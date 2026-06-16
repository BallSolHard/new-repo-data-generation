// Type definitions (replacing Zod schemas)
type MockTestQuestion = {
  question_id: string;
  mock_test_id: string;
  question_text: string;
  options: string[];
  topic_id: number;
  question_order: number;
  question_type: string;
  explanation: string;
  correct_answer: number[];
  pairs: any | null;
  matches: any | null;
  module_id: string;
  time_spent_seconds: any | null;
  created_at: string;
};

type Module = {
  created_at: string;
  module_name: string;
  module_description: string;
  topic_id: number;
  ideal_completion_time: string;
  module_content: string;
  module_id: string;
};

type ModuleMatchingResponse = {
  question_id: string;
  current_module_id: string;
  matched_module_id: string;
  confidence_score: number;
  reasoning: string;
  sql_update_statement: string;
};

interface BatchUpdateRequest {
  questions: MockTestQuestion[];
  modules: Module[];
}

async function generateModuleMatching(
  questions: MockTestQuestion[],
  modules: Module[]
): Promise<ModuleMatchingResponse[]> {
  if (!process.env.GEMINI_API_KEY) {
    throw new Error("GEMINI_API_KEY is not set in environment variables");
  }

  // Format questions and modules for the prompt
  const questionsText = questions
    .map(
      (q, idx) =>
        `[Question ${idx + 1}]\nID: ${q.question_id}\nText: ${q.question_text}\nCurrent Module: ${q.module_id}\nExplanation: ${q.explanation}`
    )
    .join("\n\n");

  const modulesText = modules
    .map(
      (m) =>
        `[Module: ${m.module_id}]\nName: ${m.module_name}\nDescription: ${m.module_description}\nContent: ${m.module_content}`
    )
    .join("\n\n");

  const responseSchema = {
    type: "array",
    items: {
      type: "object",
      properties: {
        question_id: {
          type: "string",
          description: "The unique identifier of the question",
        },
        current_module_id: {
          type: "string",
          description: "The current module_id assigned to the question",
        },
        matched_module_id: {
          type: "string",
          description:
            "The recommended module_id based on semantic analysis (use format like m_19_2)",
        },
        confidence_score: {
          type: "number",
          description:
            "Confidence score between 0 and 1 indicating how well the question matches the recommended module",
        },
        reasoning: {
          type: "string",
          description:
            "Brief explanation of why this module was selected for this question",
        },
        sql_update_statement: {
          type: "string",
          description:
            'SQL UPDATE statement to update this question. Format: UPDATE public.mock_test_questions SET module_id = \'NEW_MODULE_ID\' WHERE question_id = \'QUESTION_ID\';',
        },
      },
      required: [
        "question_id",
        "current_module_id",
        "matched_module_id",
        "confidence_score",
        "reasoning",
        "sql_update_statement",
      ],
    },
  };

  try {
    const response = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${process.env.GEMINI_API_KEY}`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          contents: [
            {
              parts: [
                {
                  text: `Analyze the following AWS SAA mock test questions and match them to the most appropriate module based on their content.

## AVAILABLE MODULES:
${modulesText}

## MOCK TEST QUESTIONS TO ANALYZE:
${questionsText}

## MATCHING INSTRUCTIONS:
1. Analyze each question's content, explanations, and the services/concepts mentioned
2. Match each question to the BEST fitting module from the available modules list
3. Consider the topic area, services discussed, and learning objectives
4. Provide a confidence score (0-1) for each match
5. Generate the exact SQL UPDATE statement for each question

## MATCHING GUIDELINES:
- Questions about backup, recovery, RTO/RPO, disaster recovery, and multi-region failover → "High Availability Architectures" (m_19_2)
- Questions about databases, data consistency, replication, multi-region databases → "High-Performing Databases" (m_20_3)
- Questions about batch processing, scalability, serverless → "Scalable Architectures" (m_19_1)
- Questions about cost optimization strategies → "Cost-Optimized" modules (m_21_x)
- Questions about infrastructure recreation, CloudFormation, IaC → relevant high-availability or scalability modules
- Consider both the primary topic AND the secondary services mentioned

## IMPORTANT:
- Only use module_ids from the available modules list
- Ensure confidence_score reflects how well the question truly matches the module
- The sql_update_statement must be properly formatted
- If a question belongs to its current module, still include it with high confidence`,
                },
              ],
            },
          ],
          generationConfig: {
            temperature: 0.3,
            maxOutputTokens: 8192,
            responseMimeType: "application/json",
            responseSchema: responseSchema,
            topP: 0.9,
            topK: 40,
          },
        }),
      }
    ).then((res) =>
      res.json().then((data) => {
        if (!res.ok) throw new Error(data?.error?.message || "Gemini API error");
        return data;
      })
    );

    if (!response.candidates?.[0]?.content?.parts?.[0]?.text) {
      console.error("Unexpected Gemini response format:", response);
      throw new Error("Unexpected response format from Gemini API");
    }

    const responseText = response.candidates[0].content.parts[0].text;
    const parsedContent = JSON.parse(responseText);

    // Return parsed content as ModuleMatchingResponse array
    return parsedContent as ModuleMatchingResponse[];
  } catch (error) {
    console.error("Error in generateModuleMatching:", error);
    throw error;
  }
}

function generateBatchUpdateSQL(
  matches: ModuleMatchingResponse[],
  minConfidenceThreshold: number = 0.7
): {
  updateStatements: string[];
  summary: {
    total: number;
    updated: number;
    skipped: number;
    changes: Array<{
      questionId: string;
      oldModule: string;
      newModule: string;
      confidence: number;
    }>;
  };
} {
  const updateStatements: string[] = [];
  const changes: Array<{
    questionId: string;
    oldModule: string;
    newModule: string;
    confidence: number;
  }> = [];
  let updated = 0;
  let skipped = 0;

  for (const match of matches) {
    if (match.matched_module_id !== match.current_module_id) {
      if (match.confidence_score >= minConfidenceThreshold) {
        updateStatements.push(match.sql_update_statement);
        changes.push({
          questionId: match.question_id,
          oldModule: match.current_module_id,
          newModule: match.matched_module_id,
          confidence: match.confidence_score,
        });
        updated++;
      } else {
        skipped++;
        console.warn(
          `Skipped question ${match.question_id}: Low confidence (${match.confidence_score.toFixed(2)})`
        );
      }
    } else {
      console.log(
        `Question ${match.question_id}: Already in correct module (${match.current_module_id})`
      );
    }
  }

  return {
    updateStatements,
    summary: {
      total: matches.length,
      updated,
      skipped,
      changes,
    },
  };
}

async function main() {
  // Mock test questions data
  const questions: MockTestQuestion[] = [
    {
      question_id: "43b0ceb5-bf31-4fbb-affe-3b4894ca4d9e",
      mock_test_id: "aws_saa_mock2_abc123",
      question_text:
        "A backup strategy requires automated testing of backup integrity, point-in-time recovery across multiple services, and compliance with recovery objectives. The solution must verify backup completeness and provide recovery time estimates. What backup architecture ensures data protection?",
      options: [
        "AWS Backup with automated restore testing, cross-service policies, and compliance monitoring",
        "Individual service backups with manual testing and custom verification",
        "Third-party backup solution with AWS service integration",
        "Custom backup scripts with automated testing and reporting",
      ],
      topic_id: 19,
      question_order: 63,
      question_type: "mcq",
      explanation:
        "Option A (incorrect) While AWS Backup offers robust automation... [truncated for brevity]",
      correct_answer: [1],
      pairs: null,
      matches: null,
      module_id: "m_2_3",
      time_spent_seconds: null,
      created_at: "2026-03-11 01:41:54.116876+00",
    },
    {
      question_id: "06a01c34-2b13-46de-a958-0c74bda955f1",
      mock_test_id: "aws_saa_mock_exam_xyz789",
      question_text:
        "A database-driven application requires read replicas distributed across multiple regions for disaster recovery and local read performance. Write operations must be consistent across all regions, and failover should be automatic with minimal data loss. What database solution meets these requirements?",
      options: [
        "Amazon RDS with Multi-AZ deployment and cross-region read replicas",
        "Amazon Aurora Global Database with automated failover capabilities",
        "Amazon DynamoDB with Global Tables and eventually consistent reads",
        "Amazon Redshift with cross-region snapshots and manual failover procedures",
      ],
      topic_id: 19,
      question_order: 7,
      question_type: "mcq",
      explanation:
        "**CORRECT ANSWER: Option B (Index 1)**... [truncated for brevity]",
      correct_answer: [1],
      pairs: null,
      matches: null,
      module_id: "m_2_3",
      time_spent_seconds: null,
      created_at: "2026-03-11 01:41:54.116876+00",
    },
    {
      question_id: "58a6db98-b2df-4f96-883b-6d90830eb981",
      mock_test_id: "aws_saa_mock_exam_xyz789",
      question_text:
        "A data processing pipeline must handle batch jobs that can take anywhere from minutes to hours to complete. The system should automatically retry failed jobs, scale processing capacity based on queue depth, and minimize costs during low-demand periods. What serverless approach accomplishes this?",
      options: [
        "AWS Batch with EC2 Spot instances and Amazon SQS for job queuing",
        "AWS Lambda with SQS triggers and Dead Letter Queue for failed processing",
        "AWS Step Functions coordinating multiple Lambda functions with error handling",
        "Amazon ECS with Fargate Spot and CloudWatch Events for scheduling",
      ],
      topic_id: 19,
      question_order: 10,
      question_type: "mcq",
      explanation:
        "Option A (correct) AWS Batch is purpose-built... [truncated for brevity]",
      correct_answer: [0],
      pairs: null,
      matches: null,
      module_id: "m_2_3",
      time_spent_seconds: null,
      created_at: "2026-03-11 01:41:54.116876+00",
    },
    // ... remaining questions would be added similarly
  ];

  // Modules data
  const modules: Module[] = [
    {
      created_at: "2025-09-01 10:40:24.998564+00",
      module_name: "High Availability Architectures",
      module_description: "Ensuring fault tolerance and high availability.",
      topic_id: 19,
      ideal_completion_time: "2025-08-22 03:00:00",
      module_content:
        "Covers multi-AZ deployments and disaster recovery strategies.",
      module_id: "m_19_2",
    },
    {
      created_at: "2025-09-01 10:40:24.998564+00",
      module_name: "Scalable Architectures",
      module_description: "Designing loosely coupled and scalable systems.",
      topic_id: 19,
      ideal_completion_time: "2025-08-22 03:00:00",
      module_content:
        "Includes microservices, serverless, and container orchestration.",
      module_id: "m_19_1",
    },
    {
      created_at: "2025-09-01 10:40:24.998564+00",
      module_name: "High-Performing Databases",
      module_description: "Optimizing database performance.",
      topic_id: 20,
      ideal_completion_time: "2025-08-22 01:30:00",
      module_content:
        "Covers Aurora, DynamoDB, and caching strategies.",
      module_id: "m_20_3",
    },
    // ... additional modules would be added
  ];

  try {
    console.log("🚀 Starting module matching process...\n");
    console.log(`📊 Processing ${questions.length} questions...\n`);

    // Generate module matches using Gemini
    const matches = await generateModuleMatching(questions, modules);

    console.log("✅ Module matching completed!\n");

    // Generate SQL update statements
    const { updateStatements, summary } = generateBatchUpdateSQL(matches, 0.65);

    console.log("📋 UPDATE SUMMARY:");
    console.log(`   Total questions analyzed: ${summary.total}`);
    console.log(`   Questions to update: ${summary.updated}`);
    console.log(`   Skipped (low confidence): ${summary.skipped}\n`);

    if (summary.changes.length > 0) {
      console.log("🔄 PROPOSED CHANGES:");
      for (const change of summary.changes) {
        console.log(
          `   ${change.questionId}: ${change.oldModule} → ${change.newModule} (confidence: ${(change.confidence * 100).toFixed(0)}%)`
        );
      }
      console.log();
    }

    console.log("💾 SQL UPDATE STATEMENTS:");
    console.log("----------------------------------------");
    if (updateStatements.length > 0) {
      for (const statement of updateStatements) {
        console.log(statement);
      }
      console.log("----------------------------------------\n");

      // Create a batch SQL file
      const batchSqlContent = [
        "-- Auto-generated SQL update statements for mock test questions",
        "-- Generated by: update_mock_test_module_ids.ts",
        `-- Timestamp: ${new Date().toISOString()}`,
        "-- Total updates: " + updateStatements.length,
        "",
        "BEGIN TRANSACTION;",
        "",
        ...updateStatements,
        "",
        "COMMIT;",
      ].join("\n");

      const fs = await import("fs").then((m) => m.promises);
      const timestamp = new Date().toISOString().replace(/[:.]/g, "-");
      const filename = `/Users/ranjanbatra/Ranjan_Programming_repos/studytech/new-studytech/sql/update_mock_questions_modules_${timestamp}.sql`;

      await fs.writeFile(filename, batchSqlContent);
      console.log(`✨ SQL file saved: ${filename}\n`);
    } else {
      console.log("No updates needed - all questions are in correct modules.\n");
    }
  } catch (error) {
    console.error("❌ Error during module matching:", error);
    process.exit(1);
  }
}

main();
