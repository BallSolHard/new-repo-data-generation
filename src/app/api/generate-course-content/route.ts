import { NextRequest, NextResponse } from 'next/server';

// ─── Types ────────────────────────────────────────────────────────────────────

interface CourseGenerationRequest {
  certification_id: string;
  certification_name: string;
  topic_id: string;
  topic_name: string;
  topic_description?: string;
  module_id: string;
  module_name: string;
  module_description?: string;
  module_content?: string;
}

interface ContentSection {
  title: string;
  content: string;
  duration?: string;
  key_points?: string[];
  examples?: string[];
  best_practices?: string[];
}

interface GeneratedCourseContent {
  certification_name: string;
  certification_id: string;
  topic_name: string;
  topic_id: string;
  topic_description?: string;
  module_id: string;
  module_name: string;
  module_description?: string;
  overview?: string;
  estimated_duration: string;
  learning_objectives: string[];
  content_sections: ContentSection[];
  summary?: string;
  next_steps?: string[];
  generated_at: string;
}

// ─── Course Content Generator using Gemini API ────────────────────────────────

async function generateCourseContentWithGemini(
  request: CourseGenerationRequest
): Promise<GeneratedCourseContent> {
  const apiKey = process.env.GOOGLE_AI_API_KEY || process.env.GEMINI_API_KEY;

  if (!apiKey) {
    throw new Error('GOOGLE_AI_API_KEY or GEMINI_API_KEY not configured');
  }

  const prompt = `You are an expert course content creator. Generate comprehensive, well-structured lesson content for a 5-7 minute read.

Generate a complete course lesson with the following specifications:
- Format: JSON with structured sections
- Duration: 5-7 minutes reading time (approximately 1,200-1,400 words)
- Style: Professional, educational, and engaging
- Target audience: Certification exam candidates
- Include: Concepts, examples, best practices, and actionable takeaways

Topic Details:
- Certification: ${request.certification_name}
- Domain: ${request.topic_name}
- Module: ${request.module_name}
- Description: ${request.module_description || request.topic_description || 'Core module content'}
- Additional Context: ${request.module_content || 'Generate comprehensive module content based on certification standards'}

Generate ONLY a valid JSON object with NO additional text or markdown formatting.

{
  "overview": "Brief introduction to the module (2-3 sentences)",
  "learning_objectives": [
    "Objective 1",
    "Objective 2",
    "Objective 3",
    "Objective 4",
    "Objective 5"
  ],
  "content_sections": [
    {
      "title": "Section 1 Title",
      "content": "Detailed section content with clear explanations...",
      "duration": "1-2 minutes",
      "key_points": [
        "Key point 1",
        "Key point 2",
        "Key point 3"
      ],
      "examples": [
        "Example 1 with practical application",
        "Example 2 with practical application"
      ],
      "best_practices": [
        "Best practice 1",
        "Best practice 2"
      ]
    }
  ],
  "summary": "Comprehensive summary of key concepts and their importance",
  "next_steps": [
    "Next step 1 for deeper learning",
    "Next step 2 for practical application",
    "Next step 3 for certification preparation"
  ]
}`;

  try {
    const response = await fetch('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-goog-api-key': apiKey,
      },
      body: JSON.stringify({
        contents: [
          {
            parts: [
              {
                text: prompt,
              },
            ],
          },
        ],
        generationConfig: {
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 4096,
        },
      }),
    });

    if (!response.ok) {
      const error = await response.text();
      console.error('Gemini API error:', error);
      throw new Error(`Gemini API error: ${response.status}`);
    }

    const data = await response.json();
    const responseText = data.candidates?.[0]?.content?.parts?.[0]?.text;

    if (!responseText) {
      throw new Error('No content generated from Gemini API');
    }

    // Parse the JSON response
    let parsedContent;
    try {
      // Try to extract JSON from the response if it contains extra text
      const jsonMatch = responseText.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        parsedContent = JSON.parse(jsonMatch[0]);
      } else {
        parsedContent = JSON.parse(responseText);
      }
    } catch (parseError) {
      console.error('JSON parse error:', parseError);
      console.error('Response text:', responseText.substring(0, 500));
      // Fallback: create a structured response
      parsedContent = {
        overview: 'Generated course content',
        learning_objectives: ['Understand core concepts', 'Apply knowledge practically'],
        content_sections: [
          {
            title: 'Core Concepts',
            content: responseText,
            key_points: ['Key concept 1', 'Key concept 2'],
          },
        ],
        summary: 'Complete your learning journey with practice',
        next_steps: ['Review the material', 'Take practice tests'],
      };
    }

    // Structure the final response
    const courseContent: GeneratedCourseContent = {
      certification_name: request.certification_name,
      certification_id: request.certification_id,
      topic_name: request.topic_name,
      topic_id: request.topic_id,
      topic_description: request.topic_description,
      module_id: request.module_id,
      module_name: request.module_name,
      module_description: request.module_description,
      overview: parsedContent.overview || `Learn about ${request.module_name}`,
      estimated_duration: '5-7 minutes',
      learning_objectives: parsedContent.learning_objectives || [],
      content_sections: parsedContent.content_sections || [],
      summary: parsedContent.summary || 'Complete your learning',
      next_steps: parsedContent.next_steps || [],
      generated_at: new Date().toISOString(),
    };

    return courseContent;
  } catch (error) {
    console.error('Error calling Gemini API:', error);
    throw error;
  }
}

// ─── Route Handler ────────────────────────────────────────────────────────────

export async function POST(request: NextRequest) {
  try {
    const body = (await request.json()) as CourseGenerationRequest;

    // Validate required fields
    if (!body.module_id || !body.module_name || !body.certification_name || !body.topic_name) {
      return NextResponse.json(
        {
          error: 'Missing required fields: module_id, module_name, certification_name, topic_name',
        },
        { status: 400 }
      );
    }

    // Generate course content
    const courseContent = await generateCourseContentWithGemini(body);

    return NextResponse.json(courseContent, { status: 200 });
  } catch (error) {
    console.error('Error generating course content:', error);
    return NextResponse.json(
      {
        error: 'Failed to generate course content',
        details: error instanceof Error ? error.message : 'Unknown error',
      },
      { status: 500 }
    );
  }
}
