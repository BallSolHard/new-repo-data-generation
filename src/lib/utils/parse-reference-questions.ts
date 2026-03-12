/**
 * Parser for reference questions from index.txt files
 * Extracts questions, options, answers, and explanations
 */

import type { ReferenceQuestion } from '@/lib/types/reference-question';

export interface ParsedQuestionBlock {
  question: string;
  options: string[];
  correctAnswer: number | number[];
  correctOptions?: string[];
  explanation: string;
  type: 'mcq' | 'multiple' | 'matching' | 'ordering';
  difficulty: 'basic' | 'intermediate' | 'advanced';
  tags: string[];
}

/**
 * Parse reference questions from markdown-formatted index.txt content
 * 
 * Expected format:
 * - Question text (multiple lines possible)
 * - Blank line
 * - Options as bullet points (- text)
 * - Some options bolded (- **text**)
 * - Blank line
 * - Next question or "Explanation:" section
 */
export function parseReferenceQuestionsFromText(content: string): ParsedQuestionBlock[] {
  const questions: ParsedQuestionBlock[] = [];
  
  // Split by double newlines to get question blocks
  // This is more reliable than regex pattern matching
  const blocks = content.split(/\n\n+/);

  let i = 0;
  while (i < blocks.length) {
    const block = blocks[i].trim();
    if (!block) {
      i++;
      continue;
    }

    // Check if this block contains a question (usually starts with context or question keywords)
    // A question typically has:
    // 1. Question text (1-3 lines)
    // 2. Options (prefixed with - )
    // 3. At least one bolded option (- ** ... **)
    
    try {
      // Try to parse this block + next blocks as a question
      let questionSection = block;
      let nextIdx = i + 1;
      
      // Collect lines until we have options and explanation
      while (nextIdx < blocks.length && !hasAllParts(questionSection)) {
        questionSection += '\n\n' + blocks[nextIdx].trim();
        nextIdx++;
      }
      
      const parsed = parseQuestionSection(questionSection);
      if (parsed && parsed.question.trim().length > 20 && parsed.options.length >= 2) {
        questions.push(parsed);
        i = nextIdx;
        continue;
      }
    } catch (e) {
      // Skip malformed sections
    }
    
    i++;
  }

  return questions;
}

/**
 * Check if a section has all required parts of a question
 */
function hasAllParts(section: string): boolean {
  const hasOptions = /^- /m.test(section);
  const hasBoldedAnswer = /^- \*\*/m.test(section);
  const hasExplanation = /explanation:|hence the/i.test(section);
  
  return hasOptions && hasBoldedAnswer && hasExplanation;
}

/**
 * Parse a single question section
 */
function parseQuestionSection(section: string): ParsedQuestionBlock | null {
  const lines = section.split('\n');
  if (lines.length < 6) return null;

  // Find the question part (everything before first bullet point)
  let questionEndIdx = 0;
  for (let i = 0; i < lines.length; i++) {
    if (lines[i].trim().startsWith('- ')) {
      questionEndIdx = i;
      break;
    }
  }

  if (questionEndIdx === 0) return null;

  // Extract question text
  const questionText = lines.slice(0, questionEndIdx).join(' ').trim();
  if (!questionText || questionText.length < 20) return null;

  const options: string[] = [];
  const boldedOptions: string[] = [];
  let correctAnswerIndex = -1;
  let explanation = '';
  let inExplanation = false;

  for (let i = questionEndIdx; i < lines.length; i++) {
    const line = lines[i].trim();

    // Skip empty lines
    if (!line) {
      if (inExplanation) {
        // Empty line while in explanation means end of explanation
        break;
      }
      continue;
    }

    // Check if we're starting explanation section
    if (line.toLowerCase().includes('explanation:') || 
        line.toLowerCase().includes('hence the') ||
        line.toLowerCase().includes('answer:')) {
      inExplanation = true;
      explanation = line.replace(/^(explanation:|hence the|hence,? the correct|answer:)\s*/i, '').trim();
      continue;
    }

    // Collect explanation lines
    if (inExplanation) {
      explanation += ' ' + line;
      continue;
    }

    // Parse options (must start with dash)
    if (line.startsWith('- ')) {
      const optionContent = line.substring(2).trim();
      
      // Check if this is a bolded option (correct answer)
      if (optionContent.startsWith('**') && optionContent.includes('**')) {
        const boldedText = optionContent
          .replace(/^\*\*/, '')
          .replace(/\*\*.*$/, '')
          .trim();
        
        if (boldedText) {
          correctAnswerIndex = options.length;
          boldedOptions.push(boldedText);
          options.push(boldedText);
        }
      } 
      // Regular option
      else if (optionContent && optionContent.length > 3 && !optionContent.toLowerCase().includes('evaluation')) {
        options.push(optionContent);
      }
    }
  }

  // Clean up explanation
  explanation = explanation
    .replace(/\*\*/g, '')
    .replace(/\[ap-.*?\]/g, '')
    .trim()
    .substring(0, 500);

  // Validate the parsed question
  if (options.length < 2 || correctAnswerIndex === -1 || !explanation) {
    return null;
  }

  // Determine question type
  const type = questionText.toLowerCase().includes('select') && questionText.toLowerCase().includes('two') ? 'multiple' : 'mcq';
  
  return {
    question: questionText,
    options,
    correctAnswer: correctAnswerIndex,
    correctOptions: boldedOptions,
    explanation,
    type,
    difficulty: 'intermediate',
    tags: extractTags(questionText),
  };
}

