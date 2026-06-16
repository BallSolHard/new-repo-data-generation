// Mock Test SQL Generator - Node.js Template
// Use this in your generation pipeline to ensure proper SQL output

export interface MockTestQuestion {
  mock_test_id: string;
  question_text: string;
  options: string[];
  question_type: 'mcq' | 'ordering' | 'matching' | 'pairing';
  correct_answer: number[];
  explanation: string;
  topic_id: number;
  module_id: string;
  question_order: number;
  pairs?: Record<string, string> | null;
  matches?: Record<string, string> | null;
}

export interface MockTest {
  id: string;
  topic_id: number;
  title: string;
  questions: MockTestQuestion[];
  difficulty_distribution?: Record<string, number>;
}

export function validateMockTestQuestions(questions: MockTestQuestion[]): {
  valid: boolean;
  errors: string[];
} {
  const errors: string[] = [];

  questions.forEach((q, index) => {
    const qNum = index + 1;

    // Check required fields
    if (!q.question_text?.trim()) {
      errors.push(`Question ${qNum}: Missing or empty question_text`);
    }

    if (!q.options || q.options.length === 0) {
      errors.push(`Question ${qNum}: Missing or empty options`);
    }

    if (!q.question_type) {
      errors.push(`Question ${qNum}: Missing question_type`);
    }

    if (!q.correct_answer || q.correct_answer.length === 0) {
      errors.push(`Question ${qNum}: Missing or empty correct_answer`);
    }

    if (!q.explanation?.trim()) {
      errors.push(`Question ${qNum}: Missing or empty explanation`);
    }

    // Check module_id is not undefined
    if (!q.module_id || q.module_id === 'undefined') {
      errors.push(`Question ${qNum}: module_id is 'undefined' or missing`);
    }

    // Validate module_id format (m_X_Y)
    if (q.module_id && !q.module_id.match(/^m_\d+_\d+$/)) {
      errors.push(
        `Question ${qNum}: Invalid module_id format '${q.module_id}'. Expected format: m_<topic>_<section>`
      );
    }

    // Validate correct_answer indices are within options range
    const maxIndex = q.options.length - 1;
    for (const idx of q.correct_answer) {
      if (idx < 0 || idx > maxIndex) {
        errors.push(
          `Question ${qNum}: correct_answer index ${idx} out of range (0-${maxIndex})`
        );
      }
    }
  });

  return {
    valid: errors.length === 0,
    errors,
  };
}

export function ensureModuleId(
  question: MockTestQuestion,
  topicId: number,
  questionOrder: number
): string {
  // If module_id is already valid, keep it
  if (question.module_id && question.module_id !== 'undefined') {
    if (question.module_id.match(/^m_\d+_\d+$/)) {
      return question.module_id;
    }
  }

  // Infer from question order
  let section: number;
  if (questionOrder <= 3) {
    section = 1;
  } else if (questionOrder <= 6) {
    section = 2;
  } else if (questionOrder <= 10) {
    section = 3;
  } else if (questionOrder <= 15) {
    section = 4;
  } else {
    section = 5;
  }

  return `m_${topicId}_${section}`;
}

