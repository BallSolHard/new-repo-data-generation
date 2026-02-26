import { GoogleGenerativeAI } from '@google/generative-ai';

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');

// ─── V1 Model Configs (default, unchanged) ───

const V1_GENERATION_CONFIG = {
  temperature: 0.9,
  topP: 0.8,
  topK: 40,
  maxOutputTokens: 16384, // Doubled to prevent truncation
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
  maxOutputTokens: 16384, // Doubled to prevent truncation
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
 * - Malformed JSON with missing brackets or commas
 */
export function parseGeminiJson<T>(text: string): T {
  let cleaned = text.trim();

  // Strip markdown code fences
  if (cleaned.startsWith('```')) {
    cleaned = cleaned.replace(/^```(?:json)?\s*\n?/, '').replace(/\n?```\s*$/, '');
  }

  try {
    return JSON.parse(cleaned);
  } catch (primaryError) {
    // attempt simple quote fix for unterminated string errors
    if (/Unterminated string/.test(String(primaryError))) {
      // add closing quote at end if missing
      if (cleaned.trim().endsWith('"')) {
        // already ends with quote, leave it
      } else {
        cleaned += '"';
      }
      try {
        return JSON.parse(cleaned);
      } catch {
        // fall through to other strategies
      }
    }
    // Strategy 1: Try to extract and fix a JSON array
    const arrayMatch = cleaned.match(/\[[\s\S]*\]/);
    if (arrayMatch) {
      try {
        return JSON.parse(arrayMatch[0]);
      } catch (arrayError) {
        // Try to fix incomplete array
        let fixedArray = arrayMatch[0];
        
        // Add missing closing bracket if needed
        const openBrackets = (fixedArray.match(/\{/g) || []).length;
        const closeBrackets = (fixedArray.match(/\}/g) || []).length;
        if (openBrackets > closeBrackets) {
          fixedArray += '}';
        }
        
        // Try again with fixed version
        try {
          return JSON.parse(fixedArray);
        } catch (fixedArrayError) {
          console.warn('[parseGeminiJson] Could not fix array JSON, trying object extraction');
        }
      }
    }

    // Strategy 2: Try to extract individual objects
    const objectMatches = cleaned.match(/\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}/g);
    if (objectMatches && objectMatches.length > 0) {
      const validObjects: any[] = [];
      
      for (const match of objectMatches) {
        try {
          const obj = JSON.parse(match);
          // Validate it looks like a question
          if (obj.text && obj.options && obj.correct_answer !== undefined) {
            validObjects.push(obj);
          }
        } catch (objError) {
          // Continue to next match
        }
      }
      
      if (validObjects.length > 0) {
        console.warn(`[parseGeminiJson] Recovered ${validObjects.length} valid objects from malformed response`);
        return validObjects as unknown as T;
      }
    }

    // Strategy 3: Try to extract just a single JSON object
    const singleObjectMatch = cleaned.match(/\{[\s\S]*\}/);
    if (singleObjectMatch) {
      try {
        const obj = JSON.parse(singleObjectMatch[0]);
        // Return as array if it looks like a single question
        if (obj.text && obj.options && obj.correct_answer !== undefined) {
          return [obj] as unknown as T;
        }
      } catch (singleError) {
        // Continue
      }
    }

    // If all extraction fails, provide detailed error
    throw new Error(
      `Failed to parse Gemini response as JSON. Original error: ${primaryError instanceof Error ? primaryError.message : String(primaryError)}. ` +
      `Response preview: ${cleaned.slice(0, 300)}...`
    );
  }
}
