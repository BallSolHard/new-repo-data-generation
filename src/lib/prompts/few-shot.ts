import type { ReferenceQuestion } from '@/lib/types/reference-question';

/**
 * Build the few-shot examples section for prompt injection.
 * Reference questions calibrate the LLM's output on style, difficulty,
 * option phrasing, and explanation depth.
 */
export function buildFewShotSection(examples: ReferenceQuestion[]): string {
  if (!examples.length) return '';

  const formatted = examples.map((ex, i) => {
    const answerStr = Array.isArray(ex.correctAnswer)
      ? JSON.stringify(ex.correctAnswer)
      : ex.correctAnswer;

    return `--- Example ${i + 1} (${ex.type.toUpperCase()}, ${ex.difficulty}) ---
Question: ${ex.text}
Options: ${JSON.stringify(ex.options, null, 2)}
Correct Answer: ${answerStr}
Explanation: ${ex.explanation}
Tags: ${ex.tags?.join(', ') || 'N/A'}`;
  }).join('\n\n');

  return `
═══════════════════════════════════════════════════════
REFERENCE EXAMPLES — Match this quality, style, and depth
═══════════════════════════════════════════════════════

${formatted}

CRITICAL INSTRUCTIONS FOR USING THESE EXAMPLES:
1. Match the STYLE: scenario-based questions with real business context
2. Match the DEPTH: explanations that justify the correct answer AND explain why each wrong answer is wrong
3. Match the PRECISION: use exact AWS service names and correct technical behavior
4. DO NOT copy or paraphrase these questions — generate ENTIRELY NEW questions
5. Each of your options should be a plausible answer that a professional might consider
═══════════════════════════════════════════════════════
`;
}
