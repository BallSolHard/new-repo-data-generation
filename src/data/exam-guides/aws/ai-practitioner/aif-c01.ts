import type { ExamGuide } from '@/lib/types/exam-guide';

export const aifC01: ExamGuide = {
  certificationCode: 'AWS Certified AI Practitioner',
  certificationName: 'AWS Certified AI Practitioner',
  provider: 'aws',
  version: 'AWS Certified AI Practitioner',
  effectiveDate: '2024-09-09',
  status: 'current',
  tier: 'foundational' as const,
  examFormat: {
    totalQuestions: 85,
    scoredQuestions: 65,
    unscoredQuestions: 20,
    duration: 120,
    passingScore: 700,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    // ─── Domain 1: Fundamentals of AI and ML (20%) ───
    {
      id: 'domain-1',
      name: 'Fundamentals of AI and ML',
      weightPercent: 20,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Explain basic AI concepts and terminologies',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'Differences between AI, machine learning, deep learning, and generative AI' },
            { id: 'ks-1.1.2', text: 'Types of machine learning: supervised, unsupervised, and reinforcement learning' },
            { id: 'ks-1.1.3', text: 'Key ML concepts: training, inference, model, dataset, features, labels' },
            { id: 'ks-1.1.4', text: 'Neural networks and their fundamental components' },
            { id: 'ks-1.1.5', text: 'Foundation models and large language models (LLMs)' },
            { id: 'ks-1.1.6', text: 'Common ML use cases: classification, regression, clustering, recommendation' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Treating AI and machine learning as interchangeable terms',
              whyWrong: 'AI is the broad concept of machines simulating human intelligence. ML is a subset of AI that uses statistical methods to learn from data. Deep learning is a subset of ML using neural networks. Understanding the hierarchy matters for exam questions.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Confusing supervised and unsupervised learning',
              whyWrong: 'Supervised learning uses labeled training data to predict outcomes. Unsupervised learning finds hidden patterns in unlabeled data. Using a supervised approach when labels are unavailable, or vice versa, leads to poor model outcomes.',
            },
            {
              id: 'ap-1.1-003',
              misconception: 'Assuming generative AI and discriminative AI are the same',
              whyWrong: 'Discriminative AI classifies or predicts from input data. Generative AI creates new content (text, images, code) by learning data distributions. Foundation models and LLMs are generative AI.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Identify practical use cases for AI',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'Business problems suitable for AI/ML solutions (NLP, computer vision, forecasting, anomaly detection)' },
            { id: 'ks-1.2.2', text: 'When AI/ML is appropriate vs. traditional programming' },
            { id: 'ks-1.2.3', text: 'AWS AI/ML service portfolio overview' },
            { id: 'ks-1.2.4', text: 'Responsible AI principles: fairness, transparency, privacy, robustness' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Applying ML to problems solvable by simple rule-based logic',
              whyWrong: 'ML adds complexity and cost. If a deterministic rule (e.g., "if temperature > 100, alert") solves the problem reliably, ML is unnecessary overhead. Use ML when patterns are too complex for explicit rules.',
            },
            {
              id: 'ap-1.2-002',
              misconception: 'Overlooking bias and fairness concerns when deploying AI models',
              whyWrong: 'AI models trained on biased data produce biased outcomes. Responsible AI requires evaluating datasets for representation and monitoring model outputs for discriminatory patterns before and after deployment.',
            },
          ],
        },
        {
          id: 'task-1.3',
          text: 'Describe the ML development lifecycle',
          knowledgeStatements: [
            { id: 'ks-1.3.1', text: 'ML pipeline stages: data collection, preprocessing, feature engineering, model training, evaluation, deployment, monitoring' },
            { id: 'ks-1.3.2', text: 'Training vs. inference and their respective resource requirements' },
            { id: 'ks-1.3.3', text: 'Model evaluation metrics: accuracy, precision, recall, F1, AUC-ROC, RMSE' },
            { id: 'ks-1.3.4', text: 'Overfitting, underfitting, and model generalization' },
            { id: 'ks-1.3.5', text: 'Iterative nature of ML model development' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.3-001',
              misconception: 'Optimizing for accuracy alone regardless of class imbalance',
              whyWrong: 'High accuracy on imbalanced datasets is misleading. A model predicting the majority class always achieves high accuracy but fails on the minority class. Use precision, recall, and F1 to better evaluate performance.',
            },
            {
              id: 'ap-1.3-002',
              misconception: 'Skipping data preprocessing and feature engineering',
              whyWrong: 'Model quality is directly proportional to data quality. Missing values, outliers, inconsistent encodings, and irrelevant features degrade model performance. Data preparation typically consumes 70-80% of ML project effort.',
            },
            {
              id: 'ap-1.3-003',
              misconception: 'Treating model deployment as the end of the ML lifecycle',
              whyWrong: 'Models in production degrade as data distributions shift (model drift). Continuous monitoring, retraining triggers, and performance evaluation are essential post-deployment activities.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker', category: 'Machine Learning' },
        { name: 'Amazon Rekognition', category: 'Machine Learning' },
        { name: 'Amazon Comprehend', category: 'Machine Learning' },
        { name: 'Amazon Translate', category: 'Machine Learning' },
        { name: 'Amazon Polly', category: 'Machine Learning' },
        { name: 'Amazon Transcribe', category: 'Machine Learning' },
        { name: 'Amazon Lex', category: 'Machine Learning' },
        { name: 'Amazon Textract', category: 'Machine Learning' },
        { name: 'Amazon Forecast', category: 'Machine Learning' },
        { name: 'Amazon Personalize', category: 'Machine Learning' },
        { name: 'Amazon Kendra', category: 'Machine Learning' },
        { name: 'AWS DeepRacer', category: 'Machine Learning' },
      ],
    },

    // ─── Domain 2: Fundamentals of Generative AI (24%) ───
    {
      id: 'domain-2',
      name: 'Fundamentals of Generative AI',
      weightPercent: 24,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Explain the basic concepts of generative AI',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'Foundation models and large language models (LLMs): architecture, training, and capabilities' },
            { id: 'ks-2.1.2', text: 'Tokens, tokenization, and context windows' },
            { id: 'ks-2.1.3', text: 'Prompt engineering techniques: zero-shot, few-shot, chain-of-thought' },
            { id: 'ks-2.1.4', text: 'Inference parameters: temperature, top-p, top-k, max tokens' },
            { id: 'ks-2.1.5', text: 'Generative AI modalities: text, image, audio, video, code generation' },
            { id: 'ks-2.1.6', text: 'Hallucinations and their causes in LLMs' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Setting temperature to 0 for all generative AI use cases',
              whyWrong: 'Temperature 0 produces deterministic, highly focused output — appropriate for factual Q&A or code generation. Creative writing or brainstorming benefits from higher temperatures. One-size-fits-all inference parameters produce suboptimal results.',
            },
            {
              id: 'ap-2.1-002',
              misconception: 'Trusting LLM outputs without validation for factual or high-stakes tasks',
              whyWrong: 'LLMs hallucinate — generating plausible-sounding but incorrect information. For high-stakes applications (medical, legal, financial), human review, RAG with grounded sources, or output validation are mandatory.',
            },
            {
              id: 'ap-2.1-003',
              misconception: 'Ignoring context window limits when processing long documents',
              whyWrong: 'LLMs have finite context windows (e.g., 4K to 200K tokens). Content exceeding the window is truncated or ignored, leading to incomplete responses. Use chunking strategies or models with larger context windows.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Understand the capabilities and limitations of generative AI for solving business problems',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'Generative AI use cases: summarization, Q&A, content generation, code generation, translation, sentiment analysis' },
            { id: 'ks-2.2.2', text: 'Retrieval-augmented generation (RAG) and its benefits' },
            { id: 'ks-2.2.3', text: 'Fine-tuning vs. prompt engineering vs. RAG tradeoffs' },
            { id: 'ks-2.2.4', text: 'Generative AI limitations: knowledge cutoff, hallucinations, context limits, cost' },
            { id: 'ks-2.2.5', text: 'Agents and tool use for agentic AI workflows' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Fine-tuning a foundation model when prompt engineering or RAG would suffice',
              whyWrong: 'Fine-tuning is expensive and time-consuming, requiring curated training data and compute. For most use cases, well-designed prompts or RAG provide sufficient quality at a fraction of the cost.',
            },
            {
              id: 'ap-2.2-002',
              misconception: 'Using a base model for enterprise chat without grounding it in company-specific knowledge',
              whyWrong: 'Base models have a training knowledge cutoff and no access to proprietary data. Without RAG or fine-tuning, responses will miss internal context, leading to generic and potentially incorrect answers.',
            },
          ],
        },
        {
          id: 'task-2.3',
          text: 'Describe AWS infrastructure and technologies for building generative AI applications',
          knowledgeStatements: [
            { id: 'ks-2.3.1', text: 'Amazon Bedrock: managed foundation models, model APIs, knowledge bases' },
            { id: 'ks-2.3.2', text: 'Amazon SageMaker JumpStart for deploying pre-trained models' },
            { id: 'ks-2.3.3', text: 'AWS generative AI accelerators (AWS Trainium, AWS Inferentia)' },
            { id: 'ks-2.3.4', text: 'Vector databases and embeddings for RAG use cases (Amazon OpenSearch, pgvector)' },
            { id: 'ks-2.3.5', text: 'Amazon Q for business productivity and developer assistance' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.3-001',
              misconception: 'Self-hosting and managing LLMs instead of using Amazon Bedrock',
              whyWrong: 'Self-hosting requires significant compute, security, and operational overhead. Amazon Bedrock provides serverless access to leading foundation models (Anthropic Claude, Meta Llama, etc.) with no infrastructure management.',
            },
            {
              id: 'ap-2.3-002',
              misconception: 'Using generic key-value storage for RAG knowledge bases instead of vector databases',
              whyWrong: 'RAG requires semantic similarity search across vector embeddings. Key-value stores only support exact-match lookups. Vector databases (OpenSearch with k-NN, pgvector) are required for efficient embedding retrieval.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Bedrock', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Knowledge Bases', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Agents', category: 'Machine Learning' },
        { name: 'Amazon SageMaker JumpStart', category: 'Machine Learning' },
        { name: 'Amazon Q Business', category: 'Machine Learning' },
        { name: 'Amazon Q Developer', category: 'Machine Learning' },
        { name: 'AWS Trainium', category: 'Machine Learning' },
        { name: 'AWS Inferentia', category: 'Machine Learning' },
        { name: 'Amazon OpenSearch Service (vector search)', category: 'Analytics' },
        { name: 'Amazon Aurora (pgvector)', category: 'Database' },
      ],
    },

    // ─── Domain 3: Applications of Foundation Models (28%) ───
    {
      id: 'domain-3',
      name: 'Applications of Foundation Models',
      weightPercent: 28,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Describe design considerations for foundation model-based applications',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'Model selection criteria: capability, latency, cost, context window, modality' },
            { id: 'ks-3.1.2', text: 'Model customization approaches: continued pre-training, fine-tuning, RLHF, prompt engineering' },
            { id: 'ks-3.1.3', text: 'Evaluation of foundation model outputs: human evaluation, automated metrics (BLEU, ROUGE)' },
            { id: 'ks-3.1.4', text: 'Multi-modal models and their use cases' },
            { id: 'ks-3.1.5', text: 'Cost and latency tradeoffs across model sizes' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Always choosing the largest, most powerful model for every task',
              whyWrong: 'Larger models cost more per token and have higher latency. For simple classification or short text generation, smaller, faster models achieve comparable accuracy at significantly lower cost.',
            },
            {
              id: 'ap-3.1-002',
              misconception: 'Relying solely on automated metrics (BLEU, ROUGE) to evaluate generative model quality',
              whyWrong: 'BLEU and ROUGE measure n-gram overlap, which does not capture semantic quality, coherence, or factual accuracy. Human evaluation or LLM-as-judge approaches are necessary for comprehensive quality assessment.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Choose effective prompt engineering techniques',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'Prompt structure: system prompts, human turns, assistant turns' },
            { id: 'ks-3.2.2', text: 'Prompt techniques: zero-shot, one-shot, few-shot, chain-of-thought, ReAct' },
            { id: 'ks-3.2.3', text: 'Prompt injection and jailbreaking risks' },
            { id: 'ks-3.2.4', text: 'Output formatting: structured JSON output, XML tags' },
            { id: 'ks-3.2.5', text: 'Iterative prompt refinement and testing' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Writing vague, ambiguous prompts and expecting precise outputs',
              whyWrong: 'LLMs follow instructions literally. Ambiguous prompts produce inconsistent results. Clear, specific instructions with examples (few-shot) and output format specifications dramatically improve response quality.',
            },
            {
              id: 'ap-3.2-002',
              misconception: 'Not guarding against prompt injection attacks in user-facing applications',
              whyWrong: 'Prompt injection allows malicious users to override system instructions by embedding commands in their input. Applications must sanitize user inputs and use robust system prompts to prevent instruction hijacking.',
            },
          ],
        },
        {
          id: 'task-3.3',
          text: 'Describe the training and fine-tuning process for foundation models',
          knowledgeStatements: [
            { id: 'ks-3.3.1', text: 'Pre-training, fine-tuning, and instruction tuning concepts' },
            { id: 'ks-3.3.2', text: 'Parameter-efficient fine-tuning (PEFT) techniques: LoRA, QLoRA' },
            { id: 'ks-3.3.3', text: 'Training data requirements: volume, quality, diversity' },
            { id: 'ks-3.3.4', text: 'Amazon Bedrock fine-tuning and continued pre-training capabilities' },
            { id: 'ks-3.3.5', text: 'When to fine-tune vs. use RAG vs. prompt engineering' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.3-001',
              misconception: 'Fine-tuning on a small, low-quality dataset expecting significant improvement',
              whyWrong: 'Fine-tuning quality is proportional to training data quality and diversity. Small or biased datasets cause overfitting or amplify existing model biases rather than improving performance.',
            },
          ],
        },
        {
          id: 'task-3.4',
          text: 'Describe methods to evaluate foundation model performance',
          knowledgeStatements: [
            { id: 'ks-3.4.1', text: 'Evaluation dimensions: accuracy, toxicity, bias, relevance, coherence, groundedness' },
            { id: 'ks-3.4.2', text: 'Amazon Bedrock model evaluation features' },
            { id: 'ks-3.4.3', text: 'A/B testing and shadow deployment for model evaluation' },
            { id: 'ks-3.4.4', text: 'Guardrails for content filtering and safe outputs (Amazon Bedrock Guardrails)' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.4-001',
              misconception: 'Deploying a foundation model application without content moderation guardrails',
              whyWrong: 'Without guardrails, LLMs can generate harmful, biased, or off-topic content. Amazon Bedrock Guardrails provide configurable content filters, PII redaction, and topic denial lists to enforce safe and responsible usage.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Bedrock', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Guardrails', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Model Evaluation', category: 'Machine Learning' },
        { name: 'Amazon SageMaker', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Clarify', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Knowledge Bases', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Agents', category: 'Machine Learning' },
      ],
    },

    // ─── Domain 4: Guidelines for Responsible AI (14%) ───
    {
      id: 'domain-4',
      name: 'Guidelines for Responsible AI',
      weightPercent: 14,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Explain the development of AI systems that are responsible',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'Responsible AI dimensions: fairness, explainability, privacy, robustness, governance, transparency' },
            { id: 'ks-4.1.2', text: 'Bias in AI: sources (data, algorithmic, human), detection, and mitigation' },
            { id: 'ks-4.1.3', text: 'Explainable AI (XAI) and model interpretability' },
            { id: 'ks-4.1.4', text: 'Data privacy and PII handling in AI systems' },
            { id: 'ks-4.1.5', text: 'Human oversight and human-in-the-loop patterns' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Treating responsible AI as an afterthought rather than a design principle',
              whyWrong: 'Retrofitting fairness, explainability, and privacy into existing AI systems is significantly harder and more expensive than building them in from the start. Responsible AI must be integrated throughout the ML lifecycle.',
            },
            {
              id: 'ap-4.1-002',
              misconception: 'Deploying AI in high-stakes decisions without human oversight',
              whyWrong: 'AI models make errors. In domains like healthcare, lending, or legal decisions, unchecked AI can cause significant harm. Human-in-the-loop patterns ensure accountability and allow error correction.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Recognize the importance of transparent and explainable models',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'Differences between transparent models (decision trees) and black-box models (deep neural networks)' },
            { id: 'ks-4.2.2', text: 'Post-hoc explainability techniques: SHAP values, feature importance' },
            { id: 'ks-4.2.3', text: 'AWS tools for model explainability: SageMaker Clarify' },
            { id: 'ks-4.2.4', text: 'Regulatory requirements for AI explainability (GDPR, financial regulations)' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Choosing black-box models for regulated industries without explainability requirements planning',
              whyWrong: 'Regulations like GDPR require organizations to explain automated decisions. Deep learning models without explainability tooling (e.g., SHAP, SageMaker Clarify) cannot satisfy these requirements.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker Clarify', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Guardrails', category: 'Machine Learning' },
        { name: 'AWS Audit Manager', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Macie', category: 'Security, Identity, & Compliance' },
      ],
    },

    // ─── Domain 5: Security, Compliance, and Governance for AI Solutions (14%) ───
    {
      id: 'domain-5',
      name: 'Security, Compliance, and Governance for AI Solutions',
      weightPercent: 14,
      tasks: [
        {
          id: 'task-5.1',
          text: 'Explain methods to secure AI systems',
          knowledgeStatements: [
            { id: 'ks-5.1.1', text: 'IAM roles and policies for access control to AI/ML services' },
            { id: 'ks-5.1.2', text: 'Encryption of training data, model artifacts, and inference inputs/outputs' },
            { id: 'ks-5.1.3', text: 'VPC configurations for private model endpoints' },
            { id: 'ks-5.1.4', text: 'Threat vectors specific to AI: data poisoning, model inversion, adversarial attacks' },
            { id: 'ks-5.1.5', text: 'Prompt injection and jailbreaking mitigations' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.1-001',
              misconception: 'Using public endpoints for SageMaker inference in compliance-sensitive environments',
              whyWrong: 'Public inference endpoints expose model APIs to the internet. For sensitive data, deploy SageMaker endpoints within a VPC with private endpoints, and use resource-based policies to restrict access.',
            },
          ],
        },
        {
          id: 'task-5.2',
          text: 'Recognize governance and compliance regulations for AI systems',
          knowledgeStatements: [
            { id: 'ks-5.2.1', text: 'AI governance frameworks: model cards, datasheets, audit logs' },
            { id: 'ks-5.2.2', text: 'Compliance considerations for AI in regulated industries (healthcare, finance, EU AI Act)' },
            { id: 'ks-5.2.3', text: 'Data governance: lineage tracking, consent management, data minimization' },
            { id: 'ks-5.2.4', text: 'Model risk management and documentation' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.2-001',
              misconception: 'Treating AI governance as optional for internal-only tools',
              whyWrong: 'Even internal AI tools can affect employees through biased hiring recommendations or performance evaluations. Governance, documentation, and audit trails are best practices regardless of whether the tool is customer-facing.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS IAM', category: 'Security, Identity, & Compliance' },
        { name: 'AWS KMS', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon VPC', category: 'Networking & Content Delivery' },
        { name: 'AWS CloudTrail', category: 'Management & Governance' },
        { name: 'AWS Config', category: 'Management & Governance' },
        { name: 'Amazon SageMaker Role Manager', category: 'Machine Learning' },
        { name: 'Amazon Bedrock Guardrails', category: 'Machine Learning' },
        { name: 'AWS Audit Manager', category: 'Security, Identity, & Compliance' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Writing ML model code or algorithms from scratch',
    'Advanced neural network architecture design',
    'MLOps pipeline implementation details',
    'Detailed Kubernetes or container orchestration for ML',
    'Advanced mathematical concepts (linear algebra, calculus for ML)',
    'Specific cloud architecture design patterns (covered in associate/professional certs)',
    'Detailed pricing calculations for ML services',
  ],
};
