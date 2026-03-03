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
  console.log("KEEYYYY ", key);
  if (!key) {
    console.warn('[serper] no API key provided');
    return '';
  }

  try {
    // first attempt: GET with query parameter (include key in URL just in case)
    let url = `https://google.serper.dev/search?q=${encodeURIComponent(query)}&api_key=${encodeURIComponent(key)}`;
    console.log(`[serper] fetching context for query: "${query}" using URL ${url}`);
    let resp = await fetch(url, {
      method: 'GET',
      headers: {
        // some versions of the Serper API want the key in a header
        Authorization: `Bearer ${key}`,

      },
    });

    // if the GET failed with a client error, try sending the query in the body
    if (!resp.ok && (resp.status === 404 || resp.status === 405 || resp.status === 403)) {
      console.log('[serper] GET failed, retrying using POST with JSON body');
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
      console.warn('[serper] request failed', resp.status, await resp.text());
      // give up on external context
      return '';
    }

    const data: any = await resp.json();
    
    // prefer the structured answer if available
    if (data.answer) {
      return data.answer;
    }
    // otherwise fallback to snippets
    if (Array.isArray(data.organic_results)) {
      return data.organic_results
        .slice(0, 3)
        .map((r: any) => `${r.title || ''}\n${r.snippet || ''}`)
        .join('\n\n');
    }
    return '';
  } catch (err) {
    console.warn('[serper] failed to fetch', err);
    return '';
  }
}
