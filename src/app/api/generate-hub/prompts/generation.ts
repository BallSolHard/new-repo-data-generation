import type { QuestionGenerationParams } from "../types";

/**
 * Creates a generation prompt for producing multiple-choice questions for certification modules
 * @param params - Parameters containing modules, topic info, certification context, etc.
 * @returns A formatted prompt string for LLM question generation
 */
export function createQuestionGenerationPrompt(
  params: QuestionGenerationParams
): string {
  const {
    modules,
    topicName,
    topicDescription,
    certificationName,
    questionsPerModule,
    questionTypes,
    questionType = "mcq",
    complexityLevel = "basic",
    isProfessionalOrSpecialty = false,
  } = params;

  // Build modules information for the prompt
  const modulesInfo = modules
    .map((module, index) => {
      return `
Module ${index + 1}:
- ID: ${module.module_id}
- Name: ${module.module_name}
- Description: ${module.module_description || "Not provided"}
- Content: ${
        module.module_content
          ? module.module_content.substring(0, 200) + "..."
          : "Not provided"
      }`;
    })
    .join("\n");

  const totalQuestions = questionsPerModule * modules.length;
  const isMultipleSelect = questionType === "multiple";

  let formatExample;
  if (isProfessionalOrSpecialty) {
    formatExample = isMultipleSelect
      ? `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "You are architecting a multi-tier e-commerce platform for a Fortune 500 company that processes 100,000+ transactions daily across 15 geographical regions. The platform consists of web servers, application servers, database clusters, and caching layers. During peak shopping seasons, traffic can spike to 10x normal levels within minutes, while during off-peak hours, resource utilization drops to 20%. The company has strict compliance requirements for data residency, requires 99.99% uptime SLA, and needs to optimize costs while maintaining performance. Given the complex regulatory environment, varying regional demand patterns, and the need to maintain session affinity for certain user workflows, which architectural strategies should be implemented to ensure optimal performance and compliance? (Select 3 options)",
    "options": ["Implement multi-region auto-scaling infrastructure with regulatory-compliant data residency controls and zone-aware load balancing", "Deploy single-region centralized architecture with manual capacity management and simplified operational overhead procedures", "Configure region-specific caching strategies with session persistence mechanisms and intelligent traffic distribution patterns", "Establish cross-region database replication topology with compliance-aware failover controls and audit logging capabilities"],
    "correct_answer": [0, 2, 3],
    "explanation": "Multi-region auto-scaling ensures performance across regions while maintaining data residency compliance. Region-specific caching with session persistence addresses user experience needs. Cross-region database replication provides high availability while maintaining regulatory compliance."
  }`
      : `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "A large financial services company is migrating their core banking system to the cloud. The system handles millions of transactions per day, must comply with strict regulatory requirements including PCI DSS and SOX, requires 99.99% uptime, and needs to maintain sub-second response times during peak trading hours. The current on-premises infrastructure consists of mainframe systems, multiple database clusters, and legacy applications that cannot be easily refactored. The company wants to implement a hybrid cloud approach that minimizes risk while maximizing scalability and cost efficiency. They also need to ensure that sensitive customer data never leaves their geographic region due to regulatory constraints. What would be the most appropriate architectural approach for this complex migration scenario?",
    "options": ["Execute complete lift-and-shift migration to public cloud infrastructure while ensuring all security configurations are properly established, comprehensive monitoring dashboards are deployed across all regions, compliance audits are conducted regularly, and disaster recovery procedures are fully documented and tested", "Deploy workloads to single cloud region with containerized services", "Implement hybrid architecture with on-premises core and cloud scaling", "Maintain current infrastructure with enhanced monitoring"],
    "correct_answer": "{2}",
    "explanation": "A hybrid architecture allows the company to keep mission-critical core systems on-premises while leveraging cloud scalability for supporting systems."
  }`;
  } else if (complexityLevel === "intermediate") {
    formatExample = isMultipleSelect
      ? `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "When implementing auto-scaling for a web application that experiences variable traffic patterns, which configuration practices should be followed to ensure optimal performance and cost efficiency? (Select 2 options)",
    "options": ["Configure scaling policies based on combined CPU utilization metrics and incoming request count thresholds", "Maintain fixed instance counts regardless of actual traffic patterns to ensure predictable operational costs", "Implement predictive scaling mechanisms for known traffic patterns using historical usage data analysis", "Disable monitoring dashboards and automated alerts to reduce operational complexity and management overhead"],
    "correct_answer": [0, 2],
    "explanation": "CPU and request-based scaling ensures responsive scaling to actual demand. Predictive scaling helps prepare for known traffic patterns, reducing response time during traffic spikes."
  }`
      : `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "You're configuring auto-scaling for a web application that sees traffic spikes during business hours. What's the most effective scaling metric to use?",
    "options": ["Combine CPU utilization with request count for load assessment", "Monitor network bandwidth utilization as the sole metric while ensuring all traffic patterns are thoroughly analyzed, historical data is incorporated into the decision process, and baseline thresholds are properly calibrated", "Track memory consumption exclusively for capacity needs", "Apply fixed time-based scheduling only"],
    "correct_answer": "{0}",
    "explanation": "Using both CPU utilization and request count provides a more accurate picture of application load."
  }`;
  } else {
    formatExample = isMultipleSelect
      ? `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "Which AWS security practices should be implemented for production environments? (Select 2 options)",
    "options": ["Enable multi-factor authentication (MFA) for the root account to add security layer", "Configure shared credentials across team members to simplify access management workflow", "Enable CloudTrail logging service to maintain comprehensive audit trails for compliance", "Disable encryption features on storage services to improve data access performance speeds"],
    "correct_answer": [0, 2],
    "explanation": "MFA protects root account access and CloudTrail provides audit logging for compliance."
  }`
      : `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "What is the primary benefit of using AWS Lambda for serverless computing?",
    "options": ["Provides complete manual server management with full infrastructure control capabilities while ensuring all underlying resources are properly configured, maintained, monitored, and documented according to organizational standards", "Features predictable fixed pricing model", "Supports limited language options only", "Offers automatic scaling with pay-per-use pricing"],
    "correct_answer": "{3}",
    "explanation": "Lambda automatically scales and charges only for actual execution time."
  }`;
  }

  const answerFormat = isMultipleSelect
    ? "- For multiple select: use array format like [0,2] for options 1 and 3 (NO quotes, NO curly braces)"
    : '- For single answer: use "{index}" format like "{2}" for option 3';

  return `Generate ${totalQuestions} ${certificationName} exam questions as valid JSON array.

MANDATORY RULE #1 - READ THIS FIRST
THE CORRECT ANSWER MUST NEVER BE THE LONGEST OPTION.
For EVERY question, you MUST make ONE of the WRONG answers the LONGEST option (at least 5-10 words longer than the correct answer).

Example of CORRECT format:
- Option A (WRONG - LONGEST): "Implement comprehensive manual server provisioning with detailed configuration management while ensuring all security protocols are followed and documented" (22 words)
- Option B (WRONG): "Use fixed capacity planning without scaling" (6 words)  
- Option C (CORRECT - MEDIUM): "Deploy auto-scaling with load balancing" (6 words)
- Option D (WRONG): "Disable all monitoring services" (4 words)

Example of WRONG format (DO NOT DO THIS):
- Option A (WRONG): "Manual setup" (2 words)
- Option B (CORRECT - LONGEST): "Implement auto-scaling infrastructure with load balancing and comprehensive monitoring across all regions" (13 words) ❌ WRONG - correct answer is longest!
- Option C (WRONG): "Fixed capacity" (2 words)
- Option D (WRONG): "No scaling" (2 words)

QUESTION TYPE: ${
    isMultipleSelect
      ? "Multiple Select (choose all that apply)"
      : "Multiple Choice (single answer)"
  }

MODULES:
${modulesInfo}

CONTEXT: ${topicName}${topicDescription ? ` - ${topicDescription}` : ""}
CERTIFICATION: ${certificationName}

FORMAT (JSON only, no markdown):
[${formatExample}
]

REQUIREMENTS:
- Exactly ${questionsPerModule} questions per module
- Question type: ${isMultipleSelect ? "Multiple Select" : "Multiple Choice"}
${
  isMultipleSelect
    ? "- Each question must have 2-3 correct answers out of 4 options"
    : ""
}
${
  isMultipleSelect
    ? '- Question text must include "(Select X options)" where X is the number of correct answers'
    : ""
}
${
  isProfessionalOrSpecialty
    ? `
- QUESTION LENGTH: EXTREMELY LENGTHY questions (minimum 4-6 sentences, 80-150+ words)
- COMPLEXITY: Create ELABORATE enterprise-level scenarios with multiple variables and constraints
- SCENARIO DEPTH: Include detailed business contexts, compliance requirements, performance considerations
- TECHNICAL DEPTH: Use advanced terminology, architectural patterns, enterprise-level concepts
- AVOID: Simple definitions, straightforward procedures, or obvious answers
- FOCUS: Complex decision-making, troubleshooting multi-layered problems, strategic technical choices
- CONTEXT: Multi-paragraph scenarios with incomplete information requiring professional judgment`
    : complexityLevel === "intermediate"
    ? `
- QUESTION LENGTH: Moderate length (2-3 sentences, 40-80 words)
- COMPLEXITY: Practical scenarios with clear implementation context
- FOCUS: Real-world application, configuration, and common use cases
- Use standard technical terminology with some advanced concepts`
    : `
- QUESTION LENGTH: Keep question text concise (20-50 words maximum)
- COMPLEXITY: Clear, direct questions about fundamental concepts
- FOCUS: Basic principles, definitions, and simple procedures
- Use simple, clear language with minimal technical jargon`
}
- Difficulty level: ${complexityLevel.toUpperCase()}

CORRECT ANSWER POSITION RANDOMIZATION:
- DISTRIBUTE correct answer positions EVENLY across indices: {0}, {1}, {2}, {3}
- Pattern for ${totalQuestions} questions: vary between 0, 1, 2, 3 (roughly equal distribution)
- NEVER have more than 2 consecutive questions with the same correct answer index

REMEMBER: Before finalizing each question, verify that a WRONG answer is the LONGEST option, NOT the correct answer.

- Base questions ONLY on the provided topic description and module descriptions/content
- Use specific details from module content to create relevant questions
- Mix question types: ${questionTypes.slice(0, 5).join(", ")}, etc.
- Proper JSON format with escaped quotes
${answerFormat}
- Return only the JSON array

Generate ${totalQuestions} questions:`;
}
