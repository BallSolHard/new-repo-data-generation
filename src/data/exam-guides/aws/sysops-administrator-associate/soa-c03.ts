import type { ExamGuide } from '@/lib/types/exam-guide';

export const soaC03: ExamGuide = {
  certificationCode: 'SOA-C03',
  certificationName: 'AWS Certified CloudOps Engineer - Associate (SOA-C03)',
  provider: 'aws',
  version: 'SOA-C03',
  effectiveDate: '2021-07-26',
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
    // ─── Domain 1: Monitoring, Logging, and Remediation (20%) ───
    {
      id: 'domain-1',
      name: 'Monitoring, Logging, and Remediation',
      weightPercent: 20,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Implement metrics, alarms, and filters by using AWS monitoring and logging services',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'Amazon CloudWatch metrics, custom metrics, namespaces, and dimensions' },
            { id: 'ks-1.1.2', text: 'CloudWatch alarms: static thresholds, anomaly detection, composite alarms' },
            { id: 'ks-1.1.3', text: 'CloudWatch Logs: log groups, log streams, metric filters, retention policies' },
            { id: 'ks-1.1.4', text: 'CloudWatch Logs Insights for querying log data' },
            { id: 'ks-1.1.5', text: 'AWS CloudTrail for API activity logging and governance' },
            { id: 'ks-1.1.6', text: 'AWS Config for resource configuration tracking and compliance' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Relying on default CloudWatch metrics alone for complete EC2 visibility',
              whyWrong: 'Default metrics cover CPU, network, and disk I/O but not memory utilization or disk space usage — common operational metrics. Install the CloudWatch agent to collect these OS-level metrics.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Not setting log retention policies on CloudWatch log groups',
              whyWrong: 'Without retention policies, logs are stored indefinitely, incurring unbounded storage costs. Set appropriate retention periods (e.g., 90 days for operational logs, 365+ days for audit logs) for each log group.',
            },
            {
              id: 'ap-1.1-003',
              misconception: 'Using individual alarms when composite alarms would reduce alert noise',
              whyWrong: 'Multiple individual alarms firing simultaneously causes alert fatigue. Composite alarms combine multiple alarm states with AND/OR logic, allowing root cause alerting rather than alerting on every symptom.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Remediate issues based on monitoring and availability metrics',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'EC2 Auto Recovery and status checks (system, instance)' },
            { id: 'ks-1.2.2', text: 'AWS Systems Manager Automation for runbook-based remediation' },
            { id: 'ks-1.2.3', text: 'AWS Health Dashboard for service and account health events' },
            { id: 'ks-1.2.4', text: 'EventBridge rules for automated responses to operational events' },
            { id: 'ks-1.2.5', text: 'AWS Trusted Advisor for proactive issue detection' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Manually responding to EC2 system failures instead of configuring auto-recovery',
              whyWrong: 'EC2 auto-recovery automatically restores an instance on another host when system status checks fail, preserving the instance ID, EIP, and metadata. Manual recovery introduces delay and human error.',
            },
            {
              id: 'ap-1.2-002',
              misconception: 'Not subscribing to AWS Health events for account-specific notifications',
              whyWrong: 'Generic service status pages don\'t show account-specific impacts. AWS Health Dashboard provides personalized notifications about events affecting your specific resources.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon CloudWatch', category: 'Management & Governance' },
        { name: 'Amazon CloudWatch Logs', category: 'Management & Governance' },
        { name: 'Amazon CloudWatch Alarms', category: 'Management & Governance' },
        { name: 'CloudWatch Agent', category: 'Management & Governance' },
        { name: 'AWS CloudTrail', category: 'Management & Governance' },
        { name: 'AWS Config', category: 'Management & Governance' },
        { name: 'AWS Health Dashboard', category: 'Management & Governance' },
        { name: 'AWS Trusted Advisor', category: 'Management & Governance' },
        { name: 'Amazon EventBridge', category: 'Application Integration' },
        { name: 'AWS Systems Manager Automation', category: 'Management & Governance' },
      ],
    },

    // ─── Domain 2: Reliability and Business Continuity (16%) ───
    {
      id: 'domain-2',
      name: 'Reliability and Business Continuity',
      weightPercent: 16,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Implement scalability and elasticity based on requirements',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'EC2 Auto Scaling: launch templates, scaling policies (target tracking, step, simple)' },
            { id: 'ks-2.1.2', text: 'Elastic Load Balancing configuration and health checks' },
            { id: 'ks-2.1.3', text: 'Amazon RDS storage auto-scaling and read replicas' },
            { id: 'ks-2.1.4', text: 'DynamoDB on-demand and auto-scaling capacity modes' },
            { id: 'ks-2.1.5', text: 'AWS Application Auto Scaling for non-EC2 resources' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Using simple scaling policies instead of target tracking for most auto-scaling scenarios',
              whyWrong: 'Simple scaling policies require manual threshold tuning and create step-function behavior. Target tracking automatically adjusts capacity to maintain a specific metric (e.g., 50% CPU), providing smoother scaling.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Implement high availability and resilient environments',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'Multi-AZ deployments for RDS, Elasticache, and EC2 Auto Scaling' },
            { id: 'ks-2.2.2', text: 'Route 53 health checks and routing policies for failover' },
            { id: 'ks-2.2.3', text: 'Amazon EFS for shared, durable storage across AZs' },
            { id: 'ks-2.2.4', text: 'S3 Cross-Region Replication for data durability' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Configuring Route 53 failover routing without associated health checks',
              whyWrong: 'Failover routing policy alone does not detect failures. Health checks must be explicitly attached to Route 53 records to monitor endpoint availability and trigger automatic DNS failover.',
            },
          ],
        },
        {
          id: 'task-2.3',
          text: 'Implement backup and restore strategies',
          knowledgeStatements: [
            { id: 'ks-2.3.1', text: 'AWS Backup for centralized backup management across services' },
            { id: 'ks-2.3.2', text: 'RDS automated backups, snapshots, and point-in-time recovery' },
            { id: 'ks-2.3.3', text: 'EBS snapshots and cross-region snapshot copy' },
            { id: 'ks-2.3.4', text: 'S3 versioning and lifecycle policies for data protection' },
            { id: 'ks-2.3.5', text: 'RTO and RPO objectives and matching them to backup/DR strategies' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.3-001',
              misconception: 'Taking backups without testing restore procedures',
              whyWrong: 'Untested backups are not guaranteed backups. Regular restore tests are the only way to confirm that backup data is complete, uncorrupted, and can be restored within the required RTO.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon EC2 Auto Scaling', category: 'Compute' },
        { name: 'Elastic Load Balancing', category: 'Networking & Content Delivery' },
        { name: 'Amazon Route 53', category: 'Networking & Content Delivery' },
        { name: 'Amazon RDS', category: 'Database' },
        { name: 'Amazon DynamoDB', category: 'Database' },
        { name: 'Amazon EFS', category: 'Storage' },
        { name: 'Amazon EBS', category: 'Storage' },
        { name: 'Amazon S3', category: 'Storage' },
        { name: 'AWS Backup', category: 'Storage' },
      ],
    },

    // ─── Domain 3: Deployment, Provisioning, and Automation (18%) ───
    {
      id: 'domain-3',
      name: 'Deployment, Provisioning, and Automation',
      weightPercent: 18,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Provision and maintain cloud resources',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'AWS CloudFormation for infrastructure as code: stacks, templates, change sets, drift detection' },
            { id: 'ks-3.1.2', text: 'AWS CDK and CloudFormation StackSets for multi-account deployments' },
            { id: 'ks-3.1.3', text: 'AWS Service Catalog for standardized resource provisioning' },
            { id: 'ks-3.1.4', text: 'Amazon Machine Images (AMIs) for standardized EC2 builds' },
            { id: 'ks-3.1.5', text: 'EC2 Launch Templates vs. Launch Configurations' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Making manual changes to CloudFormation-managed resources',
              whyWrong: 'Manual changes to CloudFormation-managed resources cause stack drift, making the template inconsistent with actual infrastructure. Use change sets to preview and apply all changes through CloudFormation.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Automate manual or repeatable processes',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'AWS Systems Manager Run Command and Session Manager' },
            { id: 'ks-3.2.2', text: 'AWS Systems Manager Patch Manager for automated OS patching' },
            { id: 'ks-3.2.3', text: 'AWS Systems Manager State Manager for configuration compliance' },
            { id: 'ks-3.2.4', text: 'AWS Lambda for operational automation' },
            { id: 'ks-3.2.5', text: 'AWS CodeDeploy for automated application deployments' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Using SSH/RDP for all EC2 remote access instead of Systems Manager Session Manager',
              whyWrong: 'SSH/RDP requires open inbound ports and key management. Session Manager provides secure, audited shell access without any inbound firewall rules or bastion hosts, and logs session activity to CloudTrail and CloudWatch Logs.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS CloudFormation', category: 'Management & Governance' },
        { name: 'AWS Service Catalog', category: 'Management & Governance' },
        { name: 'AWS Systems Manager', category: 'Management & Governance' },
        { name: 'AWS Systems Manager Patch Manager', category: 'Management & Governance' },
        { name: 'AWS Systems Manager Session Manager', category: 'Management & Governance' },
        { name: 'AWS CodeDeploy', category: 'Developer Tools' },
        { name: 'AWS OpsWorks', category: 'Management & Governance' },
        { name: 'AWS Lambda', category: 'Compute' },
        { name: 'Amazon EventBridge', category: 'Application Integration' },
      ],
    },

    // ─── Domain 4: Security and Compliance (16%) ───
    {
      id: 'domain-4',
      name: 'Security and Compliance',
      weightPercent: 16,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Implement and manage security and compliance policies',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'AWS Config rules and conformance packs for compliance monitoring' },
            { id: 'ks-4.1.2', text: 'AWS Security Hub for centralized security findings aggregation' },
            { id: 'ks-4.1.3', text: 'Amazon GuardDuty for threat detection' },
            { id: 'ks-4.1.4', text: 'AWS IAM: roles, policies, permissions boundaries, and access analyzer' },
            { id: 'ks-4.1.5', text: 'AWS Organizations SCPs for preventive guardrails' },
            { id: 'ks-4.1.6', text: 'Amazon Inspector for vulnerability scanning of EC2 and containers' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Treating Config rules as blocking controls rather than detective controls',
              whyWrong: 'AWS Config rules detect non-compliant configurations but do not prevent them. For preventive controls, use SCPs in AWS Organizations or IAM permission boundaries to block non-compliant actions before they occur.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Implement data and infrastructure protection strategies',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'Encryption at rest: EBS encryption, S3 server-side encryption, RDS encryption' },
            { id: 'ks-4.2.2', text: 'Encryption in transit: TLS/SSL enforcement, VPC traffic encryption' },
            { id: 'ks-4.2.3', text: 'AWS KMS for key management and rotation' },
            { id: 'ks-4.2.4', text: 'S3 bucket policies, ACLs, and Block Public Access settings' },
            { id: 'ks-4.2.5', text: 'VPC security: security groups, NACLs, VPC Flow Logs' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Not enabling VPC Flow Logs for network traffic analysis and security investigations',
              whyWrong: 'VPC Flow Logs capture metadata about accepted and rejected traffic, essential for security forensics, network troubleshooting, and compliance auditing. Without them, post-incident investigation has no network visibility.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Config', category: 'Management & Governance' },
        { name: 'AWS Security Hub', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon GuardDuty', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Inspector', category: 'Security, Identity, & Compliance' },
        { name: 'AWS IAM', category: 'Security, Identity, & Compliance' },
        { name: 'AWS IAM Access Analyzer', category: 'Security, Identity, & Compliance' },
        { name: 'AWS KMS', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Macie', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Organizations', category: 'Management & Governance' },
        { name: 'Amazon VPC Flow Logs', category: 'Networking & Content Delivery' },
      ],
    },

    // ─── Domain 5: Networking and Content Delivery (18%) ───
    {
      id: 'domain-5',
      name: 'Networking and Content Delivery',
      weightPercent: 18,
      tasks: [
        {
          id: 'task-5.1',
          text: 'Implement networking features and connectivity',
          knowledgeStatements: [
            { id: 'ks-5.1.1', text: 'VPC design: subnets, route tables, internet gateway, NAT gateway' },
            { id: 'ks-5.1.2', text: 'VPC peering and Transit Gateway for inter-VPC connectivity' },
            { id: 'ks-5.1.3', text: 'AWS Site-to-Site VPN and AWS Direct Connect' },
            { id: 'ks-5.1.4', text: 'VPC endpoints (Gateway and Interface) for private AWS access' },
            { id: 'ks-5.1.5', text: 'Elastic IPs, ENIs, and multi-NIC configurations' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.1-001',
              misconception: 'Using VPC peering for hub-and-spoke connectivity between many VPCs',
              whyWrong: 'VPC peering is non-transitive and requires N*(N-1)/2 peering connections for full mesh connectivity. Transit Gateway provides a scalable hub-and-spoke model for many VPCs with centralized routing management.',
            },
          ],
        },
        {
          id: 'task-5.2',
          text: 'Configure domains, DNS services, and content delivery',
          knowledgeStatements: [
            { id: 'ks-5.2.1', text: 'Amazon Route 53: hosted zones, record types (A, AAAA, CNAME, Alias, MX), routing policies' },
            { id: 'ks-5.2.2', text: 'Amazon CloudFront: distributions, origins, behaviors, cache invalidation' },
            { id: 'ks-5.2.3', text: 'CloudFront signed URLs and signed cookies for content access control' },
            { id: 'ks-5.2.4', text: 'AWS Certificate Manager for SSL/TLS certificate provisioning' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.2-001',
              misconception: 'Using CNAME records for zone apex (root domain) DNS entries',
              whyWrong: 'CNAME records cannot be used at the zone apex (e.g., example.com). Use Route 53 Alias records, which map to AWS resource DNS names at the apex and do not incur additional query charges.',
            },
          ],
        },
        {
          id: 'task-5.3',
          text: 'Troubleshoot network connectivity issues',
          knowledgeStatements: [
            { id: 'ks-5.3.1', text: 'VPC Flow Logs for network traffic analysis' },
            { id: 'ks-5.3.2', text: 'AWS Reachability Analyzer for connectivity path analysis' },
            { id: 'ks-5.3.3', text: 'EC2 network troubleshooting: security groups, NACLs, route tables' },
            { id: 'ks-5.3.4', text: 'ELB access logs and connection draining' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.3-001',
              misconception: 'Forgetting that NACLs are stateless when troubleshooting connectivity',
              whyWrong: 'Unlike security groups, NACLs require explicit rules for both inbound AND outbound traffic (including ephemeral ports 1024-65535 for response traffic). Missing return traffic rules are a common source of connectivity failures.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon VPC', category: 'Networking & Content Delivery' },
        { name: 'Amazon Route 53', category: 'Networking & Content Delivery' },
        { name: 'Amazon CloudFront', category: 'Networking & Content Delivery' },
        { name: 'AWS Transit Gateway', category: 'Networking & Content Delivery' },
        { name: 'AWS Direct Connect', category: 'Networking & Content Delivery' },
        { name: 'AWS Site-to-Site VPN', category: 'Networking & Content Delivery' },
        { name: 'Elastic Load Balancing', category: 'Networking & Content Delivery' },
        { name: 'AWS PrivateLink', category: 'Networking & Content Delivery' },
        { name: 'AWS Reachability Analyzer', category: 'Networking & Content Delivery' },
        { name: 'AWS Certificate Manager', category: 'Security, Identity, & Compliance' },
      ],
    },

    // ─── Domain 6: Cost and Performance Optimization (12%) ───
    {
      id: 'domain-6',
      name: 'Cost and Performance Optimization',
      weightPercent: 12,
      tasks: [
        {
          id: 'task-6.1',
          text: 'Implement cost optimization strategies',
          knowledgeStatements: [
            { id: 'ks-6.1.1', text: 'Right-sizing EC2 instances using CloudWatch metrics and Compute Optimizer' },
            { id: 'ks-6.1.2', text: 'Reserved Instances and Savings Plans for predictable workloads' },
            { id: 'ks-6.1.3', text: 'Spot Instances for fault-tolerant workloads' },
            { id: 'ks-6.1.4', text: 'S3 storage class optimization and Intelligent-Tiering' },
            { id: 'ks-6.1.5', text: 'AWS Cost Explorer and Budgets for cost visibility and alerting' },
          ],
          antiPatterns: [
            {
              id: 'ap-6.1-001',
              misconception: 'Not using AWS Compute Optimizer before purchasing Reserved Instances',
              whyWrong: 'Purchasing RIs for over-sized instances locks in waste. Compute Optimizer analyzes utilization patterns and recommends right-sized instances, ensuring RI purchases are for appropriately sized resources.',
            },
          ],
        },
        {
          id: 'task-6.2',
          text: 'Implement performance optimization strategies',
          knowledgeStatements: [
            { id: 'ks-6.2.1', text: 'EBS volume types and performance characteristics: gp3, io2, st1, sc1' },
            { id: 'ks-6.2.2', text: 'EC2 placement groups: cluster, spread, partition' },
            { id: 'ks-6.2.3', text: 'Enhanced networking and Elastic Fabric Adapter (EFA) for HPC' },
            { id: 'ks-6.2.4', text: 'CloudFront caching for reduced latency and origin offload' },
            { id: 'ks-6.2.5', text: 'RDS read replicas and ElastiCache for database performance' },
          ],
          antiPatterns: [
            {
              id: 'ap-6.2-001',
              misconception: 'Using gp2 volumes without considering the superior cost-performance of gp3',
              whyWrong: 'gp3 volumes provide baseline 3,000 IOPS and 125 MB/s at lower cost than gp2, with IOPS and throughput independently configurable. Migrating gp2 to gp3 typically reduces costs by 20% while maintaining or improving performance.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Cost Explorer', category: 'Cloud Financial Management' },
        { name: 'AWS Budgets', category: 'Cloud Financial Management' },
        { name: 'AWS Compute Optimizer', category: 'Management & Governance' },
        { name: 'Amazon EC2 Spot Instances', category: 'Compute' },
        { name: 'AWS Savings Plans', category: 'Cloud Financial Management' },
        { name: 'Amazon S3 Intelligent-Tiering', category: 'Storage' },
        { name: 'Amazon CloudFront', category: 'Networking & Content Delivery' },
        { name: 'Amazon ElastiCache', category: 'Database' },
        { name: 'Amazon EBS', category: 'Storage' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Application development or coding',
    'Advanced machine learning or AI services',
    'Detailed database query optimization',
    'DevOps pipeline design (covered in DVA-C02 and DOP-C02)',
    'Complex multi-account architecture patterns (covered in SAP-C02)',
  ],
};
