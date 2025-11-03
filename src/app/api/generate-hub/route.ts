import { NextRequest, NextResponse } from 'next/server';

// Interface for generated question
interface GeneratedQuestion {
  text: string;
  options: string[];
  correct_answer: string;
  explanation: string;
}

// Function to generate contextual questions based on module and topic information
async function generateContextualQuestion(
  module: any,
  topicName: string,
  topicDescription: string,
  certificationName: string,
  questionNumber: number
): Promise<GeneratedQuestion> {
  const { module_name, module_description, module_content } = module;
  
  // Question generation strategies based on certification type
  const certificationContext = getCertificationContext(certificationName);
  
  // Generate different question types
  const questionTypes = [
    () => generateScenarioQuestion(module_name, module_description, topicName, certificationContext),
    () => generateBestPracticeQuestion(module_name, module_description, topicName, certificationContext),
    () => generateTroubleshootingQuestion(module_name, module_description, topicName, certificationContext),
    () => generateArchitecturalQuestion(module_name, module_description, topicName, certificationContext),
    () => generateSecurityQuestion(module_name, module_description, topicName, certificationContext)
  ];
  
  // Select question type based on question number and module content
  const questionTypeIndex = (questionNumber - 1) % questionTypes.length;
  return questionTypes[questionTypeIndex]();
}

// Get certification-specific context and services
function getCertificationContext(certificationName: string) {
  const contexts = {
    'AWS Solutions Architect': {
      services: ['IAM', 'VPC', 'EC2', 'Lambda', 'RDS', 'DynamoDB', 'S3', 'CloudFront', 'ELB', 'Auto Scaling', 'CloudWatch', 'CloudTrail', 'KMS', 'ECS', 'ElastiCache'],
      focus: 'scalability, reliability, performance optimization, cost optimization, security',
      scenarios: 'enterprise applications, microservices, data lakes, content delivery, high availability'
    },
    'Azure Fundamentals': {
      services: ['Azure AD', 'Virtual Network', 'Virtual Machines', 'App Service', 'Azure Functions', 'SQL Database', 'Cosmos DB', 'Blob Storage', 'CDN', 'Load Balancer', 'Monitor', 'Key Vault'],
      focus: 'cloud concepts, core services, security compliance, governance, hybrid connectivity',
      scenarios: 'web applications, data storage, hybrid cloud, business continuity, digital transformation'
    },
    'Google Cloud Associate': {
      services: ['Cloud IAM', 'VPC', 'Compute Engine', 'Cloud Functions', 'Cloud SQL', 'Firestore', 'Cloud Storage', 'Cloud CDN', 'Cloud Load Balancing', 'Stackdriver', 'GKE', 'Cloud Security'],
      focus: 'cloud infrastructure, data services, networking security, container orchestration, machine learning',
      scenarios: 'containerized applications, big data analytics, machine learning pipelines, global deployment, DevOps automation'
    }
  };
  
  return contexts[certificationName as keyof typeof contexts] || contexts['AWS Solutions Architect'];
}

// Extract meaningful keywords from descriptions
function extractKeywords(text: string): string[] {
  if (!text) return [];
  
  // Remove common words and extract meaningful terms
  const commonWords = ['and', 'or', 'the', 'a', 'an', 'to', 'for', 'of', 'in', 'on', 'with', 'by', 'from', 'as', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'do', 'does', 'did', 'will', 'would', 'should', 'could', 'can', 'may', 'might', 'must', 'shall'];
  
  const words = text.toLowerCase()
    .replace(/[^a-zA-Z\s]/g, ' ') // Remove special characters
    .split(/\s+/)
    .filter(word => word.length > 2 && !commonWords.includes(word))
    .slice(0, 5); // Take first 5 meaningful words
  
  return words.length > 0 ? words : ['management', 'optimization'];
}

