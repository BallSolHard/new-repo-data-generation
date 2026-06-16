-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: SCS-C02
-- Generated: 2026-03-24T00:34:20.935Z
-- Questions: 3 (3 validated, 1 rejected)
-- Quiz ID: quiz_domain54_12
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_54_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_54_m_54_2_40',
  'Which AWS service continuously monitors for malicious activity and unauthorized behavior to protect AWS accounts and workloads by using threat intelligence, anomaly detection, and machine learning?',
  'mcq',
  '["Amazon GuardDuty","Amazon Macie","AWS Config","AWS CloudTrail"]'::json,
  '{0}',
  'Option A (Amazon GuardDuty) is the correct service. Amazon GuardDuty is a threat detection service that continuously monitors for malicious activity and unauthorized behavior to protect AWS accounts and workloads. It uses threat intelligence feeds, machine learning, and anomaly detection to identify potential threats.

Option B (Amazon Macie) is incorrect. Amazon Macie is primarily used for discovering, classifying, and protecting sensitive data, such as Personally Identifiable Information (PII), in Amazon S3 buckets. While security-related, its core purpose is not general threat detection across account and workload activity.

Option C (AWS Config) is incorrect. AWS Config provides a detailed inventory of AWS resources and records configuration changes over time. It helps in assessing, auditing, and evaluating the configurations of AWS resources to ensure compliance and detect unauthorized configuration changes, but it does not actively monitor for malicious activity.

Option D (AWS CloudTrail) is incorrect. AWS CloudTrail provides a record of actions taken by a user, role, or an AWS service in AWS. It is essential for auditing, compliance, and operational troubleshooting by logging API calls and related events, but it does not perform continuous threat detection for malicious behavior itself; rather, it provides the data that other services like GuardDuty or CloudTrail Insights analyze.',
  NOW(),
  'quiz_domain54_12',
  NOW(),
  1,
  NULL,
  NULL,
  'm_54_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_54_m_54_2_41',
  'Which AWS service continuously monitors for malicious activity and unauthorized behavior to protect AWS accounts and workloads, leveraging threat intelligence and machine learning?',
  'mcq',
  '["Amazon GuardDuty","Amazon Macie","AWS Config","AWS CloudTrail Insights"]'::json,
  '{0}',
  'Option A (correct) is Amazon GuardDuty. It is a threat detection service that continuously monitors for malicious activity and unauthorized behavior to protect AWS accounts and workloads. It uses threat intelligence feeds and machine learning to identify threats such as compromised EC2 instances or unauthorized API calls. Option B (incorrect) is Amazon Macie, which is primarily used for discovering, classifying, and protecting sensitive data in Amazon S3. It does not continuously monitor for general malicious activity across the entire AWS account. Option C (incorrect) is AWS Config, which assesses, audits, and evaluates the configurations of AWS resources for compliance. It helps detect unauthorized configuration changes but is not a threat detection service for malicious activity. Option D (incorrect) is AWS CloudTrail Insights, which helps identify unusual operational activity in AWS accounts, such as spikes in resource provisioning or gaps in routine maintenance. While security-related, its primary focus is on API activity anomalies, not general malicious activity or unauthorized behavior across workloads.',
  NOW(),
  'quiz_domain54_12',
  NOW(),
  2,
  NULL,
  NULL,
  'm_54_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_54_m_54_2_42',
  'Which AWS service provides a comprehensive view of the security state of AWS resources by aggregating, organizing, and prioritizing security findings from various AWS services and partner products?',
  'mcq',
  '["Amazon GuardDuty","Amazon Security Hub","AWS Systems Manager Incident Manager","AWS Config"]'::json,
  '{1}',
  'Option B (correct) is Amazon Security Hub. It aggregates, organizes, and prioritizes security findings from various AWS services (like GuardDuty, Macie, Inspector, and Config) and third-party partners, providing a centralized view of the security state. It also checks against security best practices and compliance standards like CIS AWS Foundations Benchmark. Option A (incorrect) is Amazon GuardDuty, which is a threat detection service that generates findings but does not aggregate findings from *other* services into a centralized view. Option C (incorrect) is AWS Systems Manager Incident Manager, which helps automate incident response and recovery, but it is not primarily for aggregating security findings from various services. Option D (incorrect) is AWS Config, which assesses, audits, and evaluates the configurations of AWS resources. While it can generate findings about non-compliant configurations, it does not aggregate findings from other security services.',
  NOW(),
  'quiz_domain54_12',
  NOW(),
  3,
  NULL,
  NULL,
  'm_54_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain54_12', 'q_54_m_54_2_40'),
  (NOW(), 'quiz_domain54_12', 'q_54_m_54_2_41'),
  (NOW(), 'quiz_domain54_12', 'q_54_m_54_2_42')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain54_12'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;


