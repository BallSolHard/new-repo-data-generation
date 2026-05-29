// ─── Kimi API Configuration ───

const KIMI_API_KEY = process.env.KIMI_API_KEY || '';
// Using the correct OpenAI-compatible endpoint (same as validation.py)
const KIMI_BASE_URL = 'https://api.moonshot.ai/v1';
// Updated to use the OpenAI-compatible endpoint model name
const KIMI_MODEL = 'kimi-k2.6';

// ─── Generation Model Config ───
// Note: Kimi K2.6 requires temperature=1 and top_p=0.95 (fixed values)
const GENERATION_CONFIG = {
  temperature: 1,
  top_p: 0.95,
  max_tokens: 16384,
};

// ─── Validation Model Config ───
// Note: Kimi K2.6 requires temperature=1 and top_p=0.95 (fixed values)
const VALIDATION_CONFIG = {
  temperature: 1,
  top_p: 0.95,
  max_tokens: 4096,
};

export interface KimiModel {
  name: 'kimi';
  config: {
    temperature: number;
    top_p: number;
    max_tokens: number;
    web_search?: boolean;
  };
}

/**
 * Generation model: Kimi with controlled creativity and web search enabled.
 */
export function getGenerationModel(enableWebSearch: boolean = true): KimiModel {
  return {
    name: 'kimi',
    config: { ...GENERATION_CONFIG, web_search: enableWebSearch },
  };
}

/**
 * Validation model: Kimi with stricter settings for fact-checking.
 */
export function getValidationModel(enableWebSearch: boolean = false): KimiModel {
  return {
    name: 'kimi',
    config: { ...VALIDATION_CONFIG, web_search: enableWebSearch },
  };
}

/**
 * Generate content using Kimi API via REST.
 * This uses the same REST API approach as the working validation.py script.
 */
export async function generateContent(prompt: string, model: KimiModel): Promise<string> {
  if (!KIMI_API_KEY) {
    throw new Error('KIMI_API_KEY not configured');
  }

  try {
    console.log(`[kimi] Attempting to connect to ${KIMI_BASE_URL}/chat/completions`);
    console.log(`[kimi] Model: ${KIMI_MODEL}`);
    console.log(`[kimi] Temperature: ${model.config.temperature}, top_p: ${model.config.top_p}`);
    
    const response = await fetch(`${KIMI_BASE_URL}/chat/completions`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${KIMI_API_KEY}`,
      },
      body: JSON.stringify({
        model: KIMI_MODEL,
        messages: [
          {
            role: 'user',
            content: prompt,
          },
        ],
        temperature: model.config.temperature,
        top_p: model.config.top_p,
        max_tokens: model.config.max_tokens,
        ...(model.config.web_search !== undefined && { web_search: model.config.web_search }),
      }),
    });

    console.log(`[kimi] Response status: ${response.status}`);

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      console.error('[kimi] API error response:', errorData);
      
      // Handle authentication errors
      if (response.status === 401) {
        throw new Error(`Kimi Authentication Failed: Invalid API key. Please verify KIMI_API_KEY is correct.`);
      }
      
      // Handle rate limiting
      if (response.status === 429) {
        throw new Error(`Kimi Rate Limited: Too many requests. Please try again later.`);
      }
      
      // Handle timeout
      if (response.status === 408) {
        throw new Error(`Kimi API Request Timeout: Request took too long.`);
      }
      
      throw new Error(`Kimi API error: ${response.status} ${response.statusText} - ${JSON.stringify(errorData)}`);
    }

    const data = await response.json();

    if (!data.choices || data.choices.length === 0) {
      throw new Error('No content generated from Kimi API');
    }

    console.log(`[kimi] Successfully generated content (${data.choices[0].message.content.length} chars)`);
    return data.choices[0].message.content || '';
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : String(error);
    console.error('[kimi] Generation error:', errorMessage);
    console.error('[kimi] Full error:', error);
    throw new Error(`Kimi API error: ${errorMessage}`);
  }
}

/**
 * Parse a JSON response from Kimi, handling common edge cases:
 * - Markdown code fences (```json ... ```)
 * - Leading/trailing whitespace
 * - Partial JSON (extract first valid array)
 * - Malformed JSON with missing brackets or commas
 */
export function parseKimiJson<T>(text: string): T {
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
          console.warn('[parseKimiJson] Could not fix array JSON, trying object extraction');
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
        console.warn(`[parseKimiJson] Recovered ${validObjects.length} valid objects from malformed response`);
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
      `Failed to parse Kimi response as JSON. Original error: ${primaryError instanceof Error ? primaryError.message : String(primaryError)}. ` +
      `Response preview: ${cleaned.slice(0, 300)}...`
    );
  }
}
