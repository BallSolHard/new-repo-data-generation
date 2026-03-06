import type { ExamGuide } from '@/lib/types/exam-guide';

export const dvaC02: ExamGuide = {
  certificationCode: 'DVA-C02',
  certificationName: 'AWS Certified Developer - Associate',
  provider: 'aws',
  version: 'DVA-C02',
  effectiveDate: '2023-03-28',
  status: 'current',
  tier: 'associate' as const,
  examFormat: {
    totalQuestions: 65,
    scoredQuestions: 50,
    unscoredQuestions: 15,
    duration: 130,
    passingScore: 720,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    // ─── Domain 1: Development with AWS Services (32%) ───
    {
      id: 'domain-1',
      name: 'Development with AWS Services',
      weightPercent: 32,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Develop code for applications hosted on AWS',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'AWS SDK usage: authentication, pagination, error handling, retries with exponential backoff' },
            { id: 'ks-1.1.2', text: 'Lambda function development: handlers, context, events, environment variables, execution roles' },
            { id: 'ks-1.1.3', text: 'Lambda best practices: function sizing, timeout configuration, cold start optimization' },
            { id: 'ks-1.1.4', text: 'Lambda concurrency: reserved concurrency, provisioned concurrency, burst limits' },
            { id: 'ks-1.1.5', text: 'API Gateway: REST APIs, HTTP APIs, WebSocket APIs, stages, deployment, throttling' },
            { id: 'ks-1.1.6', text: 'Amazon ECS and EKS for containerized applications' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Initializing AWS SDK clients inside the Lambda handler function',
              whyWrong: 'Initializing clients inside the handler creates new connections on every invocation. Move initialization to the global scope (outside the handler) to reuse connections across warm invocations, reducing latency and overhead.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Not implementing exponential backoff and jitter for retries',
              whyWrong: 'Retrying immediately on failure can amplify load on a struggling service. Exponential backoff with jitter spreads retry attempts over time, preventing retry storms and allowing the downstream service to recover.',
            },
            {
              id: 'ap-1.1-003',
              misconception: 'Setting Lambda timeout too high for all functions',
              whyWrong: 'Overly generous timeouts allow hung functions to consume concurrency budget and incur unnecessary cost. Set timeouts based on expected execution time plus reasonable buffer, not the maximum 15 minutes.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Develop code for AWS Lambda',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'Lambda event sources and triggers: S3, DynamoDB Streams, Kinesis, SQS, SNS, API Gateway, EventBridge' },
            { id: 'ks-1.2.2', text: 'Lambda destinations for async invocation success/failure routing' },
            { id: 'ks-1.2.3', text: 'Lambda layers for code reuse and dependency management' },
            { id: 'ks-1.2.4', text: 'Lambda function URLs and testing locally with SAM CLI' },
            { id: 'ks-1.2.5', text: 'Lambda power tuning and memory configuration for cost-performance optimization' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Using SQS as a Lambda trigger without configuring a dead-letter queue',
              whyWrong: 'Failed Lambda processing of SQS messages retries until the visibility timeout expires. Without a DLQ, poison-pill messages continuously retry and block the queue. Configure a DLQ to isolate failed messages for investigation.',
            },
            {
              id: 'ap-1.2-002',
              misconception: 'Packaging large ML libraries or unnecessary dependencies in Lambda deployment packages',
              whyWrong: 'Lambda has a 250 MB deployment package limit (unzipped). Large packages increase cold start times significantly. Use Lambda layers for shared libraries, and use container image deployments (up to 10 GB) for large dependencies.',
            },
          ],
        },
        {
          id: 'task-1.3',
          text: 'Use data stores in application development',
          knowledgeStatements: [
            { id: 'ks-1.3.1', text: 'DynamoDB: data modeling, partition keys, sort keys, GSIs, LSIs, query vs. scan' },
            { id: 'ks-1.3.2', text: 'DynamoDB Streams for change data capture' },
            { id: 'ks-1.3.3', text: 'Amazon S3 for object storage: presigned URLs, multipart upload, S3 Select' },
            { id: 'ks-1.3.4', text: 'Amazon ElastiCache (Redis, Memcached) for caching patterns' },
            { id: 'ks-1.3.5', text: 'RDS and Aurora for relational data, connection pooling with RDS Proxy' },
            { id: 'ks-1.3.6', text: 'Amazon SQS and SNS for asynchronous communication patterns' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.3-001',
              misconception: 'Using DynamoDB Scan for filtering large tables instead of Query',
              whyWrong: 'Scan reads every item in the table, consuming significant RCUs. Query uses the partition key (and optionally sort key) to retrieve items efficiently. Design access patterns first and create GSIs to support them.',
            },
            {
              id: 'ap-1.3-002',
              misconception: 'Opening new database connections from Lambda on every invocation',
              whyWrong: 'Lambda functions can scale to thousands of concurrent instances, each opening a new database connection, exhausting RDS connection limits. Use RDS Proxy to pool and reuse connections across Lambda invocations.',
            },
            {
              id: 'ap-1.3-003',
              misconception: 'Using hot partition keys in DynamoDB that route all traffic to a single partition',
              whyWrong: 'DynamoDB partitions are limited to 3,000 RCUs and 1,000 WCUs per second. Hot partitions caused by non-uniform access (e.g., using status codes or dates as partition keys) cause throttling. Design for uniform distribution.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Lambda', category: 'Compute' },
        { name: 'Amazon API Gateway', category: 'Networking & Content Delivery' },
        { name: 'Amazon DynamoDB', category: 'Database' },
        { name: 'Amazon DynamoDB Accelerator (DAX)', category: 'Database' },
        { name: 'Amazon SQS', category: 'Application Integration' },
        { name: 'Amazon SNS', category: 'Application Integration' },
        { name: 'Amazon S3', category: 'Storage' },
        { name: 'Amazon ElastiCache', category: 'Database' },
        { name: 'Amazon RDS Proxy', category: 'Database' },
        { name: 'Amazon Kinesis Data Streams', category: 'Analytics' },
        { name: 'Amazon EventBridge', category: 'Application Integration' },
        { name: 'AWS Step Functions', category: 'Application Integration' },
        { name: 'Amazon ECS', category: 'Containers' },
        { name: 'Amazon EKS', category: 'Containers' },
        { name: 'AWS App Runner', category: 'Compute' },
      ],
    },

    // ─── Domain 2: Security (26%) ───
    {
      id: 'domain-2',
      name: 'Security',
      weightPercent: 26,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Implement authentication and authorization for applications and AWS services',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'Amazon Cognito User Pools for user authentication (JWT tokens, OAuth 2.0, OIDC)' },
            { id: 'ks-2.1.2', text: 'Amazon Cognito Identity Pools for temporary AWS credential vending' },
            { id: 'ks-2.1.3', text: 'IAM roles for compute services (Lambda, EC2, ECS task roles)' },
            { id: 'ks-2.1.4', text: 'API Gateway authorization: IAM, Lambda authorizers, Cognito User Pool authorizers' },
            { id: 'ks-2.1.5', text: 'STS AssumeRole for temporary credentials and cross-account access' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Confusing Cognito User Pools and Identity Pools in authentication flows',
              whyWrong: 'User Pools handle app-level authentication (sign-up, sign-in, JWT tokens). Identity Pools exchange tokens (including third-party provider tokens) for temporary IAM credentials. They serve distinct purposes and can be used together.',
            },
            {
              id: 'ap-2.1-002',
              misconception: 'Hardcoding IAM access keys in application code or configuration files',
              whyWrong: 'Hardcoded credentials risk exposure via version control, logs, or process inspection. Use IAM roles for AWS services, the credential provider chain in the SDK, and Secrets Manager for non-AWS service credentials.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Implement encryption by using AWS services',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'AWS KMS: GenerateDataKey, Encrypt/Decrypt, envelope encryption pattern' },
            { id: 'ks-2.2.2', text: 'AWS Secrets Manager for secrets storage, rotation, and retrieval in code' },
            { id: 'ks-2.2.3', text: 'SSM Parameter Store (SecureString) for configuration and secrets' },
            { id: 'ks-2.2.4', text: 'S3 client-side and server-side encryption options' },
            { id: 'ks-2.2.5', text: 'TLS/HTTPS enforcement for data in transit' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Using SSM Parameter Store SecureString for secrets requiring rotation',
              whyWrong: 'Parameter Store does not support automatic secret rotation. Use Secrets Manager for credentials requiring automatic rotation (e.g., database passwords). Use Parameter Store for non-sensitive configuration or static secrets.',
            },
          ],
        },
        {
          id: 'task-2.3',
          text: 'Manage sensitive data in application code',
          knowledgeStatements: [
            { id: 'ks-2.3.1', text: 'Lambda environment variable encryption at rest' },
            { id: 'ks-2.3.2', text: 'Avoiding secret exposure in Lambda logs and environment variables' },
            { id: 'ks-2.3.3', text: 'IAM policy conditions and resource-based policies' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.3-001',
              misconception: 'Logging full request/response bodies containing sensitive data for debugging',
              whyWrong: 'Logging PII, credentials, or payment information in CloudWatch Logs creates compliance violations and data breach risk. Redact sensitive fields before logging and use structured logging to control log verbosity.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Cognito', category: 'Security, Identity, & Compliance' },
        { name: 'AWS IAM', category: 'Security, Identity, & Compliance' },
        { name: 'AWS STS', category: 'Security, Identity, & Compliance' },
        { name: 'AWS KMS', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Secrets Manager', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Systems Manager Parameter Store', category: 'Management & Governance' },
        { name: 'Amazon API Gateway (authorizers)', category: 'Networking & Content Delivery' },
        { name: 'AWS WAF', category: 'Security, Identity, & Compliance' },
      ],
    },

    // ─── Domain 3: Deployment (24%) ───
    {
      id: 'domain-3',
      name: 'Deployment',
      weightPercent: 24,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Prepare application artifacts to be deployed to AWS',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'Docker container packaging and deployment to Amazon ECR' },
            { id: 'ks-3.1.2', text: 'AWS SAM (Serverless Application Model) for Lambda and serverless deployments' },
            { id: 'ks-3.1.3', text: 'CloudFormation templates for application infrastructure as code' },
            { id: 'ks-3.1.4', text: 'Elastic Beanstalk application deployment and configuration' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Including development dependencies and test files in production deployment artifacts',
              whyWrong: 'Large deployment packages increase Lambda cold start times and container pull times. Use multi-stage Docker builds and build scripts to exclude development dependencies from production artifacts.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Test applications in development environments',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'AWS SAM CLI for local Lambda testing and debugging' },
            { id: 'ks-3.2.2', text: 'DynamoDB Local for local development without AWS costs' },
            { id: 'ks-3.2.3', text: 'AWS CodeBuild for automated test execution' },
            { id: 'ks-3.2.4', text: 'Mocking AWS services with LocalStack and moto' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Testing Lambda functions exclusively against production AWS resources',
              whyWrong: 'Testing against production resources risks data corruption and incurs costs. Use SAM CLI for local testing, DynamoDB Local for database tests, and dedicated dev/test accounts for pre-production validation.',
            },
          ],
        },
        {
          id: 'task-3.3',
          text: 'Automate deployment testing',
          knowledgeStatements: [
            { id: 'ks-3.3.1', text: 'AWS CodeCommit, CodeBuild, CodeDeploy, CodePipeline for CI/CD' },
            { id: 'ks-3.3.2', text: 'CodeDeploy deployment strategies: all-at-once, rolling, blue/green' },
            { id: 'ks-3.3.3', text: 'Lambda alias routing for canary deployments' },
            { id: 'ks-3.3.4', text: 'CodeDeploy AppSpec file for deployment lifecycle hooks' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.3-001',
              misconception: 'Using all-at-once deployment for production Lambda or ECS updates',
              whyWrong: 'All-at-once deployments cause downtime if the new version fails. Use Lambda alias traffic shifting (canary/linear) or CodeDeploy blue/green for ECS to gradually shift traffic with automated rollback on failures.',
            },
          ],
        },
        {
          id: 'task-3.4',
          text: 'Deploy code by using AWS CI/CD services',
          knowledgeStatements: [
            { id: 'ks-3.4.1', text: 'CodePipeline stages: source, build, test, deploy' },
            { id: 'ks-3.4.2', text: 'CodeBuild buildspec.yml configuration' },
            { id: 'ks-3.4.3', text: 'Environment variable management in CI/CD pipelines' },
            { id: 'ks-3.4.4', text: 'Artifact management with S3 and CodeArtifact' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.4-001',
              misconception: 'Storing build secrets in CodeBuild environment variables in plaintext',
              whyWrong: 'CodeBuild environment variables are visible in the console and build logs. Use AWS Secrets Manager or Parameter Store SecureString and reference them in buildspec.yml to keep secrets encrypted.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS CodeCommit', category: 'Developer Tools' },
        { name: 'AWS CodeBuild', category: 'Developer Tools' },
        { name: 'AWS CodeDeploy', category: 'Developer Tools' },
        { name: 'AWS CodePipeline', category: 'Developer Tools' },
        { name: 'AWS CodeArtifact', category: 'Developer Tools' },
        { name: 'AWS SAM', category: 'Developer Tools' },
        { name: 'AWS CloudFormation', category: 'Management & Governance' },
        { name: 'AWS Elastic Beanstalk', category: 'Compute' },
        { name: 'Amazon ECR', category: 'Containers' },
        { name: 'AWS CDK', category: 'Developer Tools' },
      ],
    },

    // ─── Domain 4: Troubleshooting and Optimization (18%) ───
    {
      id: 'domain-4',
      name: 'Troubleshooting and Optimization',
      weightPercent: 18,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Assist in a root cause analysis',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'AWS X-Ray for distributed tracing and service map visualization' },
            { id: 'ks-4.1.2', text: 'CloudWatch Logs and Logs Insights for application log analysis' },
            { id: 'ks-4.1.3', text: 'Lambda CloudWatch metrics: errors, throttles, duration, concurrent executions' },
            { id: 'ks-4.1.4', text: 'API Gateway access logging and execution logging' },
            { id: 'ks-4.1.5', text: 'Common Lambda error types: timeout, out-of-memory, throttling, cold start' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Relying solely on CloudWatch Logs for distributed system debugging',
              whyWrong: 'Log correlation across microservices is error-prone and time-consuming. AWS X-Ray provides distributed tracing with service maps, latency distributions, and error analysis across Lambda, API Gateway, and other integrated services.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Instrument code for observability',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'AWS X-Ray SDK integration for Lambda, EC2, and ECS' },
            { id: 'ks-4.2.2', text: 'Custom CloudWatch metrics and structured logging' },
            { id: 'ks-4.2.3', text: 'CloudWatch Embedded Metrics Format (EMF) for high-cardinality metrics' },
            { id: 'ks-4.2.4', text: 'AWS Lambda Powertools for structured logging, tracing, and metrics' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Putting high-cardinality data (e.g., user IDs) in CloudWatch metric dimensions',
              whyWrong: 'Each unique dimension combination creates a distinct metric, incurring per-metric costs. With millions of users, this creates enormous cost. Use structured logs with CloudWatch Logs Insights for high-cardinality analysis.',
            },
          ],
        },
        {
          id: 'task-4.3',
          text: 'Optimize applications by using AWS services and features',
          knowledgeStatements: [
            { id: 'ks-4.3.1', text: 'Lambda performance optimization: memory tuning, concurrency, provisioned concurrency' },
            { id: 'ks-4.3.2', text: 'Caching strategies: API Gateway caching, CloudFront, DAX, ElastiCache' },
            { id: 'ks-4.3.3', text: 'Asynchronous processing for improved throughput' },
            { id: 'ks-4.3.4', text: 'SQS batch processing with Lambda for cost-effective message processing' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.3-001',
              misconception: 'Not using API Gateway caching for frequently accessed, rarely changed endpoints',
              whyWrong: 'Without caching, repeated identical API calls invoke Lambda on every request, increasing cost and latency. API Gateway caching with appropriate TTL drastically reduces backend invocations for stable response data.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS X-Ray', category: 'Developer Tools' },
        { name: 'Amazon CloudWatch', category: 'Management & Governance' },
        { name: 'Amazon CloudWatch Logs Insights', category: 'Management & Governance' },
        { name: 'Amazon DynamoDB Accelerator (DAX)', category: 'Database' },
        { name: 'Amazon ElastiCache', category: 'Database' },
        { name: 'Amazon CloudFront', category: 'Networking & Content Delivery' },
        { name: 'API Gateway Caching', category: 'Networking & Content Delivery' },
        { name: 'AWS Lambda Powertools', category: 'Developer Tools' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Deep infrastructure operations and management (covered in SOA-C03)',
    'Advanced multi-account governance (covered in DOP-C02 and SAP-C02)',
    'Designing highly available architectures from scratch (covered in SAA-C03)',
    'Advanced networking (Transit Gateway routing, Direct Connect configuration)',
    'ML/AI model training (covered in MLA-C01 and MLS-C01)',
  ],
};
