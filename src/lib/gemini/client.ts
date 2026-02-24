import { GoogleGenerativeAI } from '@google/generative-ai';

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');

// ─── V1 Model Configs (default, unchanged) ───

const V1_GENERATION_CONFIG = {
  temperature: 0.9,
  topP: 0.8,
  topK: 40,
  maxOutputTokens: 8192,
};

const V1_VALIDATION_CONFIG = {
  temperature: 0.3,
  topP: 0.6,
  topK: 20,
  maxOutputTokens: 2048,
};

// ─── V2 Model Configs (tier-aware, lower temperature) ───

const V2_GENERATION_CONFIG = {
  temperature: 0.45,
  topP: 0.8,
  topK: 40,
  maxOutputTokens: 8192,
};

const V2_VALIDATION_CONFIG = {
  temperature: 0.15,
  topP: 0.6,
  topK: 20,
  maxOutputTokens: 4096,
};

/**
 * Generation model.
 * V1 (default): gemini-2.5-flash, temp 0.9 — high creativity for diverse output.
 * V2 (v2=true): gemini-2.5-flash, temp 0.45 — controlled creativity, fewer hallucinations.
 */
export function getGenerationModel(v2?: boolean) {
  return genAI.getGenerativeModel({
    model: 'gemini-2.5-flash',
    generationConfig: v2 ? V2_GENERATION_CONFIG : V1_GENERATION_CONFIG,
  });
}

/**
 * Validation model.
 * V1 (default): gemini-2.5-flash, temp 0.3 — conservative factual checking.
 * V2 (v2=true): gemini-2.5-pro, temp 0.15 — higher reasoning, stricter fact-checking.
 */
export function getValidationModel(v2?: boolean) {
  return genAI.getGenerativeModel({
    model: v2 ? 'gemini-2.5-pro' : 'gemini-2.5-flash',
    generationConfig: v2 ? V2_VALIDATION_CONFIG : V1_VALIDATION_CONFIG,
  });
}

/**
 * Parse a JSON response from Gemini, handling common edge cases:
 * - Markdown code fences (```json ... ```)
 * - Leading/trailing whitespace
 * - Partial JSON (extract first valid array)
 */
export function parseGeminiJson<T>(text: string): T {
  let cleaned = text.trim();

  // Strip markdown code fences
  if (cleaned.startsWith('```')) {
    cleaned = cleaned.replace(/^```(?:json)?\s*\n?/, '').replace(/\n?```\s*$/, '');
  }

  try {
    return JSON.parse(cleaned);
  } catch {
    // Try to extract a JSON array
    const arrayMatch = cleaned.match(/\[[\s\S]*\]/);
    if (arrayMatch) {
      return JSON.parse(arrayMatch[0]);
    }

    // Try to extract a JSON object
    const objectMatch = cleaned.match(/\{[\s\S]*\}/);
    if (objectMatch) {
      return JSON.parse(objectMatch[0]);
    }

    throw new Error(`Failed to parse Gemini response as JSON: ${cleaned.slice(0, 200)}...`);
  }
}
