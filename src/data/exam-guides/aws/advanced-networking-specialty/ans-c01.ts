import type { ExamGuide } from '@/lib/types/exam-guide';

export const ansC01: ExamGuide = {
  certificationCode: 'ANS-C01',
  certificationName: 'AWS Certified Advanced Networking - Specialty',
  provider: 'aws',
  version: 'ANS-C01',
  effectiveDate: '2022-03-15',
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
    // ─── Domain 1: Network Design (30%) ───
    {
      id: 'domain-1',
      name: 'Network Design',
      weightPercent: 30,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Design a solution that incorporates edge network services',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'Amazon CloudFront: distributions, behaviors, cache policies, origin groups, signed URLs/cookies, Lambda@Edge, CloudFront Functions' },
            { id: 'ks-1.1.2', text: 'AWS Global Accelerator: standard vs. custom routing, endpoint groups, health checks' },
            { id: 'ks-1.1.3', text: 'Amazon Route 53: DNSSEC, resolver endpoints, forwarding rules, private hosted zones' },
            { id: 'ks-1.1.4', text: 'AWS WAF and Shield Advanced integration with edge services' },
            { id: 'ks-1.1.5', text: 'Edge computing patterns with Lambda@Edge and CloudFront Functions' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Using Global Accelerator and CloudFront interchangeably for all use cases',
              whyWrong: 'CloudFront is a CDN for HTTP/S content with caching at edge locations. Global Accelerator provides static anycast IPs with TCP/UDP acceleration to regional endpoints without caching. Use CloudFront for cacheable content, Global Accelerator for dynamic or non-HTTP traffic.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Not implementing DNSSEC for Route 53 public hosted zones in regulated environments',
              whyWrong: 'Without DNSSEC, DNS responses can be spoofed (DNS cache poisoning). DNSSEC cryptographically signs DNS records, allowing resolvers to verify authenticity. Required for government and financial services compliance.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Design DNS solutions',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'Route 53 Resolver: inbound and outbound resolver endpoints for hybrid DNS' },
            { id: 'ks-1.2.2', text: 'Route 53 Resolver DNS Firewall for DNS-layer threat protection' },
            { id: 'ks-1.2.3', text: 'Private hosted zones and VPC association, including cross-account association' },
            { id: 'ks-1.2.4', text: 'DNS resolution in multi-VPC and multi-account architectures' },
            { id: 'ks-1.2.5', text: 'Split-horizon DNS for different resolution for internal vs. external clients' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Not deploying Route 53 Resolver endpoints for hybrid DNS resolution',
              whyWrong: 'Without resolver endpoints, on-premises systems cannot resolve AWS private hosted zone records (using the VPC\'s +2 resolver) and vice versa. Inbound endpoints allow on-premises DNS to query AWS; outbound endpoints allow VPC to query on-premises DNS.',
            },
          ],
        },
        {
          id: 'task-1.3',
          text: 'Design solutions that integrate load balancing',
          knowledgeStatements: [
            { id: 'ks-1.3.1', text: 'ALB: listener rules, target groups, health checks, authentication, WebSockets, HTTP/2' },
            { id: 'ks-1.3.2', text: 'NLB: TCP/UDP/TLS termination, static IPs, zonal isolation, connection stickiness' },
            { id: 'ks-1.3.3', text: 'Gateway Load Balancer (GWLB): inline traffic inspection with third-party appliances' },
            { id: 'ks-1.3.4', text: 'Cross-zone load balancing, deregistration delay, slow start mode' },
            { id: 'ks-1.3.5', text: 'Load balancer access logging and integration with WAF' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.3-001',
              misconception: 'Using ALB for non-HTTP protocols like financial trading systems requiring ultra-low latency',
              whyWrong: 'ALB adds request processing overhead for Layer 7 inspection. NLB operates at Layer 4 with sub-millisecond latency and is appropriate for latency-sensitive TCP/UDP workloads, financial trading, and gaming applications.',
            },
          ],
        },
        {
          id: 'task-1.4',
          text: 'Define logging and monitoring requirements',
          knowledgeStatements: [
            { id: 'ks-1.4.1', text: 'VPC Flow Logs: format, filtering, aggregation, delivery to S3/CloudWatch/Kinesis' },
            { id: 'ks-1.4.2', text: 'Traffic Mirroring for deep packet inspection' },
            { id: 'ks-1.4.3', text: 'Network access analyzer for network access path validation' },
            { id: 'ks-1.4.4', text: 'Route 53 query logging and Resolver query logging' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.4-001',
              misconception: 'Enabling VPC Flow Logs without filtering for cost management in high-traffic environments',
              whyWrong: 'Logging all traffic in high-throughput environments generates enormous data volumes and costs. Use flow log filters to capture only relevant traffic (REJECT records for security analysis, specific source/destination for troubleshooting).',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon CloudFront', category: 'Networking & Content Delivery' },
        { name: 'AWS Global Accelerator', category: 'Networking & Content Delivery' },
        { name: 'Amazon Route 53', category: 'Networking & Content Delivery' },
        { name: 'Route 53 Resolver', category: 'Networking & Content Delivery' },
        { name: 'Route 53 Resolver DNS Firewall', category: 'Networking & Content Delivery' },
        { name: 'Elastic Load Balancing (ALB)', category: 'Networking & Content Delivery' },
        { name: 'Elastic Load Balancing (NLB)', category: 'Networking & Content Delivery' },
        { name: 'AWS Gateway Load Balancer', category: 'Networking & Content Delivery' },
        { name: 'VPC Flow Logs', category: 'Networking & Content Delivery' },
        { name: 'VPC Traffic Mirroring', category: 'Networking & Content Delivery' },
        { name: 'AWS WAF', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Shield Advanced', category: 'Security, Identity, & Compliance' },
      ],
    },

    // ─── Domain 2: Network Implementation (26%) ───
    {
      id: 'domain-2',
      name: 'Network Implementation',
      weightPercent: 26,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Implement routing and connectivity between networks',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'VPC routing: route tables, most-specific route, local routes, blackhole routes' },
            { id: 'ks-2.1.2', text: 'Transit Gateway: route tables, associations, propagations, static routes, BGP' },
            { id: 'ks-2.1.3', text: 'Transit Gateway multicast and Connect attachments' },
            { id: 'ks-2.1.4', text: 'AWS Cloud WAN for global network management' },
            { id: 'ks-2.1.5', text: 'VPC peering: same-Region, cross-Region, and cross-account peering' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Relying on Transit Gateway default route table for all routing without segmentation',
              whyWrong: 'A single default route table allows full mesh connectivity between all attached VPCs. For security segmentation (prod/dev isolation, shared services access), create separate Transit Gateway route tables with explicit associations and propagations.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Implement complex hybrid connectivity',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'AWS Direct Connect: physical connections, VIFs (public, private, transit), hosted connections' },
            { id: 'ks-2.2.2', text: 'Direct Connect Gateway for multi-Region and multi-account private connectivity' },
            { id: 'ks-2.2.3', text: 'High availability with Direct Connect: LAG, redundant connections, backup VPN' },
            { id: 'ks-2.2.4', text: 'AWS VPN: customer gateway, virtual private gateway, accelerated VPN' },
            { id: 'ks-2.2.5', text: 'BGP routing: AS path prepending, local preference, MED for path selection' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Using a single Direct Connect connection without a backup for resilient hybrid connectivity',
              whyWrong: 'A single DX connection is a single point of failure. AWS recommends two DX connections (ideally from different providers/locations) with a Site-to-Site VPN backup for maximum resiliency.',
            },
            {
              id: 'ap-2.2-002',
              misconception: 'Advertising all VPC routes over Direct Connect public VIF',
              whyWrong: 'Public VIFs advertise routes from AWS public IP space to on-premises. Advertising all VPC CIDRs over public VIF exposes them publicly. Use private VIF or transit VIF for VPC CIDR advertisement to on-premises.',
            },
          ],
        },
        {
          id: 'task-2.3',
          text: 'Implement VPC designs',
          knowledgeStatements: [
            { id: 'ks-2.3.1', text: 'CIDR planning for multi-account, multi-Region environments avoiding overlaps' },
            { id: 'ks-2.3.2', text: 'Shared VPCs using Resource Access Manager (RAM) for centralized networking' },
            { id: 'ks-2.3.3', text: 'IPv6 implementation: dual-stack VPC, egress-only internet gateway' },
            { id: 'ks-2.3.4', text: 'Security group design patterns: tiered security groups, reference by security group ID' },
            { id: 'ks-2.3.5', text: 'NACL implementation for stateless subnet-level filtering' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.3-001',
              misconception: 'Using /16 VPC CIDRs without planning subnets, causing exhaustion in large environments',
              whyWrong: 'Unplanned CIDR allocation leads to overlapping ranges preventing VPC peering and Transit Gateway attachments. Design a hierarchical CIDR plan allocating ranges per Region, account, environment, and tier to avoid exhaustion and overlaps.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon VPC', category: 'Networking & Content Delivery' },
        { name: 'AWS Transit Gateway', category: 'Networking & Content Delivery' },
        { name: 'AWS Direct Connect', category: 'Networking & Content Delivery' },
        { name: 'AWS Direct Connect Gateway', category: 'Networking & Content Delivery' },
        { name: 'AWS Site-to-Site VPN', category: 'Networking & Content Delivery' },
        { name: 'AWS Client VPN', category: 'Networking & Content Delivery' },
        { name: 'AWS Cloud WAN', category: 'Networking & Content Delivery' },
        { name: 'AWS Resource Access Manager (RAM)', category: 'Security, Identity, & Compliance' },
        { name: 'VPC Peering', category: 'Networking & Content Delivery' },
      ],
    },

    // ─── Domain 3: Network Management and Operations (20%) ───
    {
      id: 'domain-3',
      name: 'Network Management and Operations',
      weightPercent: 20,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Maintain routing and connectivity on AWS and hybrid networks',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'Monitoring BGP session health and route propagation on Direct Connect' },
            { id: 'ks-3.1.2', text: 'Transit Gateway Network Manager for global network monitoring' },
            { id: 'ks-3.1.3', text: 'Troubleshooting asymmetric routing in hybrid environments' },
            { id: 'ks-3.1.4', text: 'Route propagation in Transit Gateway and VGW' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Not monitoring BGP session status on Direct Connect connections',
              whyWrong: 'BGP session flaps on Direct Connect disrupt connectivity silently if not monitored. CloudWatch metrics for Virtual Interface BGP status and CW alarms enable proactive detection before user impact.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Monitor and analyze network traffic',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'VPC Flow Logs analysis with Athena and CloudWatch Logs Insights' },
            { id: 'ks-3.2.2', text: 'Network performance monitoring: CloudWatch metrics for VPN, DX, ELB' },
            { id: 'ks-3.2.3', text: 'AWS Network Access Analyzer for unintended network access' },
            { id: 'ks-3.2.4', text: 'Traffic Mirroring for intrusion detection and deep packet inspection' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Using Traffic Mirroring for all VPC traffic without filtering, impacting instance performance',
              whyWrong: 'Traffic Mirroring adds overhead to instance network performance when capturing all traffic. Use mirror filters to target specific protocols, ports, or source/destination to minimize impact while capturing relevant traffic for inspection.',
            },
          ],
        },
        {
          id: 'task-3.3',
          text: 'Optimize AWS networks for performance, reliability, and cost',
          knowledgeStatements: [
            { id: 'ks-3.3.1', text: 'Enhanced networking (SR-IOV) and Elastic Fabric Adapter (EFA) for HPC and distributed ML' },
            { id: 'ks-3.3.2', text: 'EC2 placement groups: cluster (low latency), spread (HA), partition (big data)' },
            { id: 'ks-3.3.3', text: 'Data transfer cost optimization: same-AZ placement, VPC endpoints, S3 Transfer Acceleration' },
            { id: 'ks-3.3.4', text: 'NAT Gateway vs. NAT instance tradeoffs' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.3-001',
              misconception: 'Routing all outbound internet traffic through a single NAT Gateway without multi-AZ redundancy',
              whyWrong: 'A single NAT Gateway in one AZ is a single point of failure for internet-bound traffic from private subnets. Deploy one NAT Gateway per AZ and configure route tables to use the local AZ NAT Gateway to eliminate cross-AZ dependency.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon CloudWatch (Network Metrics)', category: 'Management & Governance' },
        { name: 'AWS Transit Gateway Network Manager', category: 'Networking & Content Delivery' },
        { name: 'AWS Network Access Analyzer', category: 'Networking & Content Delivery' },
        { name: 'VPC Traffic Mirroring', category: 'Networking & Content Delivery' },
        { name: 'VPC Flow Logs', category: 'Networking & Content Delivery' },
        { name: 'Amazon Athena (Flow Log Analysis)', category: 'Analytics' },
        { name: 'NAT Gateway', category: 'Networking & Content Delivery' },
      ],
    },

    // ─── Domain 4: Network Security, Compliance, and Governance (24%) ───
    {
      id: 'domain-4',
      name: 'Network Security, Compliance, and Governance',
      weightPercent: 24,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Implement and maintain network security',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'AWS Network Firewall for stateful and stateless traffic inspection within VPCs' },
            { id: 'ks-4.1.2', text: 'AWS WAF: managed rule groups, custom rules, rate limiting, geo-blocking' },
            { id: 'ks-4.1.3', text: 'Security group design: least-privilege, layered security, reference by SG ID' },
            { id: 'ks-4.1.4', text: 'Centralized security inspection architecture with Gateway Load Balancer' },
            { id: 'ks-4.1.5', text: 'AWS Firewall Manager for centralized policy enforcement across accounts' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Using security groups as the only layer of defense for critical workloads',
              whyWrong: 'Security groups are the last line of defense. Defense-in-depth requires Network Firewall for Layer 7 inspection, NACLs for subnet-level stateless filtering, and WAF for HTTP attack prevention. Layering controls limits blast radius.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Validate and audit security by using network and application monitoring tools',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'Amazon GuardDuty for network-layer threat detection using VPC Flow Logs and DNS logs' },
            { id: 'ks-4.2.2', text: 'AWS Security Hub for centralized network security findings' },
            { id: 'ks-4.2.3', text: 'IAM Access Analyzer for network accessibility analysis of resources' },
            { id: 'ks-4.2.4', text: 'AWS Config rules for network configuration compliance' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Treating VPC Flow Log analysis as sufficient for threat detection',
              whyWrong: 'Flow Logs capture connection metadata but not DNS queries or Layer 7 attack patterns. GuardDuty integrates Flow Logs with threat intelligence and DNS logs to detect C2 communication, port scanning, and data exfiltration that Flow Logs alone miss.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Network Firewall', category: 'Networking & Content Delivery' },
        { name: 'AWS WAF', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Shield Advanced', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Firewall Manager', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon GuardDuty', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Security Hub', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Config', category: 'Management & Governance' },
        { name: 'AWS IAM Access Analyzer', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Gateway Load Balancer', category: 'Networking & Content Delivery' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Application layer development',
    'Database or storage service-specific configuration',
    'ML/AI service configuration',
    'Physical data center networking (on-premises switching and routing specifics)',
    'Basic VPC concepts covered in associate certifications',
  ],
};
