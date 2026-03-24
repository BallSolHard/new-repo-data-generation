import type { ExamGuide } from '@/lib/types/exam-guide';

export const clfC02: ExamGuide = {
  certificationCode: 'CLF-C02',
  certificationName: 'AWS Certified Cloud Practitioner - Foundational (CLF-C02)',
  provider: 'aws',
  version: 'CLF-C02',
  effectiveDate: '2023-09-19',
  status: 'current',
  tier: 'foundational' as const,
  examFormat: {
    totalQuestions: 65,
    scoredQuestions: 50,
    unscoredQuestions: 15,
    duration: 90,
    passingScore: 700,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    // ─── Domain 1: Cloud Concepts (24%) ───
    {
      id: 'domain-1',
      name: 'Cloud Concepts',
      weightPercent: 24,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Define the benefits of the AWS Cloud',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'Value proposition of the AWS Cloud' },
            { id: 'ks-1.1.2', text: 'Economies of scale (cost advantages that large-scale cloud providers pass to customers)' },
            { id: 'ks-1.1.3', text: 'Benefits of global infrastructure (deploy globally in minutes, low latency for end users)' },
            { id: 'ks-1.1.4', text: 'Total cost of ownership (TCO) comparison: on-premises infrastructure vs. cloud' },
            { id: 'ks-1.1.5', text: 'Benefits of cloud computing: agility, elasticity, cost savings, deploy globally in minutes' },
            { id: 'ks-1.1.6', text: 'High availability and fault tolerance enabled by AWS infrastructure' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Thinking cloud is always cheaper than on-premises',
              whyWrong: 'Cloud is not automatically cheaper. Data transfer costs, over-provisioning, and always-on resources can exceed on-premises costs. The value proposition includes agility, speed, and elasticity — not just raw cost savings.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Ignoring operational benefits and focusing only on infrastructure cost',
              whyWrong: 'Cloud benefits extend far beyond cost: reduced time-to-market, global reach, elimination of capacity planning, and the ability to experiment quickly. Evaluating cloud solely on price misses the strategic advantages.',
            },
            {
              id: 'ap-1.1-003',
              misconception: 'Assuming all workloads benefit equally from cloud migration',
              whyWrong: 'Some workloads (e.g., legacy mainframes with heavy licensing, latency-critical on-site systems) may not benefit from cloud migration. Each workload should be evaluated individually for cloud fit.',
            },
            {
              id: 'ap-1.1-004',
              misconception: 'Overlooking pay-as-you-go pricing by keeping resources always on',
              whyWrong: 'One of the key cloud benefits is paying only for what you use. Running dev/test environments 24/7 or not shutting down unused resources negates this advantage.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Identify design principles of the AWS Cloud',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'AWS Well-Architected Framework pillars: operational excellence, security, reliability, performance efficiency, cost optimization, sustainability' },
            { id: 'ks-1.2.2', text: 'Design principles: design for failure, decouple components, implement elasticity, think parallel' },
            { id: 'ks-1.2.3', text: 'Importance of automation in cloud deployments and operations' },
            { id: 'ks-1.2.4', text: 'Benefits of disposable resources and infrastructure as code' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Treating cloud servers as pets instead of cattle',
              whyWrong: 'Cloud infrastructure should be disposable and reproducible. Manually configuring and maintaining individual servers prevents auto-scaling, complicates disaster recovery, and contradicts infrastructure-as-code principles.',
            },
            {
              id: 'ap-1.2-002',
              misconception: 'Building tightly coupled architectures that cannot scale independently',
              whyWrong: 'Tight coupling means a failure or bottleneck in one component cascades to the entire system. Loosely coupled architectures use queues, load balancers, and APIs to allow independent scaling and fault isolation.',
            },
            {
              id: 'ap-1.2-003',
              misconception: 'Ignoring the Well-Architected Framework when designing solutions',
              whyWrong: 'The Well-Architected Framework codifies AWS best practices across six pillars. Skipping it leads to security gaps, reliability issues, cost overruns, and operational inefficiency.',
            },
            {
              id: 'ap-1.2-004',
              misconception: 'Deploying to a single Availability Zone and assuming it is sufficient for production',
              whyWrong: 'A single AZ is a single point of failure. Production workloads should span multiple AZs for high availability, as an AZ outage would take down the entire application.',
            },
          ],
        },
        {
          id: 'task-1.3',
          text: 'Understand the benefits of and strategies for migration to the AWS Cloud',
          knowledgeStatements: [
            { id: 'ks-1.3.1', text: 'Cloud adoption strategies: the 6 Rs of migration (rehost, replatform, repurchase, refactor, retain, retire)' },
            { id: 'ks-1.3.2', text: 'AWS Cloud Adoption Framework (AWS CAF) perspectives: business, people, governance, platform, security, operations' },
            { id: 'ks-1.3.3', text: 'Benefits of migration: reduced complexity, improved agility, business continuity' },
            { id: 'ks-1.3.4', text: 'AWS migration services and tools overview (Migration Hub, Application Migration Service, DMS)' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.3-001',
              misconception: 'Attempting to refactor everything at once instead of using a phased migration approach',
              whyWrong: 'Big-bang refactoring is risky and slow. A phased approach (e.g., rehost first, then optimize) reduces risk, delivers value incrementally, and builds cloud skills over time.',
            },
            {
              id: 'ap-1.3-002',
              misconception: 'Only considering rehost (lift and shift) without evaluating replatform or refactor',
              whyWrong: 'Lift and shift moves workloads quickly but misses cloud-native benefits like auto-scaling and managed services. Some workloads gain significant value from replatforming or refactoring.',
            },
            {
              id: 'ap-1.3-003',
              misconception: 'Ignoring organizational readiness and migrating without a Cloud Adoption Framework assessment',
              whyWrong: 'Migration is not just a technical exercise. Without addressing people, process, and governance readiness (as outlined in AWS CAF), migrations stall or fail due to skills gaps and organizational resistance.',
            },
            {
              id: 'ap-1.3-004',
              misconception: 'Not assessing existing workloads before selecting a migration strategy',
              whyWrong: 'Each workload has different characteristics (dependencies, compliance needs, architecture). Applying the same migration strategy to all workloads leads to suboptimal outcomes and wasted effort.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Pricing Calculator', category: 'Cloud Financial Management' },
        { name: 'AWS Well-Architected Tool', category: 'Management & Governance' },
        { name: 'AWS Migration Hub', category: 'Migration & Transfer' },
        { name: 'AWS Application Migration Service', category: 'Migration & Transfer' },
        { name: 'AWS Database Migration Service (DMS)', category: 'Migration & Transfer' },
        { name: 'AWS Snow Family', category: 'Migration & Transfer' },
        { name: 'AWS Cloud Adoption Framework (CAF)', category: 'Cloud Strategy' },
      ],
    },

    // ─── Domain 2: Security and Compliance (30%) ───
    {
      id: 'domain-2',
      name: 'Security and Compliance',
      weightPercent: 30,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Understand the AWS shared responsibility model',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'AWS shared responsibility model: security OF the cloud (AWS) vs. security IN the cloud (customer)' },
            { id: 'ks-2.1.2', text: 'AWS responsibilities: physical infrastructure, hypervisor, managed service patching, network infrastructure' },
            { id: 'ks-2.1.3', text: 'Customer responsibilities: data encryption, OS patching (for EC2), security group configuration, IAM, application-level security' },
            { id: 'ks-2.1.4', text: 'How the shared responsibility model shifts depending on the service type (IaaS vs. managed services vs. serverless)' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Assuming AWS handles all security including customer data encryption and access control',
              whyWrong: 'AWS secures the underlying infrastructure, but customers are responsible for encrypting their data, managing IAM permissions, configuring firewalls, and securing their applications. This is the core of the shared responsibility model.',
            },
            {
              id: 'ap-2.1-002',
              misconception: 'Not patching the operating system on EC2 instances because AWS manages security',
              whyWrong: 'For IaaS services like EC2, the customer is responsible for OS patches, security updates, and configuration. AWS only manages the hardware and hypervisor layer beneath the guest OS.',
            },
            {
              id: 'ap-2.1-003',
              misconception: 'Confusing the shared responsibility boundary for managed services vs. unmanaged services',
              whyWrong: 'For managed services like RDS, AWS handles OS patching and database engine updates. For EC2, the customer handles everything above the hypervisor. Understanding which service model shifts which responsibilities is critical.',
            },
            {
              id: 'ap-2.1-004',
              misconception: 'Neglecting to configure security groups and NACLs assuming AWS does it by default',
              whyWrong: 'While AWS provides the security group and NACL mechanisms, the customer must configure them correctly. Default security group rules may be too permissive for production workloads.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Understand AWS Cloud security, governance, and compliance concepts',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'AWS compliance programs (HIPAA, PCI DSS, SOC, FedRAMP, GDPR)' },
            { id: 'ks-2.2.2', text: 'AWS Artifact for accessing compliance reports and agreements' },
            { id: 'ks-2.2.3', text: 'Encryption concepts: encryption at rest and encryption in transit' },
            { id: 'ks-2.2.4', text: 'Logging and auditing services for governance (CloudTrail, Config)' },
            { id: 'ks-2.2.5', text: 'AWS Organizations and Service Control Policies (SCPs) for multi-account governance' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Assuming compliance certifications transfer automatically to customer workloads',
              whyWrong: 'AWS certifications cover the infrastructure, but customers must implement their own controls to meet compliance requirements. Running on HIPAA-eligible services does not make a workload HIPAA-compliant without proper safeguards.',
            },
            {
              id: 'ap-2.2-002',
              misconception: 'Not enabling CloudTrail or Config and missing audit trail requirements',
              whyWrong: 'CloudTrail logs API calls and Config tracks resource configurations. Without them, there is no audit trail for who did what and when — a common compliance and security requirement.',
            },
            {
              id: 'ap-2.2-003',
              misconception: 'Storing encryption keys alongside the data they protect instead of using KMS',
              whyWrong: 'Co-locating keys with encrypted data defeats the purpose of encryption. AWS KMS provides centralized, auditable key management with automatic rotation and access controls.',
            },
            {
              id: 'ap-2.2-004',
              misconception: 'Ignoring governance controls like SCPs when operating a multi-account environment',
              whyWrong: 'Without SCPs, individual accounts can perform any action allowed by their IAM policies. SCPs provide guardrails that restrict what actions are possible across the organization, regardless of IAM permissions.',
            },
          ],
        },
        {
          id: 'task-2.3',
          text: 'Identify AWS access management capabilities',
          knowledgeStatements: [
            { id: 'ks-2.3.1', text: 'IAM features: users, groups, roles, and policies' },
            { id: 'ks-2.3.2', text: 'Principle of least privilege for granting permissions' },
            { id: 'ks-2.3.3', text: 'Root account best practices: enable MFA, avoid daily use, secure access keys' },
            { id: 'ks-2.3.4', text: 'Multi-factor authentication (MFA) for enhanced security' },
            { id: 'ks-2.3.5', text: 'AWS IAM Identity Center (SSO) for centralized access management' },
            { id: 'ks-2.3.6', text: 'Federated access and identity providers' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.3-001',
              misconception: 'Using the root account for everyday tasks instead of creating individual IAM users',
              whyWrong: 'The root account has unrestricted access and cannot be scoped down with policies. It should be secured with MFA and used only for account-level tasks that require root. Daily operations should use IAM users or roles.',
            },
            {
              id: 'ap-2.3-002',
              misconception: 'Granting overly broad permissions instead of following least privilege',
              whyWrong: 'Policies like AdministratorAccess give full access to all services. If credentials are compromised, the blast radius is the entire account. Grant only the specific permissions each user or role needs.',
            },
            {
              id: 'ap-2.3-003',
              misconception: 'Sharing IAM credentials between team members instead of creating individual users',
              whyWrong: 'Shared credentials eliminate accountability and make it impossible to audit who performed which action. Each person should have their own IAM user or federated identity.',
            },
            {
              id: 'ap-2.3-004',
              misconception: 'Not enabling MFA on the root account and privileged IAM users',
              whyWrong: 'Without MFA, a compromised password is sufficient to gain full access. MFA adds a second factor that significantly reduces the risk of unauthorized access.',
            },
            {
              id: 'ap-2.3-005',
              misconception: 'Embedding long-term access keys in application source code instead of using IAM roles',
              whyWrong: 'Access keys in code risk exposure via version control and are difficult to rotate. IAM roles for EC2, Lambda, and ECS provide temporary credentials that rotate automatically.',
            },
          ],
        },
        {
          id: 'task-2.4',
          text: 'Identify components and resources for security',
          knowledgeStatements: [
            { id: 'ks-2.4.1', text: 'Network security: security groups, network ACLs, AWS WAF' },
            { id: 'ks-2.4.2', text: 'DDoS protection with AWS Shield (Standard and Advanced)' },
            { id: 'ks-2.4.3', text: 'Threat detection with Amazon GuardDuty' },
            { id: 'ks-2.4.4', text: 'Vulnerability management with Amazon Inspector' },
            { id: 'ks-2.4.5', text: 'Sensitive data discovery with Amazon Macie' },
            { id: 'ks-2.4.6', text: 'Centralized security findings with AWS Security Hub' },
            { id: 'ks-2.4.7', text: 'Investigation and root cause analysis with Amazon Detective' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.4-001',
              misconception: 'Relying only on security groups without considering network ACLs for subnet-level defense',
              whyWrong: 'Security groups operate at the instance level and are stateful. Network ACLs operate at the subnet level and are stateless. Using both provides defense-in-depth at multiple layers.',
            },
            {
              id: 'ap-2.4-002',
              misconception: 'Not enabling GuardDuty because there is no perceived threat',
              whyWrong: 'GuardDuty uses ML and threat intelligence to detect unexpected activity. Threats are often invisible until damage is done. GuardDuty provides continuous monitoring with minimal setup.',
            },
            {
              id: 'ap-2.4-003',
              misconception: 'Manually reviewing S3 buckets for sensitive data instead of using Macie',
              whyWrong: 'Manual review does not scale and misses sensitive data patterns. Macie uses ML to automatically discover and classify sensitive data like PII and financial data across S3 buckets.',
            },
            {
              id: 'ap-2.4-004',
              misconception: 'Ignoring AWS Shield Standard and not understanding DDoS protection is built in',
              whyWrong: 'AWS Shield Standard is automatically enabled at no additional cost and protects against common DDoS attacks. Many users are unaware they already have baseline DDoS protection.',
            },
            {
              id: 'ap-2.4-005',
              misconception: 'Not centralizing security findings with Security Hub across multiple accounts',
              whyWrong: 'Without Security Hub, security findings from GuardDuty, Inspector, Macie, and other services are siloed. Security Hub aggregates and prioritizes findings in one place for faster response.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Identity and Access Management (IAM)', category: 'Security, Identity, & Compliance' },
        { name: 'AWS IAM Identity Center (SSO)', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Cognito', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Directory Service', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Key Management Service (KMS)', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Certificate Manager (ACM)', category: 'Security, Identity, & Compliance' },
        { name: 'AWS WAF', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Shield', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon GuardDuty', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Inspector', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Macie', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Security Hub', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Detective', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Firewall Manager', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Artifact', category: 'Security, Identity, & Compliance' },
        { name: 'AWS CloudTrail', category: 'Management & Governance' },
        { name: 'AWS Config', category: 'Management & Governance' },
        { name: 'AWS Organizations', category: 'Management & Governance' },
        { name: 'Service Control Policies (SCPs)', category: 'Management & Governance' },
      ],
    },

    // ─── Domain 3: Cloud Technology and Services (34%) ───
    {
      id: 'domain-3',
      name: 'Cloud Technology and Services',
      weightPercent: 34,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Define methods of deploying and operating in the AWS Cloud',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'Cloud deployment models: public cloud, private cloud, hybrid cloud' },
            { id: 'ks-3.1.2', text: 'Service models: Infrastructure as a Service (IaaS), Platform as a Service (PaaS), Software as a Service (SaaS)' },
            { id: 'ks-3.1.3', text: 'Connectivity options: internet, VPN, AWS Direct Connect' },
            { id: 'ks-3.1.4', text: 'Ways to interact with AWS: Management Console, CLI, SDKs, Infrastructure as Code (IaC)' },
            { id: 'ks-3.1.5', text: 'AWS Elastic Beanstalk for PaaS-style deployments' },
            { id: 'ks-3.1.6', text: 'AWS CloudFormation and AWS CDK for infrastructure as code' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Manually configuring infrastructure through the console for production environments',
              whyWrong: 'Manual console configurations are error-prone, not repeatable, and not auditable. Infrastructure as code (CloudFormation, CDK) ensures consistent, version-controlled, and automated deployments.',
            },
            {
              id: 'ap-3.1-002',
              misconception: 'Not understanding the difference between IaaS, PaaS, and SaaS',
              whyWrong: 'Choosing the wrong service model leads to unnecessary management overhead. EC2 (IaaS) requires OS management; Elastic Beanstalk (PaaS) handles it; SaaS like Amazon WorkMail handles everything.',
            },
            {
              id: 'ap-3.1-003',
              misconception: 'Using only the Management Console for all deployments instead of automating',
              whyWrong: 'The console is great for exploration but does not scale. CLI, SDKs, and IaC tools enable automation, repeatability, and integration with CI/CD pipelines.',
            },
            {
              id: 'ap-3.1-004',
              misconception: 'Ignoring hybrid cloud options when regulatory requirements demand on-premises components',
              whyWrong: 'Some compliance or latency requirements mandate on-premises infrastructure. AWS Outposts, VPN, and Direct Connect enable hybrid architectures that satisfy these requirements while leveraging the cloud.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Define the AWS global infrastructure',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'AWS Regions and how to choose a Region (compliance, latency, service availability, pricing)' },
            { id: 'ks-3.2.2', text: 'Availability Zones (AZs) and their role in high availability and fault tolerance' },
            { id: 'ks-3.2.3', text: 'Edge locations and their role in content delivery (CloudFront, Route 53)' },
            { id: 'ks-3.2.4', text: 'AWS Local Zones and AWS Wavelength for low-latency use cases' },
            { id: 'ks-3.2.5', text: 'AWS Outposts for on-premises AWS infrastructure' },
            { id: 'ks-3.2.6', text: 'Benefits of deploying across multiple AZs and Regions' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Deploying all resources in a single Availability Zone and expecting high availability',
              whyWrong: 'A single AZ is a single point of failure. If that AZ experiences an outage, the entire application goes down. Multi-AZ deployment is essential for high availability.',
            },
            {
              id: 'ap-3.2-002',
              misconception: 'Choosing a Region based solely on cost without considering latency or compliance',
              whyWrong: 'The cheapest Region may be geographically far from users (causing high latency) or may not meet data residency compliance requirements. Region selection should balance cost, latency, compliance, and service availability.',
            },
            {
              id: 'ap-3.2-003',
              misconception: 'Confusing edge locations with Availability Zones or Regions',
              whyWrong: 'Edge locations are CDN endpoints for CloudFront and Route 53 — they cache content close to users. They are not full AZs or Regions and cannot run EC2 instances or host databases.',
            },
            {
              id: 'ap-3.2-004',
              misconception: 'Not understanding that each Region is fully isolated from other Regions',
              whyWrong: 'AWS Regions are designed to be completely independent. Data does not automatically replicate across Regions. Multi-Region architectures require explicit cross-Region replication configuration.',
            },
          ],
        },
        {
          id: 'task-3.3',
          text: 'Identify AWS compute services',
          knowledgeStatements: [
            { id: 'ks-3.3.1', text: 'Amazon EC2 instance types and use cases (general purpose, compute optimized, memory optimized, storage optimized)' },
            { id: 'ks-3.3.2', text: 'EC2 pricing options: On-Demand, Reserved Instances, Spot Instances, Savings Plans' },
            { id: 'ks-3.3.3', text: 'Container services: Amazon ECS, Amazon EKS, AWS Fargate' },
            { id: 'ks-3.3.4', text: 'Serverless compute: AWS Lambda (event-driven, no server management, pay per invocation)' },
            { id: 'ks-3.3.5', text: 'Amazon Lightsail for simple web applications and virtual private servers' },
            { id: 'ks-3.3.6', text: 'Auto Scaling for automatic capacity adjustments based on demand' },
            { id: 'ks-3.3.7', text: 'Elastic Load Balancing for distributing traffic across targets' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.3-001',
              misconception: 'Using EC2 for everything instead of considering serverless or containers',
              whyWrong: 'EC2 requires managing instances, patching, and scaling. Lambda eliminates server management for event-driven workloads. Fargate removes container host management. Choosing the right compute model reduces operational overhead.',
            },
            {
              id: 'ap-3.3-002',
              misconception: 'Running EC2 instances 24/7 for sporadic or unpredictable workloads',
              whyWrong: 'Paying for idle compute wastes money. Lambda charges per invocation for sporadic workloads. Spot Instances offer up to 90% savings for fault-tolerant batch processing.',
            },
            {
              id: 'ap-3.3-003',
              misconception: 'Not using Auto Scaling and manually adding or removing instances',
              whyWrong: 'Manual scaling is slow, error-prone, and cannot respond to sudden traffic spikes. Auto Scaling automatically adjusts capacity based on demand, maintaining performance while optimizing costs.',
            },
            {
              id: 'ap-3.3-004',
              misconception: 'Choosing the wrong EC2 instance type for the workload',
              whyWrong: 'Using compute-optimized instances for memory-heavy workloads (or vice versa) wastes resources. Each instance family is designed for specific workload characteristics — match the instance type to the workload.',
            },
            {
              id: 'ap-3.3-005',
              misconception: 'Ignoring Fargate and always managing EC2-based container hosts',
              whyWrong: 'Fargate is a serverless container option that removes the need to provision and manage EC2 instances for containers. It simplifies operations and lets teams focus on application code.',
            },
          ],
        },
        {
          id: 'task-3.4',
          text: 'Identify AWS database services',
          knowledgeStatements: [
            { id: 'ks-3.4.1', text: 'Amazon RDS for managed relational databases (MySQL, PostgreSQL, Oracle, SQL Server, MariaDB)' },
            { id: 'ks-3.4.2', text: 'Amazon Aurora as a high-performance managed relational database (MySQL and PostgreSQL compatible)' },
            { id: 'ks-3.4.3', text: 'Amazon DynamoDB for managed NoSQL (key-value and document database)' },
            { id: 'ks-3.4.4', text: 'Amazon ElastiCache for in-memory caching (Redis, Memcached)' },
            { id: 'ks-3.4.5', text: 'Amazon Redshift for data warehousing and analytics at scale' },
            { id: 'ks-3.4.6', text: 'Choosing between relational, NoSQL, and in-memory databases based on use case' },
            { id: 'ks-3.4.7', text: 'Amazon DocumentDB for MongoDB-compatible workloads' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.4-001',
              misconception: 'Using a relational database for highly variable key-value data',
              whyWrong: 'Relational databases enforce rigid schemas and struggle with highly variable data structures. DynamoDB is purpose-built for key-value and document data with flexible schemas and single-digit millisecond performance.',
            },
            {
              id: 'ap-3.4-002',
              misconception: 'Self-managing a database on EC2 instead of using a managed service like RDS',
              whyWrong: 'Running databases on EC2 requires managing backups, patching, replication, scaling, and failover manually. Managed services like RDS and Aurora handle these operational tasks automatically.',
            },
            {
              id: 'ap-3.4-003',
              misconception: 'Using a general-purpose database for analytics workloads',
              whyWrong: 'Transactional databases (RDS, DynamoDB) are optimized for OLTP, not analytical queries on large datasets. Amazon Redshift is a columnar data warehouse designed for complex analytical queries across petabytes of data.',
            },
            {
              id: 'ap-3.4-004',
              misconception: 'Not considering read replicas or ElastiCache for read-heavy workloads',
              whyWrong: 'Sending all reads to the primary database creates a bottleneck. Read replicas offload read traffic, and ElastiCache provides microsecond-latency caching for frequently accessed data.',
            },
          ],
        },
        {
          id: 'task-3.5',
          text: 'Identify AWS network services',
          knowledgeStatements: [
            { id: 'ks-3.5.1', text: 'Amazon VPC: virtual private cloud, subnets (public and private), internet gateways, NAT gateways' },
            { id: 'ks-3.5.2', text: 'Security groups (stateful, instance-level) and network ACLs (stateless, subnet-level)' },
            { id: 'ks-3.5.3', text: 'Amazon Route 53 for DNS and domain registration' },
            { id: 'ks-3.5.4', text: 'Amazon CloudFront for content delivery network (CDN)' },
            { id: 'ks-3.5.5', text: 'AWS Direct Connect for dedicated network connections to AWS' },
            { id: 'ks-3.5.6', text: 'AWS VPN for encrypted connections over the internet' },
            { id: 'ks-3.5.7', text: 'VPC peering and Transit Gateway for connecting VPCs' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.5-001',
              misconception: 'Placing all resources in public subnets instead of using private subnets with NAT gateways',
              whyWrong: 'Resources in public subnets are directly accessible from the internet, increasing the attack surface. Databases and application servers should be in private subnets, with NAT gateways providing outbound-only internet access.',
            },
            {
              id: 'ap-3.5-002',
              misconception: 'Confusing security groups (stateful, instance-level) with network ACLs (stateless, subnet-level)',
              whyWrong: 'Security groups track connection state and apply at the instance level. NACLs are stateless (require explicit inbound and outbound rules) and apply at the subnet level. Using the wrong one leads to misconfigured access controls.',
            },
            {
              id: 'ap-3.5-003',
              misconception: 'Using only VPN for high-throughput, latency-sensitive connections instead of Direct Connect',
              whyWrong: 'VPN connections traverse the public internet and are subject to variable latency and bandwidth limits. AWS Direct Connect provides a dedicated, private connection with consistent performance for high-throughput workloads.',
            },
            {
              id: 'ap-3.5-004',
              misconception: 'Not using Route 53 health checks and routing policies for high availability',
              whyWrong: 'Without health checks, DNS continues routing traffic to unhealthy endpoints. Route 53 failover, weighted, and latency-based routing policies automatically direct traffic to healthy, optimal endpoints.',
            },
            {
              id: 'ap-3.5-005',
              misconception: 'Serving all content from the origin server instead of using CloudFront',
              whyWrong: 'Without a CDN, every request travels to the origin server, increasing latency for distant users and load on the origin. CloudFront caches content at edge locations worldwide for faster delivery.',
            },
          ],
        },
        {
          id: 'task-3.6',
          text: 'Identify AWS storage services',
          knowledgeStatements: [
            { id: 'ks-3.6.1', text: 'Amazon S3 storage classes: Standard, Intelligent-Tiering, Standard-IA, One Zone-IA, Glacier Instant Retrieval, Glacier Flexible Retrieval, Glacier Deep Archive' },
            { id: 'ks-3.6.2', text: 'Amazon S3 features: versioning, lifecycle policies, static website hosting, object-level access controls' },
            { id: 'ks-3.6.3', text: 'Amazon EBS (Elastic Block Store) for EC2 instance storage (persistent block storage, volume types)' },
            { id: 'ks-3.6.4', text: 'Amazon EFS (Elastic File System) for shared file storage across multiple instances (NFS)' },
            { id: 'ks-3.6.5', text: 'Amazon FSx for Windows File Server and Lustre file systems' },
            { id: 'ks-3.6.6', text: 'AWS Storage Gateway for hybrid cloud storage' },
            { id: 'ks-3.6.7', text: 'AWS Snow Family (Snowcone, Snowball, Snowmobile) for offline data migration' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.6-001',
              misconception: 'Using S3 Standard for all data regardless of access patterns',
              whyWrong: 'S3 Standard is the most expensive storage class. Infrequently accessed data should use S3 Standard-IA or Glacier, and S3 Intelligent-Tiering automatically moves data between tiers based on access patterns.',
            },
            {
              id: 'ap-3.6-002',
              misconception: 'Using EBS when shared file access across multiple instances is needed',
              whyWrong: 'EBS volumes can only be attached to one EC2 instance at a time (except io1/io2 Multi-Attach). EFS provides a shared file system that can be mounted by thousands of instances simultaneously.',
            },
            {
              id: 'ap-3.6-003',
              misconception: 'Attempting to transfer petabytes of data over the internet instead of using the Snow Family',
              whyWrong: 'Transferring petabytes over the internet takes weeks or months. AWS Snowball and Snowmobile provide physical devices for offline data transfer, completing migrations in days.',
            },
            {
              id: 'ap-3.6-004',
              misconception: 'Not enabling S3 versioning and lifecycle policies to manage data protection and costs',
              whyWrong: 'Without versioning, accidental deletes are permanent. Without lifecycle policies, old data stays in expensive storage classes. Together they provide data protection and automatic cost optimization.',
            },
            {
              id: 'ap-3.6-005',
              misconception: 'Storing archival data in S3 Standard-IA instead of Glacier Deep Archive',
              whyWrong: 'Data that is rarely accessed (e.g., compliance archives) should use Glacier Deep Archive at a fraction of the cost. Standard-IA is for data accessed monthly, not data accessed once a year or less.',
            },
          ],
        },
        {
          id: 'task-3.7',
          text: 'Identify AWS AI/ML and analytics services',
          knowledgeStatements: [
            { id: 'ks-3.7.1', text: 'Amazon SageMaker for building, training, and deploying ML models' },
            { id: 'ks-3.7.2', text: 'AI services: Amazon Rekognition (image/video), Amazon Comprehend (NLP), Amazon Polly (text-to-speech), Amazon Lex (chatbots), Amazon Textract (document OCR), Amazon Translate, Amazon Transcribe' },
            { id: 'ks-3.7.3', text: 'Analytics services: Amazon Athena (serverless SQL on S3), Amazon QuickSight (BI dashboards)' },
            { id: 'ks-3.7.4', text: 'Streaming and ETL: Amazon Kinesis (real-time streaming), AWS Glue (ETL and data catalog)' },
            { id: 'ks-3.7.5', text: 'Amazon EMR for big data processing (Hadoop, Spark)' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.7-001',
              misconception: 'Building custom ML models from scratch when pre-built AI services already solve the use case',
              whyWrong: 'Services like Rekognition, Comprehend, and Textract provide pre-trained ML capabilities via API calls. Building custom models for common tasks (image recognition, NLP, OCR) wastes time and requires ML expertise.',
            },
            {
              id: 'ap-3.7-002',
              misconception: 'Setting up dedicated infrastructure for ad hoc SQL queries on S3 data',
              whyWrong: 'Amazon Athena is serverless — it runs SQL queries directly on S3 data with no infrastructure to manage. There is no need to provision databases or clusters for exploratory data analysis.',
            },
            {
              id: 'ap-3.7-003',
              misconception: 'Using batch processing for real-time streaming use cases',
              whyWrong: 'Batch processing introduces delay. Amazon Kinesis is designed for real-time data ingestion and processing (e.g., IoT, clickstream, log analytics) with sub-second latency.',
            },
            {
              id: 'ap-3.7-004',
              misconception: 'Building custom dashboards from scratch instead of leveraging QuickSight',
              whyWrong: 'Amazon QuickSight provides serverless BI with ML-powered insights, pay-per-session pricing, and integration with AWS data sources. Custom dashboards require ongoing development and maintenance effort.',
            },
          ],
        },
      ],
      inScopeServices: [
        // Compute
        { name: 'Amazon EC2', category: 'Compute' },
        { name: 'Amazon EC2 Auto Scaling', category: 'Compute' },
        { name: 'Elastic Load Balancing (ELB)', category: 'Compute' },
        { name: 'AWS Lambda', category: 'Compute' },
        { name: 'Amazon ECS', category: 'Compute' },
        { name: 'Amazon EKS', category: 'Compute' },
        { name: 'AWS Fargate', category: 'Compute' },
        { name: 'Amazon Lightsail', category: 'Compute' },
        { name: 'AWS Batch', category: 'Compute' },
        // Database
        { name: 'Amazon RDS', category: 'Database' },
        { name: 'Amazon Aurora', category: 'Database' },
        { name: 'Amazon DynamoDB', category: 'Database' },
        { name: 'Amazon ElastiCache', category: 'Database' },
        { name: 'Amazon Redshift', category: 'Database' },
        { name: 'Amazon DocumentDB', category: 'Database' },
        { name: 'Amazon Neptune', category: 'Database' },
        { name: 'Amazon MemoryDB for Redis', category: 'Database' },
        // Networking & Content Delivery
        { name: 'Amazon VPC', category: 'Networking & Content Delivery' },
        { name: 'Amazon Route 53', category: 'Networking & Content Delivery' },
        { name: 'Amazon CloudFront', category: 'Networking & Content Delivery' },
        { name: 'AWS Direct Connect', category: 'Networking & Content Delivery' },
        { name: 'AWS VPN', category: 'Networking & Content Delivery' },
        { name: 'AWS Transit Gateway', category: 'Networking & Content Delivery' },
        { name: 'Elastic Load Balancing (ELB)', category: 'Networking & Content Delivery' },
        { name: 'AWS PrivateLink', category: 'Networking & Content Delivery' },
        { name: 'AWS Global Accelerator', category: 'Networking & Content Delivery' },
        // Storage
        { name: 'Amazon S3', category: 'Storage' },
        { name: 'Amazon S3 Glacier', category: 'Storage' },
        { name: 'Amazon EBS', category: 'Storage' },
        { name: 'Amazon EFS', category: 'Storage' },
        { name: 'Amazon FSx', category: 'Storage' },
        { name: 'AWS Storage Gateway', category: 'Storage' },
        { name: 'AWS Snow Family', category: 'Storage' },
        { name: 'AWS Backup', category: 'Storage' },
        // Management & Governance
        { name: 'AWS Management Console', category: 'Management & Governance' },
        { name: 'AWS CLI', category: 'Management & Governance' },
        { name: 'AWS SDKs', category: 'Management & Governance' },
        { name: 'AWS CloudFormation', category: 'Management & Governance' },
        { name: 'AWS CDK', category: 'Management & Governance' },
        { name: 'AWS Elastic Beanstalk', category: 'Management & Governance' },
        { name: 'AWS CloudShell', category: 'Management & Governance' },
        { name: 'AWS Outposts', category: 'Management & Governance' },
        { name: 'AWS Local Zones', category: 'Management & Governance' },
        { name: 'AWS Wavelength', category: 'Management & Governance' },
        // AI/ML
        { name: 'Amazon SageMaker', category: 'Machine Learning' },
        { name: 'Amazon Rekognition', category: 'Machine Learning' },
        { name: 'Amazon Comprehend', category: 'Machine Learning' },
        { name: 'Amazon Polly', category: 'Machine Learning' },
        { name: 'Amazon Lex', category: 'Machine Learning' },
        { name: 'Amazon Textract', category: 'Machine Learning' },
        { name: 'Amazon Translate', category: 'Machine Learning' },
        { name: 'Amazon Transcribe', category: 'Machine Learning' },
        // Analytics
        { name: 'Amazon Athena', category: 'Analytics' },
        { name: 'Amazon QuickSight', category: 'Analytics' },
        { name: 'Amazon Kinesis', category: 'Analytics' },
        { name: 'AWS Glue', category: 'Analytics' },
        { name: 'Amazon EMR', category: 'Analytics' },
        { name: 'Amazon OpenSearch Service', category: 'Analytics' },
      ],
    },

    // ─── Domain 4: Billing, Pricing, and Support (12%) ───
    {
      id: 'domain-4',
      name: 'Billing, Pricing, and Support',
      weightPercent: 12,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Compare AWS pricing models',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'On-Demand pricing: pay by the second or hour with no long-term commitment' },
            { id: 'ks-4.1.2', text: 'Reserved Instances and Savings Plans: commit to 1- or 3-year terms for significant discounts' },
            { id: 'ks-4.1.3', text: 'Spot Instances: bid on unused EC2 capacity at up to 90% discount (can be interrupted)' },
            { id: 'ks-4.1.4', text: 'AWS Free Tier: always free, 12 months free, and short-term trial offers' },
            { id: 'ks-4.1.5', text: 'Data transfer pricing: inbound is free, outbound is charged, cross-Region and cross-AZ costs' },
            { id: 'ks-4.1.6', text: 'Per-service pricing models (e.g., S3: storage + requests, Lambda: invocations + duration, EC2: instance hours)' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Not taking advantage of the AWS Free Tier to explore and learn services at no cost',
              whyWrong: 'Many AWS services offer a free tier (e.g., 750 hours/month of t2.micro EC2, 5 GB S3 storage, 1 million Lambda invocations/month). Not using the free tier means paying for experimentation that could be free.',
            },
            {
              id: 'ap-4.1-002',
              misconception: 'Running steady-state workloads on On-Demand instead of Reserved Instances or Savings Plans',
              whyWrong: 'On-Demand is the most expensive pricing option. For predictable, always-on workloads, Reserved Instances or Savings Plans offer up to 72% savings with 1- or 3-year commitments.',
            },
            {
              id: 'ap-4.1-003',
              misconception: 'Using Reserved Instances for unpredictable or short-lived workloads',
              whyWrong: 'Reserved Instances require a commitment regardless of usage. For unpredictable workloads, On-Demand provides flexibility, and Spot Instances offer deep discounts for fault-tolerant, interruptible tasks.',
            },
            {
              id: 'ap-4.1-004',
              misconception: 'Ignoring data transfer costs when estimating total cloud costs',
              whyWrong: 'Data transfer out of AWS and between Regions/AZs is charged. For data-intensive applications, transfer costs can be a significant portion of the bill. Always include data transfer in cost estimates.',
            },
            {
              id: 'ap-4.1-005',
              misconception: 'Not considering Spot Instances for fault-tolerant batch processing workloads',
              whyWrong: 'Spot Instances offer up to 90% savings over On-Demand for workloads that can tolerate interruption (e.g., batch jobs, data analysis, CI/CD). Many users overlook this option and overpay for interruptible work.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Understand resources for billing, budget, and cost management',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'AWS Cost Explorer for visualizing and analyzing spending patterns over time' },
            { id: 'ks-4.2.2', text: 'AWS Budgets for setting custom cost and usage thresholds with alerts' },
            { id: 'ks-4.2.3', text: 'AWS Cost and Usage Report for detailed, line-item billing data' },
            { id: 'ks-4.2.4', text: 'AWS Billing Dashboard for account-level billing overview' },
            { id: 'ks-4.2.5', text: 'Cost allocation tags for tracking costs by project, team, or environment' },
            { id: 'ks-4.2.6', text: 'AWS Organizations consolidated billing for multi-account cost management' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Not setting up AWS Budgets and being surprised by unexpected charges',
              whyWrong: 'Without budget alerts, cost overruns are only discovered after the fact on the monthly bill. AWS Budgets provides proactive alerts when costs or usage exceed defined thresholds.',
            },
            {
              id: 'ap-4.2-002',
              misconception: 'Failing to use cost allocation tags to attribute costs to specific projects or teams',
              whyWrong: 'Without tags, it is impossible to determine which team, project, or environment is driving costs. Cost allocation tags enable granular cost tracking and accountability across the organization.',
            },
            {
              id: 'ap-4.2-003',
              misconception: 'Not reviewing Cost Explorer regularly to identify spending trends and savings opportunities',
              whyWrong: 'Cost Explorer provides historical analysis and forecasting. Regular review surfaces unused resources, underutilized instances, and opportunities for Reserved Instance or Savings Plan purchases.',
            },
            {
              id: 'ap-4.2-004',
              misconception: 'Managing multiple accounts without consolidated billing through AWS Organizations',
              whyWrong: 'Without consolidated billing, each account is billed separately, missing volume discounts and making cost tracking across the organization difficult. Consolidated billing aggregates usage for potential savings.',
            },
          ],
        },
        {
          id: 'task-4.3',
          text: 'Identify AWS technical resources and AWS Support options',
          knowledgeStatements: [
            { id: 'ks-4.3.1', text: 'AWS Support plans: Basic (free), Developer, Business, Enterprise On-Ramp, Enterprise' },
            { id: 'ks-4.3.2', text: 'Support features by plan: Trusted Advisor checks, response times, Technical Account Manager (TAM)' },
            { id: 'ks-4.3.3', text: 'AWS Trusted Advisor for best practice recommendations (cost, security, performance, fault tolerance, service limits)' },
            { id: 'ks-4.3.4', text: 'AWS Health Dashboard for personalized service health notifications' },
            { id: 'ks-4.3.5', text: 'AWS self-service resources: Knowledge Center, documentation, whitepapers, re:Post' },
            { id: 'ks-4.3.6', text: 'AWS Professional Services and AWS Partner Network (APN)' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.3-001',
              misconception: 'Staying on Basic Support for production workloads that need faster response times',
              whyWrong: 'Basic Support has no access to technical support engineers. Business and Enterprise plans provide 24/7 phone, chat, and email access with response times as fast as 15 minutes for critical issues.',
            },
            {
              id: 'ap-4.3-002',
              misconception: 'Not running Trusted Advisor checks to identify cost savings and security improvements',
              whyWrong: 'Trusted Advisor proactively identifies underutilized resources, security gaps, and service limit risks. Ignoring it means missing easy wins for cost optimization and security hardening.',
            },
            {
              id: 'ap-4.3-003',
              misconception: 'Ignoring the AWS Health Dashboard and missing important service event notifications',
              whyWrong: 'The Health Dashboard provides personalized alerts about AWS service events that affect your specific resources. Without monitoring it, teams may not realize an outage or scheduled maintenance impacts their workloads.',
            },
            {
              id: 'ap-4.3-004',
              misconception: 'Contacting AWS Support for questions that are answered in documentation and re:Post',
              whyWrong: 'AWS documentation, Knowledge Center, and re:Post cover the vast majority of common questions. Self-service resources provide faster answers and free up support cases for truly complex issues.',
            },
            {
              id: 'ap-4.3-005',
              misconception: 'Assuming a Technical Account Manager (TAM) is available on all support plans',
              whyWrong: 'A TAM is only available with Enterprise On-Ramp and Enterprise support plans. Business and Developer plans do not include a dedicated TAM for proactive guidance and architectural reviews.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon EC2 Pricing', category: 'Cloud Financial Management' },
        { name: 'Amazon S3 Pricing', category: 'Cloud Financial Management' },
        { name: 'AWS Lambda Pricing', category: 'Cloud Financial Management' },
        { name: 'AWS Pricing Calculator', category: 'Cloud Financial Management' },
        { name: 'AWS Cost Explorer', category: 'Cloud Financial Management' },
        { name: 'AWS Budgets', category: 'Cloud Financial Management' },
        { name: 'AWS Cost and Usage Report', category: 'Cloud Financial Management' },
        { name: 'AWS Billing Dashboard', category: 'Cloud Financial Management' },
        { name: 'AWS Organizations (Consolidated Billing)', category: 'Cloud Financial Management' },
        { name: 'AWS Support', category: 'Support' },
        { name: 'AWS Trusted Advisor', category: 'Support' },
        { name: 'AWS Health Dashboard', category: 'Support' },
        { name: 'AWS re:Post', category: 'Support' },
        { name: 'AWS IQ', category: 'Support' },
        { name: 'AWS Managed Services (AMS)', category: 'Support' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Coding or programming (no code-level questions)',
    'Cloud architecture design or implementation (covered in associate/professional certs)',
    'Advanced networking configurations (VPC peering details, Transit Gateway advanced routing)',
    'Detailed database administration or performance tuning',
    'Specific pricing calculations (only general pricing concepts are tested)',
    'Machine learning model building or training processes',
    'Detailed CloudFormation template syntax or IaC implementation',
    'Container orchestration details (ECS task definitions, Kubernetes manifests)',
    'Disaster recovery strategy implementation details',
    'Advanced IAM policy writing (JSON policy documents)',
    'Multi-account architecture patterns (beyond basic Organizations concepts)',
    'Operating system administration or server configuration',
  ],
};
