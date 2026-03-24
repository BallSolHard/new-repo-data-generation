import type { ExamGuide } from '@/lib/types/exam-guide';

export const dopC02: ExamGuide = {
  certificationCode: 'DOP-C02',
  certificationName: 'AWS Certified DevOps Engineer - Professional (DOP-C02)',
  provider: 'aws',
  version: 'DOP-C02',
  effectiveDate: '2023-03-07',
  status: 'current',
  tier: 'professional' as const,
  examFormat: {
    totalQuestions: 75,
    scoredQuestions: 65,
    unscoredQuestions: 10,
    duration: 180,
    passingScore: 750,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    // ─── Domain 1: SDLC Automation (22%) ───
    {
      id: 'domain-1',
      name: 'SDLC Automation',
      weightPercent: 22,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Implement CI/CD pipelines',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'AWS CodePipeline: pipeline stages, actions, artifacts, manual approvals' },
            { id: 'ks-1.1.2', text: 'AWS CodeBuild: buildspec.yml, caching, batch builds, test reporting' },
            { id: 'ks-1.1.3', text: 'AWS CodeDeploy: deployment strategies (in-place, blue/green), AppSpec, lifecycle hooks, rollback triggers' },
            { id: 'ks-1.1.4', text: 'Cross-account and cross-region pipeline deployments' },
            { id: 'ks-1.1.5', text: 'Pipeline security: IAM least privilege for pipeline roles, secrets management in builds' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Using a single pipeline role with admin access instead of least-privilege per stage',
              whyWrong: 'A pipeline role with broad permissions creates a large blast radius if compromised. Each CodePipeline action should use a scoped IAM role granting only permissions needed for that specific action.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Not implementing automated rollback triggers in CodeDeploy',
              whyWrong: 'Without rollback triggers tied to CloudWatch alarms, failed deployments require manual intervention. Configure CodeDeploy to automatically roll back when error rates or latency alarms breach thresholds.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Integrate automated testing',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'Unit, integration, and end-to-end testing stages in CodePipeline' },
            { id: 'ks-1.2.2', text: 'CodeBuild test reports and test result trends' },
            { id: 'ks-1.2.3', text: 'Static code analysis with CodeGuru Reviewer' },
            { id: 'ks-1.2.4', text: 'Infrastructure testing with CloudFormation StackSets and drift detection' },
            { id: 'ks-1.2.5', text: 'Load testing integration before production deployments' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Deploying to production without a staging environment stage in the pipeline',
              whyWrong: 'Production-only validation means issues first appear in the highest-stakes environment. Staging environments mirror production and catch configuration, integration, and load-related issues before customer impact.',
            },
          ],
        },
        {
          id: 'task-1.3',
          text: 'Build and manage artifacts',
          knowledgeStatements: [
            { id: 'ks-1.3.1', text: 'Amazon ECR for container image management with lifecycle policies' },
            { id: 'ks-1.3.2', text: 'AWS CodeArtifact for private package repository management' },
            { id: 'ks-1.3.3', text: 'S3 pipeline artifact storage and cross-region replication for multi-region pipelines' },
            { id: 'ks-1.3.4', text: 'Artifact versioning and immutable artifact strategies' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.3-001',
              misconception: 'Using mutable container image tags (e.g., "latest") in deployment pipelines',
              whyWrong: 'Mutable tags make rollback and audit impossible — "latest" today differs from "latest" yesterday. Use immutable image tags (e.g., git commit SHA) so every deployed version is uniquely identifiable and reproducible.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS CodePipeline', category: 'Developer Tools' },
        { name: 'AWS CodeBuild', category: 'Developer Tools' },
        { name: 'AWS CodeDeploy', category: 'Developer Tools' },
        { name: 'AWS CodeCommit', category: 'Developer Tools' },
        { name: 'AWS CodeArtifact', category: 'Developer Tools' },
        { name: 'Amazon CodeGuru Reviewer', category: 'Developer Tools' },
        { name: 'Amazon ECR', category: 'Containers' },
        { name: 'Amazon S3', category: 'Storage' },
        { name: 'AWS IAM', category: 'Security, Identity, & Compliance' },
      ],
    },

    // ─── Domain 2: Configuration Management and IaC (17%) ───
    {
      id: 'domain-2',
      name: 'Configuration Management and Infrastructure as Code',
      weightPercent: 17,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Implement IaC',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'AWS CloudFormation: nested stacks, StackSets, change sets, drift detection, custom resources' },
            { id: 'ks-2.1.2', text: 'AWS CDK for infrastructure definition in code (TypeScript, Python, Java)' },
            { id: 'ks-2.1.3', text: 'CloudFormation macros and transforms (SAM transform)' },
            { id: 'ks-2.1.4', text: 'CloudFormation Guard for policy-as-code compliance checking' },
            { id: 'ks-2.1.5', text: 'AWS Service Catalog for standardized product provisioning' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Creating one monolithic CloudFormation stack for all application resources',
              whyWrong: 'Monolithic stacks have slow deployments, limited team autonomy, and a large blast radius if a stack update fails. Use nested stacks or separate stacks for different lifecycle domains (network, compute, application).',
            },
            {
              id: 'ap-2.1-002',
              misconception: 'Not using CloudFormation change sets before applying stack updates',
              whyWrong: 'Applying stack updates without previewing change sets can cause unexpected replacements or deletions. Change sets show what will be added, modified, or deleted before any changes are made.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Perform configuration management',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'AWS Systems Manager State Manager for configuration compliance enforcement' },
            { id: 'ks-2.2.2', text: 'Systems Manager Inventory and Patch Manager for fleet management' },
            { id: 'ks-2.2.3', text: 'AWS Config conformance packs for multi-rule compliance assessment' },
            { id: 'ks-2.2.4', text: 'AWS OpsWorks for Chef/Puppet-based configuration management (legacy)' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Managing EC2 instance configuration manually without configuration management tooling',
              whyWrong: 'Manual configuration drifts over time, creating inconsistencies across instances ("configuration drift"). Systems Manager State Manager enforces and remediates desired state continuously across entire fleets.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS CloudFormation', category: 'Management & Governance' },
        { name: 'AWS CDK', category: 'Developer Tools' },
        { name: 'AWS Service Catalog', category: 'Management & Governance' },
        { name: 'AWS Systems Manager', category: 'Management & Governance' },
        { name: 'AWS Config', category: 'Management & Governance' },
        { name: 'AWS CloudFormation Guard', category: 'Management & Governance' },
      ],
    },

    // ─── Domain 3: Resilient Cloud Solutions (15%) ───
    {
      id: 'domain-3',
      name: 'Resilient Cloud Solutions',
      weightPercent: 15,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Implement highly available solutions',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'Multi-AZ and multi-Region architecture patterns' },
            { id: 'ks-3.1.2', text: 'Route 53 health checks, routing policies, and DNS failover' },
            { id: 'ks-3.1.3', text: 'Aurora Global Database and RDS cross-region read replicas' },
            { id: 'ks-3.1.4', text: 'DynamoDB global tables for multi-region active-active' },
            { id: 'ks-3.1.5', text: 'AWS Global Accelerator for multi-region traffic routing' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Using Route 53 latency routing as a primary disaster recovery mechanism',
              whyWrong: 'Latency routing picks the lowest-latency endpoint based on DNS TTL, not endpoint health. Combine latency routing with health checks or use failover routing policy to ensure traffic is only routed to healthy endpoints.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Implement disaster recovery solutions',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'DR strategies: backup and restore, pilot light, warm standby, multi-site active/active' },
            { id: 'ks-3.2.2', text: 'AWS Elastic Disaster Recovery (DRS) for server replication' },
            { id: 'ks-3.2.3', text: 'Chaos engineering principles and AWS Fault Injection Service (FIS)' },
            { id: 'ks-3.2.4', text: 'GameDay exercises and runbook automation for DR testing' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Designing a DR plan but never testing it until a real disaster',
              whyWrong: 'Untested DR plans fail when needed most. Regular DR drills using AWS Fault Injection Service expose gaps in runbooks, automation, and RTO/RPO assumptions before a real event occurs.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Route 53', category: 'Networking & Content Delivery' },
        { name: 'AWS Global Accelerator', category: 'Networking & Content Delivery' },
        { name: 'Amazon Aurora Global Database', category: 'Database' },
        { name: 'Amazon DynamoDB Global Tables', category: 'Database' },
        { name: 'AWS Elastic Disaster Recovery', category: 'Migration & Transfer' },
        { name: 'AWS Fault Injection Service', category: 'Developer Tools' },
        { name: 'AWS Backup', category: 'Storage' },
      ],
    },

    // ─── Domain 4: Monitoring and Logging (15%) ───
    {
      id: 'domain-4',
      name: 'Monitoring and Logging',
      weightPercent: 15,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Configure the collection, aggregation, and storage of logs and metrics',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'CloudWatch: custom metrics, dashboards, Logs Insights, contributor insights' },
            { id: 'ks-4.1.2', text: 'CloudWatch cross-account observability and cross-account log aggregation' },
            { id: 'ks-4.1.3', text: 'AWS X-Ray for distributed tracing and service maps' },
            { id: 'ks-4.1.4', text: 'Amazon OpenSearch for log analytics and visualization (ELK stack patterns)' },
            { id: 'ks-4.1.5', text: 'Centralized logging architectures: Kinesis Data Firehose to S3/OpenSearch' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Sending all logs directly from EC2 to CloudWatch without centralized log routing',
              whyWrong: 'Direct-to-CloudWatch logging creates per-account silos and complicates cross-account analysis. Centralized log aggregation via Kinesis Firehose enables unified search, retention, and compliance reporting across accounts.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Audit, monitor, and analyze logs and metrics',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'CloudWatch anomaly detection and dynamic alarming' },
            { id: 'ks-4.2.2', text: 'AWS CloudTrail Lake for long-term API audit and SQL-based queries' },
            { id: 'ks-4.2.3', text: 'Security information and event management (SIEM) integration with AWS services' },
            { id: 'ks-4.2.4', text: 'Amazon EventBridge for event-driven automated responses to operational events' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Only creating alarms for known failure modes and not using anomaly detection',
              whyWrong: 'Static thresholds miss anomalies outside expected failure patterns. CloudWatch anomaly detection uses ML to establish dynamic baselines and alerts on statistically significant deviations, catching unknown-unknown failures.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon CloudWatch', category: 'Management & Governance' },
        { name: 'AWS X-Ray', category: 'Developer Tools' },
        { name: 'AWS CloudTrail', category: 'Management & Governance' },
        { name: 'AWS CloudTrail Lake', category: 'Management & Governance' },
        { name: 'Amazon OpenSearch Service', category: 'Analytics' },
        { name: 'Amazon Kinesis Data Firehose', category: 'Analytics' },
        { name: 'Amazon EventBridge', category: 'Application Integration' },
      ],
    },

    // ─── Domain 5: Incident and Event Response (14%) ───
    {
      id: 'domain-5',
      name: 'Incident and Event Response',
      weightPercent: 14,
      tasks: [
        {
          id: 'task-5.1',
          text: 'Manage event lifecycles',
          knowledgeStatements: [
            { id: 'ks-5.1.1', text: 'Amazon EventBridge rules, event buses, and cross-account event routing' },
            { id: 'ks-5.1.2', text: 'AWS Health events and EventBridge integration for automated response' },
            { id: 'ks-5.1.3', text: 'SNS and SQS fan-out patterns for event distribution' },
            { id: 'ks-5.1.4', text: 'Amazon GuardDuty findings and automated remediation with Lambda' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.1-001',
              misconception: 'Building custom event routing logic instead of using EventBridge rules',
              whyWrong: 'Custom routing adds undifferentiated heavy lifting. EventBridge provides native pattern matching, content-based filtering, schema registry, and routing to 20+ AWS targets without custom code.',
            },
          ],
        },
        {
          id: 'task-5.2',
          text: 'Implement configuration changes in response to events',
          knowledgeStatements: [
            { id: 'ks-5.2.1', text: 'AWS Config auto-remediation with SSM Automation runbooks' },
            { id: 'ks-5.2.2', text: 'Lambda-based automated incident response' },
            { id: 'ks-5.2.3', text: 'Systems Manager OpsCenter for operational issue tracking' },
            { id: 'ks-5.2.4', text: 'Incident Manager for structured incident response and escalation' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.2-001',
              misconception: 'Manually responding to every AWS Config non-compliance finding',
              whyWrong: 'Manual remediation does not scale across hundreds of accounts and thousands of resources. AWS Config auto-remediation with SSM Automation documents can automatically fix common misconfigurations (e.g., open S3 buckets) without human intervention.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon EventBridge', category: 'Application Integration' },
        { name: 'AWS Config (Auto-remediation)', category: 'Management & Governance' },
        { name: 'AWS Systems Manager OpsCenter', category: 'Management & Governance' },
        { name: 'AWS Systems Manager Incident Manager', category: 'Management & Governance' },
        { name: 'Amazon GuardDuty', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Lambda', category: 'Compute' },
        { name: 'Amazon SNS', category: 'Application Integration' },
        { name: 'AWS Health', category: 'Management & Governance' },
      ],
    },

    // ─── Domain 6: Security and Compliance (17%) ───
    {
      id: 'domain-6',
      name: 'Security and Compliance',
      weightPercent: 17,
      tasks: [
        {
          id: 'task-6.1',
          text: 'Implement and automate security controls',
          knowledgeStatements: [
            { id: 'ks-6.1.1', text: 'AWS Security Hub for centralized findings and compliance standards (CIS, PCI, NIST)' },
            { id: 'ks-6.1.2', text: 'AWS Organizations SCPs and permission boundaries for preventive controls' },
            { id: 'ks-6.1.3', text: 'AWS IAM Access Analyzer for external access and unused access findings' },
            { id: 'ks-6.1.4', text: 'Secret rotation automation with Secrets Manager and Lambda' },
            { id: 'ks-6.1.5', text: 'Amazon Inspector v2 for continuous vulnerability scanning of EC2 and containers' },
          ],
          antiPatterns: [
            {
              id: 'ap-6.1-001',
              misconception: 'Manually rotating credentials on an ad-hoc schedule instead of using automated rotation',
              whyWrong: 'Manual rotation is error-prone and often skipped. Secrets Manager automatic rotation with a Lambda rotation function ensures credentials are rotated on a defined schedule without downtime or manual intervention.',
            },
          ],
        },
        {
          id: 'task-6.2',
          text: 'Implement and automate compliance controls',
          knowledgeStatements: [
            { id: 'ks-6.2.1', text: 'AWS Config conformance packs for bulk compliance deployment' },
            { id: 'ks-6.2.2', text: 'AWS Audit Manager for automated audit evidence collection' },
            { id: 'ks-6.2.3', text: 'CloudFormation Guard for IaC policy-as-code compliance' },
            { id: 'ks-6.2.4', text: 'Data classification and protection with Macie and Lake Formation' },
          ],
          antiPatterns: [
            {
              id: 'ap-6.2-001',
              misconception: 'Performing compliance audits manually on a quarterly schedule',
              whyWrong: 'Quarterly audits discover compliance issues that have been present for months. Continuous compliance monitoring with AWS Config and Security Hub detects violations in near-real-time, reducing compliance risk exposure window.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Security Hub', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Organizations', category: 'Management & Governance' },
        { name: 'AWS IAM Access Analyzer', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Secrets Manager', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Inspector', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Config', category: 'Management & Governance' },
        { name: 'AWS Audit Manager', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Macie', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon GuardDuty', category: 'Security, Identity, & Compliance' },
        { name: 'AWS KMS', category: 'Security, Identity, & Compliance' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Basic AWS service fundamentals (covered in associate certs)',
    'ML/AI pipeline operations',
    'Application-level code development',
    'Advanced data engineering pipelines',
  ],
};
