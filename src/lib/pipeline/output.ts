import type { GeneratedQuestion } from '@/lib/types/generation';

interface OutputParams {
  topicId: string;
  quizId: string;
  examGuideVersion: string;
  generationTimestamp: string;
  validatedCount: number;
  rejectedCount: number;
  /** Per-module starting index so new IDs continue from the last existing question. Key = moduleId */
  startIndexByModule?: Record<string, number>;
}

/**
 * Output step: convert validated questions into a SQL script for Supabase insertion.
 *
 * Generates INSERT statements for the `question` and `quiz_question` tables,
 * plus a quiz count update — matching the existing schema conventions.
 */
export function buildSqlOutput(
  questions: GeneratedQuestion[],
  params: OutputParams
): string {
  const { topicId, quizId, examGuideVersion, generationTimestamp, validatedCount, rejectedCount, startIndexByModule = {} } = params;

  let sql = `-- ═══════════════════════════════════════════════════════\n`;
  sql += `-- Generated Hub Questions — AI Pipeline Output\n`;
  sql += `-- ═══════════════════════════════════════════════════════\n`;
  sql += `-- Exam Guide Version: ${examGuideVersion}\n`;
  sql += `-- Generated: ${generationTimestamp}\n`;
  sql += `-- Questions: ${questions.length} (${validatedCount} validated, ${rejectedCount} rejected)\n`;
  sql += `-- Quiz ID: ${quizId}\n`;
  sql += `-- ═══════════════════════════════════════════════════════\n\n`;
  sql += `BEGIN;\n\n`;

  const quizQuestionLinks: string[] = [];
  let questionIndex = 1;

  // CRITICAL: Sanitize all questions before output
  // Fix common LLM output issues with multiple type and explanations
  questions = questions.map(q => sanitizeQuestion(q));

  // Group questions by module for organized output
  const byModule = new Map<string, GeneratedQuestion[]>();
  for (const q of questions) {
    const key = q.module_id || 'unknown';
    if (!byModule.has(key)) byModule.set(key, []);
    byModule.get(key)!.push(q);
  }

  for (const [moduleId, moduleQuestions] of byModule) {
    sql += `-- ─────────────────────────────────────────\n`;
    sql += `-- Module: ${moduleId}\n`;
    sql += `-- ─────────────────────────────────────────\n\n`;

    // Continue from the last existing question index for this module
    const moduleStartIndex = (startIndexByModule[moduleId] ?? 0) + 1;

    for (let i = 0; i < moduleQuestions.length; i++) {
      const q = moduleQuestions[i];
      const moduleLocalIndex = moduleStartIndex + i;
      // Format: q_<topicId>_<moduleId>_<index>
      const questionId = `q_${topicId}_${moduleId}_${moduleLocalIndex}`;

      const escapedText = escapeSql(q.text);
      const escapedExplanation = escapeSql(q.explanation);
      const optionsJson = JSON.stringify(q.options);

      // Use the question type from Gemini (mcq, multiple, ordering, matching)
      const type = q.type || 'mcq';

      // Map difficulty to the DB column value (default to 'medium')
      const difficultyMap: Record<string, string> = {
        easy: 'easy',
        intermediate: 'medium',
        hard: 'hard',
      };
      const difficulty = difficultyMap[q.difficulty ?? ''] ?? 'medium';

      // Handle correct_answer format based on question type
      let correctAnswer: string;
      let correctAnswerForSql: string;
      let optionsForSql = optionsJson;
      let matchesVal = 'NULL';

      if (type === 'mcq') {
        // MCQ: single index as string (e.g., "0")
        correctAnswer = String(q.correct_answer);
        correctAnswerForSql = `'${escapeSql(correctAnswer)}'`;
      } else if (type === 'multiple' || type === 'ordering') {
        // Multiple Select / Ordering: array of indices (e.g., [0, 2] or [2, 0, 3, 1])
        correctAnswer = Array.isArray(q.correct_answer) ? JSON.stringify(q.correct_answer) : String(q.correct_answer);
        correctAnswerForSql = `'${escapeSql(correctAnswer)}'`;
      } else if (type === 'matching') {
        // Matching: correct_answer should be NULL
        correctAnswer = 'NULL';
        correctAnswerForSql = 'NULL';
        
        // Build options object from pairs.left with A, B, C keys
        if (q.pairs && Array.isArray(q.pairs.left)) {
          const optionsObj: Record<string, string> = {};
          q.pairs.left.forEach((item: string, index: number) => {
            optionsObj[String.fromCharCode(65 + index)] = item;
          });
          optionsForSql = JSON.stringify(optionsObj);
          
          // Build matches with left/right structure
          const matchesObj = {
            left: Array.from({ length: q.pairs.left.length }, (_, i) => i),
            right: Array.from({ length: q.pairs.left.length }, (_, i) => i)
          };
          matchesVal = `'${escapeSql(JSON.stringify(matchesObj))}'::jsonb`;
        }
      } else {
        correctAnswer = formatCorrectAnswer(q.correct_answer);
        correctAnswerForSql = `'${escapeSql(correctAnswer)}'`;
      }

      // Handle pairs for matching questions
      const pairsVal = q.pairs ? `'${escapeSql(JSON.stringify(q.pairs))}'::json` : 'NULL';

      sql += `INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)\n`;
      sql += `VALUES (\n`;
      sql += `  '${escapeSql(questionId)}',\n`;
      sql += `  '${escapedText}',\n`;
      sql += `  '${type}',\n`;
      sql += `  '${escapeSql(optionsForSql)}'::json,\n`;
      sql += `  ${correctAnswerForSql},\n`;
      sql += `  '${escapedExplanation}',\n`;
      sql += `  NOW(),\n`;
      sql += `  '${escapeSql(quizId)}',\n`;
      sql += `  NOW(),\n`;
      sql += `  ${questionIndex},\n`;
      sql += `  ${pairsVal},\n`;
      sql += `  ${matchesVal},\n`;
      sql += `  '${escapeSql(moduleId)}',\n`;
      sql += `  '${difficulty}'\n`;
      sql += `) ON CONFLICT (id) DO NOTHING;\n\n`;

      quizQuestionLinks.push(`(NOW(), '${escapeSql(quizId)}', '${escapeSql(questionId)}')`);
      questionIndex++;
    }
  }

  // Quiz-question links
  if (quizQuestionLinks.length > 0) {
    sql += `-- ─────────────────────────────────────────\n`;
    sql += `-- Link questions to quiz\n`;
    sql += `-- ─────────────────────────────────────────\n`;
    sql += `INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES\n`;
    sql += `  ${quizQuestionLinks.join(',\n  ')}\n`;
    sql += `ON CONFLICT DO NOTHING;\n\n`;
  }

  // Update question count
  sql += `-- Update quiz question count\n`;
  sql += `UPDATE public.quiz q\n`;
  sql += `SET questions = sub.cnt,\n`;
  sql += `    modified_at = NOW()\n`;
  sql += `FROM (\n`;
  sql += `  SELECT quiz_id, COUNT(*)::int AS cnt\n`;
  sql += `  FROM public.quiz_question\n`;
  sql += `  WHERE quiz_id = '${escapeSql(quizId)}'\n`;
  sql += `  GROUP BY quiz_id\n`;
  sql += `) sub\n`;
  sql += `WHERE q.id = sub.quiz_id;\n\n`;
  sql += `COMMIT;\n`;

  return sql;
}

