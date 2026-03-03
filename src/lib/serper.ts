/**
 * Simple wrapper around the Serper API (https://serper.dev) that performs a
 * web-search query and returns a short text summary of the top results.  The
 * key is expected to be provided in the SERPER_API_KEY environment variable.
 *
 * The exact shape of the Serper response may vary; we currently try to use the
 * `answer` field (the AI's summary) or concatenate the first few organic results.
 */

export async function fetchSerperContext(query: string): Promise<string> {
  const key = process.env.SERPER_API_KEY;
  if (!key) {
    console.warn('[serper] ❌ No SERPER_API_KEY environment variable set. Serper context disabled.');
    return '';
  }

  try {
    // first attempt: GET with query parameter (include key in URL just in case)
    let url = `https://google.serper.dev/search?q=${encodeURIComponent(query)}&api_key=${encodeURIComponent(key)}`;
    console.log(`[serper] 🔍 Fetching context for query: "${query}"`);
    let resp = await fetch(url, {
      method: 'GET',
      headers: {
        // some versions of the Serper API want the key in a header
        Authorization: `Bearer ${key}`,
      },
    });

    // if the GET failed with a client error, try sending the query in the body
    if (!resp.ok && (resp.status === 404 || resp.status === 405 || resp.status === 403)) {
      console.log('[serper] ⚠️  GET failed, retrying using POST with JSON body');
      resp = await fetch('https://google.serper.dev/search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${key}`,
          'x-api-key': key,
        },
        body: JSON.stringify({ q: query, api_key: key }),
      });
    }

    if (!resp.ok) {
      console.warn(`[serper] ❌ Request failed with status ${resp.status}`);
      const respText = await resp.text();
      console.warn('[serper] Response:', respText.slice(0, 500));
      // give up on external context
      return '';
    }

    const data: any = await resp.json();
    console.log('[serper] ✅ API returned data successfully');
    console.log('[serper] Response structure:', JSON.stringify({
      hasAnswer: !!data.answer,
      hasOrganic_results: Array.isArray(data.organic_results),
      hasOrganic: Array.isArray(data.organic),
      organicCount: data.organic_results?.length || data.organic?.length || 0,
      hasSearchParameters: !!data.searchParameters,
      hasKnowledgeGraph: !!data.knowledgeGraph,
      hasRelated: Array.isArray(data.related),
      relatedCount: data.related?.length || 0,
      allKeys: Object.keys(data).join(', ')
    }));
    
    // prefer the structured answer if available
    if (data.answer) {
      console.log(`[serper] ✅ Using AI-generated answer (${data.answer.length} chars)`);
      return data.answer;
    }
    
    // Try organic_results first (standard format)
    if (Array.isArray(data.organic_results) && data.organic_results.length > 0) {
      const context = data.organic_results
        .slice(0, 3)
        .map((r: any) => `${r.title || ''}\n${r.snippet || ''}`)
        .join('\n\n');
      console.log(`[serper] ✅ Using organic_results (${context.length} chars)`);
      return context;
    }
    
    // Try organic field (alternative format that Serper sometimes uses)
    if (Array.isArray(data.organic) && data.organic.length > 0) {
      const context = data.organic
        .slice(0, 3)
        .map((r: any) => `${r.title || ''}\n${r.snippet || ''}`)
        .join('\n\n');
      console.log(`[serper] ✅ Using organic field (${context.length} chars)`);
      return context;
    }
    
    // Try knowledge graph as fallback
    if (data.knowledgeGraph) {
      const kgText = `${data.knowledgeGraph.title || ''}\n${data.knowledgeGraph.description || ''}`;
      console.log(`[serper] ✅ Using knowledge graph (${kgText.length} chars)`);
      return kgText;
    }
    
    // Try related searches as last resort
    if (Array.isArray(data.related) && data.related.length > 0) {
      const relatedText = data.related.slice(0, 5).map((r: any) => r.query).join(', ');
      console.log(`[serper] ⚠️  Using related searches as fallback (${relatedText.length} chars)`);
      return relatedText;
    }
    
    // Log the entire response for debugging if nothing matched
    console.warn('[serper] ⚠️  No recognizable data in response. Full response:');
    console.warn('[serper] Response data:', JSON.stringify(data, null, 2).slice(0, 1000));
    return '';
  } catch (err) {
    console.error('[serper] ❌ Failed to fetch:', err);
    return '';
  }
}
