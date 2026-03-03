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

      // Auto-detect 'multiple' type when there are multiple correct answers
      const isMultipleAnswer = Array.isArray(q.correct_answer) && q.correct_answer.length > 1;
      const type = isMultipleAnswer ? 'multiple' : (q.type || 'mcq');

      // Map difficulty to the DB column value (default to 'medium')
      const difficultyMap: Record<string, string> = {
        easy: 'easy',
        intermediate: 'medium',
        hard: 'hard',
      };
      const difficulty = difficultyMap[q.difficulty ?? ''] ?? 'medium';

      // Handle correct_answer format
      const correctAnswer = formatCorrectAnswer(q.correct_answer);

      // Handle pairs and matches for matching questions
      const pairsVal = q.pairs ? `'${escapeSql(JSON.stringify(q.pairs))}'::json` : 'NULL';
      const matchesVal = q.matches ? `'${escapeSql(JSON.stringify(q.matches))}'::json` : 'NULL';

      sql += `INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)\n`;
      sql += `VALUES (\n`;
      sql += `  '${escapeSql(questionId)}',\n`;
      sql += `  '${escapedText}',\n`;
      sql += `  '${type}',\n`;
      sql += `  '${escapeSql(optionsJson)}'::json,\n`;
      sql += `  '${escapeSql(correctAnswer)}',\n`;
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

function escapeSql(str: string): string {
  if (!str) return '';
  return str.replace(/'/g, "''");
}

function formatCorrectAnswer(answer: string | number[] | null): string {
  if (answer === null) return '';
  if (Array.isArray(answer)) return JSON.stringify(answer);
  return String(answer);
}