export function escapeSqlString(str: string): string {
  return str.replace(/'/g, "''");
}

export function generateMockTestSql(mockTest: MockTest): string {
  const timestamp = new Date().toISOString();
  const questionCount = mockTest.questions.length;

  // Validate questions
  const validation = validateMockTestQuestions(mockTest.questions);
  if (!validation.valid) {
    console.error('Mock Test Validation Errors:', validation.errors);
    throw new Error(
      `Invalid mock test questions: ${validation.errors.join('; ')}`
    );
  }

  // Fix module_ids and question_order
  const fixedQuestions = mockTest.questions.map((q, i) => ({
    ...q,
    module_id: ensureModuleId(q, mockTest.topic_id, i + 1),
    question_order: i + 1,
  }));

  // Generate SQL
  const sqlParts: string[] = [];

  // Header comments
  sqlParts.push('-- ═══════════════════════════════════════════════════════');
  sqlParts.push('-- Generated Mock Test Questions — AI Pipeline Output');
  sqlParts.push('-- ═══════════════════════════════════════════════════════');
  sqlParts.push(`-- Mock Test ID: ${mockTest.id}`);
  sqlParts.push(`-- Topic ID: ${mockTest.topic_id}`);
  sqlParts.push(`-- Questions: ${questionCount}`);
  sqlParts.push(`-- Generated: ${timestamp}`);
  sqlParts.push('-- ═══════════════════════════════════════════════════════');
  sqlParts.push('');
  sqlParts.push('BEGIN;');
  sqlParts.push('');

  // Create mock_tests record (REQUIRED - Fixed schema)
  sqlParts.push('-- ─────────────────────────────────────────');
  sqlParts.push('-- Create Mock Test Record');
  sqlParts.push('-- ─────────────────────────────────────────');
  sqlParts.push('');
  sqlParts.push('INSERT INTO public.mock_tests (');
  sqlParts.push('  id,');
  sqlParts.push('  certification_id,');
  sqlParts.push('  title,');
  sqlParts.push('  total_questions,');
  sqlParts.push('  description,');
  sqlParts.push('  created_at');
  sqlParts.push(')');
  sqlParts.push('VALUES (');
  sqlParts.push(`  '${mockTest.id}',`);
  sqlParts.push(`  ${mockTest.topic_id},`);
  sqlParts.push(
    `  '${mockTest.title || `Mock Test - Topic ${mockTest.topic_id}`}',`
  );
  sqlParts.push('  0,');
  sqlParts.push(
    `  'Mock test for Topic ${mockTest.topic_id}',`
  );
  sqlParts.push('  NOW()');
  sqlParts.push(')');
  sqlParts.push('ON CONFLICT (id) DO NOTHING;');
  sqlParts.push('');

  // Add questions (grouped by module)
  const questionsByModule = groupQuestionsByModule(fixedQuestions);
  for (const [moduleId, moduleQuestions] of Object.entries(questionsByModule)) {
    sqlParts.push('-- ─────────────────────────────────────────');
    sqlParts.push(`-- Module: ${moduleId}`);
    sqlParts.push('-- ─────────────────────────────────────────');
    sqlParts.push('');
    sqlParts.push('INSERT INTO public.mock_test_questions (');
    sqlParts.push('  mock_test_id,');
    sqlParts.push('  question_text,');
    sqlParts.push('  options,');
    sqlParts.push('  question_type,');
    sqlParts.push('  correct_answer,');
    sqlParts.push('  explanation,');
    sqlParts.push('  topic_id,');
    sqlParts.push('  module_id,');
    sqlParts.push('  question_order,');
    sqlParts.push('  pairs,');
    sqlParts.push('  matches');
    sqlParts.push(')');
    sqlParts.push('VALUES');

    moduleQuestions.forEach((q, i) => {
      const questionText = escapeSqlString(q.question_text);
      const optionsJson = JSON.stringify(q.options);
      const correctAnswerJson = JSON.stringify(q.correct_answer);
      const explanation = escapeSqlString(q.explanation);

      const row = [
        `  ('${mockTest.id}',`,
        `   '${questionText}',`,
        `   '${optionsJson}'::jsonb,`,
        `   '${q.question_type}',`,
        `   '${correctAnswerJson}'::integer[],`,
        `   '${explanation}',`,
        `   ${mockTest.topic_id},`,
        `   '${q.module_id}',`,
        `   ${q.question_order},`,
        `   NULL,`,
        `   NULL)`,
      ].join('\n');

      sqlParts.push(row + (i < moduleQuestions.length - 1 ? ',' : ''));
    });

    sqlParts.push('ON CONFLICT DO NOTHING;');
    sqlParts.push('');
  }

  // Update mock test with question count
  sqlParts.push('-- ─────────────────────────────────────────');
  sqlParts.push('-- Update Mock Test with Final Count');
  sqlParts.push('-- ─────────────────────────────────────────');
  sqlParts.push('');
  sqlParts.push('UPDATE public.mock_tests');
  sqlParts.push('SET total_questions = (');
  sqlParts.push('  SELECT COUNT(*)');
  sqlParts.push('  FROM public.mock_test_questions');
  sqlParts.push(`  WHERE mock_test_id = '${mockTest.id}'`);
  sqlParts.push(')');
  sqlParts.push(`WHERE id = '${mockTest.id}';`);
  sqlParts.push('');
  sqlParts.push('COMMIT;');

  return sqlParts.join('\n');
}

function calculateDifficultyDistribution(
  questions: MockTestQuestion[]
): Record<string, number> {
  // If difficulty info is available in questions, use it
  // Otherwise return default distribution
  // This would need to be extended based on your data structure
  const distribution = {
    easy: Math.floor(questions.length * 0.4),
    medium: Math.floor(questions.length * 0.35),
    hard: Math.floor(questions.length * 0.25),
  };

  return distribution;
}

function groupQuestionsByModule(
  questions: MockTestQuestion[]
): Record<string, MockTestQuestion[]> {
  const grouped: Record<string, MockTestQuestion[]> = {};

  questions.forEach((q) => {
    if (!grouped[q.module_id]) {
      grouped[q.module_id] = [];
    }
    grouped[q.module_id].push(q);
  });

  return grouped;
}

// Usage Example:
// import { generateMockTestSql } from './mock-test-sql-generator';
//
// const mockTest: MockTest = {
//   id: 'mock_5_all_1774916815746',
//   topic_id: 5,
//   title: 'ML Practitioner - Full Mock Test',
//   questions: [
//     {
//       mock_test_id: 'mock_5_all_1774916815746',
//       question_text: 'What is supervised learning?',
//       options: ['Learning with labels', 'Learning without labels', 'Other', 'None'],
//       question_type: 'mcq',
//       correct_answer: [0],
//       explanation: 'Supervised learning requires labeled data...',
//       topic_id: 5,
//       module_id: 'undefined', // Will be fixed to 'm_5_1'
//       question_order: 1,
//     },
//     // ... more questions
//   ],
// };
//
// try {
//   const sql = generateMockTestSql(mockTest);
//   console.log(sql);
// } catch (error) {
//   console.error('Failed to generate SQL:', error.message);
// }