// Get relevant services based on keywords and available services
function getRelevantServices(keywords: string[], availableServices: string[]): string[] {
  const serviceMapping: { [key: string]: string[] } = {
    'security': ['IAM', 'VPC', 'Security Groups', 'KMS'],
    'data': ['RDS', 'DynamoDB', 'S3', 'Redshift'],
    'compute': ['EC2', 'Lambda', 'ECS', 'Fargate'],
    'network': ['VPC', 'CloudFront', 'Route53', 'ELB'],
    'monitoring': ['CloudWatch', 'CloudTrail', 'X-Ray', 'Config'],
    'storage': ['S3', 'EBS', 'EFS', 'Glacier'],
    'database': ['RDS', 'DynamoDB', 'Aurora', 'DocumentDB'],
    'scaling': ['Auto Scaling', 'ELB', 'CloudFront', 'Lambda'],
    'performance': ['CloudFront', 'ElastiCache', 'Auto Scaling', 'Lambda'],
    'access': ['IAM', 'Cognito', 'Directory Service', 'SSO'],
    'management': ['CloudFormation', 'Systems Manager', 'Config', 'CloudTrail']
  };
  
  const matchedServices: string[] = [];
  
  // Find services based on keywords
  for (const keyword of keywords) {
    for (const [category, services] of Object.entries(serviceMapping)) {
      if (keyword.includes(category) || category.includes(keyword)) {
        matchedServices.push(...services);
      }
    }
  }
  
  // If no matches, use available services
  if (matchedServices.length === 0) {
    return availableServices.slice(0, 4);
  }
  
  // Return unique services that exist in available services
  const uniqueServices = [...new Set(matchedServices)];
  const validServices = uniqueServices.filter(service => 
    availableServices.some(available => 
      available.toLowerCase().includes(service.toLowerCase()) || 
      service.toLowerCase().includes(available.toLowerCase())
    )
  );
  
  return validServices.length > 0 ? validServices.slice(0, 4) : availableServices.slice(0, 4);
}

// Generate scenario-based questions
function generateScenarioQuestion(moduleName: string, moduleDescription: string, topicName: string, context: any): GeneratedQuestion {
  // Extract key concepts from module description
  const moduleKeywords = extractKeywords(moduleDescription || moduleName);
  const topicKeywords = extractKeywords(topicName);
  
  // Build scenario from actual module description
  const scenarioContext = moduleDescription 
    ? `implementing ${moduleName} with focus on ${moduleDescription.toLowerCase()}`
    : `implementing ${moduleName} effectively`;
  
  const scenario = `An organization needs to ${scenarioContext} as part of their ${topicName.toLowerCase()} strategy.`;
  
  // Generate options based on certification services and module context
  const relevantServices = getRelevantServices(moduleKeywords, context.services);
  
  return {
    text: `${scenario} What is the most appropriate approach?`,
    options: [
      `Use basic ${relevantServices[0] || 'infrastructure'} without considering ${moduleKeywords[0] || 'requirements'}`,
      `Implement ${relevantServices[1] || 'cloud services'} with proper ${moduleKeywords[1] || 'configuration'} and ${moduleKeywords[0] || 'best practices'}`,
      `Rely on manual processes for ${moduleKeywords[0] || 'management'}`,
      `Avoid ${moduleName.toLowerCase()} implementation entirely`
    ],
    correct_answer: "{1}",
    explanation: `Implementing ${relevantServices[1] || 'cloud services'} with proper ${moduleKeywords[1] || 'configuration'} addresses the core requirements of ${moduleName}. This approach leverages ${topicName.toLowerCase()} principles while ensuring ${moduleKeywords[0] || 'optimal performance'}.`
  };
}

// Generate best practice questions
function generateBestPracticeQuestion(moduleName: string, moduleDescription: string, topicName: string, context: any): GeneratedQuestion {
  const moduleKeywords = extractKeywords(moduleDescription || moduleName);
  const focusAreas = context.focus.split(',').map((f: string) => f.trim());
  
  // Use actual module description to form the question
  const practiceContext = moduleDescription 
    ? `when working with ${moduleDescription.toLowerCase()}`
    : `when implementing ${moduleName.toLowerCase()}`;
  
  const relevantServices = getRelevantServices(moduleKeywords, context.services);
  const primaryFocus = focusAreas[0] || 'optimization';
  
  return {
    text: `What is the recommended best practice for ${primaryFocus} ${practiceContext} in ${topicName.toLowerCase()}?`,
    options: [
      `Ignore ${primaryFocus} considerations for ${moduleName.toLowerCase()}`,
      `Apply ${primaryFocus} principles using ${relevantServices[0] || 'appropriate services'} and ${relevantServices[1] || 'monitoring tools'}`,
      `Use only default configurations without customization`,
      `Implement ${moduleName.toLowerCase()} without ${primaryFocus} planning`
    ],
    correct_answer: "{1}",
    explanation: `Applying ${primaryFocus} principles using ${relevantServices[0] || 'appropriate services'} and ${relevantServices[1] || 'monitoring tools'} ensures that ${moduleName} aligns with ${topicName.toLowerCase()} objectives and delivers ${moduleKeywords[0] || 'optimal results'}.`
  };
}