/**
 * Extract tags from question text
 */
function extractTags(question: string): string[] {
  const tags: string[] = [];
  const lowerQ = question.toLowerCase();

  // Service-related tags
  if (lowerQ.includes('ec2')) tags.push('EC2');
  if (lowerQ.includes('s3') || lowerQ.includes('bucket')) tags.push('S3');
  if (lowerQ.includes('rds') || lowerQ.includes('database')) tags.push('RDS');
  if (lowerQ.includes('lambda') || lowerQ.includes('serverless')) tags.push('Lambda');
  if (lowerQ.includes('cloudwatch')) tags.push('CloudWatch');
  if (lowerQ.includes('iam')) tags.push('IAM');
  if (lowerQ.includes('vpc') || lowerQ.includes('network')) tags.push('VPC');
  if (lowerQ.includes('cloudformation')) tags.push('CloudFormation');
  if (lowerQ.includes('sns') || lowerQ.includes('sqs')) tags.push('Messaging');
  if (lowerQ.includes('ecs') || lowerQ.includes('container')) tags.push('Containers');

  // Concept tags
  if (lowerQ.includes('security') || lowerQ.includes('encrypt')) tags.push('Security');
  if (lowerQ.includes('cost') || lowerQ.includes('budget')) tags.push('Cost');
  if (lowerQ.includes('availability') || lowerQ.includes('resilience')) tags.push('Reliability');
  if (lowerQ.includes('performance') || lowerQ.includes('latency')) tags.push('Performance');
  if (lowerQ.includes('migration') || lowerQ.includes('migrate')) tags.push('Migration');
  if (lowerQ.includes('monitoring') || lowerQ.includes('logging')) tags.push('Monitoring');

  return [...new Set(tags)]; // Remove duplicates
}

/**
 * Convert parsed question blocks to ReferenceQuestion format
 */
export function convertToReferenceQuestions(
  blocks: ParsedQuestionBlock[],
  certCode: string,
  domainId: string
): ReferenceQuestion[] {
  return blocks.map((block, index) => {
    // Convert correctAnswer to proper format
    let correctAnswer: string | number[] | null = null;
    if (block.type === 'mcq') {
      // For MCQ, store as array format for consistency
      correctAnswer = [block.correctAnswer as number];
    } else if (block.type === 'multiple') {
      // For multiple, already array format
      correctAnswer = Array.isArray(block.correctAnswer) 
        ? block.correctAnswer 
        : [block.correctAnswer as number];
    }
    
    return {
      id: `${certCode}-${domainId}-ref-${index}`,
      certificationCode: certCode,
      text: block.question,
      type: block.type,
      options: block.options,
      correctAnswer,
      explanation: block.explanation,
      difficulty: block.difficulty,
      domainId,
      tags: block.tags,
      source: 'custom' as const,
    };
  });
}

/**
 * Select N random reference questions from a list
 * Ensures variety in types and difficulty
 */
export function selectRandomQuestions(
  questions: ParsedQuestionBlock[],
  count: number = 5
): ParsedQuestionBlock[] {
  if (questions.length <= count) return questions;

  const selected: ParsedQuestionBlock[] = [];
  const shuffled = [...questions].sort(() => Math.random() - 0.5);

  // Try to get diverse types
  const types = new Set<string>();
  for (const q of shuffled) {
    if (selected.length >= count) break;
    
    // Prefer questions of new types
    if (!types.has(q.type) || selected.length < count - 1) {
      selected.push(q);
      types.add(q.type);
    }
  }

  // Fill remaining slots
  for (const q of shuffled) {
    if (selected.length >= count) break;
    if (!selected.find(s => s.question === q.question)) {
      selected.push(q);
    }
  }

  return selected.slice(0, count);
}