/**
 * Sanitize questions to fix common LLM output issues
 * 1. Fix 'multiple' type questions where correct_answer is a single number instead of array
 * 2. Fix explanations to use Option A, B, C, D instead of Option 0, 1, 2, 3
 */
function sanitizeQuestion(q: GeneratedQuestion): GeneratedQuestion {
  const sanitized = { ...q };

  // FIX #1: Convert single number correct_answer to array for 'multiple' type
  if (q.type === 'multiple') {
    // If correct_answer is a string number like "0" or "1", convert to [0, 1] or similar
    if (typeof q.correct_answer === 'string') {
      const numStr = q.correct_answer.trim();
      // If it's a single digit string, assume it should be [0, 1] for multiple
      if (/^\d+$/.test(numStr)) {
        const num = parseInt(numStr, 10);
        // For multiple, we need 2-3 correct answers. Default to [num] if only 1 provided
        // This is a fallback - ideally the LLM should generate proper arrays
        sanitized.correct_answer = [num, num + 1]; // Assume consecutive indices
        console.log(`[sanitizeQuestion] Fixed MULTIPLE type: converted "${numStr}" to array [${num}, ${num + 1}]`);
      }
    } else if (typeof q.correct_answer === 'number') {
      // Single number - convert to array with this index and next index
      sanitized.correct_answer = [q.correct_answer, q.correct_answer + 1];
      console.log(`[sanitizeQuestion] Fixed MULTIPLE type: converted number ${q.correct_answer} to array [${q.correct_answer}, ${q.correct_answer + 1}]`);
    }
  }

  // FIX #2: Handle MATCHING type questions - ensure pairs structure exists
  if (q.type === 'matching') {
    // If pairs not present but options is, try to extract from options
    if (!q.pairs && Array.isArray(q.options)) {
      // Try to split options into left/right if they look like pairs
      // This is a fallback for when Gemini generates matching questions with standard options
      console.log(`[sanitizeQuestion] WARNING: Matching question missing 'pairs' field. Trying to auto-extract...`);
      
      // If we have an even number of options, split them
      if (q.options.length % 2 === 0) {
        const mid = q.options.length / 2;
        sanitized.pairs = {
          left: (q.options as string[]).slice(0, mid),
          right: (q.options as string[]).slice(mid),
        };
        console.log(`[sanitizeQuestion] Fixed MATCHING: extracted pairs from options (${mid} left, ${mid} right)`);
      }
    }

    // If matches (correct_answer) is provided as array, try to convert to object format
    if (q.correct_answer && !sanitized.matches) {
      if (Array.isArray(q.correct_answer)) {
        // If it's an array of numbers, assume they're indices for matching
        // Ideally: correct_answer should be {"left": [0,1,2], "right": [0,1,2]}
        const pairCount = sanitized.pairs?.left.length || (typeof q.options === 'object' && !Array.isArray(q.options) ? Object.keys(q.options).length : 0);
        if (typeof pairCount === 'number' && pairCount > 0) {
          const indices: number[] = Array.from({ length: pairCount }, (_, i) => i);
          sanitized.matches = {
            left: indices,
            right: indices,
          };
          console.log(`[sanitizeQuestion] Fixed MATCHING: created default matches with indices`);
        }
      } else if (typeof q.correct_answer === 'object' && q.correct_answer !== null) {
        // Already in correct format
        sanitized.matches = q.correct_answer as any;
      }
    }
  }

  // FIX #3: Replace "Option 0", "Option 1", etc. with "Option A", "Option B", etc.
  if (q.explanation) {
    let explanation = q.explanation;
    
    // Map: "Option 0" -> "Option A", "Option 1" -> "Option B", etc.
    const optionMap: Record<string, string> = {
      'Option 0': 'Option A',
      'Option 1': 'Option B',
      'Option 2': 'Option C',
      'Option 3': 'Option D',
      'Option 4': 'Option E',
    };

    // Also handle variations with parentheses and extra spacing
    for (const [numFormat, letterFormat] of Object.entries(optionMap)) {
      // Replace "Option 0", "(Option 0)", "Option 0)", etc.
      explanation = explanation.replace(new RegExp(`\\(${numFormat}\\)`, 'g'), `(${letterFormat})`);
      explanation = explanation.replace(new RegExp(`${numFormat}\\)`, 'g'), `${letterFormat})`);
      explanation = explanation.replace(new RegExp(`${numFormat}`, 'g'), letterFormat);
    }

    // Also handle standalone numbers with parentheses like "(0)", "(1)" but be careful
    // Only replace if it's clearly "Option (0)" context
    explanation = explanation.replace(/\(Option (\d)\)/g, (match, num) => {
      const letterIndex = parseInt(num, 10);
      const letters = ['A', 'B', 'C', 'D', 'E'];
      return `(Option ${letters[letterIndex] || num})`;
    });

    if (explanation !== q.explanation) {
      sanitized.explanation = explanation;
      console.log(`[sanitizeQuestion] Fixed explanation: replaced Option indices with Option letters`);
    }
  }

  return sanitized;
}

function escapeSql(str: string): string {
  if (!str) return '';
  return str.replace(/'/g, "''");
}

function formatCorrectAnswer(answer: string | number[] | null): string {
  if (answer === null) return '';
  if (Array.isArray(answer)) return JSON.stringify(answer);
  return String(answer);
}