// Generate troubleshooting questions
function generateTroubleshootingQuestion(moduleName: string, moduleDescription: string, topicName: string, context: any): GeneratedQuestion {
  const moduleKeywords = extractKeywords(moduleDescription || moduleName);
  const topicKeywords = extractKeywords(topicName);
  
  // Build troubleshooting scenario from module description
  const problemContext = moduleDescription 
    ? `with ${moduleDescription.toLowerCase()}`
    : `related to ${moduleName.toLowerCase()}`;
  
  const relevantServices = getRelevantServices(moduleKeywords.concat(topicKeywords), context.services);
  const primaryKeyword = moduleKeywords[0] || 'performance';
  
  return {
    text: `Your ${moduleName} implementation is experiencing issues ${problemContext} in the context of ${topicName.toLowerCase()}. What is the most effective troubleshooting approach?`,
    options: [
      `Ignore the ${primaryKeyword} issues and continue with current setup`,
      `Use ${relevantServices[0] || 'monitoring tools'} and ${relevantServices[1] || 'logging services'} to analyze ${primaryKeyword} patterns`,
      `Restart all services without investigating the root cause`,
      `Replace the entire ${moduleName.toLowerCase()} implementation`
    ],
    correct_answer: "{1}",
    explanation: `Using ${relevantServices[0] || 'monitoring tools'} and ${relevantServices[1] || 'logging services'} provides systematic visibility into ${primaryKeyword} issues. This data-driven approach enables precise identification and resolution of problems in ${moduleName} within ${topicName.toLowerCase()}.`
  };
}

// Generate architectural questions
function generateArchitecturalQuestion(moduleName: string, moduleDescription: string, topicName: string, context: any): GeneratedQuestion {
  const moduleKeywords = extractKeywords(moduleDescription || moduleName);
  const focusAreas = context.focus.split(',').map((f: string) => f.trim());
  
  // Build architectural context from module description
  const architecturalContext = moduleDescription 
    ? `incorporating ${moduleDescription.toLowerCase()}`
    : `implementing ${moduleName.toLowerCase()}`;
  
  const relevantServices = getRelevantServices(moduleKeywords, context.services);
  const primaryFocus = focusAreas[1] || focusAreas[0] || 'scalability';
  
  return {
    text: `How should ${moduleName} be architected for ${primaryFocus} while ${architecturalContext} in ${topicName.toLowerCase()}?`,
    options: [
      `Use single-point architecture without considering ${primaryFocus}`,
      `Design distributed architecture using ${relevantServices[0] || 'cloud services'}, ${relevantServices[1] || 'load balancing'}, and ${relevantServices[2] || 'auto-scaling'}`,
      `Avoid ${moduleName.toLowerCase()} in ${primaryFocus}-focused designs`,
      `Use legacy monolithic approach regardless of ${primaryFocus} requirements`
    ],
    correct_answer: "{1}",
    explanation: `Designing distributed architecture using ${relevantServices[0] || 'cloud services'}, ${relevantServices[1] || 'load balancing'}, and ${relevantServices[2] || 'auto-scaling'} ensures ${primaryFocus} while effectively ${architecturalContext}. This approach aligns with ${topicName.toLowerCase()} principles and modern cloud architecture patterns.`
  };
}

