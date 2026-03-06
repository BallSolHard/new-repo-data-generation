import type { ExamGuide } from '@/lib/types/exam-guide';

export const sapC02: ExamGuide = {
  certificationCode: 'SAP-C02',
  certificationName: 'AWS Certified Solutions Architect - Professional',
  provider: 'aws',
  version: 'SAP-C02',
  effectiveDate: '2022-11-15',
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
    // ─── Domain 1: Design Solutions for Organizational Complexity (26%) ───
    {
      id: 'domain-1',
      name: 'Design Solutions for Organizational Complexity',
      weightPercent: 26,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Architect network connectivity strategies',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'AWS Transit Gateway for hub-and-spoke networking: route tables, route propagation, peering, multicast' },
            { id: 'ks-1.1.2', text: 'AWS Direct Connect: dedicated connections, hosted connections, LAG, Direct Connect Gateway' },
            { id: 'ks-1.1.3', text: 'AWS Site-to-Site VPN and Client VPN for hybrid connectivity' },
            { id: 'ks-1.1.4', text: 'AWS PrivateLink for service sharing across VPCs and accounts' },
            { id: 'ks-1.1.5', text: 'Network segmentation strategies: shared services VPC, security VPC, spoke VPCs' },
            { id: 'ks-1.1.6', text: 'IPv6 architecture considerations and dual-stack implementations' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Using VPC peering for enterprise-scale multi-VPC connectivity',
              whyWrong: 'VPC peering is non-transitive and requires N*(N-1)/2 connections for a full mesh. For enterprises with 10s-100s of VPCs, Transit Gateway provides transitive routing with centralized management, security inspection insertion, and route control.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Using Site-to-Site VPN as the primary connectivity for high-throughput hybrid workloads',
              whyWrong: 'VPN is limited to ~1.25 Gbps per tunnel and traverses the public internet, introducing variable latency. Direct Connect provides dedicated bandwidth up to 100 Gbps with consistent latency for latency-sensitive or high-throughput workloads.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Prescribe security controls',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'AWS Organizations: OUs, SCPs, delegated administration, account vending' },
            { id: 'ks-1.2.2', text: 'AWS Control Tower for multi-account governance and guardrails' },
            { id: 'ks-1.2.3', text: 'IAM Identity Center (SSO) for centralized access across accounts' },
            { id: 'ks-1.2.4', text: 'Resource Access Manager (RAM) for resource sharing across accounts' },
            { id: 'ks-1.2.5', text: 'Permission boundaries and session policies for delegated IAM administration' },
            { id: 'ks-1.2.6', text: 'AWS Firewall Manager for centralized WAF, Shield, and security group management' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Applying SCPs at the root of the organization affecting all accounts equally',
              whyWrong: 'Root-level SCPs affect every account including the management account (indirectly). Apply SCPs at OU levels with exceptions for specific accounts. Use a well-structured OU hierarchy to apply controls proportional to sensitivity.',
            },
            {
              id: 'ap-1.2-002',
              misconception: 'Managing centralized security tooling deployment across accounts with manual account onboarding',
              whyWrong: 'Manual security tool deployment creates inconsistency and gaps. AWS Control Tower with Landing Zone customizations and account factory automates security guardrail deployment to new accounts without manual intervention.',
            },
          ],
        },
        {
          id: 'task-1.3',
          text: 'Design reliable and resilient architectures',
          knowledgeStatements: [
            { id: 'ks-1.3.1', text: 'Multi-Region active-active and active-passive architectures' },
            { id: 'ks-1.3.2', text: 'AWS Global Accelerator for multi-region traffic management' },
            { id: 'ks-1.3.3', text: 'Aurora Global Database for sub-second cross-region replication' },
            { id: 'ks-1.3.4', text: 'DynamoDB global tables for multi-region active-active database' },
            { id: 'ks-1.3.5', text: 'Chaos engineering with AWS Fault Injection Service' },
            { id: 'ks-1.3.6', text: 'Well-Architected Framework Reliability pillar implementation' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.3-001',
              misconception: 'Designing multi-Region failover without accounting for data replication lag',
              whyWrong: 'During Regional failover, any replication lag represents data loss (RPO). Design must account for acceptable RPO, implement synchronous replication (Aurora Global Database managed failover) or accept async lag in the DR strategy.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Transit Gateway', category: 'Networking & Content Delivery' },
        { name: 'AWS Direct Connect', category: 'Networking & Content Delivery' },
        { name: 'AWS PrivateLink', category: 'Networking & Content Delivery' },
        { name: 'AWS Organizations', category: 'Management & Governance' },
        { name: 'AWS Control Tower', category: 'Management & Governance' },
        { name: 'AWS IAM Identity Center', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Resource Access Manager', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Firewall Manager', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Aurora Global Database', category: 'Database' },
        { name: 'Amazon DynamoDB Global Tables', category: 'Database' },
        { name: 'AWS Global Accelerator', category: 'Networking & Content Delivery' },
        { name: 'AWS Fault Injection Service', category: 'Developer Tools' },
      ],
    },

    // ─── Domain 2: Design for New Solutions (29%) ───
    {
      id: 'domain-2',
      name: 'Design for New Solutions',
      weightPercent: 29,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Design a deployment strategy to meet business requirements',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'Serverless architectures: Lambda, API Gateway, Step Functions, EventBridge, SQS, SNS' },
            { id: 'ks-2.1.2', text: 'Container orchestration: ECS with Fargate, EKS, App Runner' },
            { id: 'ks-2.1.3', text: 'Blue/green and canary deployment strategies at the infrastructure level' },
            { id: 'ks-2.1.4', text: 'Feature flagging and deployment decoupling patterns' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Choosing a deployment strategy based on operational familiarity rather than application requirements',
              whyWrong: 'EC2 may be familiar but is operationally heavy for stateless services. Fargate or Lambda may better serve stateless, event-driven workloads at lower operational overhead. Select deployment based on scalability, cost, and operational requirements.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Design solutions for performance',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'Database scaling: read replicas, global tables, sharding, caching layers' },
            { id: 'ks-2.2.2', text: 'Caching strategies: CloudFront, ElastiCache, DAX, API Gateway' },
            { id: 'ks-2.2.3', text: 'Event-driven scaling and decoupled architectures for burst handling' },
            { id: 'ks-2.2.4', text: 'Compute optimization: Graviton instances, Spot Instances, compute-intensive EC2 families' },
            { id: 'ks-2.2.5', text: 'Storage performance: EBS io2 Block Express, FSx for Lustre, S3 multipart upload' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Adding caching at the application level without invalidating stale cache on writes',
              whyWrong: 'Caching without cache invalidation serves stale data. Design write-through or write-invalidate patterns to ensure cache coherency. Use ElastiCache TTL policies and DynamoDB Streams with Lambda to proactively invalidate stale cache entries.',
            },
          ],
        },
        {
          id: 'task-2.3',
          text: 'Design solutions for security',
          knowledgeStatements: [
            { id: 'ks-2.3.1', text: 'Zero-trust network architecture on AWS' },
            { id: 'ks-2.3.2', text: 'Data perimeter controls: VPC endpoint policies, S3 bucket policies, SCP' },
            { id: 'ks-2.3.3', text: 'Secrets management lifecycle: creation, rotation, revocation' },
            { id: 'ks-2.3.4', text: 'Encryption key management: KMS multi-Region keys, CloudHSM for FIPS 140-3 Level 3' },
            { id: 'ks-2.3.5', text: 'Workload isolation: separate accounts, VPCs, IAM boundaries per environment' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.3-001',
              misconception: 'Using a single KMS key for all data across all environments and services',
              whyWrong: 'A shared key creates an overly large blast radius if compromised. Use separate CMKs per service, environment, and sensitivity level. Key policies and grants provide access control, while separation limits exposure scope.',
            },
          ],
        },
        {
          id: 'task-2.4',
          text: 'Design cost-optimized solutions',
          knowledgeStatements: [
            { id: 'ks-2.4.1', text: 'Savings Plans and Reserved Instances for committed workloads' },
            { id: 'ks-2.4.2', text: 'Spot Instances for fault-tolerant, stateless, and batch workloads' },
            { id: 'ks-2.4.3', text: 'Serverless cost model vs. provisioned compute cost model tradeoffs' },
            { id: 'ks-2.4.4', text: 'Data transfer cost optimization: same-AZ traffic, VPC endpoints, CloudFront' },
            { id: 'ks-2.4.5', text: 'Storage cost optimization: tiering, compression, deduplication, lifecycle policies' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.4-001',
              misconception: 'Optimizing compute costs without addressing data transfer costs',
              whyWrong: 'Inter-Region and internet egress costs can exceed compute costs for data-intensive architectures. Use CloudFront, S3 Transfer Acceleration, VPC endpoints, and architect data locality to minimize transfer charges.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Lambda', category: 'Compute' },
        { name: 'Amazon API Gateway', category: 'Networking & Content Delivery' },
        { name: 'Amazon ECS / EKS', category: 'Containers' },
        { name: 'AWS Fargate', category: 'Containers' },
        { name: 'Amazon ElastiCache', category: 'Database' },
        { name: 'Amazon CloudFront', category: 'Networking & Content Delivery' },
        { name: 'AWS KMS', category: 'Security, Identity, & Compliance' },
        { name: 'AWS CloudHSM', category: 'Security, Identity, & Compliance' },
        { name: 'EC2 Spot Instances', category: 'Compute' },
        { name: 'AWS Savings Plans', category: 'Cloud Financial Management' },
        { name: 'Amazon S3 (all tiers)', category: 'Storage' },
        { name: 'Amazon FSx', category: 'Storage' },
      ],
    },

    // ─── Domain 3: Continuous Improvement for Existing Solutions (25%) ───
    {
      id: 'domain-3',
      name: 'Continuous Improvement for Existing Solutions',
      weightPercent: 25,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Determine a strategy to improve overall operational excellence',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'AWS Well-Architected Framework reviews and improvement plans' },
            { id: 'ks-3.1.2', text: 'Automation of operational runbooks using Systems Manager Automation' },
            { id: 'ks-3.1.3', text: 'Infrastructure as code maturity: from manual to fully automated deployments' },
            { id: 'ks-3.1.4', text: 'Observability strategy: metrics, logs, traces — correlation and insights' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Treating the Well-Architected Framework review as a one-time compliance exercise',
              whyWrong: 'Architecture evolves continuously. Well-Architected Reviews should be repeated as architectures change and after production incidents. Regular reviews surface new improvement opportunities as AWS releases new services and best practices.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Determine a strategy to improve security',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'Security Hub finding aggregation and prioritization' },
            { id: 'ks-3.2.2', text: 'GuardDuty threat intelligence and malware detection' },
            { id: 'ks-3.2.3', text: 'IAM Access Analyzer for external access findings and policy generation' },
            { id: 'ks-3.2.4', text: 'Migration from legacy security patterns to AWS-native controls' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Relying on perimeter security alone without any east-west traffic controls',
              whyWrong: 'Perimeter controls (firewalls at ingress/egress) do not stop lateral movement after an attacker is inside. Implement zero-trust with security groups, PrivateLink, VPC endpoints, and fine-grained IAM to constrain movement.',
            },
          ],
        },
        {
          id: 'task-3.3',
          text: 'Determine a strategy to improve performance',
          knowledgeStatements: [
            { id: 'ks-3.3.1', text: 'Profiling application bottlenecks with X-Ray, CloudWatch, and Performance Insights' },
            { id: 'ks-3.3.2', text: 'Database performance tuning: indexing, query optimization, RDS Performance Insights' },
            { id: 'ks-3.3.3', text: 'Right-sizing EC2 and RDS with Compute Optimizer and Performance Insights' },
            { id: 'ks-3.3.4', text: 'Graviton migration for cost and performance improvement' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.3-001',
              misconception: 'Scaling out horizontally for all performance problems without identifying the actual bottleneck',
              whyWrong: 'If the bottleneck is a single-threaded database query or a poorly indexed table, adding more EC2 instances does nothing. Profile first using X-Ray and Performance Insights to identify the true constraint before scaling.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Well-Architected Tool', category: 'Management & Governance' },
        { name: 'AWS Systems Manager Automation', category: 'Management & Governance' },
        { name: 'AWS Security Hub', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon GuardDuty', category: 'Security, Identity, & Compliance' },
        { name: 'AWS IAM Access Analyzer', category: 'Security, Identity, & Compliance' },
        { name: 'AWS X-Ray', category: 'Developer Tools' },
        { name: 'Amazon CloudWatch', category: 'Management & Governance' },
        { name: 'Amazon RDS Performance Insights', category: 'Database' },
        { name: 'AWS Compute Optimizer', category: 'Management & Governance' },
      ],
    },

    // ─── Domain 4: Accelerate Workload Migration and Modernization (20%) ───
    {
      id: 'domain-4',
      name: 'Accelerate Workload Migration and Modernization',
      weightPercent: 20,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Select existing workloads and processes for potential migration',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'Migration evaluation: 7 Rs of migration (retain, retire, rehost, replatform, repurchase, refactor, relocate)' },
            { id: 'ks-4.1.2', text: 'AWS Migration Hub for workload discovery and tracking' },
            { id: 'ks-4.1.3', text: 'AWS Application Discovery Service for on-premises inventory' },
            { id: 'ks-4.1.4', text: 'Business case development and TCO analysis for migration decisions' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Defaulting to rehost (lift and shift) for all workloads to minimize migration effort',
              whyWrong: 'Lift and shift moves technical debt to the cloud without realizing cloud-native benefits. Evaluate each workload: well-architected apps suit refactoring; legacy with high migration cost suit rehosting; obsolete apps should retire.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Determine the optimal migration approach for existing workloads',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'AWS Application Migration Service (MGN) for rehost migrations' },
            { id: 'ks-4.2.2', text: 'Database migration with AWS DMS and Schema Conversion Tool (SCT)' },
            { id: 'ks-4.2.3', text: 'Container migration: containerizing legacy applications for ECS/EKS' },
            { id: 'ks-4.2.4', text: 'Serverless modernization patterns: strangler fig, event-driven refactoring' },
            { id: 'ks-4.2.5', text: 'AWS Snow Family for offline data migration at petabyte scale' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Attempting online database migration without a fallback plan or cutover window',
              whyWrong: 'Database migrations carry data integrity risks. Always run DMS in parallel with validation, maintain the ability to roll back to the source database, and plan a maintenance window cutover with a tested validation checklist.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Migration Hub', category: 'Migration & Transfer' },
        { name: 'AWS Application Discovery Service', category: 'Migration & Transfer' },
        { name: 'AWS Application Migration Service (MGN)', category: 'Migration & Transfer' },
        { name: 'AWS Database Migration Service (DMS)', category: 'Migration & Transfer' },
        { name: 'AWS Schema Conversion Tool (SCT)', category: 'Migration & Transfer' },
        { name: 'AWS Snow Family', category: 'Migration & Transfer' },
        { name: 'AWS DataSync', category: 'Migration & Transfer' },
        { name: 'Amazon ECS / EKS', category: 'Containers' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Basic AWS service usage covered in associate certifications',
    'Code-level development practices',
    'Advanced ML/AI workload design',
    'Detailed SAP or Oracle application migration specifics',
  ],
};
