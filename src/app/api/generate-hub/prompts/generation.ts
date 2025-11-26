import type { QuestionGenerationParams } from '../types';

/**
 * Creates a generation prompt for producing multiple-choice questions for certification modules
 * @param params - Parameters containing modules, topic info, certification context, etc.
 * @returns A formatted prompt string for LLM question generation
 */
export function createQuestionGenerationPrompt(params: QuestionGenerationParams): string {
  const { 
    modules, 
    topicName, 
    topicDescription, 
    certificationName, 
    questionsPerModule, 
    questionTypes, 
    questionType = "mcq",
    complexityLevel = "basic",
    isProfessionalOrSpecialty = false
  } = params;
  
  // Build modules information for the prompt
  const modulesInfo = modules.map((module, index) => {
    return `
Module ${index + 1}:
- ID: ${module.module_id}
- Name: ${module.module_name}
- Description: ${module.module_description || 'Not provided'}
- Content: ${module.module_content ? module.module_content.substring(0, 200) + '...' : 'Not provided'}`;
  }).join('\n');
  
  const totalQuestions = questionsPerModule * modules.length;
  const isMultipleSelect = questionType === "multiple";
  
  let formatExample;
  if (isProfessionalOrSpecialty) {
    formatExample = isMultipleSelect ? `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "You are architecting a multi-tier e-commerce platform for a Fortune 500 company that processes 100,000+ transactions daily across 15 geographical regions. The platform consists of web servers, application servers, database clusters, and caching layers. During peak shopping seasons, traffic can spike to 10x normal levels within minutes, while during off-peak hours, resource utilization drops to 20%. The company has strict compliance requirements for data residency, requires 99.99% uptime SLA, and needs to optimize costs while maintaining performance. Given the complex regulatory environment, varying regional demand patterns, and the need to maintain session affinity for certain user workflows, which architectural strategies should be implemented to ensure optimal performance and compliance? (Select 3 options)",
    "options": ["Implement multi-region auto-scaling with regulatory-compliant data residency", "Use single-region deployment with manual scaling", "Deploy region-specific caching strategies with session persistence", "Implement cross-region database replication with compliance controls"],
    "correct_answer": [0, 2, 3],
    "explanation": "Multi-region auto-scaling ensures performance across regions while maintaining data residency compliance. Region-specific caching with session persistence addresses user experience needs. Cross-region database replication provides high availability while maintaining regulatory compliance."
  }` : `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "A large financial services company is migrating their core banking system to the cloud. The system handles millions of transactions per day, must comply with strict regulatory requirements including PCI DSS and SOX, requires 99.99% uptime, and needs to maintain sub-second response times during peak trading hours. The current on-premises infrastructure consists of mainframe systems, multiple database clusters, and legacy applications that cannot be easily refactored. The company wants to implement a hybrid cloud approach that minimizes risk while maximizing scalability and cost efficiency. They also need to ensure that sensitive customer data never leaves their geographic region due to regulatory constraints. What would be the most appropriate architectural approach for this complex migration scenario?",
    "options": ["Lift-and-shift all systems to public cloud with basic security", "Implement a carefully orchestrated hybrid architecture with on-premises core systems, cloud-based scaling layers, and region-specific data governance", "Move everything to a single cloud region immediately", "Maintain current infrastructure without any cloud integration"],
    "correct_answer": "{1}",
    "explanation": "A hybrid architecture allows the company to keep mission-critical core systems on-premises while leveraging cloud scalability for supporting systems. This approach addresses regulatory constraints, maintains performance requirements, and provides a lower-risk migration path for complex legacy systems."
  }`;
  } else if (complexityLevel === 'intermediate') {
    formatExample = isMultipleSelect ? `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "When implementing auto-scaling for a web application that experiences variable traffic patterns, which configuration practices should be followed to ensure optimal performance and cost efficiency? (Select 2 options)",
    "options": ["Set scaling policies based on CPU utilization and request count", "Use fixed instance counts regardless of traffic", "Implement predictive scaling for known traffic patterns", "Disable monitoring and alerts"],
    "correct_answer": [0, 2],
    "explanation": "CPU and request-based scaling ensures responsive scaling to actual demand. Predictive scaling helps prepare for known traffic patterns, reducing response time during traffic spikes."
  }` : `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "You're configuring auto-scaling for a web application that sees traffic spikes during business hours. What's the most effective scaling metric to use?",
    "options": ["Network utilization only", "Combination of CPU utilization and request count", "Memory usage only", "Fixed time-based scaling"],
    "correct_answer": "{1}",
    "explanation": "Using both CPU utilization and request count provides a more accurate picture of application load and ensures scaling responds to actual user demand rather than a single metric."
  }`;
  } else {
    formatExample = isMultipleSelect ? `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "Which AWS security practices should be implemented for production environments? (Select 2 options)",
    "options": ["Enable MFA for root account", "Use shared credentials", "Enable CloudTrail logging", "Disable encryption"],
    "correct_answer": [0, 2],
    "explanation": "MFA protects root account access and CloudTrail provides audit logging for compliance."
  }` : `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "What is the primary benefit of using AWS Lambda for serverless computing?",
    "options": ["Manual server management", "Automatic scaling and cost optimization", "Fixed pricing model", "Limited language support"],
    "correct_answer": "{1}",
    "explanation": "Lambda automatically scales and charges only for actual execution time."
  }`;
  }

  const answerFormat = isMultipleSelect 
    ? "- For multiple select: use array format like [0,2] for options 1 and 3 (NO quotes, NO curly braces)"
    : "- For single answer: use \"{index}\" format like \"{2}\" for option 3";

  return `Generate ${totalQuestions} ${certificationName} exam questions as valid JSON array.

QUESTION TYPE: ${isMultipleSelect ? "Multiple Select (choose all that apply)" : "Multiple Choice (single answer)"}

MODULES:
${modulesInfo}

CONTEXT: ${topicName}${topicDescription ? ` - ${topicDescription}` : ''}
CERTIFICATION: ${certificationName}

FORMAT (JSON only, no markdown):
[${formatExample}
]

REQUIREMENTS:
- Exactly ${questionsPerModule} questions per module
- Question type: ${isMultipleSelect ? "Multiple Select" : "Multiple Choice"}
${isMultipleSelect ? "- Each question must have 2-3 correct answers out of 4 options" : ""}
${isMultipleSelect ? "- Question text must include \"(Select X options)\" where X is the number of correct answers" : ""}
${isProfessionalOrSpecialty ? `
- QUESTION LENGTH: EXTREMELY LENGTHY questions (minimum 4-6 sentences, 80-150+ words)
- COMPLEXITY: Create ELABORATE enterprise-level scenarios with multiple variables and constraints
- SCENARIO DEPTH: Include detailed business contexts, compliance requirements, performance considerations
- TECHNICAL DEPTH: Use advanced terminology, architectural patterns, enterprise-level concepts
- AVOID: Simple definitions, straightforward procedures, or obvious answers
- FOCUS: Complex decision-making, troubleshooting multi-layered problems, strategic technical choices
- CONTEXT: Multi-paragraph scenarios with incomplete information requiring professional judgment` : complexityLevel === 'intermediate' ? `
- QUESTION LENGTH: Moderate length (2-3 sentences, 40-80 words)
- COMPLEXITY: Practical scenarios with clear implementation context
- FOCUS: Real-world application, configuration, and common use cases
- Use standard technical terminology with some advanced concepts` : `
- QUESTION LENGTH: Keep question text concise (20-50 words maximum)
- COMPLEXITY: Clear, direct questions about fundamental concepts
- FOCUS: Basic principles, definitions, and simple procedures
- Use simple, clear language with minimal technical jargon`}
- Difficulty level: ${complexityLevel.toUpperCase()}
- Base questions ONLY on the provided topic description and module descriptions/content
- Use specific details from module content to create relevant questions
- Mix question types: ${questionTypes.slice(0, 5).join(', ')}, etc.
- Proper JSON format with escaped quotes
${answerFormat}
- Return only the JSON array

Generate ${totalQuestions} questions:`;
}
