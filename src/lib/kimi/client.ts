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
    // ─── STEP 1: Prepare Request ───
    console.log(`\n[kimi] ════════════════════════════════════════════════════════`);
    console.log(`[kimi] STEP 1: Preparing Kimi API Request`);
    console.log(`[kimi] ════════════════════════════════════════════════════════`);
    console.log(`[kimi] Endpoint: ${KIMI_BASE_URL}/chat/completions`);
    console.log(`[kimi] Model: ${KIMI_MODEL}`);
    console.log(`[kimi] Temperature: ${model.config.temperature} (fixed for Kimi K2.6)`);
    console.log(`[kimi] Top_p: ${model.config.top_p} (fixed for Kimi K2.6)`);
    console.log(`[kimi] Max Tokens: ${model.config.max_tokens}`);
    console.log(`[kimi] Web Search: ${model.config.web_search ? '✅ ENABLED' : '❌ DISABLED'}`);
    console.log(`[kimi] Prompt Length: ${prompt.length} characters`);
    console.log(`[kimi] ────────────────────────────────────────────────────────`);
    
    // ─── STEP 2: Send Request ───
    console.log(`[kimi] STEP 2: Sending Request to Kimi API...`);
    const startTime = Date.now();
    
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

    const elapsedTime = Date.now() - startTime;
    
    // ─── STEP 3: Check Response Status ───
    console.log(`[kimi] STEP 3: Checking Response Status`);
    console.log(`[kimi] Response Status: ${response.status} ${response.statusText}`);
    console.log(`[kimi] Response Time: ${elapsedTime}ms`);
    console.log(`[kimi] ────────────────────────────────────────────────────────`);

    if (!response.ok) {
      console.error(`[kimi] ❌ STEP 3 FAILED: HTTP Error`);
      const errorData = await response.json().catch(() => ({}));
      console.error('[kimi] Error Response:', errorData);
      
      // Handle authentication errors
      if (response.status === 401) {
        console.error('[kimi] ❌ Authentication Error: Invalid API key');
        throw new Error(`Kimi Authentication Failed: Invalid API key. Please verify KIMI_API_KEY is correct.`);
      }
      
      // Handle rate limiting
      if (response.status === 429) {
        console.error('[kimi] ❌ Rate Limit Error: Too many requests');
        throw new Error(`Kimi Rate Limited: Too many requests. Please try again later.`);
      }
      
      // Handle timeout
      if (response.status === 408) {
        console.error('[kimi] ❌ Timeout Error: Request took too long');
        throw new Error(`Kimi API Request Timeout: Request took too long.`);
      }
      
      throw new Error(`Kimi API error: ${response.status} ${response.statusText} - ${JSON.stringify(errorData)}`);
    }

    // ─── STEP 4: Parse Response ───
    console.log(`[kimi] STEP 4: Parsing Response JSON`);
    const data = await response.json();

    if (!data.choices || data.choices.length === 0) {
      console.error('[kimi] ❌ STEP 4 FAILED: No choices in response');
      throw new Error('No content generated from Kimi API');
    }

    const contentLength = data.choices[0].message.content.length;
    console.log(`[kimi] ✅ Successfully parsed response`);
    console.log(`[kimi] Content Length: ${contentLength} characters`);
    console.log(`[kimi] ────────────────────────────────────────────────────────`);

    // ─── STEP 5: Extracting Content ───
    console.log(`[kimi] STEP 5: Extracting Content`);
    const content = data.choices[0].message.content || '';
    console.log(`[kimi] ✅ Content extracted successfully`);
    console.log(`[kimi] First 200 chars: ${content.slice(0, 200)}...`);
    console.log(`[kimi] ════════════════════════════════════════════════════════\n`);
    
    return content;
  } catch (error) {
    console.log(`\n[kimi] ════════════════════════════════════════════════════════`);
    console.error('[kimi] ❌ ERROR OCCURRED DURING GENERATION');
    const errorMessage = error instanceof Error ? error.message : String(error);
    console.error('[kimi] Error Message:', errorMessage);
    console.error('[kimi] Full Error:', error);
    console.log(`[kimi] ════════════════════════════════════════════════════════\n`);
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
  console.log(`\n[kimi-parser] ════════════════════════════════════════════════════════`);
  console.log(`[kimi-parser] STEP 6: Parsing Kimi JSON Response`);
  console.log(`[kimi-parser] ════════════════════════════════════════════════════════`);
  console.log(`[kimi-parser] Raw Response Length: ${text.length} characters`);
  console.log(`[kimi-parser] First 300 chars: ${text.slice(0, 300)}`);
  console.log(`[kimi-parser] ────────────────────────────────────────────────────────`);

  let cleaned = text.trim();
  
  console.log(`[kimi-parser] STEP 6.1: Cleaning Response`);
  console.log(`[kimi-parser] After trim: ${cleaned.length} characters`);

  // Strip markdown code fences
  if (cleaned.startsWith('```')) {
    console.log(`[kimi-parser] Detected markdown code fences, stripping...`);
    cleaned = cleaned.replace(/^```(?:json)?\s*\n?/, '').replace(/\n?```\s*$/, '');
    console.log(`[kimi-parser] After stripping fences: ${cleaned.length} characters`);
  }

  // ─── STEP 6.2: Try Direct Parse ───
  console.log(`[kimi-parser] STEP 6.2: Attempting Direct JSON Parse`);
  try {
    const result = JSON.parse(cleaned);
    console.log(`[kimi-parser] ✅ Direct parse successful!`);
    console.log(`[kimi-parser] Parsed ${Array.isArray(result) ? result.length + ' items' : 'object'}`);
    console.log(`[kimi-parser] ════════════════════════════════════════════════════════\n`);
    return result;
  } catch (primaryError) {
    console.warn(`[kimi-parser] ❌ Direct parse failed: ${primaryError}`);
    console.log(`[kimi-parser] ────────────────────────────────────────────────────────`);

    // ─── STEP 6.3: Try Quote Fix ───
    console.log(`[kimi-parser] STEP 6.3: Attempting Quote Fix`);
    if (/Unterminated string/.test(String(primaryError))) {
      if (cleaned.trim().endsWith('"')) {
        console.log(`[kimi-parser] String already ends with quote, skipping`);
      } else {
        console.log(`[kimi-parser] Adding closing quote...`);
        cleaned += '"';
      }
      try {
        const result = JSON.parse(cleaned);
        console.log(`[kimi-parser] ✅ Quote fix successful!`);
        console.log(`[kimi-parser] ════════════════════════════════════════════════════════\n`);
        return result;
      } catch (quoteError) {
        console.warn(`[kimi-parser] ❌ Quote fix failed: ${quoteError}`);
        console.log(`[kimi-parser] ────────────────────────────────────────────────────────`);
      }
    }

    // ─── STEP 6.4: Extract Array Strategy ───
    console.log(`[kimi-parser] STEP 6.4: Attempting Array Extraction`);
    const arrayMatch = cleaned.match(/\[[\s\S]*\]/);
    if (arrayMatch) {
      console.log(`[kimi-parser] Found array pattern, trying to parse...`);
      try {
        const result = JSON.parse(arrayMatch[0]);
        console.log(`[kimi-parser] ✅ Array extraction successful! Found ${result.length} items`);
        console.log(`[kimi-parser] ════════════════════════════════════════════════════════\n`);
        return result;
      } catch (arrayError) {
        console.warn(`[kimi-parser] ❌ Array parse failed: ${arrayError}`);
        
        // Try to fix incomplete array
        console.log(`[kimi-parser] STEP 6.4.1: Attempting Array Fix (missing brackets)`);
        let fixedArray = arrayMatch[0];

        // Add missing closing bracket if needed
        const openBrackets = (fixedArray.match(/\{/g) || []).length;
        const closeBrackets = (fixedArray.match(/\}/g) || []).length;
        console.log(`[kimi-parser] Open brackets: ${openBrackets}, Close brackets: ${closeBrackets}`);
        
        if (openBrackets > closeBrackets) {
          console.log(`[kimi-parser] Adding missing closing bracket...`);
          fixedArray += '}';
        }

        // Try again with fixed version
        try {
          const result = JSON.parse(fixedArray);
          console.log(`[kimi-parser] ✅ Fixed array parse successful!`);
          console.log(`[kimi-parser] ════════════════════════════════════════════════════════\n`);
          return result;
        } catch (fixedArrayError) {
          console.warn(`[kimi-parser] ❌ Fixed array parse failed: ${fixedArrayError}`);
          console.log(`[kimi-parser] ────────────────────────────────────────────────────────`);
        }
      }
    } else {
      console.log(`[kimi-parser] ⓘ No array pattern found in response`);
    }

    // ─── STEP 6.5: Extract Objects Strategy ───
    console.log(`[kimi-parser] STEP 6.5: Attempting Object Extraction`);
    const objectMatches = cleaned.match(/\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}/g);
    if (objectMatches && objectMatches.length > 0) {
      console.log(`[kimi-parser] Found ${objectMatches.length} object patterns, filtering valid ones...`);
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
        console.log(`[kimi-parser] ✅ Successfully extracted ${validObjects.length} valid objects!`);
        console.log(`[kimi-parser] ════════════════════════════════════════════════════════\n`);
        return validObjects as unknown as T;
      } else {
        console.warn(`[kimi-parser] ❌ Found ${objectMatches.length} patterns but none were valid questions`);
        console.log(`[kimi-parser] ────────────────────────────────────────────────────────`);
      }
    } else {
      console.log(`[kimi-parser] ⓘ No object patterns found in response`);
    }

    // ─── STEP 6.6: Single Object Extraction ───
    console.log(`[kimi-parser] STEP 6.6: Attempting Single Object Extraction`);
    const singleObjectMatch = cleaned.match(/\{[\s\S]*\}/);
    if (singleObjectMatch) {
      try {
        console.log(`[kimi-parser] Found single object, attempting to parse...`);
        const obj = JSON.parse(singleObjectMatch[0]);
        // Return as array if it looks like a single question
        if (obj.text && obj.options && obj.correct_answer !== undefined) {
          console.log(`[kimi-parser] ✅ Single object looks like a question!`);
          console.log(`[kimi-parser] ════════════════════════════════════════════════════════\n`);
          return [obj] as unknown as T;
        } else {
          console.log(`[kimi-parser] ⓘ Object parsed but doesn't look like a question`);
        }
      } catch (singleError) {
        console.warn(`[kimi-parser] ❌ Single object parse failed: ${singleError}`);
      }
    } else {
      console.log(`[kimi-parser] ⓘ No single object pattern found`);
    }

    // ─── STEP 6.7: All Strategies Failed ───
    console.log(`[kimi-parser] ════════════════════════════════════════════════════════`);
    console.log(`[kimi-parser] ❌ PARSING FAILED: All strategies exhausted`);
    console.error(`[kimi-parser] Could not parse Kimi response as JSON`);
    console.error(`[kimi-parser] Response preview: ${cleaned.slice(0, 500)}`);
    console.log(`[kimi-parser] ════════════════════════════════════════════════════════\n`);
    
    // If all extraction fails, provide detailed error
    throw new Error(
      `Failed to parse Kimi response as JSON. Original error: ${primaryError instanceof Error ? primaryError.message : String(primaryError)}. ` +
      `Response preview: ${cleaned.slice(0, 300)}...`
    );
  }
}