-- ═══════════════════════════════════════════════════════
-- Generated Mock Test Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Mock Test ID: ai_cloud_practitioner_mock4_def789
-- Topic ID: 5
-- Questions: 3
-- Generated: 2026-03-24T01:09:03.702Z
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_5_3
-- ─────────────────────────────────────────

INSERT INTO public.mock_test_questions (mock_test_id, question_text, options, question_type, correct_answer, explanation, topic_id, module_id, question_order, pairs, matches)
VALUES
  ('ai_cloud_practitioner_mock4_def789', 'A company has developed an Amazon SageMaker machine learning model for real-time fraud detection. They need to deploy this model to serve predictions with minimal operational overhead and ensure continuous monitoring for model performance degradation after deployment. Which approach meets these requirements MOST effectively?', '["Deploy the model to an Amazon SageMaker hosting endpoint and configure Amazon SageMaker Model Monitor.","Use Amazon SageMaker Batch Transform to process incoming requests periodically and store predictions in Amazon S3.","Deploy the model on a fleet of Amazon EC2 instances within an Auto Scaling group, managing the application and monitoring manually.","Package the model in an AWS Lambda function, invoking it for each prediction request and using Amazon CloudWatch for basic logging."]'::jsonb, 'mcq', '{0}'::integer[], 'Option A (correct) deploys the model to a fully managed Amazon SageMaker hosting endpoint, which handles scaling and infrastructure with minimal operational overhead. Integrating Amazon SageMaker Model Monitor allows for continuous monitoring of model quality, detecting data drift and concept drift, which is crucial for maintaining performance post-deployment. This directly addresses the anti-pattern of treating model deployment as the end of the ML lifecycle by ensuring ongoing evaluation.
Option B (incorrect) uses Amazon SageMaker Batch Transform, which is suitable for offline, large-scale inference on entire datasets, not for real-time, low-latency predictions. It also lacks built-in continuous model performance monitoring capabilities for real-time endpoints.
Option C (incorrect) involves deploying the model on Amazon EC2 instances. While feasible, this approach requires significant operational overhead for managing the instances, scaling, patching, and setting up custom monitoring solutions, which violates the "minimal operational overhead" constraint.
Option D (incorrect) suggests packaging the model in an AWS Lambda function. While Lambda can serve predictions, it''s generally not optimized for larger ML models due to package size limits and cold start issues, especially for real-time inference. Furthermore, setting up comprehensive model performance monitoring with Amazon CloudWatch alone would require significant custom development, increasing operational overhead.', 5, 'm_5_3', 1, NULL, NULL);

-- ─────────────────────────────────────────
-- Module: m_5_1
-- ─────────────────────────────────────────

INSERT INTO public.mock_test_questions (mock_test_id, question_text, options, question_type, correct_answer, explanation, topic_id, module_id, question_order, pairs, matches)
VALUES
  ('ai_cloud_practitioner_mock4_def789', 'A large e-commerce platform collects millions of customer reviews daily. The data scientists want to automatically group similar reviews together to discover emerging themes and common complaints without manually labeling each review. They need to understand the underlying structure of the unlabeled text data. Which machine learning paradigm is MOST appropriate for this task?', '["Supervised learning, using a pre-trained classification model to categorize reviews.","Unsupervised learning, employing clustering techniques to identify natural groupings.","Reinforcement learning, training an agent to interact with the review data.","Generative AI, to create new summary texts from the review content."]'::jsonb, 'mcq', '{1}'::integer[], 'Option B (correct) describes unsupervised learning, which is the most appropriate paradigm when dealing with unlabeled data to discover hidden patterns or structures. Clustering techniques are specifically designed to group similar data points (in this case, customer reviews) without prior knowledge of categories, directly addressing the requirement to find emerging themes without manual labeling. This aligns with the definition of unsupervised learning.
Option A (incorrect) refers to supervised learning, which requires a pre-labeled dataset to train a model to predict categories. The scenario explicitly states "without manually labeling each review," making supervised learning unsuitable as it violates the anti-pattern of confusing supervised and unsupervised learning (ap-1.1-002).
Option C (incorrect) involves reinforcement learning, which is used for training agents to make sequential decisions in an environment to maximize a reward. This paradigm is not suitable for analyzing and grouping existing text data.
Option D (incorrect) involves Generative AI, which focuses on creating new content (like summaries or new text). While it can process text, its primary goal is not to group existing unlabeled data to find inherent structures, but rather to generate new data based on learned patterns. This option confuses generative AI''s purpose with the need for data grouping (ap-1.1-003).', 5, 'm_5_1', 2, NULL, NULL);

-- ─────────────────────────────────────────
-- Module: m_5_2
-- ─────────────────────────────────────────

INSERT INTO public.mock_test_questions (mock_test_id, question_text, options, question_type, correct_answer, explanation, topic_id, module_id, question_order, pairs, matches)
VALUES
  ('ai_cloud_practitioner_mock4_def789', 'A security firm needs to automatically detect specific objects, people, and potentially unsafe activities in live video streams from surveillance cameras. They require a fully managed service that can process video content in real-time to trigger alerts without requiring custom machine learning model development. Which AWS service should they use?', '["Amazon Textract to extract text and data from video frames.","Amazon Comprehend to analyze sentiment and entities in video captions.","Amazon Transcribe to convert speech from video audio into text for analysis.","Amazon Rekognition Video to analyze objects, people, and activities in streaming video."]'::jsonb, 'mcq', '{3}'::integer[], 'Option D (correct) is Amazon Rekognition Video, a fully managed service that provides real-time analysis of video streams for object detection, facial recognition, person tracking, and activity detection. This directly addresses the requirement to detect specific objects, people, and activities in live video streams without custom ML model development.
Option A (incorrect) is Amazon Textract, which is designed to extract text and data from scanned documents, PDFs, and images, not for analyzing objects and activities in video streams. This service is inappropriate for the given data type.
Option B (incorrect) is Amazon Comprehend, a natural language processing (NLP) service used for analyzing text to extract insights like sentiment, entities, and key phrases. It is not designed for video content analysis. This service is inappropriate for the given data type.
Option C (incorrect) is Amazon Transcribe, a speech-to-text service that converts audio into text. While video streams contain audio, the primary requirement is to detect visual objects, people, and activities, not to transcribe speech. This service addresses only a secondary aspect of the video content, not the core visual analysis.', 5, 'm_5_2', 3, NULL, NULL);

-- Update mock test with question count
UPDATE public.mock_tests
SET total_questions = total_questions + 3
WHERE id = 'ai_cloud_practitioner_mock4_def789';

COMMIT;


-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: DVA-C02
-- Generated: 2026-03-24T03:24:20.985Z
-- Questions: 7 (7 validated, 2 rejected)
-- Quiz ID: quiz_domain52_11
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_52_1
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_52_m_52_1_37',
  'What is the primary purpose of using AWS Direct Connect with Border Gateway Protocol (BGP) in a hybrid cloud environment?',
  'mcq',
  '["To encrypt data at rest within Amazon S3 buckets.","To establish private, dedicated network connections between on-premises data centers and AWS, enabling dynamic route exchange.","To manage serverless function invocations across multiple AWS Regions.","To provide a global content delivery network for caching static web content."]'::json,
  '{1}',
  'Option B (correct) accurately describes the primary purpose of AWS Direct Connect with BGP. AWS Direct Connect establishes a dedicated network connection between an on-premises data center and AWS, bypassing the public internet. BGP is then used to dynamically exchange routing information between the customer''s network and AWS, ensuring efficient and stable hybrid connectivity. Option A is incorrect as Amazon S3 encryption is managed independently through S3 features or AWS Key Management Service (AWS KMS). Option C refers to AWS Lambda, which is a serverless compute service, unrelated to network connectivity establishment. Option D describes Amazon CloudFront, a content delivery network service, which is not the purpose of Direct Connect.',
  NOW(),
  'quiz_domain52_11',
  NOW(),
  1,
  NULL,
  NULL,
  'm_52_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_52_m_52_1_38',
  'A development team needs to establish a secure, encrypted connection between their on-premises data center and an Amazon VPC for a short-term project requiring occasional, low-bandwidth data transfer. The primary concern is to establish this connectivity with the LEAST initial setup cost and fastest deployment time. Which AWS service should be used?',
  'mcq',
  '["AWS Direct Connect","AWS Site-to-Site VPN","AWS Transit Gateway","Amazon VPC Peering"]'::json,
  '{1}',
  'Option B (correct) is the most suitable choice. An AWS Site-to-Site VPN connection establishes an encrypted tunnel over the public internet, offering a balance of security, speed of deployment, and cost-effectiveness for temporary, low-bandwidth needs. It has significantly lower initial setup costs and faster provisioning times compared to AWS Direct Connect.
Option A (incorrect) AWS Direct Connect provides a dedicated private connection between an on-premises data center and AWS. While it offers higher bandwidth and lower latency, it involves significant upfront costs (e.g., circuit installation) and longer provisioning times, making it unsuitable for a short-term, low-bandwidth, cost-sensitive requirement.
Option C (incorrect) AWS Transit Gateway is used to connect multiple VPCs and on-premises networks through a central hub. While it can aggregate VPN connections, it adds complexity and cost, which is not necessary for a single, temporary connection between one on-premises network and one VPC. It does not directly provide the underlying connectivity method.
Option D (incorrect) Amazon VPC Peering allows private network connectivity between two VPCs. It is used for inter-VPC communication within AWS and does not provide a mechanism to connect an on-premises data center to a VPC.',
  NOW(),
  'quiz_domain52_11',
  NOW(),
  2,
  NULL,
  NULL,
  'm_52_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_52_m_52_1_39',
  'A company needs to establish a dedicated private network connection between its on-premises data center and its Amazon VPCs. The primary goals are to reduce network costs associated with large data transfers over the public internet and to ensure consistent, high-bandwidth throughput for critical applications. Which AWS service is specifically designed to meet these requirements?',
  'mcq',
  '["Amazon VPC VPN","AWS Direct Connect","AWS Transit Gateway","Amazon Route 53"]'::json,
  '{1}',
  'Option B (AWS Direct Connect) is the correct choice. It provides a dedicated, private network connection from a customer''s premises to AWS, which helps reduce network costs, increase bandwidth throughput, and provide a more consistent network experience than internet-based connections. Option A (Amazon VPC VPN) establishes an encrypted connection over the public internet, which does not guarantee consistent bandwidth or bypass internet congestion. Option C (AWS Transit Gateway) is used to connect multiple VPCs and on-premises networks through a central hub, but it relies on underlying VPN or Direct Connect connections for the actual private link. Option D (Amazon Route 53) is a highly available and scalable Domain Name System (DNS) web service and is not used for establishing network connectivity.',
  NOW(),
  'quiz_domain52_11',
  NOW(),
  3,
  NULL,
  NULL,
  'm_52_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_52_3
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_52_m_52_3_39',
  'What is the primary benefit of utilizing Elastic Network Adapter (ENA) with Amazon EC2 instances?',
  'mcq',
  '["It enables high-performance networking, providing enhanced throughput and lower inter-instance latency.","It provides persistent block storage that can be attached to EC2 instances.","It automatically scales the number of EC2 instances based on incoming traffic.","It manages the domain name system (DNS) resolution for public-facing applications."]'::json,
  '{0}',
  'Option A (correct) accurately describes the primary benefit of Elastic Network Adapter (ENA). ENA is a custom-built network interface that supports high network performance on Amazon EC2 instances, delivering significantly higher bandwidth and lower inter-instance latency compared to traditional network interfaces. Option B refers to Amazon Elastic Block Store (Amazon EBS), which provides persistent block storage. Option C describes the functionality of Amazon EC2 Auto Scaling, which automatically adjusts the number of EC2 instances. Option D refers to Amazon Route 53, a highly available and scalable cloud DNS web service.',
  NOW(),
  'quiz_domain52_11',
  NOW(),
  4,
  NULL,
  NULL,
  'm_52_3',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_52_m_52_3_40',
  'A company is developing a high-performance computing (HPC) application that requires extremely low network latency and high throughput between Amazon EC2 instances within the same Amazon VPC. The application is sensitive to network jitter and needs to maximize network performance. Which feature should the developer ensure is enabled or utilized for the EC2 instances to meet these requirements?',
  'mcq',
  '["Configure jumbo frames on the EC2 instances.","Utilize Amazon EBS optimized instances.","Enable Enhanced Networking with Elastic Network Adapter (ENA).","Deploy instances in different Availability Zones."]'::json,
  '{2}',
  'Option C (correct) Enhanced Networking with Elastic Network Adapter (ENA) provides significantly higher packet per second (PPS) performance, lower inter-instance latency, and lower network jitter compared to traditional virtualized network interfaces. This is critical for HPC applications that demand maximum network performance.
Option A (incorrect) Configuring jumbo frames (MTU of 9001) can increase the payload size per packet, which can improve throughput for large data transfers by reducing packet overhead. However, it does not directly address latency or jitter as effectively as ENA, and misconfiguration can lead to fragmentation issues. ENA provides the underlying performance boost.
Option B (incorrect) Amazon EBS optimized instances are designed to deliver dedicated throughput between the Amazon EC2 instance and Amazon EBS volumes. While important for I/O-intensive applications, it specifically optimizes storage I/O, not inter-instance network latency or throughput, which is the primary requirement for this HPC application.
Option D (incorrect) Deploying instances in different Availability Zones would increase network latency between them, as Availability Zones are physically distinct locations. For applications requiring extremely low latency between instances, they should ideally be placed in the same Availability Zone and often within the same cluster placement group.',
  NOW(),
  'quiz_domain52_11',
  NOW(),
  5,
  NULL,
  NULL,
  'm_52_3',
  'medium'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_52_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_52_m_52_2_38',
  'A developer is troubleshooting why an AWS Lambda function cannot connect to an Amazon RDS database instance within a private subnet of an Amazon VPC. They need to quickly identify if network traffic is being blocked by security group rules or network ACLs. Which AWS service is best suited for this task?',
  'mcq',
  '["Amazon CloudWatch Logs","Amazon VPC Flow Logs","AWS Config","AWS Network Manager"]'::json,
  '{1}',
  'Option B (correct) Amazon VPC Flow Logs capture information about the IP traffic going to and from network interfaces in a VPC. This includes accepted and rejected traffic, source/destination IP addresses, ports, and protocols, which is crucial for identifying if security group rules or network ACLs are blocking traffic to the Amazon RDS instance.
Option A (incorrect) Amazon CloudWatch Logs is a general logging service that can store logs from various AWS services, including AWS Lambda function logs. While Lambda logs might show connection errors, Amazon CloudWatch Logs itself does not provide the network flow information needed to diagnose security group or network ACL issues directly at the VPC network interface level.
Option C (incorrect) AWS Config continuously monitors and records AWS resource configurations and allows you to automate the evaluation of recorded configurations against desired configurations. While it can show if security groups or network ACLs are misconfigured, it does not provide real-time traffic flow data to identify if traffic is actually being blocked.
Option D (incorrect) AWS Network Manager is a service that provides a central visual dashboard and automation tools for managing your global networks across AWS and on-premises environments. While useful for overall network management, it does not provide the granular, per-flow traffic logging needed to diagnose specific security group or network ACL blocking issues.',
  NOW(),
  'quiz_domain52_11',
  NOW(),
  6,
  NULL,
  NULL,
  'm_52_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_52_m_52_2_39',
  'A developer has configured a new network path between an Amazon EC2 instance residing in a private subnet and an Amazon S3 VPC endpoint. Before deploying the application, they need to verify that the network path is correctly configured and that traffic can flow as expected. This includes identifying any potential misconfigurations in security group rules, network ACLs, or route table entries. Which AWS service is specifically designed to perform this network path analysis and identify reachability issues?',
  'mcq',
  '["Amazon CloudWatch Network Insights","AWS Network Manager","AWS Reachability Analyzer","Amazon VPC Flow Logs"]'::json,
  '{2}',
  'Option C (AWS Reachability Analyzer) is the correct service for this task. It analyzes network configurations to determine reachability between specified source and destination resources, providing detailed insights into why a path is reachable or unreachable, including identifying misconfigured security groups, network ACLs, and route tables. Option A (Amazon CloudWatch Network Insights) is a broader capability within CloudWatch that includes Reachability Analyzer, but Reachability Analyzer is the specific tool. Option B (AWS Network Manager) is used for managing global networks across AWS and on-premises, not for detailed path analysis between specific endpoints. Option D (Amazon VPC Flow Logs) captures information about IP traffic going to and from network interfaces in a VPC, but it provides raw traffic data rather than actively analyzing network configurations for reachability.',
  NOW(),
  'quiz_domain52_11',
  NOW(),
  7,
  NULL,
  NULL,
  'm_52_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain52_11', 'q_52_m_52_1_37'),
  (NOW(), 'quiz_domain52_11', 'q_52_m_52_1_38'),
  (NOW(), 'quiz_domain52_11', 'q_52_m_52_1_39'),
  (NOW(), 'quiz_domain52_11', 'q_52_m_52_3_39'),
  (NOW(), 'quiz_domain52_11', 'q_52_m_52_3_40'),
  (NOW(), 'quiz_domain52_11', 'q_52_m_52_2_38'),
  (NOW(), 'quiz_domain52_11', 'q_52_m_52_2_39')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain52_11'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;