// Generate security-focused questions
function generateSecurityQuestion(moduleName: string, moduleDescription: string, topicName: string, context: any): GeneratedQuestion {
  const moduleKeywords = extractKeywords(moduleDescription || moduleName);
  const topicKeywords = extractKeywords(topicName);
  
  // Build security context from module description
  const securityContext = moduleDescription 
    ? `when ${moduleDescription.toLowerCase()}`
    : `in ${moduleName.toLowerCase()} implementations`;
  
  const relevantServices = getRelevantServices(['security', 'access', 'encryption'].concat(moduleKeywords), context.services);
  const securityAspect = moduleKeywords.find(keyword => 
    ['security', 'access', 'encryption', 'authentication', 'authorization', 'compliance'].includes(keyword)
  ) || 'security';
  
  return {
    text: `What is the recommended approach for ensuring ${securityAspect} ${securityContext} within ${topicName.toLowerCase()}?`,
    options: [
      `${securityAspect} is not required for ${moduleName.toLowerCase()}`,
      `Implement comprehensive ${securityAspect} using ${relevantServices[0] || 'IAM'} and ${relevantServices[1] || 'encryption services'} following industry standards`,
      `Use basic password protection without additional ${securityAspect} measures`,
      `Rely only on network-level ${securityAspect} controls`
    ],
    correct_answer: "{1}",
    explanation: `Implementing comprehensive ${securityAspect} using ${relevantServices[0] || 'IAM'} and ${relevantServices[1] || 'encryption services'} ensures robust protection for ${moduleName}. This approach addresses regulatory requirements and security best practices essential for ${topicName.toLowerCase()} implementations.`
  };
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { 
      certification_id, 
      certification_name,
      topic_id, 
      topic_name,
      topic_description,
      quiz_id, 
      modules = [] 
    } = body;

    // Validate required parameters
    if (!certification_id || !topic_id || !quiz_id) {
      return NextResponse.json(
        { error: 'Missing required parameters: certification_id, topic_id, quiz_id' },
        { status: 400 }
      );
    }

    if (!modules || modules.length === 0) {
      return NextResponse.json(
        { error: 'No modules provided' },
        { status: 400 }
      );
    }

    // Generate SQL script with 2 questions per module
    let sqlScript = `-- Generated SQL Script for Hub Questions\n`;
    sqlScript += `-- Certification ID: ${certification_id}\n`;
    sqlScript += `-- Topic ID: ${topic_id}\n`;
    sqlScript += `-- Quiz ID: ${quiz_id}\n`;
    sqlScript += `-- Generated on: ${new Date().toISOString()}\n\n`;
    sqlScript += `BEGIN;\n\n`;

    let questionIndex = 1;
    const quizQuestionLinks = [];

    for (const module of modules) {
      const { module_id, module_name } = module;
      
      sqlScript += `-- =====================\n`;
      sqlScript += `-- QUESTIONS - ${module_name}\n`;
      sqlScript += `-- =====================\n\n`;

      // Generate 2 questions per module
      for (let i = 1; i <= 2; i++) {
        const questionId = `q_${topic_id}_m_${module_id}_${i}`;
        
        // Generate contextual questions based on module and topic information
        const template = await generateContextualQuestion(
          module,
          body.topic_name,
          body.topic_description,
          body.certification_name,
          i
        );
        
        sqlScript += `INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)\n`;
        sqlScript += `VALUES ('${questionId}','${template.text}','mcq','${JSON.stringify(template.options)}'::json,'${template.correct_answer}','${template.explanation}',NOW(),'${quiz_id}',NOW(),${questionIndex},NULL,NULL,'${module_id}') ON CONFLICT (id) DO NOTHING;\n\n`;
        
        quizQuestionLinks.push(`(NOW(),'${quiz_id}','${questionId}')`);
        questionIndex++;
      }
    }

    // Add quiz-question links
    sqlScript += `-- =====================\n`;
    sqlScript += `-- Link questions to quiz\n`;
    sqlScript += `-- =====================\n`;
    sqlScript += `INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES\n`;
    sqlScript += ` ${quizQuestionLinks.join(',\n ')}\n`;
    sqlScript += `ON CONFLICT DO NOTHING;\n\n`;

    // Update question count
    sqlScript += `-- Update question count\n`;
    sqlScript += `UPDATE public.quiz q\n`;
    sqlScript += `SET questions = sub.cnt,\n`;
    sqlScript += `    modified_at = NOW()\n`;
    sqlScript += `FROM (\n`;
    sqlScript += `  SELECT quiz_id, COUNT(*)::int AS cnt\n`;
    sqlScript += `  FROM public.quiz_question\n`;
    sqlScript += `  WHERE quiz_id = '${quiz_id}'\n`;
    sqlScript += `  GROUP BY quiz_id\n`;
    sqlScript += `) sub\n`;
    sqlScript += `WHERE q.id = sub.quiz_id;\n\n`;
    sqlScript += `COMMIT;\n`;

    return NextResponse.json({
      success: true,
      sqlScript,
      questionCount: modules.length * 2,
      moduleCount: modules.length
    });

  } catch (error) {
    console.error('Error generating hub questions:', error);
    return NextResponse.json(
      { error: 'Failed to generate hub questions' },
      { status: 500 }
    );
  }
}
