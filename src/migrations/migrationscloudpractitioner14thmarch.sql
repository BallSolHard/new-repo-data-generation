-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: CLF-C02
-- Generated: 2026-03-14T20:37:40.241Z
-- Questions: 51 (51 validated, 9 rejected)
-- Quiz ID: quiz_domain60_13
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_60_1
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_110',
  'A startup is evaluating the cost advantages of migrating to the AWS Cloud. Order the following concepts from a broad financial shift to a specific pricing mechanism.',
  'ordering',
  '["Reduced Capital Expenditure (CapEx)","Pay-as-you-go pricing","Economies of scale","Elimination of capacity planning"]'::json,
  '{0,2,3,1}',
  'The migration to cloud computing fundamentally shifts costs. Option A (Reduced Capital Expenditure) represents a broad financial benefit of moving from upfront hardware purchases. Option C (Economies of scale) explains how large cloud providers achieve cost efficiencies. Option D (Elimination of capacity planning) is a specific operational benefit that reduces waste. Option B (Pay-as-you-go pricing) is the most direct and specific pricing model that enables these savings. The logical flow is from the general reduction in CapEx, enabled by economies of scale and better planning, to the specific pay-as-you-go model.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  1,
  NULL,
  NULL,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_111',
  'To effectively leverage the AWS global infrastructure, a new user should understand its hierarchical components. Order these components from the broadest geographical scope to the most specific physical location.',
  'ordering',
  '["Availability Zones","Regions","Data centers","Edge Locations"]'::json,
  '{1,0,2,3}',
  'The AWS global infrastructure is structured hierarchically. Option B (Regions) are large, geographically distinct areas. Option A (Availability Zones) are isolated locations within a Region. Option C (Data centers) are the physical facilities within an Availability Zone. Option D (Edge Locations) are distinct from the Region/AZ hierarchy for compute/storage, serving content delivery globally, but are specific points of presence. The correct order is Regions, then Availability Zones within them, then the Data Centers that make up an AZ, and finally Edge Locations as specialized global points.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  2,
  NULL,
  NULL,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_112',
  'A company is seeking to improve its business agility by adopting AWS. Order the following aspects by how they contribute to faster innovation and deployment.',
  'ordering',
  '["Reduced time-to-market","Global deployment capabilities","Rapid resource provisioning","Ability to experiment quickly"]'::json,
  '{2,3,1,0}',
  'Improving business agility on AWS involves several interconnected benefits. Option C (Rapid resource provisioning) is the immediate enabler for speed. This speed allows for Option D (Ability to experiment quickly) without significant upfront investment. Once validated, Option B (Global deployment capabilities) allows for broad reach. All these contribute to Option A (Reduced time-to-market) for new features and products. The sequence progresses from provisioning resources, to experimentation, to global reach, and ultimately to faster market entry.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  3,
  NULL,
  NULL,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_113',
  'When considering the high availability and fault tolerance of AWS infrastructure, certain components work together to provide isolation. Order these components from the largest scope of isolation to the smallest.',
  'ordering',
  '["Logical partitions within a data center","Regions","Availability Zones","Data centers"]'::json,
  '{1,2,3,0}',
  'AWS infrastructure is designed for high availability through isolation. Option B (Regions) provide the broadest level of isolation, being geographically separate. Option C (Availability Zones) are isolated locations within a Region, designed to be independent failure domains. Option D (Data centers) are the physical facilities within an Availability Zone. Option A (Logical partitions within a data center) represent further isolation within a single data center. The correct order moves from the widest geographical separation to increasingly granular levels of isolation.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  4,
  NULL,
  NULL,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_114',
  'A startup wants to demonstrate the elasticity of the AWS Cloud by scaling their web application based on demand. Arrange the following actions in the logical sequence to achieve this.',
  'ordering',
  '["Configure an Auto Scaling group with desired capacity and scaling policies.","Deploy the web application to Amazon EC2 instances.","Set up an Application Load Balancer to distribute incoming traffic.","Define Amazon CloudWatch alarms to trigger scaling actions."]'::json,
  '{1,2,0,3}',
  'To demonstrate elasticity, the logical sequence is to first deploy the application (Option B), then set up a load balancer to distribute traffic (Option C), configure an Auto Scaling group to manage the instances (Option A), and finally define CloudWatch alarms to dynamically adjust capacity based on metrics (Option D). This allows the application to scale out and in automatically in response to demand.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  5,
  NULL,
  NULL,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_115',
  'An organization is evaluating the overall value proposition of migrating to the AWS Cloud. Order the following core aspects of the AWS value proposition from foundational to advanced.',
  'ordering',
  '["Achieving global reach and deploying worldwide in minutes.","Benefiting from economies of scale and reduced costs.","Increasing agility and innovation for rapid experimentation.","Eliminating the need for capacity planning."]'::json,
  '{1,3,2,0}',
  'The foundational aspect of the AWS value proposition is benefiting from economies of scale and reduced costs (Option B). This naturally leads to eliminating the need for capacity planning (Option D). With these in place, organizations can then increase agility and innovation (Option C), ultimately enabling them to achieve global reach and deploy worldwide in minutes (Option A).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  6,
  NULL,
  NULL,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_116',
  'An international company wants to leverage the AWS global infrastructure to serve customers with low latency. Order the following benefits of AWS global infrastructure from most direct to broader impact.',
  'ordering',
  '["Providing disaster recovery capabilities across regions.","Enabling compliance with data residency requirements.","Reducing latency for end-users worldwide.","Facilitating rapid global deployment of applications."]'::json,
  '{2,3,1,0}',
  'The most direct benefit of AWS global infrastructure for end-users is reducing latency for end-users worldwide (Option C). This capability then facilitates rapid global deployment of applications (Option D). As a broader impact, it enables compliance with data residency requirements by allowing data to be stored in specific geographic locations (Option B). Finally, it provides robust disaster recovery capabilities across regions, enhancing business continuity (Option A).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  7,
  NULL,
  NULL,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_117',
  'A company is performing a basic Total Cost of Ownership (TCO) comparison between their on-premises infrastructure and migrating to the AWS Cloud. Order the following steps for this comparison.',
  'ordering',
  '["Estimate the operational costs of the cloud environment (e.g., compute, storage, networking).","Identify all current on-premises costs (e.g., hardware, software, power, cooling, labor).","Project future growth and scalability needs for both environments.","Calculate the total cost over a specified period for both scenarios."]'::json,
  '{1,0,2,3}',
  'The first step in a TCO comparison is to identify all current on-premises costs (Option B) to establish a baseline. Next, estimate the operational costs of the cloud environment (Option A), considering pay-as-you-go models. Then, project future growth and scalability needs for both environments (Option C) to account for future expenses. Finally, calculate the total cost over a specified period for both scenarios (Option D) to make an informed comparison.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  8,
  NULL,
  NULL,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_118',
  'A startup is planning to leverage the AWS Cloud to launch a new global service. They want to ensure their application can handle unpredictable user demand and provide a consistent experience worldwide. Order the following steps to effectively realize the benefits of AWS''s global infrastructure and elasticity.',
  'ordering',
  '["Deploy the application across multiple AWS Regions and Availability Zones.","Utilize Amazon CloudFront to cache content closer to end-users globally.","Implement Auto Scaling groups for compute resources to automatically adjust capacity.","Design the application to be stateless and loosely coupled."]'::json,
  '{3,0,2,1}',
  'To effectively leverage AWS''s global infrastructure and elasticity, the foundational step is to design the application to be stateless and loosely coupled (Option D), which is a prerequisite for scaling and multi-region deployment. Next, deploy the application across multiple AWS Regions and Availability Zones (Option A) to achieve global reach and high availability. Following this, implement Auto Scaling groups (Option C) to automatically adjust compute capacity based on demand, ensuring elasticity. Finally, utilize Amazon CloudFront (Option B) to cache content at edge locations, reducing latency for end-users worldwide and improving global performance.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  9,
  NULL,
  NULL,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_119',
  'A company is evaluating the financial benefits of migrating its on-premises data center to the AWS Cloud. They want to understand how AWS''s pricing model and scale contribute to cost savings over time. Order the following aspects in a logical sequence to assess the Total Cost of Ownership (TCO) comparison.',
  'ordering',
  '["Calculate the operational costs, including power, cooling, and maintenance for both environments.","Determine the capital expenditure (CapEx) for on-premises hardware and software licenses.","Estimate the potential for cost savings through AWS''s pay-as-you-go model and economies of scale.","Factor in the agility and speed benefits, which indirectly reduce time-to-market and increase revenue potential."]'::json,
  '{1,0,2,3}',
  'When assessing TCO, the initial step is to determine the capital expenditure (CapEx) for on-premises hardware and software licenses (Option B), as this represents a significant upfront cost. Next, calculate the ongoing operational costs for both environments (Option A), including power, cooling, and maintenance, to get a full picture of recurring expenses. Then, estimate the potential for cost savings through AWS''s pay-as-you-go model and economies of scale (Option C), which are direct financial benefits. Finally, factor in the agility and speed benefits (Option D), as these strategic advantages indirectly contribute to TCO reduction by improving business outcomes and revenue potential.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  10,
  NULL,
  NULL,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_120',
  'An organization is looking to benefit from the agility and elasticity of the AWS Cloud for its new project. They need to understand the typical progression of how these benefits are realized. Order the following stages from initial adoption to advanced optimization.',
  'ordering',
  '["Rapidly provision and de-provision resources as demand fluctuates, avoiding over-provisioning.","Eliminate the need for upfront capital expenditure on infrastructure.","Experiment with new services and features quickly without significant upfront investment.","Automate infrastructure deployment and management, reducing manual effort and errors."]'::json,
  '{1,2,0,3}',
  'The journey to realizing cloud benefits typically starts with eliminating the need for upfront capital expenditure (Option B), shifting to an operational expense model. This then enables the ability to experiment with new services and features quickly (Option C) due to the pay-as-you-go nature. Following this, organizations can rapidly provision and de-provision resources (Option A) to match demand, which is the core of elasticity. Finally, as maturity grows, they can automate infrastructure deployment and management (Option D), further enhancing agility and reducing operational overhead.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  11,
  NULL,
  NULL,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_121',
  'A development team is building a new application on AWS and wants to ensure it is highly available and fault-tolerant. They need to understand the fundamental architectural elements that contribute to these benefits. Order the following AWS infrastructure components from the broadest scope to the most specific for achieving resilience.',
  'ordering',
  '["Deploying resources across multiple Availability Zones within an AWS Region.","Distributing workloads across multiple AWS Regions.","Utilizing redundant power and networking within a single data center.","Placing instances behind an Elastic Load Balancer (ELB) for traffic distribution."]'::json,
  '{1,0,3,2}',
  'To achieve the highest level of resilience, the broadest scope is distributing workloads across multiple AWS Regions (Option B) to protect against widespread regional disasters. Within a chosen region, deploying resources across multiple Availability Zones (Option A) provides isolation from failures in a single data center. For applications within these AZs, placing instances behind an Elastic Load Balancer (ELB) (Option D) distributes traffic and ensures that if one instance fails, others can take over. Finally, utilizing redundant power and networking within a single data center (Option C) is a foundational physical layer benefit provided by AWS within each Availability Zone, but it is the most specific and lowest-level component in this ordering of architectural design choices.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  12,
  NULL,
  NULL,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_60_4
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_76',
  'A developer is designing a new application on AWS and wants to follow the AWS Well-Architected Framework. Order these pillars as they might typically be considered during the initial design phase.',
  'ordering',
  '["Security","Cost Optimization","Operational Excellence","Reliability"]'::json,
  '{2,0,3,1}',
  'The AWS Well-Architected Framework provides guidance across six pillars. While all are important, a common approach to initial design often starts with how the system will be run and secured. Option C (Operational Excellence) focuses on running and monitoring systems effectively. Option A (Security) is paramount for protecting data and systems. Option D (Reliability) ensures the system performs its intended function correctly and consistently. Option B (Cost Optimization) is typically considered after the core functional and non-functional requirements are established. The sequence reflects a logical progression from operations to security, then reliability, and finally cost.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  13,
  NULL,
  NULL,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_77',
  'To build a highly elastic application on AWS, certain design principles are key. Order these principles by their typical implementation sequence for achieving automatic scaling.',
  'ordering',
  '["Monitor performance metrics","Design for statelessness","Implement auto scaling","Decouple components"]'::json,
  '{1,3,0,2}',
  'Building an elastic application involves a series of design considerations. Option B (Design for statelessness) is fundamental, as it allows instances to be added or removed without session data issues. Option D (Decouple components) ensures that individual parts of the application can scale independently. Option A (Monitor performance metrics) is crucial for identifying when scaling is needed. Finally, Option C (Implement auto scaling) uses these metrics to automatically adjust capacity. The correct sequence is to first ensure statelessness, then decouple, then monitor, and finally implement auto scaling.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  14,
  NULL,
  NULL,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_78',
  'An architect is planning for fault tolerance in an application on AWS. Order these common approaches from the most fundamental concept to a more comprehensive strategy.',
  'ordering',
  '["Implement automated failover","Use multiple Regions","Design for redundancy","Distribute resources across Availability Zones"]'::json,
  '{2,3,0,1}',
  'Fault tolerance is built through layers of design. Option C (Design for redundancy) is the foundational concept of having duplicate components. Option D (Distribute resources across Availability Zones) applies redundancy across physically isolated locations. Option A (Implement automated failover) ensures that redundant components are automatically used upon failure. Option B (Use multiple Regions) provides the highest level of fault tolerance against widespread disasters. The sequence progresses from basic redundancy to multi-AZ deployment, then automated recovery, and finally multi-Region disaster recovery.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  15,
  NULL,
  NULL,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_79',
  'When adopting Infrastructure as Code (IaC) on AWS, certain benefits are realized sequentially. Order these benefits from the initial setup to long-term operational advantages.',
  'ordering',
  '["Automate deployments","Improve consistency","Version control infrastructure","Enable rapid rollback"]'::json,
  '{2,0,1,3}',
  'Infrastructure as Code (IaC) provides a structured approach to managing infrastructure. Option C (Version control infrastructure) is an initial step, treating infrastructure definitions like application code. This enables Option A (Automate deployments) through scripts or templates. Automation, in turn, helps to Option B (Improve consistency) across environments. A consistent, version-controlled infrastructure then allows for Option D (Enable rapid rollback) to previous stable states. The order moves from versioning, to automation, to consistency, and finally to recovery capabilities.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  16,
  NULL,
  NULL,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_80',
  'To achieve operational excellence on AWS, a team should prioritize certain practices. Order these practices from foundational measurement to continuous improvement.',
  'ordering',
  '["Automate routine tasks","Learn from operational events","Define operational metrics","Implement monitoring and alerting"]'::json,
  '{2,3,0,1}',
  'Operational excellence on AWS involves a cycle of measurement, action, and learning. Option C (Define operational metrics) is the foundational step to understand system health and performance. Option D (Implement monitoring and alerting) uses these metrics to detect issues. Option A (Automate routine tasks) reduces manual effort and errors. Finally, Option B (Learn from operational events) drives continuous improvement by analyzing incidents. The sequence represents a continuous feedback loop for operations.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  17,
  NULL,
  NULL,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_81',
  'A solutions architect is reviewing an application''s architecture against the AWS Well-Architected Framework. Order the following pillars in a typical assessment flow, starting with foundational concerns.',
  'ordering',
  '["Operational Excellence","Reliability","Security","Cost Optimization"]'::json,
  '{2,1,0,3}',
  'While all pillars are important, Security (Option C) is often considered foundational, as it underpins all other aspects. Reliability (Option B) ensures the system performs its intended function correctly and consistently. Operational Excellence (Option A) focuses on running and monitoring systems to deliver business value and continuously improve processes. Cost Optimization (Option D) is typically addressed after the core functional and non-functional requirements are met, ensuring efficiency without compromising other pillars.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  18,
  NULL,
  NULL,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_82',
  'A development team wants to design a fault-tolerant application on AWS that can recover from individual component failures. Order the following design principles to achieve this goal.',
  'ordering',
  '["Implement automatic recovery from failure.","Decouple components to prevent cascading failures.","Design for failure by anticipating potential issues.","Test recovery procedures regularly."]'::json,
  '{2,1,0,3}',
  'To design a fault-tolerant application, the first step is to design for failure by anticipating potential issues (Option C). This leads to decoupling components to prevent cascading failures (Option B), ensuring that a failure in one part does not bring down the entire system. Next, implement automatic recovery from failure (Option A) to minimize manual intervention. Finally, test recovery procedures regularly (Option D) to validate their effectiveness and ensure the system can indeed recover as expected.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  19,
  NULL,
  NULL,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_83',
  'A company is adopting Infrastructure as Code (IaC) to automate its cloud deployments. Order the following benefits of automation in cloud operations, starting with the most immediate.',
  'ordering',
  '["Enabling rapid and consistent deployments.","Reducing human error and manual effort.","Improving security and compliance through standardized configurations.","Facilitating quick recovery from failures by redeploying."]'::json,
  '{1,0,2,3}',
  'The most immediate benefit of automation is reducing human error and manual effort (Option B), which directly impacts operational efficiency. This then enables rapid and consistent deployments (Option A), as processes are standardized. Over time, automation improves security and compliance through standardized configurations (Option C) by enforcing best practices. Finally, it facilitates quick recovery from failures by allowing environments to be redeployed rapidly and reliably (Option D).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  20,
  NULL,
  NULL,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_84',
  'An application experiences fluctuating traffic patterns throughout the day. Order the steps to implement elasticity using AWS services to handle these changes efficiently.',
  'ordering',
  '["Create an Amazon Machine Image (AMI) of the application server.","Configure an Auto Scaling group to launch instances from the AMI.","Set up scaling policies based on Amazon CloudWatch metrics.","Place the Auto Scaling group behind an Application Load Balancer."]'::json,
  '{0,1,3,2}',
  'To implement elasticity, first create an Amazon Machine Image (AMI) of the application server (Option A) to serve as the blueprint for new instances. Next, configure an Auto Scaling group to launch instances from this AMI (Option B). Then, place the Auto Scaling group behind an Application Load Balancer (Option D) to distribute traffic. Finally, set up scaling policies based on Amazon CloudWatch metrics (Option C) to automatically adjust the number of instances based on demand.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  21,
  NULL,
  NULL,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_85',
  'AWS design principles advocate treating cloud servers as ''cattle'' rather than ''pets''. Order the following characteristics that align with the ''cattle'' approach.',
  'ordering',
  '["Replacing failed instances with new ones automatically.","Automating instance provisioning and configuration.","Designing instances to be stateless and disposable.","Not performing manual patching or configuration on individual instances."]'::json,
  '{2,1,3,0}',
  'The ''cattle'' approach starts with designing instances to be stateless and disposable (Option C), meaning they don''t hold unique, critical state. This enables automating instance provisioning and configuration (Option B) through Infrastructure as Code. Consequently, you should not perform manual patching or configuration on individual instances (Option D), as they are meant to be identical and replaceable. The ultimate outcome is replacing failed instances with new ones automatically (Option A) without significant operational impact.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  22,
  NULL,
  NULL,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_86',
  'A solutions architect is reviewing an existing application''s architecture against AWS best practices to identify areas for improvement. Order the pillars of the AWS Well-Architected Framework in a logical sequence for a comprehensive review process, starting with foundational concerns.',
  'ordering',
  '["Evaluate the system''s ability to recover from infrastructure or service disruptions.","Assess the effectiveness of security controls and data protection measures.","Review the efficiency of computing resources to meet demand and maintain cost-effectiveness.","Examine the ability to support development and run workloads effectively."]'::json,
  '{1,0,3,2}',
  'A logical sequence for reviewing an architecture against the Well-Architected Framework often starts with Security (Option B) as a foundational concern, ensuring data and systems are protected. Next, Reliability (Option A) is crucial, focusing on the system''s ability to recover from failures. Following this, Operational Excellence (Option D) ensures the system can support development and run workloads effectively. Finally, Performance Efficiency (Option C) is reviewed to ensure resources are used optimally to meet demand while considering cost, which also ties into Cost Optimization (another pillar, not listed here but implied in efficiency).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  23,
  NULL,
  NULL,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_87',
  'A company wants to implement the ''design for failure'' principle for its critical application running on Amazon EC2 instances. This principle ensures that the application remains available even if individual components fail. Order the steps to effectively implement this design principle.',
  'ordering',
  '["Configure Auto Scaling groups to automatically replace unhealthy instances.","Distribute application components across multiple Availability Zones.","Implement health checks to detect failing instances.","Use an Elastic Load Balancer (ELB) to distribute traffic across healthy instances."]'::json,
  '{1,3,2,0}',
  'To design for failure, the first step is to distribute application components across multiple Availability Zones (Option B) to ensure geographic isolation of failures. Next, use an Elastic Load Balancer (ELB) (Option D) to distribute incoming traffic across these distributed components. Then, implement health checks (Option C) to continuously monitor the health of individual instances. Finally, configure Auto Scaling groups (Option A) to automatically replace any unhealthy instances detected by the health checks, ensuring continuous availability.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  24,
  NULL,
  NULL,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_88',
  'A development team is migrating a monolithic application to AWS and wants to adopt the ''decouple components'' design principle to improve scalability and fault tolerance. Order the actions they would typically take to achieve this architectural transformation.',
  'ordering',
  '["Identify distinct functional modules within the monolith that can operate independently.","Implement message queues (e.g., Amazon SQS) or event buses (e.g., Amazon EventBridge) for inter-component communication.","Encapsulate each module into separate, independently deployable services (e.g., AWS Lambda functions or Amazon EC2 instances).","Define clear APIs and interfaces for communication between the new services."]'::json,
  '{0,3,2,1}',
  'The first step in decoupling components is to identify distinct functional modules within the monolith (Option A) that can logically operate independently. Next, define clear APIs and interfaces (Option D) for how these new services will communicate, establishing boundaries. Then, encapsulate each identified module into separate, independently deployable services (Option C), moving away from the monolithic structure. Finally, implement message queues or event buses (Option B) for asynchronous, loosely coupled communication between these new services, further enhancing resilience and scalability.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  25,
  NULL,
  NULL,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_89',
  'A DevOps team is adopting infrastructure as code (IaC) and treating cloud resources as disposable to improve deployment consistency and operational efficiency. Order the benefits realized by this approach, from foundational improvements to advanced capabilities.',
  'ordering',
  '["Enable rapid and consistent provisioning of entire environments.","Reduce configuration drift between environments.","Facilitate automated testing and deployment pipelines.","Improve disaster recovery capabilities by quickly rebuilding infrastructure."]'::json,
  '{0,1,2,3}',
  'The foundational benefit of IaC and disposable resources is to enable rapid and consistent provisioning of entire environments (Option A), ensuring uniformity. This consistency then helps to reduce configuration drift (Option B) between development, test, and production environments. With consistent and reproducible infrastructure, it becomes easier to facilitate automated testing and deployment pipelines (Option C), speeding up the software delivery lifecycle. Ultimately, this approach significantly improves disaster recovery capabilities (Option D) by allowing infrastructure to be quickly rebuilt from code in the event of a failure.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  26,
  NULL,
  NULL,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_60_3
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_55',
  'A company is evaluating the financial benefits of migrating to AWS. Order these cost concepts from a high-level financial model to a specific pricing mechanism.',
  'ordering',
  '["Operational Expenditure (OpEx)","Total Cost of Ownership (TCO)","Pay-as-you-go pricing","Reduced Capital Expenditure (CapEx)"]'::json,
  '{1,3,0,2}',
  'Understanding cloud economics involves several financial concepts. Option B (Total Cost of Ownership) is a comprehensive financial model. Option D (Reduced Capital Expenditure) represents a major shift from traditional IT. Option A (Operational Expenditure) is the primary cost model in the cloud. Option C (Pay-as-you-go pricing) is the specific billing model that drives OpEx. The correct order moves from the overall cost analysis, to the shift in investment type, to the ongoing operational costs, and finally to the specific pricing model.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  27,
  NULL,
  NULL,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_56',
  'To optimize costs on AWS, a user should follow a methodical approach. Order these steps for effective cost optimization.',
  'ordering',
  '["Right-size resources","Monitor usage and costs","Implement cost allocation tags","Leverage managed services"]'::json,
  '{1,2,0,3}',
  'Effective cost optimization on AWS requires a structured approach. Option B (Monitor usage and costs) is the initial step to gain visibility into spending. Option C (Implement cost allocation tags) helps categorize and attribute costs. Option A (Right-size resources) ensures that resources match demand, avoiding over-provisioning. Option D (Leverage managed services) can further reduce operational overhead and often costs. The sequence starts with visibility, then attribution, then optimization of existing resources, and finally adopting more efficient service models.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  28,
  NULL,
  NULL,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_57',
  'A company is transitioning its IT infrastructure from on-premises to AWS. Order the following financial shifts they will experience.',
  'ordering',
  '["Increased operational expenditure","Decreased capital expenditure","Shift from upfront investment","Reduced server procurement"]'::json,
  '{2,3,1,0}',
  'Migrating to the AWS Cloud fundamentally changes an organization''s financial model. Option C (Shift from upfront investment) is the overarching change, moving away from large initial purchases. This directly leads to Option D (Reduced server procurement) as physical hardware is no longer needed. Consequently, Option B (Decreased capital expenditure) is observed. The trade-off is Option A (Increased operational expenditure) as resources are paid for as they are consumed. The sequence shows the progression of financial changes during a cloud migration.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  29,
  NULL,
  NULL,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_58',
  'To maximize cost efficiency with managed services on AWS, certain actions are beneficial. Order these actions from general adoption to specific optimization outcomes.',
  'ordering',
  '["Focus on application development","Automate infrastructure management","Reduce operational overhead","Eliminate patching and maintenance"]'::json,
  '{1,3,2,0}',
  'Managed services on AWS offer significant benefits for cost efficiency. Option B (Automate infrastructure management) is a core aspect of managed services, where AWS handles the underlying infrastructure. This automation leads to Option D (Eliminate patching and maintenance) for the customer. These two benefits collectively contribute to Option C (Reduce operational overhead). With less operational burden, teams can then Option A (Focus on application development), which is the ultimate goal of leveraging managed services. The order progresses from the underlying automation to the resulting operational and business benefits.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  30,
  NULL,
  NULL,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_59',
  'A company wants to optimize the cost of its existing workload running on Amazon EC2 instances. Order the following actions to achieve cost optimization, starting with the most impactful and immediate.',
  'ordering',
  '["Implement Auto Scaling to match capacity with demand.","Right-size EC2 instances to use the smallest effective type.","Leverage AWS Savings Plans or Reserved Instances for predictable workloads.","Identify and terminate unused or idle resources."]'::json,
  '{3,1,0,2}',
  'The most immediate and impactful cost optimization is to identify and terminate unused or idle resources (Option D). Next, right-size EC2 instances to use the smallest effective type (Option B) to avoid over-provisioning. Then, implement Auto Scaling to match capacity with demand (Option A), ensuring you only pay for what you use. Finally, for predictable workloads, leverage AWS Savings Plans or Reserved Instances (Option C) to get significant discounts on committed usage.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  31,
  NULL,
  NULL,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_60',
  'Order the following financial benefits of cloud computing, starting with the most fundamental shift from traditional IT.',
  'ordering',
  '["Converting capital expenditure (CapEx) to operational expenditure (OpEx).","Benefiting from economies of scale.","Eliminating the need for upfront infrastructure investments.","Paying only for the compute and storage resources consumed."]'::json,
  '{2,0,3,1}',
  'The most fundamental shift in cloud computing is eliminating the need for upfront infrastructure investments (Option C). This directly leads to converting capital expenditure (CapEx) to operational expenditure (OpEx) (Option A). A core principle of cloud is paying only for the compute and storage resources consumed (Option D). Finally, by aggregating demand from many customers, cloud providers can pass on benefits from economies of scale (Option B).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  32,
  NULL,
  NULL,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_61',
  'A system administrator needs to right-size Amazon EC2 instances for an application to reduce costs without impacting performance. Order the following steps to perform this task effectively.',
  'ordering',
  '["Monitor instance utilization metrics (CPU, memory, network) over time.","Analyze the collected data to identify underutilized instances.","Test the application with the new, smaller instance types.","Adjust instance types to a smaller size based on analysis."]'::json,
  '{0,1,3,2}',
  'To right-size EC2 instances, first monitor instance utilization metrics (CPU, memory, network) over time (Option A) to gather performance data. Next, analyze the collected data to identify underutilized instances (Option B) that are candidates for downsizing. Based on this analysis, adjust instance types to a smaller size (Option D). Finally, test the application with the new, smaller instance types (Option C) to ensure performance is not negatively impacted.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  33,
  NULL,
  NULL,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_62',
  'Order the following components that typically contribute to the Total Cost of Ownership (TCO) for an on-premises IT infrastructure, from direct hardware costs to less obvious expenses.',
  'ordering',
  '["Software licensing and maintenance fees.","Hardware acquisition and depreciation.","Data center facility costs (power, cooling, space).","IT staff salaries and training."]'::json,
  '{1,0,2,3}',
  'The most direct cost in on-premises TCO is hardware acquisition and depreciation (Option B). Following that are software licensing and maintenance fees (Option A), which are essential for operation. Less obvious but significant are data center facility costs such as power, cooling, and physical space (Option C). Finally, IT staff salaries and training (Option D) represent a substantial operational expense often overlooked in initial hardware cost comparisons.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  34,
  NULL,
  NULL,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_63',
  'A small business wants to reduce operational overhead and costs by migrating from self-managed databases to AWS managed services. Order the following steps to leverage managed services for cost savings.',
  'ordering',
  '["Migrate data to the selected AWS managed database service.","Identify suitable AWS managed database services (e.g., Amazon RDS, Amazon DynamoDB).","Decommission the on-premises database infrastructure.","Refactor application code to connect to the new managed service endpoint."]'::json,
  '{1,3,0,2}',
  'To leverage managed services for cost savings, the first step is to identify suitable AWS managed database services (Option B) that meet the application''s needs. Next, refactor application code to connect to the new managed service endpoint (Option D). After the application is ready, migrate data to the selected AWS managed database service (Option A). Finally, decommission the on-premises database infrastructure (Option C) to realize the full cost and operational savings.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  35,
  NULL,
  NULL,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_64',
  'A business is evaluating the financial implications of migrating its on-premises infrastructure to the AWS Cloud, focusing on the shift from Capital Expenditure (CapEx) to Operational Expenditure (OpEx). Order the advantages of this financial model change.',
  'ordering',
  '["Convert large upfront investments into predictable monthly operating costs.","Allocate resources more flexibly to respond to business needs.","Reduce the risk of over-provisioning and stranded assets.","Free up capital that can be reinvested into innovation and business growth."]'::json,
  '{0,2,1,3}',
  'The primary advantage of shifting to OpEx is to convert large upfront investments into predictable monthly operating costs (Option A), eliminating the need for significant capital outlays. This then helps to reduce the risk of over-provisioning and stranded assets (Option C), as resources can be scaled down when not needed. With a flexible cost model, companies can allocate resources more flexibly (Option B) to respond quickly to changing business needs. Ultimately, this financial agility allows businesses to free up capital (Option D) that can be reinvested into innovation and core business growth, rather than infrastructure.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  36,
  NULL,
  NULL,
  'm_60_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_65',
  'A development team wants to ensure they are effectively utilizing the ''pay-as-you-go'' pricing model for their non-production environments on AWS. Order the actions they should take to maximize cost efficiency with this model.',
  'ordering',
  '["Implement automated shutdown schedules for resources outside business hours.","Choose Amazon EC2 instance types and Amazon RDS database sizes that match current needs.","Monitor resource utilization using Amazon CloudWatch to identify idle resources.","Utilize AWS Lambda for event-driven workloads to pay only for compute time used."]'::json,
  '{1,2,0,3}',
  'To effectively utilize ''pay-as-you-go'', the first step is to choose Amazon EC2 instance types and Amazon RDS database sizes that match current needs (Option B), avoiding over-provisioning from the start. Next, monitor resource utilization using Amazon CloudWatch (Option C) to identify any idle or underutilized resources. Based on this monitoring, implement automated shutdown schedules (Option A) for non-production resources outside business hours to stop incurring costs when not in use. Finally, utilize AWS Lambda (Option D) for event-driven workloads, as it inherently aligns with pay-as-you-go by charging only for the actual compute time consumed, further optimizing costs.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  37,
  NULL,
  NULL,
  'm_60_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_66',
  'A company is looking to reduce operational overhead and improve cost efficiency by adopting AWS managed services. Order the stages of utilizing managed services to achieve these benefits, from initial consideration to full optimization.',
  'ordering',
  '["Migrate self-managed databases to Amazon RDS.","Evaluate existing self-managed infrastructure for suitable managed service alternatives.","Leverage AWS Lambda for serverless compute instead of managing EC2 instances.","Monitor cost and performance of managed services to ensure continued optimization."]'::json,
  '{1,0,2,3}',
  'The process begins by evaluating existing self-managed infrastructure (Option B) to identify components that can be replaced by managed service alternatives. Next, migrate self-managed databases to Amazon RDS (Option A), which offloads database administration tasks. Following this, leverage AWS Lambda (Option C) for serverless compute, eliminating the need to provision and manage servers for event-driven functions. Finally, continuously monitor the cost and performance of these managed services (Option D) to ensure they continue to meet requirements and are optimized for cost efficiency.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  38,
  NULL,
  NULL,
  'm_60_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_60_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_91',
  'A company is planning its cloud migration strategy using the ''6 Rs'' of migration. Order these strategies from the simplest to the most complex in terms of required application changes.',
  'ordering',
  '["Replatform","Refactor","Rehost","Repurchase"]'::json,
  '{2,0,3,1}',
  'The ''6 Rs'' provide different approaches to cloud migration with varying levels of effort. Option C (Rehost), or ''lift and shift'', is generally the simplest, moving applications without significant changes. Option A (Replatform) involves making some cloud-native optimizations without changing the core architecture. Option D (Repurchase) means moving to a different product, often a SaaS solution, which can be simpler than refactoring but involves a new license. Option B (Refactor) involves re-architecting the application to fully leverage cloud-native features, making it the most complex. The order reflects increasing complexity in application modification.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  39,
  NULL,
  NULL,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_92',
  'The AWS Cloud Adoption Framework (CAF) helps organizations prepare for migration. Order these CAF perspectives by their typical focus areas in a comprehensive migration journey.',
  'ordering',
  '["Platform","Business","Operations","People"]'::json,
  '{1,3,0,2}',
  'The AWS Cloud Adoption Framework (CAF) organizes guidance into several perspectives. Option B (Business) typically comes first, focusing on business outcomes and strategy. Option D (People) addresses organizational change management and skill development. Option A (Platform) deals with the technical architecture and services. Option C (Operations) focuses on managing and monitoring the cloud environment post-migration. The sequence reflects a logical progression from strategic alignment to organizational readiness, then technical implementation, and finally ongoing management.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  40,
  NULL,
  NULL,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_93',
  'A large enterprise needs to migrate a substantial amount of on-premises data to AWS. Order these AWS Snow Family services by their typical data transfer capacity, from smallest to largest.',
  'ordering',
  '["AWS Snowmobile","AWS Snowcone","AWS Snowball Edge"]'::json,
  '{1,2,0}',
  'The AWS Snow Family offers various devices for physical data transfer. Option B (AWS Snowcone) is the smallest, designed for edge computing and data transfer in remote environments. Option C (AWS Snowball Edge) offers more storage and compute capabilities, suitable for larger data migrations. Option A (AWS Snowmobile) is the largest, a truck-sized container for exabyte-scale data transfer. The correct order is from the smallest to the largest data transfer capacity.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  41,
  NULL,
  NULL,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_94',
  'A database administrator is planning to migrate an on-premises relational database to Amazon RDS using AWS Database Migration Service (DMS). Order the general steps involved in setting up the DMS process.',
  'ordering',
  '["Create a migration task","Perform schema conversion (if needed)","Configure source and target endpoints","Create a replication instance"]'::json,
  '{3,2,1,0}',
  'Migrating a database with AWS DMS involves a specific sequence of steps. Option D (Create a replication instance) is typically the first step, as it provides the compute power for the migration. Next, Option C (Configure source and target endpoints) defines the connection details for the databases. Option B (Perform schema conversion (if needed)) is a preparatory step for heterogeneous migrations, often done before the data movement task. Finally, Option A (Create a migration task) defines what data to migrate and starts the process. The order ensures the necessary components are in place before the migration begins.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  42,
  NULL,
  NULL,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_95',
  'A company is planning to migrate its applications to the AWS Cloud. Order the ''6 Rs'' of migration strategies based on the level of re-architecture required, from least to most.',
  'ordering',
  '["Replatform (lift-and-reshape)","Retain (do nothing)","Rehost (lift-and-shift)","Refactor (re-architect)"]'::json,
  '{1,2,0,3}',
  'The ''6 Rs'' of migration strategies, ordered from least to most re-architecture, start with Retain (Option B), meaning doing nothing with the application. Next is Rehost (Option C), a ''lift-and-shift'' approach with minimal changes. Following that is Replatform (Option A), ''lift-and-reshape,'' which involves some cloud-native optimizations. The strategy requiring the most re-architecture is Refactor (Option D), which involves fundamentally changing the application''s architecture to fully leverage cloud-native capabilities.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  43,
  NULL,
  NULL,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_96',
  'An enterprise is embarking on a large-scale cloud migration project. Order the following phases of a typical cloud migration project, as guided by the AWS Cloud Adoption Framework (CAF).',
  'ordering',
  '["Migrate applications and data to the AWS Cloud.","Build foundational cloud capabilities and landing zone.","Assess the current environment and define migration strategy.","Optimize operations and costs post-migration."]'::json,
  '{2,1,0,3}',
  'A typical cloud migration project begins by assessing the current environment and defining the migration strategy (Option C). This is followed by building foundational cloud capabilities and a landing zone (Option B) to prepare the target environment. Once the foundation is ready, applications and data are migrated to the AWS Cloud (Option A). Finally, after migration, the focus shifts to optimizing operations and costs (Option D) to realize the full benefits of the cloud.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  44,
  NULL,
  NULL,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_97',
  'A company needs to migrate a large number of virtual machines from its on-premises data center to AWS with minimal downtime. Order the following steps when using AWS Application Migration Service (AWS MGN).',
  'ordering',
  '["Install the AWS Replication Agent on source servers.","Configure replication settings and launch settings in AWS MGN.","Launch test instances to validate migration readiness.","Perform a cutover to launch production instances on AWS."]'::json,
  '{0,1,2,3}',
  'When using AWS Application Migration Service (AWS MGN), the first step is to install the AWS Replication Agent on source servers (Option A) to enable continuous data replication. Next, configure replication settings and launch settings in AWS MGN (Option B) to define how the servers will be migrated and launched on AWS. After replication is stable, launch test instances to validate migration readiness (Option C) without affecting production. Finally, perform a cutover to launch production instances on AWS (Option D) when ready to switch traffic.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  45,
  NULL,
  NULL,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_98',
  'An organization is using the AWS Cloud Adoption Framework (CAF) to prepare for a cloud migration. Order the following CAF perspectives from those focusing on people and processes to those focusing on technology.',
  'ordering',
  '["Governance Perspective","Business Perspective","Platform Perspective","People Perspective"]'::json,
  '{1,3,0,2}',
  'The AWS CAF starts with the Business Perspective (Option B), which focuses on aligning IT with business strategy. This is closely followed by the People Perspective (Option D), addressing organizational change and skill development. The Governance Perspective (Option A) then focuses on managing and controlling the cloud environment. Finally, the Platform Perspective (Option C) focuses on the technical architecture and implementation of the cloud environment.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  46,
  NULL,
  NULL,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_99',
  'A large enterprise is planning a comprehensive migration to the AWS Cloud. They want to follow a structured approach to ensure success and address various organizational aspects. Order the phases of a typical cloud migration journey using the AWS Cloud Adoption Framework (CAF).',
  'ordering',
  '["Migrate applications and data, and iterate on new cloud-native solutions.","Analyze the current state and identify gaps across business, people, and technology.","Build foundational AWS capabilities and pilot initial migrations.","Optimize operations and costs, and continuously innovate in the cloud."]'::json,
  '{1,2,0,3}',
  'The AWS CAF journey begins with the ''Plan'' phase, which involves analyzing the current state and identifying gaps across business, people, and technology (Option B). This leads to the ''Ready'' phase, where foundational AWS capabilities are built and initial migrations are piloted (Option C). Once ready, the ''Migrate'' phase involves moving applications and data, and iterating on new cloud-native solutions (Option A). Finally, the ''Optimize'' phase focuses on optimizing operations and costs, and continuously innovating in the cloud (Option D) to maximize value.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  47,
  NULL,
  NULL,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_100',
  'A company is evaluating different strategies for migrating its diverse portfolio of applications to the AWS Cloud. They want to understand the effort and potential for cloud-native optimization associated with each approach. Order the ''6 R''s of migration strategies from the simplest (least effort, least cloud-native) to the most complex (most effort, most cloud-native).',
  'ordering',
  '["Replatform (lift-and-tinker) applications to leverage some cloud features.","Rehost (lift-and-shift) applications to AWS without changes.","Refactor/Re-architect applications to fully utilize cloud-native capabilities.","Repurchase (drop-and-shop) by moving to a SaaS solution."]'::json,
  '{1,0,3,2}',
  'The simplest migration strategy is Rehost (Option B), which involves lifting and shifting applications to AWS with minimal or no changes. Next in complexity is Replatform (Option A), where applications are moved to AWS but with some modifications to leverage cloud features (e.g., moving from self-managed database to Amazon RDS). Repurchase (Option D) involves replacing an existing application with a Software-as-a-Service (SaaS) solution, which can be simpler in terms of migration effort but requires a complete replacement. The most complex and cloud-native approach is Refactor/Re-architect (Option C), which involves fundamentally changing the application''s architecture to fully utilize cloud-native capabilities, often breaking it into microservices.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  48,
  NULL,
  NULL,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_101',
  'A large enterprise needs to migrate several terabytes of on-premises relational database data to Amazon RDS with minimal downtime. They plan to use AWS Database Migration Service (DMS). Order the high-level steps required for this migration.',
  'ordering',
  '["Create a replication instance in AWS DMS.","Configure source and target endpoints for the on-premises database and Amazon RDS.","Create and run a migration task to replicate data.","Perform a cutover to the Amazon RDS database once replication is complete."]'::json,
  '{0,1,2,3}',
  'The first step in using AWS DMS is to create a replication instance (Option A), which is the compute resource that performs the data migration. Next, configure source and target endpoints (Option B) for both the on-premises database and the Amazon RDS instance, providing connection details. Then, create and run a migration task (Option C) within DMS to define what data to migrate and how (e.g., full load, CDC). Finally, once the data replication is complete and validated, perform a cutover (Option D) to switch application traffic from the source to the new Amazon RDS database.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  49,
  NULL,
  NULL,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_102',
  'A media company has petabytes of archival video footage stored on-premises and needs to transfer it to Amazon S3 for long-term storage and processing. Due to the massive data volume and limited network bandwidth, they decide to use the AWS Snow Family. Order the steps for this data transfer process.',
  'ordering',
  '["Ship the AWS Snowball device back to AWS.","Create a job in the AWS Snow Family console to order a device.","Connect the AWS Snowball device to the on-premises network and transfer data.","AWS loads the data from the device into the specified Amazon S3 bucket."]'::json,
  '{1,2,0,3}',
  'The process begins by creating a job in the AWS Snow Family console (Option B) to specify the data transfer details and order a Snowball device. Once the device arrives, connect it to the on-premises network and transfer the data (Option C) from the local storage to the Snowball device. After data transfer is complete, ship the AWS Snowball device back to AWS (Option A) using the provided shipping label. Finally, AWS personnel will load the data from the device into the specified Amazon S3 bucket (Option D) in your account.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  50,
  NULL,
  NULL,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_103',
  'A manufacturing company is planning to migrate its enterprise resource planning (ERP) system to the AWS Cloud. They are keen on understanding the comprehensive benefits a successful migration can bring beyond just cost savings. Order the typical benefits a business gains from a successful migration to the AWS Cloud, from immediate to long-term strategic advantages.',
  'ordering',
  '["Achieve greater business agility and faster time-to-market for new features.","Reduce the need for upfront capital expenditure on IT infrastructure.","Improve business continuity and disaster recovery capabilities.","Enable innovation by providing access to a broad range of managed services."]'::json,
  '{1,2,0,3}',
  'An immediate benefit of cloud migration is to reduce the need for upfront capital expenditure (Option B), shifting to an operational expense model. Following this, businesses typically improve business continuity and disaster recovery capabilities (Option C) due to the distributed and resilient nature of cloud infrastructure. With the underlying infrastructure managed, organizations can then achieve greater business agility and faster time-to-market (Option A) for new features and products. Ultimately, the migration enables innovation (Option D) by providing easy access to a broad range of managed services and technologies, fostering new business models and capabilities.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  51,
  NULL,
  NULL,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_110'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_111'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_112'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_113'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_114'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_115'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_116'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_117'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_118'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_119'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_120'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_121'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_76'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_77'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_78'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_79'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_80'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_81'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_82'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_83'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_84'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_85'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_86'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_87'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_88'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_89'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_55'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_56'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_57'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_58'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_59'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_60'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_61'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_62'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_63'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_64'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_65'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_66'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_91'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_92'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_93'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_94'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_95'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_96'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_97'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_98'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_99'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_100'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_101'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_102'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_103')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain60_13'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;


-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: CLF-C02
-- Generated: 2026-03-14T20:58:13.892Z
-- Questions: 48 (48 validated, 12 rejected)
-- Quiz ID: quiz_domain61_13
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_61_3
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_94',
  'A new AWS account has been created. Arrange the following actions in the recommended order to secure the AWS root user account.',
  'ordering',
  '["Create individual IAM users for daily administrative tasks","Enable Multi-Factor Authentication (MFA) for the root user","Log in as the root user for initial setup","Securely store root user credentials"]'::json,
  '{2,1,0,3}',
  'The recommended best practice for securing the AWS root user account involves a specific sequence of steps. Option C (Log in as the root user for initial setup) is the first step, as the root user is required for initial account setup. Option B (Enable Multi-Factor Authentication (MFA) for the root user) should be done immediately after logging in to add an extra layer of security. Option A (Create individual IAM users for daily administrative tasks) comes next, ensuring that the root account is not used for routine operations, adhering to the principle of least privilege. Finally, Option D (Securely store root user credentials) is crucial to protect the highly privileged root account information.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  1,
  NULL,
  NULL,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_95',
  'A developer needs access to specific AWS resources. Order the steps to grant this developer access using AWS Identity and Access Management (IAM) following the principle of least privilege.',
  'ordering',
  '["Attach the policy to an IAM user or role for the developer","Create an IAM policy with only the necessary permissions","Define the specific AWS resources and actions the developer needs","Test the permissions to ensure they are sufficient but not overly broad"]'::json,
  '{2,1,0,3}',
  'To grant access following the principle of least privilege, a structured approach is essential. Option C (Define the specific AWS resources and actions the developer needs) is the foundational step, as you must first understand the exact requirements. Option B (Create an IAM policy with only the necessary permissions) follows, translating those requirements into a granular IAM policy. Option A (Attach the policy to an IAM user or role for the developer) then applies this policy to the appropriate identity. Finally, Option D (Test the permissions to ensure they are sufficient but not overly broad) is a critical validation step to confirm the principle of least privilege has been correctly implemented.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  2,
  NULL,
  NULL,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_96',
  'A company wants to enhance the security of its IAM users by requiring a second factor for authentication. Order the general steps to enable Multi-Factor Authentication (MFA) for an IAM user.',
  'ordering',
  '["Choose an MFA device type (e.g., virtual MFA device)","Log in to the AWS Management Console as the IAM user","Configure the MFA device with the IAM user account","Activate the MFA device"]'::json,
  '{1,0,2,3}',
  'Enabling MFA for an IAM user involves a clear sequence. Option B (Log in to the AWS Management Console as the IAM user) is the initial access point. Once logged in, Option A (Choose an MFA device type (e.g., virtual MFA device)) is selected based on the user''s preference or organizational policy. Option C (Configure the MFA device with the IAM user account) involves linking the chosen device to the user''s profile, often by scanning a QR code or entering a key. Finally, Option D (Activate the MFA device) completes the setup, making MFA mandatory for future logins.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  3,
  NULL,
  NULL,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_97',
  'An organization is setting up AWS IAM Identity Center (SSO) for centralized access management. Order the foundational steps to integrate an external identity provider (IdP) with IAM Identity Center.',
  'ordering',
  '["Configure the external IdP to trust IAM Identity Center","Enable IAM Identity Center in an AWS Region","Configure IAM Identity Center to trust the external IdP","Synchronize users and groups from the external IdP to IAM Identity Center"]'::json,
  '{1,2,0,3}',
  'Integrating an external identity provider with AWS IAM Identity Center follows a specific order. Option B (Enable IAM Identity Center in an AWS Region) is the prerequisite, as IAM Identity Center must be active. Next, Option C (Configure IAM Identity Center to trust the external IdP) establishes the initial trust relationship from the AWS side. This is followed by Option A (Configure the external IdP to trust IAM Identity Center), completing the two-way trust. Finally, Option D (Synchronize users and groups from the external IdP to IAM Identity Center) brings the user identities into IAM Identity Center for permission assignment.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  4,
  NULL,
  NULL,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_98',
  'A security team is reviewing the best practices for managing access keys for programmatic access. Order the following actions from most secure to least secure for an application running on an Amazon EC2 instance.',
  'ordering',
  '["Embed access keys directly in the application''s source code","Use IAM roles for EC2 instances","Store access keys in an encrypted file on the EC2 instance","Use temporary credentials retrieved from the EC2 instance metadata service"]'::json,
  '{1,3,2,0}',
  'The most secure method for programmatic access for an application on an EC2 instance is to leverage IAM roles. Option B (Use IAM roles for EC2 instances) is the most secure, as it provides temporary credentials that are automatically rotated and managed by AWS, eliminating the need to store long-term credentials on the instance. Option D (Use temporary credentials retrieved from the EC2 instance metadata service) is a direct consequence and benefit of using IAM roles, making it the next most secure. Option C (Store access keys in an encrypted file on the EC2 instance) is less secure as it still involves storing long-term credentials, even if encrypted, which could be compromised. Option A (Embed access keys directly in the application''s source code) is the least secure method, as it exposes credentials to version control systems and makes rotation difficult, posing a significant security risk.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  5,
  NULL,
  NULL,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_99',
  'A developer needs to configure an application running on an Amazon EC2 instance to securely access Amazon S3. Order the steps to implement this using IAM roles.',
  'ordering',
  '["Attach the IAM role to the EC2 instance.","Create an IAM role with a trust policy allowing EC2 to assume the role.","Define an IAM policy granting read-only permissions to the specific S3 bucket.","Ensure the application uses the temporary credentials provided by the EC2 instance metadata service."]'::json,
  '{1,2,0,3}',
  'The correct sequence for an application on an EC2 instance to securely access Amazon S3 using IAM roles starts with creating an IAM role (Option B) that has a trust policy allowing the EC2 service to assume it. Next, an IAM policy must be defined (Option C) that grants the necessary read-only permissions to the specific S3 bucket, adhering to the principle of least privilege. This policy is then attached to the newly created IAM role. After the role and policy are ready, the IAM role is attached to the EC2 instance (Option A). Finally, the application running on the EC2 instance must be configured to use the temporary credentials provided by the EC2 instance metadata service (Option D), which the instance automatically assumes from the attached role. Embedding long-term access keys in application source code (anti-pattern ap-2.3-005) is an insecure practice.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  6,
  NULL,
  NULL,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_100',
  'Order the typical steps an administrator would take to grant a new IAM user access to specific AWS resources while adhering to the principle of least privilege.',
  'ordering',
  '["Create an IAM user for the new administrator.","Attach a policy to the IAM user that grants only the necessary permissions.","Instruct the user to enable MFA on their IAM user.","Define an IAM policy with the minimum required actions and resources."]'::json,
  '{0,3,1,2}',
  'The correct order to grant a new IAM user access following the principle of least privilege begins with creating the IAM user (Option A). Next, an IAM policy should be defined (Option D) that specifies only the minimum required actions and resources, ensuring no overly broad permissions are granted. This policy is then attached to the IAM user (Option B). Finally, the administrator should be instructed to enable Multi-Factor Authentication (MFA) on their IAM user (Option C) for enhanced security. Granting overly broad permissions (anti-pattern ap-2.3-002) is a common security mistake.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  7,
  NULL,
  NULL,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_101',
  'Order the steps to enable Multi-Factor Authentication (MFA) for an existing IAM user in the AWS Management Console.',
  'ordering',
  '["Choose a virtual MFA device and scan the QR code with an authenticator app.","Sign in to the AWS Management Console and navigate to the IAM dashboard.","Enter two consecutive MFA codes from the authenticator app and assign MFA.","Select the IAM user, then go to the ''Security credentials'' tab and click ''Manage MFA device''."]'::json,
  '{1,3,0,2}',
  'To enable MFA for an IAM user, the first step is to sign in to the AWS Management Console and navigate to the IAM dashboard (Option B). From there, you select the specific IAM user, go to their ''Security credentials'' tab, and click ''Manage MFA device'' (Option D). Next, you choose a virtual MFA device, which will display a QR code to be scanned by an authenticator application on your smartphone (Option A). Finally, you enter two consecutive MFA codes generated by the authenticator app into the console to complete the assignment of MFA (Option C). Not enabling MFA on privileged IAM users (anti-pattern ap-2.3-004) is a significant security risk.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  8,
  NULL,
  NULL,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_102',
  'When an IAM principal makes a request to AWS, the IAM policy evaluation logic determines access. Order the following steps in the typical evaluation flow.',
  'ordering',
  '["AWS checks for explicit Deny statements in all applicable policies.","AWS checks for explicit Allow statements in all applicable policies.","The request is denied by default if no explicit Allow is found.","The request is allowed if an explicit Allow is found and no explicit Deny applies."]'::json,
  '{0,1,3,2}',
  'The IAM policy evaluation logic follows a specific order. First, AWS checks for any explicit Deny statements in all applicable policies (Option A). If an explicit Deny is found, the request is immediately denied, regardless of any Allow statements. If no explicit Deny applies, AWS then checks for explicit Allow statements (Option B). If an explicit Allow is found and no explicit Deny has overridden it, the request is allowed (Option D). If no explicit Allow is found, the request is denied by default (Option C), as IAM operates on an implicit deny principle. Granting overly broad permissions instead of following least privilege (anti-pattern ap-2.3-002) can lead to unintended access.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  9,
  NULL,
  NULL,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_103',
  'A developer needs to access only specific Amazon S3 buckets for reading and writing data, and nothing else. The security team mandates the principle of least privilege to minimize potential security risks. Order the following steps to correctly apply the principle of least privilege for a new IAM user accessing Amazon S3.',
  'ordering',
  '["Create an IAM policy that grants specific read and write permissions only to the designated S3 buckets.","Create a new IAM user for the developer.","Attach the custom IAM policy to the newly created IAM user.","Test the IAM user''s permissions to ensure access is limited strictly to the intended S3 buckets."]'::json,
  '{1,0,2,3}',
  'The correct order for applying the principle of least privilege begins with creating the IAM user (Option B). Next, create a custom IAM policy that grants only the necessary read and write permissions to the specific Amazon S3 buckets (Option A), rather than broad access. Then, attach this granular IAM policy to the newly created IAM user (Option C). Finally, it is crucial to test the IAM user''s permissions (Option D) to verify that access is indeed restricted to only the intended resources and actions, ensuring the principle of least privilege is effectively enforced.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  10,
  NULL,
  NULL,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_104',
  'An application running on an Amazon EC2 instance needs to securely access data stored in an Amazon S3 bucket without embedding credentials directly into the application code. This approach enhances security by utilizing temporary credentials. Order the following steps to configure an IAM role that allows an Amazon EC2 instance to access Amazon S3.',
  'ordering',
  '["Create an IAM role with a trust policy that allows the EC2 service to assume the role.","Attach an IAM policy to the role that grants necessary permissions to the Amazon S3 bucket.","Launch an Amazon EC2 instance and assign the created IAM role during instance launch or later.","Verify that the application on the EC2 instance can access the S3 bucket using the assigned role''s temporary credentials."]'::json,
  '{0,1,2,3}',
  'The correct sequence starts with creating an IAM role (Option A) and defining its trust policy to allow the Amazon EC2 service to assume it. Next, attach an IAM policy to this role (Option B) that specifies the exact permissions required for Amazon S3 access, adhering to the principle of least privilege. Then, launch or modify an Amazon EC2 instance to assign this IAM role (Option C). Finally, verify that the application running on the EC2 instance can successfully access the Amazon S3 bucket using the temporary credentials provided by the role (Option D), confirming the secure setup.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  11,
  NULL,
  NULL,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_105',
  'A small business wants to centralize access management for its AWS accounts and business applications, allowing users to log in once to access everything. This approach simplifies user management and improves the security posture. Order the following steps to set up AWS IAM Identity Center (SSO) for centralized access.',
  'ordering',
  '["Enable AWS IAM Identity Center (SSO) in the AWS Management Console.","Configure an identity source (e.g., AWS IAM Identity Center directory, Active Directory, or an external IdP).","Create or provision users and groups within AWS IAM Identity Center or sync them from the chosen identity source.","Assign users and groups to AWS accounts and applications, defining their permission sets."]'::json,
  '{0,1,2,3}',
  'The correct order for setting up AWS IAM Identity Center (SSO) begins with enabling the service in the AWS Management Console (Option A). Once enabled, you must configure an identity source (Option B), which could be the built-in IAM Identity Center directory, AWS Directory Service, or an external identity provider. After the identity source is set up, you create or provision users and groups (Option C), either directly in IAM Identity Center or by syncing them from your chosen source. Finally, you assign these users and groups to your AWS accounts and applications (Option D), specifying the permission sets that define their access levels.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  12,
  NULL,
  NULL,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_61_4
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_90',
  'A security engineer is configuring network security for an Amazon VPC. Order the following network security controls from the outermost layer to the innermost layer of protection.',
  'ordering',
  '["Security Groups for Amazon EC2 instances","AWS WAF protecting an Application Load Balancer","Network Access Control Lists (NACLs) for subnets","AWS Shield Standard for DDoS protection"]'::json,
  '{3,1,2,0}',
  'Network security in AWS involves multiple layers, starting from the perimeter. Option D (AWS Shield Standard for DDoS protection) is the outermost layer, providing automatic protection against common DDoS attacks at the network edge. Option B (AWS WAF protecting an Application Load Balancer) operates at the application layer, filtering web traffic before it reaches your instances. Option C (Network Access Control Lists (NACLs) for subnets) act as a stateless firewall at the subnet level, controlling traffic in and out of subnets. Option A (Security Groups for Amazon EC2 instances) are the innermost layer, acting as a stateful firewall at the instance level, controlling traffic to and from individual EC2 instances.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  13,
  NULL,
  NULL,
  'm_61_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_91',
  'A security team wants to enable Amazon GuardDuty for continuous threat detection across their AWS accounts. Order the general steps to activate and monitor findings from Amazon GuardDuty.',
  'ordering',
  '["Review GuardDuty findings in the console or via API","Enable GuardDuty in the AWS Management Console","Configure automated responses to critical findings (e.g., with AWS Lambda)","Integrate GuardDuty findings with AWS Security Hub"]'::json,
  '{1,0,3,2}',
  'Enabling and utilizing Amazon GuardDuty involves a logical progression. Option B (Enable GuardDuty in the AWS Management Console) is the first step to activate the service. Once enabled, Option A (Review GuardDuty findings in the console or via API) is the immediate next step to understand detected threats. Option D (Integrate GuardDuty findings with AWS Security Hub) is a best practice for centralizing security findings from various AWS services. Finally, Option C (Configure automated responses to critical findings (e.g., with AWS Lambda)) allows for proactive remediation based on the severity of the findings.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  14,
  NULL,
  NULL,
  'm_61_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_92',
  'A security team needs to discover and classify sensitive data stored in Amazon S3 buckets. Order the steps to leverage Amazon Macie for this purpose.',
  'ordering',
  '["Review the sensitive data findings and alerts","Enable Amazon Macie in the AWS Management Console","Configure Macie to monitor specific S3 buckets or the entire account","Define custom data identifiers if needed"]'::json,
  '{1,2,3,0}',
  'Using Amazon Macie for sensitive data discovery involves a clear sequence of actions. Option B (Enable Amazon Macie in the AWS Management Console) is the first step to activate the service within your account. Next, Option C (Configure Macie to monitor specific S3 buckets or the entire account) defines the scope of Macie''s analysis. Option D (Define custom data identifiers if needed) allows for tailored detection of specific sensitive data patterns relevant to your organization. Finally, Option A (Review the sensitive data findings and alerts) is where the security team analyzes the results and takes appropriate action based on Macie''s classifications.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  15,
  NULL,
  NULL,
  'm_61_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_93',
  'An organization wants to centralize security findings from various AWS services like GuardDuty and Inspector. Order the steps to effectively use AWS Security Hub for this purpose.',
  'ordering',
  '["Enable Security Hub in the AWS Management Console","Review aggregated security findings and compliance checks","Integrate other AWS security services (e.g., GuardDuty, Inspector)","Configure automated actions based on findings (e.g., custom actions)"]'::json,
  '{0,2,1,3}',
  'To centralize security findings with AWS Security Hub, a logical order of operations is followed. Option A (Enable Security Hub in the AWS Management Console) is the initial activation step for the service. Once enabled, Option C (Integrate other AWS security services (e.g., GuardDuty, Inspector)) allows Security Hub to ingest findings from these sources. Option B (Review aggregated security findings and compliance checks) is then performed to gain a consolidated view of the security posture. Finally, Option D (Configure automated actions based on findings (e.g., custom actions)) enables proactive response to identified security issues.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  16,
  NULL,
  NULL,
  'm_61_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_94',
  'A company is setting up its network security within an Amazon Virtual Private Cloud (VPC). Order the following network security layers from the broadest scope to the most granular scope.',
  'ordering',
  '["Security Groups (instance-level firewall)","Network Access Control Lists (NACLs) (subnet-level firewall)","AWS WAF (web application firewall)","VPC (isolated network environment)"]'::json,
  '{3,1,0,2}',
  'The correct order from broadest to most granular scope for network security layers is: First, the VPC (Option D) itself provides an isolated network environment, acting as the broadest container. Next, Network Access Control Lists (NACLs) (Option B) operate at the subnet level, providing stateless packet filtering for all instances within a subnet. Then, Security Groups (Option A) act as stateful firewalls at the instance level, controlling traffic to and from individual instances. Finally, AWS WAF (Option C) operates at the application layer, protecting web applications from common web exploits. Relying only on security groups without considering network ACLs (anti-pattern ap-2.4-001) is a common oversight.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  17,
  NULL,
  NULL,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_95',
  'A security engineer receives an alert from Amazon GuardDuty indicating unusual activity in an AWS account. Order the typical workflow for investigating and responding to this security finding.',
  'ordering',
  '["Analyze the GuardDuty finding details, including affected resources and threat type.","Take immediate containment actions, such as isolating compromised resources or revoking credentials.","Use Amazon Detective to perform a deeper investigation into the root cause and scope of the activity.","Review the incident and implement preventative measures to avoid future occurrences."]'::json,
  '{0,1,2,3}',
  'The typical workflow for responding to a GuardDuty finding starts with analyzing the finding details (Option A) to understand the nature of the threat and affected resources. Based on this analysis, immediate containment actions (Option B) should be taken to stop the spread or impact of the threat. For a deeper understanding, Amazon Detective can be used (Option C) to investigate the root cause and scope by analyzing security data. Finally, after the incident is resolved, a review should be conducted to implement preventative measures (Option D) and improve the security posture. Not enabling GuardDuty (anti-pattern ap-2.4-002) means missing out on continuous threat detection.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  18,
  NULL,
  NULL,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_96',
  'A company stores sensitive customer data in an Amazon S3 bucket. Order the steps to use Amazon Macie to discover and protect this sensitive data.',
  'ordering',
  '["Review Macie''s findings to identify sensitive data locations and types.","Enable Amazon Macie for the AWS account.","Configure Macie to monitor the S3 buckets containing sensitive data.","Implement remediation actions based on Macie''s findings, such as applying S3 bucket policies or encryption."]'::json,
  '{1,2,0,3}',
  'To use Amazon Macie for sensitive data discovery, the first step is to enable Amazon Macie for the AWS account (Option B). Once enabled, you configure Macie to monitor the specific S3 buckets where sensitive data might reside (Option C). After Macie has analyzed the data, you review its findings (Option A) to understand what sensitive data has been discovered and where it is located. Finally, based on these findings, you implement remediation actions (Option D), such as tightening S3 bucket policies, applying encryption, or moving data to more secure locations. Manually reviewing S3 buckets for sensitive data (anti-pattern ap-2.4-003) is inefficient and prone to error.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  19,
  NULL,
  NULL,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_97',
  'An organization needs to protect its web applications from common web exploits and bots. Order the steps to configure AWS WAF for this purpose.',
  'ordering',
  '["Associate the web ACL with an AWS resource like an Application Load Balancer or Amazon CloudFront distribution.","Create a Web Access Control List (Web ACL) in AWS WAF.","Define rules within the Web ACL to block or allow traffic based on specific patterns (e.g., IP addresses, SQL injection attempts).","Test the Web ACL in ''Count'' mode before enforcing ''Block'' or ''Allow'' actions."]'::json,
  '{1,2,0,3}',
  'The correct order to configure AWS WAF begins with creating a Web Access Control List (Web ACL) (Option B), which is the primary container for WAF rules. Next, you define rules within this Web ACL (Option C) to specify the conditions under which traffic should be blocked or allowed, such as detecting SQL injection or cross-site scripting. Once rules are defined, the Web ACL is associated with an AWS resource (Option A), like an Application Load Balancer, Amazon CloudFront distribution, or API Gateway, to start inspecting traffic. Finally, it''s a best practice to test the Web ACL in ''Count'' mode (Option D) to monitor its impact without blocking traffic, before switching to ''Block'' or ''Allow'' actions. This ensures the rules behave as expected without disrupting legitimate users.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  20,
  NULL,
  NULL,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_98',
  'A company is deploying a new web application on an Amazon EC2 instance within a Virtual Private Cloud (VPC) and needs to allow standard web traffic while blocking other unauthorized access. Order the following steps to configure a security group to allow inbound HTTP and HTTPS traffic to the EC2 instance.',
  'ordering',
  '["Create a new security group in the Amazon VPC console.","Add an inbound rule to allow HTTP traffic (TCP port 80) from 0.0.0.0/0 (all IPv4 addresses).","Add an inbound rule to allow HTTPS traffic (TCP port 443) from 0.0.0.0/0 (all IPv4 addresses).","Associate the configured security group with the Amazon EC2 instance."]'::json,
  '{0,1,2,3}',
  'The correct order for configuring a security group for web traffic starts with creating a new security group within the Amazon VPC console (Option A). Next, add an inbound rule to permit HTTP traffic on TCP port 80 from all IPv4 addresses (Option B). Following this, add another inbound rule for HTTPS traffic on TCP port 443, also from all IPv4 addresses (Option C). Finally, associate this newly configured security group with the Amazon EC2 instance (Option D) to apply the rules and allow the necessary web traffic.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  21,
  NULL,
  NULL,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_99',
  'A public-facing web application needs basic protection against common, frequently occurring Distributed Denial of Service (DDoS) attacks. The team wants to leverage AWS services that provide automatic and always-on protection without requiring manual configuration or additional cost for baseline defense. Order the following steps to leverage AWS services for baseline DDoS protection.',
  'ordering',
  '["Deploy the web application using AWS services like Amazon EC2, Elastic Load Balancing, or Amazon CloudFront.","Understand that AWS Shield Standard is automatically enabled for all AWS customers at no additional cost.","Review AWS WAF logs and metrics for advanced threat visibility and custom rule creation if needed for specific application vulnerabilities.","Ensure proper network architecture, including security groups and Network ACLs, to filter unwanted traffic."]'::json,
  '{1,0,3,2}',
  'The most fundamental step for baseline DDoS protection is to understand that AWS Shield Standard is automatically enabled for all AWS customers (Option B) at no additional cost, providing immediate protection. Then, deploy the web application using AWS services (Option A) that benefit from Shield Standard''s protection. Ensure proper network architecture (Option D), including security groups and Network ACLs, to filter unwanted traffic at different layers. While AWS WAF (Option C) can provide advanced protection, it is not part of the *baseline* Shield Standard and involves additional configuration and cost, making it a subsequent step for enhanced protection.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  22,
  NULL,
  NULL,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_100',
  'A security team wants to continuously monitor for malicious activity and unauthorized behavior within their AWS accounts, leveraging machine learning and threat intelligence. This proactive approach is crucial for early detection of potential security breaches. Order the following steps to enable and configure Amazon GuardDuty for threat detection.',
  'ordering',
  '["Navigate to the Amazon GuardDuty console in the AWS Management Console.","Review the findings generated by GuardDuty and integrate them with other security services like AWS Security Hub.","Click ''Enable GuardDuty'' to activate the service for the current AWS account.","Configure trusted IP lists and threat lists to fine-tune GuardDuty''s detection capabilities."]'::json,
  '{0,2,3,1}',
  'The correct order for setting up Amazon GuardDuty begins by navigating to the Amazon GuardDuty console (Option A). Next, click ''Enable GuardDuty'' (Option C) to activate the service, which immediately starts monitoring. After enabling, configure trusted IP lists and threat lists (Option D) to customize detection and reduce false positives. Finally, review the findings generated by GuardDuty (Option B) and integrate them with other security services like AWS Security Hub for centralized management and response.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  23,
  NULL,
  NULL,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_101',
  'An organization uses multiple AWS security services (e.g., Amazon GuardDuty, Amazon Inspector, Amazon Macie) and wants a unified view to aggregate, organize, and prioritize security findings across their accounts. This centralization improves visibility and response efficiency. Order the following steps to centralize security findings using AWS Security Hub.',
  'ordering',
  '["Navigate to the AWS Security Hub console in the AWS Management Console.","Enable AWS Security Hub for the current AWS account.","Enable integrations with other AWS security services (e.g., GuardDuty, Inspector, Macie) to automatically send findings to Security Hub.","Review the aggregated security findings, insights, and compliance checks within the Security Hub dashboard."]'::json,
  '{0,1,2,3}',
  'The correct order for centralizing security findings with AWS Security Hub begins by navigating to the AWS Security Hub console (Option A). Next, enable AWS Security Hub for the current AWS account (Option B), which activates the service. Then, enable integrations with other AWS security services (Option C) such as Amazon GuardDuty, Amazon Inspector, and Amazon Macie, so their findings are automatically sent to Security Hub. Finally, review the aggregated security findings, insights, and compliance checks (Option D) within the Security Hub dashboard to gain a comprehensive view of your security posture.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  24,
  NULL,
  NULL,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_61_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_89',
  'A company needs to ensure all API calls made within their AWS account are logged for auditing and security analysis. Order the steps to enable and utilize AWS CloudTrail for this requirement.',
  'ordering',
  '["Create a trail in the AWS CloudTrail console","Analyze CloudTrail logs for security incidents or compliance audits","Configure the trail to deliver logs to an Amazon S3 bucket","Enable CloudTrail logging for all AWS Regions"]'::json,
  '{0,3,2,1}',
  'To ensure comprehensive logging of API calls with AWS CloudTrail, a specific setup sequence is followed. Option A (Create a trail in the AWS CloudTrail console) is the initial step to define a new logging trail. Option D (Enable CloudTrail logging for all AWS Regions) is a best practice to capture events globally, ensuring no activity is missed. Option C (Configure the trail to deliver logs to an Amazon S3 bucket) is essential for durable storage and subsequent analysis of the logs. Finally, Option B (Analyze CloudTrail logs for security incidents or compliance audits) is the operational step where the collected data is used for its intended purpose.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  25,
  NULL,
  NULL,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_90',
  'A customer needs to access AWS compliance reports and certifications to demonstrate their regulatory adherence. Order the steps to obtain these documents from AWS.',
  'ordering',
  '["Log in to the AWS Management Console","Navigate to the AWS Artifact service","Download the relevant compliance reports or agreements","Accept the terms and conditions for accessing the reports"]'::json,
  '{0,1,3,2}',
  'Accessing AWS compliance reports through AWS Artifact follows a straightforward process. Option A (Log in to the AWS Management Console) is the necessary first step to access any AWS service. Option B (Navigate to the AWS Artifact service) directs the user to the correct location for compliance documentation. Option D (Accept the terms and conditions for accessing the reports) is a required legal step before viewing sensitive compliance information. Finally, Option C (Download the relevant compliance reports or agreements) allows the user to obtain the necessary documents for their auditing needs.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  26,
  NULL,
  NULL,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_91',
  'A company stores sensitive customer data in an Amazon S3 bucket and needs to ensure it is encrypted at rest. Order the steps to configure server-side encryption with Amazon S3 managed keys (SSE-S3) for an existing S3 bucket.',
  'ordering',
  '["Navigate to the ''Properties'' tab of the S3 bucket","Select ''Default encryption'' and choose ''Amazon S3 key (SSE-S3)''","Save the changes to apply the encryption settings","Open the Amazon S3 console and select the target bucket"]'::json,
  '{3,0,1,2}',
  'Configuring server-side encryption for an Amazon S3 bucket requires a specific sequence of actions within the console. Option D (Open the Amazon S3 console and select the target bucket) is the initial step to access the bucket''s settings. Option A (Navigate to the ''Properties'' tab of the S3 bucket) is where configuration options like encryption are located. Option B (Select ''Default encryption'' and choose ''Amazon S3 key (SSE-S3)'') specifies the desired encryption method. Finally, Option C (Save the changes to apply the encryption settings) commits the configuration, ensuring all new objects uploaded to the bucket are encrypted at rest.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  27,
  NULL,
  NULL,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_92',
  'An organization uses AWS Organizations to manage multiple AWS accounts. Order the hierarchy of governance from the broadest to the most granular level of control using Service Control Policies (SCPs).',
  'ordering',
  '["Organizational Units (OUs)","AWS Account","Root of the organization","IAM User/Role within an account"]'::json,
  '{2,0,1,3}',
  'The hierarchy of governance within AWS Organizations, especially with SCPs, flows from the broadest to the most specific. Option C (Root of the organization) is the highest level, where SCPs apply to all accounts unless overridden. Option A (Organizational Units (OUs)) are logical groupings of accounts, allowing for more granular policy application than the root. Option B (AWS Account) is the individual account level, where SCPs define the maximum permissions for all IAM entities within that account. Finally, Option D (IAM User/Role within an account) represents the most granular level, where IAM policies grant specific permissions, but these are always constrained by any applicable SCPs at higher levels.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  28,
  NULL,
  NULL,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_93',
  'A compliance officer needs to track configuration changes of AWS resources over time for auditing purposes. Order the steps to set up AWS Config for this requirement.',
  'ordering',
  '["Enable AWS Config in the AWS Management Console","Define which resource types to record (e.g., EC2 instances, S3 buckets)","Review the configuration history and compliance status of resources","Configure an Amazon S3 bucket for storing configuration history and snapshots"]'::json,
  '{0,1,3,2}',
  'Setting up AWS Config to track resource configuration changes involves a clear sequence. Option A (Enable AWS Config in the AWS Management Console) is the initial activation step. Next, Option B (Define which resource types to record (e.g., EC2 instances, S3 buckets)) specifies the scope of Config''s monitoring. Option D (Configure an Amazon S3 bucket for storing configuration history and snapshots) is crucial for durable storage of the collected configuration data. Finally, Option C (Review the configuration history and compliance status of resources) is the operational step where the collected data is analyzed for auditing and compliance checks.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  29,
  NULL,
  NULL,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_94',
  'An organization needs to ensure all API calls made within its AWS account are logged and auditable for governance and compliance. Order the steps to achieve this.',
  'ordering',
  '["Configure CloudTrail to deliver logs to an Amazon S3 bucket.","Enable AWS CloudTrail in the AWS account.","Review CloudTrail logs in Amazon S3 or through the CloudTrail console for audit purposes.","Optionally, integrate CloudTrail with Amazon CloudWatch Logs for real-time monitoring and alerting."]'::json,
  '{1,0,3,2}',
  'To ensure all API calls are logged and auditable, the first step is to enable AWS CloudTrail in the AWS account (Option B). CloudTrail records API calls and related events. Next, configure CloudTrail to deliver these logs to an Amazon S3 bucket (Option A) for long-term storage and analysis. Optionally, for real-time monitoring and alerting, CloudTrail can be integrated with Amazon CloudWatch Logs (Option D). Finally, the CloudTrail logs can be reviewed in Amazon S3 or through the CloudTrail console (Option C) for audit purposes, security analysis, or troubleshooting. Not enabling CloudTrail (anti-pattern ap-2.2-002) would result in missing audit trail requirements.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  30,
  NULL,
  NULL,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_95',
  'A company needs to demonstrate its adherence to industry compliance standards to auditors. Order the steps for a customer to access AWS compliance reports and certifications.',
  'ordering',
  '["Log in to the AWS Management Console.","Navigate to the AWS Artifact service.","Accept the Non-Disclosure Agreement (NDA) for specific reports, if required.","Download the relevant compliance reports (e.g., SOC, PCI DSS) or certifications."]'::json,
  '{0,1,2,3}',
  'To access AWS compliance reports and certifications, the customer must first log in to the AWS Management Console (Option A). Then, they navigate to the AWS Artifact service (Option B), which is the central resource for compliance-related information. Within AWS Artifact, for certain sensitive reports, a Non-Disclosure Agreement (NDA) may need to be accepted (Option C). Finally, the customer can download the relevant compliance reports or certifications (Option D) to provide to their auditors. AWS Artifact provides direct access to these documents, which cover AWS''s security and compliance posture.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  31,
  NULL,
  NULL,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_96',
  'An organization uses AWS Organizations to manage multiple AWS accounts. Order the hierarchy of governance controls from the broadest scope to the most granular scope within this setup.',
  'ordering',
  '["IAM policies (individual user/role permissions)","Service Control Policies (SCPs) (organization/OU-level guardrails)","AWS Organizations Root (highest level of control)","Organizational Units (OUs) (grouping of accounts)"]'::json,
  '{2,3,1,0}',
  'The hierarchy of governance controls in AWS Organizations, from broadest to most granular, starts with the AWS Organizations Root (Option C), which is the highest level of control for the entire organization. Below the root, Organizational Units (OUs) (Option D) are used to group accounts, allowing for hierarchical management. Service Control Policies (SCPs) (Option B) are then applied at the OU or root level to set maximum permissions for all accounts within that scope, acting as guardrails. Finally, IAM policies (Option A) are the most granular, defining specific permissions for individual users, groups, or roles within an account. Ignoring governance controls like SCPs (anti-pattern ap-2.2-004) can lead to unmanaged actions across accounts.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  32,
  NULL,
  NULL,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_97',
  'A compliance team needs to track and audit changes to AWS resource configurations over time. Order the typical flow for using AWS Config to achieve this.',
  'ordering',
  '["Review the configuration timeline and history of specific resources.","Enable AWS Config in the AWS account.","Define AWS Config rules to evaluate resource compliance against desired configurations.","Receive notifications for non-compliant resources and configuration changes."]'::json,
  '{1,2,3,0}',
  'To track and audit configuration changes with AWS Config, the first step is to enable AWS Config in the AWS account (Option B). Once enabled, Config starts recording configuration changes for supported resources. Next, define AWS Config rules (Option C) to continuously evaluate resource compliance against desired configurations and best practices. As changes occur or non-compliant resources are detected, you receive notifications (Option D). Finally, you can review the configuration timeline and history of specific resources (Option A) through the Config console to understand changes over time and aid in auditing. Not enabling Config (anti-pattern ap-2.2-002) means missing out on tracking resource configuration changes.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  33,
  NULL,
  NULL,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_98',
  'A company''s compliance officer needs to access AWS compliance reports and agreements for an upcoming audit to demonstrate adherence to regulatory standards. This requires knowing where to find authoritative documentation provided by AWS. Order the following steps to obtain compliance reports and agreements using AWS Artifact.',
  'ordering',
  '["Log in to the AWS Management Console.","Navigate to the AWS Artifact service.","Browse or search for the specific compliance reports (e.g., SOC, PCI DSS) or agreements (e.g., BAA) required for the audit.","Download the relevant documents to provide to auditors or for internal review."]'::json,
  '{0,1,2,3}',
  'The correct sequence for obtaining compliance reports and agreements starts by logging in to the AWS Management Console (Option A). Next, navigate to the AWS Artifact service (Option B), which is the central resource for these documents. Then, browse or search for the specific compliance reports or agreements (Option C) that are relevant to your audit requirements. Finally, download the necessary documents (Option D) to provide to your auditors or for internal review, ensuring your organization can demonstrate its compliance posture.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  34,
  NULL,
  NULL,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_99',
  'A data analytics team needs to store sensitive customer data in an Amazon S3 bucket and ensure it is encrypted at rest to meet data protection requirements. This is a fundamental security control for stored data. Order the following steps to enable server-side encryption with Amazon S3-managed keys (SSE-S3) for an existing Amazon S3 bucket.',
  'ordering',
  '["Navigate to the Amazon S3 console in the AWS Management Console.","Select the target S3 bucket and go to its ''Properties'' tab.","Locate the ''Default encryption'' section and click ''Edit''.","Choose ''Server-side encryption with Amazon S3-managed keys (SSE-S3)'' and save changes."]'::json,
  '{0,1,2,3}',
  'The correct order to enable SSE-S3 for an Amazon S3 bucket begins by navigating to the Amazon S3 console (Option A). Next, select the specific S3 bucket and go to its ''Properties'' tab (Option B). Then, locate the ''Default encryption'' section within the properties and click ''Edit'' (Option C). Finally, choose ''Server-side encryption with Amazon S3-managed keys (SSE-S3)'' and save the changes (Option D) to ensure all new objects uploaded to the bucket are encrypted at rest by default.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  35,
  NULL,
  NULL,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_100',
  'An organization requires a complete audit trail of all API calls and actions taken within their AWS account for security, operational troubleshooting, and compliance purposes. This trail helps in forensic analysis and accountability. Order the following steps to enable comprehensive logging and auditing with AWS CloudTrail.',
  'ordering',
  '["Navigate to the AWS CloudTrail console in the AWS Management Console.","Create a new trail, specifying a name and an Amazon S3 bucket to store the logs.","Configure the trail to log management events and optionally data events for services like Amazon S3 and AWS Lambda.","Enable CloudTrail log file integrity validation and optionally send logs to Amazon CloudWatch Logs for real-time monitoring."]'::json,
  '{0,1,2,3}',
  'The correct order for enabling comprehensive logging and auditing with AWS CloudTrail starts by navigating to the AWS CloudTrail console (Option A). Next, create a new trail (Option B), providing a name and designating an Amazon S3 bucket where the logs will be stored. Then, configure the trail to log management events, which capture API calls on your AWS resources, and optionally enable data events for more granular logging (Option C). Finally, enable CloudTrail log file integrity validation for tamper detection and consider sending logs to Amazon CloudWatch Logs (Option D) for real-time monitoring and alerting capabilities.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  36,
  NULL,
  NULL,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_101',
  'A DevOps team wants to track configuration changes of their AWS resources over time to maintain governance, ensure compliance, and enable auditing of resource states. This allows them to see ''who, what, and when'' changes occurred. Order the following steps to set up AWS Config to record resource configuration changes.',
  'ordering',
  '["Navigate to the AWS Config console in the AWS Management Console.","Enable AWS Config, choosing to record all resources or specific resource types.","Specify an Amazon S3 bucket for storing configuration history and snapshots, and an Amazon SNS topic for notifications.","Define AWS Config rules to evaluate resource configurations against desired settings and receive alerts for non-compliant resources."]'::json,
  '{0,1,2,3}',
  'The correct order for setting up AWS Config begins by navigating to the AWS Config console (Option A). Next, enable AWS Config (Option B), selecting whether to record all supported resource types or only specific ones. Then, specify an Amazon S3 bucket for storing the configuration history and snapshots, and an Amazon SNS topic for delivering notifications about configuration changes (Option C). Finally, define AWS Config rules (Option D) to continuously evaluate your resource configurations against predefined or custom compliance standards and receive alerts when resources become non-compliant.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  37,
  NULL,
  NULL,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_102',
  'An organization with multiple AWS accounts wants to enforce guardrails to prevent specific actions across all member accounts within an Organizational Unit (OU), regardless of individual IAM permissions. This is a powerful governance mechanism. Order the following steps to apply a Service Control Policy (SCP) to an Organizational Unit (OU) in AWS Organizations.',
  'ordering',
  '["Ensure AWS Organizations is enabled and all accounts are part of an Organizational Unit (OU).","Create a new Service Control Policy (SCP) with a JSON policy document that specifies the disallowed actions.","Attach the newly created SCP to the target Organizational Unit (OU).","Verify the SCP''s effect by attempting a disallowed action in a member account within the OU."]'::json,
  '{0,1,2,3}',
  'The correct order for applying an SCP starts by ensuring AWS Organizations is enabled and accounts are structured into Organizational Units (OUs) (Option A). Next, create a new Service Control Policy (SCP) (Option B) with a JSON policy document that explicitly defines the actions you want to prevent. Then, attach this newly created SCP to the target Organizational Unit (OU) (Option C), which will apply the restrictions to all accounts within that OU. Finally, verify the SCP''s effect (Option D) by attempting one of the disallowed actions in a member account to confirm that the guardrail is functioning as intended.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  38,
  NULL,
  NULL,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_61_1
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_74',
  'A company is deploying an application on an Amazon EC2 instance. Order the following responsibilities from AWS to the customer according to the AWS shared responsibility model for this IaaS service.',
  'ordering',
  '["Operating system patching and security updates","Physical security of the data center","Configuration of network firewalls (Security Groups)","Management of the virtualization layer (hypervisor)"]'::json,
  '{1,3,0,2}',
  'For an IaaS service like Amazon EC2, the shared responsibility model clearly delineates roles. Option B (Physical security of the data center) is solely an AWS responsibility, as AWS manages the underlying infrastructure. Option D (Management of the virtualization layer (hypervisor)) is also an AWS responsibility, as they manage the ''security OF the cloud''. Option A (Operating system patching and security updates) falls under the customer''s responsibility for an EC2 instance, as it''s part of ''security IN the cloud''. Option C (Configuration of network firewalls (Security Groups)) is also a customer responsibility, as they define the rules for their instances.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  39,
  NULL,
  NULL,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_75',
  'A team is storing data in an Amazon S3 bucket. Order the following responsibilities from AWS to the customer according to the AWS shared responsibility model for this object storage service.',
  'ordering',
  '["Encryption of customer data at rest and in transit","Physical infrastructure of the S3 service","Access control to the S3 bucket and objects (IAM policies)","Software and hardware maintenance of S3 storage infrastructure"]'::json,
  '{1,3,0,2}',
  'For Amazon S3, a managed service, the shared responsibility model shifts some burdens. Option B (Physical infrastructure of the S3 service) is an AWS responsibility, covering the underlying hardware. Option D (Software and hardware maintenance of S3 storage infrastructure) is also an AWS responsibility, as they manage the ''security OF the cloud'' for the service itself. Option A (Encryption of customer data at rest and in transit) is a shared responsibility, where AWS provides the tools (like SSE-S3, KMS) but the customer configures and enables them. Option C (Access control to the S3 bucket and objects (IAM policies)) is a customer responsibility, as they define who can access their data, falling under ''security IN the cloud''.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  40,
  NULL,
  NULL,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_76',
  'A database administrator is deploying an Amazon RDS for MySQL instance. Order the following responsibilities from AWS to the customer according to the AWS shared responsibility model for this managed database service.',
  'ordering',
  '["Database engine patching and updates","Network configuration for database access (Security Groups)","Underlying hardware and operating system of the database server","Data encryption at rest and in transit for the database"]'::json,
  '{2,0,3,1}',
  'For Amazon RDS, a managed database service, the shared responsibility model means AWS handles more. Option C (Underlying hardware and operating system of the database server) is an AWS responsibility, as they manage the infrastructure and OS patching. Option A (Database engine patching and updates) is also an AWS responsibility, as they manage the database software itself. Option D (Data encryption at rest and in transit for the database) is a shared responsibility, where AWS provides the encryption features (like KMS integration) and the customer enables and configures them. Option B (Network configuration for database access (Security Groups)) is a customer responsibility, as they define the network access rules to their database instance.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  41,
  NULL,
  NULL,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_77',
  'Consider how the AWS shared responsibility model generally shifts with different service types. Order the service models from where the customer has the MOST responsibility to where the customer has the LEAST responsibility.',
  'ordering',
  '["Platform as a Service (PaaS) like Amazon RDS","Infrastructure as a Service (IaaS) like Amazon EC2","Serverless computing like AWS Lambda","On-premises data center"]'::json,
  '{3,1,0,2}',
  'The AWS shared responsibility model shifts the burden of security based on the service model. Option D (On-premises data center) represents the scenario where the customer has 100% of the responsibility for all layers, from physical security to applications. Option B (Infrastructure as a Service (IaaS) like Amazon EC2) shifts some responsibility to AWS (physical, hypervisor), but the customer still manages the OS, runtime, data, and applications. Option A (Platform as a Service (PaaS) like Amazon RDS) further reduces customer responsibility, with AWS managing the OS, database engine, and underlying infrastructure. Option C (Serverless computing like AWS Lambda) represents the model where the customer has the least responsibility, focusing almost entirely on their code and data, with AWS managing the entire underlying infrastructure, OS, and runtime.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  42,
  NULL,
  NULL,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_78',
  'The shared responsibility model shifts depending on the service type. Order the following service models from where AWS has the least responsibility to where AWS has the most responsibility for patching.',
  'ordering',
  '["Infrastructure as a Service (IaaS) like Amazon EC2.","Platform as a Service (PaaS) like Amazon RDS.","Software as a Service (SaaS) like Amazon S3.","Serverless computing like AWS Lambda."]'::json,
  '{0,1,3,2}',
  'The shared responsibility for patching shifts across service models. AWS has the least responsibility for patching in Infrastructure as a Service (IaaS) like Amazon EC2 (Option A), where the customer is responsible for the guest operating system and application patching. For Platform as a Service (PaaS) like Amazon RDS (Option B), AWS manages the underlying OS and database engine patching, but the customer may still manage application-level patching or database configuration. For serverless computing like AWS Lambda (Option D), AWS handles the underlying infrastructure, OS, and runtime environment patching. Finally, for Software as a Service (SaaS) like Amazon S3 (Option C), AWS manages all aspects of the service, including patching, with the customer primarily responsible for data and access. Confusing the shared responsibility boundary for managed services vs. unmanaged services (anti-pattern ap-2.1-003) is a common misconception.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  43,
  NULL,
  NULL,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_79',
  'For a managed database service like Amazon RDS, the shared responsibility model clarifies who is responsible for different security aspects. Order the following from AWS''s responsibility to the customer''s responsibility.',
  'ordering',
  '["Database engine patching and updates.","Application-level security within the database.","Physical security of the underlying infrastructure.","Network configuration (e.g., security groups for database access)."]'::json,
  '{2,0,3,1}',
  'For Amazon RDS, AWS is responsible for the ''security OF the cloud'', which includes the physical security of the underlying infrastructure (Option C) and the database engine patching and updates (Option A). The customer is responsible for ''security IN the cloud'', which includes network configuration such as security groups for database access (Option D), and application-level security within the database (Option B), such as user management and data encryption. Assuming AWS handles all security including customer data encryption and access control (anti-pattern ap-2.1-001) is incorrect.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  44,
  NULL,
  NULL,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_80',
  'The AWS Shared Responsibility Model divides security tasks between AWS and the customer. Order the following focus areas from AWS''s primary responsibility to the customer''s primary responsibility.',
  'ordering',
  '["Customer data encryption and access management.","Physical infrastructure and global network.","Operating systems, network configuration, and platform applications.","Virtualization layer and managed service patching."]'::json,
  '{1,3,2,0}',
  'The Shared Responsibility Model outlines distinct areas. AWS''s primary responsibility, ''security OF the cloud'', includes the physical infrastructure and global network (Option B), as well as the virtualization layer and managed service patching (Option D). The customer''s primary responsibility, ''security IN the cloud'', includes operating systems, network configuration, and platform applications (Option C) for IaaS services like EC2, and customer data encryption and access management (Option A) across all services. Assuming AWS handles all security including customer data encryption and access control (anti-pattern ap-2.1-001) is a core misconception addressed by this model.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  45,
  NULL,
  NULL,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_81',
  'A development team is deploying serverless applications using AWS Lambda and needs to understand the distribution of security responsibilities to ensure their functions are secure. This requires recognizing how the shared responsibility model shifts for serverless services. Order the following security responsibilities from AWS''s responsibility to the customer''s responsibility for an AWS Lambda function.',
  'ordering',
  '["AWS is responsible for the underlying compute infrastructure, including patching the operating system and Lambda runtime environment.","AWS is responsible for the physical security of the facilities where Lambda functions execute.","The customer is responsible for the security of their function code, including dependencies and libraries.","The customer is responsible for configuring IAM permissions for the Lambda function''s execution role and invocation access."]'::json,
  '{1,0,2,3}',
  'For AWS Lambda, a serverless service, AWS takes on a larger share of the responsibility. AWS is responsible for the physical security of facilities (Option B) and the underlying compute infrastructure, including patching the operating system and Lambda runtime environment (Option A). The customer''s responsibilities shift to securing their function code (Option C), ensuring it is free from vulnerabilities, and configuring appropriate IAM permissions for the Lambda function''s execution role and invocation access (Option D) to control what the function can do and who can invoke it. The order shows the extensive AWS responsibility for the platform, followed by the customer''s focus on application-level security.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  46,
  NULL,
  NULL,
  'm_61_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_82',
  'An administrator needs to determine whether AWS or the customer is responsible for patching the operating system of a newly provisioned AWS resource. This decision is critical for compliance and operational security. Order the following steps to correctly identify the party responsible for operating system patching based on the AWS shared responsibility model.',
  'ordering',
  '["Identify the specific AWS service being used (e.g., Amazon EC2, Amazon RDS, AWS Lambda).","Determine the service model (IaaS, PaaS, or Serverless) that the identified AWS service falls under.","Consult the AWS Shared Responsibility Model documentation for the specific service or service model.","Based on the documentation, ascertain whether AWS or the customer is responsible for OS patching."]'::json,
  '{0,1,2,3}',
  'To correctly identify OS patching responsibility, the first step is to identify the specific AWS service in question (Option A), as responsibilities vary greatly between services. Next, determine the service model (IaaS, PaaS, or Serverless) (Option B) that the service falls under, as this directly influences the shared responsibility boundary. Then, consult the official AWS Shared Responsibility Model documentation (Option C) for the specific service or service model. Finally, based on the authoritative documentation, ascertain whether AWS or the customer is responsible for OS patching (Option D).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  47,
  NULL,
  NULL,
  'm_61_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_83',
  'A company is designing an application that processes sensitive data and needs to ensure data is encrypted while moving between AWS services (data in transit). This is a critical security requirement under the shared responsibility model. Order the following actions to ensure data encryption in transit for an application using AWS services, considering the shared responsibility model.',
  'ordering',
  '["Identify all communication paths and data flows between AWS services in the application architecture.","Configure AWS services to use encrypted endpoints and protocols (e.g., HTTPS for API calls, SSL/TLS for database connections).","Implement client-side encryption for data before it leaves the source, if additional protection is required.","Verify that all data in transit is encrypted by testing the application and monitoring network traffic."]'::json,
  '{0,1,2,3}',
  'To ensure data encryption in transit, the first step is to identify all communication paths and data flows (Option A) between AWS services within the application. Next, configure AWS services to use encrypted endpoints and protocols (Option B), such as HTTPS for API Gateway or Amazon S3, and SSL/TLS for Amazon RDS or Amazon EC2 connections. If additional protection is needed, implement client-side encryption for data (Option C) before it is sent over the network. Finally, verify that all data in transit is encrypted (Option D) by thoroughly testing the application and monitoring network traffic to confirm the use of secure protocols.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  48,
  NULL,
  NULL,
  'm_61_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_94'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_95'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_96'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_97'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_98'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_99'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_100'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_101'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_102'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_103'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_104'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_105'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_90'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_91'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_92'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_93'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_94'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_95'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_96'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_97'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_98'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_99'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_100'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_101'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_89'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_90'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_91'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_92'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_93'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_94'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_95'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_96'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_97'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_98'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_99'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_100'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_101'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_102'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_74'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_75'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_76'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_77'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_78'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_79'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_80'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_81'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_82'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_83')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain61_13'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;


-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: CLF-C02
-- Generated: 2026-03-14T21:11:53.057Z
-- Questions: 84 (84 validated, 43 rejected)
-- Quiz ID: quiz_domain62_13
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_62_1
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_82',
  'A developer wants to use Infrastructure as Code (IaC) to deploy a simple web application using AWS CloudFormation. Arrange the following steps in the correct order to achieve this.',
  'ordering',
  '["Upload the CloudFormation template to an Amazon S3 bucket.","Write the application code and create a CloudFormation template.","Monitor the stack creation events in the AWS Management Console.","Deploy the CloudFormation stack using the AWS CLI or Management Console."]'::json,
  '{1,0,3,2}',
  'To deploy an application using AWS CloudFormation, the first step is to write the application code and define the infrastructure in a CloudFormation template (Option B). Next, the template needs to be uploaded to an Amazon S3 bucket (Option A) so CloudFormation can access it. After the template is ready and accessible, the CloudFormation stack can be deployed using the AWS CLI or Management Console (Option D). Finally, it''s important to monitor the stack creation events to ensure successful deployment and troubleshoot any issues (Option C).',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  1,
  NULL,
  NULL,
  'm_62_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_83',
  'A new AWS user wants to deploy a simple web server on an Amazon EC2 instance using the AWS Management Console. Order the basic steps.',
  'ordering',
  '["Connect to the EC2 instance and install web server software.","Launch an EC2 instance, selecting an AMI and instance type.","Configure the security group to allow inbound HTTP/HTTPS traffic.","Generate or select a key pair for SSH access."]'::json,
  '{1,3,2,0}',
  'To deploy a web server on Amazon EC2, the first step is to launch an EC2 instance, choosing an Amazon Machine Image (AMI) and an instance type (Option B). During the launch process, you must generate or select a key pair (Option D) for secure SSH access to the instance. Before connecting, the security group must be configured to allow inbound HTTP (port 80) and/or HTTPS (port 443) traffic (Option C) to enable web access. Finally, you can connect to the EC2 instance and install your web server software (Option A).',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  2,
  NULL,
  NULL,
  'm_62_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_84',
  'A team is transitioning from manual infrastructure configuration to Infrastructure as Code (IaC) using AWS Cloud Development Kit (CDK). Order the typical workflow steps.',
  'ordering',
  '["Synthesize the CDK application into CloudFormation templates.","Write application code and define AWS resources using CDK constructs.","Deploy the CloudFormation stack to your AWS account.","Initialize a new CDK project in your preferred programming language."]'::json,
  '{3,1,0,2}',
  'The first step when starting with AWS CDK is to initialize a new CDK project (Option D) in your chosen programming language, which sets up the project structure. Next, you write your application code and define your AWS resources using CDK constructs within that project (Option B). Once the CDK application is defined, you synthesize it (Option A), which translates your code into standard AWS CloudFormation templates. Finally, these CloudFormation templates are deployed to your AWS account (Option C) to provision the actual resources.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  3,
  NULL,
  NULL,
  'm_62_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_85',
  'A solutions architect is planning to provision a new set of infrastructure resources using AWS CloudFormation for a repeatable deployment. Order the following actions to correctly deploy the infrastructure.',
  'ordering',
  '["Review the CloudFormation stack events and resources.","Define the infrastructure resources in a CloudFormation template (YAML/JSON).","Upload the template to an S3 bucket or directly use it in the console/CLI.","Create a new CloudFormation stack using the template."]'::json,
  '{1,2,3,0}',
  'The process of deploying infrastructure with AWS CloudFormation begins by defining the desired resources in a CloudFormation template (Option B). Once the template is ready, it needs to be made accessible to CloudFormation, typically by uploading it to an Amazon S3 bucket or providing it directly via the console or CLI (Option C). Then, a new CloudFormation stack is created using this template (Option D), which initiates the provisioning of resources. Finally, reviewing the stack events and resources (Option A) is crucial to verify successful deployment and troubleshoot any issues.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  4,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_86',
  'A company is transitioning from manual infrastructure configuration to a more automated approach. Order the following methods of interacting with AWS from LEAST automated to MOST automated.',
  'ordering',
  '["Using AWS SDKs to integrate AWS services into custom applications.","Manually configuring resources through the AWS Management Console.","Using AWS CloudFormation to define and provision infrastructure as code.","Executing commands using the AWS Command Line Interface (CLI)."]'::json,
  '{1,3,0,2}',
  'The AWS Management Console (Option B) represents the least automated method, requiring manual clicks for every action. The AWS Command Line Interface (CLI) (Option D) offers more automation than the console by allowing scriptable commands. AWS SDKs (Option A) provide libraries for programmatic interaction, enabling deeper integration into applications. AWS CloudFormation (Option C) offers the highest level of automation for infrastructure provisioning by defining resources as code, ensuring repeatability and consistency.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  5,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_87',
  'A software development company is planning to adopt Infrastructure as Code (IaC) for managing its AWS resources. Order the following approaches from LEAST to MOST suitable for defining and deploying complex, repeatable infrastructure.',
  'ordering',
  '["Using AWS CloudFormation to define infrastructure in declarative templates.","Manually creating resources via the AWS Management Console.","Writing shell scripts that call AWS CLI commands to provision resources.","Using AWS Elastic Beanstalk for platform-as-a-service deployments."]'::json,
  '{1,2,3,0}',
  'Manually creating resources via the AWS Management Console (Option B) is the least suitable for complex, repeatable infrastructure due to its error-prone and non-auditable nature. Writing shell scripts that call AWS CLI commands (Option C) offers some automation but can become complex and difficult to manage for intricate infrastructures. AWS Elastic Beanstalk (Option D) is a Platform as a Service (PaaS) offering that automates application deployment and scaling, but it''s more focused on application environments than arbitrary infrastructure. AWS CloudFormation (Option A) is the most suitable for defining and deploying complex, repeatable infrastructure as code, providing a declarative way to manage a wide range of AWS resources.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  6,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_88',
  'A developer wants to create a simple web application that automatically scales and handles deployments without managing underlying servers. Order the following steps to deploy an application using AWS Elastic Beanstalk.',
  'ordering',
  '["Create an Elastic Beanstalk application and environment.","Upload the application source bundle (e.g., .zip file).","Select a platform (e.g., Node.js, Python, Java).","Monitor the environment health and application logs."]'::json,
  '{0,2,1,3}',
  'To deploy an application using AWS Elastic Beanstalk, the first step is to create an Elastic Beanstalk application and environment (Option A). Next, select a platform (Option C) that matches the application''s language and framework. Then, upload the application source bundle (Option B) containing the application code. Finally, monitor the environment health and application logs (Option D) to ensure the application is running smoothly and troubleshoot any issues.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  7,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_89',
  'A company needs to deploy a new application and wants to ensure its infrastructure is defined and managed programmatically. Order the following methods of infrastructure management from LEAST programmatic to MOST programmatic.',
  'ordering',
  '["Using AWS SDKs to create and manage resources.","Manually configuring resources through the AWS Management Console.","Using AWS CloudFormation for Infrastructure as Code (IaC).","Executing commands via the AWS Command Line Interface (CLI)."]'::json,
  '{1,3,0,2}',
  'Manually configuring resources through the AWS Management Console (Option B) is the least programmatic method, relying on manual actions. Executing commands via the AWS Command Line Interface (CLI) (Option D) offers a command-line interface for scripting, making it more programmatic than the console. Using AWS SDKs (Option A) allows developers to integrate AWS services directly into their application code, providing a higher level of programmatic control. Using AWS CloudFormation (Option C) for Infrastructure as Code (IaC) is the most programmatic and automated approach, allowing entire infrastructures to be defined and managed declaratively.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  8,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_90',
  'Arrange the following steps in the correct order to deploy infrastructure using AWS CloudFormation.',
  'ordering',
  '["Create a stack from the template","Review stack events and resources","Define resources in a CloudFormation template","Upload template to Amazon S3"]'::json,
  '{2,3,0,1}',
  'The correct order for deploying infrastructure with AWS CloudFormation begins with defining the desired resources in a CloudFormation template (Option C). Once the template is prepared, it is typically uploaded to Amazon S3 (Option D) for storage and versioning. Next, a stack is created from this template (Option A), which provisions the specified AWS resources. Finally, the deployment progress and resource status can be monitored by reviewing the stack events and resources (Option B) in the AWS Management Console or via the AWS CLI.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  9,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_91',
  'Order the typical steps for deploying a web application using AWS Elastic Beanstalk.',
  'ordering',
  '["Upload application source bundle","Create an Elastic Beanstalk application","Deploy application version to environment","Create an environment for the application"]'::json,
  '{1,3,0,2}',
  'The process of deploying an application with AWS Elastic Beanstalk starts by creating an Elastic Beanstalk application (Option B), which acts as a logical container for your application. Next, an environment is created for this application (Option D), defining the infrastructure where the application will run. After the environment is ready, the application source bundle is uploaded (Option A). Finally, the uploaded application version is deployed to the Elastic Beanstalk environment (Option C), making it accessible to users.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  10,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_92',
  'Arrange these actions in the typical sequence for interacting with AWS services using the AWS Command Line Interface (CLI).',
  'ordering',
  '["Receive command output","Install AWS CLI","Execute AWS CLI command","Configure AWS CLI with credentials"]'::json,
  '{1,3,2,0}',
  'To interact with AWS services using the AWS Command Line Interface (CLI), the first step is to install the AWS CLI software on your local machine (Option B). After installation, you must configure the AWS CLI with your AWS access keys and default Region (Option D) to authenticate your requests. Once configured, you can execute specific AWS CLI commands (Option C) to manage AWS resources. Finally, the AWS CLI will return the command output (Option A), indicating the result of your operation.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  11,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_93',
  'Order the typical steps to deploy infrastructure using AWS CloudFormation.',
  'ordering',
  '["Upload the CloudFormation template to an Amazon S3 bucket","Create a new CloudFormation stack based on the template","Define the infrastructure resources in a CloudFormation template (YAML/JSON)","Monitor the stack creation events and resource statuses"]'::json,
  '{2,0,1,3}',
  'The correct sequence for deploying infrastructure with AWS CloudFormation begins with defining the desired resources. Option C (Define the infrastructure resources in a CloudFormation template) is the initial step, where you write the template. Next, Option A (Upload the CloudFormation template to an Amazon S3 bucket) is a common practice for storing templates, especially for larger ones. Then, Option B (Create a new CloudFormation stack based on the template) initiates the deployment process. Finally, Option D (Monitor the stack creation events and resource statuses) is crucial for verifying successful deployment and troubleshooting any issues. Uploading the template before creating the stack ensures the template is accessible.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  12,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_94',
  'Order the actions to interact with AWS services using the AWS Command Line Interface (CLI) after installation.',
  'ordering',
  '["Configure AWS credentials (e.g., access key, secret key, default Region)","Execute a specific AWS CLI command (e.g., ''aws s3 ls'')","Review the command''s output in the terminal","Verify the desired resource creation or modification in the AWS Management Console or via another CLI command"]'::json,
  '{0,1,2,3}',
  'After installing the AWS CLI, the first essential step is to set up your authentication and default settings. Option A (Configure AWS credentials) is necessary to allow the CLI to interact with your AWS account. Once configured, Option B (Execute a specific AWS CLI command) allows you to perform actions on AWS services. Following command execution, Option C (Review the command''s output in the terminal) provides immediate feedback. Finally, Option D (Verify the desired resource creation or modification) is a best practice to confirm that the command had the intended effect, either through the console or further CLI commands.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  13,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_95',
  'A development team wants to deploy a new application using Infrastructure as Code (IaC) to ensure consistency and repeatability. Order the typical high-level steps for an IaC deployment.',
  'ordering',
  '["Define the desired AWS resources in an AWS CloudFormation template.","Provision resources using the AWS CloudFormation template.","Monitor the deployed resources and application.","Validate the CloudFormation template for syntax and logic."]'::json,
  '{0,3,1,2}',
  'The correct order for an IaC deployment begins with defining the infrastructure. Option A (Define the desired AWS resources in an AWS CloudFormation template) is the initial step, where the infrastructure is described. Next, Option D (Validate the CloudFormation template for syntax and logic) ensures the template is error-free before deployment. After validation, Option B (Provision resources using the AWS CloudFormation template) executes the template to create the AWS resources. Finally, Option C (Monitor the deployed resources and application) is crucial for ongoing operational excellence.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  14,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_96',
  'Order the following methods of interacting with AWS from the most manual and least scalable to the most automated and scalable.',
  'ordering',
  '["Using AWS SDKs to programmatically manage resources.","Manually configuring resources through the AWS Management Console.","Deploying infrastructure with AWS CloudFormation templates.","Using the AWS Command Line Interface (CLI) for scripting."]'::json,
  '{1,3,0,2}',
  'The correct order from most manual to most automated is: Option B (Manually configuring resources through the AWS Management Console) is the most manual and least scalable method. Option D (Using the AWS Command Line Interface (CLI) for scripting) offers more automation than the console but is still script-based. Option A (Using AWS SDKs to programmatically manage resources) provides a higher level of programmatic control for applications. Option C (Deploying infrastructure with AWS CloudFormation templates) represents the most automated and scalable approach, enabling Infrastructure as Code.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  15,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_97',
  'A development team plans to automate the deployment of their application infrastructure using AWS CloudFormation. Order the typical steps for defining and deploying resources using Infrastructure as Code (IaC).',
  'ordering',
  '["Upload the AWS CloudFormation template to an Amazon S3 bucket.","Define the infrastructure resources in an AWS CloudFormation template.","Review the proposed changes using a change set.","Create an AWS CloudFormation stack to provision resources."]'::json,
  '{1,0,2,3}',
  'The first logical step is to define the infrastructure resources in an AWS CloudFormation template (Option B), which describes the desired state of your AWS resources. Next, this template is typically uploaded to an Amazon S3 bucket (Option A) to make it accessible to CloudFormation. Before applying changes, it is a best practice to review the proposed changes using a change set (Option C) to understand the impact on your resources. Finally, an AWS CloudFormation stack is created or updated to provision the resources according to the template (Option D).',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  16,
  NULL,
  NULL,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_75',
  'A company wants to ensure high availability for its web application. Order the steps to deploy an application across multiple Availability Zones (AZs) within a single AWS Region.',
  'ordering',
  '["Configure an Elastic Load Balancer (ELB) to distribute traffic.","Launch Amazon EC2 instances into subnets across different Availability Zones.","Create subnets in at least two different Availability Zones within your VPC.","Ensure the application code and data are replicated or accessible from all instances."]'::json,
  '{2,1,0,3}',
  'To deploy an application across multiple Availability Zones, you must first create subnets in at least two different Availability Zones within your Amazon VPC (Option C) to provide network isolation. Next, launch Amazon EC2 instances (or other compute resources) into these subnets across the different Availability Zones (Option B). An Elastic Load Balancer (ELB) is then configured to distribute incoming traffic evenly across these instances (Option A), providing a single entry point. Finally, it''s crucial to ensure that the application code and data are replicated or accessible from all instances (Option D) to maintain consistent application state and functionality across AZs.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  17,
  NULL,
  NULL,
  'm_62_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_76',
  'A global company wants to improve the performance of its static website for users worldwide. Order the steps to use Amazon CloudFront for content delivery.',
  'ordering',
  '["Create an Amazon CloudFront distribution.","Upload static website content to an Amazon S3 bucket.","Configure the S3 bucket as the origin for the CloudFront distribution.","Update DNS records to point to the CloudFront distribution''s domain name."]'::json,
  '{1,0,2,3}',
  'To use Amazon CloudFront for static content delivery, the first step is to upload your static website content to an Amazon S3 bucket (Option B), which will serve as your origin. Next, you create an Amazon CloudFront distribution (Option A). During the distribution creation, you configure the S3 bucket as the origin (Option C) from which CloudFront will retrieve content. Finally, to direct user traffic to CloudFront, you update your DNS records (e.g., using Amazon Route 53) to point to the CloudFront distribution''s domain name (Option D).',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  18,
  NULL,
  NULL,
  'm_62_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_77',
  'A solutions architect is planning a multi-Region disaster recovery strategy. Order the considerations for choosing an AWS Region.',
  'ordering',
  '["Evaluate the cost of services in the chosen Region.","Check for compliance and data residency requirements.","Assess the latency to end-users in that geographical area.","Verify the availability of specific AWS services required by the application."]'::json,
  '{1,2,3,0}',
  'When choosing an AWS Region, the most critical initial consideration is compliance and data residency requirements (Option B), as these are often non-negotiable legal or regulatory mandates. Next, assessing the latency to end-users (Option C) is important for user experience and application performance. After that, verifying the availability of specific AWS services (Option D) ensures that all necessary components for the application can be deployed. Finally, evaluating the cost of services in the chosen Region (Option A) is a practical consideration to optimize expenditure.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  19,
  NULL,
  NULL,
  'm_62_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_78',
  'A global e-commerce company wants to reduce latency for its customers worldwide. Order the following AWS infrastructure components from broadest geographical scope to most localized.',
  'ordering',
  '["Availability Zones (AZs)","AWS Regions","AWS Edge Locations (for CloudFront)","AWS Local Zones"]'::json,
  '{1,0,3,2}',
  'AWS Regions (Option B) have the broadest geographical scope, representing independent geographic areas. Within each Region, there are multiple isolated Availability Zones (AZs) (Option A). AWS Local Zones (Option D) extend an AWS Region into a geographic area closer to users, providing low-latency access. AWS Edge Locations (Option C) are the most localized, used by Amazon CloudFront to cache content closest to end-users for optimal performance.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  20,
  NULL,
  NULL,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_79',
  'A media company needs to deliver video content with low latency to viewers across the globe. Order the following steps to optimize content delivery using AWS services.',
  'ordering',
  '["Upload video content to an Amazon S3 bucket.","Configure an Amazon CloudFront distribution.","Update DNS records in Amazon Route 53 to point to the CloudFront distribution.","Test content delivery from various geographical locations."]'::json,
  '{0,1,2,3}',
  'To optimize content delivery, the video content must first be uploaded to an Amazon S3 bucket (Option A), which serves as the origin for the content. Next, an Amazon CloudFront distribution (Option B) is configured, specifying the S3 bucket as the origin. This caches the content at AWS Edge Locations worldwide. Then, DNS records in Amazon Route 53 (Option C) are updated to direct user requests to the CloudFront distribution. Finally, testing content delivery (Option D) from different locations verifies the setup and performance improvements.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  21,
  NULL,
  NULL,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_80',
  'A company is planning a disaster recovery strategy for its critical application. Order the following considerations when choosing an AWS Region for deployment to balance cost, performance, and compliance.',
  'ordering',
  '["Evaluate data residency and regulatory compliance requirements.","Assess the latency to target user populations.","Compare service availability and feature parity across Regions.","Analyze the pricing differences for required services in various Regions."]'::json,
  '{0,1,2,3}',
  'When choosing an AWS Region, the first and often most critical consideration is evaluating data residency and regulatory compliance requirements (Option A), as these can legally mandate where data must reside. Next, assessing the latency to target user populations (Option B) is important for user experience. Then, comparing service availability and feature parity (Option C) ensures all necessary services are available and function as expected. Finally, analyzing pricing differences (Option D) helps optimize costs, but should be considered after compliance and performance needs are met.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  22,
  NULL,
  NULL,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_81',
  'A company is planning to expand its infrastructure globally and needs to understand the hierarchy of AWS''s global infrastructure. Order the following components from the largest geographical scope to the smallest.',
  'ordering',
  '["Availability Zone","AWS Region","Edge Location","Local Zone"]'::json,
  '{1,0,3,2}',
  'The AWS Region (Option B) has the largest geographical scope, being a distinct geographic area. Within each Region, there are multiple isolated Availability Zones (Option A). AWS Local Zones (Option D) extend a Region closer to specific populations for ultra-low latency. Edge Locations (Option C) are the smallest in scope, primarily used by Amazon CloudFront for content delivery and caching closest to end-users.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  23,
  NULL,
  NULL,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_82',
  'Order the steps to ensure high availability for an application by deploying it across multiple Availability Zones.',
  'ordering',
  '["Launch application resources (e.g., EC2 instances) into each Availability Zone","Create subnets in different Availability Zones within the VPC","Configure an Elastic Load Balancer to distribute traffic across resources","Create a Virtual Private Cloud (VPC)"]'::json,
  '{3,1,0,2}',
  'To deploy a highly available application across multiple Availability Zones, you must first establish your isolated network environment. Option D (Create a Virtual Private Cloud (VPC)) is the foundational step. Within this VPC, Option B (Create subnets in different Availability Zones) provides the network segmentation for fault tolerance. Next, Option A (Launch application resources into each Availability Zone) places your compute capacity in these separate zones. Finally, Option C (Configure an Elastic Load Balancer to distribute traffic across resources) ensures incoming requests are directed to healthy resources across the zones, providing high availability. Creating subnets before launching resources ensures the network is ready.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  24,
  NULL,
  NULL,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_83',
  'Arrange the sequence of events when a user requests content delivered by Amazon CloudFront.',
  'ordering',
  '["CloudFront checks its cache at the edge location for the requested content","The user''s DNS query for the content is resolved to a CloudFront edge location","CloudFront retrieves the content from the origin server (e.g., Amazon S3) if not cached","The content is delivered from the edge location to the user, providing low latency"]'::json,
  '{1,0,2,3}',
  'When a user requests content delivered by Amazon CloudFront, the process begins with DNS resolution. Option B (The user''s DNS query for the content is resolved to a CloudFront edge location) directs the user to the closest edge location. Upon reaching the edge, Option A (CloudFront checks its cache at the edge location for the requested content) determines if the content is readily available. If not in the cache, Option C (CloudFront retrieves the content from the origin server) fetches it from the source. Finally, Option D (The content is delivered from the edge location to the user) ensures fast delivery, leveraging the proximity of the edge location.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  25,
  NULL,
  NULL,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_84',
  'Order the typical considerations when choosing an AWS Region for a new application deployment, from most to least critical for many businesses.',
  'ordering',
  '["Service availability (ensuring required AWS services are present)","Data residency and compliance requirements","Latency to end-users for optimal performance","Cost of services in that specific Region"]'::json,
  '{1,2,0,3}',
  'When choosing an AWS Region, the most critical factors often relate to legal and user experience requirements. Option B (Data residency and compliance requirements) is frequently the paramount concern, as it dictates where data can legally reside. Following this, Option C (Latency to end-users for optimal performance) is crucial for a good user experience. Option A (Service availability), ensuring that all necessary AWS services are offered in the chosen Region, is also a fundamental prerequisite. Finally, Option D (Cost of services) is an important consideration but often secondary to compliance, latency, and service availability. Compliance and latency directly impact business operations and user satisfaction.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  26,
  NULL,
  NULL,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_85',
  'Order the components of the AWS global infrastructure from the broadest geographical scope to the most localized.',
  'ordering',
  '["Edge Location","Availability Zone","AWS Region","AWS Local Zone"]'::json,
  '{2,1,3,0}',
  'The correct order from broadest to most localized scope is: Option C (AWS Region) is the broadest, representing a physical location in the world with multiple Availability Zones. Option B (Availability Zone) is a distinct location within a Region that is isolated from failures in other AZs. Option D (AWS Local Zone) is an extension of an AWS Region into a geographical area closer to users. Option A (Edge Location) is the most localized, used by services like Amazon CloudFront for content delivery and caching, typically for low-latency access.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  27,
  NULL,
  NULL,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_7
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_75',
  'A data analyst wants to perform ad-hoc SQL queries on log files stored in Amazon S3. Order the steps to use Amazon Athena for this task.',
  'ordering',
  '["Define a table schema in Athena that matches the S3 data structure.","Store log files in an Amazon S3 bucket.","Execute SQL queries against the defined table.","Connect a Business Intelligence (BI) tool to Athena (optional)."]'::json,
  '{1,0,2,3}',
  'To use Amazon Athena for querying data in Amazon S3, the first step is to ensure your log files are stored in an Amazon S3 bucket (Option B). Athena queries data directly from S3. Next, you need to define a table schema in Athena (Option A) that describes the structure of your data in S3, allowing Athena to interpret it. Once the table is defined, you can execute SQL queries directly against this table using the Athena console or API (Option C). Optionally, for visualization and reporting, you can connect a Business Intelligence (BI) tool like Amazon QuickSight to Athena (Option D).',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  28,
  NULL,
  NULL,
  'm_62_7',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_76',
  'A company wants to process real-time streaming data from IoT devices. Order the basic steps to ingest and process this data using Amazon Kinesis Data Streams.',
  'ordering',
  '["Write a consumer application to process data from the stream.","Create an Amazon Kinesis Data Stream.","Configure IoT devices to send data to the Kinesis Data Stream.","Monitor the Kinesis stream and consumer application."]'::json,
  '{1,2,0,3}',
  'To process real-time streaming data with Amazon Kinesis Data Streams, the initial step is to create an Amazon Kinesis Data Stream (Option B) to serve as the ingestion point. Next, you configure your IoT devices (or other data producers) to send their data to this newly created Kinesis Data Stream (Option C). After data is being ingested, you need to write a consumer application (Option A), such as an AWS Lambda function or an Amazon Kinesis Data Analytics application, to read and process the data from the stream. Finally, it''s essential to monitor the Kinesis stream and your consumer application (Option D) to ensure data is flowing correctly and being processed efficiently.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  29,
  NULL,
  NULL,
  'm_62_7',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_77',
  'A marketing team wants to analyze customer sentiment from text reviews. Order the steps to use Amazon Comprehend for this task.',
  'ordering',
  '["Send the text reviews to the Amazon Comprehend API.","Receive the sentiment analysis results (e.g., Positive, Negative, Neutral).","Collect customer text reviews (e.g., from a database or S3).","Integrate the Comprehend API into your application or script."]'::json,
  '{2,3,0,1}',
  'To analyze customer sentiment using Amazon Comprehend, the first step is to collect the customer text reviews (Option C) from their source, such as a database or Amazon S3. Next, you need to integrate the Amazon Comprehend API into your application or script (Option D) to programmatically interact with the service. Once integrated, you send the collected text reviews to the Amazon Comprehend API (Option A) for processing. Finally, you receive the sentiment analysis results (Option B), which typically categorize the text as Positive, Negative, Neutral, or Mixed.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  30,
  NULL,
  NULL,
  'm_62_7',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_78',
  'A company wants to transform and prepare data for analytics. Order the basic steps to use AWS Glue for an ETL (Extract, Transform, Load) job.',
  'ordering',
  '["Run the AWS Glue ETL job.","Define data sources and targets in the AWS Glue Data Catalog.","Create an AWS Glue ETL job script (e.g., Python or Scala).","Store the processed data in a target data store like Amazon S3 or Amazon Redshift."]'::json,
  '{1,2,0,3}',
  'To perform an ETL job with AWS Glue, you first define your data sources and targets in the AWS Glue Data Catalog (Option B), which acts as a central metadata repository. Next, you create an AWS Glue ETL job script (Option C), typically in Python or Scala, to specify the transformations needed for your data. Once the script is ready, you run the AWS Glue ETL job (Option A) to execute the transformations. Finally, the processed data is stored in a target data store (Option D), such as Amazon S3 for data lakes or Amazon Redshift for data warehousing.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  31,
  NULL,
  NULL,
  'm_62_7',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_79',
  'A developer wants to create a simple chatbot for a customer service application. Order the steps to build a basic chatbot using Amazon Lex.',
  'ordering',
  '["Define intents and sample utterances for the chatbot.","Test the chatbot''s responses and interactions.","Build and publish the Amazon Lex bot.","Integrate the Amazon Lex bot with a client application (e.g., a website or mobile app)."]'::json,
  '{0,2,1,3}',
  'To build a basic chatbot with Amazon Lex, the first step is to define the intents (what the user wants to do) and sample utterances (phrases users might say) for the chatbot (Option A). Once the intents are defined, you build and publish the Amazon Lex bot (Option C), which compiles the model. After building, you test the chatbot''s responses and interactions (Option B) within the Lex console to ensure it behaves as expected. Finally, you integrate the Amazon Lex bot with a client application (Option D), such as a website, mobile app, or messaging platform, to make it accessible to users.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  32,
  NULL,
  NULL,
  'm_62_7',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_80',
  'A data analyst needs to perform ad-hoc SQL queries on large datasets stored in Amazon S3. Order the following steps to use Amazon Athena for this task with minimal operational overhead.',
  'ordering',
  '["Define the schema for the S3 data using AWS Glue Data Catalog.","Store the datasets in an Amazon S3 bucket.","Execute SQL queries using Amazon Athena.","Analyze the query results."]'::json,
  '{1,0,2,3}',
  'To use Amazon Athena for ad-hoc SQL queries on S3 data, the first step is to store the datasets in an Amazon S3 bucket (Option B). Athena queries data directly from S3. Next, define the schema for this S3 data using AWS Glue Data Catalog (Option A), which allows Athena to understand the data structure. Then, execute SQL queries using Amazon Athena (Option C) against the defined tables. Finally, analyze the query results (Option D) to gain insights from the data.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  33,
  NULL,
  NULL,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_81',
  'A marketing team wants to analyze customer sentiment from social media posts using a pre-trained AI service. Order the following steps to achieve this using Amazon Comprehend.',
  'ordering',
  '["Receive the sentiment analysis results.","Collect social media posts containing customer feedback.","Send the text data to Amazon Comprehend for sentiment analysis.","Integrate Amazon Comprehend''s API into the application."]'::json,
  '{1,3,2,0}',
  'To analyze customer sentiment using Amazon Comprehend, the initial step is to collect the social media posts (Option B) that contain the customer feedback. Next, integrate Amazon Comprehend''s API into the application (Option D) that will send the data. Then, send the collected text data to Amazon Comprehend (Option C) via the API for sentiment analysis. Finally, receive the sentiment analysis results (Option A) from Comprehend''s response to understand customer sentiment.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  34,
  NULL,
  NULL,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_82',
  'A business intelligence team needs to create dashboards from various data sources, including data in Amazon S3. Order the following steps to prepare and visualize data using AWS Glue and Amazon QuickSight.',
  'ordering',
  '["Create a QuickSight analysis and dashboard.","Define and run an AWS Glue ETL job to transform and prepare the data.","Store raw data in Amazon S3.","Create an AWS Glue Data Catalog table for the raw data."]'::json,
  '{2,3,1,0}',
  'To prepare and visualize data using AWS Glue and Amazon QuickSight, the process begins by storing the raw data in Amazon S3 (Option C). Next, create an AWS Glue Data Catalog table (Option D) for the raw data in S3, which acts as a metadata repository. Then, define and run an AWS Glue ETL job (Option B) to transform and prepare this data, often writing the processed data back to S3. Finally, create a QuickSight analysis and dashboard (Option A), connecting to the processed data in S3 via the Glue Data Catalog, to visualize the insights.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  35,
  NULL,
  NULL,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_83',
  'A company wants to process large volumes of log data from various sources to identify patterns and anomalies. Order the following steps to set up a basic log analytics solution using Amazon Kinesis and Amazon Athena.',
  'ordering',
  '["Store processed logs in Amazon S3.","Ingest log data into an Amazon Kinesis Data Stream.","Use Amazon Athena to query and analyze the logs in S3.","Process and transform the streaming logs using Kinesis Data Firehose or AWS Lambda."]'::json,
  '{1,3,0,2}',
  'To set up a basic log analytics solution, the first step is to ingest log data into an Amazon Kinesis Data Stream (Option B) for real-time collection. Next, process and transform the streaming logs using Kinesis Data Firehose or AWS Lambda (Option D) to prepare them for storage and analysis. These processed logs are then stored in Amazon S3 (Option A), which serves as the data lake. Finally, use Amazon Athena (Option C) to query and analyze the logs directly in S3, leveraging its serverless SQL capabilities.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  36,
  NULL,
  NULL,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_84',
  'A company needs to process a large dataset stored in Amazon S3 using a managed Hadoop cluster. Order the following steps to set up and run a job on Amazon EMR.',
  'ordering',
  '["Launch an Amazon EMR cluster with the desired applications (e.g., Hadoop, Spark).","Store the large dataset in an Amazon S3 bucket.","Submit a job (e.g., Spark job, Hive query) to the EMR cluster.","Analyze the results and terminate the cluster when done."]'::json,
  '{1,0,2,3}',
  'To process a large dataset using Amazon EMR, the first step is to store the large dataset in an Amazon S3 bucket (Option B), as S3 is commonly used as the data lake for EMR. Next, launch an Amazon EMR cluster (Option A) with the desired applications like Hadoop or Spark. Then, submit a job (Option C) to the EMR cluster to process the data. Finally, analyze the results and terminate the cluster (Option D) when the job is complete to optimize costs.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  37,
  NULL,
  NULL,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_85',
  'Order the steps to perform an ad-hoc SQL query on data stored in Amazon S3 using Amazon Athena.',
  'ordering',
  '["Define the schema for the data in the AWS Glue Data Catalog","Write and execute the SQL query in the Amazon Athena console or via API","Store the data files (e.g., CSV, Parquet) in an Amazon S3 bucket","View the query results, which are also stored in S3"]'::json,
  '{2,0,1,3}',
  'To perform ad-hoc SQL queries on data in Amazon S3 using Amazon Athena, the data must first be available and structured. Option C (Store the data files in an Amazon S3 bucket) is the initial step, as Athena queries data directly from S3. Next, Option A (Define the schema for the data in the AWS Glue Data Catalog) provides Athena with the necessary metadata to understand the data structure. Once the schema is defined, Option B (Write and execute the SQL query in the Amazon Athena console) allows you to run your queries. Finally, Option D (View the query results) allows you to examine the output, which Athena stores in a separate S3 location. Storing data in S3 is a prerequisite for defining its schema.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  38,
  NULL,
  NULL,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_86',
  'A data analyst needs to query a large dataset stored in Amazon S3 without provisioning any servers. Order the typical steps for performing ad-hoc SQL queries using Amazon Athena.',
  'ordering',
  '["Store the dataset in Amazon S3.","Define the schema for the data in AWS Glue Data Catalog.","Run SQL queries against the data in Amazon S3.","Connect a business intelligence tool to Athena."]'::json,
  '{0,1,2,3}',
  'The correct sequence for using Amazon Athena begins with data availability. Option A (Store the dataset in Amazon S3) is the prerequisite, as Athena queries data directly from S3. Next, Option B (Define the schema for the data in AWS Glue Data Catalog) is necessary so Athena understands the data structure. After the schema is defined, Option C (Run SQL queries against the data in Amazon S3) can be performed using Athena. Finally, Option D (Connect a business intelligence tool to Athena) is an optional but common step to visualize query results.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  39,
  NULL,
  NULL,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_87',
  'A company wants to process real-time streaming data from IoT devices, store it, and then analyze it. Order the AWS services in a typical data flow for this scenario.',
  'ordering',
  '["Store processed data in Amazon S3 for long-term storage.","Ingest real-time data streams using Amazon Kinesis.","Analyze stored data using Amazon Athena or Amazon QuickSight.","Process and transform data using AWS Lambda or Amazon Kinesis Data Analytics."]'::json,
  '{1,3,0,2}',
  'The correct order for a real-time streaming data flow starts with ingestion. Option B (Ingest real-time data streams using Amazon Kinesis) is used to collect the data. Next, Option D (Process and transform data using AWS Lambda or Amazon Kinesis Data Analytics) handles the real-time processing of the ingested data. After processing, Option A (Store processed data in Amazon S3 for long-term storage) is a common destination for persistent storage. Finally, Option C (Analyze stored data using Amazon Athena or Amazon QuickSight) is used to gain insights from the stored data.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  40,
  NULL,
  NULL,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_88',
  'A company collects large volumes of operational logs in Amazon S3 and wants to perform serverless ad-hoc SQL queries and visualize the results for business intelligence. Order the steps to achieve this using AWS analytics services.',
  'ordering',
  '["Store raw log files in Amazon S3.","Create an AWS Glue Data Catalog table for the S3 data.","Run SQL queries against the data using Amazon Athena.","Build interactive dashboards with Amazon QuickSight."]'::json,
  '{0,1,2,3}',
  'The process begins by storing the raw log files in Amazon S3 (Option A), which provides scalable and durable object storage. Next, AWS Glue (Option B) is used to crawl the S3 data and create a Data Catalog table, defining the schema of the log files. Amazon Athena (Option C) can then leverage this catalog to run serverless SQL queries directly on the data stored in S3 without provisioning any infrastructure. Finally, Amazon QuickSight (Option D) can connect to Athena or S3 to build interactive dashboards and reports for data visualization and business intelligence.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  41,
  NULL,
  NULL,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_3
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_70',
  'A company needs to host a web application that experiences variable traffic and wants to ensure high availability and automatic scaling. Order the components of a typical Auto Scaling setup.',
  'ordering',
  '["Define a launch template or launch configuration for EC2 instances.","Create an Auto Scaling group.","Configure scaling policies (e.g., target tracking, step scaling).","Attach the Auto Scaling group to an Elastic Load Balancer (ELB)."]'::json,
  '{0,1,3,2}',
  'To set up Auto Scaling, you first need to define a launch template or launch configuration (Option A), which specifies the Amazon Machine Image (AMI), instance type, and other details for the EC2 instances that Auto Scaling will launch. Next, you create an Auto Scaling group (Option B), which uses the launch template to manage a collection of EC2 instances. For high availability and traffic distribution, you then attach the Auto Scaling group to an Elastic Load Balancer (ELB) (Option D). Finally, you configure scaling policies (Option C), such as target tracking or step scaling, to tell the Auto Scaling group when to add or remove instances based on demand.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  42,
  NULL,
  NULL,
  'm_62_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_71',
  'A developer wants to quickly launch a simple web application with a virtual private server experience. Order the steps to deploy an application using Amazon Lightsail.',
  'ordering',
  '["Choose an instance image (e.g., WordPress, LAMP stack, OS only).","Select an instance plan (size and cost).","Launch the Lightsail instance.","Connect to the instance and configure the application."]'::json,
  '{0,1,2,3}',
  'To deploy an application using Amazon Lightsail, the first step is to choose an instance image (Option A), which can be an application blueprint like WordPress or a base operating system. Next, you select an instance plan (Option B), which determines the CPU, RAM, storage, and monthly cost. After selecting the plan, you launch the Lightsail instance (Option C). Finally, you can connect to the instance (e.g., via SSH) and configure your application as needed (Option D).',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  43,
  NULL,
  NULL,
  'm_62_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_72',
  'A developer wants to deploy a serverless function that processes image uploads to Amazon S3. Order the following steps to create and configure an AWS Lambda function for this purpose.',
  'ordering',
  '["Configure an S3 bucket event trigger for the Lambda function.","Write and package the Lambda function code.","Create an AWS Lambda function.","Test the Lambda function by uploading an image to S3."]'::json,
  '{1,2,0,3}',
  'To create and configure an AWS Lambda function, the first step is to write and package the Lambda function code (Option B) that will process the image uploads. Next, create an AWS Lambda function (Option C) in the console or via CLI/SDK, providing the packaged code. Then, configure an S3 bucket event trigger (Option A) so that the Lambda function is invoked automatically when new images are uploaded to the specified S3 bucket. Finally, test the Lambda function (Option D) by uploading an image to the S3 bucket to ensure it works as expected.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  44,
  NULL,
  NULL,
  'm_62_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_73',
  'A team is deploying a containerized application and wants to minimize server management. Order the following steps to deploy the application using AWS Fargate.',
  'ordering',
  '["Define the application''s container image and push it to Amazon ECR.","Create an Amazon ECS cluster.","Define an Amazon ECS task definition specifying the container image and resources.","Run the task on AWS Fargate within the ECS cluster."]'::json,
  '{0,1,2,3}',
  'To deploy a containerized application using AWS Fargate, the first step is to define the application''s container image and push it to Amazon ECR (Option A), making it accessible to AWS. Next, create an Amazon ECS cluster (Option B), which provides the logical grouping for your Fargate tasks. Then, define an Amazon ECS task definition (Option C), specifying details like the container image, CPU, and memory requirements. Finally, run the task on AWS Fargate (Option D) within the ECS cluster, and Fargate will provision the necessary compute capacity.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  45,
  NULL,
  NULL,
  'm_62_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_74',
  'An application is experiencing fluctuating traffic throughout the day. Order the following events as they would typically occur when an Auto Scaling Group responds to increased load.',
  'ordering',
  '["New EC2 instances are launched and registered with the load balancer.","The application''s CPU utilization exceeds a defined threshold.","The Auto Scaling Group receives a scale-out alarm.","The Elastic Load Balancer (ELB) distributes traffic to all healthy instances."]'::json,
  '{1,2,0,3}',
  'When an Auto Scaling Group responds to increased load, the first event is typically the application''s CPU utilization exceeding a defined threshold (Option B), indicating higher demand. This triggers a CloudWatch alarm, causing the Auto Scaling Group to receive a scale-out alarm (Option C). In response, new EC2 instances are launched and registered with the load balancer (Option A). Finally, the Elastic Load Balancer (ELB) then distributes traffic to all healthy instances (Option D), including the newly launched ones, to handle the increased load.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  46,
  NULL,
  NULL,
  'm_62_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_75',
  'A company needs to provision compute resources for a batch processing workload that can tolerate interruptions and has flexible start and end times. Order the following EC2 pricing models from MOST suitable to LEAST suitable for this specific workload, considering cost-effectiveness.',
  'ordering',
  '["On-Demand Instances","Spot Instances","Reserved Instances","Savings Plans"]'::json,
  '{1,3,2,0}',
  'For a batch processing workload that can tolerate interruptions and has flexible start/end times, Spot Instances (Option B) are the MOST suitable as they offer the deepest discounts (up to 90%) in exchange for potential interruptions. Savings Plans (Option D) offer significant discounts for a commitment to compute usage, which can be cost-effective if the workload runs consistently for a long period, but less flexible than Spot. Reserved Instances (Option C) provide discounts for committing to specific instance types, making them less flexible for varying batch needs. On-Demand Instances (Option A) are the LEAST suitable for this type of workload due to their higher cost and lack of optimization for interruptible tasks.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  47,
  NULL,
  NULL,
  'm_62_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_76',
  'Order the steps to configure an Amazon EC2 Auto Scaling group to automatically adjust capacity.',
  'ordering',
  '["Define a launch template or launch configuration for the EC2 instances","Create an Auto Scaling group, specifying desired capacity and VPC subnets","Configure scaling policies (e.g., target tracking, simple scaling) to define when to scale","Attach the Auto Scaling group to an Elastic Load Balancer (optional, but common)"]'::json,
  '{0,1,2,3}',
  'Configuring an Amazon EC2 Auto Scaling group begins by specifying how the instances launched by the group should be configured. Option A (Define a launch template or launch configuration) is the first step, providing the blueprint for EC2 instances. Next, Option B (Create an Auto Scaling group) establishes the group itself, linking it to the launch template. After the group is created, Option C (Configure scaling policies) defines the conditions under which the group should scale in or out. Finally, Option D (Attach the Auto Scaling group to an Elastic Load Balancer) is a common practice to distribute traffic across the instances managed by the group, ensuring high availability and performance. Defining the launch template is a prerequisite for creating the Auto Scaling group.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  48,
  NULL,
  NULL,
  'm_62_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_77',
  'Arrange the sequence of events when a client request reaches an application behind an Elastic Load Balancing (ELB) load balancer.',
  'ordering',
  '["The ELB forwards the request to a healthy target (e.g., EC2 instance, container)","The client sends an HTTP/HTTPS request to the ELB''s DNS name","The target processes the request and sends a response back to the ELB","The ELB receives the response from the target and sends it back to the client"]'::json,
  '{1,0,2,3}',
  'When a client interacts with an application behind an Elastic Load Balancer, the request first goes to the load balancer. Option B (The client sends an HTTP/HTTPS request to the ELB''s DNS name) is the initial action. The ELB then takes responsibility for routing. Option A (The ELB forwards the request to a healthy target) ensures the request reaches an available backend resource. After processing, Option C (The target processes the request and sends a response back to the ELB) returns the result to the load balancer. Finally, Option D (The ELB receives the response from the target and sends it back to the client) completes the communication loop. The client must send the request before the ELB can forward it.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  49,
  NULL,
  NULL,
  'm_62_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_78',
  'Assuming the function code is already written, order the steps to deploy and invoke an AWS Lambda function.',
  'ordering',
  '["Configure an event trigger for the Lambda function (e.g., API Gateway, S3 event)","Create the Lambda function resource in AWS, specifying the code and runtime","Invoke the Lambda function manually or via its configured trigger","Define the function''s execution role with necessary permissions"]'::json,
  '{3,1,0,2}',
  'To deploy and invoke an AWS Lambda function, the function needs appropriate permissions and to be defined as a resource. Option D (Define the function''s execution role with necessary permissions) is the crucial first step to grant the Lambda function access to other AWS services. Next, Option B (Create the Lambda function resource in AWS) registers your code and runtime with Lambda. After creation, Option A (Configure an event trigger for the Lambda function) sets up how the function will be invoked automatically. Finally, Option C (Invoke the Lambda function) executes the function, either through a configured trigger or manually. Defining the execution role is a prerequisite for creating the Lambda function.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  50,
  NULL,
  NULL,
  'm_62_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_4
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_65',
  'A company needs a managed relational database for its new application. Order the steps to launch an Amazon RDS database instance.',
  'ordering',
  '["Configure database settings like instance class, storage, and credentials.","Select the database engine (e.g., MySQL, PostgreSQL).","Launch the RDS database instance.","Connect the application to the RDS endpoint."]'::json,
  '{1,0,2,3}',
  'To launch an Amazon RDS database instance, you first select the desired database engine (Option B), such as MySQL or PostgreSQL. Next, you configure various database settings (Option A), including the instance class, storage allocation, and master user credentials. After these configurations are set, you launch the RDS database instance (Option C). Finally, once the instance is available, you connect your application to the RDS endpoint (Option D) to interact with the database.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  51,
  NULL,
  NULL,
  'm_62_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_66',
  'An application is experiencing slow read performance from its primary database. Order the steps to implement Amazon ElastiCache for in-memory caching.',
  'ordering',
  '["Modify the application code to read from ElastiCache first.","Launch an Amazon ElastiCache cluster (Redis or Memcached).","Populate the cache with frequently accessed data.","Monitor cache hit ratio and performance."]'::json,
  '{1,2,0,3}',
  'To implement Amazon ElastiCache for improved read performance, the first step is to launch an Amazon ElastiCache cluster (Option B), choosing either Redis or Memcached based on your needs. Next, you populate the cache with frequently accessed data (Option C) from your primary database. After the cache is populated, you modify your application code (Option A) to first attempt to read data from ElastiCache; if the data is not found (cache miss), the application should then query the primary database and populate the cache. Finally, you monitor the cache hit ratio and overall performance (Option D) to ensure the caching strategy is effective.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  52,
  NULL,
  NULL,
  'm_62_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_67',
  'A data analytics team wants to set up a data warehouse for large-scale analytical queries. Order the steps to provision an Amazon Redshift cluster.',
  'ordering',
  '["Configure cluster details like node type, number of nodes, and master user credentials.","Launch the Amazon Redshift cluster.","Load data into the Redshift cluster from sources like S3 or DynamoDB.","Connect BI tools or SQL clients to the Redshift cluster endpoint."]'::json,
  '{0,1,2,3}',
  'To provision an Amazon Redshift cluster, you first configure cluster details (Option A), including the node type, number of nodes, and master user credentials. Next, you launch the Amazon Redshift cluster (Option B) with these specified configurations. Once the cluster is available, you load data into the Redshift cluster (Option C) from your data sources, such as Amazon S3 or Amazon DynamoDB. Finally, you connect Business Intelligence (BI) tools or SQL clients to the Redshift cluster endpoint (Option D) to perform analytical queries.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  53,
  NULL,
  NULL,
  'm_62_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_68',
  'A developer is choosing a database service for a new application. Order the general considerations when selecting an AWS database service.',
  'ordering',
  '["Evaluate the required data consistency model (e.g., ACID vs. eventual).","Determine the data model (relational, key-value, document, graph).","Consider performance requirements (latency, throughput).","Assess scalability needs (vertical, horizontal)."]'::json,
  '{1,0,2,3}',
  'When selecting an AWS database service, the first step is to determine the data model (Option B) that best fits your application''s data (e.g., relational for structured data, key-value for simple access). Next, you evaluate the required data consistency model (Option A), considering whether you need strong ACID compliance or if eventual consistency is acceptable. After that, you consider the performance requirements (Option C), such as desired latency and throughput for your queries. Finally, you assess the scalability needs (Option D) to ensure the database can grow with your application''s demands, whether through vertical or horizontal scaling.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  54,
  NULL,
  NULL,
  'm_62_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_69',
  'A developer wants to set up a managed relational database for a new application. Order the following steps to provision an Amazon RDS database instance.',
  'ordering',
  '["Configure database parameters and create the database.","Select the database engine (e.g., MySQL, PostgreSQL).","Specify instance class, storage, and Multi-AZ deployment options.","Define network and security settings (VPC, security groups)."]'::json,
  '{1,2,3,0}',
  'To provision an Amazon RDS database instance, the first step is to select the desired database engine (Option B), such as MySQL or PostgreSQL. Next, specify the instance class, storage capacity, and Multi-AZ deployment options (Option C) based on performance and availability requirements. Then, define the network and security settings (Option D), including the VPC and security groups to control access. Finally, configure specific database parameters (Option A) like the master username and password, and then create the database instance.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  55,
  NULL,
  NULL,
  'm_62_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_70',
  'A company is experiencing slow read performance on its Amazon RDS database due to a high volume of read requests. Order the following solutions from MOST impactful to LEAST impactful for improving read performance.',
  'ordering',
  '["Implement an Amazon ElastiCache cluster (Redis/Memcached) for frequently accessed data.","Add read replicas to offload read traffic from the primary database.","Optimize database queries and indexing.","Scale up the primary RDS instance to a larger instance type."]'::json,
  '{2,1,0,3}',
  'To improve read performance, the most impactful initial step is often to optimize database queries and indexing (Option C), as inefficient queries can be a major bottleneck. Next, adding read replicas (Option B) is highly impactful as it offloads read traffic from the primary instance, distributing the load. Implementing an Amazon ElastiCache cluster (Option A) provides microsecond-latency caching for frequently accessed data, significantly reducing database hits. Scaling up the primary RDS instance (Option D) can provide more resources but is often a more expensive and less efficient solution than optimizing queries or offloading reads, and may not address the root cause of read bottlenecks.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  56,
  NULL,
  NULL,
  'm_62_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_71',
  'A company is deciding on a database solution for a new application. Order the following considerations from most fundamental to most specific when choosing an AWS database service.',
  'ordering',
  '["Evaluate the required read/write throughput and latency.","Determine if the data model is relational or non-relational.","Assess the need for managed services versus self-managed databases.","Consider specific database engine features (e.g., spatial data, graph queries)."]'::json,
  '{1,2,0,3}',
  'When choosing an AWS database service, the most fundamental consideration is to determine if the data model is relational or non-relational (Option B), as this dictates the broad category of database services. Next, assess the need for managed services versus self-managed databases (Option C) to decide on the operational overhead. Then, evaluate the required read/write throughput and latency (Option A) to select a service that meets performance demands. Finally, consider specific database engine features (Option D) for specialized use cases, which refines the choice within a category.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  57,
  NULL,
  NULL,
  'm_62_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_72',
  'A data analytics team needs to store and analyze petabytes of structured data for business intelligence. Order the following steps to set up a data warehousing solution using Amazon Redshift.',
  'ordering',
  '["Load data into the Redshift cluster.","Provision an Amazon Redshift cluster.","Define schema and tables in Redshift.","Run analytical queries and generate reports."]'::json,
  '{1,2,0,3}',
  'To set up a data warehousing solution with Amazon Redshift, the first step is to provision an Amazon Redshift cluster (Option B), which provides the compute and storage resources. Next, define the schema and tables (Option C) within the Redshift cluster to structure the incoming data. Then, load the data into the Redshift cluster (Option A) from sources like Amazon S3. Finally, run analytical queries and generate reports (Option D) to extract insights from the data.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  58,
  NULL,
  NULL,
  'm_62_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_73',
  'Order the steps to provision a new Amazon RDS database instance.',
  'ordering',
  '["Choose the database engine (e.g., MySQL, PostgreSQL) and instance class","Create the database instance, which provisions the underlying infrastructure","Configure network and security settings (e.g., VPC, security groups)","Set the master username and password for database administration"]'::json,
  '{0,3,2,1}',
  'When provisioning a new Amazon RDS database instance, the initial decision is about the core database characteristics. Option A (Choose the database engine and instance class) determines the type and size of your database. Next, Option D (Set the master username and password) establishes the administrative credentials. Following this, Option C (Configure network and security settings) ensures the database is placed in the correct VPC and protected by security groups. Finally, Option B (Create the database instance) initiates the actual provisioning of the database. Choosing the engine and instance class is a fundamental first step.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  59,
  NULL,
  NULL,
  'm_62_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_74',
  'A database administrator needs to set up a new Amazon RDS for MySQL instance for a production application. Order the essential steps to provision and secure this database.',
  'ordering',
  '["Configure database parameters and backup retention.","Create a new Amazon RDS for MySQL instance.","Define a security group to control network access.","Place the RDS instance in private subnets within a VPC."]'::json,
  '{1,3,2,0}',
  'The first step is to create a new Amazon RDS for MySQL instance (Option B), specifying the engine, version, and instance class. During or immediately after creation, it is crucial to place the RDS instance in private subnets within a VPC (Option D) to ensure it is not directly accessible from the internet. Next, a security group (Option C) must be defined and associated with the RDS instance to control inbound and outbound network traffic, allowing only authorized application servers to connect. Finally, database-specific parameters and backup retention policies (Option A) are configured to optimize performance and ensure data recoverability.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  60,
  NULL,
  NULL,
  'm_62_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_5
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_67',
  'A solutions architect needs to create a new isolated network environment in AWS. Order the fundamental steps to set up an Amazon Virtual Private Cloud (VPC).',
  'ordering',
  '["Create public and private subnets within the VPC.","Create an Internet Gateway and attach it to the VPC.","Create the VPC with a specified CIDR block.","Configure route tables for subnets to direct traffic."]'::json,
  '{2,0,1,3}',
  'To set up an Amazon Virtual Private Cloud (VPC), the foundational step is to create the VPC itself with a specified CIDR block (Option C), defining its IP address range. Next, you create public and private subnets (Option A) within this VPC to segment your network. To enable internet access for public subnets, you create an Internet Gateway and attach it to the VPC (Option B). Finally, you configure route tables (Option D) for your subnets to direct traffic, including routing public subnet traffic to the Internet Gateway.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  61,
  NULL,
  NULL,
  'm_62_5',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_68',
  'A company wants to host its domain name system (DNS) records on AWS. Order the steps to configure Amazon Route 53 for a new domain.',
  'ordering',
  '["Create a hosted zone for the domain.","Update the domain''s name servers with your domain registrar.","Create resource record sets (e.g., A records, CNAMEs) within the hosted zone.","Verify DNS propagation."]'::json,
  '{0,2,1,3}',
  'To configure Amazon Route 53 for a new domain, the first step is to create a hosted zone for that domain (Option A) within Route 53. Next, you create resource record sets (Option C), such as A records for IP addresses or CNAMEs for aliases, within this hosted zone to define how traffic is routed. After configuring the records, you update the domain''s name servers (Option B) with your domain registrar to point to the Route 53 name servers. Finally, you verify DNS propagation (Option D) to ensure the changes have taken effect across the internet.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  62,
  NULL,
  NULL,
  'm_62_5',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_69',
  'A network administrator is reviewing network access controls in a VPC. Order the layers of network security from broadest to most granular.',
  'ordering',
  '["Network Access Control List (NACL)","Security Group","VPC (Virtual Private Cloud)","Subnet"]'::json,
  '{2,3,0,1}',
  'The layers of network security in AWS, from broadest to most granular, are: VPC (Option C), which is your isolated network in the cloud. Within the VPC, you define subnets (Option D), which are ranges of IP addresses. Network Access Control Lists (NACLs) (Option A) operate at the subnet level, providing stateless filtering for all traffic entering or leaving the subnet. Security Groups (Option B) operate at the instance level, providing stateful filtering for traffic to and from individual EC2 instances.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  63,
  NULL,
  NULL,
  'm_62_5',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_70',
  'A security engineer needs to configure network access for an EC2 instance running a web server. Order the following steps to apply security best practices for inbound traffic.',
  'ordering',
  '["Create a Security Group allowing inbound HTTP/HTTPS traffic from specific IP ranges.","Launch the EC2 instance in a private subnet.","Associate the Security Group with the EC2 instance.","Ensure the Network ACL for the subnet allows necessary inbound and outbound traffic."]'::json,
  '{1,3,0,2}',
  'To configure network access for an EC2 instance securely, the first step is to launch the EC2 instance in a private subnet (Option B) to prevent direct internet exposure. Next, ensure the Network ACL (NACL) for the subnet allows necessary inbound and outbound traffic (Option D), as NACLs operate at the subnet level. Then, create a Security Group (Option A) specifically allowing inbound HTTP/HTTPS traffic from specific, trusted IP ranges to the instance. Finally, associate this Security Group with the EC2 instance (Option C) to apply the rules.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  64,
  NULL,
  NULL,
  'm_62_5',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_71',
  'A media company wants to improve the performance and reduce the load on its origin servers by caching content closer to its global users. Order the following steps to implement Amazon CloudFront.',
  'ordering',
  '["Configure the CloudFront distribution with the S3 bucket as an origin.","Upload static and dynamic content to an Amazon S3 bucket.","Update DNS records to point to the CloudFront distribution''s domain name.","Test content delivery from various geographic locations."]'::json,
  '{1,0,2,3}',
  'To implement Amazon CloudFront for content delivery, the first step is to upload static and dynamic content to an Amazon S3 bucket (Option B), which will serve as the origin. Next, configure the CloudFront distribution (Option A), specifying the S3 bucket as the origin. Then, update DNS records (Option C) for the application''s domain to point to the CloudFront distribution''s domain name. Finally, test content delivery (Option D) from various geographic locations to verify the caching and performance improvements.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  65,
  NULL,
  NULL,
  'm_62_5',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_72',
  'A large enterprise needs a dedicated, high-bandwidth, and low-latency network connection between its on-premises data center and AWS. Order the following steps to establish an AWS Direct Connect connection.',
  'ordering',
  '["Configure routing on the customer''s router to use the Direct Connect connection.","Create a Direct Connect connection in the AWS Management Console.","Establish a cross-connect at an AWS Direct Connect location.","Create a Virtual Interface (VIF) for the Direct Connect connection."]'::json,
  '{1,2,3,0}',
  'To establish an AWS Direct Connect connection, the initial step is to create a Direct Connect connection (Option B) in the AWS Management Console, specifying details like location and speed. Next, establish a cross-connect (Option C) at an AWS Direct Connect location, physically connecting the customer''s network to the AWS network. Then, create a Virtual Interface (VIF) (Option D) for the Direct Connect connection, which allows access to AWS services (public VIF) or a VPC (private VIF). Finally, configure routing on the customer''s router (Option A) to direct traffic over the Direct Connect connection.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  66,
  NULL,
  NULL,
  'm_62_5',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_73',
  'A company needs to establish a secure and encrypted connection over the public internet to its AWS VPC from its on-premises network. Order the following steps to set up an AWS Site-to-Site VPN connection.',
  'ordering',
  '["Configure the customer gateway device on-premises.","Create a Virtual Private Gateway (VGW) and attach it to the VPC.","Create a Customer Gateway resource in AWS.","Create a Site-to-Site VPN connection between the VGW and Customer Gateway."]'::json,
  '{1,2,3,0}',
  'To set up an AWS Site-to-Site VPN connection, the first step is to create a Virtual Private Gateway (VGW) and attach it to the VPC (Option B), which serves as the AWS endpoint for the VPN. Next, create a Customer Gateway resource in AWS (Option C), providing details about the on-premises VPN device. Then, create a Site-to-Site VPN connection (Option D) that links the VGW to the Customer Gateway. Finally, configure the customer gateway device on-premises (Option A) using the configuration details provided by AWS to establish the tunnel.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  67,
  NULL,
  NULL,
  'm_62_5',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_6
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_60',
  'A company needs to store large amounts of unstructured data for a new application. Order the steps to create an Amazon S3 bucket and upload an object.',
  'ordering',
  '["Upload an object to the S3 bucket.","Create an Amazon S3 bucket.","Configure bucket properties (e.g., versioning, encryption, public access settings).","Set object-level permissions if needed."]'::json,
  '{1,2,0,3}',
  'To store data in Amazon S3, the first step is to create an Amazon S3 bucket (Option B), which is a container for your objects. Next, you configure bucket properties (Option C), such as enabling versioning for data protection, setting default encryption, or managing public access settings. After the bucket is configured, you upload an object to the S3 bucket (Option A). Finally, if specific access control is needed for individual objects, you set object-level permissions (Option D) using S3 ACLs or bucket policies.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  68,
  NULL,
  NULL,
  'm_62_6',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_61',
  'A user needs persistent block storage for an Amazon EC2 instance. Order the steps to create and attach an Amazon EBS volume.',
  'ordering',
  '["Attach the EBS volume to an EC2 instance.","Create an Amazon EBS volume in the same Availability Zone as the EC2 instance.","Format and mount the EBS volume on the EC2 instance''s operating system.","Ensure the EC2 instance is running."]'::json,
  '{1,3,0,2}',
  'To create and attach an Amazon EBS volume, you first create the EBS volume (Option B) in the same Availability Zone as your target EC2 instance. Before attaching, ensure the EC2 instance is running (Option D). Next, you attach the EBS volume to the running EC2 instance (Option A). Finally, after attachment, you must format and mount the EBS volume on the EC2 instance''s operating system (Option C) to make it usable.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  69,
  NULL,
  NULL,
  'm_62_6',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_62',
  'Multiple Amazon EC2 instances need shared file storage. Order the steps to set up Amazon EFS (Elastic File System).',
  'ordering',
  '["Mount the EFS file system on multiple EC2 instances.","Create an Amazon EFS file system.","Configure mount targets for the EFS file system in desired subnets.","Ensure security groups allow NFS traffic to the mount targets."]'::json,
  '{1,2,3,0}',
  'To set up Amazon EFS for shared file storage, the first step is to create an Amazon EFS file system (Option B). Next, you configure mount targets for the EFS file system (Option C) in the subnets where your EC2 instances reside. Before mounting, ensure that the security groups associated with your EC2 instances and EFS mount targets allow NFS (Network File System) traffic (Option D) (port 2049). Finally, you mount the EFS file system on your multiple EC2 instances (Option A) to enable shared access.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  70,
  NULL,
  NULL,
  'm_62_6',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_63',
  'A company needs to transfer petabytes of data from an on-premises data center to AWS. Order the steps to use the AWS Snowball service for offline data migration.',
  'ordering',
  '["Ship the Snowball device back to AWS.","Create a job in the AWS Snow Family Management Console.","Connect the Snowball device to your on-premises network and transfer data.","AWS imports the data into your specified S3 bucket."]'::json,
  '{1,2,0,3}',
  'To use AWS Snowball for offline data migration, you first create a job in the AWS Snow Family Management Console (Option B), specifying details like the data source and target Amazon S3 bucket. AWS then prepares and ships a Snowball device to your location. Upon receiving it, you connect the Snowball device to your on-premises network and transfer your data to it (Option C). Once the data transfer is complete, you ship the Snowball device back to AWS (Option A). Finally, AWS imports the data from the Snowball device into your specified S3 bucket (Option D).',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  71,
  NULL,
  NULL,
  'm_62_6',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_64',
  'A company wants to host a static website on AWS with high availability and low cost. Order the following steps to configure an Amazon S3 bucket for static website hosting.',
  'ordering',
  '["Upload the website files (HTML, CSS, JS) to the S3 bucket.","Configure the S3 bucket for static website hosting.","Set bucket policy to allow public read access to the website objects.","Test the website by accessing the S3 website endpoint."]'::json,
  '{1,2,0,3}',
  'To configure an Amazon S3 bucket for static website hosting, the first step is to configure the S3 bucket for static website hosting (Option B) in its properties, specifying an index document and optionally an error document. Next, set the bucket policy (Option C) to allow public read access to the website objects, as they need to be accessible from the internet. Then, upload the website files (Option A) to the S3 bucket. Finally, test the website (Option D) by accessing the S3 website endpoint provided by AWS.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  72,
  NULL,
  NULL,
  'm_62_6',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_65',
  'A system administrator needs to provide persistent block storage for an Amazon EC2 instance. Order the following steps to create and attach an Amazon EBS volume to an EC2 instance.',
  'ordering',
  '["Create an Amazon EBS volume in the same Availability Zone as the EC2 instance.","Attach the EBS volume to the EC2 instance.","Launch an Amazon EC2 instance.","Format and mount the EBS volume on the EC2 instance''s operating system."]'::json,
  '{2,0,1,3}',
  'To create and attach an Amazon EBS volume, first, launch an Amazon EC2 instance (Option C) that requires the storage. Next, create an Amazon EBS volume (Option A) ensuring it is in the same Availability Zone as the EC2 instance, as EBS volumes are AZ-specific. Then, attach the EBS volume to the EC2 instance (Option B) via the console or CLI. Finally, format and mount the EBS volume (Option D) on the EC2 instance''s operating system to make it available for use.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  73,
  NULL,
  NULL,
  'm_62_6',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_66',
  'A development team requires a shared file system that can be accessed concurrently by multiple Amazon EC2 instances. Order the following steps to set up Amazon EFS for this purpose.',
  'ordering',
  '["Mount the EFS file system on the EC2 instances.","Create an Amazon EFS file system.","Configure EFS mount targets in the appropriate subnets.","Launch multiple Amazon EC2 instances."]'::json,
  '{1,2,3,0}',
  'To set up Amazon EFS for shared file access, the first step is to create an Amazon EFS file system (Option B). Next, configure EFS mount targets (Option C) in the appropriate subnets within the VPC, allowing EC2 instances to connect. Then, launch multiple Amazon EC2 instances (Option D) that will need to access the shared storage. Finally, mount the EFS file system (Option A) on each of these EC2 instances using the NFS protocol.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  74,
  NULL,
  NULL,
  'm_62_6',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_67',
  'A large organization needs to migrate petabytes of on-premises data to AWS, but transferring over the internet is not feasible due to bandwidth and time constraints. Order the following steps to use AWS Snowball for offline data migration.',
  'ordering',
  '["Ship the Snowball device back to AWS.","Create a Snowball job in the AWS Management Console.","Connect the Snowball device to the on-premises network and transfer data.","AWS loads the data into the specified S3 bucket."]'::json,
  '{1,2,0,3}',
  'To use AWS Snowball for offline data migration, the first step is to create a Snowball job (Option B) in the AWS Management Console, specifying the data to be transferred and the target S3 bucket. AWS then ships a Snowball device. Once received, connect the Snowball device to the on-premises network and transfer data (Option C) from local storage to the device. After data transfer is complete, ship the Snowball device back to AWS (Option A). Finally, AWS loads the data (Option D) from the Snowball device into the specified S3 bucket.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  75,
  NULL,
  NULL,
  'm_62_6',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_8
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_49',
  'A company wants to automate sending notifications for critical system events. Order the steps to set up Amazon SNS (Simple Notification Service) for email notifications.',
  'ordering',
  '["Publish a message to the SNS topic.","Create an Amazon SNS topic.","Subscribe email addresses to the SNS topic.","Confirm the subscription via the email link."]'::json,
  '{1,2,3,0}',
  'To set up Amazon SNS for email notifications, the first step is to create an Amazon SNS topic (Option B), which acts as a communication channel. Next, you subscribe email addresses to this SNS topic (Option C). Each subscriber will receive a confirmation email. It''s crucial for each subscriber to confirm their subscription via the link in the email (Option D) to start receiving notifications. Finally, you publish a message to the SNS topic (Option A), and all confirmed subscribers will receive the email notification.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  76,
  NULL,
  NULL,
  'm_62_8',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_50',
  'A microservices application needs to decouple components using message queues. Order the steps to implement Amazon SQS (Simple Queue Service) for asynchronous communication.',
  'ordering',
  '["A consumer application polls the SQS queue for messages.","Create an Amazon SQS queue.","A producer application sends messages to the SQS queue.","The consumer application processes the message and deletes it from the queue."]'::json,
  '{1,2,0,3}',
  'To implement Amazon SQS for asynchronous communication, the initial step is to create an Amazon SQS queue (Option B), which will store messages. Next, a producer application sends messages to this SQS queue (Option C), placing them in the queue for later processing. A separate consumer application then polls the SQS queue for messages (Option A), retrieving them when available. Finally, after successfully processing a message, the consumer application deletes it from the queue (Option D) to prevent reprocessing.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  77,
  NULL,
  NULL,
  'm_62_8',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_51',
  'A microservices application needs to decouple its components using asynchronous messaging. Order the following steps to implement a message queue using Amazon SQS.',
  'ordering',
  '["Configure producer service to send messages to the SQS queue.","Create an Amazon SQS queue.","Configure consumer service to poll and process messages from the SQS queue.","Monitor the queue for message backlog and processing errors."]'::json,
  '{1,0,2,3}',
  'To implement a message queue using Amazon SQS, the first step is to create an Amazon SQS queue (Option B), which will store messages. Next, configure the producer service (Option A) to send messages to this SQS queue. Then, configure the consumer service (Option C) to poll and process messages from the SQS queue. Finally, monitor the queue (Option D) for message backlog, processing errors, and overall performance to ensure smooth operation.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  78,
  NULL,
  NULL,
  'm_62_8',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_52',
  'A company wants to build an event-driven architecture where various AWS services and custom applications react to specific events. Order the following steps to implement event routing using Amazon EventBridge.',
  'ordering',
  '["Define rules in EventBridge to match specific event patterns.","Configure event sources (e.g., AWS services, custom applications) to send events to EventBridge.","Configure targets for the rules (e.g., AWS Lambda, SQS, SNS).","Test the event flow by generating a matching event."]'::json,
  '{1,0,2,3}',
  'To implement event routing using Amazon EventBridge, the first step is to configure event sources (Option B) to send their events to EventBridge. Next, define rules in EventBridge (Option A) that specify event patterns to match incoming events. Then, configure targets (Option C) for these rules, which are the AWS services or applications that will be invoked when a rule''s pattern is matched. Finally, test the event flow (Option D) by generating a matching event to ensure the rules and targets function as expected.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  79,
  NULL,
  NULL,
  'm_62_8',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_53',
  'A business process involves multiple sequential and parallel steps, including human approvals and automated tasks. Order the following steps to model and execute this workflow using AWS Step Functions.',
  'ordering',
  '["Define the state machine using Amazon States Language (JSON).","Execute an instance of the state machine.","Integrate the state machine with AWS Lambda functions or other AWS services.","Monitor the execution flow and status in the Step Functions console."]'::json,
  '{0,2,1,3}',
  'To model and execute a workflow using AWS Step Functions, the first step is to define the state machine (Option A) using Amazon States Language (JSON), outlining the sequence and logic of the steps. Next, integrate the state machine (Option C) with AWS Lambda functions or other AWS services that perform the actual work for each step. Then, execute an instance of the state machine (Option B) to start the workflow. Finally, monitor the execution flow and status (Option D) in the Step Functions console to track progress and troubleshoot issues.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  80,
  NULL,
  NULL,
  'm_62_8',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_54',
  'A development team wants to send notifications to users and other services about important application events. Order the following steps to set up a notification system using Amazon SNS.',
  'ordering',
  '["Publish messages to the SNS topic from the application.","Create an Amazon SNS topic.","Subscribe endpoints (e.g., email, SQS, Lambda) to the SNS topic.","Verify subscriptions (if required, e.g., for email)."]'::json,
  '{1,2,3,0}',
  'To set up a notification system using Amazon SNS, the first step is to create an Amazon SNS topic (Option B), which acts as a communication channel. Next, subscribe endpoints (Option C) such as email addresses, SQS queues, or AWS Lambda functions to this topic. Then, verify subscriptions (Option D) if required (e.g., confirming email subscriptions). Finally, publish messages (Option A) to the SNS topic from the application, and SNS will fan out these messages to all subscribed endpoints.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  81,
  NULL,
  NULL,
  'm_62_8',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_55',
  'A startup wants to quickly build and deploy a full-stack web application with CI/CD, hosting, and backend services. Order the following steps to achieve this using AWS Amplify.',
  'ordering',
  '["Connect a code repository (e.g., GitHub) to Amplify for CI/CD.","Initialize an Amplify project in the application''s local directory.","Deploy the application and backend resources.","Add backend features like authentication, API, or storage using Amplify CLI."]'::json,
  '{1,3,0,2}',
  'To build and deploy a full-stack web application using AWS Amplify, the first step is to initialize an Amplify project (Option B) in the application''s local directory. Next, add backend features (Option D) like authentication, API, or storage using the Amplify CLI. Then, connect a code repository (Option A) to Amplify for continuous integration and deployment. Finally, deploy the application and backend resources (Option C) through the Amplify Console, which handles provisioning and hosting.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  82,
  NULL,
  NULL,
  'm_62_8',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_56',
  'A company is setting up a continuous integration and continuous delivery (CI/CD) pipeline for its application. Order the following stages in a typical AWS CodePipeline workflow.',
  'ordering',
  '["Source stage (e.g., pulling code from AWS CodeCommit).","Deploy stage (e.g., deploying to Amazon EC2 or AWS Lambda).","Build stage (e.g., compiling code with AWS CodeBuild).","Test stage (e.g., running automated tests with AWS CodeBuild)."]'::json,
  '{0,2,3,1}',
  'In a typical AWS CodePipeline workflow, the first stage is the Source stage (Option A), where the pipeline retrieves the latest code from a repository like AWS CodeCommit. Next is the Build stage (Option C), where the code is compiled, dependencies are installed, and artifacts are created, often using AWS CodeBuild. Following the build, the Test stage (Option D) runs automated tests, also commonly with AWS CodeBuild, to ensure code quality. Finally, the Deploy stage (Option B) deploys the validated application artifacts to the target environment, such as Amazon EC2 or AWS Lambda.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  83,
  NULL,
  NULL,
  'm_62_8',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_57',
  'A company needs to manage and connect IoT devices to the AWS Cloud. Order the following steps to establish a basic connection and enable message exchange using AWS IoT Core.',
  'ordering',
  '["Register the IoT device with AWS IoT Core and obtain credentials.","Configure an AWS IoT Core rule to route device messages to an AWS service.","Develop device software to connect to AWS IoT Core and publish/subscribe to topics.","Provision an IoT device (e.g., Raspberry Pi, sensor)."]'::json,
  '{3,0,2,1}',
  'To establish a basic connection and enable message exchange using AWS IoT Core, the first step is to provision an IoT device (Option D). Next, register the IoT device with AWS IoT Core (Option A) and obtain necessary credentials (certificates, keys). Then, develop device software (Option C) to connect to AWS IoT Core using MQTT, HTTP, or WebSockets and publish/subscribe to topics. Finally, configure an AWS IoT Core rule (Option B) to route device messages to an AWS service (e.g., AWS Lambda, Amazon S3) for processing or storage.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  84,
  NULL,
  NULL,
  'm_62_8',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_82'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_83'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_84'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_85'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_86'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_87'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_88'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_89'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_90'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_91'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_92'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_93'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_94'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_95'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_96'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_97'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_75'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_76'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_77'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_78'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_79'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_80'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_81'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_82'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_83'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_84'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_85'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_75'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_76'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_77'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_78'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_79'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_80'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_81'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_82'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_83'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_84'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_85'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_86'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_87'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_88'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_70'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_71'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_72'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_73'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_74'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_75'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_76'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_77'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_78'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_65'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_66'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_67'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_68'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_69'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_70'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_71'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_72'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_73'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_74'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_67'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_68'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_69'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_70'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_71'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_72'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_73'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_60'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_61'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_62'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_63'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_64'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_65'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_66'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_67'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_49'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_50'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_51'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_52'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_53'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_54'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_55'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_56'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_57')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain62_13'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;


-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: CLF-C02
-- Generated: 2026-03-14T22:03:53.632Z
-- Questions: 48 (48 validated, 15 rejected)
-- Quiz ID: quiz_domain63_13
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_63_1
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_80',
  'A startup wants to test a new application on AWS without incurring significant costs during the initial development phase. Order the following approaches from most cost-effective to least cost-effective for this scenario.',
  'ordering',
  '["Purchasing Reserved Instances","Utilizing the AWS Free Tier","Deploying on Spot Instances","Using On-Demand Instances"]'::json,
  '{1,2,3,0}',
  'Option B (Utilizing the AWS Free Tier) is the most cost-effective as it allows experimentation with many services at no cost for a limited period or usage. Option C (Deploying on Spot Instances) offers deep discounts for interruptible workloads, which can be suitable for non-critical development and testing. Option D (Using On-Demand Instances) provides flexibility but is more expensive than the Free Tier or Spot Instances. Option A (Purchasing Reserved Instances) is the least suitable for unpredictable development phases as it requires a long-term commitment regardless of actual usage.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  1,
  NULL,
  NULL,
  'm_63_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_81',
  'A team is migrating a legacy application to AWS and wants to minimize data transfer costs. Order the following data transfer scenarios from most likely to incur charges to least likely.',
  'ordering',
  '["Data transfer in to AWS from the internet","Data transfer between AWS Regions","Data transfer out from AWS to the internet","Data transfer within the same AWS Region (same Availability Zone)"]'::json,
  '{2,1,3,0}',
  'Option C (Data transfer out from AWS to the internet) is almost always charged and is often the most significant data transfer cost. Option B (Data transfer between AWS Regions) is also charged, as it crosses geographical boundaries. Option D (Data transfer within the same AWS Region, same Availability Zone) is generally free. Option A (Data transfer in to AWS from the internet) is typically free.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  2,
  NULL,
  NULL,
  'm_63_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_82',
  'A solutions architect is evaluating different Amazon EC2 pricing models for a new application. Order the following EC2 pricing models from the LEAST flexible to the MOST flexible in terms of commitment.',
  'ordering',
  '["Reserved Instances","Spot Instances","On-Demand Instances","Savings Plans"]'::json,
  '{0,3,2,1}',
  'Option A (Reserved Instances) typically requires a 1-year or 3-year commitment for a specific instance type and Region, making it the least flexible. Option D (Savings Plans) offers more flexibility than Reserved Instances by applying to usage across instance families, Regions, and operating systems, but still requires a 1-year or 3-year commitment to a certain amount of compute usage. Option C (On-Demand Instances) offers pay-as-you-go pricing with no long-term commitment, providing high flexibility. Option B (Spot Instances) offers the deepest discounts but can be interrupted by AWS with short notice, making it the most flexible in terms of commitment as there is no commitment at all, only bidding on unused capacity.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  3,
  NULL,
  NULL,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_83',
  'When calculating the total cost for using Amazon S3, various components contribute to the overall bill. Order the following cost components based on how they are typically considered, from the most fundamental to the more dynamic.',
  'ordering',
  '["Data transfer out of Amazon S3","Storage used in Amazon S3","Requests made to Amazon S3"]'::json,
  '{1,2,0}',
  'Option B (Storage used in Amazon S3) is the most fundamental cost, as you pay for the amount of data stored. Option C (Requests made to Amazon S3) are then charged based on operations like GET, PUT, COPY, etc., which are dynamic based on application usage. Option A (Data transfer out of Amazon S3) is typically the last component considered and can be significant, as outbound data transfer from AWS Regions to the internet is charged.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  4,
  NULL,
  NULL,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_84',
  'A development team is planning to deploy a fault-tolerant batch processing workload that can tolerate interruptions. Order the following Amazon EC2 pricing models from the MOST cost-effective to the LEAST cost-effective for this specific workload type.',
  'ordering',
  '["On-Demand Instances","Reserved Instances","Spot Instances"]'::json,
  '{2,1,0}',
  'Option C (Spot Instances) offers up to a 90% discount compared to On-Demand pricing and is ideal for fault-tolerant, interruptible workloads like batch processing, making it the most cost-effective. Option B (Reserved Instances) offers significant discounts (up to 72%) over On-Demand for a 1- or 3-year commitment, but they are less suitable for interruptible workloads than Spot Instances. Option A (On-Demand Instances) is the most expensive option and provides no discount for long-term commitment or interruptibility, making it the least cost-effective for this type of workload.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  5,
  NULL,
  NULL,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_85',
  'A company needs to optimize costs for its stable, long-running Amazon EC2 workloads. Order the following actions from the MOST impactful to the LEAST impactful for achieving significant cost savings.',
  'ordering',
  '["Purchasing On-Demand Instances","Utilizing AWS Free Tier for production workloads","Committing to Savings Plans or Reserved Instances"]'::json,
  '{2,0,1}',
  'Option C (Committing to Savings Plans or Reserved Instances) provides the most significant discounts (up to 72%) for stable, long-running workloads, making it the most impactful for cost savings. Option A (Purchasing On-Demand Instances) is the baseline pricing and offers no discounts for commitment, so while it''s a valid way to run instances, it''s less impactful for savings than commitments. Option B (Utilizing AWS Free Tier for production workloads) is incorrect because the AWS Free Tier is designed for experimentation and learning, not for production workloads, and its limits are quickly exceeded in a production environment, leading to charges.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  6,
  NULL,
  NULL,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_86',
  'When estimating the cost of an AWS Lambda function, several factors contribute to the total price. Order the following Lambda pricing components from the most frequently incurred to the less frequently incurred, assuming a typical usage pattern.',
  'ordering',
  '["Data transfer out of AWS Lambda","Number of invocations","Duration of execution"]'::json,
  '{1,2,0}',
  'Option B (Number of invocations) is the most fundamental and frequently incurred cost, as every time a Lambda function runs, it counts as an invocation. Option C (Duration of execution) is also always incurred per invocation, as you pay for the compute time consumed, but it''s a secondary factor to the invocation itself. Option A (Data transfer out of AWS Lambda) is incurred only when the Lambda function sends data out of the AWS network (e.g., to the internet), which is less frequent than invocations and duration for many common use cases.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  7,
  NULL,
  NULL,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_87',
  'A new AWS user wants to explore services without incurring unexpected costs. Order the following AWS Free Tier offerings from the most common and always available to the more specific or time-limited.',
  'ordering',
  '["12-months free offers (e.g., EC2 t2.micro, S3 Standard)","Always Free offers (e.g., AWS Lambda invocations, DynamoDB storage)","Short-term trial offers for new services"]'::json,
  '{1,0,2}',
  'Option B (Always Free offers) are available to all AWS customers indefinitely and are the most common and consistent way to use services for free. Option A (12-months free offers) are available for the first 12 months after signing up for an AWS account and typically cover popular services like EC2 and S3. Option C (Short-term trial offers for new services) are less common and are usually limited to specific new services for a defined period, making them the most specific and time-limited.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  8,
  NULL,
  NULL,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_88',
  'A startup is planning to deploy a new application with a predictable, steady-state workload on Amazon EC2 and wants to minimize costs by committing to usage. Arrange the following steps in the most logical order to achieve cost optimization for this workload.',
  'ordering',
  '["Analyze historical EC2 usage patterns in AWS Cost Explorer.","Purchase appropriate Amazon EC2 Reserved Instances or Savings Plans.","Identify the required EC2 instance family, size, and Region.","Monitor instance utilization to ensure optimal Reserved Instance or Savings Plan coverage."]'::json,
  '{2,0,1,3}',
  'To optimize costs for a predictable EC2 workload, the first step is to identify the specific EC2 instance family, size, and Region (Option C) that the application will use. Next, analyze historical usage patterns in AWS Cost Explorer (Option A) to accurately determine the commitment needed. Based on this analysis, purchase the appropriate Amazon EC2 Reserved Instances or Savings Plans (Option B) to secure significant discounts. Finally, continuously monitor instance utilization (Option D) to ensure the purchased commitments are fully utilized and provide the expected savings.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  9,
  NULL,
  NULL,
  'm_63_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_89',
  'A development team is planning a new serverless application using AWS Lambda and Amazon S3, and they need to get a preliminary cost estimate before deployment. Arrange the following steps to use the AWS Pricing Calculator effectively for this purpose.',
  'ordering',
  '["Add the planned AWS Lambda and Amazon S3 services to the estimate.","Review the detailed cost breakdown for each service and the total estimated monthly cost.","Input the expected usage parameters, such as Lambda invocations and S3 storage volume.","Access the AWS Pricing Calculator in the AWS Management Console."]'::json,
  '{3,0,2,1}',
  'To get a preliminary cost estimate using the AWS Pricing Calculator, the initial step is to access the AWS Pricing Calculator (Option D) from the AWS Management Console. Then, add the specific services planned for the application, such as AWS Lambda and Amazon S3 (Option A), to the estimate. Next, input the expected usage parameters (Option C), including the number of Lambda invocations, duration, and S3 storage volume. Finally, review the detailed cost breakdown (Option B) provided by the calculator to understand the estimated monthly cost.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  10,
  NULL,
  NULL,
  'm_63_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_90',
  'A new AWS user wants to explore various services without incurring unexpected charges during their first year. Arrange the following steps to effectively utilize the AWS Free Tier for this purpose.',
  'ordering',
  '["Monitor usage regularly through the AWS Billing Dashboard to stay within Free Tier limits.","Create an AWS account and activate the Free Tier.","Identify AWS services that offer an ''always free'' or ''12 months free'' tier.","Experiment with eligible services like Amazon EC2 t2.micro instances or Amazon S3 storage."]'::json,
  '{1,2,3,0}',
  'To effectively utilize the AWS Free Tier, the first step is to create an AWS account and activate the Free Tier (Option B). Next, identify which AWS services offer an ''always free'' or ''12 months free'' tier (Option C) to understand the eligible resources. Then, begin experimenting with these eligible services (Option D), such as launching an Amazon EC2 t2.micro instance or storing data in Amazon S3, ensuring usage stays within the specified limits. Finally, it is crucial to monitor usage regularly through the AWS Billing Dashboard (Option A) to avoid exceeding Free Tier limits and incurring charges.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  11,
  NULL,
  NULL,
  'm_63_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_91',
  'A company is migrating an existing application to AWS and needs to understand the potential data transfer costs, especially for data moving out of AWS and between different AWS Regions. Arrange the following steps to accurately assess these costs.',
  'ordering',
  '["Identify the volume of data expected to be transferred out of AWS to the internet.","Review the AWS data transfer pricing page for specific rates.","Determine the volume of data expected to be transferred between different AWS Regions.","Calculate the estimated total data transfer cost based on identified volumes and rates."]'::json,
  '{0,2,1,3}',
  'To accurately assess data transfer costs, start by identifying the volume of data expected to be transferred out of AWS to the internet (Option A), as this is a primary cost driver. Next, determine the volume of data expected to be transferred between different AWS Regions (Option C), as cross-Region transfers are also charged. After understanding the data volumes, review the AWS data transfer pricing page (Option B) to find the specific rates for outbound and cross-Region transfers. Finally, calculate the estimated total data transfer cost (Option D) by applying these rates to the identified data volumes.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  12,
  NULL,
  NULL,
  'm_63_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_63_3
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_53',
  'A user encounters a common technical question about an AWS service. Order the self-service resources they should consult first, from most immediate to most community-driven.',
  'ordering',
  '["AWS re:Post","AWS Documentation","AWS Knowledge Center","AWS Support (creating a case)"]'::json,
  '{1,2,0,3}',
  'Option B (AWS Documentation) is the most immediate and authoritative source for service information and how-to guides. Option C (AWS Knowledge Center) provides curated articles and FAQs for common issues. Option A (AWS re:Post) is a community-driven forum where users can ask questions and get answers from AWS experts and the community. Option D (AWS Support) should be considered a last resort for issues not resolved by self-service resources, as it involves creating a support case.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  13,
  NULL,
  NULL,
  'm_63_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_54',
  'A company wants to proactively identify best practice recommendations for cost optimization and security in their AWS account. Order the steps for utilizing AWS tools, from basic checks to deeper analysis.',
  'ordering',
  '["Reviewing AWS Trusted Advisor checks","Consulting AWS documentation","Submitting a support case to AWS Support","Engaging AWS Professional Services"]'::json,
  '{0,1,2,3}',
  'Option A (Reviewing AWS Trusted Advisor checks) is the first and most immediate step, as it provides automated, real-time recommendations for cost optimization, security, performance, fault tolerance, and service limits. Option B (Consulting AWS documentation) can provide deeper insights into specific best practices. Option C (Submitting a support case to AWS Support) is for when issues or questions cannot be resolved through self-service. Option D (Engaging AWS Professional Services) is for comprehensive, hands-on assistance with complex architectural reviews and implementations.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  14,
  NULL,
  NULL,
  'm_63_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_55',
  'A company experiences an unexpected service degradation affecting their AWS resources. Order the steps to check for AWS service health information, from general to personalized.',
  'ordering',
  '["Checking the AWS Service Health Dashboard (global view)","Reviewing the AWS Health Dashboard (personalized view)","Contacting AWS Support","Checking external news sources"]'::json,
  '{0,1,2,3}',
  'Option A (Checking the AWS Service Health Dashboard) provides a global view of the operational status of all AWS services. Option B (Reviewing the AWS Health Dashboard) offers a personalized view of AWS service health, showing only events that affect your specific resources. Option C (Contacting AWS Support) is the next step if the dashboards do not provide sufficient information or if direct assistance is needed. Option D (Checking external news sources) is generally not an official or reliable source for real-time AWS service health information.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  15,
  NULL,
  NULL,
  'm_63_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_56',
  'A system administrator notices that an AWS service is behaving unexpectedly and suspects a broader issue. Order the following AWS resources they should consult, from the most immediate and personalized to the more general and reactive.',
  'ordering',
  '["AWS Health Dashboard","AWS re:Post or documentation","AWS Support"]'::json,
  '{0,1,2}',
  'Option A (AWS Health Dashboard) provides personalized information about AWS service health that affects your specific resources, making it the most immediate and relevant check. Option B (AWS re:Post or documentation) offers general knowledge, FAQs, and community-driven answers, which are useful for common issues but not personalized to your account''s health. Option C (AWS Support) should be contacted if self-service resources do not resolve the issue, as it involves direct engagement with AWS technical support engineers, making it the most reactive step.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  16,
  NULL,
  NULL,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_57',
  'An organization is evaluating AWS Support plans for its production workloads. Order the following AWS Support plans from the LEAST comprehensive to the MOST comprehensive in terms of features and response times.',
  'ordering',
  '["Developer Support","Basic Support","Business Support","Enterprise Support"]'::json,
  '{1,0,2,3}',
  'Option B (Basic Support) is free and offers the least features, primarily access to documentation and re:Post, with no technical support. Option A (Developer Support) provides technical support during business hours via email, with a response time of 12-24 hours for general guidance. Option C (Business Support) offers 24/7 phone, chat, and email access with faster response times (e.g., 1 hour for impaired production systems). Option D (Enterprise Support) is the most comprehensive, providing a Technical Account Manager (TAM), fastest response times (e.g., 15 minutes for business-critical system down), and proactive architectural guidance.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  17,
  NULL,
  NULL,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_58',
  'A company wants to proactively identify and address potential cost savings and security improvements in their AWS environment. Order the following actions from the most automated to the most manual approach.',
  'ordering',
  '["Manually reviewing all resource configurations","Running AWS Trusted Advisor checks","Engaging AWS Professional Services for a deep dive"]'::json,
  '{1,0,2}',
  'Option B (Running AWS Trusted Advisor checks) is the most automated approach, as it proactively scans your AWS environment and provides automated recommendations for cost optimization, security, performance, fault tolerance, and service limits. Option A (Manually reviewing all resource configurations) is a manual and time-consuming process, making it less automated. Option C (Engaging AWS Professional Services for a deep dive) involves expert consultation and is the most manual and hands-on approach, providing tailored guidance but requiring significant human interaction.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  18,
  NULL,
  NULL,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_59',
  'A critical production system running on AWS experiences an outage. Order the following AWS Support plan response times for a ''business-critical system down'' severity, from the longest to the shortest.',
  'ordering',
  '["Business Support: 1 hour","Developer Support: 12 hours","Enterprise Support: 15 minutes"]'::json,
  '{1,0,2}',
  'Option B (Developer Support) has the longest response time for critical issues, typically 12 hours for ''system impaired'' or ''production system impaired'' (no specific ''business-critical system down'' tier). Option A (Business Support) guarantees a response within 1 hour for ''production system impaired'' or ''production system down''. Option C (Enterprise Support) offers the fastest response time, guaranteeing 15 minutes for ''business-critical system down'' issues.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  19,
  NULL,
  NULL,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_60',
  'A user discovers a potential security vulnerability in their application running on AWS. Order the steps they should take to address this, from immediate action to seeking expert guidance.',
  'ordering',
  '["Contact AWS Support for assistance","Review AWS Security documentation and best practices","Implement immediate mitigation steps (e.g., patching, access restriction)"]'::json,
  '{2,1,0}',
  'Option C (Implement immediate mitigation steps) is the most crucial first step to contain the vulnerability and prevent further damage. Option B (Review AWS Security documentation and best practices) should follow to understand the nature of the vulnerability and identify recommended long-term solutions. Option A (Contact AWS Support for assistance) should be done if the issue is complex, requires AWS''s direct involvement, or if the user needs expert guidance beyond self-service resources.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  20,
  NULL,
  NULL,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_61',
  'AWS Support plans offer varying levels of access to technical support engineers. Order the following support plans from those with NO direct access to technical support to those with dedicated technical support.',
  'ordering',
  '["Basic Support","Developer Support","Enterprise Support"]'::json,
  '{0,1,2}',
  'Option A (Basic Support) provides no direct access to technical support engineers; users rely on self-service resources. Option B (Developer Support) offers technical support via email during business hours. Option C (Enterprise Support) provides 24/7 access to technical support engineers via phone, chat, and email, along with a dedicated Technical Account Manager (TAM), representing the highest level of direct technical support.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  21,
  NULL,
  NULL,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_62',
  'When seeking answers to common AWS questions or troubleshooting minor issues, a user should leverage various self-service resources. Order these resources from the most community-driven to the most official and comprehensive.',
  'ordering',
  '["AWS re:Post","AWS Documentation","AWS Knowledge Center"]'::json,
  '{0,2,1}',
  'Option A (AWS re:Post) is a community-driven Q&A service where users can ask and answer questions, making it the most community-focused. Option C (AWS Knowledge Center) provides a collection of articles and FAQs for common technical issues, offering more official guidance than re:Post. Option B (AWS Documentation) is the most official and comprehensive source of information for all AWS services, covering detailed features, APIs, and best practices.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  22,
  NULL,
  NULL,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_63',
  'A company is deploying a critical production workload on AWS and needs to ensure rapid response times for technical issues. Arrange the following steps to choose the most appropriate AWS Support plan.',
  'ordering',
  '["Evaluate the required response times for critical, urgent, and general issues.","Review the features and benefits of each AWS Support plan (Basic, Developer, Business, Enterprise On-Ramp, Enterprise).","Assess the level of architectural guidance and proactive support needed.","Select the AWS Support plan that best aligns with the workload''s criticality and support requirements."]'::json,
  '{1,0,2,3}',
  'To choose the most appropriate AWS Support plan for a critical production workload, first review the features and benefits of each AWS Support plan (Option B), from Basic to Enterprise, to understand what each offers. Next, evaluate the required response times (Option A) for different severities of issues (e.g., 15 minutes for critical production system down) to ensure the plan meets operational needs. Then, assess the level of architectural guidance and proactive support (Option C), such as access to a Technical Account Manager (TAM), that the workload requires. Finally, select the AWS Support plan (Option D) that best aligns with the workload''s criticality, desired response times, and support needs.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  23,
  NULL,
  NULL,
  'm_63_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_64',
  'A cloud administrator wants to proactively identify potential cost savings, security vulnerabilities, and performance improvements across their AWS environment. Arrange the following steps to effectively use AWS Trusted Advisor for this purpose.',
  'ordering',
  '["Review the recommendations provided by Trusted Advisor, categorized by pillar (e.g., Cost Optimization, Security).","Access AWS Trusted Advisor in the AWS Management Console.","Implement the suggested actions to improve the AWS environment.","Prioritize recommendations based on impact and effort."]'::json,
  '{1,0,3,2}',
  'To effectively use AWS Trusted Advisor, first access AWS Trusted Advisor (Option B) in the AWS Management Console. Next, review the recommendations (Option A) provided by Trusted Advisor, which are categorized into pillars like Cost Optimization, Security, Performance, Fault Tolerance, and Service Limits. Then, prioritize these recommendations (Option D) based on their potential impact on cost savings or security posture and the effort required to implement them. Finally, implement the suggested actions (Option C) to improve the AWS environment according to best practices.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  24,
  NULL,
  NULL,
  'm_63_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_65',
  'A DevOps team encounters a critical issue affecting their production application running on AWS and needs immediate technical assistance. Assuming they have a Business Support plan, arrange the following steps to get help efficiently.',
  'ordering',
  '["Open a new support case with a ''Critical'' severity level.","Describe the issue in detail, including affected resources and impact.","Access the AWS Support Center in the AWS Management Console.","Provide contact information for immediate follow-up via phone or chat."]'::json,
  '{2,0,1,3}',
  'To get efficient technical assistance for a critical production issue with a Business Support plan, first access the AWS Support Center (Option C) in the AWS Management Console. Next, open a new support case (Option A) and select a ''Critical'' severity level to ensure the fastest response time. Then, describe the issue in detail (Option B), including affected resources, error messages, and the impact on the production application. Finally, provide contact information (Option D) for immediate follow-up via phone or chat, as Business Support offers 24/7 access to technical support engineers.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  25,
  NULL,
  NULL,
  'm_63_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_66',
  'An operations team wants to stay informed about any AWS service events that might impact their specific resources or Region. Arrange the following steps to effectively monitor personalized service health notifications.',
  'ordering',
  '["Access the AWS Health Dashboard in the AWS Management Console.","Review the ''Your affected resources'' section for specific impacts.","Check the ''Open issues'' and ''Scheduled changes'' sections for relevant events.","Configure AWS Health events to send notifications via Amazon EventBridge or Amazon SNS."]'::json,
  '{0,2,1,3}',
  'To effectively monitor personalized service health notifications, first access the AWS Health Dashboard (Option A) in the AWS Management Console. Next, check the ''Open issues'' and ''Scheduled changes'' sections (Option C) to see any ongoing or upcoming events that could affect your services. Then, review the ''Your affected resources'' section (Option B) for specific details on how these events might impact your particular AWS resources. Finally, for proactive alerts, configure AWS Health events to send notifications (Option D) via Amazon EventBridge or Amazon SNS to relevant teams.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  26,
  NULL,
  NULL,
  'm_63_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_67',
  'A developer is looking for answers to a common technical question about an AWS service and wants to utilize self-service resources before contacting AWS Support. Arrange the following steps to efficiently find the required information.',
  'ordering',
  '["Search the AWS Knowledge Center or official AWS documentation for relevant articles.","Post a question on AWS re:Post if an answer is not readily available.","Identify keywords related to the technical question or issue.","Review community-provided answers and official AWS responses on re:Post."]'::json,
  '{2,0,1,3}',
  'To efficiently find answers using self-service resources, first identify keywords (Option C) related to the technical question or issue. Next, search the AWS Knowledge Center or official AWS documentation (Option A) for relevant articles or guides. If a direct answer isn''t found, post a question on AWS re:Post (Option B) to leverage the community and AWS experts. Finally, review community-provided answers and official AWS responses (Option D) on re:Post to find the solution.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  27,
  NULL,
  NULL,
  'm_63_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_68',
  'A new AWS user is trying to understand the different levels of support available from AWS to decide which plan is suitable for their future production workloads. Arrange the following steps to understand the benefits of various AWS Support plans.',
  'ordering',
  '["Compare the technical support channels and response times offered by each plan.","Review the official AWS Support plans documentation.","Identify the features exclusive to higher-tier plans, such as a Technical Account Manager (TAM) or AWS Concierge.","Assess the cost implications of each support plan relative to its benefits."]'::json,
  '{1,0,2,3}',
  'To understand the benefits of various AWS Support plans, first review the official AWS Support plans documentation (Option B) to get an overview of Basic, Developer, Business, and Enterprise plans. Next, compare the technical support channels (e.g., email, chat, phone) and response times (Option A) offered by each plan for different issue severities. Then, identify the features exclusive to higher-tier plans (Option C), such as a Technical Account Manager (TAM) or AWS Concierge, which provide proactive guidance. Finally, assess the cost implications (Option D) of each support plan relative to its benefits to make an informed decision for future production workloads.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  28,
  NULL,
  NULL,
  'm_63_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_63_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_71',
  'Order the following AWS cost management tools from providing a high-level overview to offering detailed, granular data for analysis.',
  'ordering',
  '["AWS Cost Explorer","AWS Cost and Usage Report","AWS Billing Dashboard","AWS Pricing Calculator"]'::json,
  '{2,0,1,3}',
  'Option C (AWS Billing Dashboard) provides a high-level summary of your current and past AWS spending. Option A (AWS Cost Explorer) allows for more detailed visualization and analysis of spending patterns over time. Option B (AWS Cost and Usage Report) provides the most granular, line-item billing data for in-depth analysis. Option D (AWS Pricing Calculator) is used for estimating future costs, not for analyzing past spending.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  29,
  NULL,
  NULL,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_72',
  'A company wants to prevent unexpected charges by setting up alerts for their AWS spending. Order the general steps to configure a cost budget in AWS.',
  'ordering',
  '["Define budget thresholds and alerts","Select a budget type (e.g., cost, usage)","Specify the budget scope (e.g., entire account, specific tags)","Review and create the budget"]'::json,
  '{1,2,0,3}',
  'The first step is to Option B (Select a budget type), such as a cost budget or usage budget. Next, Option C (Specify the budget scope) by choosing whether it applies to the entire account, specific services, or resources with certain tags. Then, Option A (Define budget thresholds and alerts) to specify when you want to be notified. Finally, Option D (Review and create the budget) to activate your budget and alerts.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  30,
  NULL,
  NULL,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_73',
  'Order the general steps to effectively use cost allocation tags to track costs by project or team.',
  'ordering',
  '["Activate tags for cost allocation in the Billing console","Apply tags to AWS resources","Analyze costs using Cost Explorer with tag filters","Define a tagging strategy"]'::json,
  '{3,1,0,2}',
  'The first step is to Option D (Define a tagging strategy) to standardize how tags will be used across your organization. Next, Option B (Apply tags to AWS resources) as you create or modify them. Then, Option A (Activate tags for cost allocation in the Billing console) so AWS can process them for cost reporting. Finally, Option C (Analyze costs using Cost Explorer with tag filters) to view and break down your spending by project or team.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  31,
  NULL,
  NULL,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_74',
  'An organization with multiple AWS accounts wants to simplify billing and potentially gain volume discounts. Order the initial steps to set up consolidated billing within AWS Organizations.',
  'ordering',
  '["Create an organization in the AWS Organizations console","Invite other AWS accounts to join the organization","Accept the invitation from the invited accounts","Review the consolidated bill in the management account"]'::json,
  '{0,1,2,3}',
  'The first step is to Option A (Create an organization in the AWS Organizations console) from the account that will serve as the management account. Next, Option B (Invite other AWS accounts to join the organization) from the management account. Then, Option C (Accept the invitation from the invited accounts) to add them as member accounts. Once accounts are joined, you can Option D (Review the consolidated bill in the management account) which will aggregate charges and apply volume discounts.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  32,
  NULL,
  NULL,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_75',
  'Order the typical sections a user would navigate through on the AWS Billing Dashboard to understand their current month''s spending.',
  'ordering',
  '["Bills","Cost Explorer","Cost and Usage Reports","Monthly spend by service"]'::json,
  '{3,0,1,2}',
  'When viewing the AWS Billing Dashboard, a user would typically first see Option D (Monthly spend by service) for a quick overview of their current charges. To get more detailed invoices, they would navigate to Option A (Bills). For interactive analysis and deeper insights, Option B (Cost Explorer) is used. Option C (Cost and Usage Reports) provides the most granular, raw data, which is usually accessed for advanced analysis or integration with other tools, not typically a direct navigation from the dashboard for a quick understanding.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  33,
  NULL,
  NULL,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_76',
  'A finance team needs a highly detailed, line-item breakdown of all AWS charges for auditing purposes. Order the AWS tools from most granular to least granular for this purpose.',
  'ordering',
  '["AWS Billing Dashboard","AWS Cost and Usage Report (CUR)","AWS Cost Explorer","AWS Budgets"]'::json,
  '{1,2,0,3}',
  'Option B (AWS Cost and Usage Report (CUR)) provides the most granular, comprehensive line-item data about your AWS costs and usage, suitable for detailed auditing. Option C (AWS Cost Explorer) offers powerful visualization and analysis capabilities based on your cost and usage data, but it''s an aggregated view compared to the raw CUR. Option A (AWS Billing Dashboard) provides a summary overview of your charges. Option D (AWS Budgets) is used for setting cost and usage thresholds and receiving alerts, not primarily for detailed historical auditing.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  34,
  NULL,
  NULL,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_77',
  'Order the capabilities of AWS Cost Explorer from basic visualization to advanced analysis and forecasting.',
  'ordering',
  '["View spending trends by service","Create custom reports with filters and groups","Forecast future costs based on past usage","Identify Reserved Instance and Savings Plan recommendations"]'::json,
  '{0,1,3,2}',
  'Option A (View spending trends by service) is a basic visualization capability, providing an overview of where costs are going. Option B (Create custom reports with filters and groups) allows for more advanced analysis by segmenting data. Option D (Identify Reserved Instance and Savings Plan recommendations) is an advanced feature that helps optimize costs by suggesting commitment-based purchases. Option C (Forecast future costs based on past usage) is another advanced capability, using historical data to predict future spending.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  35,
  NULL,
  NULL,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_78',
  'A startup is launching a new application on AWS and wants to monitor its costs from day one. Order the following steps to establish basic cost monitoring and alerts for their AWS account.',
  'ordering',
  '["Review the AWS Billing Dashboard for an overview","Set up an AWS Budget to receive alerts","Apply cost allocation tags to resources"]'::json,
  '{2,1,0}',
  'Option C (Apply cost allocation tags to resources) is the foundational step for granular cost tracking, allowing costs to be categorized from the start. Option B (Set up an AWS Budget to receive alerts) should be configured next, leveraging tags if available, to proactively notify the team of potential overspending. Option A (Review the AWS Billing Dashboard for an overview) is a general overview tool that can be used at any time to see the current bill, but it''s less proactive than budgets and relies on underlying cost data, including tags.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  36,
  NULL,
  NULL,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_79',
  'A company notices an unexpected increase in their monthly AWS bill. Order the following AWS tools they should use to investigate the cause, from the most high-level overview to the most detailed analysis.',
  'ordering',
  '["AWS Cost Explorer","AWS Billing Dashboard","AWS Cost and Usage Report (CUR)"]'::json,
  '{1,0,2}',
  'Option B (AWS Billing Dashboard) provides a high-level overview of current and forecasted charges, making it the first place to check for a quick summary. Option A (AWS Cost Explorer) allows for visualizing, understanding, and managing AWS costs and usage over time with more detailed filtering and grouping capabilities. Option C (AWS Cost and Usage Report (CUR)) provides the most granular, line-item level detail of all AWS costs and usage, which can be analyzed with other tools for deep investigation, making it the most detailed.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  37,
  NULL,
  NULL,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_80',
  'An organization with multiple AWS accounts wants to centralize billing and gain better cost visibility. Order the following steps to achieve this, from initial setup to detailed analysis.',
  'ordering',
  '["Enable consolidated billing in AWS Organizations","Analyze costs using AWS Cost Explorer across all accounts","Create an AWS Organization and invite accounts"]'::json,
  '{2,0,1}',
  'Option C (Create an AWS Organization and invite accounts) is the initial step to bring multiple accounts under a single management structure. Option A (Enable consolidated billing in AWS Organizations) is then configured within the Organization to aggregate billing for all member accounts, allowing for volume discounts. Option B (Analyze costs using AWS Cost Explorer across all accounts) is the final step, where the consolidated billing data can be visualized and analyzed for optimization opportunities.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  38,
  NULL,
  NULL,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_81',
  'AWS provides various tools for cost management, offering different levels of detail. Order the following tools by the granularity of cost data they provide, from the least granular to the most granular.',
  'ordering',
  '["AWS Cost Explorer","AWS Billing Dashboard","AWS Cost and Usage Report (CUR)"]'::json,
  '{1,0,2}',
  'Option B (AWS Billing Dashboard) provides the least granular data, offering a high-level summary of costs. Option A (AWS Cost Explorer) offers more granularity, allowing users to analyze costs by service, usage type, tags, and more. Option C (AWS Cost and Usage Report (CUR)) provides the most granular data, with line-item details for every charge, enabling deep analysis and integration with other data analysis tools.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  39,
  NULL,
  NULL,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_82',
  'A finance team wants to be notified if their AWS spending exceeds certain thresholds. Order the following steps to set up proactive cost alerts.',
  'ordering',
  '["Define the budget amount and period","Specify the recipients for budget notifications","Create an AWS Budget in the console"]'::json,
  '{2,0,1}',
  'Option C (Create an AWS Budget in the console) is the initial action to start the budget creation process. Option A (Define the budget amount and period) is a critical configuration step within the budget creation, specifying what cost or usage threshold to monitor. Option B (Specify the recipients for budget notifications) is the final configuration step to ensure that the correct individuals or groups receive alerts when the budget thresholds are met or exceeded.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  40,
  NULL,
  NULL,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_83',
  'A cloud administrator needs to regularly review AWS spending. Order the following AWS cost management tools from providing the quickest, highest-level summary to offering the most granular, historical analysis.',
  'ordering',
  '["AWS Cost Explorer","AWS Billing Dashboard","AWS Cost and Usage Report (CUR)"]'::json,
  '{1,0,2}',
  'Option B (AWS Billing Dashboard) provides the quickest, highest-level summary of current month-to-date charges and forecasted costs. Option A (AWS Cost Explorer) allows for more detailed, interactive analysis of costs over time, with filtering and grouping capabilities. Option C (AWS Cost and Usage Report (CUR)) provides the most granular, historical line-item data, suitable for deep analysis and integration with other business intelligence tools.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  41,
  NULL,
  NULL,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_84',
  'A finance department wants to proactively monitor AWS spending and receive alerts if costs exceed predefined thresholds. Arrange the following steps to set up an AWS Budget to achieve this goal.',
  'ordering',
  '["Define the specific cost or usage threshold for the budget.","Configure alert notifications to be sent to relevant stakeholders.","Navigate to the AWS Budgets section within the AWS Management Console.","Specify the budget''s scope, such as monthly, quarterly, or annual, and the services to include."]'::json,
  '{2,3,0,1}',
  'To set up an AWS Budget for proactive cost monitoring, first navigate to the AWS Budgets section (Option C) in the AWS Management Console. Next, specify the budget''s scope (Option D), including the time period (e.g., monthly) and which services or tags to include. Then, define the specific cost or usage threshold (Option A) that, if exceeded, should trigger an alert. Finally, configure alert notifications (Option B) to be sent to relevant stakeholders via email or Amazon SNS, ensuring they are informed of potential cost overruns.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  42,
  NULL,
  NULL,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_85',
  'A cloud administrator needs to analyze historical AWS spending patterns to identify trends and potential areas for cost optimization. Arrange the following steps to effectively use AWS Cost Explorer for this analysis.',
  'ordering',
  '["Apply filters and groups (e.g., by service, Region, or tag) to refine the data.","Access AWS Cost Explorer in the AWS Management Console.","Review the generated graphs and reports to identify spending trends and anomalies.","Select the desired time period for the cost analysis."]'::json,
  '{1,3,0,2}',
  'To effectively use AWS Cost Explorer for analyzing historical spending, first access AWS Cost Explorer (Option B) in the AWS Management Console. Next, select the desired time period (Option D) for the cost analysis, such as the last 3 months or a custom range. Then, apply filters and groups (Option A) to refine the data, allowing for granular analysis by service, Region, or cost allocation tags. Finally, review the generated graphs and reports (Option C) to identify spending trends, pinpoint high-cost areas, and discover opportunities for optimization.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  43,
  NULL,
  NULL,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_86',
  'An organization wants to track AWS costs by specific projects and departments to improve accountability and chargeback. Arrange the following steps to implement cost allocation tags for this purpose.',
  'ordering',
  '["Activate the defined tags as cost allocation tags in the AWS Billing and Cost Management console.","Define a consistent tagging strategy (e.g., ''Project'', ''Department'') for resources.","Apply the defined tags to relevant AWS resources, such as Amazon EC2 instances or Amazon S3 buckets.","Use AWS Cost Explorer to filter and analyze costs based on the applied tags."]'::json,
  '{1,2,0,3}',
  'To implement cost allocation tags, first define a consistent tagging strategy (Option B) that includes keys like ''Project'' or ''Department''. Next, apply these defined tags to relevant AWS resources (Option C) across your infrastructure. After applying tags, activate them as cost allocation tags (Option A) in the AWS Billing and Cost Management console so they appear in your cost reports. Finally, use AWS Cost Explorer (Option D) to filter and analyze costs based on these tags, providing granular visibility into spending by project or department.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  44,
  NULL,
  NULL,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_87',
  'A financial analyst requires a highly detailed, line-item breakdown of all AWS usage and costs for auditing and advanced analysis. Arrange the following steps to obtain and utilize this information using the AWS Cost and Usage Report (CUR).',
  'ordering',
  '["Configure the AWS Cost and Usage Report to be delivered to an Amazon S3 bucket.","Access the AWS Billing Dashboard and navigate to the Cost & Usage Reports section.","Analyze the detailed data using business intelligence tools or spreadsheet software.","Specify report details such as time granularity (hourly/daily) and data refresh frequency."]'::json,
  '{1,0,3,2}',
  'To obtain detailed billing data via the AWS Cost and Usage Report (CUR), first access the AWS Billing Dashboard and navigate to the Cost & Usage Reports section (Option B). Next, configure the AWS Cost and Usage Report (Option A) to be delivered to a specified Amazon S3 bucket. Then, specify report details (Option D), such as hourly or daily granularity and data refresh frequency, to meet analytical needs. Finally, analyze the detailed data (Option C) stored in the S3 bucket using business intelligence tools or spreadsheet software for auditing and advanced cost analysis.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  45,
  NULL,
  NULL,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_88',
  'A company with several AWS accounts wants to simplify billing and potentially benefit from volume discounts by consolidating their invoices. Arrange the following steps to implement consolidated billing using AWS Organizations.',
  'ordering',
  '["Invite existing AWS accounts to join the organization.","Create an organization in AWS Organizations from the management account.","Review the consolidated bill and identify potential volume discounts.","Designate one AWS account as the management account."]'::json,
  '{3,1,0,2}',
  'To implement consolidated billing with AWS Organizations, the first step is to designate one AWS account as the management account (Option D), which will pay all bills. Next, create an organization in AWS Organizations (Option B) from this management account. Then, invite existing AWS accounts (Option A) to join the organization, making them member accounts. Finally, review the consolidated bill (Option C) generated by the management account, which aggregates usage across all member accounts and applies any eligible volume discounts.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  46,
  NULL,
  NULL,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_89',
  'A new AWS user wants to quickly get an overview of their current month''s spending and recent charges. Arrange the following steps to effectively use the AWS Billing Dashboard for this purpose.',
  'ordering',
  '["Access the AWS Billing Dashboard in the AWS Management Console.","Review the ''Cost and Usage'' section for a summary of current charges.","Examine the ''Bills'' section to see past invoices and payment history.","Identify the top services contributing to the current month''s spend."]'::json,
  '{0,1,3,2}',
  'To quickly get an overview of current spending, first access the AWS Billing Dashboard (Option A) in the AWS Management Console. Next, review the ''Cost and Usage'' section (Option B) which provides a high-level summary of current charges for the month-to-date. Then, identify the top services (Option D) contributing to the current month''s spend using the visual breakdown. Finally, examine the ''Bills'' section (Option C) to view past invoices and payment history for a broader financial context.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  47,
  NULL,
  NULL,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_90',
  'A company is looking for opportunities to reduce its AWS bill by identifying underutilized resources and potential savings. Arrange the following steps to leverage AWS Cost Explorer''s recommendations for cost optimization.',
  'ordering',
  '["Implement the recommended actions, such as rightsizing instances or purchasing Reserved Instances.","Access AWS Cost Explorer in the AWS Management Console.","Navigate to the ''Recommendations'' section within Cost Explorer.","Review the suggested cost optimization opportunities, including estimated savings."]'::json,
  '{1,2,3,0}',
  'To leverage AWS Cost Explorer''s recommendations for cost optimization, first access AWS Cost Explorer (Option B) in the AWS Management Console. Next, navigate to the ''Recommendations'' section (Option C) within Cost Explorer. Then, review the suggested cost optimization opportunities (Option D), which may include rightsizing Amazon EC2 instances, purchasing Reserved Instances, or deleting idle resources, along with their estimated savings. Finally, implement the recommended actions (Option A) to realize the potential cost reductions.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  48,
  NULL,
  NULL,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_80'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_81'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_82'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_83'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_84'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_85'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_86'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_87'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_88'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_89'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_90'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_91'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_53'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_54'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_55'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_56'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_57'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_58'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_59'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_60'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_61'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_62'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_63'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_64'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_65'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_66'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_67'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_68'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_71'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_72'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_73'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_74'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_75'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_76'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_77'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_78'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_79'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_80'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_81'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_82'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_83'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_84'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_85'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_86'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_87'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_88'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_89'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_90')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain63_13'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;


-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: CLF-C02
-- Generated: 2026-03-19T01:39:19.819Z
-- Questions: 96 (96 validated, 1 rejected)
-- Quiz ID: quiz_domain60_13
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_60_1
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_110',
  'Match each fundamental benefit of the AWS Cloud to its description.',
  'matching',
  '{"A":"Agility","B":"Elasticity","C":"Pay-as-you-go"}'::json,
  NULL,
  'Agility (left[0]) refers to the speed and responsiveness to change (right[2]), allowing businesses to innovate faster. Elasticity (left[1]) is the ability to scale resources up or down quickly (right[0]) based on demand, avoiding over-provisioning. Pay-as-you-go (left[2]) means customers incur no upfront costs and pay only for what they use (right[1]), aligning costs with actual consumption.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  1,
  '{"left":["Agility","Elasticity","Pay-as-you-go"],"right":["Ability to scale resources up or down quickly","No upfront costs, pay only for what you use","Speed and responsiveness to change"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_111',
  'Match the AWS Cloud benefit to its characteristic.',
  'matching',
  '{"A":"High Availability","B":"Fault Tolerance","C":"Global Infrastructure"}'::json,
  NULL,
  'High Availability (left[0]) ensures applications remain operational despite failures (right[2]), often achieved by distributing resources. Fault Tolerance (left[1]) is the ability of a system to withstand component failures (right[0]) and continue operating. AWS Global Infrastructure (left[2]) refers to the worldwide network that spans multiple geographic regions and Availability Zones (right[1]), enabling low-latency deployments.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  2,
  '{"left":["High Availability","Fault Tolerance","Global Infrastructure"],"right":["Ability to withstand component failures","Spans multiple geographic regions and Availability Zones","Ensures applications remain operational despite failures"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_112',
  'Match the AWS Cloud economic concept to its definition.',
  'matching',
  '{"A":"Economies of Scale","B":"Reduced Total Cost of Ownership (TCO)","C":"Capital Expenditure (CapEx) to Operational Expenditure (OpEx)"}'::json,
  NULL,
  'Economies of Scale (left[0]) refers to the benefit of large-scale cloud providers passing cost savings to customers (right[0]) due to their massive infrastructure. Reduced Total Cost of Ownership (TCO) (left[1]) represents the overall cost of owning and operating IT infrastructure (right[2]), which is often lower in the cloud. Shifting from Capital Expenditure (CapEx) to Operational Expenditure (OpEx) (left[2]) means eliminating large upfront infrastructure investments (right[1]) and paying for services as you consume them.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  3,
  '{"left":["Economies of Scale","Reduced Total Cost of Ownership (TCO)","Capital Expenditure (CapEx) to Operational Expenditure (OpEx)"],"right":["Benefit of large-scale cloud providers passing cost savings to customers","Eliminating large upfront infrastructure investments","Overall cost of owning and operating IT infrastructure"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_113',
  'Match the AWS Cloud benefit to its impact on business.',
  'matching',
  '{"A":"Deploy Globally in Minutes","B":"Increased Speed","C":"Enabling Innovation"}'::json,
  NULL,
  'Deploy Globally in Minutes (left[0]) allows businesses to quickly launch applications in multiple regions (right[2]), reaching a wider audience. Increased Speed (left[1]) comes from the rapid provisioning of resources (right[1]), reducing time-to-market. Enabling Innovation (left[2]) is facilitated by the ability to experiment and iterate rapidly (right[0]) without significant upfront investment.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  4,
  '{"left":["Deploy Globally in Minutes","Increased Speed","Enabling Innovation"],"right":["Ability to experiment and iterate rapidly","Rapid provisioning of resources","Quickly launch applications in multiple regions"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_114',
  'Match the AWS Cloud benefit to its characteristic.',
  'matching',
  '{"A":"Scalability","B":"Cost Savings","C":"Increased Speed"}'::json,
  NULL,
  'Scalability (left[0]) is the ability to handle increased load by adding resources (right[0]) as needed. Cost Savings (left[1]) refers to reduced expenses compared to on-premises infrastructure (right[1]) due to pay-as-you-go and economies of scale. Increased Speed (left[2]) is achieved through faster provisioning of IT resources (right[2]), accelerating development and deployment cycles.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  5,
  '{"left":["Scalability","Cost Savings","Increased Speed"],"right":["Ability to handle increased load by adding resources","Reduced expenses compared to on-premises infrastructure","Faster provisioning of IT resources"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_115',
  'Match the AWS Cloud value proposition to its aspect.',
  'matching',
  '{"A":"Global Reach","B":"Innovation","C":"Reduced Time to Market"}'::json,
  NULL,
  'Global Reach (left[0]) provides access to a vast network of data centers worldwide (right[1]), allowing businesses to serve customers globally. Innovation (left[1]) is fostered by the freedom to experiment with new technologies (right[2]) without significant upfront investment. Reduced Time to Market (left[2]) is achieved through the ability to quickly launch new products and features (right[0]) using cloud resources.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  6,
  '{"left":["Global Reach","Innovation","Reduced Time to Market"],"right":["Ability to quickly launch new products and features","Access to a vast network of data centers worldwide","Freedom to experiment with new technologies"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_116',
  'Match the AWS Cloud cost component to its description.',
  'matching',
  '{"A":"Server Costs","B":"Data Center Costs","C":"Staff Costs"}'::json,
  NULL,
  'Server Costs (left[0]) refer to the cost of virtual machines or physical servers (right[2]) used for computing. Data Center Costs (left[1]) include expenses for power, cooling, and physical security (right[0]) of on-premises facilities. Staff Costs (left[2]) are the salaries for IT personnel managing infrastructure (right[1]), which can be reduced with managed cloud services.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  7,
  '{"left":["Server Costs","Data Center Costs","Staff Costs"],"right":["Expenses for power, cooling, and physical security","Salaries for IT personnel managing infrastructure","Cost of virtual machines or physical servers"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_117',
  'Match the AWS Cloud characteristic to its on-premises comparison.',
  'matching',
  '{"A":"Agility","B":"Capacity Planning","C":"Maintenance"}'::json,
  NULL,
  'Agility (left[0]) in the cloud means rapid provisioning and de-provisioning of resources (right[2]), unlike traditional IT. Capacity Planning (left[1]) on-premises requires forecasting demand and purchasing hardware (right[0]), which is largely eliminated in the cloud. Maintenance (left[2]) of underlying infrastructure is managed by AWS, reducing customer burden (right[1]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  8,
  '{"left":["Agility","Capacity Planning","Maintenance"],"right":["Requires forecasting demand and purchasing hardware","Managed by AWS, reducing customer burden","Rapid provisioning and de-provisioning of resources"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_118',
  'Match each core benefit of the AWS Cloud to its primary characteristic.',
  'matching',
  '{"A":"Agility","B":"Elasticity","C":"Economies of scale"}'::json,
  NULL,
  'Agility (left[0]) refers to the ability to innovate faster and respond quickly to change (right[0]). Elasticity (left[1]) is the ability to scale resources up or down based on demand (right[1]), ensuring resources match actual usage. Economies of scale (left[2]) are the cost advantages that AWS, as a large-scale cloud provider, passes to its customers (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  9,
  '{"left":["Agility","Elasticity","Economies of scale"],"right":["Ability to innovate faster and respond quickly to change.","Ability to scale resources up or down based on demand.","Cost advantages passed to customers due to large-scale operations."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_119',
  'Match each AWS Cloud value proposition to its description.',
  'matching',
  '{"A":"High availability","B":"Global infrastructure","C":"Pay-as-you-go"}'::json,
  NULL,
  'High availability (left[0]) is achieved by distributing workloads across multiple Availability Zones for resilience against failures (right[0]). The AWS Global Infrastructure (left[1]) allows deploying applications worldwide in minutes to reduce latency for end users (right[1]). The pay-as-you-go model (left[2]) means customers only pay for the specific compute, storage, and other resources they consume (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  10,
  '{"left":["High availability","Global infrastructure","Pay-as-you-go"],"right":["Distribute workloads across multiple Availability Zones for resilience.","Deploy applications worldwide in minutes to reduce latency.","Only pay for the compute, storage, and other resources consumed."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_120',
  'Match the AWS Cloud benefit to its explanation.',
  'matching',
  '{"A":"Fault tolerance","B":"Reduced TCO","C":"Innovation focus"}'::json,
  NULL,
  'Fault tolerance (left[0]) is a key benefit that allows systems to maintain operations even if individual components fail (right[0]). Reduced Total Cost of Ownership (TCO) (left[1]) means that the overall costs of running IT infrastructure on AWS are often lower than on-premises (right[1]), considering both direct and indirect costs. An innovation focus (left[2]) is enabled by the cloud, allowing organizations to shift resources from managing infrastructure to developing new products and features (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  11,
  '{"left":["Fault tolerance","Reduced TCO","Innovation focus"],"right":["Maintain operations despite component failures.","Lower overall costs compared to on-premises.","Shift resources from infrastructure to product development."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_121',
  'Match the AWS Cloud benefit to its operational impact.',
  'matching',
  '{"A":"Speed","B":"Capacity planning","C":"Experimentation"}'::json,
  NULL,
  'Speed (left[0]) is a benefit due to the rapid provisioning of resources, allowing quick deployment (right[0]). The cloud eliminates the need for manual capacity planning (left[1]) by providing on-demand resources, removing the guesswork for future infrastructure needs (right[1]). Experimentation (left[2]) is greatly enhanced as users can test new ideas quickly and cheaply without large upfront investments (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  12,
  '{"left":["Speed","Capacity planning","Experimentation"],"right":["Rapid provisioning of resources.","Elimination of guesswork for infrastructure needs.","Ability to test new ideas quickly and cheaply."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_122',
  'Match the AWS infrastructure component to its definition.',
  'matching',
  '{"A":"AWS Region","B":"Availability Zone","C":"Edge Location"}'::json,
  NULL,
  'An AWS Region (left[0]) is a geographical area that contains multiple isolated locations (right[0]). An Availability Zone (left[1]) is an isolated location within a Region, designed with redundant power, networking, and connectivity (right[1]). An Edge Location (left[2]) is a site used by Amazon CloudFront to cache content closer to end users, reducing latency (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  13,
  '{"left":["AWS Region","Availability Zone","Edge Location"],"right":["A geographical area with multiple isolated locations.","An isolated location within a Region, with redundant power.","A site for caching content closer to end users."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_123',
  'Match the AWS Cloud benefit to how it impacts business.',
  'matching',
  '{"A":"Cost savings","B":"Global deployment","C":"Business continuity"}'::json,
  NULL,
  'Cost savings (left[0]) are achieved by reducing both operational expenditure and capital expenditure through the pay-as-you-go model (right[0]). Global deployment (left[1]) allows businesses to reach a worldwide audience with minimal effort, leveraging AWS''s extensive infrastructure (right[1]). Business continuity (left[2]) is enhanced by AWS''s robust, highly available infrastructure, helping maintain operations during disruptions (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  14,
  '{"left":["Cost savings","Global deployment","Business continuity"],"right":["Reduce operational expenditure and capital expenditure.","Reach a worldwide audience with minimal effort.","Maintain operations during disruptions with robust infrastructure."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_124',
  'Match the AWS Cloud characteristic to its advantage.',
  'matching',
  '{"A":"Scalability","B":"Security","C":"Performance"}'::json,
  NULL,
  'Scalability (left[0]) allows applications to handle increasing workloads without performance degradation by adding or removing resources as needed (right[0]). Security (left[1]) benefits from leveraging AWS''s robust security controls, compliance certifications, and shared responsibility model (right[1]). Performance (left[2]) is enhanced by access to high-speed networking, optimized hardware, and global infrastructure (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  15,
  '{"left":["Scalability","Security","Performance"],"right":["Handle increasing workloads without performance degradation.","Leverage AWS''s robust security controls and compliance.","Access high-speed network and optimized hardware."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_125',
  'Match the AWS Cloud benefit to its impact on resource management.',
  'matching',
  '{"A":"On-demand resources","B":"Managed services","C":"Self-service portal"}'::json,
  NULL,
  'On-demand resources (left[0]) allow users to provision computing resources instantly as needed, without long-term commitments (right[0]). Managed services (left[1]) offload the operational burden of infrastructure management, patching, and backups to AWS (right[1]). The self-service portal (left[2]), typically the AWS Management Console, empowers users to provision and manage their own resources independently (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  16,
  '{"left":["On-demand resources","Managed services","Self-service portal"],"right":["Provision resources instantly as needed.","Offload operational burden to AWS.","Empower users to provision their own resources."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_126',
  'Match each AWS Cloud benefit to its primary characteristic.',
  'matching',
  '{"A":"Economies of Scale","B":"Agility","C":"High Availability","D":"Pay-as-you-go"}'::json,
  NULL,
  'Economies of Scale (left[0]) refers to the cost advantages AWS passes to customers due to its massive infrastructure (right[0]). Agility (left[1]) is the ability to rapidly develop, test, and deploy applications (right[1]). High Availability (left[2]) ensures applications remain operational despite failures (right[2]). The Pay-as-you-go model (left[3]) means customers only pay for the services they use, avoiding upfront capital expenditure (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  17,
  '{"left":["Economies of Scale","Agility","High Availability","Pay-as-you-go"],"right":["Cost savings from large-scale infrastructure","Ability to innovate and deploy quickly","Designing systems to withstand component failures","Paying only for consumed resources"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_127',
  'Match the AWS Cloud benefit with its description regarding global reach.',
  'matching',
  '{"A":"Global Infrastructure","B":"Elasticity","C":"Fault Tolerance","D":"Total Cost of Ownership (TCO)"}'::json,
  NULL,
  'Global Infrastructure (left[0]) allows for rapid deployment across multiple geographic regions, ensuring low latency for users globally (right[0]). Elasticity (left[1]) is the ability to automatically acquire and release compute capacity to match demand (right[1]). Fault Tolerance (left[2]) is a design principle that enables systems to continue functioning even if some components fail (right[2]). Total Cost of Ownership (TCO) (left[3]) is a financial estimation that helps compare the direct and indirect costs of different infrastructure options (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  18,
  '{"left":["Global Infrastructure","Elasticity","Fault Tolerance","Total Cost of Ownership (TCO)"],"right":["Deploying applications worldwide in minutes with low latency","Automatically scaling resources up or down based on demand","Building systems that can continue operating despite failures","Comparing the overall cost of on-premises vs. cloud infrastructure"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_128',
  'Match the AWS Cloud benefit to its impact on business operations.',
  'matching',
  '{"A":"Increased Speed and Agility","B":"Eliminate Guessing Capacity","C":"Cost Savings","D":"Global Reach"}'::json,
  NULL,
  'Increased Speed and Agility (left[0]) directly translates to faster innovation and deployment cycles (right[0]). Eliminating Guessing Capacity (left[1]) is achieved through cloud elasticity and auto-scaling, preventing over or under-provisioning (right[1]). Cost Savings (left[2]) are realized through the pay-as-you-go model and economies of scale, reducing both CapEx and OpEx (right[2]). Global Reach (left[3]) allows businesses to deploy their applications closer to their customers worldwide, improving performance and user experience (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  19,
  '{"left":["Increased Speed and Agility","Eliminate Guessing Capacity","Cost Savings","Global Reach"],"right":["Faster innovation and deployment cycles","Automatic scaling to match demand without over-provisioning","Reduced capital expenditure and operational costs","Deploying applications to users around the world quickly"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_129',
  'Match the AWS Cloud benefit to how it addresses traditional IT challenges.',
  'matching',
  '{"A":"High Availability","B":"Elasticity","C":"Fault Tolerance","D":"Cost Optimization"}'::json,
  NULL,
  'High Availability (left[0]) directly addresses the challenge of system downtime by ensuring continuous operation (right[0]). Elasticity (left[1]) solves the problem of over- or under-provisioning by dynamically adjusting resources (right[1]). Fault Tolerance (left[2]) is a design principle that enables systems to automatically recover from unexpected outages, minimizing impact (right[2]). Cost Optimization (left[3]) helps overcome high upfront capital expenditures by shifting to a pay-as-you-go model (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  20,
  '{"left":["High Availability","Elasticity","Fault Tolerance","Cost Optimization"],"right":["Ensuring continuous operation despite component failures","Dynamically adjusting compute resources to meet fluctuating demand","Designing systems to automatically recover from unexpected outages","Reducing expenses by paying only for what is used"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_130',
  'Match the AWS Cloud benefit with its contribution to business innovation.',
  'matching',
  '{"A":"Experimentation","B":"Reduced Time-to-Market","C":"Global Deployment","D":"Focus on Business Value"}'::json,
  NULL,
  'Experimentation (left[0]) is enhanced by the cloud''s ability to provision and de-provision resources on demand, allowing quick testing of ideas (right[0]). Reduced Time-to-Market (left[1]) is a direct result of increased agility and faster deployment cycles in the cloud (right[1]). Global Deployment (left[2]) allows businesses to expand their reach and serve customers in new regions without significant upfront investment (right[2]). Focusing on Business Value (left[3]) is achieved by offloading infrastructure management to AWS, freeing up resources for core business activities (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  21,
  '{"left":["Experimentation","Reduced Time-to-Market","Global Deployment","Focus on Business Value"],"right":["Ability to quickly test new ideas with minimal cost","Accelerated delivery of new products and features","Reaching customers in new geographic locations rapidly","Shifting resources from infrastructure management to core business"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_131',
  'Match the AWS Cloud benefit to its operational advantage.',
  'matching',
  '{"A":"Operational Excellence","B":"Security","C":"Reliability","D":"Performance Efficiency"}'::json,
  NULL,
  'Operational Excellence (left[0]) focuses on running and monitoring systems effectively to deliver business value (right[0]). Security (left[1]) is about protecting information, systems, and assets while delivering business value (right[1]). Reliability (left[2]) ensures a workload performs its intended function correctly and consistently (right[2]). Performance Efficiency (left[3]) involves using computing resources efficiently to meet system requirements and maintain that efficiency as demand changes (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  22,
  '{"left":["Operational Excellence","Security","Reliability","Performance Efficiency"],"right":["Running and monitoring systems to deliver business value","Protecting data, systems, and assets","Ensuring a workload performs its intended function correctly and consistently","Using computing resources efficiently to meet requirements"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_132',
  'Match the AWS Cloud benefit with its definition related to resource management.',
  'matching',
  '{"A":"Elasticity","B":"Scalability","C":"Disposable Resources","D":"Infrastructure as Code"}'::json,
  NULL,
  'Elasticity (left[0]) is the ability to automatically adjust capacity to meet demand, scaling both up and down (right[0]). Scalability (left[1]) refers to the ability of a system to handle a growing amount of work by adding resources (right[1]). Disposable Resources (left[2]) is a design principle where infrastructure components are treated as temporary and can be easily replaced or terminated (right[2]). Infrastructure as Code (left[3]) is the practice of managing and provisioning infrastructure through machine-readable definition files, rather than manual hardware configuration (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  23,
  '{"left":["Elasticity","Scalability","Disposable Resources","Infrastructure as Code"],"right":["Automatically adjusting capacity to meet demand","Handling increased load by adding resources","Treating infrastructure components as temporary and replaceable","Managing and provisioning infrastructure through code"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_1_133',
  'Match the AWS Cloud benefit to its role in reducing operational burden.',
  'matching',
  '{"A":"Managed Services","B":"Automation","C":"Shared Responsibility Model","D":"Global Infrastructure"}'::json,
  NULL,
  'Managed Services (left[0]) reduce operational burden by offloading tasks like patching, backups, and scaling to AWS (right[0]). Automation (left[1]) minimizes manual effort in cloud deployments and operations, leading to consistency and efficiency (right[1]). The Shared Responsibility Model (left[2]) clarifies which security tasks AWS manages (''security of the cloud'') and which the customer manages (''security in the cloud'') (right[2]). Global Infrastructure (left[3]) provides a vast network of data centers, enabling high availability and disaster recovery, but its primary role isn''t direct operational burden reduction for specific tasks (right[3] describes it accurately but it''s not the best fit for ''reducing operational burden'' compared to the others).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  24,
  '{"left":["Managed Services","Automation","Shared Responsibility Model","Global Infrastructure"],"right":["Offloading operational tasks to AWS","Minimizing manual effort in deployments and operations","Defining security responsibilities between AWS and the customer","Providing a worldwide network of data centers"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_60_4
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_76',
  'Match the AWS Well-Architected Framework pillar to its core focus.',
  'matching',
  '{"A":"Operational Excellence","B":"Security","C":"Reliability"}'::json,
  NULL,
  'Operational Excellence (left[0]) focuses on performing operations as code and continuously improving procedures (right[1]). Security (left[1]) is about protecting information, systems, and assets (right[2]). Reliability (left[2]) is the ability of a system to recover from infrastructure or service disruptions (right[0]) and dynamically acquire computing resources to meet demand.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  25,
  '{"left":["Operational Excellence","Security","Reliability"],"right":["Ability of a system to recover from infrastructure or service disruptions","Performing operations as code and continuously improving procedures","Protecting information, systems, and assets"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_77',
  'Match the AWS Well-Architected Framework pillar to its objective.',
  'matching',
  '{"A":"Performance Efficiency","B":"Cost Optimization","C":"Sustainability"}'::json,
  NULL,
  'Performance Efficiency (left[0]) focuses on using computing resources efficiently to meet system requirements (right[2]) and maintaining efficiency as demand changes. Cost Optimization (left[1]) is about running systems to deliver business value at the lowest price point (right[0]). Sustainability (left[2]) is the pillar focused on minimizing the environmental impacts of running cloud workloads (right[1]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  26,
  '{"left":["Performance Efficiency","Cost Optimization","Sustainability"],"right":["Running systems to deliver business value at the lowest price point","Minimizing the environmental impacts of running cloud workloads","Using computing resources efficiently to meet system requirements"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_78',
  'Match the AWS Cloud design principle to its description.',
  'matching',
  '{"A":"Design for Failure","B":"Decouple Components","C":"Implement Elasticity"}'::json,
  NULL,
  'Design for Failure (left[0]) means to assume that any component can fail at any time (right[1]) and design your system to handle such events gracefully. Decouple Components (left[1]) involves breaking down monolithic applications into smaller, independent services (right[2]) to improve resilience and scalability. Implement Elasticity (left[2]) is to build systems that can automatically scale up or down (right[0]) to meet varying demand.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  27,
  '{"left":["Design for Failure","Decouple Components","Implement Elasticity"],"right":["Build systems that can automatically scale up or down","Assume that any component can fail at any time","Break down monolithic applications into smaller, independent services"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_79',
  'Match the AWS Cloud operational concept to its benefit.',
  'matching',
  '{"A":"Automation","B":"Disposable Resources","C":"Infrastructure as Code"}'::json,
  NULL,
  'Automation (left[0]) helps in reducing manual effort and human error in operations (right[2]), leading to more consistent deployments. Disposable Resources (left[1]) refers to treating infrastructure as temporary and easily replaceable (right[0]), enabling rapid scaling and recovery. Infrastructure as Code (left[2]) is the practice of managing and provisioning infrastructure through code (right[1]) rather than manual processes, ensuring consistency and version control.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  28,
  '{"left":["Automation","Disposable Resources","Infrastructure as Code"],"right":["Treating infrastructure as temporary and easily replaceable","Managing and provisioning infrastructure through code","Reducing manual effort and human error in operations"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_80',
  'Match the AWS design principle to its application.',
  'matching',
  '{"A":"Think Parallel","B":"Automation","C":"Infrastructure as Code"}'::json,
  NULL,
  'Think Parallel (left[0]) involves distributing workloads across multiple resources to improve performance (right[2]) and resilience. Automation (left[1]) refers to performing tasks programmatically to reduce manual effort (right[1]) and ensure consistency. Infrastructure as Code (left[2]) is the practice of managing and provisioning resources through version-controlled scripts (right[0]), promoting repeatability and traceability.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  29,
  '{"left":["Think Parallel","Automation","Infrastructure as Code"],"right":["Managing and provisioning resources through version-controlled scripts","Performing tasks programmatically to reduce manual effort","Distributing workloads across multiple resources to improve performance"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_81',
  'Match the AWS Well-Architected Tool feature to its purpose.',
  'matching',
  '{"A":"Review Workloads","B":"Identify Risks","C":"Improve Architectures"}'::json,
  NULL,
  'The AWS Well-Architected Tool allows users to Review Workloads (left[0]) by evaluating existing or new cloud designs against best practices (right[1]). It helps to Identify Risks (left[1]) by highlighting areas that deviate from best practices (right[2]). Ultimately, it helps to Improve Architectures (left[2]) by providing recommendations to enhance cloud designs (right[0]) across the six pillars.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  30,
  '{"left":["Review Workloads","Identify Risks","Improve Architectures"],"right":["Provides recommendations to enhance cloud designs","Evaluates existing or new cloud designs against best practices","Highlights areas that deviate from best practices"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_82',
  'Match the AWS Cloud infrastructure concept to its definition.',
  'matching',
  '{"A":"Multi-AZ Deployment","B":"Auto Scaling","C":"Infrastructure as Code"}'::json,
  NULL,
  'Multi-AZ Deployment (left[0]) involves distributing resources across multiple Availability Zones for resilience (right[2]) against single points of failure. Auto Scaling (left[1]) automatically adjusts compute capacity to maintain performance (right[0]) and cost efficiency. Infrastructure as Code (left[2]) is the practice of managing infrastructure through configuration files (right[1]), rather than manual processes.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  31,
  '{"left":["Multi-AZ Deployment","Auto Scaling","Infrastructure as Code"],"right":["Automatically adjusts compute capacity to maintain performance","Managing infrastructure through configuration files","Distributing resources across multiple Availability Zones for resilience"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_83',
  'Match the reliability concept to its goal in the cloud.',
  'matching',
  '{"A":"Fault Tolerance","B":"High Availability","C":"Disaster Recovery"}'::json,
  NULL,
  'Fault Tolerance (left[0]) aims at ensuring continuous operation despite component failures (right[0]). High Availability (left[1]) focuses on maintaining application uptime and accessibility (right[1]) to users. Disaster Recovery (left[2]) is the process of restoring operations after a major outage (right[2]) or catastrophic event.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  32,
  '{"left":["Fault Tolerance","High Availability","Disaster Recovery"],"right":["Ensuring continuous operation despite component failures","Maintaining application uptime and accessibility","Restoring operations after a major outage"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_84',
  'Match the AWS design principle to its core idea.',
  'matching',
  '{"A":"Operational Excellence","B":"Security","C":"Reliability"}'::json,
  NULL,
  'Operational Excellence (left[0]) focuses on running and monitoring systems to deliver business value (right[2]) effectively. Security (left[1]) is about protecting data and systems (right[0]) from threats and unauthorized access. Reliability (left[2]) ensures a system works consistently and recovers from failure (right[1]), maintaining availability.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  33,
  '{"left":["Operational Excellence","Security","Reliability"],"right":["Protecting data and systems","Ensuring a system works consistently and recovers from failure","Running and monitoring systems to deliver business value"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_85',
  'Match each pillar of the AWS Well-Architected Framework to its focus area.',
  'matching',
  '{"A":"Security","B":"Reliability","C":"Cost Optimization"}'::json,
  NULL,
  'The Security pillar (left[0]) focuses on protecting information, systems, and assets while delivering business value (right[0]). The Reliability pillar (left[1]) ensures a workload performs its intended function correctly and consistently when expected (right[1]). The Cost Optimization pillar (left[2]) is about avoiding unnecessary costs and maximizing business value by managing expenses (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  34,
  '{"left":["Security","Reliability","Cost Optimization"],"right":["Protecting information, systems, and assets.","Ensuring a workload performs its intended function correctly and consistently.","Avoiding unnecessary costs and maximizing business value."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_86',
  'Match each pillar of the AWS Well-Architected Framework to its primary goal.',
  'matching',
  '{"A":"Operational Excellence","B":"Performance Efficiency","C":"Sustainability"}'::json,
  NULL,
  'The Operational Excellence pillar (left[0]) focuses on running and monitoring systems to deliver business value and continuously improve processes (right[0]). The Performance Efficiency pillar (left[1]) is about using computing resources efficiently to meet system requirements and maintain efficiency as demand changes (right[1]). The Sustainability pillar (left[2]) focuses on minimizing the environmental impacts of running cloud workloads (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  35,
  '{"left":["Operational Excellence","Performance Efficiency","Sustainability"],"right":["Run and monitor systems to deliver business value.","Use computing resources efficiently to meet requirements.","Minimize environmental impacts of running cloud workloads."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_87',
  'Match the AWS Cloud design principle to its implementation strategy.',
  'matching',
  '{"A":"Design for failure","B":"Decouple components","C":"Implement elasticity"}'::json,
  NULL,
  'Designing for failure (left[0]) means anticipating and planning for component failures rather than trying to prevent them, building resilience into the architecture (right[0]). Decoupling components (left[1]) involves building systems where components can operate independently, reducing cascading failures (right[1]). Implementing elasticity (left[2]) means automatically scaling resources up or down based on demand, optimizing performance and cost (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  36,
  '{"left":["Design for failure","Decouple components","Implement elasticity"],"right":["Anticipate and plan for component failures.","Build systems where components can operate independently.","Automatically scale resources based on demand."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_88',
  'Match the cloud design concept to its benefit.',
  'matching',
  '{"A":"Automation","B":"Infrastructure as Code","C":"Disposable resources"}'::json,
  NULL,
  'Automation (left[0]) helps reduce manual effort, increase speed, and minimize human error in cloud deployments and operations (right[0]). Infrastructure as Code (left[1]) allows managing and provisioning infrastructure using machine-readable definition files, enabling version control and reproducibility (right[1]). Disposable resources (left[2]) promote treating servers as cattle, not pets, meaning they can be easily replaced rather than manually maintained, supporting auto-scaling and disaster recovery (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  37,
  '{"left":["Automation","Infrastructure as Code","Disposable resources"],"right":["Reduce manual effort and human error.","Manage and provision infrastructure using code.","Treat servers as cattle, not pets, for easy replacement."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_89',
  'Match the AWS design principle to its reliability aspect.',
  'matching',
  '{"A":"Multi-AZ deployment","B":"Auto Scaling","C":"Fault isolation"}'::json,
  NULL,
  'Multi-AZ deployment (left[0]) is a design principle that involves distributing resources across multiple Availability Zones to achieve high availability and fault tolerance (right[0]). Auto Scaling (left[1]) automatically adjusts compute capacity to maintain application performance and availability (right[1]). Fault isolation (left[2]) is a design principle that aims to prevent failures in one component or part of a system from affecting other components (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  38,
  '{"left":["Multi-AZ deployment","Auto Scaling","Fault isolation"],"right":["Distribute resources across multiple Availability Zones.","Automatically adjust compute capacity to maintain performance.","Prevent failures in one component from affecting others."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_90',
  'Match the AWS design principle to its performance aspect.',
  'matching',
  '{"A":"Think parallel","B":"Decouple services","C":"Use managed services"}'::json,
  NULL,
  'Thinking parallel (left[0]) involves designing systems to process tasks concurrently, which leads to faster execution and improved performance (right[0]). Decoupling services (left[1]) allows individual services to scale and fail independently, improving overall system resilience and performance (right[1]). Using managed services (left[2]) leverages AWS''s optimized and maintained infrastructure, often leading to better performance and reduced operational overhead (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  39,
  '{"left":["Think parallel","Decouple services","Use managed services"],"right":["Process tasks concurrently for faster execution.","Allow services to scale and fail independently.","Leverage AWS optimized and maintained infrastructure."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_91',
  'Match the AWS Well-Architected Framework security principle to its practice.',
  'matching',
  '{"A":"Least privilege","B":"Defense in depth","C":"Traceability"}'::json,
  NULL,
  'The principle of least privilege (left[0]) dictates granting only the necessary permissions for a specific task or user (right[0]). Defense in depth (left[1]) involves applying multiple security controls across different layers of an architecture to provide comprehensive protection (right[1]). Traceability (left[2]) refers to the ability to monitor, alert, and audit actions and changes within the AWS environment, ensuring accountability and compliance (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  40,
  '{"left":["Least privilege","Defense in depth","Traceability"],"right":["Grant only necessary permissions for a task.","Apply multiple security controls across layers.","Monitor, alert, and audit actions and changes."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_92',
  'Match the AWS design principle to its operational benefit.',
  'matching',
  '{"A":"Automation","B":"Monitoring","C":"Event-driven architecture"}'::json,
  NULL,
  'Automation (left[0]) reduces manual tasks, improves consistency, and accelerates deployments (right[0]). Monitoring (left[1]) provides crucial visibility into system health, performance, and operational metrics (right[1]). An event-driven architecture (left[2]) enables systems to respond to changes and events in real time, promoting loose coupling and scalability (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  41,
  '{"left":["Automation","Monitoring","Event-driven architecture"],"right":["Reduce manual tasks and improve consistency.","Gain visibility into system health and performance.","Respond to changes and events in real time."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_93',
  'Match each pillar of the AWS Well-Architected Framework to its core focus.',
  'matching',
  '{"A":"Operational Excellence","B":"Security","C":"Reliability","D":"Performance Efficiency"}'::json,
  NULL,
  'The AWS Well-Architected Framework provides guidance on designing and operating reliable, secure, efficient, and cost-effective systems in the cloud. Operational Excellence (left[0]) focuses on running and monitoring systems (right[0]). Security (left[1]) is about protecting data and systems (right[1]). Reliability (left[2]) ensures the system performs consistently (right[2]). Performance Efficiency (left[3]) is about using resources optimally (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  42,
  '{"left":["Operational Excellence","Security","Reliability","Performance Efficiency"],"right":["Running and monitoring systems to deliver business value","Protecting information, systems, and assets","Ensuring a workload performs its intended function correctly and consistently","Using computing resources efficiently to meet requirements"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_94',
  'Match the AWS Well-Architected Framework pillar to its key design area.',
  'matching',
  '{"A":"Cost Optimization","B":"Sustainability","C":"Operational Excellence","D":"Security"}'::json,
  NULL,
  'Cost Optimization (left[0]) focuses on avoiding unneeded costs and maximizing ROI (right[0]). Sustainability (left[1]) is about minimizing environmental impacts (right[1]). Operational Excellence (left[2]) emphasizes automating changes and responding to events effectively (right[2]). Security (left[3]) involves implementing a strong identity foundation and protecting systems (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  43,
  '{"left":["Cost Optimization","Sustainability","Operational Excellence","Security"],"right":["Avoiding unneeded costs and maximizing return on investment","Minimizing the environmental impacts of running cloud workloads","Automating changes and responding to events","Implementing a strong identity foundation"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_95',
  'Match the AWS design principle to its core concept.',
  'matching',
  '{"A":"Design for Failure","B":"Decouple Components","C":"Implement Elasticity","D":"Think Parallel"}'::json,
  NULL,
  'Designing for Failure (left[0]) means anticipating and planning for potential component failures to ensure system resilience (right[0]). Decoupling Components (left[1]) involves building systems where individual parts can operate and fail independently without impacting the entire system (right[1]). Implementing Elasticity (left[2]) refers to designing systems that can automatically scale resources to match fluctuating demand (right[2]). Thinking Parallel (left[3]) is about designing workloads to process multiple tasks concurrently, improving performance and throughput (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  44,
  '{"left":["Design for Failure","Decouple Components","Implement Elasticity","Think Parallel"],"right":["Anticipate and plan for component failures","Build systems where components operate independently","Automatically scale resources up or down with demand","Process multiple tasks concurrently for efficiency"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_96',
  'Match the AWS Cloud design principle to its benefit for system resilience.',
  'matching',
  '{"A":"Automation","B":"Disposable Resources","C":"Infrastructure as Code","D":"Multi-AZ Deployment"}'::json,
  NULL,
  'Automation (left[0]) reduces human error and increases operational efficiency by performing tasks programmatically (right[0]). Disposable Resources (left[1]) refers to the practice of treating infrastructure components as temporary and easily replaceable, which aids in faster recovery from failures (right[1]). Infrastructure as Code (left[2]) ensures consistent and repeatable infrastructure provisioning, reducing configuration drift and errors (right[2]). Multi-AZ Deployment (left[3]) is a key strategy for high availability, distributing workloads across physically separate Availability Zones to protect against single points of failure (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  45,
  '{"left":["Automation","Disposable Resources","Infrastructure as Code","Multi-AZ Deployment"],"right":["Reducing human error and increasing operational efficiency","Treating servers as temporary and replaceable for easier recovery","Ensuring consistent and repeatable infrastructure provisioning","Distributing workloads across physically separate locations for high availability"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_97',
  'Match the AWS Well-Architected Tool feature to its primary function.',
  'matching',
  '{"A":"Workload Reviews","B":"Custom Lenses","C":"Improvement Plans","D":"Best Practices"}'::json,
  NULL,
  'The AWS Well-Architected Tool helps customers review the state of their workloads. Workload Reviews (left[0]) are used for assessing workloads against the framework''s best practices (right[0]). Custom Lenses (left[1]) allow users to extend the framework with their own domain-specific guidance (right[1]). Improvement Plans (left[2]) provide actionable recommendations to address identified risks and improve the workload (right[2]). Best Practices (left[3]) are the guiding principles and recommendations provided by the framework across its six pillars (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  46,
  '{"left":["Workload Reviews","Custom Lenses","Improvement Plans","Best Practices"],"right":["Assessing workloads against architectural best practices","Extending the framework with domain-specific guidance","Providing actionable recommendations to address risks","Guiding principles for designing and operating systems"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_98',
  'Match the AWS design principle to its impact on system scalability.',
  'matching',
  '{"A":"Horizontal Scaling","B":"Vertical Scaling","C":"Loose Coupling","D":"Stateless Components"}'::json,
  NULL,
  'Horizontal Scaling (left[0]) involves adding more instances of a resource to distribute the load, which is highly effective for cloud scalability (right[0]). Vertical Scaling (left[1]) means increasing the size or capacity of a single instance, which has inherent limits (right[1]). Loose Coupling (left[2]) is a design principle that allows components to operate and scale independently, improving overall system resilience and scalability (right[2]). Stateless Components (left[3]) are designed not to store session-specific data, making them easier to scale horizontally and replace (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  47,
  '{"left":["Horizontal Scaling","Vertical Scaling","Loose Coupling","Stateless Components"],"right":["Adding more instances to distribute load","Increasing the size of a single instance","Allowing components to operate and scale independently","Designing components that do not store session data"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_99',
  'Match the AWS Well-Architected Framework pillar with its goal for cloud operations.',
  'matching',
  '{"A":"Reliability","B":"Performance Efficiency","C":"Cost Optimization","D":"Sustainability"}'::json,
  NULL,
  'Reliability (left[0]) aims for the ability of a system to recover from infrastructure or service disruptions (right[0]). Performance Efficiency (left[1]) focuses on maintaining efficiency as demand changes and evolving technologies (right[1]). Cost Optimization (left[2]) seeks to achieve business outcomes at the lowest price point, primarily by paying only for consumed resources (right[2]). Sustainability (left[3]) is concerned with reducing energy consumption and resource usage across the entire workload lifecycle (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  48,
  '{"left":["Reliability","Performance Efficiency","Cost Optimization","Sustainability"],"right":["Recovering from infrastructure or service disruptions","Maintaining efficiency as demand changes","Paying only for resources consumed","Reducing energy consumption and resource usage"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_4_100',
  'Match the AWS design principle to its approach for managing infrastructure.',
  'matching',
  '{"A":"Automation","B":"Infrastructure as Code","C":"Version Control","D":"Monitoring and Alerting"}'::json,
  NULL,
  'Automation (left[0]) is a core principle for performing tasks programmatically, reducing manual effort and potential errors (right[0]). Infrastructure as Code (left[1]) involves defining infrastructure resources in configuration files, enabling consistent and repeatable deployments (right[1]). Version Control (left[2]) is crucial for tracking changes to these infrastructure definitions, allowing for rollbacks and collaboration (right[2]). Monitoring and Alerting (left[3]) are essential for observing system behavior, detecting anomalies, and notifying operators of potential issues (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  49,
  '{"left":["Automation","Infrastructure as Code","Version Control","Monitoring and Alerting"],"right":["Performing tasks programmatically to reduce manual effort","Defining infrastructure resources in configuration files","Tracking changes to infrastructure definitions over time","Observing system behavior and notifying of issues"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_60_3
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_55',
  'Match the AWS Cloud economic concept to its definition.',
  'matching',
  '{"A":"Capital Expenditure (CapEx)","B":"Operational Expenditure (OpEx)","C":"Total Cost of Ownership (TCO)"}'::json,
  NULL,
  'Capital Expenditure (CapEx) (left[0]) involves upfront spending on physical infrastructure (right[1]), such as servers and data centers. Operational Expenditure (OpEx) (left[1]) refers to ongoing costs for running a business (right[0]), like electricity or cloud service subscriptions. Total Cost of Ownership (TCO) (left[2]) is the overall cost of acquiring, operating, and maintaining IT systems (right[2]) over their lifespan.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  50,
  '{"left":["Capital Expenditure (CapEx)","Operational Expenditure (OpEx)","Total Cost of Ownership (TCO)"],"right":["Ongoing costs for running a business, like utility bills","Upfront spending on physical infrastructure","Overall cost of acquiring, operating, and maintaining IT systems"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_56',
  'Match the cost optimization strategy to its description.',
  'matching',
  '{"A":"Right-sizing","B":"Managed Services","C":"Pay-as-you-go"}'::json,
  NULL,
  'Right-sizing (left[0]) involves selecting the most appropriate instance types and sizes for workloads (right[1]) to avoid over-provisioning. Managed Services (left[1]) like Amazon RDS or AWS Lambda help optimize costs by offloading operational responsibilities to AWS (right[2]). Pay-as-you-go (left[2]) is a pricing model where you pay only for the compute, storage, and other resources consumed (right[0]), with no long-term contracts or upfront commitments.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  51,
  '{"left":["Right-sizing","Managed Services","Pay-as-you-go"],"right":["Paying only for the compute, storage, and other resources consumed","Selecting the most appropriate instance types and sizes for workloads","Offloading operational responsibilities to AWS"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_57',
  'Match the AWS pricing model to its characteristic.',
  'matching',
  '{"A":"On-Demand Instances","B":"Reserved Instances","C":"Spot Instances"}'::json,
  NULL,
  'On-Demand Instances (left[0]) allow you to pay for compute capacity by the hour or second with no long-term commitment (right[1]). Reserved Instances (left[1]) offer significant discounts for committing to 1 or 3 years of usage (right[0]) for a specific instance type. Spot Instances (left[2]) enable you to bid on unused EC2 capacity for steep discounts (right[2]), suitable for fault-tolerant workloads.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  52,
  '{"left":["On-Demand Instances","Reserved Instances","Spot Instances"],"right":["Significant discounts for committing to 1 or 3 years of usage","Pay for compute capacity by the hour or second with no long-term commitment","Bid on unused EC2 capacity for steep discounts"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_58',
  'Match the AWS cost management tool to its primary function.',
  'matching',
  '{"A":"AWS Pricing Calculator","B":"AWS Budgets","C":"AWS Cost Explorer"}'::json,
  NULL,
  'AWS Pricing Calculator (left[0]) helps users plan and estimate costs for new AWS solutions (right[1]). AWS Budgets (left[1]) allows customers to set custom cost and usage alerts (right[2]) to stay within their spending limits. AWS Cost Explorer (left[2]) enables users to visualize and manage their AWS costs and usage over time (right[0]), identifying trends and opportunities for optimization.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  53,
  '{"left":["AWS Pricing Calculator","AWS Budgets","AWS Cost Explorer"],"right":["Visualize and manage your AWS costs and usage over time","Plan and estimate costs for new AWS solutions","Set custom cost and usage alerts"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_59',
  'Match the AWS Cloud economic benefit to its characteristic.',
  'matching',
  '{"A":"Reduced Fixed Costs","B":"Economies of Scale","C":"Optimized Return on Investment (ROI)"}'::json,
  NULL,
  'Reduced Fixed Costs (left[0]) is a benefit of converting large upfront expenses into variable costs (right[2]) in the cloud. Economies of Scale (left[1]) result in a lower per-unit cost due to large infrastructure (right[1]) that AWS passes on to customers. Optimized Return on Investment (ROI) (left[2]) means achieving maximum value from cloud spending (right[0]) by leveraging cloud benefits.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  54,
  '{"left":["Reduced Fixed Costs","Economies of Scale","Optimized Return on Investment (ROI)"],"right":["Achieving maximum value from cloud spending","Lower per-unit cost due to large infrastructure","Converting large upfront expenses into variable costs"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_60',
  'Match the resource utilization concept to its cloud characteristic.',
  'matching',
  '{"A":"Elasticity","B":"Scalability","C":"Metering"}'::json,
  NULL,
  'Elasticity (left[0]) refers to the automatic adjustment of resources based on demand (right[2]), ensuring optimal resource use. Scalability (left[1]) is the ability to handle increasing workload by adding resources (right[1]), either vertically or horizontally. Metering (left[2]) is the process of measuring resource consumption for billing (right[0]), enabling the pay-as-you-go model.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  55,
  '{"left":["Elasticity","Scalability","Metering"],"right":["Measuring resource consumption for billing","Ability to handle increasing workload by adding resources","Automatic adjustment of resources based on demand"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_61',
  'Match the financial benefit of the AWS Cloud to its description.',
  'matching',
  '{"A":"No Upfront Investment","B":"Variable Costs","C":"Reduced Waste"}'::json,
  NULL,
  'No Upfront Investment (left[0]) means eliminating the need for large initial capital outlays (right[1]) for infrastructure. Variable Costs (left[1]) are costs that fluctuate based on usage (right[2]), allowing businesses to pay only for what they need. Reduced Waste (left[2]) is achieved by paying only for what is consumed, avoiding idle resources (right[0]) and maximizing efficiency.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  56,
  '{"left":["No Upfront Investment","Variable Costs","Reduced Waste"],"right":["Paying only for what is consumed, avoiding idle resources","Eliminating the need for large initial capital outlays","Costs that fluctuate based on usage"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_62',
  'Match the cost concept to its definition.',
  'matching',
  '{"A":"Capital Expenditure (CapEx)","B":"Operational Expenditure (OpEx)","C":"Total Cost of Ownership (TCO)"}'::json,
  NULL,
  'Capital Expenditure (CapEx) (left[0]) refers to upfront spending on physical infrastructure, such as servers and data centers (right[0]). Operational Expenditure (OpEx) (left[1]) represents ongoing costs for running and maintaining systems, like utilities and software licenses (right[1]). Total Cost of Ownership (TCO) (left[2]) is the overall cost of owning and operating IT infrastructure, including both direct and indirect costs (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  57,
  '{"left":["Capital Expenditure (CapEx)","Operational Expenditure (OpEx)","Total Cost of Ownership (TCO)"],"right":["Upfront spending on physical infrastructure.","Ongoing costs for running and maintaining systems.","Overall cost of owning and operating IT infrastructure."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_63',
  'Match the AWS cost optimization strategy to its approach.',
  'matching',
  '{"A":"Right-sizing","B":"Managed services","C":"Automation"}'::json,
  NULL,
  'Right-sizing (left[0]) is a cost optimization strategy that involves matching instance types and sizes to the actual workload performance and capacity needs (right[0]). Utilizing managed services (left[1]) helps optimize costs by offloading infrastructure management, patching, and backups to AWS, reducing operational overhead (right[1]). Automation (left[2]) through tools like AWS CloudFormation helps reduce manual effort, human error, and ensures consistent, cost-effective deployments (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  58,
  '{"left":["Right-sizing","Managed services","Automation"],"right":["Matching instance types and sizes to workload needs.","Offloading infrastructure management to AWS.","Using Infrastructure as Code to reduce manual effort."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_64',
  'Match the AWS pricing model to its typical use case.',
  'matching',
  '{"A":"On-Demand","B":"Reserved Instances","C":"Spot Instances"}'::json,
  NULL,
  'On-Demand pricing (left[0]) is suitable for workloads with unpredictable usage patterns or for testing new applications, as you pay for compute capacity by the hour or second (right[0]). Reserved Instances (left[1]) offer significant discounts for workloads with steady-state or predictable usage, committed for 1 or 3 years (right[1]). Spot Instances (left[2]) are ideal for fault-tolerant workloads that can tolerate interruptions, offering the largest discounts by bidding on unused EC2 capacity (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  59,
  '{"left":["On-Demand","Reserved Instances","Spot Instances"],"right":["Workloads with unpredictable usage patterns.","Workloads with steady-state or predictable usage.","Fault-tolerant workloads that can tolerate interruptions."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_65',
  'Match the licensing approach to its characteristic in the cloud.',
  'matching',
  '{"A":"BYOL (Bring Your Own License)","B":"Included licenses","C":"Open-source software"}'::json,
  NULL,
  'Bring Your Own License (BYOL) (left[0]) allows customers to use their existing software licenses on AWS, potentially saving costs on new licenses (right[0]). Included licenses (left[1]) are those where the software license costs are bundled directly into the AWS service costs, simplifying billing (right[1]). Open-source software (left[2]) allows customers to leverage community-driven, free software, often reducing licensing costs significantly (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  60,
  '{"left":["BYOL (Bring Your Own License)","Included licenses","Open-source software"],"right":["Use existing software licenses on AWS.","Licenses are bundled with AWS service costs.","Leverage community-driven, free software."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_66',
  'Match the cloud economic benefit to its description.',
  'matching',
  '{"A":"Reduced fixed costs","B":"Pay-as-you-go model","C":"Maximize ROI"}'::json,
  NULL,
  'Reduced fixed costs (left[0]) is a benefit where large capital expenditures are converted into variable costs, improving financial flexibility (right[0]). The pay-as-you-go model (left[1]) ensures that customers only pay for the specific resources they consume, avoiding wasted capacity (right[1]). Maximizing Return on Investment (ROI) (left[2]) is achieved by optimizing cloud spending and leveraging cloud benefits to achieve higher returns on cloud investments (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  61,
  '{"left":["Reduced fixed costs","Pay-as-you-go model","Maximize ROI"],"right":["Convert large capital expenditures to variable costs.","Only pay for the resources consumed.","Achieve higher returns on cloud investments."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_67',
  'Match the AWS cost management tool to its function.',
  'matching',
  '{"A":"AWS Pricing Calculator","B":"AWS Cost Explorer","C":"AWS Budgets"}'::json,
  NULL,
  'The AWS Pricing Calculator (left[0]) is used to estimate costs for new AWS deployments and services (right[0]). AWS Cost Explorer (left[1]) allows users to visualize, understand, and manage their AWS spending over time, analyzing historical and current patterns (right[1]). AWS Budgets (left[2]) enables setting custom cost and usage alerts to notify users when their costs or usage exceed predefined thresholds (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  62,
  '{"left":["AWS Pricing Calculator","AWS Cost Explorer","AWS Budgets"],"right":["Estimate costs for new AWS deployments.","Analyze historical and current spending patterns.","Set custom cost and usage alerts."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_68',
  'Match the resource optimization technique to its impact on cost.',
  'matching',
  '{"A":"Elasticity","B":"Serverless computing","C":"Storage tiers"}'::json,
  NULL,
  'Elasticity (left[0]) helps optimize costs by automatically scaling resources to match demand, thus avoiding over-provisioning and idle resources (right[0]). Serverless computing (left[1]), such as AWS Lambda, eliminates idle compute costs by only paying for the actual execution time of code (right[1]). Utilizing different Amazon S3 storage tiers (left[2]) allows moving infrequently accessed data to cheaper storage classes, significantly reducing storage costs (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  63,
  '{"left":["Elasticity","Serverless computing","Storage tiers"],"right":["Automatically scale resources to match demand, avoiding over-provisioning.","Eliminate idle compute costs by only paying for execution time.","Move infrequently accessed data to cheaper storage classes."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_69',
  'Match the cloud economic driver to its business outcome.',
  'matching',
  '{"A":"Agility","B":"Scalability","C":"Global footprint"}'::json,
  NULL,
  'Agility (left[0]) as an economic driver leads to a faster time-to-market for new products and services, accelerating revenue generation (right[0]). Scalability (left[1]) allows businesses to handle growth and fluctuating demand without major infrastructure changes, preventing costly over-provisioning or under-provisioning (right[1]). A global footprint (left[2]) enables businesses to expand their market reach and improve customer experience by deploying applications closer to users worldwide (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  64,
  '{"left":["Agility","Scalability","Global footprint"],"right":["Faster time-to-market for new products.","Handle growth without major infrastructure changes.","Expand market reach and improve customer experience."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_70',
  'Match the cloud economics concept to its definition.',
  'matching',
  '{"A":"Capital Expenditure (CapEx)","B":"Operational Expenditure (OpEx)","C":"Total Cost of Ownership (TCO)","D":"Pay-as-you-go Model"}'::json,
  NULL,
  'Capital Expenditure (CapEx) (left[0]) refers to upfront spending on physical infrastructure and assets (right[0]). Operational Expenditure (OpEx) (left[1]) represents ongoing costs for running and maintaining services, which is typical for cloud computing (right[1]). Total Cost of Ownership (TCO) (left[2]) is a comprehensive financial analysis comparing all direct and indirect costs of different infrastructure options (right[2]). The Pay-as-you-go Model (left[3]) is a fundamental cloud pricing principle where customers only pay for the specific computing resources they consume (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  65,
  '{"left":["Capital Expenditure (CapEx)","Operational Expenditure (OpEx)","Total Cost of Ownership (TCO)","Pay-as-you-go Model"],"right":["Upfront spending on physical infrastructure","Ongoing costs for running and maintaining services","Comprehensive financial comparison of cloud vs. on-premises","Paying only for the computing resources consumed"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_71',
  'Match the cost optimization strategy to its description.',
  'matching',
  '{"A":"Right-sizing","B":"Managed Services","C":"Economies of Scale","D":"Reserved Instances"}'::json,
  NULL,
  'Right-sizing (left[0]) is a cost optimization strategy that involves selecting the most appropriate instance types and sizes to meet workload needs efficiently (right[0]). Managed Services (left[1]), such as Amazon RDS, reduce operational costs by offloading infrastructure management tasks to AWS (right[1]). Economies of Scale (left[2]) allow AWS to offer lower prices to customers due to its massive infrastructure and large customer base (right[2]). Reserved Instances (left[3]) offer significant discounts for customers who commit to a specific compute capacity for a 1-year or 3-year term (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  66,
  '{"left":["Right-sizing","Managed Services","Economies of Scale","Reserved Instances"],"right":["Matching instance types and sizes to workload needs","Reducing operational costs by offloading infrastructure management","Achieving lower prices due to AWS''s large customer base","Committing to a specific compute capacity for a discounted rate"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_72',
  'Match the AWS tool or concept to its role in cloud economics.',
  'matching',
  '{"A":"AWS Pricing Calculator","B":"AWS Well-Architected Tool","C":"Cost Optimization Pillar","D":"Tagging"}'::json,
  NULL,
  'The AWS Pricing Calculator (left[0]) is a tool used to estimate the costs of various AWS services before deployment (right[0]). The AWS Well-Architected Tool (left[1]) helps identify areas for cost reduction by reviewing workloads against best practices, including the Cost Optimization Pillar (right[1]). The Cost Optimization Pillar (left[2]) itself is a key component of the Well-Architected Framework, specifically focused on minimizing expenses (right[2]). Tagging (left[3]) is a method for organizing and tracking AWS resources, which is crucial for cost allocation and management (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  67,
  '{"left":["AWS Pricing Calculator","AWS Well-Architected Tool","Cost Optimization Pillar","Tagging"],"right":["Estimating costs for AWS services","Identifying areas for cost reduction in workloads","A framework pillar focused on minimizing expenses","Organizing and tracking AWS resource costs"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_73',
  'Match the cost management practice to its objective.',
  'matching',
  '{"A":"Cost Allocation","B":"Budgeting","C":"Monitoring Costs","D":"Automated Shutdown"}'::json,
  NULL,
  'Cost Allocation (left[0]) involves using tags and other mechanisms to attribute AWS costs to specific departments, projects, or cost centers (right[0]). Budgeting (left[1]) is the process of setting spending limits and tracking actual expenditure against these limits to prevent overspending (right[1]). Monitoring Costs (left[2]) refers to continuously tracking resource usage and spending patterns in real-time to identify anomalies or areas for optimization (right[2]). Automated Shutdown (left[3]) is a cost-saving practice, especially for development and test environments, where resources are automatically stopped when not actively used (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  68,
  '{"left":["Cost Allocation","Budgeting","Monitoring Costs","Automated Shutdown"],"right":["Attributing costs to specific teams or projects","Setting spending limits and tracking against them","Tracking resource usage and spending in real-time","Automatically stopping non-production resources when not in use"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_74',
  'Match the cloud economics concept to its impact on financial planning.',
  'matching',
  '{"A":"Variable Costs","B":"Fixed Costs","C":"Forecasting","D":"Cost Visibility"}'::json,
  NULL,
  'Variable Costs (left[0]) are expenses that fluctuate based on the amount of AWS resources consumed, common in the cloud (right[0]). Fixed Costs (left[1]) are expenses that remain constant regardless of usage, more typical of on-premises infrastructure (right[1]). Forecasting (left[2]) involves using historical data and anticipated growth to estimate future cloud spending, aiding financial planning (right[2]). Cost Visibility (left[3]) is the ability to clearly see and understand where cloud spending is occurring, often achieved through AWS Cost Explorer and tagging (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  69,
  '{"left":["Variable Costs","Fixed Costs","Forecasting","Cost Visibility"],"right":["Costs that fluctuate with resource usage","Costs that remain constant regardless of usage","Estimating future cloud spending based on patterns","Understanding where cloud spending occurs"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_75',
  'Match the cost optimization principle to its application.',
  'matching',
  '{"A":"Trade CapEx for OpEx","B":"Benefit from massive economies of scale","C":"Stop spending money on data center operations","D":"Analyze and attribute expenditure"}'::json,
  NULL,
  'Trading CapEx for OpEx (left[0]) is a core cloud benefit, moving from large upfront investments to flexible, usage-based payments (right[0]). Benefiting from massive economies of scale (left[1]) means customers get lower prices due to AWS''s large infrastructure (right[1]). Stopping spending money on data center operations (left[2]) allows businesses to reallocate resources to innovation and core business functions (right[2]). Analyzing and attributing expenditure (left[3]) involves using AWS tools and tagging to gain granular visibility into costs (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  70,
  '{"left":["Trade CapEx for OpEx","Benefit from massive economies of scale","Stop spending money on data center operations","Analyze and attribute expenditure"],"right":["Shifting from upfront hardware purchases to pay-as-you-go","Leveraging AWS''s lower prices due to aggregated demand","Focusing resources on core business instead of infrastructure","Using tools like Cost Explorer and tags for transparency"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_3_76',
  'Match the AWS cloud economics concept to its role in resource utilization.',
  'matching',
  '{"A":"Elasticity","B":"Scalability","C":"Right-sizing","D":"Monitoring"}'::json,
  NULL,
  'Elasticity (left[0]) plays a crucial role in resource utilization by dynamically adjusting capacity to meet demand, thus avoiding over-provisioning and waste (right[0]). Scalability (left[1]) ensures that systems can efficiently handle increased load, preventing performance bottlenecks that might lead to user dissatisfaction or lost revenue (right[1]). Right-sizing (left[2]) is a direct cost optimization technique focused on optimizing resource allocation to eliminate idle or underutilized capacity (right[2]). Monitoring (left[3]) provides essential data on resource usage, which is critical for making informed decisions about scaling, right-sizing, and overall cost management (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  71,
  '{"left":["Elasticity","Scalability","Right-sizing","Monitoring"],"right":["Dynamically matching capacity to demand to avoid waste","Designing systems to handle increased load efficiently","Optimizing resource allocation to eliminate idle capacity","Collecting data on resource usage to inform decisions"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_60_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_91',
  'Match the cloud migration strategy to its description.',
  'matching',
  '{"A":"Rehost (Lift and Shift)","B":"Replatform (Lift and Reshape)","C":"Refactor/Re-architect"}'::json,
  NULL,
  'Rehost (Lift and Shift) (left[0]) involves moving an application to the cloud with minimal changes (right[0]), often by migrating virtual machines. Replatform (Lift and Reshape) (left[1]) means running an application on a managed cloud service (right[2]), making some cloud optimizations without changing the core architecture. Refactor/Re-architect (left[2]) involves modifying an application to use cloud-native features (right[1]) to gain maximum cloud benefits.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  72,
  '{"left":["Rehost (Lift and Shift)","Replatform (Lift and Reshape)","Refactor/Re-architect"],"right":["Moving an application to the cloud with minimal changes","Modifying an application to use cloud-native features","Running an application on a managed cloud service"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_92',
  'Match the cloud migration strategy to its approach.',
  'matching',
  '{"A":"Repurchase","B":"Retain","C":"Retire"}'::json,
  NULL,
  'Repurchase (left[0]) means moving to a different product, typically SaaS (right[1]), replacing an existing application with a cloud-native solution. Retain (left[1]) involves keeping applications on-premises (right[2]) if there''s no business case for migration. Retire (left[2]) is about decommissioning applications no longer needed (right[0]) after migration, reducing costs and complexity.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  73,
  '{"left":["Repurchase","Retain","Retire"],"right":["Decommissioning applications no longer needed","Moving to a different product, typically SaaS","Keeping applications on-premises"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_93',
  'Match the AWS Cloud Adoption Framework (CAF) perspective to its area of focus.',
  'matching',
  '{"A":"Business","B":"People","C":"Governance"}'::json,
  NULL,
  'The Business perspective (left[0]) of the AWS CAF focuses on aligning IT with business strategy and financial objectives (right[1]). The People perspective (left[1]) addresses ensuring organizational readiness and skills development (right[0]) for cloud adoption. The Governance perspective (left[2]) is concerned with managing and measuring cloud investments and compliance (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  74,
  '{"left":["Business","People","Governance"],"right":["Ensuring organizational readiness and skills development","Aligning IT with business strategy and financial objectives","Managing and measuring cloud investments and compliance"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_94',
  'Match the AWS Cloud Adoption Framework (CAF) perspective to its domain.',
  'matching',
  '{"A":"Platform","B":"Security","C":"Operations"}'::json,
  NULL,
  'The Platform perspective (left[0]) of the AWS CAF focuses on defining how cloud services are consumed and managed (right[0]). The Security perspective (left[1]) is dedicated to ensuring the cloud environment meets security requirements (right[1]). The Operations perspective (left[2]) addresses delivering and supporting cloud workloads (right[2]) effectively.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  75,
  '{"left":["Platform","Security","Operations"],"right":["Defining how cloud services are consumed and managed","Ensuring the cloud environment meets security requirements","Delivering and supporting cloud workloads"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_95',
  'Match the AWS migration benefit to its outcome.',
  'matching',
  '{"A":"Reduced Complexity","B":"Improved Agility","C":"Business Continuity"}'::json,
  NULL,
  'Reduced Complexity (left[0]) in migration leads to simplified IT operations and management (right[1]) by leveraging managed services. Improved Agility (left[1]) allows businesses to quickly adapt to market changes (right[0]) and innovate faster. Business Continuity (left[2]) is enhanced by maintaining critical business functions during disruptions (right[2]) through cloud resilience features.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  76,
  '{"left":["Reduced Complexity","Improved Agility","Business Continuity"],"right":["Ability to quickly adapt to market changes","Simplified IT operations and management","Maintaining critical business functions during disruptions"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_96',
  'Match the AWS migration service to its primary function.',
  'matching',
  '{"A":"AWS Migration Hub","B":"AWS Application Migration Service","C":"AWS Database Migration Service (DMS)"}'::json,
  NULL,
  'AWS Migration Hub (left[0]) provides a central location to track migrations (right[2]) from on-premises to AWS. AWS Application Migration Service (left[1]) facilitates rehosting applications to AWS (right[0]) by automating server migration. AWS Database Migration Service (DMS) (left[2]) helps migrate databases to AWS with minimal downtime (right[1]), supporting homogeneous and heterogeneous migrations.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  77,
  '{"left":["AWS Migration Hub","AWS Application Migration Service","AWS Database Migration Service (DMS)"],"right":["Facilitates rehosting applications to AWS","Helps migrate databases to AWS with minimal downtime","Provides a central location to track migrations"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_97',
  'Match the AWS data transfer service to its use case.',
  'matching',
  '{"A":"AWS Snow Family","B":"AWS Database Migration Service (DMS)","C":"AWS Direct Connect"}'::json,
  NULL,
  'AWS Snow Family (left[0]) consists of physical devices for large-scale data transfer to AWS (right[2]) for petabyte-scale migrations. AWS Database Migration Service (DMS) (left[1]) is used for migrating databases with minimal downtime (right[1]). AWS Direct Connect (left[2]) provides a dedicated network connection from on-premises to AWS (right[0]), offering consistent network performance.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  78,
  '{"left":["AWS Snow Family","AWS Database Migration Service (DMS)","AWS Direct Connect"],"right":["Dedicated network connection from on-premises to AWS","Migrating databases with minimal downtime","Physical devices for large-scale data transfer to AWS"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_98',
  'Match the AWS Cloud Adoption Framework (CAF) phase to its objective.',
  'matching',
  '{"A":"Assess","B":"Mobilize","C":"Migrate & Modernize"}'::json,
  NULL,
  'The Assess phase (left[0]) of the AWS CAF focuses on evaluating the current state and readiness for cloud adoption (right[2]). The Mobilize phase (left[1]) involves building foundational cloud capabilities and skills (right[1]) within the organization. The Migrate & Modernize phase (left[2]) is about executing the migration of applications and optimizing them (right[0]) for the cloud environment.',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  79,
  '{"left":["Assess","Mobilize","Migrate & Modernize"],"right":["Executing the migration of applications and optimizing them","Building foundational cloud capabilities and skills","Evaluating the current state and readiness for cloud adoption"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_99',
  'Match each ''R'' of migration to its description.',
  'matching',
  '{"A":"Rehost","B":"Replatform","C":"Refactor"}'::json,
  NULL,
  'Rehost (left[0]), also known as lift and shift, involves moving applications to AWS without making any significant architectural changes (right[0]). Replatform (left[1]) means moving to AWS while making some cloud-native optimizations, like replacing a self-managed database with Amazon RDS (right[1]). Refactor (left[2]) involves re-architecting applications to fully leverage cloud-native features and services, often for significant agility and scalability gains (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  80,
  '{"left":["Rehost","Replatform","Refactor"],"right":["Lift and shift applications to AWS without changes.","Move to AWS, making some cloud-native optimizations.","Re-architect applications to fully leverage cloud features."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_100',
  'Match the remaining ''R''s of migration to their definitions.',
  'matching',
  '{"A":"Repurchase","B":"Retain","C":"Retire"}'::json,
  NULL,
  'Repurchase (left[0]) involves replacing an existing application with a Software-as-a-Service (SaaS) solution available on AWS Marketplace or elsewhere (right[0]). Retain (left[1]) means keeping some applications on-premises due to specific business, compliance, or technical needs (right[1]). Retire (left[2]) refers to decommissioning applications that are no longer needed or used, saving costs and reducing complexity (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  81,
  '{"left":["Repurchase","Retain","Retire"],"right":["Replace an existing application with a SaaS solution.","Keep some applications on-premises due to specific needs.","Decommission applications that are no longer needed."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_101',
  'Match each AWS Cloud Adoption Framework (CAF) perspective to its focus.',
  'matching',
  '{"A":"Business","B":"People","C":"Governance"}'::json,
  NULL,
  'The Business perspective (left[0]) of the AWS CAF focuses on ensuring IT aligns with business strategy and outcomes, defining business cases and metrics (right[0]). The People perspective (left[1]) prepares the organization for cloud adoption by addressing skills gaps, training, and organizational change management (right[1]). The Governance perspective (left[2]) focuses on managing and controlling cloud environments effectively, including policy, risk, and compliance (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  82,
  '{"left":["Business","People","Governance"],"right":["Ensuring IT aligns with business strategy and outcomes.","Preparing the organization for cloud adoption through training.","Managing and controlling cloud environments effectively."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_102',
  'Match the AWS Cloud Adoption Framework (CAF) perspective to its area of concern.',
  'matching',
  '{"A":"Platform","B":"Security","C":"Operations"}'::json,
  NULL,
  'The Platform perspective (left[0]) of the AWS CAF focuses on designing and implementing the cloud architecture, including infrastructure, applications, and data (right[0]). The Security perspective (left[1]) ensures data protection, identity and access management, and compliance within the cloud environment (right[1]). The Operations perspective (left[2]) defines how cloud services are managed, monitored, and supported, including incident response and continuous improvement (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  83,
  '{"left":["Platform","Security","Operations"],"right":["Designing and implementing the cloud architecture.","Ensuring data protection and compliance in the cloud.","Defining how cloud services are managed and monitored."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_103',
  'Match the benefit of cloud migration to its impact.',
  'matching',
  '{"A":"Reduced complexity","B":"Improved agility","C":"Business continuity"}'::json,
  NULL,
  'Reduced complexity (left[0]) is a benefit of cloud migration as it simplifies IT infrastructure management by leveraging managed services and automation (right[0]). Improved agility (left[1]) allows organizations to accelerate development and deployment cycles, responding faster to market demands (right[1]). Enhanced business continuity (left[2]) is achieved by leveraging AWS''s global, highly available infrastructure, improving resilience against outages and disasters (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  84,
  '{"left":["Reduced complexity","Improved agility","Business continuity"],"right":["Simplify IT infrastructure management.","Accelerate development and deployment cycles.","Enhance resilience against outages and disasters."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_104',
  'Match the AWS migration service to its primary function.',
  'matching',
  '{"A":"AWS Migration Hub","B":"AWS Application Migration Service","C":"AWS Database Migration Service (DMS)"}'::json,
  NULL,
  'AWS Migration Hub (left[0]) provides a central dashboard to track the progress of application migrations across multiple AWS and partner solutions (right[0]). AWS Application Migration Service (left[1]) automates the rehosting (lift-and-shift) of physical servers, virtual machines, and cloud instances to AWS (right[1]). AWS Database Migration Service (DMS) (left[2]) helps migrate relational databases, data warehouses, NoSQL databases, and other data stores with minimal downtime (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  85,
  '{"left":["AWS Migration Hub","AWS Application Migration Service","AWS Database Migration Service (DMS)"],"right":["Central dashboard for tracking migrations.","Automate rehosting of physical or virtual servers.","Migrate databases with minimal downtime."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_105',
  'Match the AWS data transfer service to its use case.',
  'matching',
  '{"A":"AWS Snow Family","B":"AWS DataSync","C":"AWS Direct Connect"}'::json,
  NULL,
  'The AWS Snow Family (left[0]) is used for transferring large amounts of data offline to and from AWS, especially for remote or disconnected environments (right[0]). AWS DataSync (left[1]) automates and accelerates online data transfer between on-premises storage and AWS storage services (right[1]). AWS Direct Connect (left[2]) establishes a dedicated network connection from an on-premises data center to AWS, offering consistent network performance (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  86,
  '{"left":["AWS Snow Family","AWS DataSync","AWS Direct Connect"],"right":["Transfer large amounts of data offline.","Automate and accelerate online data transfer.","Establish a dedicated network connection to AWS."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_106',
  'Match the migration strategy component to its purpose.',
  'matching',
  '{"A":"Workload assessment","B":"Phased migration","C":"Incremental value"}'::json,
  NULL,
  'Workload assessment (left[0]) involves evaluating existing applications for cloud readiness, dependencies, and suitability for different migration strategies (right[0]). A phased migration (left[1]) approach involves moving applications in stages rather than a ''big bang,'' which helps reduce risk and allows for learning (right[1]). Focusing on incremental value (left[2]) ensures that business benefits are delivered throughout the migration process, not just at the end (right[2]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  87,
  '{"left":["Workload assessment","Phased migration","Incremental value"],"right":["Evaluate applications for cloud readiness and dependencies.","Move applications in stages to reduce risk.","Deliver business benefits throughout the migration process."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_60_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_107',
  'Match each of the 6 Rs of migration strategies to its description.',
  'matching',
  '{"A":"Rehost (Lift and Shift)","B":"Replatform (Lift and Reshape)","C":"Refactor/Re-architect","D":"Repurchase (Drop and Shop)"}'::json,
  NULL,
  'Rehost (Lift and Shift) (left[0]) involves moving applications to the cloud without making any significant changes to their architecture (right[0]). Replatform (Lift and Reshape) (left[1]) entails making some cloud-native optimizations to gain benefits without changing the core architecture (right[1]). Refactor/Re-architect (left[2]) means reimagining how an application is architected and developed, often using cloud-native features extensively (right[2]). Repurchase (Drop and Shop) (left[3]) involves replacing an existing application with a cloud-native SaaS solution (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  88,
  '{"left":["Rehost (Lift and Shift)","Replatform (Lift and Reshape)","Refactor/Re-architect","Repurchase (Drop and Shop)"],"right":["Moving applications without changes","Making minor cloud-native optimizations without changing core architecture","Reimagining how an application is architected and developed","Replacing an existing application with a SaaS solution"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_108',
  'Match the AWS Cloud Adoption Framework (CAF) perspective to its area of focus.',
  'matching',
  '{"A":"Business Perspective","B":"People Perspective","C":"Governance Perspective","D":"Platform Perspective"}'::json,
  NULL,
  'The AWS Cloud Adoption Framework (CAF) helps organizations prepare for cloud migration. The Business Perspective (left[0]) focuses on ensuring IT aligns with business strategy and financial objectives (right[0]). The People Perspective (left[1]) addresses organizational structure, roles, and training to prepare the workforce for cloud adoption (right[1]). The Governance Perspective (left[2]) focuses on managing and controlling the cloud environment, including policies and compliance (right[2]). The Platform Perspective (left[3]) deals with designing and implementing the cloud architecture, including services and infrastructure (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  89,
  '{"left":["Business Perspective","People Perspective","Governance Perspective","Platform Perspective"],"right":["Ensuring IT aligns with business strategy","Preparing the organization for cloud adoption","Managing and controlling cloud environments","Designing and implementing the cloud architecture"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_109',
  'Match the AWS migration service to its primary function.',
  'matching',
  '{"A":"AWS Migration Hub","B":"AWS Application Migration Service","C":"AWS Database Migration Service (DMS)","D":"AWS Snow Family"}'::json,
  NULL,
  'AWS Migration Hub (left[0]) provides a single location to track the progress of application migrations across various AWS and partner migration tools (right[0]). AWS Application Migration Service (left[1]), powered by CloudEndure Migration, automates the rehosting (lift-and-shift) of physical, virtual, and cloud servers to AWS (right[1]). AWS Database Migration Service (DMS) (left[2]) helps migrate relational databases, data warehouses, NoSQL databases, and other data stores to AWS quickly and securely (right[2]). The AWS Snow Family (left[3]) offers a collection of physical devices for transferring large amounts of data into and out of AWS, especially useful for environments with limited network connectivity (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  90,
  '{"left":["AWS Migration Hub","AWS Application Migration Service","AWS Database Migration Service (DMS)","AWS Snow Family"],"right":["Tracking migration progress across multiple tools","Automating rehosting of physical, virtual, and cloud servers","Migrating relational databases to AWS","Transferring large amounts of data to AWS offline"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_110',
  'Match the AWS Cloud Adoption Framework (CAF) perspective to its area of focus for cloud readiness.',
  'matching',
  '{"A":"Security Perspective","B":"Operations Perspective","C":"People Perspective","D":"Business Perspective"}'::json,
  NULL,
  'The Security Perspective (left[0]) of the AWS CAF focuses on ensuring data protection, identity management, and compliance within the cloud environment (right[0]). The Operations Perspective (left[1]) defines how cloud resources are managed, monitored, and supported post-migration (right[1]). The People Perspective (left[2]) addresses the organizational change management, training, and skill development necessary for successful cloud adoption (right[2]). The Business Perspective (left[3]) ensures that cloud initiatives are aligned with the organization''s strategic goals and financial objectives (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  91,
  '{"left":["Security Perspective","Operations Perspective","People Perspective","Business Perspective"],"right":["Ensuring data protection and compliance in the cloud","Defining how cloud resources are managed and supported","Developing skills and processes for cloud adoption","Aligning cloud initiatives with organizational goals"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_111',
  'Match the migration benefit to its impact on an organization.',
  'matching',
  '{"A":"Reduced Complexity","B":"Improved Agility","C":"Business Continuity","D":"Cost Savings"}'::json,
  NULL,
  'Reduced Complexity (left[0]) is a benefit of migrating to the cloud, as managed services simplify IT infrastructure management (right[0]). Improved Agility (left[1]) allows organizations to respond faster to market changes and customer needs by rapidly provisioning resources (right[1]). Business Continuity (left[2]) is enhanced through cloud capabilities like multi-AZ deployments and disaster recovery strategies, maintaining operations during disruptions (right[2]). Cost Savings (left[3]) are realized through the pay-as-you-go model, economies of scale, and optimized resource utilization (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  92,
  '{"left":["Reduced Complexity","Improved Agility","Business Continuity","Cost Savings"],"right":["Simplifying IT infrastructure management","Faster response to market changes and customer needs","Maintaining operations during disruptions with disaster recovery","Lowering infrastructure and operational expenses"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_112',
  'Match the AWS migration strategy to its level of application modification.',
  'matching',
  '{"A":"Retain","B":"Retire","C":"Rehost","D":"Refactor"}'::json,
  NULL,
  'Retain (left[0]) is a migration strategy where some applications are kept on-premises, often due to specific compliance or legacy requirements (right[0]). Retire (left[1]) involves decommissioning applications that are no longer needed, reducing complexity and costs (right[1]). Rehost (left[2]) is the ''lift-and-shift'' approach, moving applications to AWS with minimal or no changes (right[2]). Refactor (left[3]) is the most transformative strategy, involving re-architecting applications to fully leverage cloud-native features and services (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  93,
  '{"left":["Retain","Retire","Rehost","Refactor"],"right":["Keeping some applications on-premises","Decommissioning applications no longer needed","Moving applications to AWS with minimal or no changes","Re-architecting applications to leverage cloud-native features"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_113',
  'Match the AWS Snow Family device to its typical use case.',
  'matching',
  '{"A":"AWS Snowcone","B":"AWS Snowball Edge Storage Optimized","C":"AWS Snowball Edge Compute Optimized","D":"AWS Snowmobile"}'::json,
  NULL,
  'AWS Snowcone (left[0]) is the smallest member of the Snow Family, designed for small-scale data transfer and edge computing in disconnected environments (right[0]). AWS Snowball Edge Storage Optimized (left[1]) is suitable for large-scale data transfer and local storage-intensive workloads (right[1]). AWS Snowball Edge Compute Optimized (left[2]) is designed for large-scale data transfer and local compute-intensive workloads, often with machine learning applications (right[2]). AWS Snowmobile (left[3]) is an exabyte-scale data transfer service, used for moving extremely large amounts of data to AWS (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  94,
  '{"left":["AWS Snowcone","AWS Snowball Edge Storage Optimized","AWS Snowball Edge Compute Optimized","AWS Snowmobile"],"right":["Small-scale data transfer and edge computing","Large-scale data transfer with storage-intensive workloads","Large-scale data transfer with compute-intensive workloads","Exabyte-scale data transfer"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_114',
  'Match the AWS Cloud Adoption Framework (CAF) perspective to its primary concern.',
  'matching',
  '{"A":"Governance Perspective","B":"Operations Perspective","C":"Platform Perspective","D":"Security Perspective"}'::json,
  NULL,
  'The Governance Perspective (left[0]) of the AWS CAF focuses on organizational policies, compliance, and risk management within the cloud environment (right[0]). The Operations Perspective (left[1]) is concerned with how cloud services and resources are managed, monitored, and supported on a day-to-day basis (right[1]). The Platform Perspective (left[2]) involves choosing and implementing the appropriate cloud services and architectural patterns to meet technical requirements (right[2]). The Security Perspective (left[3]) addresses identity and access management, data protection, and overall security posture in the cloud (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  95,
  '{"left":["Governance Perspective","Operations Perspective","Platform Perspective","Security Perspective"],"right":["Organizational policies, compliance, and risk management","Managing and monitoring cloud services and resources","Choosing and implementing cloud services and architecture","Identity, access, and data protection strategies"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_60_m_60_2_115',
  'Match the AWS migration tool to its specific migration type.',
  'matching',
  '{"A":"AWS Application Migration Service (AWS MGN)","B":"AWS Database Migration Service (DMS)","C":"AWS Snowball Edge","D":"AWS Migration Hub"}'::json,
  NULL,
  'AWS Application Migration Service (AWS MGN) (left[0]) is primarily used for automated rehosting (lift-and-shift) of physical, virtual, and cloud servers to AWS (right[0]). AWS Database Migration Service (DMS) (left[1]) specializes in migrating databases and other data stores to AWS with minimal downtime (right[1]). AWS Snowball Edge (left[2]) is a physical device used for offline transfer of large amounts of data, often including local compute capabilities (right[2]). AWS Migration Hub (left[3]) serves as a centralized dashboard for tracking and planning migrations across various AWS and partner tools (right[3]).',
  NOW(),
  'quiz_domain60_13',
  NOW(),
  96,
  '{"left":["AWS Application Migration Service (AWS MGN)","AWS Database Migration Service (DMS)","AWS Snowball Edge","AWS Migration Hub"],"right":["Automated rehosting of servers","Database and data store migration","Offline large data transfer with compute","Centralized migration tracking and planning"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_60_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_110'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_111'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_112'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_113'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_114'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_115'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_116'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_117'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_118'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_119'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_120'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_121'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_122'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_123'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_124'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_125'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_126'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_127'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_128'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_129'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_130'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_131'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_132'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_1_133'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_76'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_77'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_78'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_79'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_80'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_81'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_82'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_83'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_84'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_85'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_86'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_87'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_88'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_89'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_90'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_91'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_92'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_93'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_94'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_95'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_96'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_97'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_98'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_99'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_4_100'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_55'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_56'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_57'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_58'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_59'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_60'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_61'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_62'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_63'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_64'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_65'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_66'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_67'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_68'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_69'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_70'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_71'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_72'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_73'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_74'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_75'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_3_76'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_91'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_92'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_93'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_94'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_95'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_96'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_97'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_98'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_99'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_100'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_101'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_102'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_103'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_104'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_105'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_106'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_107'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_108'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_109'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_110'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_111'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_112'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_113'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_114'),
  (NOW(), 'quiz_domain60_13', 'q_60_m_60_2_115')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain60_13'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;

-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: CLF-C02
-- Generated: 2026-03-19T01:57:28.419Z
-- Questions: 96 (96 validated, 8 rejected)
-- Quiz ID: quiz_domain61_13
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_61_3
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_106',
  'Match each AWS Identity and Access Management (IAM) entity to its primary description.',
  'matching',
  '{"A":"IAM User","B":"IAM Group","C":"IAM Role"}'::json,
  NULL,
  'Option A (IAM User) represents an individual person or service that interacts with AWS. Option B (IAM Group) is a collection of IAM users, making it easier to manage permissions for multiple users. Option C (IAM Role) is an identity that you can assume to gain temporary permissions for specific tasks, often used by AWS services or for cross-account access.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  1,
  '{"left":["IAM User","IAM Group","IAM Role"],"right":["Represents a person or service identity","A collection of IAM users","Grants temporary permissions to AWS resources"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_107',
  'Match each IAM best practice to its security purpose.',
  'matching',
  '{"A":"Least Privilege","B":"Multi-Factor Authentication","C":"Root Account Usage"}'::json,
  NULL,
  'Option A (Least Privilege) is a security principle to grant only the permissions required to perform a task. Option B (Multi-Factor Authentication) enhances security by requiring two or more verification factors to log in. Option C (Root Account Usage) should be avoided for everyday tasks, as it has unrestricted access and should only be used for initial setup and critical account management.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  2,
  '{"left":["Least Privilege","Multi-Factor Authentication","Root Account Usage"],"right":["Grant minimum necessary permissions","Adds a second authentication factor","Avoid for daily operational tasks"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_108',
  'Match each AWS service to its primary access management function.',
  'matching',
  '{"A":"AWS IAM","B":"AWS IAM Identity Center","C":"Amazon Cognito"}'::json,
  NULL,
  'Option A (AWS IAM) is fundamental for managing access to AWS services and resources. Option B (AWS IAM Identity Center) provides centralized single sign-on (SSO) access to multiple AWS accounts and cloud applications. Option C (Amazon Cognito) offers user sign-up, sign-in, and access control for web and mobile applications.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  3,
  '{"left":["AWS IAM","AWS IAM Identity Center","Amazon Cognito"],"right":["Manages user and resource permissions","Centralized single sign-on access","User directory for web and mobile applications"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_109',
  'Match each security principle to its definition.',
  'matching',
  '{"A":"Principle of Least Privilege","B":"Multi-Factor Authentication","C":"Identity Federation"}'::json,
  NULL,
  'Option A (Principle of Least Privilege) dictates that users and services should only be granted the minimum permissions required to perform their tasks. Option B (Multi-Factor Authentication) adds an extra layer of security by requiring a second form of verification. Option C (Identity Federation) allows users to access AWS resources using credentials from an external identity provider, such as a corporate directory.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  4,
  '{"left":["Principle of Least Privilege","Multi-Factor Authentication","Identity Federation"],"right":["Granting only necessary permissions","Requires two verification factors for login","Linking external identity systems to AWS"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_110',
  'Match each IAM component to its specific function.',
  'matching',
  '{"A":"IAM Policy","B":"IAM Credential Report","C":"IAM Access Advisor"}'::json,
  NULL,
  'Option A (IAM Policy) is a document that defines permissions, specifying what actions are allowed or denied on which resources. Option B (IAM Credential Report) is an account-level report that lists all IAM users and the status of their various credentials. Option C (IAM Access Advisor) shows the services that a user or role has accessed and the last time they accessed them, helping to refine permissions.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  5,
  '{"left":["IAM Policy","IAM Credential Report","IAM Access Advisor"],"right":["Defines permissions for an identity","Lists all user credentials and status","Shows service access history for a user"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_111',
  'Match each root account security best practice to its recommendation.',
  'matching',
  '{"A":"Root Account Usage","B":"MFA for Root Account","C":"Root Access Keys"}'::json,
  NULL,
  'Option A (Root Account Usage) should be avoided for daily tasks due to its unrestricted permissions. Option B (MFA for Root Account) should always be enabled to add a critical layer of security. Option C (Root Access Keys) should be deleted or kept inactive, as they grant programmatic access equivalent to the root user and are a high-risk credential.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  6,
  '{"left":["Root Account Usage","MFA for Root Account","Root Access Keys"],"right":["Avoid for daily operations","Always enable for enhanced security","Delete or keep inactive if not needed"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_112',
  'Match each IAM role type to its common use case.',
  'matching',
  '{"A":"EC2 Instance Role","B":"Cross-Account Role","C":"Service Role"}'::json,
  NULL,
  'Option A (EC2 Instance Role) is attached to an Amazon EC2 instance to grant it permissions to interact with other AWS services. Option B (Cross-Account Role) enables a trusted entity in one AWS account to access resources in another account. Option C (Service Role) allows an AWS service, like AWS Lambda or Amazon RDS, to assume permissions to perform actions on your behalf.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  7,
  '{"left":["EC2 Instance Role","Cross-Account Role","Service Role"],"right":["Grants permissions to an EC2 instance","Grants access to resources in another AWS account","Allows an AWS service to perform actions"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_113',
  'Match each IAM authentication method to its primary type.',
  'matching',
  '{"A":"Password","B":"MFA Device","C":"Access Key"}'::json,
  NULL,
  'Option A (Password) is the standard credential used for logging into the AWS Management Console. Option B (MFA Device) provides a second factor of authentication, significantly increasing security. Option C (Access Key) consists of an access key ID and a secret access key, used for programmatic access to AWS APIs via the AWS CLI or SDKs.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  8,
  '{"left":["Password","MFA Device","Access Key"],"right":["Standard login credential for console","Second factor of authentication","Programmatic access credential for APIs"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_114',
  'Match each AWS Identity and Access Management (IAM) entity to its primary description.',
  'matching',
  '{"A":"IAM User","B":"IAM Group","C":"IAM Role"}'::json,
  NULL,
  'An IAM User (left[0]) is an entity that represents a person or application that interacts with AWS (right[0]). An IAM Group (left[1]) is a collection of IAM users (right[1]) to which you can attach policies. An IAM Role (left[2]) is an IAM identity that you can create in your account that has specific permissions, designed to grant temporary access to AWS services and resources (right[2]).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  9,
  '{"left":["IAM User","IAM Group","IAM Role"],"right":["Represents a person or application","Collection of IAM users","Grants temporary permissions"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_115',
  'Match each IAM best practice to its recommended action.',
  'matching',
  '{"A":"Root account","B":"Least privilege","C":"MFA"}'::json,
  NULL,
  'The Root account (left[0]) should be secured with Multi-Factor Authentication (MFA) and its use avoided for daily operational tasks (right[0]). The principle of Least privilege (left[1]) dictates granting only the necessary permissions for a user or role to perform its tasks (right[1]). Multi-Factor Authentication (MFA) (left[2]) adds a second layer of security to sign-ins (right[2]) by requiring a second verification method.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  10,
  '{"left":["Root account","Least privilege","MFA"],"right":["Secure with MFA, avoid daily use","Grant only necessary permissions","Adds a second layer of security"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_116',
  'Match each IAM component to its function within access management.',
  'matching',
  '{"A":"IAM Policy","B":"IAM User","C":"IAM Role"}'::json,
  NULL,
  'An IAM Policy (left[0]) is a document that formally defines permissions (right[0]) for an entity. An IAM User (left[1]) represents an individual identity (right[1]) with long-term credentials. An IAM Role (left[2]) is an assumable identity for services or users (right[2]) to gain temporary access to resources.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  11,
  '{"left":["IAM Policy","IAM User","IAM Role"],"right":["Defines permissions","Individual identity","Assumable identity for services"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_117',
  'Match each access management concept to its definition.',
  'matching',
  '{"A":"Federated access","B":"IAM Identity Center","C":"MFA"}'::json,
  NULL,
  'Federated access (left[0]) allows users to sign in to AWS using credentials from an external identity provider (right[0]). AWS IAM Identity Center (SSO) (left[1]) provides centralized single sign-on management (right[1]) to multiple AWS accounts and applications. MFA (left[2]) stands for Multi-Factor Authentication (right[2]), which adds an extra layer of security.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  12,
  '{"left":["Federated access","IAM Identity Center","MFA"],"right":["Access using external identity","Centralized SSO management","Multi-factor authentication"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_118',
  'Match each IAM security feature to its primary benefit.',
  'matching',
  '{"A":"MFA","B":"Least privilege","C":"IAM Roles"}'::json,
  NULL,
  'MFA (left[0]) significantly reduces the risk of unauthorized access (right[0]) by requiring multiple verification factors. The principle of Least privilege (left[1]) limits the blast radius of a security compromise (right[1]) by ensuring entities only have permissions essential for their tasks. IAM Roles (left[2]) provide temporary, automatically rotating credentials (right[2]), which is more secure than long-term access keys.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  13,
  '{"left":["MFA","Least privilege","IAM Roles"],"right":["Reduces unauthorized access risk","Limits blast radius of compromise","Provides temporary, rotating credentials"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_119',
  'Match each IAM user type to its appropriate use case.',
  'matching',
  '{"A":"IAM User","B":"Root User","C":"IAM Role"}'::json,
  NULL,
  'An IAM User (left[0]) is suitable for daily administrative tasks (right[0]) and should be used instead of the root account. The Root User (left[1]) should only be used for initial account setup (right[1]) and a few account management tasks. An IAM Role (left[2]) is ideal for granting temporary cross-account access (right[2]) or permissions to AWS services.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  14,
  '{"left":["IAM User","Root User","IAM Role"],"right":["Daily administrative tasks","Initial account setup","Cross-account access"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_120',
  'Match each IAM access type to its characteristic.',
  'matching',
  '{"A":"Programmatic access","B":"Console access","C":"Federated access"}'::json,
  NULL,
  'Programmatic access (left[0]) typically uses access keys and secret keys (right[0]) for interacting with AWS via APIs or CLI. Console access (left[1]) requires a username and password (right[1]) to log in to the AWS Management Console. Federated access (left[2]) integrates with an existing corporate directory (right[2]) or identity provider for authentication.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  15,
  '{"left":["Programmatic access","Console access","Federated access"],"right":["Uses access keys and secret keys","Requires username and password","Integrates with corporate directory"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_121',
  'Match each IAM concept to its security implication.',
  'matching',
  '{"A":"IAM Policy","B":"IAM Group","C":"IAM Role"}'::json,
  NULL,
  'An IAM Policy (left[0]) defines what actions are allowed or denied (right[0]) on AWS resources. An IAM Group (left[1]) simplifies user permission management (right[1]) by applying policies to a collection of users rather than individually. An IAM Role (left[2]) provides temporary, scoped permissions (right[2]) without requiring long-term credentials.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  16,
  '{"left":["IAM Policy","IAM Group","IAM Role"],"right":["Defines what actions are allowed","Simplifies user permission management","Provides temporary, scoped permissions"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_122',
  'Match the IAM component to its primary function.',
  'matching',
  '{"A":"IAM User","B":"IAM Group","C":"IAM Role"}'::json,
  NULL,
  'An IAM User (left item 0) is an identity representing a person or application that interacts with AWS services (right item 2), typically with long-term credentials. An IAM Group (left item 1) is a collection of IAM users that share the same permissions (right item 0), simplifying permission management for multiple users. An IAM Role (left item 2) is an identity that can be assumed by trusted entities (users, services, or external identities) to grant temporary permissions (right item 1), promoting the principle of least privilege and avoiding long-term credentials.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  17,
  '{"left":["IAM User","IAM Group","IAM Role"],"right":["A collection of IAM users that share the same permissions.","An identity that can be assumed by trusted entities for temporary permissions.","An identity representing a person or application that interacts with AWS."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_123',
  'Match the AWS access management best practice to its description.',
  'matching',
  '{"A":"Principle of least privilege","B":"Root account best practice","C":"Multi-factor authentication (MFA)"}'::json,
  NULL,
  'The Principle of least privilege (left item 0) is a security best practice that involves granting only the necessary permissions for a user or role to perform its task (right item 1), minimizing the impact of compromised credentials. A Root account best practice (left item 1) is to use it only for initial setup and highly sensitive account management tasks (right item 2), and never for daily operations, to limit its exposure. Multi-factor authentication (MFA) (left item 2) enhances security by requiring users to provide multiple forms of verification for access (right item 0), adding an extra layer of protection beyond just a password.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  18,
  '{"left":["Principle of least privilege","Root account best practice","Multi-factor authentication (MFA)"],"right":["Requires users to provide multiple forms of verification for access.","Granting only the necessary permissions for a user or role to perform its task.","Using it only for initial setup and highly sensitive account management tasks."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_124',
  'Match the AWS Identity and Access Management (IAM) feature to its security benefit.',
  'matching',
  '{"A":"IAM Policies","B":"IAM Identity Center (SSO)","C":"Federated Access"}'::json,
  NULL,
  'IAM Policies (left item 0) define specific permissions for users, groups, or roles (right item 2), enforcing the principle of least privilege. AWS IAM Identity Center (SSO) (left item 1) enables users to sign in once to access multiple AWS accounts and cloud applications (right item 0), simplifying access management and improving user experience. Federated Access (left item 2) allows external identities (e.g., from a corporate directory like Active Directory) to access AWS resources (right item 1) without creating individual IAM users for each person, integrating with existing identity systems.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  19,
  '{"left":["IAM Policies","IAM Identity Center (SSO)","Federated Access"],"right":["Enables users to sign in once to access multiple AWS accounts and cloud applications.","Allows external identities (e.g., corporate directory) to access AWS resources.","Defines specific permissions for users, groups, or roles."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_125',
  'Match the IAM security anti-pattern to the correct best practice that addresses it.',
  'matching',
  '{"A":"Using the root account for daily tasks","B":"Granting AdministratorAccess to all users","C":"Embedding access keys directly in application code"}'::json,
  NULL,
  'Using the root account for daily tasks (left item 0) is an anti-pattern because the root account has unrestricted access. The best practice is to restrict root account use to initial setup and critical account recovery (right item 2). Granting AdministratorAccess to all users (left item 1) violates the principle of least privilege. Instead, the best practice is to create individual IAM users with least privilege permissions (right item 1). Embedding access keys directly in application code (left item 2) is insecure and hard to manage. The best practice is to use IAM roles for applications to obtain temporary credentials (right item 0), which are automatically rotated and don''t require storing long-term credentials.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  20,
  '{"left":["Using the root account for daily tasks","Granting AdministratorAccess to all users","Embedding access keys directly in application code"],"right":["Use IAM roles for applications to obtain temporary credentials.","Create individual IAM users with least privilege permissions.","Restrict root account use to initial setup and critical account recovery."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_126',
  'Match the AWS access management concept to its security principle.',
  'matching',
  '{"A":"IAM Users","B":"Multi-factor Authentication (MFA)","C":"IAM Roles"}'::json,
  NULL,
  'IAM Users (left item 0) represent individual human or application identities with specific permissions (right item 2), allowing for granular access control and auditing. Multi-factor Authentication (MFA) (left item 1) adds an extra layer of security by requiring a second verification factor (right item 1) beyond just a password, significantly reducing the risk of unauthorized access. IAM Roles (left item 2) provide temporary credentials for trusted entities, avoiding the need for long-term access keys (right item 0), which is a best practice for applications and services.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  21,
  '{"left":["IAM Users","Multi-factor Authentication (MFA)","IAM Roles"],"right":["Provides temporary credentials for trusted entities, avoiding long-term keys.","Adds an extra layer of security by requiring a second verification factor.","Represents individual human or application identities with specific permissions."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_127',
  'Match the AWS security best practice to its associated access management concept.',
  'matching',
  '{"A":"Granting minimal permissions","B":"Securing the root user","C":"Centralized access management"}'::json,
  NULL,
  'Granting minimal permissions (left item 0) is achieved by implementing the Principle of Least Privilege (right item 2), ensuring users and roles only have the necessary access. Securing the root user (left item 1) is a critical best practice that involves enabling Multi-Factor Authentication (MFA) and avoiding its use for daily operations (right item 1). Centralized access management (left item 2) for multiple accounts and applications is best achieved by using AWS IAM Identity Center (SSO) (right item 0), which simplifies user provisioning and access control.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  22,
  '{"left":["Granting minimal permissions","Securing the root user","Centralized access management"],"right":["Using AWS IAM Identity Center (SSO).","Enabling Multi-Factor Authentication (MFA) and avoiding daily use.","Implementing the Principle of Least Privilege."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_128',
  'Match the IAM best practice to its security outcome.',
  'matching',
  '{"A":"Use IAM Roles for EC2 instances","B":"Enable MFA on root account","C":"Grant least privilege"}'::json,
  NULL,
  'Using IAM Roles for EC2 instances (left item 0) is a best practice because it avoids embedding long-term access keys in applications (right item 2) by providing temporary credentials. Enabling MFA on the root account (left item 1) adds an extra layer of security against compromised root credentials (right item 1), which have unrestricted access. Granting least privilege (left item 2) reduces the attack surface by limiting permissions to only what''s needed (right item 0) for a user or service to perform its task.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  23,
  '{"left":["Use IAM Roles for EC2 instances","Enable MFA on root account","Grant least privilege"],"right":["Reduces the attack surface by limiting permissions to only what''s needed.","Adds an extra layer of security against compromised root credentials.","Avoids embedding long-term access keys in applications."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_129',
  'Match the IAM identity type to its typical use case.',
  'matching',
  '{"A":"IAM User","B":"IAM Group","C":"IAM Role"}'::json,
  NULL,
  'An IAM User (left item 0) is typically used for providing long-term access for a specific administrator (right item 2) or individual user. An IAM Group (left item 1) is useful for assigning common permissions to a team of developers (right item 1) or other users, simplifying policy management. An IAM Role (left item 2) is best for granting temporary permissions to an Amazon EC2 instance (right item 0) or other AWS services, allowing them to perform actions on your behalf without storing long-term credentials.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  24,
  '{"left":["IAM User","IAM Group","IAM Role"],"right":["Granting temporary permissions to an Amazon EC2 instance.","Assigning common permissions to a team of developers.","Providing long-term access for a specific administrator."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_130',
  'Match the IAM feature to its role in managing access to AWS resources.',
  'matching',
  '{"A":"IAM Policies","B":"MFA","C":"IAM Identity Center"}'::json,
  NULL,
  'IAM Policies (left item 0) define the specific permissions for users, groups, or roles (right item 0), specifying what actions they can perform on which resources. Multi-Factor Authentication (MFA) (left item 1) adds a second factor of authentication for enhanced security (right item 2), requiring more than just a password. AWS IAM Identity Center (left item 2) enables single sign-on access to multiple AWS accounts and applications (right item 1), simplifying identity management for users.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  25,
  '{"left":["IAM Policies","MFA","IAM Identity Center"],"right":["Defines permissions for users, groups, or roles.","Enables single sign-on access to multiple AWS accounts and applications.","Adds a second factor of authentication for enhanced security."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_3_131',
  'Match the IAM concept to its best practice for security.',
  'matching',
  '{"A":"Root user access keys","B":"IAM user permissions","C":"Application credentials"}'::json,
  NULL,
  'For Root user access keys (left item 0), the best practice is to avoid creating them and delete them if they exist (right item 0), as the root user has unrestricted access. For IAM user permissions (left item 1), the best practice is to grant only the minimum necessary permissions (right item 1) to adhere to the principle of least privilege. For Application credentials (left item 2), the secure best practice is to use IAM roles to provide temporary credentials (right item 2) to AWS services and applications, avoiding the need to embed long-term access keys.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  26,
  '{"left":["Root user access keys","IAM user permissions","Application credentials"],"right":["Avoid creating them and delete if they exist.","Grant only the minimum necessary permissions.","Use IAM roles to provide temporary credentials."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_61_4
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_102',
  'Match each threat detection service to its primary function.',
  'matching',
  '{"A":"Amazon GuardDuty","B":"Amazon Inspector","C":"Amazon Macie"}'::json,
  NULL,
  'Option A (Amazon GuardDuty) is a continuous security monitoring service that detects malicious activity and unauthorized behavior. Option B (Amazon Inspector) is an automated security assessment service that helps improve the security and compliance of applications deployed on AWS. Option C (Amazon Macie) uses machine learning to discover, classify, and protect sensitive data in Amazon S3.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  27,
  '{"left":["Amazon GuardDuty","Amazon Inspector","Amazon Macie"],"right":["Intelligent threat detection and monitoring","Automated vulnerability management service","Sensitive data discovery and protection"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_103',
  'Match each AWS Shield offering to its DDoS protection feature.',
  'matching',
  '{"A":"AWS Shield Standard","B":"AWS Shield Advanced","C":"DDoS Protection"}'::json,
  NULL,
  'Option A (AWS Shield Standard) is automatically enabled for all AWS customers at no additional cost, providing protection against common, most frequently occurring DDoS attacks. Option B (AWS Shield Advanced) provides enhanced protections for applications running on AWS, including more sophisticated DDoS attack mitigation. Option C (DDoS Protection) is the general term for defending against distributed denial-of-service attacks, which AWS Shield provides.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  28,
  '{"left":["AWS Shield Standard","AWS Shield Advanced","DDoS Protection"],"right":["Automatic, no-cost baseline protection","Enhanced protection for applications","Defends against distributed denial-of-service attacks"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_104',
  'Match each security management service to its primary purpose.',
  'matching',
  '{"A":"AWS Security Hub","B":"Amazon Detective","C":"AWS Firewall Manager"}'::json,
  NULL,
  'Option A (AWS Security Hub) provides a comprehensive view of your security alerts and security posture across your AWS accounts. Option B (Amazon Detective) automatically collects log data from your AWS resources and uses machine learning, statistical analysis, and graph theory to build a linked set of data that enables easier security investigation. Option C (AWS Firewall Manager) simplifies your AWS WAF, AWS Shield Advanced, and VPC security group administration across multiple accounts.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  29,
  '{"left":["AWS Security Hub","Amazon Detective","AWS Firewall Manager"],"right":["Centralized security findings aggregation","Investigate security incidents and root cause","Centralized management of firewall rules"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_105',
  'Match each security service to its role in security finding aggregation and analysis.',
  'matching',
  '{"A":"AWS Security Hub","B":"Amazon Detective","C":"Security Findings"}'::json,
  NULL,
  'Option A (AWS Security Hub) serves as a central place to aggregate, organize, and prioritize security alerts and compliance status from various AWS services. Option B (Amazon Detective) helps security teams conduct faster and more efficient investigations into security incidents by analyzing log data. Option C (Security Findings) refers to the alerts and insights generated by services like GuardDuty, Inspector, and Macie, which are then often sent to Security Hub.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  30,
  '{"left":["AWS Security Hub","Amazon Detective","Security Findings"],"right":["Aggregates security alerts and compliance status","Analyzes root cause of security incidents","Alerts generated by security services"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_106',
  'Match each network security service to its operational layer.',
  'matching',
  '{"A":"Security Group","B":"Network ACL","C":"AWS WAF"}'::json,
  NULL,
  'A Security Group (left[0]) acts as a virtual firewall for EC2 instances, operating at the instance level and being stateful (right[0]). A Network ACL (left[1]) operates at the subnet level and is stateless (right[1]), providing an optional layer of security. AWS WAF (left[2]) is an application layer firewall (right[2]) that helps protect web applications from common web exploits.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  31,
  '{"left":["Security Group","Network ACL","AWS WAF"],"right":["Instance level, stateful","Subnet level, stateless","Application layer firewall"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_107',
  'Match each threat protection service to its primary function.',
  'matching',
  '{"A":"AWS Shield","B":"Amazon GuardDuty","C":"Amazon Inspector"}'::json,
  NULL,
  'AWS Shield (left[0]) provides managed Distributed Denial of Service (DDoS) protection (right[0]) for applications. Amazon GuardDuty (left[1]) offers intelligent threat detection (right[1]) by continuously monitoring for malicious activity and unauthorized behavior. Amazon Inspector (left[2]) performs automated vulnerability assessment (right[2]) of EC2 instances and container images.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  32,
  '{"left":["AWS Shield","Amazon GuardDuty","Amazon Inspector"],"right":["DDoS protection","Intelligent threat detection","Automated vulnerability assessment"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_108',
  'Match each data security service to its specific capability.',
  'matching',
  '{"A":"Amazon Macie","B":"AWS Security Hub","C":"Amazon Detective"}'::json,
  NULL,
  'Amazon Macie (left[0]) is used for sensitive data discovery in Amazon S3 buckets (right[0]), identifying PII and other sensitive information. AWS Security Hub (left[1]) provides a centralized view of security findings (right[1]) from various AWS services and partner products. Amazon Detective (left[2]) helps with root cause analysis of security events (right[2]) by automatically collecting and correlating log data.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  33,
  '{"left":["Amazon Macie","AWS Security Hub","Amazon Detective"],"right":["Sensitive data discovery in S3","Centralized security findings","Root cause analysis of security events"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_109',
  'Match each security monitoring service to its focus area.',
  'matching',
  '{"A":"Amazon GuardDuty","B":"Amazon Inspector","C":"AWS Security Hub"}'::json,
  NULL,
  'Amazon GuardDuty (left[0]) focuses on runtime threat detection (right[0]) by analyzing AWS CloudTrail, VPC Flow Logs, and DNS logs. Amazon Inspector (left[1]) specializes in vulnerability scanning (right[1]) for EC2 instances and container images. AWS Security Hub (left[2]) provides an aggregated view of your security posture (right[2]) across multiple AWS accounts and services.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  34,
  '{"left":["Amazon GuardDuty","Amazon Inspector","AWS Security Hub"],"right":["Runtime threat detection","Vulnerability scanning","Aggregated security posture"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_110',
  'Match each DDoS protection service to its level of coverage.',
  'matching',
  '{"A":"AWS Shield Standard","B":"AWS Shield Advanced","C":"AWS WAF"}'::json,
  NULL,
  'AWS Shield Standard (left[0]) provides automatic, baseline DDoS protection (right[0]) for all AWS customers at no additional cost. AWS Shield Advanced (left[1]) offers enhanced DDoS mitigation capabilities and is a paid service (right[1]). AWS WAF (left[2]) provides web application layer protection (right[2]) against common web exploits, complementing Shield''s network and transport layer protection.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  35,
  '{"left":["AWS Shield Standard","AWS Shield Advanced","AWS WAF"],"right":["Automatic, baseline protection","Enhanced DDoS mitigation, cost","Web application layer protection"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_111',
  'Match each security service to its primary purpose.',
  'matching',
  '{"A":"AWS WAF","B":"AWS Shield","C":"Amazon GuardDuty"}'::json,
  NULL,
  'AWS WAF (left[0]) primarily protects web applications (right[0]) from common web exploits. AWS Shield (left[1]) is designed to protect against DDoS attacks (right[1]). Amazon GuardDuty (left[2]) continuously monitors and detects malicious activity (right[2]) and unauthorized behavior in your AWS accounts.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  36,
  '{"left":["AWS WAF","AWS Shield","Amazon GuardDuty"],"right":["Protects web applications","Protects against DDoS attacks","Detects malicious activity"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_112',
  'Match each security control to its scope of protection.',
  'matching',
  '{"A":"Security Group","B":"AWS WAF","C":"Amazon Macie"}'::json,
  NULL,
  'A Security Group (left[0]) controls instance traffic (right[0]) at the virtual machine level. AWS WAF (left[1]) filters web requests (right[1]) to protect web applications. Amazon Macie (left[2]) discovers sensitive data (right[2]) in Amazon S3 buckets.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  37,
  '{"left":["Security Group","AWS WAF","Amazon Macie"],"right":["Controls instance traffic","Filters web requests","Discovers sensitive data"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_113',
  'Match the AWS network security control to its scope of operation.',
  'matching',
  '{"A":"Security Groups","B":"Network Access Control Lists (NACLs)","C":"AWS WAF"}'::json,
  NULL,
  'Security Groups (left item 0) operate at the instance level and are stateful (right item 0), meaning that if you allow inbound traffic, the outbound return traffic is automatically allowed. Network Access Control Lists (NACLs) (left item 1) operate at the subnet level and are stateless (right item 2), requiring explicit rules for both inbound and outbound traffic. AWS WAF (left item 2) is a web application firewall that helps protect web applications from common web exploits (right item 1) that could affect application availability, compromise security, or consume excessive resources.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  38,
  '{"left":["Security Groups","Network Access Control Lists (NACLs)","AWS WAF"],"right":["Operates at the instance level and is stateful.","Protects web applications from common web exploits.","Operates at the subnet level and is stateless."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_114',
  'Match the AWS security service to its primary threat detection or protection capability.',
  'matching',
  '{"A":"Amazon GuardDuty","B":"AWS Shield Standard","C":"Amazon Inspector"}'::json,
  NULL,
  'Amazon GuardDuty (left item 0) continuously monitors for malicious activity and unauthorized behavior (right item 1) across your AWS accounts and workloads, using threat intelligence and machine learning. AWS Shield Standard (left item 1) provides baseline DDoS protection automatically at no extra cost (right item 0) for all AWS customers, defending against common network and transport layer attacks. Amazon Inspector (left item 2) is an automated security assessment service that helps improve the security and compliance of applications deployed on AWS by identifying vulnerabilities in EC2 instances and container images (right item 2).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  39,
  '{"left":["Amazon GuardDuty","AWS Shield Standard","Amazon Inspector"],"right":["Provides baseline DDoS protection automatically at no extra cost.","Continuously monitors for malicious activity and unauthorized behavior.","Automated security assessment service for EC2 instances and container images."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_115',
  'Match the AWS security service to its function in identifying and managing security findings.',
  'matching',
  '{"A":"Amazon Macie","B":"AWS Security Hub","C":"Amazon Detective"}'::json,
  NULL,
  'Amazon Macie (left item 0) uses machine learning to discover, classify, and protect sensitive data in Amazon S3 (right item 1), such as Personally Identifiable Information (PII). AWS Security Hub (left item 1) aggregates, organizes, and prioritizes security findings from various AWS services (like GuardDuty, Inspector, and Macie) and partner solutions (right item 0), providing a comprehensive view of your security posture. Amazon Detective (left item 2) automatically collects log data from your AWS resources and uses machine learning, statistical analysis, and graph theory to help investigate potential security issues and root causes (right item 2).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  40,
  '{"left":["Amazon Macie","AWS Security Hub","Amazon Detective"],"right":["Aggregates, organizes, and prioritizes security findings from multiple AWS services.","Uses machine learning to discover, classify, and protect sensitive data in Amazon S3.","Analyzes security data to help investigate potential security issues and root causes."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_116',
  'Match the AWS security component to its role in protecting AWS resources.',
  'matching',
  '{"A":"AWS Shield Advanced","B":"Amazon GuardDuty","C":"AWS WAF"}'::json,
  NULL,
  'AWS Shield Advanced (left item 0) provides enhanced DDoS protection with advanced detection and mitigation capabilities (right item 0) for applications running on AWS, offering more comprehensive protection than Shield Standard. Amazon GuardDuty (left item 1) monitors for unexpected and potentially malicious activity in AWS accounts (right item 2), such as unusual API calls or compromised EC2 instances. AWS WAF (left item 2) filters malicious web traffic based on customizable rules (right item 1), protecting web applications from common web exploits like SQL injection and cross-site scripting.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  41,
  '{"left":["AWS Shield Advanced","Amazon GuardDuty","AWS WAF"],"right":["Provides enhanced DDoS protection with advanced detection and mitigation capabilities.","Filters malicious web traffic based on customizable rules.","Monitors for unexpected and potentially malicious activity in AWS accounts."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_117',
  'Match the AWS security service to its primary purpose.',
  'matching',
  '{"A":"Amazon Inspector","B":"AWS Security Hub","C":"Amazon Macie"}'::json,
  NULL,
  'Amazon Inspector (left item 0) is an automated security assessment service that helps identify vulnerabilities in Amazon EC2 instances and container images (right item 0). AWS Security Hub (left item 1) provides a comprehensive and centralized view of your security alerts and compliance status across multiple AWS accounts (right item 1). Amazon Macie (left item 2) is a data security and privacy service that uses machine learning to discover, classify, and protect sensitive data in Amazon S3 (right item 2).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  42,
  '{"left":["Amazon Inspector","AWS Security Hub","Amazon Macie"],"right":["Automated security assessment for vulnerabilities in EC2 instances.","Centralized view of security alerts and compliance status.","Sensitive data discovery and protection in Amazon S3."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_118',
  'Match the AWS network security control to its characteristic.',
  'matching',
  '{"A":"Security Groups","B":"Network ACLs","C":"AWS WAF"}'::json,
  NULL,
  'Security Groups (left item 0) act as a virtual firewall for EC2 instances, allowing or denying traffic based on rules (right item 0). Network ACLs (left item 1) filter traffic at the subnet level and are stateless, meaning they evaluate both inbound and outbound rules independently (right item 1). AWS WAF (left item 2) is a web application firewall that helps protect web applications or APIs from common web exploits (right item 2) that could affect availability or security.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  43,
  '{"left":["Security Groups","Network ACLs","AWS WAF"],"right":["Acts as a virtual firewall for EC2 instances, allowing or denying traffic.","Filters traffic at the subnet level, stateless.","Protects web applications or APIs from common web exploits."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_119',
  'Match the AWS security service to its primary benefit for an organization.',
  'matching',
  '{"A":"Amazon GuardDuty","B":"AWS Shield","C":"Amazon Detective"}'::json,
  NULL,
  'Amazon GuardDuty (left item 0) provides intelligent threat detection and continuous monitoring (right item 0) for malicious activity and unauthorized behavior in AWS accounts. AWS Shield (left item 1) offers protection against Distributed Denial of Service (DDoS) attacks (right item 1) at the network and transport layers. Amazon Detective (left item 2) simplifies security investigations and root cause analysis (right item 2) by automatically collecting and analyzing security data from various sources.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  44,
  '{"left":["Amazon GuardDuty","AWS Shield","Amazon Detective"],"right":["Provides intelligent threat detection and continuous monitoring.","Offers protection against Distributed Denial of Service (DDoS) attacks.","Simplifies security investigations and root cause analysis."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_120',
  'Match the AWS security service to its primary function in protecting your AWS environment.',
  'matching',
  '{"A":"AWS Shield","B":"Amazon GuardDuty","C":"AWS WAF"}'::json,
  NULL,
  'AWS Shield (left item 0) provides protection against Distributed Denial of Service (DDoS) attacks (right item 0) at the network and transport layers. Amazon GuardDuty (left item 1) offers intelligent threat detection for malicious activity and unauthorized behavior (right item 1) by continuously monitoring for suspicious API calls and network activity. AWS WAF (left item 2) filters specific web traffic patterns to protect web applications (right item 2) from common web exploits like SQL injection and cross-site scripting.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  45,
  '{"left":["AWS Shield","Amazon GuardDuty","AWS WAF"],"right":["Provides protection against Distributed Denial of Service (DDoS) attacks.","Intelligent threat detection for malicious activity and unauthorized behavior.","Filters specific web traffic patterns to protect web applications."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_121',
  'Match the AWS security service to its primary purpose for threat detection and analysis.',
  'matching',
  '{"A":"Amazon GuardDuty","B":"Amazon Inspector","C":"Amazon Detective"}'::json,
  NULL,
  'Amazon GuardDuty (left item 0) provides continuous threat detection for malicious activity and unauthorized behavior (right item 1) in your AWS accounts. Amazon Inspector (left item 1) offers automated vulnerability management for EC2 instances and container images (right item 0) by scanning for software vulnerabilities and unintended network exposure. Amazon Detective (left item 2) facilitates security investigations and root cause analysis (right item 2) by automatically collecting and analyzing security data from various sources.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  46,
  '{"left":["Amazon GuardDuty","Amazon Inspector","Amazon Detective"],"right":["Automated vulnerability management for EC2 instances and container images.","Continuous threat detection for malicious activity and unauthorized behavior.","Facilitates security investigations and root cause analysis."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_122',
  'Match the AWS security service to its primary function.',
  'matching',
  '{"A":"Amazon Macie","B":"AWS Security Hub","C":"Amazon GuardDuty"}'::json,
  NULL,
  'Amazon Macie (left item 0) discovers and protects sensitive data in Amazon S3 buckets (right item 1) using machine learning. AWS Security Hub (left item 1) aggregates and prioritizes security findings from various AWS services (right item 0) into a single dashboard. Amazon GuardDuty (left item 2) monitors for malicious activity and unauthorized behavior (right item 2) across your AWS accounts and workloads.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  47,
  '{"left":["Amazon Macie","AWS Security Hub","Amazon GuardDuty"],"right":["Aggregates and prioritizes security findings from various AWS services.","Discovers and protects sensitive data in Amazon S3 buckets.","Monitors for malicious activity and unauthorized behavior."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_123',
  'Match the AWS security service to its primary function in protecting your AWS environment.',
  'matching',
  '{"A":"AWS WAF","B":"AWS Shield Advanced","C":"Amazon Inspector"}'::json,
  NULL,
  'AWS WAF (left item 0) protects web applications from common web exploits (right item 1) by allowing you to define custom rules to filter traffic. AWS Shield Advanced (left item 1) provides enhanced DDoS protection for applications (right item 2) with more sophisticated detection and mitigation capabilities than Shield Standard. Amazon Inspector (left item 2) performs automated security assessments for vulnerabilities in EC2 instances (right item 0) and container images.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  48,
  '{"left":["AWS WAF","AWS Shield Advanced","Amazon Inspector"],"right":["Automated security assessment for vulnerabilities in EC2 instances.","Protects web applications from common web exploits.","Provides enhanced DDoS protection for applications."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_4_124',
  'Match the AWS security service to its primary focus area.',
  'matching',
  '{"A":"Network ACLs","B":"Amazon Macie","C":"AWS Security Hub"}'::json,
  NULL,
  'Network ACLs (left item 0) focus on subnet-level traffic filtering (right item 1), acting as a stateless firewall for subnets. Amazon Macie (left item 1) focuses on sensitive data discovery and classification in S3 (right item 0), using machine learning to identify PII and other sensitive information. AWS Security Hub (left item 2) provides centralized security posture management (right item 2) by aggregating and prioritizing security findings from various AWS services.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  49,
  '{"left":["Network ACLs","Amazon Macie","AWS Security Hub"],"right":["Sensitive data discovery and classification in S3.","Subnet-level traffic filtering.","Centralized security posture management."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_61_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_103',
  'Match each compliance resource to its primary function.',
  'matching',
  '{"A":"AWS Artifact","B":"Compliance Reports","C":"AWS Compliance Programs"}'::json,
  NULL,
  'Option A (AWS Artifact) is your go-to central resource for on-demand access to AWS security and compliance reports and select online agreements. Option B (Compliance Reports) are documents like SOC reports or PCI DSS attestations that demonstrate AWS''s compliance with various standards. Option C (AWS Compliance Programs) refers to the various industry-specific certifications and attestations that AWS infrastructure adheres to, such as HIPAA, PCI DSS, and SOC.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  50,
  '{"left":["AWS Artifact","Compliance Reports","AWS Compliance Programs"],"right":["Access to AWS compliance documents","Documents for auditing AWS environment","Industry-specific certifications for AWS"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_104',
  'Match each encryption concept to its definition.',
  'matching',
  '{"A":"Encryption at Rest","B":"Encryption in Transit","C":"AWS KMS"}'::json,
  NULL,
  'Option A (Encryption at Rest) refers to encrypting data when it is stored on persistent storage devices. Option B (Encryption in Transit) involves encrypting data as it moves between network endpoints. Option C (AWS KMS) is a managed service that makes it easy for you to create and control the encryption keys used to encrypt your data.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  51,
  '{"left":["Encryption at Rest","Encryption in Transit","AWS KMS"],"right":["Data encrypted when stored on disk","Data encrypted while moving over a network","Manages cryptographic keys for encryption"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_105',
  'Match each logging and auditing service to its primary purpose.',
  'matching',
  '{"A":"AWS CloudTrail","B":"AWS Config","C":"Audit Trail"}'::json,
  NULL,
  'Option A (AWS CloudTrail) records API calls made within your AWS account, providing an audit trail of actions. Option B (AWS Config) continuously monitors and records your AWS resource configurations and allows you to automate the evaluation of recorded configurations against desired configurations. Option C (Audit Trail) is a general term for a chronological record of activities, which CloudTrail and Config help to provide.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  52,
  '{"left":["AWS CloudTrail","AWS Config","Audit Trail"],"right":["Logs API activity across AWS accounts","Tracks resource configurations and changes","Record of actions and changes for accountability"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_106',
  'Match each multi-account governance tool to its primary function.',
  'matching',
  '{"A":"AWS Organizations","B":"Service Control Policies","C":"Multi-Account Strategy"}'::json,
  NULL,
  'Option A (AWS Organizations) helps you centrally manage and govern your environment as you grow and scale your AWS resources. Option B (Service Control Policies) are a type of organization policy that you can use to manage permissions in your organization, providing central control over the maximum available permissions for all accounts. Option C (Multi-Account Strategy) is a best practice for structuring your AWS environment to improve security, operational efficiency, and cost management.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  53,
  '{"left":["AWS Organizations","Service Control Policies","Multi-Account Strategy"],"right":["Centralized management of multiple AWS accounts","Restrict permissions across accounts in an organization","Best practice for isolating workloads and data"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_107',
  'Match each data protection concept to its description.',
  'matching',
  '{"A":"Encryption Keys","B":"Data Encryption","C":"Key Management"}'::json,
  NULL,
  'Option A (Encryption Keys) are cryptographic strings used in algorithms to encrypt and decrypt data. Option B (Data Encryption) is the process of encoding data so that only authorized parties can access it. Option C (Key Management) refers to the secure generation, storage, distribution, and rotation of cryptographic keys, a service provided by AWS KMS.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  54,
  '{"left":["Encryption Keys","Data Encryption","Key Management"],"right":["Cryptographic strings used for encryption/decryption","Process of transforming data to protect it","Securely storing and controlling access to keys"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_108',
  'Match each compliance standard to its primary focus.',
  'matching',
  '{"A":"HIPAA","B":"PCI DSS","C":"GDPR"}'::json,
  NULL,
  'Option A (HIPAA) is a U.S. law that sets standards for protecting sensitive patient health information. Option B (PCI DSS) is a set of security standards designed to ensure that all companies that process, store, or transmit credit card information maintain a secure environment. Option C (GDPR) is a European Union law concerning data protection and privacy for all individuals within the EU and the European Economic Area.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  55,
  '{"left":["HIPAA","PCI DSS","GDPR"],"right":["Healthcare data protection in the US","Payment card industry data security","European Union data privacy regulations"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_109',
  'Match each governance service to its primary function.',
  'matching',
  '{"A":"AWS CloudTrail","B":"AWS Config","C":"AWS Organizations"}'::json,
  NULL,
  'Option A (AWS CloudTrail) provides a record of actions taken by a user, role, or an AWS service in AWS. Option B (AWS Config) enables you to assess, audit, and evaluate the configurations of your AWS resources. Option C (AWS Organizations) helps you to centrally manage and govern your environment as you grow and scale your AWS resources.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  56,
  '{"left":["AWS CloudTrail","AWS Config","AWS Organizations"],"right":["Records API calls and account activity","Assesses and audits resource configurations","Manages multiple AWS accounts centrally"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_110',
  'Match each security reporting concept to its description.',
  'matching',
  '{"A":"Compliance Reports","B":"AWS Artifact","C":"Audit Readiness"}'::json,
  NULL,
  'Option A (Compliance Reports) are documents that provide evidence of an organization''s adherence to specific security standards or regulations. Option B (AWS Artifact) is the service that provides on-demand access to AWS''s security and compliance reports. Option C (Audit Readiness) refers to the state of being prepared for an external audit or assessment, often achieved through proper logging, configuration, and documentation.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  57,
  '{"left":["Compliance Reports","AWS Artifact","Audit Readiness"],"right":["Evidence of security controls and adherence","Portal for accessing compliance documentation","Preparedness for external security assessments"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_111',
  'Match each compliance resource to its content.',
  'matching',
  '{"A":"AWS Artifact","B":"AWS Config","C":"AWS CloudTrail"}'::json,
  NULL,
  'AWS Artifact (left[0]) provides on-demand access to AWS security and compliance reports and agreements (right[0]). AWS Config (left[1]) records and evaluates the resource configuration history (right[1]) of your AWS resources. AWS CloudTrail (left[2]) logs API call activity (right[2]) made across your AWS account.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  58,
  '{"left":["AWS Artifact","AWS Config","AWS CloudTrail"],"right":["Compliance reports and agreements","Resource configuration history","API call activity logs"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_112',
  'Match each encryption concept to its definition.',
  'matching',
  '{"A":"Encryption at rest","B":"Encryption in transit","C":"AWS KMS"}'::json,
  NULL,
  'Encryption at rest (left[0]) refers to encrypting data when it is stored on persistent storage (right[0]). Encryption in transit (left[1]) refers to encrypting data as it moves between network endpoints (right[1]). AWS Key Management Service (KMS) (left[2]) is a managed service that makes it easy to create and control encryption keys (right[2]) used to encrypt your data.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  59,
  '{"left":["Encryption at rest","Encryption in transit","AWS KMS"],"right":["Data encrypted when stored","Data encrypted during transfer","Managed encryption key service"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_113',
  'Match each governance service to its primary function.',
  'matching',
  '{"A":"AWS CloudTrail","B":"AWS Config","C":"AWS Organizations"}'::json,
  NULL,
  'AWS CloudTrail (left[0]) audits API calls (right[0]) and records events in your AWS account. AWS Config (left[1]) tracks resource changes (right[1]) and evaluates configurations against desired settings. AWS Organizations (left[2]) helps you centrally manage multiple AWS accounts (right[2]) under a single billing and management entity.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  60,
  '{"left":["AWS CloudTrail","AWS Config","AWS Organizations"],"right":["Audits API calls","Tracks resource changes","Manages multiple AWS accounts"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_114',
  'Match each compliance program to its industry focus.',
  'matching',
  '{"A":"HIPAA","B":"PCI DSS","C":"SOC"}'::json,
  NULL,
  'HIPAA (left[0]) is a compliance program focused on protecting healthcare data (right[0]). PCI DSS (left[1]) is a standard for organizations that handle payment card data (right[1]). SOC (left[2]) reports (Service Organization Control) are independent third-party examination reports that demonstrate how AWS achieves key compliance controls for security, availability, and confidentiality (right[2]).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  61,
  '{"left":["HIPAA","PCI DSS","SOC"],"right":["Healthcare data","Payment card data","Security, availability, confidentiality"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_115',
  'Match each data protection service to its role.',
  'matching',
  '{"A":"AWS KMS","B":"Amazon Macie","C":"AWS CloudTrail"}'::json,
  NULL,
  'AWS Key Management Service (KMS) (left[0]) manages encryption keys (right[0]) for various AWS services. Amazon Macie (left[1]) discovers sensitive data (right[1]) like PII in S3 buckets. AWS CloudTrail (left[2]) audits data access (right[2]) and API calls, providing an activity log.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  62,
  '{"left":["AWS KMS","Amazon Macie","AWS CloudTrail"],"right":["Manages encryption keys","Discovers sensitive data","Audits data access"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_116',
  'Match each multi-account governance tool to its scope.',
  'matching',
  '{"A":"AWS Organizations","B":"Service Control Policies","C":"AWS CloudTrail"}'::json,
  NULL,
  'AWS Organizations (left[0]) provides central account management (right[0]) for multiple AWS accounts. Service Control Policies (SCPs) (left[1]) within AWS Organizations set the maximum permissions (right[1]) that all IAM users and roles in an account can have. AWS CloudTrail (left[2]) logs actions across accounts (right[2]) within an organization when configured for multi-account logging.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  63,
  '{"left":["AWS Organizations","Service Control Policies","AWS CloudTrail"],"right":["Central account management","Sets maximum permissions for accounts","Logs actions across accounts"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_117',
  'Match each audit and logging service to the type of data it captures.',
  'matching',
  '{"A":"AWS CloudTrail","B":"AWS Config","C":"Amazon GuardDuty"}'::json,
  NULL,
  'AWS CloudTrail (left[0]) captures API activity logs (right[0]) for actions taken in your AWS account. AWS Config (left[1]) records resource configuration changes (right[1]) and compliance status. Amazon GuardDuty (left[2]) generates threat detection findings (right[2]) based on continuous monitoring of various log sources.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  64,
  '{"left":["AWS CloudTrail","AWS Config","Amazon GuardDuty"],"right":["API activity logs","Resource configuration changes","Threat detection findings"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_118',
  'Match each compliance documentation item to its access method.',
  'matching',
  '{"A":"AWS compliance reports","B":"AWS service certifications","C":"AWS GDPR Data Processing Addendum"}'::json,
  NULL,
  'AWS compliance reports (left[0]), such as SOC reports, are accessed via AWS Artifact (right[0]). AWS service certifications (left[1]), like ISO or PCI DSS attestations, are viewable in AWS Artifact (right[1]). The AWS GDPR Data Processing Addendum (left[2]) is also available in AWS Artifact (right[2]) for customers to review and accept.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  65,
  '{"left":["AWS compliance reports","AWS service certifications","AWS GDPR Data Processing Addendum"],"right":["Accessed via AWS Artifact","Viewable in AWS Artifact","Available in AWS Artifact"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_119',
  'Match each AWS compliance-related service or concept to its primary function.',
  'matching',
  '{"A":"AWS Artifact","B":"AWS CloudTrail","C":"AWS Config"}'::json,
  NULL,
  'AWS Artifact (left item 0) is the service that provides on-demand access to AWS''s security and compliance reports and agreements (right item 0). AWS CloudTrail (left item 1) is essential for governance, compliance, and operational auditing, as it records AWS API calls and account activity (right item 1). AWS Config (left item 2) helps in evaluating, auditing, and assessing the configurations of AWS resources, tracking changes over time (right item 2).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  66,
  '{"left":["AWS Artifact","AWS CloudTrail","AWS Config"],"right":["Provides on-demand access to AWS security and compliance reports.","Records AWS API calls and account activity for auditing.","Evaluates, audits, and assesses the configurations of AWS resources."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_120',
  'Match the AWS governance and compliance concept to its description.',
  'matching',
  '{"A":"Encryption at rest","B":"Service Control Policies (SCPs)","C":"AWS compliance programs (e.g., HIPAA, PCI DSS)"}'::json,
  NULL,
  'Encryption at rest (left item 0) refers to the protection of data while it is stored on persistent storage (right item 1), a critical security control. Service Control Policies (SCPs) (left item 1) are a feature of AWS Organizations that allow you to restrict the maximum available permissions for IAM users and roles in member accounts (right item 0), providing guardrails for governance. AWS compliance programs (left item 2) are the certifications and attestations that AWS maintains for its infrastructure (right item 2), which customers can leverage to meet their own compliance requirements.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  67,
  '{"left":["Encryption at rest","Service Control Policies (SCPs)","AWS compliance programs (e.g., HIPAA, PCI DSS)"],"right":["Restricts the maximum available permissions for IAM users and roles in an AWS Organization.","Protects data while it is stored on persistent storage.","Certifications and attestations AWS maintains for its infrastructure."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_121',
  'Match the encryption method to its primary use case in AWS.',
  'matching',
  '{"A":"Encryption at rest","B":"Encryption in transit","C":"AWS Key Management Service (KMS)"}'::json,
  NULL,
  'Encryption at rest (left item 0) is primarily used for protecting data stored on disks or in databases (right item 2), ensuring data confidentiality when not actively being moved. Encryption in transit (left item 1) is crucial for securing data as it travels over a network (right item 0), preventing eavesdropping or tampering. AWS Key Management Service (KMS) (left item 2) is a managed service for creating, managing, and controlling encryption keys used across various AWS services (right item 1), centralizing key management.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  68,
  '{"left":["Encryption at rest","Encryption in transit","AWS Key Management Service (KMS)"],"right":["Securing data as it travels over a network.","Managing and creating encryption keys for various AWS services.","Protecting data stored on disks or in databases."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_122',
  'Match the AWS service to its role in governance and compliance.',
  'matching',
  '{"A":"AWS Organizations","B":"AWS CloudTrail","C":"AWS Config"}'::json,
  NULL,
  'AWS Organizations (left item 0) is used to enable centralized management of multiple AWS accounts (right item 1), allowing for consolidated billing and applying governance policies like SCPs. AWS CloudTrail (left item 1) provides a centralized audit trail of API activity across all accounts in an organization (right item 0), crucial for security analysis and compliance. AWS Config (left item 2) continuously tracks resource configuration changes and assesses compliance against desired configurations (right item 2), helping maintain a compliant state.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  69,
  '{"left":["AWS Organizations","AWS CloudTrail","AWS Config"],"right":["Provides a centralized audit trail of API activity across accounts.","Enables centralized management of multiple AWS accounts.","Tracks resource configuration changes and assesses compliance."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_123',
  'Match the AWS compliance-related service to its primary purpose.',
  'matching',
  '{"A":"AWS Artifact","B":"AWS CloudTrail","C":"AWS Config"}'::json,
  NULL,
  'AWS Artifact (left item 0) provides customers with on-demand access to AWS''s compliance reports and agreements (right item 0), such as SOC reports and HIPAA Business Associate Addendums. AWS CloudTrail (left item 1) records API calls and events made by or on behalf of your AWS account (right item 1), creating an audit trail for security analysis and governance. AWS Config (left item 2) monitors and records AWS resource configurations and changes over time (right item 2), enabling compliance auditing and security analysis.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  70,
  '{"left":["AWS Artifact","AWS CloudTrail","AWS Config"],"right":["Provides access to AWS''s compliance reports and agreements.","Records API calls and events for auditing and governance.","Monitors and records AWS resource configurations and changes."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_124',
  'Match the AWS compliance feature to its primary benefit.',
  'matching',
  '{"A":"AWS Artifact","B":"Encryption at rest","C":"AWS Organizations Service Control Policies (SCPs)"}'::json,
  NULL,
  'AWS Artifact (left item 0) provides a central place to retrieve AWS compliance documentation (right item 0), such as audit reports and certifications. Encryption at rest (left item 1) protects sensitive data when it is stored in storage services (right item 2), preventing unauthorized access to the data on disk. AWS Organizations Service Control Policies (SCPs) (left item 2) enforce guardrails on permissions across multiple AWS accounts (right item 1), ensuring that accounts within an organization adhere to defined security policies.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  71,
  '{"left":["AWS Artifact","Encryption at rest","AWS Organizations Service Control Policies (SCPs)"],"right":["Provides a central place to retrieve AWS compliance documentation.","Enforces guardrails on permissions across multiple AWS accounts.","Protects sensitive data when it is stored in storage services."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_125',
  'Match the AWS compliance-related service to its primary function.',
  'matching',
  '{"A":"AWS Artifact","B":"AWS Config","C":"AWS Organizations"}'::json,
  NULL,
  'AWS Artifact (left item 0) provides on-demand access to AWS security and compliance reports (right item 1). AWS Config (left item 1) evaluates and records AWS resource configurations over time (right item 2), enabling compliance auditing and security analysis. AWS Organizations (left item 2) enables centralized management of multiple AWS accounts (right item 0), facilitating consolidated billing and applying governance policies.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  72,
  '{"left":["AWS Artifact","AWS Config","AWS Organizations"],"right":["Centralized management of multiple AWS accounts.","On-demand access to AWS security and compliance reports.","Evaluates and records AWS resource configurations over time."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_126',
  'Match the AWS compliance concept to its related service or mechanism.',
  'matching',
  '{"A":"Accessing compliance reports","B":"Auditing API activity","C":"Enforcing organizational policies"}'::json,
  NULL,
  'Accessing compliance reports (left item 0) is done through AWS Artifact (right item 1), which provides on-demand access to AWS''s security and compliance documents. Auditing API activity (left item 1) for governance and security is a primary function of AWS CloudTrail (right item 0). Enforcing organizational policies (left item 2) across multiple AWS accounts is achieved using Service Control Policies (SCPs) in AWS Organizations (right item 2).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  73,
  '{"left":["Accessing compliance reports","Auditing API activity","Enforcing organizational policies"],"right":["AWS CloudTrail","AWS Artifact","Service Control Policies (SCPs) in AWS Organizations"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_2_127',
  'Match the AWS governance concept to its primary mechanism.',
  'matching',
  '{"A":"Audit trail of actions","B":"Configuration compliance","C":"Centralized account management"}'::json,
  NULL,
  'An audit trail of actions (left item 0) performed in your AWS account is provided by AWS CloudTrail (right item 0). Configuration compliance (left item 1), which involves continuously monitoring and assessing resource configurations against desired baselines, is handled by AWS Config (right item 2). Centralized account management (left item 2) for multiple AWS accounts, including consolidated billing and policy enforcement, is managed by AWS Organizations (right item 1).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  74,
  '{"left":["Audit trail of actions","Configuration compliance","Centralized account management"],"right":["AWS CloudTrail","AWS Organizations","AWS Config"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_61_1
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_84',
  'Match each aspect of the Shared Responsibility Model to the responsible party.',
  'matching',
  '{"A":"Security OF the Cloud","B":"Security IN the Cloud","C":"Shared Responsibility"}'::json,
  NULL,
  'Option A (Security OF the Cloud) is AWS''s responsibility, covering the underlying infrastructure that runs all AWS services. Option B (Security IN the Cloud) is the customer''s responsibility, covering their data, applications, and configurations within AWS services. Option C (Shared Responsibility) describes the model where both AWS and the customer have security duties.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  75,
  '{"left":["Security OF the Cloud","Security IN the Cloud","Shared Responsibility"],"right":["AWS''s responsibility","Customer''s responsibility","Joint security duties"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_85',
  'Match each specific duty to the customer''s responsibility under the Shared Responsibility Model.',
  'matching',
  '{"A":"Data Encryption","B":"OS Patching (EC2)","C":"Security Group Configuration"}'::json,
  NULL,
  'Option A (Data Encryption) is the customer''s responsibility to encrypt their data, both at rest and in transit. Option B (OS Patching (EC2)) for EC2 instances is the customer''s duty, as EC2 is an IaaS service. Option C (Security Group Configuration) involves setting up the rules for security groups, which is a customer responsibility to control network traffic.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  76,
  '{"left":["Data Encryption","OS Patching (EC2)","Security Group Configuration"],"right":["Encrypting sensitive data in transit and at rest","Updating the operating system on EC2 instances","Defining network access rules for instances"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_86',
  'Match each AWS service type to how the Shared Responsibility Model shifts.',
  'matching',
  '{"A":"IaaS (EC2)","B":"Managed Service (RDS)","C":"Serverless (Lambda)"}'::json,
  NULL,
  'Option A (IaaS (EC2)) places most of the responsibility on the customer, including the operating system, applications, and data. Option B (Managed Service (RDS)) shifts more responsibility to AWS, which manages the operating system, database engine patching, and backups. Option C (Serverless (Lambda)) shifts almost all operational responsibility to AWS, with the customer primarily responsible for their code and data.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  77,
  '{"left":["IaaS (EC2)","Managed Service (RDS)","Serverless (Lambda)"],"right":["Most customer responsibility","AWS manages OS and database engine","AWS manages almost everything, less customer responsibility"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_87',
  'Match each security aspect to the party primarily responsible for it.',
  'matching',
  '{"A":"Customer Data","B":"Application Security","C":"AWS Global Infrastructure"}'::json,
  NULL,
  'Option A (Customer Data) is always the customer''s responsibility to secure. Option B (Application Security) for applications deployed on AWS is also the customer''s responsibility. Option C (AWS Global Infrastructure) refers to the physical facilities, network, and hardware, which are AWS''s responsibility.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  78,
  '{"left":["Customer Data","Application Security","AWS Global Infrastructure"],"right":["Customer''s responsibility","Customer''s responsibility","AWS''s responsibility"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_88',
  'Match each AWS managed component to its description.',
  'matching',
  '{"A":"Physical Security","B":"Managed Service Patching","C":"Hypervisor Layer"}'::json,
  NULL,
  'Option A (Physical Security) of AWS data centers is entirely managed by AWS. Option B (Managed Service Patching) refers to AWS''s responsibility to patch the operating systems and underlying software for managed services like Amazon RDS. Option C (Hypervisor Layer) is the virtualization software that AWS manages, providing the foundation for EC2 instances and other services.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  79,
  '{"left":["Physical Security","Managed Service Patching","Hypervisor Layer"],"right":["Securing AWS data centers and hardware","Updating underlying OS for services like RDS","Virtualization software beneath guest OS"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_89',
  'Match each customer managed component to its description.',
  'matching',
  '{"A":"Guest Operating System","B":"IAM Configuration","C":"Network Access Control Lists"}'::json,
  NULL,
  'Option A (Guest Operating System) on an Amazon EC2 instance is the customer''s responsibility to configure and patch. Option B (IAM Configuration) involves setting up users, groups, roles, and policies, which is a customer responsibility. Option C (Network Access Control Lists) are subnet-level firewalls that customers must configure to control traffic.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  80,
  '{"left":["Guest Operating System","IAM Configuration","Network Access Control Lists"],"right":["OS installed on Amazon EC2 instances","User and permission management in AWS","Subnet-level firewall rules for traffic"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_90',
  'Match each security model component to its role.',
  'matching',
  '{"A":"Security OF the Cloud","B":"Security IN the Cloud","C":"Shared Responsibility Model"}'::json,
  NULL,
  'Option A (Security OF the Cloud) describes AWS''s role in protecting the infrastructure that runs all of the services offered in the AWS Cloud. Option B (Security IN the Cloud) describes the customer''s responsibility and control over their data, applications, and configurations within AWS services. Option C (Shared Responsibility Model) is the overarching framework that defines the security duties between AWS and its customers.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  81,
  '{"left":["Security OF the Cloud","Security IN the Cloud","Shared Responsibility Model"],"right":["AWS''s responsibility for infrastructure protection","Customer''s responsibility for application protection","Defines the division of security duties"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_91',
  'Match each shared responsibility concept to the party primarily responsible.',
  'matching',
  '{"A":"Security OF the cloud","B":"Security IN the cloud","C":"Customer data encryption"}'::json,
  NULL,
  'Security OF the cloud (left[0]) is AWS''s responsibility (right[0]), covering the underlying infrastructure. Security IN the cloud (left[1]) is the customer''s responsibility (right[1]), covering their data, applications, and configurations. Customer data encryption (left[2]) is explicitly a customer responsibility (right[2]) under the shared responsibility model.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  82,
  '{"left":["Security OF the cloud","Security IN the cloud","Customer data encryption"],"right":["AWS responsibility","Customer responsibility","Customer responsibility"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_92',
  'Match each AWS responsibility to its example.',
  'matching',
  '{"A":"Physical infrastructure","B":"Hypervisor","C":"Managed service patching"}'::json,
  NULL,
  'Physical infrastructure (left[0]) refers to AWS data centers (right[0]), which AWS is responsible for securing. The Hypervisor (left[1]), the virtualization layer beneath guest operating systems, is also AWS''s responsibility (right[1]). Managed service patching (left[2]), such as operating system updates for Amazon RDS, is handled by AWS (right[2]).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  83,
  '{"left":["Physical infrastructure","Hypervisor","Managed service patching"],"right":["AWS data centers","Virtualization layer","RDS OS updates"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_93',
  'Match each customer responsibility to its example.',
  'matching',
  '{"A":"OS patching on EC2","B":"Security Group configuration","C":"IAM management"}'::json,
  NULL,
  'OS patching on EC2 (left[0]) instances, such as updating Windows or Linux, is the customer''s responsibility (right[0]). Security Group configuration (left[1]), including defining inbound and outbound rules, is also managed by the customer (right[1]). IAM management (left[2]), which involves creating users, groups, roles, and policies, falls under the customer''s purview (right[2]).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  84,
  '{"left":["OS patching on EC2","Security Group configuration","IAM management"],"right":["Updating Windows/Linux on instances","Defining inbound/outbound rules","Creating users and policies"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_94',
  'Match each service type to how shared responsibility shifts.',
  'matching',
  '{"A":"IaaS (EC2)","B":"Managed Service (RDS)","C":"Serverless (Lambda)"}'::json,
  NULL,
  'For IaaS services like Amazon EC2 (left[0]), the customer manages the operating system and everything above it (right[0]). For Managed Services like Amazon RDS (left[1]), AWS manages the operating system and the database engine (right[1]). For Serverless services like AWS Lambda (left[2]), AWS manages the underlying infrastructure and runtime environment (right[2]), significantly reducing customer responsibility.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  85,
  '{"left":["IaaS (EC2)","Managed Service (RDS)","Serverless (Lambda)"],"right":["Customer manages OS and above","AWS manages OS and database","AWS manages runtime and infrastructure"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_95',
  'Match each security task to its responsible party under the shared responsibility model.',
  'matching',
  '{"A":"Patching EC2 OS","B":"Patching RDS OS","C":"Physical security of data centers"}'::json,
  NULL,
  'Patching the operating system on an EC2 instance (left[0]) is the customer''s responsibility (right[0]). Patching the operating system for an Amazon RDS instance (left[1]) is AWS''s responsibility (right[1]) as it''s a managed service. The physical security of data centers (left[2]) is always AWS''s responsibility (right[2]).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  86,
  '{"left":["Patching EC2 OS","Patching RDS OS","Physical security of data centers"],"right":["Customer","AWS","AWS"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_96',
  'Match each shared responsibility component to its category.',
  'matching',
  '{"A":"AWS Global Infrastructure","B":"Customer applications","C":"Data encryption"}'::json,
  NULL,
  'AWS Global Infrastructure (left[0]) falls under Security OF the Cloud (right[0]), which is AWS''s responsibility. Customer applications (left[1]) are part of Security IN the Cloud (right[1]), which is the customer''s responsibility. Data encryption (left[2]) is a shared responsibility (right[2]), where AWS provides the tools (like KMS) and the customer implements them.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  87,
  '{"left":["AWS Global Infrastructure","Customer applications","Data encryption"],"right":["Security OF the Cloud","Security IN the Cloud","Shared responsibility"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_97',
  'Match each security control type to its owner.',
  'matching',
  '{"A":"Network infrastructure","B":"Customer data","C":"IAM policies"}'::json,
  NULL,
  'The underlying Network infrastructure (left[0]) is managed and secured by AWS (right[0]). Customer data (left[1]), including its encryption and access, is the customer''s responsibility (right[1]). IAM policies (left[2]) are configured and managed by the customer (right[2]) to control access to their resources.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  88,
  '{"left":["Network infrastructure","Customer data","IAM policies"],"right":["AWS","Customer","Customer"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_98',
  'Match each shared responsibility example to the responsible party.',
  'matching',
  '{"A":"AWS hardware","B":"Customer OS on EC2","C":"AWS Lambda runtime"}'::json,
  NULL,
  'AWS hardware (left[0]) is part of the physical infrastructure, making it AWS''s responsibility (right[0]). The Customer OS on EC2 (left[1]) is managed by the customer (right[1]) in an IaaS model. The AWS Lambda runtime (left[2]) environment is managed by AWS (right[2]) in a serverless model.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  89,
  '{"left":["AWS hardware","Customer OS on EC2","AWS Lambda runtime"],"right":["AWS","Customer","AWS"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_99',
  'Match the AWS shared responsibility model concept to its description.',
  'matching',
  '{"A":"Security OF the Cloud","B":"Security IN the Cloud","C":"Responsibility for managed services (e.g., Amazon RDS)"}'::json,
  NULL,
  'Security OF the Cloud (left item 0) refers to AWS''s responsibility for the underlying infrastructure, hardware, and global network (right item 1). Security IN the Cloud (left item 1) refers to the customer''s responsibility for their data, applications, operating systems (for IaaS), and network configuration (right item 0). For managed services like Amazon RDS (left item 2), AWS takes on more responsibility, handling OS patching and database engine updates, while the customer remains responsible for their data and access management (right item 2).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  90,
  '{"left":["Security OF the Cloud","Security IN the Cloud","Responsibility for managed services (e.g., Amazon RDS)"],"right":["Customer is responsible for data, applications, OS, and network configuration.","AWS manages the underlying infrastructure, hardware, and global network.","AWS handles OS patching and database engine updates; customer manages data and access."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_100',
  'Match the customer''s security responsibility to the specific action required for an AWS workload.',
  'matching',
  '{"A":"Protecting data stored in Amazon S3","B":"Updating the operating system on an Amazon EC2 instance","C":"Controlling access to AWS resources"}'::json,
  NULL,
  'Protecting data stored in Amazon S3 (left item 0) is a customer responsibility, primarily achieved by enabling encryption at rest for S3 buckets (right item 1) and configuring appropriate bucket policies. Updating the operating system on an Amazon EC2 instance (left item 1) falls under the customer''s ''security IN the cloud'' duties, requiring them to apply security patches to the EC2''s guest OS (right item 2). Controlling access to AWS resources (left item 2) is managed by the customer through configuring AWS Identity and Access Management (IAM) policies (right item 0) to enforce the principle of least privilege.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  91,
  '{"left":["Protecting data stored in Amazon S3","Updating the operating system on an Amazon EC2 instance","Controlling access to AWS resources"],"right":["Configuring AWS Identity and Access Management (IAM) policies.","Enabling encryption at rest for S3 buckets.","Applying security patches to the EC2''s guest OS."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_101',
  'Match the AWS shared responsibility model responsibility to the correct category.',
  'matching',
  '{"A":"Security of the physical facility","B":"Customer data encryption","C":"Patching the underlying host OS for Amazon RDS"}'::json,
  NULL,
  'The security of the physical facility (left item 0) where AWS services operate is entirely AWS''s Responsibility (right item 1). Customer data encryption (left item 1) is typically the Customer''s Responsibility (right item 0), although AWS provides services like AWS KMS to assist. Patching the underlying host OS for Amazon RDS (left item 2) is AWS''s Responsibility (right item 1) as RDS is a managed service where AWS handles the database engine and operating system maintenance.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  92,
  '{"left":["Security of the physical facility","Customer data encryption","Patching the underlying host OS for Amazon RDS"],"right":["Customer Responsibility","AWS Responsibility","Shared Responsibility"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_102',
  'Match the AWS shared responsibility model component to the party primarily responsible.',
  'matching',
  '{"A":"Security of the hypervisor","B":"Application-level security","C":"Configuration of Amazon S3 bucket policies"}'::json,
  NULL,
  'Security of the hypervisor (left item 0) is a core part of ''security OF the cloud'' and is the responsibility of AWS (right item 1). Application-level security (left item 1), including the code and configuration of customer applications, is the responsibility of the Customer (right item 0). Configuration of Amazon S3 bucket policies (left item 2) to control access to customer data is also a Customer responsibility (right item 0) under ''security IN the cloud''.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  93,
  '{"left":["Security of the hypervisor","Application-level security","Configuration of Amazon S3 bucket policies"],"right":["Customer","AWS","Shared"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_103',
  'Match the AWS shared responsibility model concept to its application.',
  'matching',
  '{"A":"Security OF the Cloud","B":"Security IN the Cloud","C":"Shared responsibility for patching"}'::json,
  NULL,
  'Security OF the Cloud (left item 0) refers to AWS''s responsibility for the physical infrastructure and global network (right item 0). Security IN the Cloud (left item 1) refers to the customer''s responsibility for their application code and data encryption (right item 1). The concept of shared responsibility for patching (left item 2) is exemplified by AWS patching the underlying OS for managed services like Amazon RDS, while the customer is responsible for patching the guest OS on their Amazon EC2 instances (right item 2).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  94,
  '{"left":["Security OF the Cloud","Security IN the Cloud","Shared responsibility for patching"],"right":["AWS manages the physical infrastructure and global network.","Customer is responsible for application code and data encryption.","AWS patches the underlying OS for Amazon RDS, customer patches EC2 OS."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_104',
  'Match the AWS shared responsibility model concept to its definition.',
  'matching',
  '{"A":"AWS''s responsibility for physical security","B":"Customer''s responsibility for data encryption","C":"Shared responsibility for network controls"}'::json,
  NULL,
  'AWS''s responsibility for physical security (left item 0) means AWS secures the underlying infrastructure, including data centers and hardware (right item 0). Customer''s responsibility for data encryption (left item 1) means the customer encrypts their data, while AWS provides the services like AWS KMS to facilitate this (right item 2). Shared responsibility for network controls (left item 2) means the customer configures security groups and Network ACLs, while AWS provides the underlying network infrastructure (right item 1).',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  95,
  '{"left":["AWS''s responsibility for physical security","Customer''s responsibility for data encryption","Shared responsibility for network controls"],"right":["AWS secures the underlying infrastructure, including data centers.","Customer configures security groups and Network ACLs.","Customer encrypts their data, while AWS provides encryption services."]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_61_m_61_1_105',
  'Match the AWS shared responsibility model concept to the party responsible for it.',
  'matching',
  '{"A":"Security of the network infrastructure (e.g., routers, switches)","B":"Configuration of customer-managed databases (e.g., on EC2)","C":"Security of the virtualized environment (hypervisor)"}'::json,
  NULL,
  'Security of the network infrastructure (left item 0), including the physical routers and switches, is the responsibility of AWS (right item 1). Configuration of customer-managed databases (left item 1), such as those running on an EC2 instance, falls under the Customer''s responsibility (right item 0). Security of the virtualized environment (left item 2), specifically the hypervisor layer, is a core part of AWS''s responsibility (right item 1) in ''security OF the cloud''.',
  NOW(),
  'quiz_domain61_13',
  NOW(),
  96,
  '{"left":["Security of the network infrastructure (e.g., routers, switches)","Configuration of customer-managed databases (e.g., on EC2)","Security of the virtualized environment (hypervisor)"],"right":["Customer","AWS","Shared"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_61_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_106'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_107'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_108'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_109'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_110'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_111'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_112'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_113'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_114'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_115'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_116'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_117'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_118'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_119'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_120'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_121'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_122'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_123'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_124'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_125'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_126'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_127'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_128'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_129'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_130'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_3_131'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_102'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_103'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_104'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_105'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_106'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_107'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_108'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_109'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_110'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_111'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_112'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_113'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_114'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_115'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_116'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_117'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_118'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_119'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_120'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_121'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_122'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_123'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_4_124'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_103'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_104'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_105'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_106'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_107'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_108'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_109'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_110'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_111'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_112'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_113'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_114'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_115'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_116'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_117'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_118'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_119'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_120'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_121'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_122'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_123'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_124'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_125'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_126'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_2_127'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_84'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_85'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_86'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_87'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_88'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_89'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_90'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_91'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_92'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_93'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_94'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_95'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_96'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_97'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_98'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_99'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_100'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_101'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_102'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_103'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_104'),
  (NOW(), 'quiz_domain61_13', 'q_61_m_61_1_105')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain61_13'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;

-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: CLF-C02
-- Generated: 2026-03-19T02:32:31.322Z
-- Questions: 46 (46 validated, 18 rejected)
-- Quiz ID: quiz_domain63_13
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_63_1
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_92',
  'Match each AWS pricing model to its primary characteristic.',
  'matching',
  '{"A":"On-Demand","B":"Reserved Instances","C":"Spot Instances"}'::json,
  NULL,
  'On-Demand pricing allows you to pay for compute capacity by the second or hour with no long-term commitments. Reserved Instances offer significant discounts (up to 72%) in exchange for a 1- or 3-year commitment. Spot Instances allow you to bid on unused EC2 capacity, offering up to a 90% discount, but can be interrupted.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  1,
  '{"left":["On-Demand","Reserved Instances","Spot Instances"],"right":["Pay for compute by the second","Commit to 1 or 3 years for discount","Bid on unused EC2 capacity"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_93',
  'Match each AWS Free Tier type to its description.',
  'matching',
  '{"A":"Always Free","B":"12 Months Free","C":"Short-term trials"}'::json,
  NULL,
  'The Always Free tier includes offers that do not expire and are available to all AWS customers. The 12 Months Free tier is available to new AWS accounts for 12 months following their AWS sign-up date. Short-term trials are limited-time offers for certain services.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  2,
  '{"left":["Always Free","12 Months Free","Short-term trials"],"right":["Services with no expiration","Available for new accounts for one year","Limited-time service offers"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_94',
  'Match the data transfer scenario to its typical pricing.',
  'matching',
  '{"A":"Data transfer IN to AWS","B":"Data transfer OUT from AWS","C":"Data transfer between AWS Regions"}'::json,
  NULL,
  'Data transfer inbound to AWS from the internet is generally free. Data transfer outbound from AWS to the internet is charged per gigabyte. Data transfer between different AWS Regions is also charged per gigabyte.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  3,
  '{"left":["Data transfer IN to AWS","Data transfer OUT from AWS","Data transfer between AWS Regions"],"right":["Generally free","Charged per gigabyte","Charged per gigabyte"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_95',
  'Match each AWS service to its primary pricing dimension.',
  'matching',
  '{"A":"Amazon EC2","B":"Amazon S3","C":"AWS Lambda"}'::json,
  NULL,
  'Amazon EC2 instances are primarily priced by the instance type and the number of instance hours consumed. Amazon S3 pricing is based on storage used and data transfer/requests. AWS Lambda is priced based on the number of invocations and the duration of compute time.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  4,
  '{"left":["Amazon EC2","Amazon S3","AWS Lambda"],"right":["Instance hours","Storage and data requests","Invocations and compute duration"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_96',
  'Match the AWS pricing model to its suitability for workloads.',
  'matching',
  '{"A":"On-Demand","B":"Reserved Instances","C":"Spot Instances"}'::json,
  NULL,
  'On-Demand pricing is best suited for unpredictable workloads with short durations or fluctuating demand, as it offers maximum flexibility. Reserved Instances are ideal for steady-state, predictable workloads that run continuously. Spot Instances are highly cost-effective for fault-tolerant batch jobs or tasks that can be interrupted.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  5,
  '{"left":["On-Demand","Reserved Instances","Spot Instances"],"right":["Unpredictable workloads","Steady-state workloads","Fault-tolerant batch jobs"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_97',
  'Match each AWS pricing model to its primary characteristic.',
  'matching',
  '{"A":"On-Demand pricing","B":"Reserved Instances","C":"Spot Instances"}'::json,
  NULL,
  'On-Demand pricing allows users to pay for compute or services by the second or hour with no long-term commitment, offering maximum flexibility. Reserved Instances provide significant discounts (up to 72%) in exchange for a 1- or 3-year commitment, ideal for predictable workloads. Spot Instances offer up to 90% savings by bidding on unused EC2 capacity, but they can be interrupted by AWS with short notice, making them suitable for fault-tolerant workloads.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  6,
  '{"left":["On-Demand pricing","Reserved Instances","Spot Instances"],"right":["Pay-as-you-go, no commitment","Long-term commitment for discounts","Bid on unused capacity, interruptible"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_98',
  'Match the AWS data transfer scenario to its typical pricing model.',
  'matching',
  '{"A":"Data transfer IN to AWS","B":"Data transfer OUT to the internet","C":"Data transfer between Availability Zones"}'::json,
  NULL,
  'Data transfer into AWS from the internet is generally free across most services. Data transfer out from AWS to the internet is typically charged per gigabyte (GB), and these costs can be significant for data-intensive applications. Data transfer between different Availability Zones within the same AWS Region is also charged per gigabyte (GB) for most services, as it involves network traffic across distinct physical locations.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  7,
  '{"left":["Data transfer IN to AWS","Data transfer OUT to the internet","Data transfer between Availability Zones"],"right":["Generally free of charge","Charged per gigabyte (GB)","Charged per gigabyte (GB)"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_99',
  'Match each component of the AWS Free Tier to its description.',
  'matching',
  '{"A":"Always Free tier","B":"12 Months Free tier","C":"Short-term trial offers"}'::json,
  NULL,
  'The Always Free tier provides access to certain AWS services up to a specific usage limit, available indefinitely to all AWS customers. The 12 Months Free tier offers free usage of specific services for a limited amount up to 12 months following your AWS sign-up date. Short-term trial offers provide free access to certain services for a limited time or specific events, allowing users to explore new services.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  8,
  '{"left":["Always Free tier","12 Months Free tier","Short-term trial offers"],"right":["Available indefinitely for all customers","Limited for the first year of account creation","Specific service offers for a limited period"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_100',
  'Match the workload type to the most cost-effective AWS pricing model.',
  'matching',
  '{"A":"Predictable steady-state workload","B":"Fault-tolerant batch processing","C":"Unpredictable short-term tasks"}'::json,
  NULL,
  'For predictable steady-state workloads that run continuously, Reserved Instances or Savings Plans offer the most significant cost savings due to the commitment. Fault-tolerant batch processing, where tasks can be interrupted and restarted, is ideally suited for Spot Instances, which provide deep discounts. Unpredictable short-term tasks that require flexibility without commitment are best suited for On-Demand pricing.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  9,
  '{"left":["Predictable steady-state workload","Fault-tolerant batch processing","Unpredictable short-term tasks"],"right":["Reserved Instances or Savings Plans","Spot Instances","On-Demand pricing"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_101',
  'Match each AWS service to its primary billing dimension.',
  'matching',
  '{"A":"Amazon S3","B":"AWS Lambda","C":"Amazon EC2"}'::json,
  NULL,
  'Amazon S3 pricing is primarily based on the amount of data stored, the number of requests made (GET, PUT, etc.), and data transfer out. AWS Lambda charges are based on the number of times a function is invoked and the duration (compute time) it runs. Amazon EC2 instances are billed based on the instance type, the operating system, and the number of instance hours consumed.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  10,
  '{"left":["Amazon S3","AWS Lambda","Amazon EC2"],"right":["Storage capacity and requests","Number of invocations and duration","Instance hours and configuration"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_102',
  'Match the cost optimization strategy to the specific use case.',
  'matching',
  '{"A":"Running a 24/7 web server","B":"Restartable batch processing","C":"New service experimentation"}'::json,
  NULL,
  'For a 24/7 web server, which is a predictable and continuous workload, utilizing Reserved Instances or Savings Plans provides substantial cost savings over On-Demand pricing. Restartable batch processing, which can tolerate interruptions, is a perfect fit for leveraging Spot Instances to achieve significant discounts. For experimenting with new AWS services or learning, using the AWS Free Tier helps avoid costs during the initial exploration phase.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  11,
  '{"left":["Running a 24/7 web server","Restartable batch processing","New service experimentation"],"right":["Utilize Reserved Instances","Leverage Spot Instances","Use the AWS Free Tier"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_103',
  'Match the Savings Plan type to the AWS services it covers.',
  'matching',
  '{"A":"Compute Savings Plans","B":"EC2 Instance Savings Plans","C":"SageMaker Savings Plans"}'::json,
  NULL,
  'Compute Savings Plans offer the most flexibility, applying to usage across AWS Fargate, AWS Lambda, and Amazon EC2 instances, regardless of instance family, Region, or OS. EC2 Instance Savings Plans apply specifically to Amazon EC2 instance usage, offering lower prices in exchange for commitment to an individual instance family in a Region. SageMaker Savings Plans apply to Amazon SageMaker ML instance usage, providing discounts for a committed spend.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  12,
  '{"left":["Compute Savings Plans","EC2 Instance Savings Plans","SageMaker Savings Plans"],"right":["AWS Fargate, AWS Lambda, Amazon EC2","Amazon EC2 instance usage only","Amazon SageMaker ML instances"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_104',
  'A global enterprise is optimizing its AWS expenditure across diverse workloads, ranging from steady-state production databases to intermittent batch processing and new development environments. The finance team requires a clear understanding of how different EC2 pricing models align with specific operational needs and cost objectives. Match each workload characteristic to the most cost-effective Amazon EC2 pricing model.',
  'matching',
  '{"A":"Predictable, long-term compute needs","B":"Fault-tolerant, interruptible batch jobs","C":"Flexible, short-duration testing","D":"Consistent usage with flexible instance types"}'::json,
  NULL,
  'For predictable, long-term compute needs (Option A), Reserved Instances (Option C) offer significant discounts for a 1- or 3-year commitment. Fault-tolerant, interruptible batch jobs (Option B) are best suited for Spot Instances (Option B), which provide up to 90% savings but can be interrupted. Flexible, short-duration testing (Option C) is ideal for On-Demand Instances (Option A) due to their pay-as-you-go nature with no commitment. Consistent usage with flexible instance types (Option D) can leverage Savings Plans (Option D) for a commitment to a consistent amount of compute usage, regardless of instance family or Region, offering greater flexibility than Reserved Instances.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  13,
  '{"left":["Predictable, long-term compute needs","Fault-tolerant, interruptible batch jobs","Flexible, short-duration testing","Consistent usage with flexible instance types"],"right":["On-Demand Instances","Spot Instances","Reserved Instances","Savings Plans"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_105',
  'A startup is launching its first application on AWS and is keen to manage costs effectively from day one. They need to understand how different AWS services are priced to accurately forecast their monthly expenses. Match each AWS service''s primary pricing dimension to its typical billing model.',
  'matching',
  '{"A":"Amazon EC2","B":"AWS Lambda","C":"Amazon S3","D":"Data Transfer Out"}'::json,
  NULL,
  'Amazon EC2 (Option A) is primarily priced based on instance hours (Option C) or seconds, depending on the instance type. AWS Lambda (Option B) is billed based on the number of invocations and the duration (Option A) of each invocation. Amazon S3 (Option C) pricing is determined by the amount of storage used and the number of requests (Option B) made to the objects. Data Transfer Out (Option D) from AWS to the internet is generally charged per gigabyte (Option D) transferred.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  14,
  '{"left":["Amazon EC2","AWS Lambda","Amazon S3","Data Transfer Out"],"right":["Invocations and duration","Storage and requests","Instance hours","Per gigabyte"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_106',
  'A development team is experimenting with new AWS services and needs to manage costs carefully, especially during the initial exploration phase. They want to leverage any available free resources to minimize expenditure before committing to production deployments. Match each AWS Free Tier offer to its corresponding service.',
  'matching',
  '{"A":"Amazon EC2","B":"Amazon S3","C":"AWS Lambda","D":"Amazon RDS"}'::json,
  NULL,
  'The AWS Free Tier for Amazon EC2 (Option A) includes 750 hours per month of t2.micro or t3.micro instances (Option B). For Amazon S3 (Option B), the Free Tier provides 5 GB of Standard Storage (Option A). AWS Lambda (Option C) offers 1 million free requests (Option C) per month. Amazon RDS (Option D) includes 750 hours per month of db.t2.micro or db.t3.micro instances (Option D) for single-AZ deployments.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  15,
  '{"left":["Amazon EC2","Amazon S3","AWS Lambda","Amazon RDS"],"right":["5 GB Standard Storage","750 hours t2.micro/t3.micro","1 million requests","750 hours db.t2.micro/db.t3.micro"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_107',
  'A financial services company is migrating its on-premises data center to AWS and needs to understand the cost implications of data movement. They are particularly concerned about data transfer costs between different AWS components and to external networks. Match each data transfer scenario to its typical pricing characteristic.',
  'matching',
  '{"A":"Data transfer in to AWS","B":"Data transfer out to the internet","C":"Data transfer between AWS Regions","D":"Data transfer within the same Availability Zone"}'::json,
  NULL,
  'Data transfer in to AWS (Option A) from the internet is generally free (Option A) across most services. Data transfer out to the internet (Option B) from AWS services is typically charged per GB (Option B). Data transfer between different AWS Regions (Option C) is also charged per GB (Option C). Data transfer within the same Availability Zone (Option D) between AWS services is generally free (Option D).',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  16,
  '{"left":["Data transfer in to AWS","Data transfer out to the internet","Data transfer between AWS Regions","Data transfer within the same Availability Zone"],"right":["Generally free","Charged per GB","Charged per GB","Generally free"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_1_108',
  'A media company runs various analytics jobs that can tolerate interruptions and are not time-sensitive. They are looking for the most cost-effective way to run these workloads on Amazon EC2 without over-provisioning. Match each pricing model characteristic to its primary benefit for such flexible workloads.',
  'matching',
  '{"A":"Deepest discounts for interruptible tasks","B":"No upfront commitment, pay-as-you-go","C":"Significant savings for consistent usage","D":"Fixed hourly rate for 1 or 3 years"}'::json,
  NULL,
  'For the deepest discounts on interruptible tasks (Option A), Spot Instances (Option C) are the most suitable option, offering up to 90% savings. For workloads requiring no upfront commitment and a pay-as-you-go model (Option B), On-Demand Instances (Option B) provide flexibility. Significant savings for consistent usage (Option C) across compute services are best achieved with Savings Plans (Option D). A fixed hourly rate for a 1 or 3-year term (Option D) is characteristic of Reserved Instances (Option A), which offer discounts for specific instance types.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  17,
  '{"left":["Deepest discounts for interruptible tasks","No upfront commitment, pay-as-you-go","Significant savings for consistent usage","Fixed hourly rate for 1 or 3 years"],"right":["Reserved Instances","On-Demand Instances","Spot Instances","Savings Plans"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_63_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_91',
  'Match each AWS cost management tool to its primary function.',
  'matching',
  '{"A":"AWS Cost Explorer","B":"AWS Budgets","C":"AWS Cost and Usage Report"}'::json,
  NULL,
  'AWS Cost Explorer allows you to visualize, understand, and manage your AWS costs and usage over time. AWS Budgets enables you to set custom budgets to track your costs and usage and receive alerts when thresholds are exceeded. The AWS Cost and Usage Report provides comprehensive, detailed line-item billing data.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  18,
  '{"left":["AWS Cost Explorer","AWS Budgets","AWS Cost and Usage Report"],"right":["Visualize and analyze spending","Set custom cost and usage alerts","Detailed line-item billing data"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_92',
  'Match the cost management feature to its purpose.',
  'matching',
  '{"A":"Cost allocation tags","B":"AWS Organizations consolidated billing","C":"AWS Billing Dashboard"}'::json,
  NULL,
  'Cost allocation tags are used to categorize and track costs across different projects, teams, or environments. AWS Organizations consolidated billing allows you to combine billing for multiple AWS accounts into a single bill, often leading to volume discounts. The AWS Billing Dashboard provides a high-level overview of your current and past spending.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  19,
  '{"left":["Cost allocation tags","AWS Organizations consolidated billing","AWS Billing Dashboard"],"right":["Track costs by project or team","Aggregate billing for multiple accounts","Overview of account-level spending"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_93',
  'Match the AWS Budgets feature to what it monitors.',
  'matching',
  '{"A":"Cost budgets","B":"Usage budgets","C":"Reservation utilization budgets"}'::json,
  NULL,
  'Cost budgets monitor your actual spending against a defined cost threshold. Usage budgets track your resource consumption (e.g., EC2 instance hours). Reservation utilization budgets help you track how effectively your Reserved Instances or Savings Plans are being used.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  20,
  '{"left":["Cost budgets","Usage budgets","Reservation utilization budgets"],"right":["Monitor actual vs. budgeted costs","Track resource consumption","Track efficiency of RIs/Savings Plans"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_94',
  'Match the cost analysis capability to the AWS tool.',
  'matching',
  '{"A":"Historical spending analysis","B":"Cost forecasting","C":"Identifying savings opportunities"}'::json,
  NULL,
  'AWS Cost Explorer provides capabilities for analyzing historical spending patterns, forecasting future costs based on past usage, and identifying potential savings opportunities like underutilized resources or Reserved Instance recommendations.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  21,
  '{"left":["Historical spending analysis","Cost forecasting","Identifying savings opportunities"],"right":["AWS Cost Explorer","AWS Cost Explorer","AWS Cost Explorer"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_95',
  'Match the cost management action to the appropriate AWS service.',
  'matching',
  '{"A":"Visualize spending trends","B":"Receive alerts for overspending","C":"Allocate costs to departments"}'::json,
  NULL,
  'To visualize spending trends, you would use AWS Cost Explorer. To receive alerts when your spending exceeds a predefined threshold, you would configure AWS Budgets. To allocate costs to specific departments or projects, you would apply cost allocation tags to your resources.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  22,
  '{"left":["Visualize spending trends","Receive alerts for overspending","Allocate costs to departments"],"right":["AWS Cost Explorer","AWS Budgets","Cost allocation tags"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_96',
  'Match each AWS cost management tool to its primary function.',
  'matching',
  '{"A":"AWS Cost Explorer","B":"AWS Budgets","C":"AWS Billing Dashboard"}'::json,
  NULL,
  'AWS Cost Explorer is used to visualize, understand, and manage AWS costs and usage over time, allowing for detailed analysis and forecasting. AWS Budgets enables users to set custom cost and usage thresholds and receive alerts when actual or forecasted costs exceed these thresholds. The AWS Billing Dashboard provides a high-level overview of your current month''s charges, payment history, and billing preferences for your AWS account.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  23,
  '{"left":["AWS Cost Explorer","AWS Budgets","AWS Billing Dashboard"],"right":["Visualize and analyze spending patterns","Set custom cost and usage alerts","Provide an account-level billing overview"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_97',
  'Match the AWS resource to its role in detailed cost tracking.',
  'matching',
  '{"A":"AWS Cost and Usage Report","B":"Cost allocation tags","C":"AWS Organizations"}'::json,
  NULL,
  'The AWS Cost and Usage Report provides highly granular line-item data about your AWS costs and usage, allowing for in-depth analysis. Cost allocation tags are key-value pairs that can be applied to AWS resources to track costs by specific projects, teams, or environments. AWS Organizations enables consolidated billing, which aggregates usage across multiple AWS accounts to simplify billing and potentially achieve volume discounts.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  24,
  '{"left":["AWS Cost and Usage Report","Cost allocation tags","AWS Organizations"],"right":["Granular line-item billing data","Track costs by project or team","Consolidated billing for multiple accounts"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_98',
  'Match the specific cost management need to the appropriate AWS tool.',
  'matching',
  '{"A":"Proactively monitor spending","B":"Analyze past spending patterns","C":"Allocate costs to departments"}'::json,
  NULL,
  'To proactively monitor spending and receive alerts before costs exceed expectations, AWS Budgets is the correct tool. For analyzing historical spending patterns and identifying trends, AWS Cost Explorer provides visualization and reporting capabilities. To attribute costs to specific business units or projects, implementing Cost allocation tags on resources is essential.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  25,
  '{"left":["Proactively monitor spending","Analyze past spending patterns","Allocate costs to departments"],"right":["AWS Budgets","AWS Cost Explorer","Cost allocation tags"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_99',
  'Match the benefit of AWS Organizations consolidated billing to its description.',
  'matching',
  '{"A":"Volume discounts","B":"Single payment method","C":"Centralized cost control"}'::json,
  NULL,
  'Consolidated billing in AWS Organizations allows for volume discounts by combining the usage of all accounts in an organization, leading to lower overall costs. It simplifies billing by providing a single payment method for all accounts, reducing administrative overhead. This also enables centralized cost control, making it easier to manage and report on costs across the entire organization from a single payer account.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  26,
  '{"left":["Volume discounts","Single payment method","Centralized cost control"],"right":["Lower overall costs due to aggregated usage","Simplified billing across all accounts","Easier financial management and reporting"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_100',
  'Match the cost-related action to the AWS resource that supports it.',
  'matching',
  '{"A":"Analyze historical spending","B":"Set alerts for potential overspending","C":"Get detailed usage data"}'::json,
  NULL,
  'To analyze historical spending and identify trends, AWS Cost Explorer is the appropriate tool. For setting alerts to be notified when costs or usage exceed predefined thresholds, AWS Budgets is used. To obtain the most granular, line-item level data about all AWS usage and costs, the AWS Cost and Usage Report is the comprehensive solution.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  27,
  '{"left":["Analyze historical spending","Set alerts for potential overspending","Get detailed usage data"],"right":["AWS Cost Explorer","AWS Budgets","AWS Cost and Usage Report"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_101',
  'Match the type of cost reporting granularity to its corresponding AWS tool.',
  'matching',
  '{"A":"High-level overview of charges","B":"Detailed hourly usage and costs","C":"Forecasted future spend"}'::json,
  NULL,
  'The AWS Billing Dashboard provides a high-level overview of your current and past charges. For detailed hourly usage and costs at a line-item level, the AWS Cost and Usage Report is the most comprehensive source. AWS Cost Explorer offers capabilities to visualize and analyze historical costs, and also provides forecasts of your future spend.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  28,
  '{"left":["High-level overview of charges","Detailed hourly usage and costs","Forecasted future spend"],"right":["AWS Billing Dashboard","AWS Cost and Usage Report","AWS Cost Explorer"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_102',
  'A rapidly growing tech company needs to maintain tight control over its AWS spending to ensure profitability and avoid unexpected charges. They require robust tools for monitoring, forecasting, and allocating costs across different projects and teams. Match each AWS cost management tool to its primary capability.',
  'matching',
  '{"A":"Visualize and analyze spending trends","B":"Set custom cost/usage thresholds with alerts","C":"Detailed, line-item billing data","D":"Aggregate billing for multiple accounts"}'::json,
  NULL,
  'AWS Cost Explorer (Option A) is used to visualize and analyze spending trends (Option A) over time, identify cost drivers, and forecast future costs. AWS Budgets (Option B) allows users to set custom cost and usage thresholds with alerts (Option B) to be notified when actual or forecasted costs exceed defined limits. The AWS Cost and Usage Report (Option C) provides detailed, line-item billing data (Option C) for comprehensive cost analysis. AWS Organizations Consolidated Billing (Option D) enables the aggregation of billing for multiple AWS accounts (Option D) under a single payer account, often leading to volume discounts.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  29,
  '{"left":["Visualize and analyze spending trends","Set custom cost/usage thresholds with alerts","Detailed, line-item billing data","Aggregate billing for multiple accounts"],"right":["AWS Cost Explorer","AWS Budgets","AWS Cost and Usage Report","AWS Organizations Consolidated Billing"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_103',
  'A company is concerned about potential cost overruns and wants to implement proactive measures to prevent unexpected charges in their AWS account. They need to establish a system that notifies them when their spending approaches predefined limits. Match each AWS resource to its capability in managing and controlling costs proactively.',
  'matching',
  '{"A":"Set spending limits and alerts","B":"Analyze historical cost data","C":"Receive detailed usage reports","D":"Consolidate billing for multiple accounts"}'::json,
  NULL,
  'To set spending limits and receive alerts (Option A), AWS Budgets (Option B) is the correct service. AWS Cost Explorer (Option B) is used to analyze historical cost data (Option A) and identify spending patterns. To receive detailed usage reports (Option C) at a granular level, the AWS Cost and Usage Report (Option D) is utilized. AWS Organizations (Option D) is primarily used to consolidate billing for multiple accounts (Option C) and manage them centrally.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  30,
  '{"left":["Set spending limits and alerts","Analyze historical cost data","Receive detailed usage reports","Consolidate billing for multiple accounts"],"right":["AWS Cost Explorer","AWS Budgets","AWS Organizations","AWS Cost and Usage Report"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_104',
  'A development team is exploring new AWS services and needs to ensure they are not incurring unnecessary costs during experimentation. They also want to understand how to track and optimize their spending effectively. Match each anti-pattern in cost management to the AWS resource designed to mitigate it.',
  'matching',
  '{"A":"Not setting up budgets","B":"Failing to use cost allocation tags","C":"Not reviewing Cost Explorer regularly","D":"Managing multiple accounts without consolidated billing"}'::json,
  NULL,
  'The anti-pattern of not setting up AWS Budgets (Option A) is mitigated by using AWS Budgets (Option B) to create proactive alerts for cost and usage thresholds. Failing to use cost allocation tags (Option B) to attribute costs is addressed by implementing Cost allocation tags (Option D). Not reviewing AWS Cost Explorer (Option C) regularly to identify spending trends and savings opportunities is mitigated by leveraging AWS Cost Explorer (Option A) for historical analysis and forecasting. Managing multiple accounts without consolidated billing (Option D) through AWS Organizations (Option C) leads to missed volume discounts and difficult cost tracking.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  31,
  '{"left":["Not setting up budgets","Failing to use cost allocation tags","Not reviewing Cost Explorer regularly","Managing multiple accounts without consolidated billing"],"right":["AWS Cost Explorer","AWS Budgets","AWS Organizations","Cost allocation tags"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_105',
  'A company is looking to gain deeper insights into their AWS spending patterns and identify areas for optimization. They require tools that can provide both high-level overviews and granular details of their cloud costs. Match each AWS billing resource to the specific type of cost information it provides.',
  'matching',
  '{"A":"Current month''s spending summary","B":"Historical cost and usage trends","C":"Detailed, hourly usage line items","D":"Potential savings recommendations"}'::json,
  NULL,
  'The AWS Billing Dashboard (Option B) provides a summary of the current month''s spending (Option A) and a high-level overview. AWS Cost Explorer (Option A) is used to analyze historical cost and usage trends (Option B) and identify cost drivers. For detailed, hourly usage line items (Option C), the AWS Cost and Usage Report (Option C) is the most comprehensive source. AWS Trusted Advisor (Option D) provides potential savings recommendations (Option D) among other best practice checks.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  32,
  '{"left":["Current month''s spending summary","Historical cost and usage trends","Detailed, hourly usage line items","Potential savings recommendations"],"right":["AWS Cost Explorer","AWS Billing Dashboard","AWS Cost and Usage Report","AWS Trusted Advisor"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_2_106',
  'An organization is scaling its operations on AWS and needs to implement a robust cost management strategy across its various business units. They are looking for tools that can help them forecast costs, set spending limits, and understand their billing structure. Match each AWS cost management feature to its primary function.',
  'matching',
  '{"A":"Forecasting future costs","B":"Receiving alerts on budget overruns","C":"Understanding service-specific pricing","D":"Viewing all account charges in one place"}'::json,
  NULL,
  'AWS Cost Explorer (Option C) offers capabilities for forecasting future costs (Option A) based on historical usage. AWS Budgets (Option A) is used for receiving alerts on budget overruns (Option B) when actual or forecasted costs exceed defined thresholds. The AWS Pricing Calculator (Option B) helps in understanding service-specific pricing (Option C) for new deployments. AWS Organizations Consolidated Billing (Option D) allows viewing all account charges in one place (Option D) for multiple linked accounts.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  33,
  '{"left":["Forecasting future costs","Receiving alerts on budget overruns","Understanding service-specific pricing","Viewing all account charges in one place"],"right":["AWS Budgets","AWS Pricing Calculator","AWS Cost Explorer","AWS Organizations Consolidated Billing"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_63_3
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_69',
  'Match each AWS Support plan to its primary characteristic.',
  'matching',
  '{"A":"Basic Support","B":"Developer Support","C":"Business Support"}'::json,
  NULL,
  'Basic Support is free for all AWS accounts and includes customer service and basic Trusted Advisor checks. Developer Support provides email access to Cloud Support Associates during business hours. Business Support offers 24/7 phone, chat, and email access to Cloud Support Engineers for production systems.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  34,
  '{"left":["Basic Support","Developer Support","Business Support"],"right":["Free for all AWS accounts","Email access to Cloud Support Associates","24/7 phone, chat, email support"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_70',
  'Match each AWS self-service resource to its content.',
  'matching',
  '{"A":"AWS documentation","B":"AWS re:Post","C":"AWS Health Dashboard"}'::json,
  NULL,
  'AWS documentation provides comprehensive official guides, tutorials, and API references for all AWS services. AWS re:Post is a community-driven Q&A service where users can get answers from AWS experts and the community. The AWS Health Dashboard provides personalized information about the health of AWS services and alerts for events affecting your resources.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  35,
  '{"left":["AWS documentation","AWS re:Post","AWS Health Dashboard"],"right":["Official service guides and API references","Community-driven Q&A forum","Personalized service event notifications"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_71',
  'Match the AWS resource to its primary purpose for best practices.',
  'matching',
  '{"A":"AWS Trusted Advisor","B":"AWS Health Dashboard","C":"AWS Professional Services"}'::json,
  NULL,
  'AWS Trusted Advisor provides recommendations to help you follow AWS best practices in categories like cost optimization, security, and performance. The AWS Health Dashboard provides personalized alerts and notifications about AWS service health events. AWS Professional Services offers expert consulting to help enterprises achieve specific outcomes with AWS.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  36,
  '{"left":["AWS Trusted Advisor","AWS Health Dashboard","AWS Professional Services"],"right":["Best practice recommendations","Personalized service health","Expert consulting and guidance"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_72',
  'Match the AWS Trusted Advisor category to its focus.',
  'matching',
  '{"A":"Cost Optimization","B":"Security","C":"Performance"}'::json,
  NULL,
  'The Cost Optimization category in Trusted Advisor helps identify ways to save money, such as by terminating idle resources. The Security category checks for security gaps and helps improve the security posture. The Performance category offers recommendations to improve the speed and responsiveness of your applications.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  37,
  '{"left":["Cost Optimization","Security","Performance"],"right":["Reduce spending on underutilized resources","Identify security vulnerabilities","Improve responsiveness of applications"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_73',
  'Match the AWS Support plan to its typical response time for critical issues.',
  'matching',
  '{"A":"Developer Support","B":"Business Support","C":"Enterprise Support"}'::json,
  NULL,
  'Developer Support offers email responses during business hours. Business Support aims for a 1-hour response time for production system impaired issues. Enterprise Support provides the fastest response times, targeting 15 minutes for business-critical system down issues.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  38,
  '{"left":["Developer Support","Business Support","Enterprise Support"],"right":["Business hours email response","1 hour for production system impaired","15 minutes for business-critical system down"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_74',
  'Match the AWS resource to its role in getting external assistance.',
  'matching',
  '{"A":"AWS Partner Network (APN)","B":"AWS IQ","C":"AWS Managed Services (AMS)"}'::json,
  NULL,
  'The AWS Partner Network (APN) connects customers with consulting and technology partners who can provide solutions and services. AWS IQ allows customers to find and engage AWS-certified third-party experts for on-demand project work. AWS Managed Services (AMS) provides operational assistance and management of your AWS environment.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  39,
  '{"left":["AWS Partner Network (APN)","AWS IQ","AWS Managed Services (AMS)"],"right":["Connect with consulting/technology partners","Find third-party AWS experts for projects","Operational assistance for AWS environment"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_75',
  'Match each AWS Support plan to its primary level of technical assistance.',
  'matching',
  '{"A":"Basic Support","B":"Developer Support","C":"Business Support"}'::json,
  NULL,
  'Basic Support is free and includes access to documentation, forums, and the AWS Health Dashboard, but no direct technical support from engineers. Developer Support provides technical support via email during business hours for general guidance. Business Support offers 24/7 access to technical support engineers via phone, chat, and email for production workloads, with faster response times for critical issues.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  40,
  '{"left":["Basic Support","Developer Support","Business Support"],"right":["No technical support access","Email access during business hours","24/7 phone, chat, and email access"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_76',
  'Match each AWS self-service resource to its primary purpose.',
  'matching',
  '{"A":"AWS Documentation","B":"AWS re:Post","C":"AWS Knowledge Center"}'::json,
  NULL,
  'AWS Documentation provides comprehensive official guides, API references, and user manuals for all AWS services. AWS re:Post is a community-driven Q&A forum where users can get answers to technical questions from AWS experts and the community. The AWS Knowledge Center offers a collection of articles, FAQs, and troubleshooting guides for common issues and best practices.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  41,
  '{"left":["AWS Documentation","AWS re:Post","AWS Knowledge Center"],"right":["Official service guides and API references","Community-driven Q&A forum","Articles for common issues and how-to guides"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_77',
  'Match the workload criticality to the recommended AWS Support plan.',
  'matching',
  '{"A":"Non-production workload","B":"Production workload with 24/7 need","C":"Mission-critical workload with proactive guidance"}'::json,
  NULL,
  'For non-production workloads or development environments, Developer Support is generally recommended, offering email support during business hours. Production workloads that require 24/7 support and faster response times for critical issues should use Business Support. Mission-critical workloads that need proactive architectural guidance, a dedicated Technical Account Manager (TAM), and the fastest response times are best suited for Enterprise Support.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  42,
  '{"left":["Non-production workload","Production workload with 24/7 need","Mission-critical workload with proactive guidance"],"right":["Developer Support","Business Support","Enterprise Support"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_78',
  'Match each AWS tool or role to its primary function in operational excellence.',
  'matching',
  '{"A":"AWS Trusted Advisor","B":"AWS Health Dashboard","C":"Technical Account Manager (TAM)"}'::json,
  NULL,
  'AWS Trusted Advisor provides best practice recommendations across cost optimization, security, performance, fault tolerance, and service limits. The AWS Health Dashboard offers personalized alerts and notifications about AWS service events that may affect your specific resources. A Technical Account Manager (TAM), available with Enterprise Support, is a dedicated expert who provides proactive guidance and architectural reviews.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  43,
  '{"left":["AWS Trusted Advisor","AWS Health Dashboard","Technical Account Manager (TAM)"],"right":["Best practice recommendations for optimization","Personalized service health notifications","Dedicated expert for strategic guidance"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_79',
  'Match the operational need to the appropriate AWS resource or support feature.',
  'matching',
  '{"A":"Alerts about service outages","B":"Recommendations for cost savings","C":"Dedicated expert for architecture"}'::json,
  NULL,
  'To receive personalized alerts and notifications about AWS service outages or scheduled maintenance events that might impact your resources, the AWS Health Dashboard is the correct tool. For recommendations on how to optimize costs, improve security, or enhance performance, AWS Trusted Advisor provides actionable insights. Access to a dedicated expert for architectural reviews and strategic guidance is a key feature of Enterprise Support, provided by a Technical Account Manager (TAM).',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  44,
  '{"left":["Alerts about service outages","Recommendations for cost savings","Dedicated expert for architecture"],"right":["AWS Health Dashboard","AWS Trusted Advisor","Enterprise Support (TAM)"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_80',
  'Match each external AWS resource to its primary offering.',
  'matching',
  '{"A":"AWS Professional Services","B":"AWS Partner Network (APN)","C":"AWS IQ"}'::json,
  NULL,
  'AWS Professional Services offers expert consulting and hands-on assistance to help enterprises achieve specific outcomes with AWS. The AWS Partner Network (APN) is a global community of partners that leverage AWS to build solutions and services for customers. AWS IQ connects customers with AWS-certified third-party experts for on-demand project work and advice.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  45,
  '{"left":["AWS Professional Services","AWS Partner Network (APN)","AWS IQ"],"right":["Expert consulting for complex projects","Global network of AWS-trained partners","Connect with third-party AWS experts"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_63_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_63_m_63_3_81',
  'A small development team is building a new application on AWS and needs access to technical guidance and support without incurring high costs. They are exploring various AWS support options and self-service resources to find the most suitable fit for their needs. Match each AWS support option or resource to its typical characteristic.',
  'matching',
  '{"A":"No access to technical support engineers","B":"General guidance, 12-24 hour response","C":"Community-driven Q&A forum","D":"Collection of best practice documents"}'::json,
  NULL,
  'AWS Basic Support (Option A) offers no access to technical support engineers (Option A), providing only customer service and forums. AWS Developer Support (Option B) provides general guidance with a typical response time of 12-24 hours (Option B) for general questions. AWS re:Post (Option C) is a community-driven Q&A forum (Option C) for technical questions. AWS Whitepapers (Option D) are a collection of best practice documents (Option D) and architectural guidance from AWS experts.',
  NOW(),
  'quiz_domain63_13',
  NOW(),
  46,
  '{"left":["No access to technical support engineers","General guidance, 12-24 hour response","Community-driven Q&A forum","Collection of best practice documents"],"right":["AWS Basic Support","AWS Developer Support","AWS re:Post","AWS Whitepapers"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_63_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_92'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_93'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_94'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_95'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_96'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_97'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_98'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_99'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_100'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_101'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_102'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_103'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_104'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_105'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_106'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_107'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_1_108'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_91'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_92'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_93'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_94'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_95'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_96'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_97'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_98'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_99'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_100'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_101'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_102'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_103'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_104'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_105'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_2_106'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_69'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_70'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_71'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_72'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_73'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_74'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_75'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_76'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_77'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_78'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_79'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_80'),
  (NOW(), 'quiz_domain63_13', 'q_63_m_63_3_81')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain63_13'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;


-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: CLF-C02
-- Generated: 2026-03-19T02:38:44.261Z
-- Questions: 49 (49 validated, 7 rejected)
-- Quiz ID: quiz_domain62_13
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_62_1
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_98',
  'Match each method of interacting with AWS to its primary use case.',
  'matching',
  '{"A":"AWS Management Console","B":"AWS Command Line Interface (CLI)","C":"AWS SDKs"}'::json,
  NULL,
  'The AWS Management Console is a web-based graphical interface for managing AWS services. The AWS Command Line Interface (CLI) allows users to script and automate AWS services from a terminal. AWS SDKs provide language-specific APIs for programmatic interaction with AWS services from within application code.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  1,
  '{"left":["AWS Management Console","AWS Command Line Interface (CLI)","AWS SDKs"],"right":["Web-based graphical interface for service management","Scripting and automating AWS services from a terminal","Programmatic interaction with AWS services from application code"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_99',
  'Match each cloud deployment model to its description.',
  'matching',
  '{"A":"Public Cloud","B":"Private Cloud","C":"Hybrid Cloud"}'::json,
  NULL,
  'Public Cloud refers to IT resources owned and operated by a third-party cloud provider, like AWS, that are shared among multiple tenants. Private Cloud describes IT resources used exclusively by one business or organization, often on-premises. Hybrid Cloud is an environment that combines public cloud resources with on-premises infrastructure, allowing data and applications to move between them.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  2,
  '{"left":["Public Cloud","Private Cloud","Hybrid Cloud"],"right":["IT resources owned and operated by a third-party cloud provider","IT resources used exclusively by one business or organization","A combination of public cloud and on-premises infrastructure"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_100',
  'Match each method of interacting with AWS to its primary use case.',
  'matching',
  '{"A":"AWS Management Console","B":"AWS CLI","C":"AWS SDKs"}'::json,
  NULL,
  'The AWS Management Console provides a web-based graphical interface for managing AWS services. The AWS CLI (Command Line Interface) allows users to control AWS services from the command line, ideal for scripting and automation. AWS SDKs (Software Development Kits) provide APIs in various programming languages, enabling programmatic access to AWS services for application development.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  3,
  '{"left":["AWS Management Console","AWS CLI","AWS SDKs"],"right":["Graphical interface for service management","Scripting and automating tasks","Programmatic access for application development"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_1_101',
  'Match each cloud deployment model to its characteristic.',
  'matching',
  '{"A":"Public Cloud","B":"Private Cloud","C":"Hybrid Cloud"}'::json,
  NULL,
  'Public Cloud refers to cloud resources owned and operated by a third-party cloud provider, like AWS, available to the general public. Private Cloud involves cloud resources exclusively used by a single organization, often hosted on-premises. Hybrid Cloud is a combination of public cloud and on-premises infrastructure, allowing data and applications to be shared between them.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  4,
  '{"left":["Public Cloud","Private Cloud","Hybrid Cloud"],"right":["Cloud resources owned and operated by a third-party cloud provider","Cloud resources exclusively used by a single organization","Combination of public cloud and on-premises infrastructure"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_86',
  'Match each AWS global infrastructure component to its purpose.',
  'matching',
  '{"A":"AWS Region","B":"Availability Zone","C":"Edge Location"}'::json,
  NULL,
  'An AWS Region is a physical location in the world where AWS clusters data centers. An Availability Zone (AZ) is one or more discrete data centers with redundant power, networking, and connectivity within an AWS Region, designed for high availability. An Edge Location is a site used by Amazon CloudFront to cache content closer to users for faster delivery.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  5,
  '{"left":["AWS Region","Availability Zone","Edge Location"],"right":["A geographic area with multiple isolated locations","An isolated location within a Region for high availability","A data center used by CloudFront for content delivery"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_87',
  'Match each global infrastructure concept to its benefit.',
  'matching',
  '{"A":"Multiple Availability Zones","B":"Multiple AWS Regions","C":"AWS Local Zones"}'::json,
  NULL,
  'Deploying across Multiple Availability Zones within a Region is crucial for achieving high availability and fault tolerance, protecting against single points of failure. Utilizing Multiple AWS Regions enables robust disaster recovery strategies and allows applications to serve a global user base with lower latency. AWS Local Zones extend AWS infrastructure to provide ultra-low latency access to end-users or on-premises installations in specific geographic areas.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  6,
  '{"left":["Multiple Availability Zones","Multiple AWS Regions","AWS Local Zones"],"right":["Achieving high availability and fault tolerance within a Region","Enabling disaster recovery and global presence for applications","Extending AWS infrastructure closer to users for ultra-low latency"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_88',
  'Match each specialized AWS infrastructure offering to its primary use case.',
  'matching',
  '{"A":"AWS Outposts","B":"AWS Wavelength","C":"AWS Direct Connect"}'::json,
  NULL,
  'AWS Outposts allows customers to run AWS infrastructure and services on-premises for a truly consistent hybrid experience. AWS Wavelength embeds AWS compute and storage services within 5G networks, enabling developers to build ultra-low latency applications for mobile devices. AWS Direct Connect establishes a dedicated private network connection from a customer''s premises to AWS, offering consistent network performance.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  7,
  '{"left":["AWS Outposts","AWS Wavelength","AWS Direct Connect"],"right":["Running AWS infrastructure on-premises for hybrid workloads","Delivering ultra-low latency applications at the 5G network edge","Establishing a dedicated private network connection to AWS"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_89',
  'Match each AWS global infrastructure component to its role.',
  'matching',
  '{"A":"AWS Region","B":"Availability Zone","C":"Edge Location"}'::json,
  NULL,
  'An AWS Region is a geographical area that contains multiple, isolated locations. An Availability Zone (AZ) is an isolated location within a Region, designed for high availability and fault tolerance. An Edge Location is an endpoint for AWS services like Amazon CloudFront and Amazon Route 53, used for content delivery and DNS resolution closer to users.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  8,
  '{"left":["AWS Region","Availability Zone","Edge Location"],"right":["Geographical area with multiple isolated locations","Isolated location within a Region for high availability","Endpoint for content delivery and DNS services"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_90',
  'Match the AWS global infrastructure concept to its definition.',
  'matching',
  '{"A":"High Availability","B":"Fault Tolerance","C":"Low Latency"}'::json,
  NULL,
  'High Availability refers to designing systems to operate continuously without interruption for long periods, often achieved by deploying across multiple Availability Zones. Fault Tolerance is the ability of a system to continue operating without interruption in the event of a failure. Low Latency means minimizing the delay in data transmission, often achieved by deploying resources geographically closer to users via Edge Locations or specific Regions.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  9,
  '{"left":["High Availability","Fault Tolerance","Low Latency"],"right":["Ensuring continuous operation despite failures","Ability to withstand failures without downtime","Minimizing delay in data transmission"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_91',
  'Match the AWS Region selection factor to its primary consideration.',
  'matching',
  '{"A":"Compliance","B":"Latency","C":"Service Availability"}'::json,
  NULL,
  'When choosing an AWS Region, Compliance is crucial for meeting data residency and regulatory requirements specific to a geographic location. Latency is considered to minimize network delay for end-users by selecting a Region geographically closer to them. Service Availability ensures that all necessary AWS services for your application are available in the chosen Region.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  10,
  '{"left":["Compliance","Latency","Service Availability"],"right":["Meeting data residency and regulatory requirements","Minimizing network delay for end-users","Ensuring specific AWS services are present"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_2_92',
  'An architect is designing a highly available and low-latency application for global users, considering data residency and content delivery. Match each AWS global infrastructure component to its primary architectural role.',
  'matching',
  '{"A":"AWS Region","B":"Availability Zone","C":"Edge Location"}'::json,
  NULL,
  'An AWS Region (left[0]) is an ''Isolated geographic area for services'' (right[1]), providing complete isolation from other Regions for disaster recovery and data residency. An Availability Zone (left[1]) is a ''Fault-isolated data center'' (right[2]) within a Region, designed to be independent of other AZs to provide high availability. An Edge Location (left[2]) is primarily used for ''Content delivery and DNS caching'' (right[0]) by services like Amazon CloudFront and Amazon Route 53, bringing content closer to users for lower latency.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  11,
  '{"left":["AWS Region","Availability Zone","Edge Location"],"right":["Content delivery and DNS caching","Isolated geographic area for services","Fault-isolated data center"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_7
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_89',
  'Match each AWS AI service to its primary function.',
  'matching',
  '{"A":"Amazon Rekognition","B":"Amazon Comprehend","C":"Amazon Polly"}'::json,
  NULL,
  'Amazon Rekognition is an AI service for analyzing images and videos to identify objects, people, text, and activities. Amazon Comprehend uses natural language processing (NLP) to extract insights and relationships from unstructured text. Amazon Polly is a text-to-speech service that turns text into lifelike speech, allowing for the creation of talking applications.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  12,
  '{"left":["Amazon Rekognition","Amazon Comprehend","Amazon Polly"],"right":["Analyzing images and videos for objects, people, and activities","Extracting insights and relationships from text","Converting text into lifelike speech"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_7',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_90',
  'Match each AWS analytics service to its primary use case.',
  'matching',
  '{"A":"Amazon Athena","B":"Amazon QuickSight","C":"Amazon Kinesis"}'::json,
  NULL,
  'Amazon Athena is a serverless query service that allows users to run SQL queries directly on data stored in Amazon S3 without managing any infrastructure. Amazon QuickSight is a scalable, serverless business intelligence (BI) service that enables users to create interactive dashboards and reports. Amazon Kinesis is a platform for processing and analyzing real-time streaming data at scale.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  13,
  '{"left":["Amazon Athena","Amazon QuickSight","Amazon Kinesis"],"right":["Running SQL queries directly on data in Amazon S3","Creating interactive dashboards and business intelligence reports","Processing and analyzing real-time streaming data"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_7',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_91',
  'Match each AWS data processing service to its primary purpose.',
  'matching',
  '{"A":"AWS Glue","B":"Amazon EMR","C":"Amazon SageMaker"}'::json,
  NULL,
  'AWS Glue is a serverless data integration service that makes it easy to discover, prepare, and combine data for analytics, machine learning, and application development. Amazon EMR is a managed cluster platform that simplifies running big data frameworks like Apache Hadoop and Apache Spark. Amazon SageMaker is a fully managed service that provides every developer and data scientist with the ability to build, train, and deploy machine learning models quickly.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  14,
  '{"left":["AWS Glue","Amazon EMR","Amazon SageMaker"],"right":["Serverless data integration (ETL) service and data catalog","Managed cluster platform for big data processing (Hadoop, Spark)","Building, training, and deploying machine learning models"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_7',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_92',
  'Match each AWS AI service to its core capability.',
  'matching',
  '{"A":"Amazon Rekognition","B":"Amazon Comprehend","C":"Amazon Polly"}'::json,
  NULL,
  'Amazon Rekognition provides image and video analysis capabilities, such as object and facial recognition. Amazon Comprehend is a natural language processing (NLP) service that uncovers insights and relationships in text. Amazon Polly is a text-to-speech service that turns text into lifelike speech.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  15,
  '{"left":["Amazon Rekognition","Amazon Comprehend","Amazon Polly"],"right":["Image and video analysis","Natural language processing (NLP)","Text-to-speech conversion"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_93',
  'Match each AWS analytics service to its primary function.',
  'matching',
  '{"A":"Amazon Athena","B":"Amazon QuickSight","C":"Amazon Kinesis"}'::json,
  NULL,
  'Amazon Athena is a serverless query service that makes it easy to analyze data directly in Amazon S3 using standard SQL. Amazon QuickSight is a scalable, serverless, embeddable, machine learning-powered business intelligence (BI) service that builds interactive dashboards. Amazon Kinesis is a platform for real-time streaming data processing, enabling you to collect, process, and analyze data streams.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  16,
  '{"left":["Amazon Athena","Amazon QuickSight","Amazon Kinesis"],"right":["Serverless SQL queries on S3 data","Business intelligence dashboards and visualizations","Real-time streaming data processing"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_94',
  'Match the data processing need to the appropriate AWS analytics service.',
  'matching',
  '{"A":"Ad-hoc S3 data querying","B":"Real-time log analysis","C":"ETL for data warehousing"}'::json,
  NULL,
  'For ad-hoc querying of data stored in Amazon S3 without provisioning servers, Amazon Athena is the ideal serverless solution. For real-time log analysis and processing of streaming data, Amazon Kinesis provides the necessary capabilities. AWS Glue is a serverless data integration service that makes it easy to discover, prepare, and combine data for analytics, machine learning, and application development, making it suitable for ETL (Extract, Transform, Load) processes for data warehousing.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  17,
  '{"left":["Ad-hoc S3 data querying","Real-time log analysis","ETL for data warehousing"],"right":["Amazon Athena","Amazon Kinesis","AWS Glue"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_7',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_7_95',
  'A data analytics team needs to process and analyze various types of data for business intelligence. Match each AWS analytics service to its most suitable use case.',
  'matching',
  '{"A":"Amazon Athena","B":"AWS Glue","C":"Amazon QuickSight"}'::json,
  NULL,
  'Amazon Athena (left[0]) is a serverless query service that allows you to run ''Serverless SQL queries on S3'' (right[1]) directly on data stored in Amazon S3 without managing any infrastructure. AWS Glue (left[1]) is a serverless data integration service that provides ''ETL and data cataloging'' (right[2]) capabilities, preparing data for analytics. Amazon QuickSight (left[2]) is a scalable, serverless business intelligence (BI) service that enables the creation of ''Business intelligence dashboards'' (right[0]) for data visualization and interactive analysis.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  18,
  '{"left":["Amazon Athena","AWS Glue","Amazon QuickSight"],"right":["Business intelligence dashboards","Serverless SQL queries on S3","ETL and data cataloging"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_7',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_3
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_79',
  'Match each AWS compute service to its primary characteristic.',
  'matching',
  '{"A":"Amazon EC2","B":"AWS Lambda","C":"AWS Fargate"}'::json,
  NULL,
  'Amazon EC2 provides virtual servers (instances) that require users to manage the operating system. AWS Lambda offers serverless, event-driven compute where AWS manages the underlying servers, and users pay per invocation. AWS Fargate is a serverless compute engine for containers that removes the need to provision and manage servers for containerized applications.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  19,
  '{"left":["Amazon EC2","AWS Lambda","AWS Fargate"],"right":["Virtual servers requiring OS management","Serverless, event-driven compute, no server management","Serverless compute for containers, no host management"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_80',
  'Match each Amazon EC2 pricing option to its ideal use case.',
  'matching',
  '{"A":"On-Demand Instances","B":"Reserved Instances","C":"Spot Instances"}'::json,
  NULL,
  'On-Demand Instances are ideal for workloads with unpredictable usage and short durations, as they offer pay-as-you-go pricing without long-term commitments. Reserved Instances are best for workloads with predictable, steady-state usage over 1 or 3 years, offering significant discounts. Spot Instances provide up to 90% savings for fault-tolerant workloads that can tolerate interruptions, such as batch processing or data analysis.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  20,
  '{"left":["On-Demand Instances","Reserved Instances","Spot Instances"],"right":["Workloads with unpredictable usage and short durations","Workloads with predictable, steady-state usage for 1 or 3 years","Fault-tolerant workloads that can tolerate interruptions for cost savings"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_81',
  'Match each AWS compute management service to its primary function.',
  'matching',
  '{"A":"Amazon EC2 Auto Scaling","B":"Elastic Load Balancing (ELB)","C":"Amazon Lightsail"}'::json,
  NULL,
  'Amazon EC2 Auto Scaling automatically adjusts compute capacity to maintain application performance and optimize costs based on defined policies and demand. Elastic Load Balancing (ELB) distributes incoming application traffic across multiple targets, such as EC2 instances, to improve application availability and fault tolerance. Amazon Lightsail provides simple virtual private servers (VPS) for basic web applications, websites, and development environments with an easy-to-use interface.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  21,
  '{"left":["Amazon EC2 Auto Scaling","Elastic Load Balancing (ELB)","Amazon Lightsail"],"right":["Automatically adjusting compute capacity based on demand","Distributing incoming application traffic across multiple targets","Simple virtual private servers for basic web applications"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_82',
  'Match each AWS compute service to its primary use case.',
  'matching',
  '{"A":"Amazon EC2","B":"AWS Lambda","C":"AWS Fargate"}'::json,
  NULL,
  'Amazon EC2 provides virtual servers (instances) with full control over the operating system, ideal for custom configurations. AWS Lambda is a serverless compute service that runs code in response to events without provisioning or managing servers. AWS Fargate is a serverless compute engine for Amazon ECS and Amazon EKS, allowing you to run containers without managing the underlying EC2 instances.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  22,
  '{"left":["Amazon EC2","AWS Lambda","AWS Fargate"],"right":["Virtual servers for full control","Event-driven serverless functions","Serverless compute for containers"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_83',
  'Match each Amazon EC2 pricing option to its characteristic.',
  'matching',
  '{"A":"On-Demand Instances","B":"Reserved Instances","C":"Spot Instances"}'::json,
  NULL,
  'On-Demand Instances allow you to pay for compute capacity by the hour or second without long-term commitments, offering flexibility. Reserved Instances provide a significant discount (up to 75%) compared to On-Demand pricing in exchange for a 1- or 3-year commitment. Spot Instances allow you to bid on unused EC2 capacity, offering up to 90% savings for fault-tolerant workloads that can tolerate interruptions.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  23,
  '{"left":["On-Demand Instances","Reserved Instances","Spot Instances"],"right":["Pay for compute capacity by the hour or second","Commit to 1- or 3-year term for significant discount","Bid on unused EC2 capacity for cost savings"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_84',
  'Match the compute workload characteristic to the appropriate AWS service.',
  'matching',
  '{"A":"Fluctuating web traffic","B":"Long-running batch jobs","C":"Event-driven microservices"}'::json,
  NULL,
  'For applications with fluctuating web traffic, Amazon EC2 Auto Scaling automatically adjusts the number of EC2 instances to maintain performance and optimize costs. AWS Batch is designed for running long-running, large-scale batch computing workloads efficiently. For event-driven microservices that respond to triggers, AWS Lambda provides a serverless, pay-per-invocation compute environment.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  24,
  '{"left":["Fluctuating web traffic","Long-running batch jobs","Event-driven microservices"],"right":["Amazon EC2 Auto Scaling","AWS Batch","AWS Lambda"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_3_85',
  'A development team is choosing compute services for different parts of an application, balancing operational overhead and control. Match each AWS compute service to its typical management model.',
  'matching',
  '{"A":"Amazon EC2","B":"AWS Lambda","C":"AWS Fargate"}'::json,
  NULL,
  'Amazon EC2 (left[0]) provides virtual servers, offering ''Infrastructure as a Service (IaaS)'' (right[1]), where users manage the operating system and application runtime. AWS Lambda (left[1]) is a ''Serverless compute'' (right[2]) service that runs code without provisioning or managing servers, charging only for compute time consumed. AWS Fargate (left[2]) is a compute engine for Amazon ECS and Amazon EKS that allows you to run containers without managing servers or clusters, representing ''Serverless containers'' (right[0]).',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  25,
  '{"left":["Amazon EC2","AWS Lambda","AWS Fargate"],"right":["Serverless containers","Infrastructure as a Service (IaaS)","Serverless compute"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_3',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_4
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_75',
  'Match each AWS database service to its primary database type.',
  'matching',
  '{"A":"Amazon RDS","B":"Amazon DynamoDB","C":"Amazon Redshift"}'::json,
  NULL,
  'Amazon RDS (Relational Database Service) is a managed relational database service supporting various engines like MySQL and PostgreSQL. Amazon DynamoDB is a fully managed NoSQL database service that supports key-value and document data models. Amazon Redshift is a fully managed, petabyte-scale data warehouse service designed for analytical workloads.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  26,
  '{"left":["Amazon RDS","Amazon DynamoDB","Amazon Redshift"],"right":["Managed relational database","Managed NoSQL key-value and document database","Managed data warehouse for analytics"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_76',
  'Match each AWS database service to its specific use case.',
  'matching',
  '{"A":"Amazon Aurora","B":"Amazon ElastiCache","C":"Amazon DocumentDB"}'::json,
  NULL,
  'Amazon Aurora is a high-performance, MySQL and PostgreSQL-compatible relational database built for the cloud, offering superior performance and availability. Amazon ElastiCache provides in-memory caching with Redis and Memcached to accelerate application performance by retrieving data from fast, managed caches. Amazon DocumentDB (with MongoDB compatibility) is a fully managed native JSON document database service that supports MongoDB workloads.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  27,
  '{"left":["Amazon Aurora","Amazon ElastiCache","Amazon DocumentDB"],"right":["High-performance, MySQL and PostgreSQL-compatible relational database","In-memory caching for accelerating application performance","MongoDB-compatible document database service"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_77',
  'Match each AWS database characteristic to its corresponding service.',
  'matching',
  '{"A":"Managed relational database with flexible scaling","B":"Managed NoSQL database for high-scale applications","C":"In-memory data store for real-time applications"}'::json,
  NULL,
  'Amazon RDS provides managed relational databases with flexible scaling options. Amazon DynamoDB is a fully managed NoSQL database designed for high-scale applications requiring single-digit millisecond performance. Amazon MemoryDB for Redis is a durable, in-memory database service compatible with Redis, offering ultra-fast performance for real-time applications.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  28,
  '{"left":["Managed relational database with flexible scaling","Managed NoSQL database for high-scale applications","In-memory data store for real-time applications"],"right":["Amazon RDS","Amazon DynamoDB","Amazon MemoryDB for Redis"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_4',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_78',
  'Match each database type to its corresponding AWS service.',
  'matching',
  '{"A":"Relational Database","B":"NoSQL Key-Value Database","C":"In-memory Cache"}'::json,
  NULL,
  'Amazon RDS (Relational Database Service) provides managed relational databases like MySQL, PostgreSQL, and SQL Server. Amazon DynamoDB is a fast and flexible NoSQL key-value and document database service. Amazon ElastiCache is a fully managed in-memory caching service that supports Redis and Memcached, used to speed up data retrieval.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  29,
  '{"left":["Relational Database","NoSQL Key-Value Database","In-memory Cache"],"right":["Amazon RDS","Amazon DynamoDB","Amazon ElastiCache"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_79',
  'Match each AWS database service to its key feature.',
  'matching',
  '{"A":"Amazon Aurora","B":"Amazon Redshift","C":"Amazon DocumentDB"}'::json,
  NULL,
  'Amazon Aurora is a high-performance, MySQL and PostgreSQL-compatible relational database built for the cloud. Amazon Redshift is a fully managed, petabyte-scale data warehousing service optimized for analytical workloads. Amazon DocumentDB (with MongoDB compatibility) is a fast, scalable, highly available, and fully managed document database service that supports MongoDB workloads.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  30,
  '{"left":["Amazon Aurora","Amazon Redshift","Amazon DocumentDB"],"right":["High-performance MySQL/PostgreSQL compatible relational DB","Petabyte-scale data warehousing and analytics","MongoDB-compatible document database"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_80',
  'Match the data storage and access pattern to the most suitable AWS database service.',
  'matching',
  '{"A":"Structured, transactional data","B":"Flexible schema, high-scale key-value data","C":"Complex analytical queries on large datasets"}'::json,
  NULL,
  'For structured, transactional data requiring ACID compliance and a fixed schema, Amazon RDS is the appropriate choice. For flexible schema, high-scale key-value or document data with single-digit millisecond performance, Amazon DynamoDB is purpose-built. For complex analytical queries on large datasets, Amazon Redshift, a columnar data warehouse, is optimized for performance.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  31,
  '{"left":["Structured, transactional data","Flexible schema, high-scale key-value data","Complex analytical queries on large datasets"],"right":["Amazon RDS","Amazon DynamoDB","Amazon Redshift"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_4',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_4_81',
  'A solutions architect is selecting database services for various application requirements, from structured transactions to flexible key-value storage. Match each AWS database service to its primary database type.',
  'matching',
  '{"A":"Amazon RDS","B":"Amazon DynamoDB","C":"Amazon Redshift"}'::json,
  NULL,
  'Amazon RDS (left[0]) is a service for ''Managed relational database'' (right[1]) engines like MySQL, PostgreSQL, and SQL Server, suitable for structured transactional data. Amazon DynamoDB (left[1]) is a fast, flexible NoSQL database service for key-value and document workloads, making it a ''Managed NoSQL database'' (right[2]). Amazon Redshift (left[2]) is a fully managed, petabyte-scale ''Data warehousing'' (right[0]) service designed for analytical workloads and complex queries on large datasets.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  32,
  '{"left":["Amazon RDS","Amazon DynamoDB","Amazon Redshift"],"right":["Data warehousing","Managed relational database","Managed NoSQL database"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_4',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_5
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_74',
  'Match each Amazon VPC component to its primary function.',
  'matching',
  '{"A":"Subnet","B":"Internet Gateway","C":"NAT Gateway"}'::json,
  NULL,
  'A Subnet is a range of IP addresses in your Amazon VPC. An Internet Gateway enables communication between instances in your public subnets and the internet. A NAT Gateway allows instances in private subnets to connect to the internet or other AWS services, but prevents the internet from initiating connections to those instances.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  33,
  '{"left":["Subnet","Internet Gateway","NAT Gateway"],"right":["A range of IP addresses in your VPC","Enabling public subnets to access the internet","Enabling private subnets to access the internet outbound only"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_5',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_75',
  'Match each AWS network component to its primary function.',
  'matching',
  '{"A":"Amazon VPC","B":"Internet Gateway","C":"NAT Gateway"}'::json,
  NULL,
  'An Amazon VPC (Virtual Private Cloud) is a logically isolated section of the AWS Cloud where you can launch AWS resources. An Internet Gateway enables communication between your VPC and the internet, primarily for resources in public subnets. A NAT Gateway allows instances in a private subnet to connect to the internet or other AWS services, but prevents the internet from initiating connections to those instances.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  34,
  '{"left":["Amazon VPC","Internet Gateway","NAT Gateway"],"right":["Logically isolated section of the AWS Cloud","Enabling internet access for public subnets","Allowing private subnets to access the internet"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_5',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_76',
  'Match each AWS network security control to its scope.',
  'matching',
  '{"A":"Security Group","B":"Network ACL","C":"Route 53"}'::json,
  NULL,
  'A Security Group acts as a stateful, instance-level firewall that controls inbound and outbound traffic for EC2 instances. A Network ACL (Access Control List) operates as a stateless, subnet-level firewall, requiring explicit rules for both inbound and outbound traffic. Amazon Route 53 is a highly available and scalable cloud Domain Name System (DNS) web service, not a firewall, but it controls traffic routing.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  35,
  '{"left":["Security Group","Network ACL","Route 53"],"right":["Stateful, instance-level firewall","Stateless, subnet-level firewall","Domain Name System (DNS) web service"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_5',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_77',
  'Match the connectivity requirement to the appropriate AWS networking service.',
  'matching',
  '{"A":"Secure internet connection to VPC","B":"Dedicated private connection to AWS","C":"Distributing traffic across multiple targets"}'::json,
  NULL,
  'For a secure, encrypted connection over the public internet between your on-premises network and your Amazon VPC, AWS VPN is used. AWS Direct Connect provides a dedicated, private network connection from your premises to AWS, offering consistent network performance. Elastic Load Balancing (ELB) automatically distributes incoming application traffic across multiple targets, such as EC2 instances, in multiple Availability Zones.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  36,
  '{"left":["Secure internet connection to VPC","Dedicated private connection to AWS","Distributing traffic across multiple targets"],"right":["AWS VPN","AWS Direct Connect","Elastic Load Balancing"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_5',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_5_78',
  'A company is designing its network architecture within AWS to ensure secure and efficient communication. Match each AWS networking component to its fundamental function.',
  'matching',
  '{"A":"Amazon VPC","B":"Security Group","C":"NAT Gateway"}'::json,
  NULL,
  'An Amazon VPC (left[0]) provides an ''Isolated virtual network'' (right[1]) in the AWS Cloud, where you can launch AWS resources. A Security Group (left[1]) acts as an ''Instance-level firewall'' (right[2]), controlling inbound and outbound traffic for EC2 instances. A NAT Gateway (left[2]) allows instances in a private subnet to connect to the internet or other AWS services, but prevents the internet from initiating connections with those instances, providing ''Private outbound internet access'' (right[0]).',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  37,
  '{"left":["Amazon VPC","Security Group","NAT Gateway"],"right":["Private outbound internet access","Isolated virtual network","Instance-level firewall"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_5',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_6
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_68',
  'Match each AWS storage service to its primary use case.',
  'matching',
  '{"A":"Amazon S3","B":"Amazon EBS","C":"Amazon EFS"}'::json,
  NULL,
  'Amazon S3 (Simple Storage Service) provides object storage for unstructured data, suitable for static websites, backups, and data lakes. Amazon EBS (Elastic Block Store) offers persistent block storage volumes for use with Amazon EC2 instances. Amazon EFS (Elastic File System) provides scalable, shared file storage that can be accessed concurrently by multiple EC2 instances.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  38,
  '{"left":["Amazon S3","Amazon EBS","Amazon EFS"],"right":["Object storage for unstructured data","Block storage for EC2 instances","Shared file storage for multiple EC2 instances"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_6',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_69',
  'Match each Amazon S3 storage class to its typical access pattern.',
  'matching',
  '{"A":"S3 Standard","B":"S3 Standard-IA","C":"S3 Glacier Deep Archive"}'::json,
  NULL,
  'Amazon S3 Standard is designed for frequently accessed data, offering high durability and availability. Amazon S3 Standard-IA (Infrequent Access) is for data that is accessed less frequently but requires rapid access when needed, offering lower storage costs. Amazon S3 Glacier Deep Archive is the lowest-cost storage class for archival data that is accessed rarely, typically once or twice a year, with retrieval times in hours.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  39,
  '{"left":["S3 Standard","S3 Standard-IA","S3 Glacier Deep Archive"],"right":["Frequently accessed data","Infrequently accessed data, rapid access needed","Archival data, accessed once or twice a year"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_6',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_70',
  'Match each AWS data transfer and hybrid storage service to its purpose.',
  'matching',
  '{"A":"AWS Storage Gateway","B":"AWS Snowball","C":"Amazon FSx for Windows File Server"}'::json,
  NULL,
  'AWS Storage Gateway connects on-premises software appliances with cloud-based storage, enabling hybrid cloud storage. AWS Snowball is a petabyte-scale data transfer device used for securely transferring large amounts of data into and out of AWS offline. Amazon FSx for Windows File Server provides a fully managed, highly reliable, and scalable native Windows file system, accessible over the Server Message Block (SMB) protocol.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  40,
  '{"left":["AWS Storage Gateway","AWS Snowball","Amazon FSx for Windows File Server"],"right":["Hybrid cloud storage integration with on-premises applications","Petabyte-scale data transfer device for offline migration","Fully managed native Windows file system"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_6',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_71',
  'Match each AWS storage service to its primary storage type.',
  'matching',
  '{"A":"Amazon S3","B":"Amazon EBS","C":"Amazon EFS"}'::json,
  NULL,
  'Amazon S3 (Simple Storage Service) provides object storage for unstructured data, ideal for data lakes, backups, and static websites. Amazon EBS (Elastic Block Store) offers persistent block storage volumes for use with Amazon EC2 instances. Amazon EFS (Elastic File System) provides shared file storage that can be mounted by multiple EC2 instances simultaneously, supporting the NFS protocol.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  41,
  '{"left":["Amazon S3","Amazon EBS","Amazon EFS"],"right":["Object storage for unstructured data","Block storage for EC2 instances","Shared file storage for multiple instances"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_6',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_72',
  'Match each Amazon S3 storage class to its typical access pattern.',
  'matching',
  '{"A":"S3 Standard","B":"S3 Standard-IA","C":"S3 Glacier Deep Archive"}'::json,
  NULL,
  'Amazon S3 Standard is designed for frequently accessed data, offering high durability and availability. Amazon S3 Standard-IA (Infrequent Access) is for infrequently accessed data that requires rapid access when needed, offering lower storage costs but higher retrieval fees. Amazon S3 Glacier Deep Archive is the lowest-cost storage class for archival data that is accessed once or twice a year, with retrieval times ranging from hours.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  42,
  '{"left":["S3 Standard","S3 Standard-IA","S3 Glacier Deep Archive"],"right":["Frequently accessed data","Infrequently accessed data with rapid access","Archival data accessed once or twice a year"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_6',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_73',
  'Match the data management requirement to the suitable AWS storage feature or service.',
  'matching',
  '{"A":"Protecting against accidental deletion","B":"Automating data movement to cheaper tiers","C":"Offline transfer of petabytes of data"}'::json,
  NULL,
  'S3 Versioning protects against accidental deletion or overwrites by keeping multiple versions of an object in the same bucket. S3 Lifecycle Policies automate the movement of objects between different S3 storage classes or deletion after a specified time, optimizing costs. The AWS Snow Family (e.g., Snowball, Snowmobile) is used for offline transfer of petabytes of data into and out of AWS, bypassing internet limitations.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  43,
  '{"left":["Protecting against accidental deletion","Automating data movement to cheaper tiers","Offline transfer of petabytes of data"],"right":["S3 Versioning","S3 Lifecycle Policies","AWS Snow Family"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_6',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_6_74',
  'A team needs to store various types of data, from frequently accessed application files to long-term archives, with different performance and cost requirements. Match each AWS storage service to its primary use case or characteristic.',
  'matching',
  '{"A":"Amazon S3","B":"Amazon EBS","C":"Amazon EFS"}'::json,
  NULL,
  'Amazon S3 (left[0]) is highly durable ''Object storage for static content'' (right[1]), ideal for data lakes, backups, and static website hosting. Amazon EBS (left[1]) provides persistent ''Block storage for EC2 instances'' (right[2]), functioning like a virtual hard drive that can be attached to a single EC2 instance (with Multi-Attach for specific volume types). Amazon EFS (left[2]) offers scalable ''Shared file storage for multiple instances'' (right[0]) using the NFS protocol, allowing many EC2 instances to access the same file system concurrently.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  44,
  '{"left":["Amazon S3","Amazon EBS","Amazon EFS"],"right":["Shared file storage for multiple instances","Object storage for static content","Block storage for EC2 instances"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_6',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_62_8
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_58',
  'Match each AWS messaging service to its communication pattern.',
  'matching',
  '{"A":"Amazon SQS","B":"Amazon SNS","C":"Amazon EventBridge"}'::json,
  NULL,
  'Amazon SQS (Simple Queue Service) provides decoupled message queues for microservices, distributed systems, and serverless applications. Amazon SNS (Simple Notification Service) is a pub/sub messaging service for high-throughput, push-based, many-to-many notifications. Amazon EventBridge is a serverless event bus that makes it easier to connect applications together using data from your own applications, integrated SaaS applications, and AWS services.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  45,
  '{"left":["Amazon SQS","Amazon SNS","Amazon EventBridge"],"right":["Decoupled message queues for microservices","Pub/Sub messaging for fan-out notifications","Serverless event bus for application integration"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_8',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_59',
  'Match each AWS developer tool to its primary function.',
  'matching',
  '{"A":"AWS CodePipeline","B":"AWS Amplify","C":"AWS CloudShell"}'::json,
  NULL,
  'AWS CodePipeline is a continuous delivery service that automates the release pipelines for fast and reliable application and infrastructure updates. AWS Amplify is a set of tools and services that enables developers to build and deploy full-stack web and mobile applications quickly. AWS CloudShell is a browser-based shell that makes it easy to securely manage, explore, and interact with your AWS resources.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  46,
  '{"left":["AWS CodePipeline","AWS Amplify","AWS CloudShell"],"right":["Automating continuous delivery pipelines","Building and deploying full-stack web and mobile apps","Browser-based shell for managing AWS resources"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_8',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_60',
  'Match the integration need to the appropriate AWS service.',
  'matching',
  '{"A":"Asynchronous task processing","B":"Fan-out notifications to multiple subscribers","C":"Orchestrating serverless workflows"}'::json,
  NULL,
  'For asynchronous task processing and decoupling components, Amazon SQS provides reliable message queues. For fan-out notifications to multiple subscribers (e.g., email, SMS, Lambda functions), Amazon SNS is the suitable publish/subscribe service. AWS Step Functions is a serverless workflow service that lets you combine AWS Lambda functions and other AWS services to build business-critical applications, ideal for orchestrating complex serverless workflows.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  47,
  '{"left":["Asynchronous task processing","Fan-out notifications to multiple subscribers","Orchestrating serverless workflows"],"right":["Amazon SQS","Amazon SNS","AWS Step Functions"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_8',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_61',
  'Match each AWS service to its primary application integration use case.',
  'matching',
  '{"A":"Amazon SQS","B":"Amazon SNS","C":"Amazon EventBridge"}'::json,
  NULL,
  'Amazon SQS is primarily used for decoupling application components by providing a reliable message queue, ensuring messages are processed even if a component is temporarily unavailable. Amazon SNS is ideal for sending notifications to various endpoints (e.g., email, SMS, Lambda) through a publish/subscribe model. Amazon EventBridge is used for building event-driven architectures, allowing applications to react to events from AWS services, SaaS applications, and custom applications.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  48,
  '{"left":["Amazon SQS","Amazon SNS","Amazon EventBridge"],"right":["Decoupling application components with message queues","Sending notifications to various endpoints","Building event-driven architectures across services"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_8',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_62_m_62_8_62',
  'A developer is building a decoupled, event-driven application and needs to choose appropriate messaging services for different communication patterns. Match each AWS messaging service to its primary communication model.',
  'matching',
  '{"A":"Amazon SQS","B":"Amazon SNS","C":"Amazon EventBridge"}'::json,
  NULL,
  'Amazon SQS (left[0]) is a fully managed ''Message queue for decoupling'' (right[1]) and buffering messages between distributed application components. Amazon SNS (left[1]) is a ''Publish/subscribe messaging'' (right[2]) service that allows you to send messages to a large number of subscribers simultaneously. Amazon EventBridge (left[2]) is a ''Serverless event bus'' (right[0]) that makes it easier to connect applications together using data from your own applications, integrated SaaS applications, and AWS services.',
  NOW(),
  'quiz_domain62_13',
  NOW(),
  49,
  '{"left":["Amazon SQS","Amazon SNS","Amazon EventBridge"],"right":["Serverless event bus","Message queue for decoupling","Publish/subscribe messaging"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_62_8',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_98'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_99'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_100'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_1_101'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_86'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_87'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_88'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_89'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_90'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_91'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_2_92'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_89'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_90'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_91'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_92'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_93'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_94'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_7_95'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_79'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_80'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_81'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_82'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_83'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_84'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_3_85'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_75'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_76'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_77'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_78'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_79'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_80'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_4_81'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_74'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_75'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_76'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_77'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_5_78'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_68'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_69'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_70'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_71'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_72'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_73'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_6_74'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_58'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_59'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_60'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_61'),
  (NOW(), 'quiz_domain62_13', 'q_62_m_62_8_62')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain62_13'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;
