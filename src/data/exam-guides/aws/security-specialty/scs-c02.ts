import type { ExamGuide } from '@/lib/types/exam-guide';

export const scsC02: ExamGuide = {
  certificationCode: 'SCS-C02',
  certificationName: 'AWS Certified Security - Specialty',
  provider: 'aws',
  version: 'SCS-C02',
  effectiveDate: '2023-07-11',
  status: 'current',
  tier: 'specialty' as const,
  examFormat: {
    totalQuestions: 65,
    scoredQuestions: 50,
    unscoredQuestions: 15,
    duration: 170,
    passingScore: 750,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    // ─── Domain 1: Threat Detection and Incident Response (14%) ───
    {
      id: 'domain-1',
      name: 'Threat Detection and Incident Response',
      weightPercent: 14,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Design and implement an incident response plan',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'Amazon GuardDuty: threat intelligence, finding types, suppression rules, multi-account' },
            { id: 'ks-1.1.2', text: 'GuardDuty finding remediation with EventBridge and Lambda' },
            { id: 'ks-1.1.3', text: 'Incident response playbooks: isolation, forensics, recovery' },
            { id: 'ks-1.1.4', text: 'EC2 forensics: isolating compromised instances, EBS snapshot capture, memory acquisition' },
            { id: 'ks-1.1.5', text: 'IAM credential compromise response: key rotation, session revocation, AWS STS' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Terminating a compromised EC2 instance immediately before preserving evidence',
              whyWrong: 'Terminating an instance destroys volatile memory and forensic evidence. Isolate first: remove from load balancer, change security groups to block all traffic, take EBS snapshots, and capture memory before termination.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Rotating IAM access keys without also invalidating active sessions',
              whyWrong: 'Rotating a compromised IAM access key deactivates the key but not active STS sessions. Use an explicit deny policy based on time-of-issue to invalidate all sessions issued before the compromise event.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Detect security threats and anomalies by using AWS services',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'Amazon Security Hub: finding aggregation, standards (CIS, PCI DSS, NIST, AWS FSBP)' },
            { id: 'ks-1.2.2', text: 'Amazon Macie for S3 PII and sensitive data discovery' },
            { id: 'ks-1.2.3', text: 'AWS Config for unauthorized configuration changes detection' },
            { id: 'ks-1.2.4', text: 'CloudTrail Insights for unusual API activity detection' },
            { id: 'ks-1.2.5', text: 'VPC Flow Logs analysis for network-layer anomaly detection' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Relying solely on GuardDuty without Security Hub for a complete threat picture',
              whyWrong: 'GuardDuty detects threats but operates in isolation. Security Hub aggregates findings from GuardDuty, Inspector, Macie, Config, and third-party tools into a prioritized, normalized view for triage and response.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon GuardDuty', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Security Hub', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Macie', category: 'Security, Identity, & Compliance' },
        { name: 'AWS CloudTrail', category: 'Management & Governance' },
        { name: 'AWS CloudTrail Insights', category: 'Management & Governance' },
        { name: 'AWS Config', category: 'Management & Governance' },
        { name: 'Amazon EventBridge', category: 'Application Integration' },
        { name: 'VPC Flow Logs', category: 'Networking & Content Delivery' },
        { name: 'AWS Systems Manager Incident Manager', category: 'Management & Governance' },
      ],
    },

    // ─── Domain 2: Security Logging and Monitoring (18%) ───
    {
      id: 'domain-2',
      name: 'Security Logging and Monitoring',
      weightPercent: 18,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Design and implement monitoring and alerting to address security events',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'CloudTrail: organization trails, log file validation, S3 delivery, CloudWatch Logs integration' },
            { id: 'ks-2.1.2', text: 'CloudWatch metric filters on CloudTrail logs for security alerting' },
            { id: 'ks-2.1.3', text: 'EventBridge rules for automated security response workflows' },
            { id: 'ks-2.1.4', text: 'AWS Security Lake for centralized security data aggregation (OCSF format)' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Not enabling CloudTrail log file validation',
              whyWrong: 'Without log file validation, tampered or deleted CloudTrail logs are undetectable. Validation creates a hash for each log file and a signed digest, allowing verification that log files have not been modified or deleted.',
            },
            {
              id: 'ap-2.1-002',
              misconception: 'Using per-account CloudTrail trails instead of an organization trail',
              whyWrong: 'Per-account trails require account-by-account configuration and can be disabled by account administrators. Organization trails are centrally managed, cannot be disabled by member accounts, and aggregate all account logs to a central S3 bucket.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Troubleshoot security monitoring and alerting',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'Diagnosing missing CloudTrail events for specific services or API calls' },
            { id: 'ks-2.2.2', text: 'CloudTrail data events vs. management events configuration' },
            { id: 'ks-2.2.3', text: 'GuardDuty finding suppression for false positive management' },
            { id: 'ks-2.2.4', text: 'Security Hub finding filtering and workflow status management' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Enabling all CloudTrail data events on every S3 bucket and Lambda function without cost evaluation',
              whyWrong: 'Data events (S3 object-level, Lambda invoke, DynamoDB item-level) generate extremely high volumes and cost in high-traffic environments. Selectively enable data events for sensitive buckets, Lambda functions, and tables only.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS CloudTrail', category: 'Management & Governance' },
        { name: 'AWS CloudTrail Lake', category: 'Management & Governance' },
        { name: 'Amazon CloudWatch (Security Alarms)', category: 'Management & Governance' },
        { name: 'Amazon EventBridge', category: 'Application Integration' },
        { name: 'Amazon Security Lake', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon OpenSearch Service (SIEM)', category: 'Analytics' },
        { name: 'Amazon Kinesis Data Firehose', category: 'Analytics' },
      ],
    },

    // ─── Domain 3: Infrastructure Security (20%) ───
    {
      id: 'domain-3',
      name: 'Infrastructure Security',
      weightPercent: 20,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Design and implement security controls for edge services',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'AWS WAF: custom rules, managed rule groups, rate-based rules, geo-restriction, bot control' },
            { id: 'ks-3.1.2', text: 'AWS Shield Standard and Shield Advanced for DDoS protection' },
            { id: 'ks-3.1.3', text: 'CloudFront security: HTTPS enforcement, security headers, origin access control (OAC)' },
            { id: 'ks-3.1.4', text: 'AWS Firewall Manager for centralized WAF and Shield policy management' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Relying on AWS Shield Standard for sophisticated DDoS attacks against high-value targets',
              whyWrong: 'Shield Standard provides automatic protection against common Layer 3/4 attacks. For application-layer (Layer 7) DDoS and advanced attacks, Shield Advanced provides additional detection, SRT access, cost protection, and near-real-time attack visibility.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Design and implement security controls for compute workloads',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'EC2 security: security groups, instance metadata v2 (IMDSv2), Systems Manager Session Manager' },
            { id: 'ks-3.2.2', text: 'Amazon Inspector for vulnerability scanning of EC2 and container images' },
            { id: 'ks-3.2.3', text: 'Container security: ECR image scanning, ECS task role least privilege, Fargate isolation' },
            { id: 'ks-3.2.4', text: 'Lambda security: execution roles, VPC configuration, resource-based policies' },
            { id: 'ks-3.2.5', text: 'AWS Systems Manager Patch Manager and Compliance for fleet patching' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Using IMDSv1 on EC2 instances in production environments',
              whyWrong: 'IMDSv1 is vulnerable to SSRF attacks where a compromised application can query the metadata service to retrieve IAM credentials. IMDSv2 requires a PUT request with a session token, blocking most SSRF-based credential theft attacks.',
            },
          ],
        },
        {
          id: 'task-3.3',
          text: 'Troubleshoot a secure network infrastructure',
          knowledgeStatements: [
            { id: 'ks-3.3.1', text: 'Security group and NACL troubleshooting for connectivity issues' },
            { id: 'ks-3.3.2', text: 'VPC Reachability Analyzer for end-to-end path analysis' },
            { id: 'ks-3.3.3', text: 'AWS Network Firewall for stateful inspection within VPCs' },
            { id: 'ks-3.3.4', text: 'VPC endpoint policies and their interaction with resource-based policies' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.3-001',
              misconception: 'Troubleshooting connectivity by loosening security groups instead of using systematic diagnostic tools',
              whyWrong: 'Loosening security groups to resolve issues creates security vulnerabilities and leaves them misconfigured. Use VPC Reachability Analyzer and Flow Logs to systematically identify the exact restriction before making targeted changes.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS WAF', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Shield Advanced', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Firewall Manager', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Inspector', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Network Firewall', category: 'Networking & Content Delivery' },
        { name: 'AWS Systems Manager', category: 'Management & Governance' },
        { name: 'Amazon ECR (image scanning)', category: 'Containers' },
        { name: 'VPC Reachability Analyzer', category: 'Networking & Content Delivery' },
        { name: 'Amazon VPC Endpoints', category: 'Networking & Content Delivery' },
      ],
    },

    // ─── Domain 4: Identity and Access Management (16%) ───
    {
      id: 'domain-4',
      name: 'Identity and Access Management',
      weightPercent: 16,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Design, implement, and troubleshoot authentication for AWS resources',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'IAM policy types: identity-based, resource-based, SCPs, permission boundaries, session policies' },
            { id: 'ks-4.1.2', text: 'IAM policy evaluation logic: explicit deny → SCP → permission boundary → identity policy → resource policy' },
            { id: 'ks-4.1.3', text: 'AWS IAM Identity Center: SSO for workforce access with SAML 2.0 and OIDC integration' },
            { id: 'ks-4.1.4', text: 'STS: AssumeRole, AssumeRoleWithWebIdentity, AssumeRoleWithSAML' },
            { id: 'ks-4.1.5', text: 'IAM Access Analyzer: unused access, external access, policy validation' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Not understanding that explicit deny always wins in IAM policy evaluation',
              whyWrong: 'Regardless of any allow statement, an explicit deny in any policy (identity, resource, SCP, or permission boundary) blocks the action. This is the most common source of "access denied" issues in complex multi-policy environments.',
            },
            {
              id: 'ap-4.1-002',
              misconception: 'Creating IAM users for human access instead of using IAM Identity Center',
              whyWrong: 'IAM users have long-term credentials requiring manual rotation. IAM Identity Center provides time-limited credentials through SSO, integrates with corporate identity providers (Active Directory, Okta), and centralizes access management.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Design and implement authorization for AWS services',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'Attribute-based access control (ABAC) using IAM condition keys and tags' },
            { id: 'ks-4.2.2', text: 'Cross-account access patterns: resource-based policies vs. cross-account role assumption' },
            { id: 'ks-4.2.3', text: 'Service-linked roles and their permissions' },
            { id: 'ks-4.2.4', text: 'AWS Organizations and SCP strategies for preventive controls' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Granting cross-account access via broad trust policies without condition keys',
              whyWrong: 'Without condition keys (aws:PrincipalOrgID, sts:ExternalId for third parties), trust policies can be exploited through confused deputy attacks. Always use ExternalId for third-party access and PrincipalOrgID for internal cross-account access.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS IAM', category: 'Security, Identity, & Compliance' },
        { name: 'AWS IAM Identity Center', category: 'Security, Identity, & Compliance' },
        { name: 'AWS IAM Access Analyzer', category: 'Security, Identity, & Compliance' },
        { name: 'AWS STS', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Organizations', category: 'Management & Governance' },
        { name: 'Amazon Cognito', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Directory Service', category: 'Security, Identity, & Compliance' },
      ],
    },

    // ─── Domain 5: Data Protection (18%) ───
    {
      id: 'domain-5',
      name: 'Data Protection',
      weightPercent: 18,
      tasks: [
        {
          id: 'task-5.1',
          text: 'Design and implement controls that provide confidentiality and integrity for data at rest',
          knowledgeStatements: [
            { id: 'ks-5.1.1', text: 'AWS KMS: customer-managed keys, key policies, grants, multi-Region keys, key rotation' },
            { id: 'ks-5.1.2', text: 'AWS CloudHSM for FIPS 140-2 Level 3 key management and custom key store' },
            { id: 'ks-5.1.3', text: 'S3 encryption: SSE-S3, SSE-KMS, SSE-C, DSSE-KMS, client-side encryption' },
            { id: 'ks-5.1.4', text: 'RDS, Aurora, EBS, EFS encryption with KMS' },
            { id: 'ks-5.1.5', text: 'S3 Object Lock (WORM) for regulatory compliance and ransomware protection' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.1-001',
              misconception: 'Using S3 default encryption (SSE-S3) for data subject to compliance requiring key audit trails',
              whyWrong: 'SSE-S3 uses AWS-managed keys with no customer-controlled key policy or CloudTrail audit. SSE-KMS with a customer-managed KMS key provides detailed key usage logs, custom key policies, and granular access control required by HIPAA, PCI DSS, and FedRAMP.',
            },
          ],
        },
        {
          id: 'task-5.2',
          text: 'Design and implement controls that provide confidentiality and integrity for data in transit',
          knowledgeStatements: [
            { id: 'ks-5.2.1', text: 'TLS certificate management with ACM and third-party CAs' },
            { id: 'ks-5.2.2', text: 'HTTPS enforcement on S3, API Gateway, CloudFront, and ELB' },
            { id: 'ks-5.2.3', text: 'AWS Certificate Manager Private CA for internal certificate authority' },
            { id: 'ks-5.2.4', text: 'VPN and Direct Connect for encrypted hybrid connectivity' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.2-001',
              misconception: 'Allowing HTTP traffic alongside HTTPS on load balancers without HTTP-to-HTTPS redirect',
              whyWrong: 'Mixed HTTP/HTTPS allows unencrypted transmission if clients use HTTP. Configure ALB listener rules to permanently redirect (301) all HTTP traffic to HTTPS, ensuring all data in transit is encrypted.',
            },
          ],
        },
        {
          id: 'task-5.3',
          text: 'Implement lifecycle management of data',
          knowledgeStatements: [
            { id: 'ks-5.3.1', text: 'AWS Secrets Manager for secret lifecycle: creation, rotation, versioning, deletion' },
            { id: 'ks-5.3.2', text: 'S3 lifecycle policies for data retention and automated deletion' },
            { id: 'ks-5.3.3', text: 'KMS key deletion (7-30 day waiting period) and key disabling' },
            { id: 'ks-5.3.4', text: 'Data residency controls with S3 Object Ownership and bucket location constraints' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.3-001',
              misconception: 'Immediately deleting a KMS key when removing encrypted resources',
              whyWrong: 'Deleting a KMS key before all encrypted data is decrypted or re-encrypted permanently destroys access to that data. Always schedule key deletion only after confirming no resources depend on it, and use the mandatory 7-30 day waiting period.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS KMS', category: 'Security, Identity, & Compliance' },
        { name: 'AWS CloudHSM', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Secrets Manager', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Certificate Manager (ACM)', category: 'Security, Identity, & Compliance' },
        { name: 'ACM Private CA', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon S3 (Encryption & Object Lock)', category: 'Storage' },
        { name: 'Amazon Macie', category: 'Security, Identity, & Compliance' },
      ],
    },

    // ─── Domain 6: Management and Security Governance (14%) ───
    {
      id: 'domain-6',
      name: 'Management and Security Governance',
      weightPercent: 14,
      tasks: [
        {
          id: 'task-6.1',
          text: 'Develop a strategy to centrally deploy and manage AWS accounts',
          knowledgeStatements: [
            { id: 'ks-6.1.1', text: 'AWS Control Tower for multi-account governance and landing zone' },
            { id: 'ks-6.1.2', text: 'AWS Organizations: OU hierarchy design, SCP strategy, account vending' },
            { id: 'ks-6.1.3', text: 'AWS Config conformance packs for multi-account compliance' },
            { id: 'ks-6.1.4', text: 'Security Hub cross-account and cross-Region aggregation' },
          ],
          antiPatterns: [
            {
              id: 'ap-6.1-001',
              misconception: 'Using a single AWS account for all environments and workloads',
              whyWrong: 'A single account provides no blast radius containment, no environment isolation, and no workload-level access control. Multi-account strategy isolates blast radius, enables environment separation, and simplifies compliance scoping.',
            },
          ],
        },
        {
          id: 'task-6.2',
          text: 'Implement a secure and consistent deployment strategy',
          knowledgeStatements: [
            { id: 'ks-6.2.1', text: 'CloudFormation security best practices: StackSets with SCPs, drift detection' },
            { id: 'ks-6.2.2', text: 'AWS Service Catalog for compliant resource provisioning' },
            { id: 'ks-6.2.3', text: 'AWS Audit Manager for automated compliance evidence collection' },
            { id: 'ks-6.2.4', text: 'Preventive vs. detective vs. corrective control classification' },
          ],
          antiPatterns: [
            {
              id: 'ap-6.2-001',
              misconception: 'Relying only on detective controls (Config, GuardDuty) without preventive controls (SCPs, permission boundaries)',
              whyWrong: 'Detective controls find issues after the fact. Preventive controls (SCPs, IAM permission boundaries, service-specific conditions) block non-compliant actions before they occur, reducing remediation cost and compliance risk.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Control Tower', category: 'Management & Governance' },
        { name: 'AWS Organizations', category: 'Management & Governance' },
        { name: 'AWS Config', category: 'Management & Governance' },
        { name: 'AWS Audit Manager', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Security Hub', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Service Catalog', category: 'Management & Governance' },
        { name: 'AWS CloudFormation (StackSets)', category: 'Management & Governance' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Basic cloud concepts and services (covered in CLF-C02 and associate certs)',
    'Application code security (covered in DVA-C02)',
    'Advanced ML/AI security (requires specialty knowledge)',
    'Physical security controls (AWS responsibility)',
  ],
};
