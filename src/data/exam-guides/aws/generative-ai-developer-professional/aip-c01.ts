import type { ExamGuide } from '@/lib/types/exam-guide';

export const aipC01: ExamGuide = {
  certificationCode: 'AIP-C01',
  certificationName: 'AWS Certified Generative AI Developer - Professional',
  provider: 'aws',
  version: 'AIP-C01',
  effectiveDate: '2025-04-01',
  status: 'current',
  tier: 'professional' as const,
  examFormat: {
    totalQuestions: 85,
    scoredQuestions: 65,
    unscoredQuestions: 20,
    duration: 170,
    passingScore: 750,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    // ─── Domain 1: Fundamentals of Generative AI and AWS Services (16%) ───
    {
      id: 'domain-1',
      name: 'Fundamentals of Generative AI and AWS Services',
      weightPercent: 16,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Explain core generative AI concepts and their AWS implementations',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'Foundation models (FMs): transformer architecture, pre-training, fine-tuning, inference' },
            { id: 'ks-1.1.2', text: 'Large language models (LLMs): tokens, context window, temperature, top-p, top-k' },
            { id: 'ks-1.1.3', text: 'Embedding models and vector representations for semantic search' },
            { id: 'ks-1.1.4', text: 'Multimodal models: text, image, audio, and video generation and understanding' },
            { id: 'ks-1.1.5', text: 'Amazon Bedrock: managed FM access, model catalog, on-demand and provisioned throughput' },
            { id: 'ks-1.1.6', text: 'Amazon SageMaker JumpStart for FM deployment and fine-tuning' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Treating all generative AI tasks as interchangeable regardless of model size and type',
              whyWrong: 'Different tasks require different model capabilities: small models for classification/extraction, large models for complex reasoning, multimodal models for image understanding. Matching model to task optimizes cost, latency, and quality.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Select the appropriate AWS services and FM for a generative AI use case',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'Amazon Bedrock model selection: Anthropic Claude, Amazon Titan, Meta Llama, Cohere, Mistral, Stability AI' },
            { id: 'ks-1.2.2', text: 'Cost-performance tradeoffs: model size, throughput modes, inference profiles' },
            { id: 'ks-1.2.3', text: 'Cross-Region inference for latency optimization and capacity management' },
            { id: 'ks-1.2.4', text: 'Amazon Q for enterprise applications (Business, Developer, Connect variants)' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Always choosing the largest available model for production workloads',
              whyWrong: 'Larger models have higher per-token cost and latency. Many production tasks (summarization, classification, extraction) perform equally well with smaller, faster models. Benchmark multiple model sizes before selecting.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Bedrock', category: 'Machine Learning' },
        { name: 'Amazon SageMaker JumpStart', category: 'Machine Learning' },
        { name: 'Amazon Q Business', category: 'Machine Learning' },
        { name: 'Amazon Q Developer', category: 'Developer Tools' },
      ],
    },

    // ─── Domain 2: Prompt Engineering (20%) ───
    {
      id: 'domain-2',
      name: 'Design and Implement Prompt Engineering Solutions',
      weightPercent: 20,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Apply prompt engineering techniques to improve model outputs',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'Zero-shot, one-shot, and few-shot prompting strategies' },
            { id: 'ks-2.1.2', text: 'Chain-of-thought (CoT) and tree-of-thoughts prompting for complex reasoning' },
            { id: 'ks-2.1.3', text: 'Role prompting, persona assignment, and instruction framing' },
            { id: 'ks-2.1.4', text: 'Output formatting: JSON mode, structured outputs, XML tags, delimiters' },
            { id: 'ks-2.1.5', text: 'System prompts vs. user prompts vs. assistant prefills in chat APIs' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Using vague or ambiguous instructions in production prompts',
              whyWrong: 'Ambiguous prompts produce inconsistent outputs at scale. Production prompts should be precise, include explicit constraints, specify output format (e.g., "respond only with valid JSON"), and be versioned and tested like code.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Implement prompt templates and manage prompt versioning',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'Amazon Bedrock Prompt Management: prompt templates, versions, and A/B testing' },
            { id: 'ks-2.2.2', text: 'Dynamic prompt construction with variable injection and context windows' },
            { id: 'ks-2.2.3', text: 'Prompt caching for latency reduction and cost optimization' },
            { id: 'ks-2.2.4', text: 'Token budget management: prompt compression, summarization, and context management' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Hardcoding prompts directly in application code without versioning',
              whyWrong: 'Hardcoded prompts cannot be updated without code deployments, cannot be A/B tested, and cannot be audited. Use Amazon Bedrock Prompt Management or a dedicated prompt registry to version, test, and deploy prompts independently of application code.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Bedrock (Prompt Management)', category: 'Machine Learning' },
        { name: 'Amazon Bedrock (Inference API)', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Playgrounds', category: 'Machine Learning' },
      ],
    },

    // ─── Domain 3: Retrieval-Augmented Generation (RAG) (22%) ───
    {
      id: 'domain-3',
      name: 'Design and Implement Retrieval-Augmented Generation (RAG)',
      weightPercent: 22,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Design and build knowledge bases for RAG applications',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'RAG architecture: data ingestion, chunking, embedding, vector store, retrieval, augmentation, generation' },
            { id: 'ks-3.1.2', text: 'Amazon Bedrock Knowledge Bases: managed RAG with S3, chunking strategies, embedding models' },
            { id: 'ks-3.1.3', text: 'Vector stores: Amazon OpenSearch Serverless, Aurora pgvector, Pinecone, Weaviate' },
            { id: 'ks-3.1.4', text: 'Chunking strategies: fixed-size, semantic, hierarchical, sentence-window' },
            { id: 'ks-3.1.5', text: 'Embedding model selection: Amazon Titan Embeddings, Cohere Embed' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Using very large chunk sizes for all document types',
              whyWrong: 'Overly large chunks dilute relevance by including too much irrelevant context, inflating token usage. Overly small chunks lose coherent meaning. Optimal chunk size depends on document structure: technical docs benefit from smaller precise chunks; narrative docs may need larger semantic chunks.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Optimize retrieval strategies for RAG accuracy and efficiency',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'Semantic search vs. keyword search vs. hybrid retrieval strategies' },
            { id: 'ks-3.2.2', text: 'Re-ranking and relevance scoring for retrieved documents' },
            { id: 'ks-3.2.3', text: 'Metadata filtering to narrow vector search scope' },
            { id: 'ks-3.2.4', text: 'Query transformation: HyDE, step-back prompting, multi-query expansion' },
            { id: 'ks-3.2.5', text: 'RAG evaluation metrics: faithfulness, answer relevance, context precision/recall' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Relying solely on vector similarity search without metadata filtering',
              whyWrong: 'Pure vector search can retrieve semantically similar but contextually irrelevant documents (e.g., documents from the wrong time period or customer). Combine metadata filters (date, category, access level) with semantic search for precise, relevant retrieval.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Bedrock Knowledge Bases', category: 'Machine Learning' },
        { name: 'Amazon OpenSearch Serverless (Vector Engine)', category: 'Analytics' },
        { name: 'Amazon Aurora (pgvector)', category: 'Database' },
        { name: 'Amazon S3 (Data Source)', category: 'Storage' },
        { name: 'Amazon Kendra', category: 'Machine Learning' },
      ],
    },

    // ─── Domain 4: Agents and Multi-Step Reasoning (20%) ───
    {
      id: 'domain-4',
      name: 'Build and Orchestrate Generative AI Agents',
      weightPercent: 20,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Design and build AI agents using Amazon Bedrock Agents',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'Amazon Bedrock Agents: agent executor, action groups, knowledge bases, Lambda integration' },
            { id: 'ks-4.1.2', text: 'Action group design: API schema (OpenAPI), Lambda function handlers' },
            { id: 'ks-4.1.3', text: 'ReAct (Reasoning + Acting) pattern for agent decision loops' },
            { id: 'ks-4.1.4', text: 'Multi-agent collaboration: supervisor agents, subagents, and orchestration patterns' },
            { id: 'ks-4.1.5', text: 'Session context management, memory retention across turns' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Building a single monolithic agent to handle all tasks in a complex workflow',
              whyWrong: 'Monolithic agents have larger context windows (higher cost), less focused reasoning, harder debugging, and reduced reliability. Multi-agent architectures with specialized subagents are more efficient, maintainable, and accurate for complex workflows.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Implement tool use and function calling in generative AI applications',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'Tool/function calling in Bedrock Converse API: tool definitions, tool results' },
            { id: 'ks-4.2.2', text: 'Guardrails for agents: input/output filtering, topic denial, grounding' },
            { id: 'ks-4.2.3', text: 'Code interpreter action group for data analysis and computation' },
            { id: 'ks-4.2.4', text: 'Return-of-control (RoC) for human-in-the-loop workflows' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Granting agents excessive permissions for tool use without considering blast radius',
              whyWrong: 'Agents with broad permissions can execute destructive actions if a prompt injection attack or hallucination causes an unintended tool call. Apply least-privilege to agent Lambda execution roles and use resource-based policy conditions to scope allowed operations.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Bedrock Agents', category: 'Machine Learning' },
        { name: 'AWS Lambda (Agent Action Groups)', category: 'Compute' },
        { name: 'Amazon Bedrock Guardrails', category: 'Machine Learning' },
        { name: 'Amazon DynamoDB (Agent Memory)', category: 'Database' },
      ],
    },

    // ─── Domain 5: Customization and Fine-Tuning (12%) ───
    {
      id: 'domain-5',
      name: 'Customize and Fine-Tune Foundation Models',
      weightPercent: 12,
      tasks: [
        {
          id: 'task-5.1',
          text: 'Select the appropriate model customization approach',
          knowledgeStatements: [
            { id: 'ks-5.1.1', text: 'Customization options: prompt engineering, RAG, fine-tuning, continued pre-training' },
            { id: 'ks-5.1.2', text: 'Amazon Bedrock fine-tuning: instruction-based fine-tuning (RLHF), datasets, epochs' },
            { id: 'ks-5.1.3', text: 'Amazon Bedrock Model Evaluation for selecting and comparing models' },
            { id: 'ks-5.1.4', text: 'SageMaker Training Jobs for custom model training with PEFT (LoRA, QLoRA)' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.1-001',
              misconception: 'Fine-tuning a model when RAG would be more appropriate',
              whyWrong: 'Fine-tuning teaches a model new skills and styles but is expensive, requires curated datasets, and cannot incorporate real-time knowledge. RAG is preferred for grounding responses in frequently updated proprietary documents. Fine-tune for consistent behavior changes; use RAG for dynamic knowledge.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Bedrock (Fine-Tuning)', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Model Evaluation', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Training', category: 'Machine Learning' },
        { name: 'Amazon S3 (Training Data)', category: 'Storage' },
      ],
    },

    // ─── Domain 6: Responsible AI and Governance (10%) ───
    {
      id: 'domain-6',
      name: 'Responsible AI, Security, and Governance',
      weightPercent: 10,
      tasks: [
        {
          id: 'task-6.1',
          text: 'Implement safety, governance, and responsible AI practices',
          knowledgeStatements: [
            { id: 'ks-6.1.1', text: 'Amazon Bedrock Guardrails: topic denial, content filters, PII redaction, grounding, word filters' },
            { id: 'ks-6.1.2', text: 'Prompt injection detection and prevention strategies' },
            { id: 'ks-6.1.3', text: 'Hallucination mitigation: grounding, citation-based responses, RAG with Guardrails' },
            { id: 'ks-6.1.4', text: 'Bias detection and fairness considerations in generative AI outputs' },
            { id: 'ks-6.1.5', text: 'Amazon Bedrock Model Invocation Logging for audit and compliance' },
          ],
          antiPatterns: [
            {
              id: 'ap-6.1-001',
              misconception: 'Deploying a generative AI application without Guardrails in production',
              whyWrong: 'Without guardrails, models can generate harmful content, respond to off-topic queries, leak PII, or be manipulated via prompt injection. Amazon Bedrock Guardrails provides multi-layer protection independent of the underlying model.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Bedrock Guardrails', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Model Invocation Logging', category: 'Machine Learning' },
        { name: 'AWS IAM (Model Access)', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon CloudWatch (Bedrock Metrics)', category: 'Management & Governance' },
        { name: 'AWS PrivateLink (Bedrock VPC Endpoint)', category: 'Networking & Content Delivery' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Basic ML concepts without generative AI context (covered in AIF-C01)',
    'ML training infrastructure details (covered in MLA-C01 and MLS-C01)',
    'General cloud practitioner concepts',
    'Advanced networking architecture (covered in ANS-C01)',
  ],
};
