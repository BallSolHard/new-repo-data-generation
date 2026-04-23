-- Update Critical Mock Test Questions (PROD)
-- Generated from updateonreview.py
-- Appended on each record processing

BEGIN;

-- question_id: 00561d7b-4331-48bc-8540-37c176f83cc1
-- answer_correct: True | verified_indices: [1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Enabling AWS Glue job metrics and logs in CloudWatch primarily provides operational performance data and raw job output, not structured data lineage or an auditable trail of specific column access and transformations. Option B (correct) Configuring AWS CloudTrail logs all API calls made to AWS Glue, including interactions with the AWS Glue Data Catalog (e.g., GetTable, UpdateTable) and potentially S3 data events (GetObject, PutObject), providing a comprehensive audit trail of what data was accessed, modified, and where it was written. Option C (incorrect) AWS Glue DataBrew is a separate data preparation service with its own recipe lineage tracking, which does not apply to custom AWS Glue Spark/Python jobs mentioned in the question. Option D (incorrect) The AWS Glue Data Catalog stores metadata but does not inherently provide "crawler lineage detection" or automatically track transformations; while CloudTrail integrates with the Data Catalog, the Data Catalog itself is not a lineage tracking service.'
WHERE question_id = '00561d7b-4331-48bc-8540-37c176f83cc1';

-- question_id: 009b9f2e-91a0-461b-b8e8-4fe8e4501ce3
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) A rolling update gradually replaces instances of an old version with new ones, often leveraging AWS Auto Scaling groups or ECS rolling updates, leading to a mixed environment during the transition rather than a full separate deployment and single traffic switch. Option B (incorrect) An in-place upgrade modifies the existing running instances directly, which typically incurs downtime or increased risk during the update process and does not involve deploying a separate environment alongside the current one. Option C (correct) Blue/green deployment involves creating a completely separate, identical environment (green) with the new application version alongside the current production environment (blue), then using services like Amazon Route 53 or an Application Load Balancer to instantly switch all traffic to the validated green environment. Option D (incorrect) A canary release gradually introduces the new application version to a small subset of users, often using AWS Lambda alias routing or Application Load Balancer weighted target groups, to monitor its performance and stability before a full rollout, which differs from an immediate full traffic switch once validated.'
WHERE question_id = '009b9f2e-91a0-461b-b8e8-4fe8e4501ce3';

-- question_id: 00b67b2b-9300-46eb-9984-56b8c4768330
-- answer_correct: True | verified_indices: [3] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Storing in S3 Standard-IA for 30 days before transitioning to Glacier Deep Archive incurs higher initial storage costs than necessary for infrequently accessed data and does not minimize long-term costs effectively due to the initial tier''s pricing and potential minimum duration charges. Option B (incorrect) S3 Intelligent-Tiering incurs monitoring and automation fees, and while it eventually moves data to a Deep Archive Access tier, direct placement in the cheapest tier for known infrequently accessed data is more cost-effective for primary cost optimization. Option C (incorrect) S3 Glacier Instant Retrieval provides millisecond access, which is not required as the retrieval window is "within hours," and its storage cost is significantly higher than S3 Glacier Deep Archive, thus not minimizing long-term costs. Option D (correct) Direct upload to S3 Glacier Deep Archive offers the lowest storage cost for long-term retention of infrequently accessed data, and its standard retrieval option of 12 hours meets the "within hours" requirement, making it the most cost-optimized solution despite S3 Glacier Deep Archive not offering expedited retrieval options in the traditional sense.'
WHERE question_id = '00b67b2b-9300-46eb-9984-56b8c4768330';

-- question_id: 00f9c8d0-e479-4231-9fc4-fb284ff84690
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Transactional processing (OLTP) is handled by services like Amazon RDS (Aurora, MySQL, PostgreSQL) or Amazon DynamoDB, which are optimized for high volumes of concurrent read/write operations and smaller transactions, not the complex analytical queries Redshift excels at. Option B (correct) Analytics and data warehousing (OLAP) is the primary purpose of Amazon Redshift, which uses a columnar storage and Massively Parallel Processing (MPP) architecture to efficiently execute complex analytical queries on petabyte-scale datasets. Option C (incorrect) In-memory caching is primarily addressed by Amazon ElastiCache (Redis or Memcached), designed to provide ultra-low latency data access for frequently requested data by applications, not for persistent analytical data storage. Option D (incorrect) Document storage is the domain of NoSQL databases like Amazon DocumentDB (MongoDB compatible) or Amazon DynamoDB, which are designed to store and query semi-structured or unstructured data such as JSON documents with flexible schemas.'
WHERE question_id = '00f9c8d0-e479-4231-9fc4-fb284ff84690';

-- question_id: 00fa0c90-d569-4b2c-a6ed-12cc3083a3b3
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) General purpose M-series instances offer a balance of compute, memory, and networking resources, making them suitable for diverse workloads but not specialized for the highest memory-to-vCPU ratio required by memory-intensive applications. Option B (correct) Memory optimized R-series instances are specifically designed to deliver a high memory-to-vCPU ratio, making them ideal for memory-intensive applications like in-memory databases, large caches, and big data analytics that require significant RAM. Option C (incorrect) Compute optimized C-series instances are optimized for compute-intensive applications, providing a high compute-to-memory ratio with powerful processors, rather than an emphasis on the highest memory capacity per vCPU. Option D (incorrect) Storage optimized I-series instances are designed for workloads requiring high, low-latency local storage I/O performance, such as transactional databases and data warehousing, and do not prioritize the highest memory-to-vCPU ratio.'
WHERE question_id = '00fa0c90-d569-4b2c-a6ed-12cc3083a3b3';

-- question_id: 0138a96f-869a-413b-8cbb-8faa2ff534d4
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Stratified sampling across demographics ensures that each demographic subgroup is proportionally represented in the training dataset, preventing underrepresentation of minorities, which is a key practice for responsible AI development supported by AWS services like Amazon SageMaker Data Wrangler for data preparation. Option B (correct) Synthetic data generation for minorities addresses data scarcity for underrepresented groups by creating artificial but statistically similar data points, helping to improve model fairness and reduce bias, a technique that complements AWS''s focus on ethical AI and can be integrated into SageMaker workflows for augmenting training data. Option C (incorrect) Using only majority data directly leads to biased models that perform poorly and unfairly for minority populations, a practice that contradicts AWS''s best practices for building fair and unbiased machine learning systems. Option D (incorrect) Random deletion does not specifically target or improve data diversity and can inadvertently remove critical samples, potentially worsening data imbalance or losing valuable information from minority groups rather than ensuring their representation. Option E (incorrect) Ignoring demographics prevents the identification and mitigation of biases present in the data, making it impossible to build models that perform equitably across all user groups, a practice contrary to AWS responsible AI guidelines and the capabilities of services like Amazon SageMaker Clarify for bias detection.'
WHERE question_id = '0138a96f-869a-413b-8cbb-8faa2ff534d4';

-- question_id: 0190dfca-733d-4862-8c4e-a67e5442ad3a
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) While explicitly instructing the model to output JSON with a predefined schema is a common prompt engineering technique, LLMs can occasionally generate malformed JSON, which would break automated downstream processing, making it less consistently parseable for critical workflows. Option 1 (correct) Requesting a natural language summary from the model and then using a separate AWS Lambda function to robustly parse and validate the text into JSON ensures consistent and valid output for automated workflows, leveraging deterministic code for guaranteed parseability and accuracy. Option 2 (incorrect) Chain-of-thought prompting enhances the model''s reasoning and content accuracy but does not inherently enforce a structured JSON output format; the result would still be a free-form text summary requiring further parsing. Option 3 (incorrect) Employing a negative prompt to discourage irrelevant content is a prompt engineering technique, but without specifying a structured format like JSON, the output would remain unstructured text, failing to meet the requirement for consistently parseable data for automated workflows.'
WHERE question_id = '0190dfca-733d-4862-8c4e-a67e5442ad3a';

-- question_id: 01ab636b-a07e-4a5a-a4f5-85d94dc17d8a
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Higher temperature flattens the probability distribution over the next token, increasing the likelihood of less probable tokens being selected, which leads to more diverse, creative, and less predictable outputs, a behavior adjustable in models accessed via Amazon Bedrock for generative AI applications. Option B (incorrect) Higher temperature makes outputs less deterministic; lower temperature values, closer to zero, sharpen the probability distribution, making the model more likely to pick the most probable token, resulting in more predictable and deterministic outputs, often preferred for factual tasks when deploying models on Amazon SageMaker. Option C (incorrect) Temperature is a critical hyperparameter that significantly influences the stylistic and qualitative aspects of LLM outputs, directly affecting the creativity and randomness of the generated text, making it a key configurable parameter in services like Amazon Bedrock. Option D (incorrect) Temperature primarily affects the quality and randomness of the generated output by influencing the token sampling process, not the speed of inference, which is instead determined by factors such as model size, available compute resources like AWS EC2 instances or AWS Inferentia, and network latency.'
WHERE question_id = '01ab636b-a07e-4a5a-a4f5-85d94dc17d8a';

-- question_id: 020d811f-fea6-43b5-983e-74c2f8d99a2f
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Operational Excellence focuses on running and monitoring systems and continually improving processes, such as automating infrastructure deployment with AWS CloudFormation and monitoring with Amazon CloudWatch, rather than primarily protecting information and systems. Option B (correct) Security is the correct principle as it specifically addresses protecting information and systems, implementing detective controls with AWS Security Hub, and managing access with AWS Identity and Access Management (IAM). Option C (incorrect) Reliability focuses on ensuring a workload performs its intended function correctly and consistently, including recovering from infrastructure or service disruptions using services like Amazon Route 53 for failover and AWS Auto Scaling, not primarily on protecting information. Option D (incorrect) Performance Efficiency focuses on using computing resources efficiently to meet system requirements and adapt to changing demands, such as selecting appropriate Amazon EC2 instance types and leveraging AWS Lambda for scalable serverless computing, not on protecting information.'
WHERE question_id = '020d811f-fea6-43b5-983e-74c2f8d99a2f';

-- question_id: 0267e4e4-dd70-472d-a92a-fa0aca385f40
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) CloudTrail does not directly capture application logs; these are typically collected and stored by services like Amazon CloudWatch Logs or other specialized logging solutions integrated within applications. Option B (incorrect) CloudTrail does not capture system performance metrics; these are collected by Amazon CloudWatch Metrics to monitor the operational health and performance of AWS resources. Option C (correct) CloudTrail is specifically designed to capture AWS API calls and related events, providing a historical record of actions taken by users, roles, or AWS services within your account. Option D (incorrect) CloudTrail does not capture raw network traffic data; this information is collected by services such as Amazon VPC Flow Logs to monitor and troubleshoot network connectivity and security.'
WHERE question_id = '0267e4e4-dd70-472d-a92a-fa0aca385f40';

-- question_id: 02e3250e-68bd-4f60-bedd-7a8fcec2cbed
-- answer_correct: True | verified_indices: [0, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Customers are responsible for implementing data encryption in transit for their specific applications and data flows using mechanisms such as TLS/SSL for application traffic, client-side encryption for S3 uploads, or IPsec tunnels for VPN connections, which falls under "Security in the Cloud". Option B (incorrect) Physical security of data centers, including the controlled access, surveillance, and environmental monitoring of the facilities where AWS global infrastructure resides, is solely an AWS responsibility ("Security of the Cloud"). Option C (correct) Customers are responsible for configuring network access control lists (ACLs) and security groups within their Amazon Virtual Private Cloud (VPC) to control inbound and outbound traffic to their virtual instances and subnets, which is a key aspect of "Security in the Cloud". Option D (incorrect) Hardware maintenance, including the patching, upgrading, and overall upkeep of the physical servers, storage, and networking devices that comprise the AWS infrastructure, is an AWS responsibility ("Security of the Cloud"). Option E (incorrect) Power and cooling systems for the physical data centers are fundamental aspects of the underlying infrastructure that AWS owns and operates, making them an AWS responsibility ("Security of the Cloud").'
WHERE question_id = '02e3250e-68bd-4f60-bedd-7a8fcec2cbed';

-- question_id: 02f6af99-c3a6-4697-8e69-4753489ae663
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Data collection is an initial phase, but MLOps encompasses the entire machine learning lifecycle beyond just data collection, focusing on orchestrating data ingestion and preparation via services like Amazon S3 and AWS Glue within a continuous pipeline. Option B (incorrect) Model training, often executed using Amazon SageMaker training jobs, is a key stage, but MLOps extends far beyond training to include data management, model deployment, monitoring, and continuous retraining, managing the entire process around the model. Option C (correct) MLOps primarily focuses on applying DevOps principles to machine learning to automate and streamline the entire ML lifecycle, from initial data preparation and model development to continuous deployment, monitoring, and retraining in production, leveraging services like Amazon SageMaker Pipelines and AWS CodePipeline for end-to-end automation. Option D (incorrect) Model evaluation, a critical step for assessing model performance often through Amazon SageMaker Model Monitor, is just one stage within the much broader MLOps scope, which includes development, deployment, inference, and continuous improvement processes across the model''s lifespan.'
WHERE question_id = '02f6af99-c3a6-4697-8e69-4753489ae663';

-- question_id: 035a177b-57e8-48eb-bcf3-bea62af0ba56
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon DynamoDB is a fully managed NoSQL key-value and document database service, which means it is not compatible with relational databases like MySQL or PostgreSQL. Option B (correct) Amazon Relational Database Service (RDS) is a fully managed service that provides support for multiple relational database engines, including MySQL and PostgreSQL, offering compatibility and operational ease. Option C (incorrect) Amazon Redshift is a fully managed, petabyte-scale data warehousing service optimized for analytical workloads, not for general-purpose transactional database compatibility with MySQL or PostgreSQL. Option D (incorrect) Amazon ElastiCache is a fully managed in-memory caching service, primarily used to speed up application performance, and does not provide persistent relational database compatibility with MySQL or PostgreSQL.'
WHERE question_id = '035a177b-57e8-48eb-bcf3-bea62af0ba56';

-- question_id: 0487201c-6bf1-4d45-952e-2b2bc64e5fd8
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increasing Lambda timeout only delays failure and more memory might speed up individual functions, but it doesn''t scale the overall processing rate for a high iterator age issue across many records and shards, where parallelization is key. Option B (incorrect) Increasing the batch size when Lambda functions are already timing out will likely worsen the timeouts by giving each invocation more work, further increasing processing time per invocation and iterator age. Option C (correct) Reducing Lambda batch size ensures individual invocations complete faster, and increasing the parallelization factor (up to 10 per shard) significantly boosts the overall processing throughput from the Kinesis stream, directly addressing high iterator age and reducing timeouts. Option D (incorrect) Configuring Lambda reserved concurrency guarantees a minimum number of available instances, but it doesn''t inherently increase the number of Kinesis-triggered invocations or processing rate if the Kinesis-Lambda integration''s scaling (shards, parallelization factor) is the bottleneck for high iterator age.'
WHERE question_id = '0487201c-6bf1-4d45-952e-2b2bc64e5fd8';

-- question_id: 05006210-f735-46dc-9b1d-1df335c46920
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS''s massive scale allows for more efficient resource utilization and procurement, driving down the per-unit cost of infrastructure for its customers rather than increasing it, exemplified by lower pricing for services like EC2 instances as AWS expands. Option B (correct) AWS''s vast global infrastructure and high volume of customers enable it to achieve significant economies of scale in hardware procurement, data center operations, and power consumption, directly translating to lower, pay-as-you-go pricing models for services like S3 and EC2, benefiting customers economically. Option C (incorrect) AWS''s architecture is built on a global network of Regions and Availability Zones, designing for high availability and redundancy to ensure broad service availability for services like Amazon RDS, rather than limiting it. Option D (incorrect) While AWS offers a wide array of services, its primary goal is to abstract underlying infrastructure and offer managed services like AWS Fargate or Amazon DynamoDB to reduce operational complexity for customers, not increase it.'
WHERE question_id = '05006210-f735-46dc-9b1d-1df335c46920';

-- question_id: 054fc873-d176-418c-88b3-dba54a1cc821
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) SMS-based MFA is susceptible to SIM swapping and interception attacks, making it less secure and generally not recommended by AWS for protecting critical accounts like the root user or privileged IAM users. Option B (correct) Hardware security keys, such as those compliant with FIDO U2F/WebAuthn standards, offer the highest level of security because they are phishing-resistant, cryptographically secure, and physically separate from the device being used, making them extremely difficult to compromise for AWS root and IAM users. Option C (incorrect) Virtual MFA apps generate time-based one-time passwords (TOTP) and while more secure than SMS, they are still vulnerable if the device they are installed on is compromised by malware or if the MFA seed is phished, offering a lower level of security than a dedicated hardware key for AWS accounts. Option D (incorrect) Email-based verification is the least secure method as email accounts are frequently targeted by phishing and other compromise attempts, making it highly unsuitable for protecting sensitive AWS resources.'
WHERE question_id = '054fc873-d176-418c-88b3-dba54a1cc821';

-- question_id: 0552dbcd-4e0e-4490-bd82-55913e42d0b3
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Classification categorizes data into predefined classes, such as ''healthy'' or ''failed'', which is useful for current status reporting but less optimal for identifying novel or subtle precursors of equipment failure that deviate from established patterns. Option B (correct) Anomaly detection identifies unusual patterns or deviations from normal operating behavior, which is highly suitable for predicting equipment failures by detecting early warning signs in sensor data before they escalate into critical issues, a capability offered by AWS services like Amazon Lookout for Equipment. Option C (incorrect) Regression predicts a continuous numerical value, such as remaining useful life or the exact time until failure, which is a specific quantitative prediction rather than the broad detection of an impending problem based on abnormal behavior. Option D (incorrect) Clustering groups similar data points based on inherent characteristics, which could help in segmenting equipment or identifying operational modes but does not directly predict individual equipment failures before they occur.'
WHERE question_id = '0552dbcd-4e0e-4490-bd82-55913e42d0b3';

-- question_id: 05987ad6-8c1e-4761-8c0a-19a367de39e2
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Vision Transformers fundamentally differ from CNNs by employing self-attention mechanisms to process image patches as sequences, rather than relying on the convolutional layers that are the hallmark of CNN architectures often used in services like Amazon SageMaker for tasks such as image classification. Option B (incorrect) While CNNs are primarily built on convolutions, Vision Transformers explicitly move away from this approach, relying on attention to capture long-range dependencies, a fundamental architectural distinction for models deployed on AWS. Option C (incorrect) CNNs utilize convolutional layers for feature extraction, not attention, whereas Vision Transformers leverage attention, making the claim that both use only attention incorrect for the diverse machine learning workflows on AWS. Option D (incorrect) Both CNNs and Vision Transformers are highly effective and widely used for various image processing tasks, such as those that might power features in Amazon Rekognition or custom models developed and deployed on Amazon SageMaker.'
WHERE question_id = '05987ad6-8c1e-4761-8c0a-19a367de39e2';

-- question_id: 05f8ffcc-b5e1-4ba0-965f-4753842354e8
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Cross-Zone Load Balancing ensures traffic is distributed evenly across all registered targets in all enabled Availability Zones, it does not determine the health of individual instances or route traffic away from unhealthy ones. Option B (incorrect) Sticky Sessions configure the ALB to route requests from a specific client to the same target instance for a defined duration, which is unrelated to assessing instance health and rerouting traffic from unhealthy instances. Option C (correct) Target Group Health Checks are crucial for an ALB to regularly assess the health of registered EC2 instances, automatically stopping traffic to any instance that fails the configured health check thresholds. Option D (incorrect) Security Groups act as a virtual firewall controlling network access to EC2 instances and the ALB, but they do not actively monitor instance health or reroute traffic based on application or system health status.'
WHERE question_id = '05f8ffcc-b5e1-4ba0-965f-4753842354e8';

-- question_id: 062960e9-15c6-40f7-b1c9-1a00bae8e6e5
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The AWS Well-Architected Framework focuses on helping customers design and operate reliable, secure, efficient, and cost-optimized workloads in the cloud by providing prescriptive guidance across six pillars (Operational Excellence, Security, Reliability, Performance Efficiency, Cost Optimization, and Sustainability), rather than guiding the initial strategic benefits of cloud adoption itself. Option B (correct) The AWS Cloud Adoption Framework (CAF) provides guidance and best practices across six perspectives (Business, People, Governance, Platform, Security, and Operations) to help organizations develop an efficient and effective plan for successful cloud adoption, specifically addressing the benefits and challenges of moving to AWS. Option C (incorrect) There is no specific standalone "AWS Security Framework"; instead, security is a shared responsibility with AWS providing secure infrastructure and numerous security services like AWS IAM and AWS KMS, while customers are responsible for security in the cloud, which is also a perspective within CAF and a pillar in the Well-Architected Framework. Option D (incorrect) The AWS Migration Framework, often referred to through programs like the Migration Acceleration Program (MAP) or strategies like the 6 Rs of migration, focuses on the tactical process of moving existing applications and data to AWS using services like AWS DMS and AWS SMS, rather than the initial strategic understanding of overall cloud adoption benefits.'
WHERE question_id = '062960e9-15c6-40f7-b1c9-1a00bae8e6e5';

-- question_id: 065e8100-844f-40ce-96bc-dae427216a56
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Comprehend is an AWS service for natural language processing (NLP), designed to extract insights and relationships from unstructured text, not visual content. Option B (incorrect) Amazon Polly is an AWS text-to-speech service that converts text into lifelike speech, serving a different purpose than visual analysis. Option C (correct) Amazon Rekognition is the AWS service specifically designed for image and video analysis, capable of detecting objects, scenes, faces, and activities within visual media. Option D (incorrect) Amazon Textract is an AWS service for intelligent text and data extraction from documents, focusing on OCR and structural understanding, not general object detection in arbitrary images.'
WHERE question_id = '065e8100-844f-40ce-96bc-dae427216a56';

-- question_id: 06735a8f-0cdf-4613-9736-dedd7ee083d2
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Mixture of Experts (MoE) architectures achieve efficient scaling by routing each input to only a subset of "expert" sub-networks, meaning that during inference on services like Amazon SageMaker, only the parameters of the activated experts are loaded and computed, leading to lower latency and reduced compute costs compared to running an equivalently sized dense model. Option B (incorrect) MoE fundamentally operates by *not* using all parameters all the time; instead, a router network selectively activates a few experts per input, which is the opposite of using all parameters constantly and would negate the efficiency benefits for large-scale deployments on AWS. Option C (incorrect) MoE is designed to *enhance* model capabilities by allowing for a much larger total number of parameters than a conventional dense model, enabling it to learn more diverse and complex patterns without the prohibitive computational cost for inference, making it suitable for high-performing large language models often deployed on AWS. Option D (incorrect) MoE architectures are inherently *more complex* than standard dense models, introducing components like a gating network (router) and multiple expert sub-networks, which adds complexity to model training, deployment, and management on platforms like Amazon SageMaker, often requiring specialized frameworks or configurations.'
WHERE question_id = '06735a8f-0cdf-4613-9736-dedd7ee083d2';

-- question_id: 068db01c-2950-4e93-b10f-39272f1b5599
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Guardrails for Amazon Bedrock do not increase model speed; they operate as a processing layer to evaluate and filter input/output, which can introduce a slight overhead rather than improve speed. Option B (correct) Guardrails for Amazon Bedrock are specifically designed to implement responsible AI controls and filters by setting safety policies to block harmful content, filter sensitive information, and define undesirable topics in model interactions. Option C (incorrect) Guardrails for Amazon Bedrock are not purposed to reduce storage costs; storage costs are managed by underlying AWS storage services like S3 or EBS, not by content filtering mechanisms. Option D (incorrect) Guardrails for Amazon Bedrock do not compress model outputs; output compression is typically handled by application logic or data transfer mechanisms, not by a responsible AI filtering service.'
WHERE question_id = '068db01c-2950-4e93-b10f-39272f1b5599';

-- question_id: 06bdb362-476a-400d-a80a-d2765ed01364
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config records configuration changes of your AWS resources over time for auditing and compliance, rather than providing detailed logs of individual API calls made in the account. Option B (incorrect) Amazon CloudWatch is a monitoring and observability service that collects logs, metrics, and events, but it does not generate detailed API call logs directly; it can ingest logs from other services like CloudTrail. Option C (correct) AWS CloudTrail provides detailed logs of API calls made across your AWS account, enabling security analysis, resource change tracking, and compliance auditing by recording who, what, when, and from where API calls were made. Option D (incorrect) AWS Inspector is an automated security assessment service that identifies vulnerabilities and deviations from best practices in applications and infrastructure, not a service that logs API calls.'
WHERE question_id = '06bdb362-476a-400d-a80a-d2765ed01364';

-- question_id: 06e8e76c-d3d1-47b8-b888-7c4978eb6df7
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The COPY command in Amazon Redshift is primarily for bulk loading data from S3, EMR, or DynamoDB and does not inherently support an UPSERT parameter or direct DELETE functionality for incremental loads. Option B (correct) The MERGE statement in Amazon Redshift allows you to efficiently combine INSERT, UPDATE, and DELETE operations from a source table into a target table in a single, atomic transaction, perfectly addressing the need for upsert and delete capabilities. Option C (incorrect) While a stored procedure can encapsulate a sequence of UPDATE, INSERT, and DELETE statements, it executes them as separate operations rather than providing a single, combined DML statement that inherently handles all three efficiently in one logical operation. Option D (incorrect) Redshift data sharing is a feature for sharing data across different clusters, accounts, or regions, and while it might be used to access staging data, it does not itself perform the DML operations (merge, upsert, delete) required for incremental loading into a target table.'
WHERE question_id = '06e8e76c-d3d1-47b8-b888-7c4978eb6df7';

-- question_id: 07151951-f8a6-42b5-9601-ea2596ee0716
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Systems Manager is primarily an operational hub for managing and automating tasks across your AWS resources, not a service focused on identifying broad misconfigurations or security vulnerabilities as its core function. Option B (correct) AWS Trusted Advisor is specifically designed to provide recommendations by inspecting your AWS environment for adherence to best practices, including identifying misconfigured resources and potential security vulnerabilities under its security category. Option C (incorrect) AWS Cost Explorer is a financial management tool that helps visualize and manage AWS costs and usage, unrelated to identifying security issues or misconfigurations. Option D (incorrect) AWS Marketplace is a digital catalog for finding and purchasing third-party software, services, and data, and does not serve to identify misconfigured AWS resources or security vulnerabilities.'
WHERE question_id = '07151951-f8a6-42b5-9601-ea2596ee0716';

-- question_id: 07a4092a-506a-40fd-9ff1-fb1670a10783
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While the term "serverless" implies a lack of servers from the developer''s perspective, AWS Lambda still runs on underlying compute infrastructure, such as Amazon EC2 instances and other virtualized environments, which are provisioned and managed entirely by AWS. Option B (correct) In the context of AWS Lambda, "serverless" means that AWS fully provisions, scales, patches, and maintains all the underlying server infrastructure required to run your code, abstracting away all operational responsibilities from the developer. Option C (incorrect) Servers are not managed manually by the user with AWS Lambda; manual server management is typically associated with Infrastructure as a Service (IaaS) offerings like Amazon EC2, where users are responsible for operating system, patching, and scaling. Option D (incorrect) Although AWS Lambda''s execution environment ultimately relies on physical servers in AWS data centers, the "serverless" model means developers do not interact with or manage these physical servers, nor do they manage virtual servers; this responsibility is entirely absorbed by AWS.'
WHERE question_id = '07a4092a-506a-40fd-9ff1-fb1670a10783';

-- question_id: 07a6bbc6-99f6-43f5-b72d-a09a3ba57b87
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] (incorrect) While Kinesis Data Streams is excellent for high-throughput streaming, it is not explicitly an "IoT platform" for managing device connectivity and protocols, and it lacks the long-term message buffering and decoupling benefits of SQS for handling extreme variations in downstream processing workloads. Option [1] (correct) SQS provides a highly scalable and durable message queue that effectively decouples ingestion from processing, absorbing variable ingestion rates and acting as a robust buffer. Lambda, triggered by SQS, can perform real-time processing and simultaneously persist the raw data to S3 for batch analysis, thus providing distinct and scalable processing paths. Option [2] (incorrect) Although AWS IoT Core is ideal for managing device connectivity, its rules engine, when directly routing to Lambda and S3, offers less robust decoupling and buffering than SQS for handling sustained downstream processing backlogs or failures under highly variable ingestion rates. Option [3] (incorrect) This option primarily focuses on stream and batch analytics processing components (Kinesis Data Analytics and EMR) without providing a complete architecture for initial ingestion from thousands of IoT devices or the flexible storage of raw data for batch analysis.'
WHERE question_id = '07a6bbc6-99f6-43f5-b72d-a09a3ba57b87';

-- question_id: 083f1244-960b-4cea-97a1-aec486da439a
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The AWS Partner Network (APN) extends beyond just consulting companies, as it explicitly includes Technology Partners who build software and integrate with AWS services like Amazon EC2 or Amazon S3. Option B (correct) The AWS Partner Network comprehensively categorizes its members into Consulting Partners, such as System Integrators and Managed Service Providers, and Technology Partners, comprising Independent Software Vendors (ISVs) offering solutions that run on or integrate with AWS. Option C (incorrect) The APN is not limited to only software vendors (Technology Partners) but also includes Consulting Partners who provide services like migration assistance using AWS Migration Hub or managed operations for AWS environments. Option D (incorrect) While system integrators are a type of Consulting Partner within the APN, the network is far broader, encompassing Managed Service Providers, Value-Added Resellers, and a distinct category for Technology Partners who provide software solutions.'
WHERE question_id = '083f1244-960b-4cea-97a1-aec486da439a';

-- question_id: 0856fb3a-62eb-4d7a-9842-17aaaeff87e8
-- answer_correct: False | verified_indices: [1, 3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1, 3}'::integer[],
    explanation = 'Option A (incorrect) Enabling Glue job auto-scaling dynamically adjusts the number of workers but does not fundamentally change the memory footprint of individual join operations, failing to address per-executor out-of-memory errors caused by inefficient join strategies. Option B (correct) Implementing broadcast joins for smaller dimension tables under 2 GB significantly reduces memory pressure by sending the entire smaller table to all executors, eliminating the need for expensive data shuffling and reducing intermediate data storage during the join. Option C (incorrect) Increasing executor memory by using larger Glue worker types is a brute-force approach that adds more resources rather than optimizing the join''s memory usage, which the problem statement indicates is already proving unsustainable and only temporarily helpful. Option D (correct) Partitioning data by join keys before performing join operations reduces memory pressure by ensuring that co-located data is processed on the same executors, minimizing data shuffling and the intermediate memory required for sort-merge or hash joins.'
WHERE question_id = '0856fb3a-62eb-4d7a-9842-17aaaeff87e8';

-- question_id: 0864c78d-ff5a-43fa-9939-5bccaa164543
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS eliminates the need for large upfront capital expenditures on hardware and infrastructure by allowing companies to pay for resources like EC2 instances and S3 storage on a usage basis, converting CAPEX to OPEX. Option B (incorrect) AWS''s pay-as-you-go model and elasticity, leveraging services like Auto Scaling Groups and Lambda, inherently reduce fixed operational expenses by allowing resources to scale dynamically with demand, avoiding over-provisioning. Option C (incorrect) While AWS helps optimize and potentially reduce IT costs significantly, customers still incur costs for the AWS services they consume, such as EC2 instance hours or S3 storage, and may still have internal IT staff for management and development. Option D (incorrect) AWS primarily aims to convert fixed costs into variable costs and make them more aligned with actual usage through services like Amazon S3 and Amazon DynamoDB, which are billed based on consumption rather than requiring large fixed investments.'
WHERE question_id = '0864c78d-ff5a-43fa-9939-5bccaa164543';

-- question_id: 086fe99a-5ed4-4ef0-b19f-c91f4559278f
-- answer_correct: True | verified_indices: [2] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Glue DataBrew is primarily for visual data preparation and cleansing, and while it supports data quality rules, its focus is not on programmatic, fail-fast validation within an automated ETL job to directly stop downstream processing upon validation failure in the same manner as a dedicated data quality library. Option B (incorrect) Implementing custom validation logic in a Glue ETL job is possible, but CloudWatch alarms monitor metrics and do not inherently provide a direct mechanism to stop the *current* Glue job processing *within the job itself* based on data content validation failures; the job would need to explicitly fail for CloudWatch to detect an error metric. Option C (correct) The Great Expectations library seamlessly integrates into a Glue ETL job, allowing declarative definition of data quality expectations (e.g., record counts, null checks, range checks), providing robust validation that can programmatically halt processing upon failure, and generating validation reports that can trigger SNS notifications. Option D (incorrect) A Lambda function is suitable for event-driven, lightweight tasks, but performing extensive, full-dataset data validation for a large-scale data pipeline within Lambda is generally inefficient and prone to hitting memory or execution time limits, making it unsuitable for this scenario.'
WHERE question_id = '086fe99a-5ed4-4ef0-b19f-c91f4559278f';

-- question_id: 08c32347-aaef-48be-868b-04a16091a1fa
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Data poisoning involves the malicious manipulation of training data by an adversary, potentially affecting the integrity of models trained on services like Amazon SageMaker by causing them to learn incorrect behaviors or exhibit biases, necessitating robust data validation and monitoring practices for inputs from sources like S3. Option B (incorrect) Improving data quality, often performed using services like AWS Glue for ETL and data cleansing, is the process of making data more accurate and reliable, which is the antithesis of data poisoning. Option C (incorrect) Data compression is a technique to reduce data size for storage and transmission efficiency, commonly used with Amazon S3 for cost optimization, and is unrelated to the security threat of data poisoning. Option D (incorrect) Data encryption, provided by services like AWS Key Management Service (KMS) and S3 server-side encryption, protects data confidentiality and integrity from unauthorized access but does not prevent a legitimate or compromised user from introducing malicious data into a dataset before or after encryption.'
WHERE question_id = '08c32347-aaef-48be-868b-04a16091a1fa';

-- question_id: 08e52483-afbf-409f-bb7d-d6cd377fe9fb
-- answer_correct: True | verified_indices: [1] | confidence: 95%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) While Amazon Redshift with columnar storage and result caching provides strong analytical query performance, managing a large cluster for 500TB can be very expensive, and its cost optimization may not be as favorable as a serverless solution for this specific query pattern. Option 1 (correct) Amazon Athena with partitioned Parquet data and query result reuse offers significant performance improvements by drastically reducing data scanned and optimizes costs due to its serverless, pay-per-query model and efficient columnar storage. Option 2 (incorrect) Aurora PostgreSQL is an OLTP database not designed for 500TB analytical workloads, making it unsuitable and extremely expensive for complex SQL queries on such a massive dataset. Option 3 (incorrect) Deploying an EMR cluster with Presto can handle distributed SQL queries effectively, but it requires cluster management and can incur higher operational and compute costs compared to a serverless service like Athena for intermittent queries.'
WHERE question_id = '08e52483-afbf-409f-bb7d-d6cd377fe9fb';

-- question_id: 08f95cd3-c6e4-4f3e-8083-b938f37a3d32
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option 0 (incorrect) This strategy typically results in RTOs of several hours or more, due to the time required to provision new EC2 instances, restore snapshots, and configure applications, which significantly exceeds the <15 minute RTO requirement. Option 1 (incorrect) While more cost-effective than warm standby, the Pilot Light strategy often requires provisioning and scaling up the full application tier (EC2 instances) from a minimal base, which can push the RTO beyond the <15 minute target, especially for complex applications. Option 2 (correct) A Warm Standby strategy, leveraging cross-Region Amazon RDS Read Replicas for low RPO and pre-provisioned, scaled-down EC2 instances ready for quick scale-up, can reliably achieve RTOs under 15 minutes and RPOs under 1 hour while balancing cost efficiency. Option 3 (incorrect) While this strategy provides the lowest RTO and RPO (typically seconds), it incurs the highest cost due to running a full-scale, active infrastructure in multiple Regions simultaneously, thus not meeting the requirement to minimize costs.'
WHERE question_id = '08f95cd3-c6e4-4f3e-8083-b938f37a3d32';

-- question_id: 0910d6ee-b2ae-443c-a255-a749b0d131fe
-- answer_correct: True | verified_indices: [1] | confidence: 95%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While Transformers can leverage parallel processing for efficiency, they typically have high computational demands for training large models, often requiring significant resources like those provided by AWS EC2 GPU instances, rather than inherently reducing total training time for equivalent performance. Option B (correct) The self-attention mechanism in transformer architecture allows for efficient and robust modeling of long-range dependencies in sequences, enabling superior contextual understanding in NLP tasks leveraged by AWS services like Amazon Comprehend and Amazon Translate. Option C (incorrect) Transformer models, especially large ones, are memory-intensive due to their attention mechanisms and numerous parameters, frequently requiring high-memory AWS EC2 instance types or specialized GPU memory for training and inference via services like Amazon SageMaker. Option D (incorrect) Implementing the transformer architecture from scratch is considerably more complex than simpler neural network models, involving intricate components like multi-head attention and positional encoding, although AWS SageMaker facilitates deployment of pre-trained models.'
WHERE question_id = '0910d6ee-b2ae-443c-a255-a749b0d131fe';

-- question_id: 0a582d3c-70dc-475d-a383-c046e792a4dd
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Query expansion leverages AWS services like Amazon Bedrock to generate alternative queries or Amazon Kendra for intelligent search, while document reranking, often implemented with models deployed via Amazon SageMaker, refines the order of retrieved documents to ensure the most relevant information is provided to the LLM, both significantly improving response quality. Option B (incorrect) Random retrieval would provide irrelevant context to the LLM, leading to inaccurate and low-quality responses, contradicting the purpose of RAG which relies on relevant information from services like Amazon OpenSearch Service. Option C (incorrect) No processing would mean a basic, unoptimized retrieval that fails to understand user intent or refine search results, leading to suboptimal document provision to the LLM and poor response quality, unlike the structured data processing possible with AWS Glue or embedding generation using Amazon SageMaker. Option D (incorrect) Limiting RAG to a single document would drastically reduce the available context for the LLM, potentially missing critical information spread across multiple relevant sources and resulting in incomplete or inaccurate answers, whereas robust RAG systems built on Amazon OpenSearch Service or Amazon Bedrock knowledge bases are designed to retrieve multiple pertinent documents.'
WHERE question_id = '0a582d3c-70dc-475d-a383-c046e792a4dd';

-- question_id: 0a6974dc-b02d-4598-babf-b05ffaff7fe4
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Individual account isolation is an inherent feature of separate AWS accounts that AWS Organizations helps manage, but it is not the main cost management purpose that Organizations itself provides. Option B (correct) AWS Organizations'' primary cost management feature is consolidated billing, which aggregates usage across all member accounts to achieve volume pricing tiers and maximize discounts, resulting in lower overall costs. Option C (incorrect) While AWS Organizations improves overall governance and security posture through features like Service Control Policies (SCPs), this is a security management benefit and not its main purpose specifically for cost management. Option D (incorrect) AWS Organizations is an account and billing management service and has no direct impact on the performance of AWS services or applications running within member accounts.'
WHERE question_id = '0a6974dc-b02d-4598-babf-b05ffaff7fe4';

-- question_id: 0a74e1db-ebf2-4552-bc1a-6c075f33c387
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Downsizing instances would reduce hourly costs but does not address the significant cost savings available from completely stopping resources during non-business hours, missing the primary optimization opportunity for this time-bound environment. Option 1 (incorrect) Spot Instances are primarily designed for fault-tolerant EC2 workloads, are not available for managed RDS and ElastiCache services, and are unsuitable for a development environment requiring consistent availability during specified business hours due to their interruptible nature. Option 2 (correct) Implementing automated stop/start scheduling with Lambda and EventBridge directly aligns with the "only used during business hours" requirement by completely stopping EC2 instances and RDS databases, and potentially managing ElastiCache capacity, to eliminate costs when the environment is not in use. Option 3 (incorrect) Purchasing Reserved Instances provides cost savings for continuous, predictable workloads, but would lead to paying for resources that are idle outside of business hours and on weekends, making them inefficient for an environment with such a specific operational schedule.'
WHERE question_id = '0a74e1db-ebf2-4552-bc1a-6c075f33c387';

-- question_id: 0b1bcb93-51c4-441d-880d-d7606341a7c2
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Migrating all resources to a single AWS account makes cost allocation more challenging as it consolidates all billing under one entity, requiring extensive and error-prone tagging to differentiate costs for various departments or projects instead of leveraging AWS Organizations for clear billing separation. Option 1 (incorrect) Using only On-Demand instances without Reserved Instances is a cost optimization choice that typically results in higher overall costs for stable workloads and does not inherently improve or simplify cost allocation to departments compared to other purchasing options. Option 2 (correct) Analyzing AWS Cost and Usage Reports (CUR) provides granular billing data, and implementing resource tagging allows for the categorization and filtering of these costs by department, project, or environment, which are essential for detailed cost allocation. Option 3 (incorrect) Disabling all monitoring to reduce operational overhead would severely hinder visibility into resource usage, performance, and security, making effective cost allocation and optimization efforts significantly more difficult and potentially leading to compliance issues.'
WHERE question_id = '0b1bcb93-51c4-441d-880d-d7606341a7c2';

-- question_id: 0bb2718d-d305-48ce-82e7-f7dc92ce7037
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS IAM is primarily used for managing access to AWS services and resources, defining users, groups, roles, and their permissions, but it does not manage encryption keys or provide hardware security modules. Option B (correct) AWS KMS (Key Management Service) is a managed service designed to create and control encryption keys, and it leverages FIPS 140-2 validated hardware security modules (HSMs) to protect the security and integrity of those keys. Option C (incorrect) AWS Secrets Manager is used to store, manage, and rotate sensitive information like database credentials and API keys, and while it integrates with KMS for encryption of the secrets, it is not the service that directly manages encryption keys or provides HSMs. Option D (incorrect) AWS Certificate Manager (ACM) provisions, manages, and deploys SSL/TLS certificates for use with AWS services and connected resources, dealing with public key infrastructure for secure communication, not general encryption key management or HSM provisioning.'
WHERE question_id = '0bb2718d-d305-48ce-82e7-f7dc92ce7037';

-- question_id: 0bd77441-c83e-4268-91fb-47f68f82b755
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon ECS with EC2 launch type requires you to provision, scale, and manage the underlying EC2 instances that host your containers.Option B (correct) AWS Fargate is a serverless compute engine that allows you to run containers without having to provision, manage, or scale any servers or underlying infrastructure.Option C (incorrect) Amazon EKS is a managed Kubernetes service that manages the control plane, but typically requires you to provision and manage the EC2 worker nodes where your containers run, unless explicitly configured to use Fargate.Option D (incorrect) AWS Batch is a batch job scheduling and execution service that provisions compute resources (which can be EC2 instances you manage or Fargate) for your jobs, but it is primarily focused on job orchestration rather than inherently freeing you from managing all underlying infrastructure for general container workloads.'
WHERE question_id = '0bd77441-c83e-4268-91fb-47f68f82b755';

-- question_id: 0c1892cd-4f72-4f07-b655-d02daef32291
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon SQS is a message queuing service designed for decoupling application components and provides point-to-point delivery, not direct pub/sub for sending notifications. Option B (correct) Amazon SNS is a fully managed pub/sub messaging service specifically designed for sending notifications to a multitude of subscribers and various endpoints like email, SMS, and HTTP/S. Option C (incorrect) Amazon Kinesis is a suite of services for real-time processing of streaming data at scale, not primarily a pub/sub service for general notifications. Option D (incorrect) Amazon EventBridge is an event bus service for routing events between applications and AWS services to build event-driven architectures, rather than a direct pub/sub service for broad notification delivery.'
WHERE question_id = '0c1892cd-4f72-4f07-b655-d02daef32291';

-- question_id: 0c2bb98b-5bc7-4891-9f03-8a5e7a7ac2f5
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Cross-validation typically increases training time and computational costs because it involves training and evaluating a model multiple times on different subsets of data, often utilizing distributed training on Amazon SageMaker instances rather than speeding up a single training run. Option B (correct) Cross-validation is a crucial technique to assess how well a machine learning model will perform on new, unseen data, ensuring the model built and deployed via Amazon SageMaker will generalize effectively beyond the training set. Option C (incorrect) Cross-validation does not directly reduce model size; model size reduction techniques like pruning or quantization are distinct processes often applied after or in conjunction with model training and evaluation, with AWS SageMaker Neo being a service that optimizes compiled models for deployment. Option D (incorrect) Cross-validation is focused on model evaluation and performance, not on data security; encryption of model parameters or data is handled by security services like AWS Key Management Service (KMS) when storing artifacts in Amazon S3 or configuring encryption for SageMaker training jobs and endpoints.'
WHERE question_id = '0c2bb98b-5bc7-4891-9f03-8a5e7a7ac2f5';

-- question_id: 0cb8055f-e9e8-4ca4-a273-6399f47799ae
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While AWS IAM roles with explicit deny policies can restrict actions within an account, applying them consistently across all accounts within an AWS Organization would require managing and deploying these policies in each individual account, which is not a centralized enforcement mechanism at the organization level. Option B (incorrect) AWS Control Tower with AWS Config rules primarily provides governance and audits resource configurations for compliance *after* deployment, rather than directly preventing resource deployment centrally at the organization level across all accounts. Option C (correct) AWS Organizations with Service Control Policies (SCPs) is the correct choice because SCPs are powerful guardrails that allow operations engineers to centrally define and enforce maximum permissions for all IAM users and roles within an entire AWS Organization or specific Organizational Units, including denying resource deployments in specific AWS Regions. Option D (incorrect) AWS Security Hub with custom actions is a security posture management service that aggregates findings and allows for automated responses to security issues, but it is designed for identifying and responding to problems rather than centrally *preventing* specific resource deployments across an entire organization.'
WHERE question_id = '0cb8055f-e9e8-4ca4-a273-6399f47799ae';

-- question_id: 0cc4e692-61c3-44cf-ae92-975c8bc8228b
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) A simple routing policy is used for a single resource or multiple resources without the ability to perform health checks or automatic failover to a different endpoint. Option B (incorrect) A geolocation routing policy directs traffic based on the geographic location of the user, not on the health status of an endpoint for automatic disaster recovery. Option C (correct) A failover routing policy, in conjunction with Route 53 health checks, is specifically designed to automatically redirect traffic to a secondary healthy endpoint if the primary endpoint becomes unhealthy, fulfilling the requirement for improved resilience through cross-Region failover. Option D (incorrect) A weighted routing policy distributes traffic to multiple resources based on assigned weights and while it can use health checks to remove unhealthy endpoints, its primary purpose is not to automatically fail over all traffic from a failed primary to a designated secondary.'
WHERE question_id = '0cc4e692-61c3-44cf-ae92-975c8bc8228b';

-- question_id: 0cecaea6-6ec6-417f-a2b6-5babee8e7e36
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Amazon SQS Standard queues do not guarantee message ordering or provide exactly-once delivery, failing to meet two critical requirements of the application. Option B (correct) Amazon SQS FIFO queues guarantee strict message ordering and ensure exactly-once processing, while Lambda processing can handle time-sensitive transactions within the 2-second requirement, and a Dead Letter Queue provides robust error handling. Option C (incorrect) Amazon Kinesis Data Streams guarantees ordering only within a shard and offers at-least-once delivery, requiring custom consumer-side logic for exactly-once processing and potentially complex shard management for global ordering. Option D (incorrect) Amazon EventBridge does not guarantee message ordering and provides at-least-once delivery, meaning it cannot natively meet the strict ordering and exactly-once delivery requirements for financial transactions.'
WHERE question_id = '0cecaea6-6ec6-417f-a2b6-5babee8e7e36';

-- question_id: 0d0e7268-15cd-434e-9403-0b5f7e328e8f
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Polly is a Text-to-Speech service that converts text into lifelike speech, not for analyzing sentiment or extracting entities. Option B (incorrect) Amazon Lex is a service for building conversational interfaces (chatbots and voice bots) using Automatic Speech Recognition and Natural Language Understanding to process user input, not for general sentiment analysis or entity extraction from text documents. Option C (correct) Amazon Comprehend is a natural language processing (NLP) service that specifically uses machine learning to uncover insights from text, including analyzing sentiment and extracting entities. Option D (incorrect) Amazon Textract is an optical character recognition (OCR) service that automatically extracts text and data from scanned documents, forms, and tables, but it does not analyze the sentiment or extract entities from the extracted text.'
WHERE question_id = '0d0e7268-15cd-434e-9403-0b5f7e328e8f';

-- question_id: 0dda2626-a841-4a1b-8bc3-54b4117e5f00
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deploying models to production is a subsequent step in the machine learning lifecycle, handled by services like Amazon SageMaker Endpoints, and occurs after data analysis, model training, and validation. Option B (correct) EDA is essential for gaining initial insights into the dataset, identifying distributions, correlations, outliers, and preparing data for modeling, often performed using notebooks in Amazon SageMaker Studio. Option C (incorrect) Training machine learning models, typically executed through Amazon SageMaker training jobs or AWS Deep Learning AMIs, is a distinct phase that follows comprehensive data understanding and preprocessing achieved during EDA. Option D (incorrect) Data collection is typically an upstream process, often involving services like AWS Kinesis or AWS Glue for ingestion, and while EDA might highlight data gaps, its primary goal is to analyze the data already available.'
WHERE question_id = '0dda2626-a841-4a1b-8bc3-54b4117e5f00';

-- question_id: 0dde9411-ce71-42a2-9840-9c4fbfb5f55e
-- answer_correct: True | verified_indices: [0] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) CloudFront effectively caches and serves static content globally from edge locations, while Lambda@Edge provides programmatic intelligence at the edge to route API calls to optimal regional backends based on custom logic, perform dynamic content generation, or implement advanced failover strategies. Option B (incorrect) AWS Global Accelerator optimizes dynamic traffic and API calls by routing requests over the AWS global network to the nearest healthy endpoint (like ALBs), but it does not provide global caching for static content like CloudFront does, thus not fully optimizing both. Option C (incorrect) Route 53 with latency-based routing provides DNS-level optimization to direct users to the lowest latency region, and CloudFront can utilize multiple origins for redundancy, but this combination lacks the fine-grained, request-level "intelligent routing based on performance" for API calls that solutions like Lambda@Edge or Global Accelerator offer at the network edge or CDN edge. Option D (incorrect) API Gateway with edge optimization inherently uses CloudFront to serve APIs from edge locations, and CloudFront custom behaviors can define specific caching and routing rules, but this combination does not explicitly offer the dynamic, programmable "intelligent routing based on performance" or advanced failover logic at the edge that Lambda@Edge or Global Accelerator can provide for both content types.'
WHERE question_id = '0dde9411-ce71-42a2-9840-9c4fbfb5f55e';

-- question_id: 0e0cd343-f278-4ba9-87af-4356079dc627
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While comparing CloudWatch metrics is valuable for understanding resource saturation and identifying general trends in CPU, memory, or I/O utilization, it primarily shows symptoms of performance degradation (e.g., resources are bottlenecked) rather than pinpointing the specific inefficient operations within the ETL code itself that are causing the problem. Option B (correct) Profiling the ETL code, for instance using Spark UI for AWS Glue or Amazon EMR jobs, directly identifies which transformations, functions, or stages are consuming the most time and resources, providing precise insight into the algorithmic or operational bottlenecks responsible for the significant performance degradation. Option C (incorrect) Reviewing job execution logs for errors and retry patterns is critical for diagnosing job failures or instability and understanding why a job might restart, but it is less effective at revealing the root cause of degraded performance in jobs that are successfully completing, albeit slowly. Option D (incorrect) Analyzing data distribution and partitioning strategy is a crucial optimization technique for distributed processing like AWS Glue and EMR, as it can highlight issues like data skew or inefficient I/O; however, code profiling (Option B) is a more fundamental approach that will reveal *any* slow operation, which might then lead to investigating partitioning as a specific solution for identified I/O or shuffle bottlenecks.'
WHERE question_id = '0e0cd343-f278-4ba9-87af-4356079dc627';

-- question_id: 0e3e3d4d-7a7c-4272-94ae-88ac8c89c5b4
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Glue ETL jobs with PySpark transformations involve writing code (PySpark/Scala Spark) for data transformations, which does not align with the requirement for visual data transformation with built-in functions in a graphical interface. Option B (incorrect) AWS Lambda is a serverless compute service best suited for event-driven, smaller-scale tasks, and while it can run custom parsing code, processing 100 GB of daily logs would be inefficient, costly, and it offers no visual transformation capabilities. Option C (correct) AWS Glue DataBrew is specifically designed for visual data preparation, offering a graphical interface with over 250 pre-built transformations suitable for tasks like parsing strings, performing lookups (e.g., GeoIP), and converting timestamps without writing code. Option D (incorrect) Amazon EMR with Apache Spark provides a powerful platform for large-scale data processing, but transformations are primarily coded using Spark APIs, and EMR itself does not offer the "visual data transformation with built-in functions" experience described in the question.'
WHERE question_id = '0e3e3d4d-7a7c-4272-94ae-88ac8c89c5b4';

-- question_id: 0e7bdd78-61da-4f05-af62-fb590ab54621
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) CloudWatch Events is not primarily designed for data storage; services like Amazon S3, Amazon EBS, or Amazon CloudWatch Logs are used for storing different types of data. Option B (correct) CloudWatch Events (now EventBridge) is primarily used for event-driven automation and monitoring by routing events from various sources to target AWS services to trigger actions or notifications. Option C (incorrect) User authentication in AWS is handled by AWS Identity and Access Management (IAM) and Amazon Cognito, not by CloudWatch Events. Option D (incorrect) Cost tracking and management are primarily handled by AWS Cost Explorer, AWS Budgets, and the AWS Billing dashboard, not by CloudWatch Events.'
WHERE question_id = '0e7bdd78-61da-4f05-af62-fb590ab54621';

-- question_id: 0e823572-fcf1-4d7e-9fa3-0b4ac846cbdc
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Database management is handled by AWS services like Amazon RDS, DynamoDB, or Aurora, not Amazon CloudFront, which focuses on content distribution. Option B (correct) Content delivery and caching is the primary purpose of Amazon CloudFront, a global content delivery network (CDN) that uses edge locations to cache and deliver content closer to users with low latency. Option C (incorrect) Server provisioning is managed by services such as Amazon EC2 or AWS Lambda, which are responsible for creating and managing compute instances or functions, not CloudFront. Option D (incorrect) User authentication is typically managed by AWS Identity and Access Management (IAM) or Amazon Cognito, not by CloudFront, which focuses on delivering content rather than user identity verification.'
WHERE question_id = '0e823572-fcf1-4d7e-9fa3-0b4ac846cbdc';

-- question_id: 0e957cad-674d-4750-a83c-a98f3840433d
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) A rolling update replaces instances of an old version with new ones incrementally within the same environment, but it does not primarily focus on gradually routing a small percentage of user traffic to a new feature for observation before a full rollout, rather it minimizes downtime during an update across all instances. Option B (incorrect) Blue/green deployment involves switching all traffic at once from an old environment to a new, fully tested environment, which does not allow for gradually increasing exposure to a small subset of users. Option C (correct) A canary deployment strategy precisely matches the requirements by routing a small, controlled percentage of live user traffic to the new version initially, allowing for real-world monitoring and gradual increase of exposure using services like AWS CodeDeploy with its Canary deployment type or AWS App Mesh. Option D (incorrect) Rolling out a feature to a specific geographical region first targets all users within that region, not a small, percentage-based subset of the overall user base, and while a form of phased rollout, it''s not the direct answer to "small subset of users, gradually increasing exposure" in the context of feature testing across the user base.'
WHERE question_id = '0e957cad-674d-4750-a83c-a98f3840433d';

-- question_id: 0f1c8ddf-1eb8-4b1f-9a8f-f0be2a2dc9bb
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Aurora MySQL is not best suited for data warehousing because data warehousing involves analytical processing of large datasets (OLAP) which is typically handled more efficiently by purpose-built services like Amazon Redshift with its columnar storage and optimized query engine. Option B (correct) Amazon Aurora MySQL is specifically designed for high-performance transactional applications, offering superior performance and availability for online transaction processing (OLTP) workloads through its distributed, fault-tolerant, and self-healing storage system. Option C (incorrect) Amazon Aurora MySQL is not suited for caching because caching requires extremely low-latency, in-memory data storage and retrieval, a function best performed by services like Amazon ElastiCache (Redis or Memcached) which are optimized for high throughput and speed. Option D (incorrect) Amazon Aurora MySQL is not exclusively for analytics only; it is primarily an OLTP database, and while it can handle some analytical queries, dedicated analytical workloads are better served by services like Amazon Redshift, Amazon Athena, or Amazon EMR for optimal performance and cost-efficiency.'
WHERE question_id = '0f1c8ddf-1eb8-4b1f-9a8f-f0be2a2dc9bb';

-- question_id: 10524771-22b7-4a0c-b651-6d2978de0264
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) NAT Gateway allows instances in a private subnet to initiate outbound connections to the internet, but traffic to AWS public services like S3 or DynamoDB would still traverse the public internet, violating the security and private connectivity requirements. Option B (incorrect) Internet Gateway provides internet connectivity for a VPC and allows instances in a public subnet to reach the internet, but it explicitly routes traffic over the public internet, which contradicts the requirement of "without traversing the public internet." Option C (correct) VPC Endpoints, specifically Gateway Endpoints for S3 and DynamoDB, enable private connectivity from instances in a private subnet to supported AWS services, ensuring all traffic remains within the Amazon network, thus providing maximum security and low latency without traversing the public internet. Option D (incorrect) Direct Connect Gateway is used to connect an on-premises network to multiple VPCs across different AWS regions via an AWS Direct Connect connection, not for connecting an application within a private subnet directly to AWS services like S3 or DynamoDB within the AWS network without traversing the public internet.'
WHERE question_id = '10524771-22b7-4a0c-b651-6d2978de0264';

-- question_id: 10597798-1fbb-4abb-b5a7-f73732ddd15d
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) AWS Key Management Service (KMS) with customer-managed keys (CMKs) uses multi-tenant HSMs managed by AWS and does not provide direct customer access to the underlying hardware security modules for key generation and management, nor does it guarantee FIPS 140-2 Level 3 compliance for its default key stores. Option B (correct) AWS CloudHSM provides dedicated, single-tenant hardware security modules that are FIPS 140-2 Level 3 compliant, giving customers full, direct control over the HSMs and the cryptographic keys for generation and management, directly meeting all specified requirements. Option C (incorrect) AWS Secrets Manager is designed for storing secrets like database credentials and API keys, encrypting them using KMS, but it is not an HSM and does not provide dedicated hardware or direct access for key management. Option D (incorrect) AWS Systems Manager Parameter Store SecureString is used for storing encrypted configuration data and sensitive strings, leveraging KMS for encryption, but it is not an HSM and does not offer dedicated hardware, FIPS 140-2 Level 3 compliance, or direct HSM access.'
WHERE question_id = '10597798-1fbb-4abb-b5a7-f73732ddd15d';

-- question_id: 10e36db6-7385-45c9-a216-7d69d294f9e0
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Deploying all resources within a single Availability Zone only provides resilience against an Availability Zone failure, not an entire AWS Region outage, as an Availability Zone is a distinct location within a single Region. Option B (correct) Implementing a multi-Region active-passive (e.g., pilot light or warm standby) or active-active (hot standby) architecture is the most effective strategy because it designs the application to run across physically isolated AWS Regions, allowing failover if one Region becomes unavailable, utilizing services like Route 53 for DNS failover and cross-Region data replication for databases or storage. Option C (incorrect) Relying on daily backups to restore services in the same Region is insufficient because if the entire Region is down, there is no operational environment in that Region to restore services to, regardless of backup availability. Option D (incorrect) While some serverless services (e.g., S3, Route 53, DynamoDB Global Tables) offer multi-Region capabilities or global distribution, not all serverless services are inherently global in a way that prevents application downtime during a full Region outage; most regional serverless compute like Lambda functions still need to be deployed across multiple Regions to achieve inter-Region resilience.'
WHERE question_id = '10e36db6-7385-45c9-a216-7d69d294f9e0';

-- question_id: 11dd7f42-2330-4ae7-846e-3c166d65ba01
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) Using AWS Serverless Application Model (SAM) with AWS CodePipeline and AWS CodeBuild offers the least operational overhead because SAM simplifies defining serverless resources, CodePipeline automates the entire release process from Git, and CodeBuild handles the necessary build and packaging steps, creating a fully automated, repeatable CI/CD pipeline that minimizes manual intervention and ensures consistent deployments. Option B (incorrect) Manually creating and updating AWS Lambda functions and AWS Step Functions state machines through the AWS Management Console introduces significant operational overhead as it is highly prone to human error, inconsistent across environments, and lacks automation or integration with version control. Option C (incorrect) Writing custom Python scripts to package and deploy AWS Lambda functions and define Step Functions state machines introduces substantial development and maintenance overhead for the custom scripts themselves, which must be built, tested, and updated, rather than leveraging purpose-built AWS services that provide this functionality out-of-the-box. Option D (incorrect) Utilizing AWS CloudFormation templates for Infrastructure as Code is a good practice for consistency and repeatability, but manually uploading templates to Amazon S3 and deploying through the CloudFormation console still involves manual steps, lacks integration with version control for automated triggers, and increases operational overhead compared to a fully automated CI/CD pipeline.'
WHERE question_id = '11dd7f42-2330-4ae7-846e-3c166d65ba01';

-- question_id: 1225f109-ffb8-418d-b857-ec43d20e11d6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Model quantization typically involves a trade-off where a slight reduction in model accuracy may occur, or at best, accuracy is maintained, as seen when using AWS SageMaker Neo to optimize models for various hardware targets where the focus is performance rather than an increase in accuracy. Option B (correct) Model quantization reduces the precision of model weights and activations, converting them from data types like 32-bit floats to 8-bit integers, thereby significantly decreasing the model''s memory footprint and accelerating inference on services such as AWS SageMaker Endpoints or AWS IoT Greengrass, directly leading to lower inference costs. Option C (incorrect) Quantization focuses on reducing the numerical precision of a model''s existing parameters and activations, not on increasing the number of parameters, which would generally make the model larger and more complex, contradicting the purpose of quantization. Option D (incorrect) Expanding vocabulary is a concept specific to natural language processing models, where new words or tokens are added to the model''s lexicon, a process entirely unrelated to model quantization which deals with the numerical precision of weights and activations.'
WHERE question_id = '1225f109-ffb8-418d-b857-ec43d20e11d6';

-- question_id: 124422b4-0926-40b1-b447-c8cd838e0056
-- answer_correct: True | verified_indices: [0, 4] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS DataSync is designed for high-performance, automated data transfers between on-premises and S3, using multi-threading and optimized network protocols to significantly improve throughput over existing connections. Option B (incorrect) While upgrading Direct Connect would increase raw bandwidth and reduce transfer time, it''s a direct increase in infrastructure cost and might not be the most cost-effective or optimized solution when other options can improve efficiency or leverage existing resources better to achieve the "potentially reduce networking costs" goal. Option C (incorrect) AWS Snowball Edge is suitable for large-scale, infrequent data migrations (PBs of data) but is operationally impractical and costly for daily 10 TB transfers due to the shipping, handling, and integration overhead involved. Option D (incorrect) AWS Transfer Family provides managed SFTP/FTPS/FTP endpoints for S3, simplifying protocol compatibility, but it does not offer the same level of performance optimization (like multi-threading and intelligent network utilization) as AWS DataSync for large-scale bulk data transfers. Option E (correct) Scheduling DataSync transfers during off-peak hours avoids network contention from other applications, allowing dedicated use of the 1 Gbps Direct Connect, and DataSync''s parallel transfer capabilities maximize throughput and efficiency over that connection.'
WHERE question_id = '124422b4-0926-40b1-b447-c8cd838e0056';

-- question_id: 12b9efb1-9ee8-4d91-8093-d5c0f72a2370
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Developing a custom Python script on an Amazon EC2 instance introduces significant operational overhead for managing the EC2 instance, maintaining the custom orchestration logic, implementing robust error handling, retries, and visual tracking, which contradicts the requirement for the least operational overhead. Option B (correct) AWS Step Functions is purpose-built for orchestrating complex, multi-step workflows with visual tracking, built-in error handling, automatic retries, and state management, abstracting away much of the operational complexity and meeting all requirements with low operational overhead. Option C (incorrect) While AWS Glue Workflows can orchestrate Glue jobs and some Lambda functions, its error handling, retry mechanisms, and visual tracking capabilities are less comprehensive and flexible compared to Step Functions for a pipeline involving a diverse mix of Lambda and Glue steps, especially when robust and granular control over state and error handling across heterogeneous steps is critical. Option D (incorrect) Scheduling individual AWS Lambda functions and AWS Glue jobs using Amazon EventBridge rules is suitable for simple, independent tasks but lacks the built-in capabilities for managing complex inter-step dependencies, state persistence, robust error handling across multiple steps, automatic retries with backoff strategies, or visual workflow tracking required for this type of pipeline.'
WHERE question_id = '12b9efb1-9ee8-4d91-8093-d5c0f72a2370';

-- question_id: 130f49ad-71bd-485a-9e56-e1aadc0937b6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Migrating to serverless without analyzing resource needs is a significant architectural change that may not resolve the immediate CPU bottleneck and could introduce new complexities or cost inefficiencies if not properly planned. Option B (correct) Right-sizing EC2 instances directly addresses the identified problem by providing more CPU capacity through a larger instance type or a compute-optimized instance family, allowing the application to handle its workload without exceeding 90%+ CPU utilization. Option C (incorrect) Reducing the number of EC2 instances would further starve the application of necessary CPU resources, leading to increased bottlenecks and performance degradation, which is contrary to the goal of improving performance. Option D (incorrect) A CloudFront distribution primarily offloads static content delivery and improves latency, but it does not directly alleviate high CPU utilization caused by the application''s backend processing or complex computations on the EC2 instances.'
WHERE question_id = '130f49ad-71bd-485a-9e56-e1aadc0937b6';

-- question_id: 13849520-1814-41a4-92e5-1d1c15db548e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using homogeneous training data leads to models that are biased towards the characteristics present in that data, failing to generalize or perform fairly for underrepresented groups, which contradicts the goal of inclusivity and would be identified as bias by AWS SageMaker Clarify. Option B (correct) Training on diverse, representative datasets allows the AI model to learn patterns across a wide range of characteristics, demographics, and scenarios, significantly reducing bias and improving fairness and performance for all user groups, aligning with best practices for data preparation using AWS Glue for ETL before training with Amazon SageMaker. Option C (incorrect) Ignoring demographic factors prevents the identification and mitigation of biases related to specific groups, making it impossible to ensure an AI model is truly inclusive, as AWS SageMaker Clarify''s bias detection capabilities often rely on analyzing these factors. Option D (incorrect) Using the smallest possible dataset is unlikely to provide sufficient data to represent the diversity of a population, leading to models that generalize poorly, are prone to bias, and lack robustness for different user segments, even when trained on AWS SageMaker.'
WHERE question_id = '13849520-1814-41a4-92e5-1d1c15db548e';

-- question_id: 13b0b6e3-69d7-4964-9ce5-f4cc7a796811
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The Business support plan provides 24/7 access to Cloud Support Engineers and offers some billing assistance but does not include a dedicated Concierge Support Team for specialized best practices. Option B (incorrect) The Enterprise On-Ramp support plan offers proactive guidance and a dedicated Technical Account Manager (TAM) for operational reviews, but it does not include the Concierge Support Team specifically focused on billing and account best practices. Option C (correct) The Enterprise support plan is the highest tier and explicitly includes a Concierge Support Team, which provides specialized assistance for billing, account management, and best practices. Option D (incorrect) Only the Enterprise support plan includes the Concierge Support Team, as lower-tier plans like Developer, Business, and Enterprise On-Ramp offer different levels of support without this specialized dedicated team.'
WHERE question_id = '13b0b6e3-69d7-4964-9ce5-f4cc7a796811';

-- question_id: 13df5d3c-e9e2-45f7-a33c-ed688bbfe31c
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon CloudFront with regional edge caches and intelligent origin selection effectively minimizes costs by caching popular content close to users globally, reducing origin load, and allowing region-specific content to be fetched from localized origins only when needed, minimizing cross-region data transfer out of origin. Option B (incorrect) S3 with cross-region replication and lifecycle policies ensures data availability and optimizes storage tiers but does not provide the performance benefits of a CDN or directly minimize data transfer costs to end-users from the closest edge location. Option C (incorrect) Global storage with CDN caching would still incur higher origin data transfer costs for region-specific content that is stored globally, rather than leveraging the cost benefits of regional data locality. Option D (incorrect) Regional storage with intelligent traffic routing and caching describes a general architectural pattern, but it lacks the specific, fully managed, and highly optimized global infrastructure and features provided by AWS CloudFront, making it less specific and potentially less cost-effective than Option A.'
WHERE question_id = '13df5d3c-e9e2-45f7-a33c-ed688bbfe31c';

-- question_id: 14229d07-5784-4d0c-928b-e8e0c463a796
-- answer_correct: True | verified_indices: [2] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Glue ETL job using PySpark with custom data quality functions is a highly manageable serverless option but might offer less granular control over the Spark environment, configurations, and custom dependencies compared to EMR, which could be critical for exceptionally complex transformations or highly optimized custom quality frameworks. Option B (incorrect) Lambda function with Python pandas for data transformation is ill-suited for large-scale data processing due to inherent limitations in execution time, memory, and payload size, making it impractical for transforming large S3 JSON files to Parquet. Option C (correct) EMR cluster with Apache Spark and custom quality framework provides the ultimate flexibility and deep control over the Apache Spark environment, allowing for highly complex transformation logic, custom libraries, and advanced data quality frameworks, while EMR as a managed service handles the underlying infrastructure for good manageability. Option D (incorrect) AWS Glue DataBrew with built-in data quality rules is primarily a visual data preparation tool that lacks the programmatic flexibility and scalability required for highly complex, custom transformation logic and sophisticated data quality checks on large datasets.'
WHERE question_id = '14229d07-5784-4d0c-928b-e8e0c463a796';

-- question_id: 1483f299-5720-4b38-88e1-39a51b272f73
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Giving maximum permissions to all users violates the principle of least privilege and is an anti-pattern in AWS security, as it increases the attack surface and potential for unauthorized actions or data breaches, directly opposing AWS IAM best practices for finely-grained access control. Option B (correct) Granting only necessary permissions for specific tasks is the direct definition of the principle of least privilege, ensuring that AWS IAM users, roles, or services like Amazon SageMaker have access only to the resources and actions required to perform their designated functions, minimizing the impact of a compromised credential or misconfigured application. Option C (incorrect) Removing all permissions would render an AI system or any AWS resource entirely unusable, as no legitimate operations could be performed, directly contradicting the need for functional access even while prioritizing security. Option D (incorrect) Using public access for everything is a severe security vulnerability that completely disregards the principle of least privilege, exposing AI system components such as Amazon S3 buckets containing training data or Amazon SageMaker endpoints to unauthorized internet access instead of restricting access via controlled IAM policies or network configurations.'
WHERE question_id = '1483f299-5720-4b38-88e1-39a51b272f73';

-- question_id: 151cd87f-7648-428c-91a2-77ef23691371
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config continuously monitors and records your AWS resource configurations and allows you to automate the evaluation of recorded configurations against desired baselines, primarily for auditing and compliance, not for detecting malicious activity and threats. Option B (correct) Amazon GuardDuty is a threat detection service that continuously monitors for malicious activity and unauthorized behavior to protect your AWS accounts and workloads. Option C (incorrect) AWS CloudFormation is an infrastructure as code service used for provisioning and managing AWS resources, not for detecting security threats or malicious activity. Option D (incorrect) Amazon Inspector is an automated security assessment service that helps improve the security and compliance of applications deployed on AWS by assessing EC2 instances and container images for vulnerabilities, but it does not continuously monitor for malicious activity across the entire AWS account like GuardDuty.'
WHERE question_id = '151cd87f-7648-428c-91a2-77ef23691371';

-- question_id: 15465f19-1bc9-4bd7-90f8-bfcceb7c53e0
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Standard is designed for frequently accessed data and requires S3 Lifecycle policies to explicitly transition data to other storage classes, rather than automatically moving data itself. Option B (incorrect) S3 Standard-IA (Infrequent Access) is a specific storage class for infrequently accessed data that needs rapid access, and like S3 Standard, it does not automatically move data between tiers without a lifecycle policy. Option C (correct) S3 Intelligent-Tiering automatically moves data between two access tiers (frequent and infrequent access) based on changing access patterns to optimize storage costs without performance impact. Option D (incorrect) S3 Glacier is an archive storage class for long-term data archiving and requires explicit retrieval requests; it does not automatically move data between access tiers based on access patterns.'
WHERE question_id = '15465f19-1bc9-4bd7-90f8-bfcceb7c53e0';

-- question_id: 16d4ed8a-6b5b-4b33-a640-ca9d1b519ecf
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Kinesis Data Streams On-demand mode automatically adjusts capacity to match actual throughput, eliminating the need to provision and pay for peak capacity during low-traffic periods. Option B (incorrect) While technically possible to reduce shard count via resharding, it introduces operational complexity, requires manual or scheduled intervention, and carries potential risks of data loss or service disruption, making On-demand mode a superior and simpler solution. Option C (incorrect) Configuring producer throttling only reduces the amount of data sent, but it does not reduce the cost of the continuously provisioned shards in Kinesis Data Streams, which is the root cause of the overspending. Option D (incorrect) Migrating to Kinesis Data Firehose would involve a significant architectural change, as Firehose is primarily designed for data delivery to specific destinations and not as a direct replacement for Kinesis Data Streams when custom application consumers are required.'
WHERE question_id = '16d4ed8a-6b5b-4b33-a640-ca9d1b519ecf';

-- question_id: 1707514f-43ef-44fa-a6a1-02a3bac20cf3
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon RDS is a relational database service that, while capable of low latency, does not consistently guarantee single-digit millisecond performance at scale across all workloads like DynamoDB. Option B (correct) Amazon DynamoDB is a fully managed NoSQL key-value and document database service specifically designed to deliver consistent single-digit millisecond performance at any scale, making it ideal for such stringent latency requirements. Option C (incorrect) Amazon Redshift is a data warehousing service optimized for analytical queries over large datasets, not for transactional applications requiring real-time, low-latency reads and writes. Option D (incorrect) Amazon DocumentDB is a document database compatible with MongoDB, offering millisecond latency for document workloads, but it doesn''t offer the same consistent single-digit millisecond performance guarantees as DynamoDB for high-throughput, low-latency operational use cases.'
WHERE question_id = '1707514f-43ef-44fa-a6a1-02a3bac20cf3';

-- question_id: 17d738c9-7057-4ebd-8440-100db596ea10
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using the root account for everything is a critical security anti-pattern because the AWS root user has unrestricted access to all resources and services, making it a high-risk target and violating the best practice of not using the root user for daily operational tasks or automated workloads. Option B (correct) Applying the principle of least privilege is a fundamental security best practice for AI workloads, ensuring that IAM users, roles, and services like Amazon SageMaker or EC2 instances only have the minimum permissions necessary to perform their specific functions, thereby reducing the potential blast radius in case of a security compromise. Option C (incorrect) Sharing credentials among team members is a severe security vulnerability as it compromises individual accountability, makes auditing actions impossible, and goes against best practices that require each individual or service to have unique credentials or roles. Option D (incorrect) Never using IAM roles is incorrect because IAM roles are the recommended and most secure way to grant temporary permissions to AWS services (like Amazon SageMaker for model training) and federated users, eliminating the need for long-term access keys and enhancing security posture.'
WHERE question_id = '17d738c9-7057-4ebd-8440-100db596ea10';

-- question_id: 17ed00e3-b2c9-40ea-803f-97f37987a997
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) The AWS Well-Architected Framework for ML provides comprehensive best practices and prescriptive guidance across its six pillars—Operational Excellence, Security, Reliability, Performance Efficiency, Cost Optimization, and Sustainability—tailored specifically for designing, deploying, and operating robust, high-performing, and cost-effective machine learning workloads on AWS, encompassing services like Amazon SageMaker, S3, and Glue. Option B (incorrect) The framework is not limited to storage; while storage solutions like Amazon S3 and EBS are critical components for ML data, the Well-Architected Framework for ML addresses the entire ML lifecycle including data preparation, model training, inference, and MLOps, far beyond just data persistence. Option C (incorrect) The framework is not solely for networking; while secure and efficient networking configurations using services like Amazon VPC and AWS PrivateLink are essential for ML workloads, the Well-Architected Framework for ML extends to all aspects of ML system design and operation, including data governance, model quality, and resource optimization. Option D (incorrect) The AWS Well-Architected Framework is absolutely applicable to ML workloads; AWS provides a dedicated "Machine Learning Lens" which integrates ML-specific considerations and best practices into the core framework, guiding customers on building well-architected ML solutions.'
WHERE question_id = '17ed00e3-b2c9-40ea-803f-97f37987a997';

-- question_id: 1876641d-f671-4840-a5da-b17fa1b83745
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CodeDeploy automates the deployment of application code to various compute services like EC2, Lambda, or ECS, rather than defining and provisioning infrastructure as code. Option B (correct) AWS CloudFormation allows users to define, provision, and update AWS infrastructure resources as code through templates, which are then used to create and manage stacks. Option C (incorrect) AWS AppConfig is a service for managing and deploying application configurations, separating them from application code, and does not provision or manage infrastructure. Option D (incorrect) AWS Elastic Beanstalk is a Platform as a Service (PaaS) that automates the deployment and scaling of web applications, provisioning underlying infrastructure implicitly, but it is not a general-purpose infrastructure as code tool for defining arbitrary infrastructure stacks.'
WHERE question_id = '1876641d-f671-4840-a5da-b17fa1b83745';

-- question_id: 18771a25-8220-4a35-9bac-264b9022b3b8
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Optimizing individual Glue jobs to use fewer DPUs is a best practice for cost and efficiency but does not directly increase the account-level DPU service quota that has already been reached. Option 1 (correct) Requesting AWS Support to increase Glue DPU service quota limits directly addresses the root cause of reaching the service quota, allowing more concurrent DPU usage for critical jobs that cannot be serialized. Option 2 (incorrect) Implementing job queuing to serialize execution contradicts the problem statement that critical jobs cannot be serialized during peak periods. Option 3 (incorrect) Migrating some Glue jobs to Amazon EMR, while reducing Glue DPU usage, is a significant re-platforming effort and not the most direct action to resolve an existing Glue DPU service quota issue, especially when a quota increase request is typically the first step for soft limits.'
WHERE question_id = '18771a25-8220-4a35-9bac-264b9022b3b8';

-- question_id: 19a25196-0e46-4281-8105-ab1e8fc550b4
-- answer_correct: True | verified_indices: [0, 1, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Data encryption is a fundamental technical safeguard mandated by HIPAA to protect Protected Health Information (PHI) both at rest using services like AWS Key Management Service (KMS) with S3, EBS, and RDS, and in transit using TLS/SSL with services like ELB and API Gateway. Option B (correct) Audit logging is a critical administrative and technical safeguard required by HIPAA to track all access and changes to PHI, which can be achieved through AWS CloudTrail for API activity, S3 server access logs, and Amazon CloudWatch Logs for application-level events. Option C (correct) Access controls are essential administrative and technical safeguards under HIPAA to limit access to PHI only to authorized personnel and systems on a need-to-know basis, implemented using AWS Identity and Access Management (IAM) policies, security groups, network ACLs, and S3 bucket policies. Option D (incorrect) Public data sharing of PHI would be a severe HIPAA violation as it contradicts the core principle of protecting patient privacy and preventing unauthorized disclosure, unless the data is fully de-identified according to strict HIPAA standards, which is not implied here. Option E (incorrect) Unrestricted API access to a system handling PHI would violate HIPAA''s requirements for strong access controls and the principle of least privilege, making the system vulnerable to unauthorized access and data breaches, contrary to using services like AWS API Gateway with strong authorizers. Option F (incorrect) While data anonymization (de-identification) can allow data to be used outside the direct scope of HIPAA for certain purposes, it is not a direct HIPAA compliance *implementation* for securing PHI within a system; HIPAA mandates safeguards for PHI itself, and the primary technical controls for ensuring compliance for a system handling PHI are encryption, audit logging, and access controls, not the removal of identifying information within the compliant system itself.'
WHERE question_id = '19a25196-0e46-4281-8105-ab1e8fc550b4';

-- question_id: 19cc3095-6318-4879-bb16-12abaa4c5752
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Load balancing is primarily handled by AWS Elastic Load Balancing (ELB) services like Application Load Balancer (ALB) or Network Load Balancer (NLB), which distribute incoming traffic, whereas Route 53 primarily directs traffic via DNS records. Option B (correct) Amazon Route 53 is a highly available and scalable cloud Domain Name System (DNS) web service that also allows for domain name registration and management. Option C (incorrect) Content delivery is primarily handled by Amazon CloudFront, which is a global content delivery network (CDN) service designed to cache and distribute content efficiently. Option D (incorrect) Database hosting is primarily handled by dedicated AWS database services such as Amazon RDS, Amazon DynamoDB, or Amazon Aurora, which provide managed database solutions.'
WHERE question_id = '19cc3095-6318-4879-bb16-12abaa4c5752';

-- question_id: 1a48c44d-8406-43ee-8064-b2ff650c63b9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon RDS supports cross-region read replicas, but generally requires manual promotion to make a replica the new primary after a regional failure, and does not provide automatic, active multi-region write replication across all its supported database engines. Option B (correct) Amazon DynamoDB Global Tables provide fully managed, multi-master, multi-region replication, automatically propagating writes across all designated replica tables in different AWS regions with low latency. Option C (incorrect) Amazon Redshift is an analytical data warehouse service that does not offer automatic multi-region replication; cross-region data redundancy typically involves manual snapshot copies. Option D (incorrect) Amazon ElastiCache is an in-memory caching service that supports high availability within a single region (Multi-AZ) but does not provide automatic multi-region replication for its clusters.'
WHERE question_id = '1a48c44d-8406-43ee-8064-b2ff650c63b9';

-- question_id: 1a611b7f-cc41-4f14-b812-a99265f1deb9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Economies of scale describe the cost advantages achieved by large-scale operations like AWS, which allow them to offer lower prices due to purchasing power and operational efficiency, but it is not the direct concept of trading capital for operational expenses. Option B (correct) Pay-as-you-go pricing is the core AWS billing model where customers only pay for the resources they actually consume, effectively transforming traditional upfront hardware purchases (CAPEX) into flexible, usage-based operational expenses (OPEX). Option C (incorrect) Reserved capacity, such as EC2 Reserved Instances or Savings Plans, involves a commitment to a certain usage level over time in exchange for discounts, which can involve partial or full upfront payments, thus reintroducing an element of upfront commitment rather than solely enabling a pure variable operational expense model. Option D (incorrect) Dedicated hosting, like EC2 Dedicated Hosts, provides physical server isolation for specific licensing or compliance requirements, but it often entails higher and more predictable operational costs compared to shared infrastructure and does not represent the fundamental concept of trading general upfront capital for variable operational expenses.'
WHERE question_id = '1a611b7f-cc41-4f14-b812-a99265f1deb9';

-- question_id: 1a7c9834-04a4-42d1-8742-17680853c0d0
-- answer_correct: True | verified_indices: [0] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Enabling Athena query result caching directly addresses identical queries by reusing previously computed results for up to 24 hours, eliminating data scans for the 35% of identical dashboard refreshes. Option B (incorrect) Materialized views require explicit creation and management for specific query patterns and while they can reduce costs, they are a more complex solution than automatic query result caching for simply identical queries. Option C (incorrect) Athena workgroups with data scan limits are a cost control mechanism that prevents queries from exceeding a budget by failing them, rather than reducing the data scanned by successful and required queries. Option D (incorrect) Migrating dashboard queries to QuickSight with SPICE caching would indeed offload Athena costs for those queries but involves adopting a new service and migration effort, whereas Athena''s native caching is a direct, in-service cost reduction.'
WHERE question_id = '1a7c9834-04a4-42d1-8742-17680853c0d0';

-- question_id: 1a957c80-eefc-4e61-bbda-de4b54c17798
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increasing the number of core nodes distributes the workload across more instances, but it does not address the fundamental bottleneck of high disk I/O wait times on the individual nodes themselves if their instance type''s I/O capability is the limiting factor. Option B (correct) Changing EMR instance types to storage-optimized instances (e.g., I3, D2, D3 family instances) provides higher I/O throughput, often through faster local NVMe SSDs or optimized EBS performance, directly alleviating the high disk I/O wait times. Option C (incorrect) Optimizing Spark job configuration for memory usage and reducing shuffle operations can decrease the *amount* of disk I/O required, but it does not directly resolve the identified issue of the *slow throughput capacity* of the existing disk subsystem. Option D (incorrect) Enabling EMRFS consistent view for S3 provides consistency guarantees for S3 objects accessed via EMR, but it does not inherently make S3 reads faster and can even introduce slight latency due to the DynamoDB consistency checks.'
WHERE question_id = '1a957c80-eefc-4e61-bbda-de4b54c17798';

-- question_id: 1af3f2cb-d251-4868-b1d1-56002f1b5265
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Disabling all MFA for the root user significantly weakens the security posture and contradicts AWS security best practices, which strongly recommend MFA for the root user to provide an additional layer of authentication. Option B (incorrect) Using a simple, easily memorable password makes the root account highly susceptible to brute-force or dictionary attacks, directly violating AWS IAM password policy best practices for strong, complex passwords. Option C (correct) Enabling MFA provides a critical additional layer of security beyond just a password, making it significantly harder for unauthorized users to gain access even if the password is compromised, and securely storing credentials is a fundamental AWS security practice to prevent unauthorized access. Option D (incorrect) Sharing root credentials among multiple team members creates an enormous security risk by making accountability impossible, increasing the attack surface, and directly contradicting the AWS IAM best practice of using individual IAM users with least privilege.'
WHERE question_id = '1af3f2cb-d251-4868-b1d1-56002f1b5265';

-- question_id: 1af6ef73-9ede-4519-a6e5-1f1df3683c50
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Organizations consolidates billing, meaning it moves away from strictly individual account billing towards a unified bill, although detailed usage per account is still available. Option B (correct) AWS Organizations enables consolidated billing across all member accounts, allowing them to benefit from volume discounts, Reserved Instances, and Savings Plans aggregated at the payer account level. Option C (incorrect) AWS Organizations typically helps reduce costs through consolidated billing by aggregating usage for better pricing tiers and sharing benefits like Reserved Instances, rather than leading to higher costs. Option D (incorrect) With consolidated billing provided by AWS Organizations, the payer account receives a single, unified invoice for all member accounts, not separate invoices.'
WHERE question_id = '1af6ef73-9ede-4519-a6e5-1f1df3683c50';

-- question_id: 1b1f5967-1c8c-4a22-896a-da565c896444
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Prompt engineering is preferred when quick results are needed, as it involves crafting inputs for existing models via services like Amazon Bedrock without the time-consuming process of data collection, training, and deployment inherent in fine-tuning. Option B (correct) Fine-tuning is preferred when the model needs to learn domain-specific patterns, allowing it to internalize niche terminology, specific factual knowledge, and specialized reasoning through further training on custom datasets, often leveraging services like Amazon SageMaker or the fine-tuning capabilities within Amazon Bedrock for models like Amazon Titan. Option C (incorrect) Prompt engineering is preferred when working with limited resources because it primarily requires human intellect to craft prompts and utilizes existing model inference endpoints, incurring significantly less computational cost and time compared to the extensive data preparation, GPU-intensive training, and deployment required for fine-tuning. Option D (incorrect) Prompt engineering is preferred when the task is simple, as many straightforward tasks can be effectively and efficiently accomplished by crafting clear instructions and examples in a prompt for a pre-trained model accessible through Amazon Bedrock, without the overhead of fine-tuning.'
WHERE question_id = '1b1f5967-1c8c-4a22-896a-da565c896444';

-- question_id: 1c0316bf-868e-4d15-a3d3-842e5bb244ee
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config assesses, audits, and evaluates the configurations of your AWS resources for compliance and security, but its primary function is not to provide explicit cost optimization recommendations. Option B (incorrect) AWS CloudFormation is an Infrastructure as Code service used for modeling and provisioning AWS resources consistently, not for analyzing existing spending or offering cost-saving advice. Option C (correct) AWS Trusted Advisor provides real-time guidance and recommendations across multiple pillars, including cost optimization, by identifying idle resources, underutilized services, and potential savings. Option D (incorrect) AWS Systems Manager helps you gain operational insights and automate tasks on your AWS resources, but it does not directly provide cost optimization recommendations in the way Trusted Advisor does.'
WHERE question_id = '1c0316bf-868e-4d15-a3d3-842e5bb244ee';

-- question_id: 1cba0b1f-ea24-49bf-b979-2746d03b3aba
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Contrastive explanation in AI specifically focuses on highlighting the crucial differences in features or decision paths that led to one particular prediction rather than an alternative, which is essential for understanding model behavior using tools like Amazon SageMaker Clarify for explainability. Option B (incorrect) Contrastive explanation inherently involves a comparison between outcomes, making it more complex than a mere single explanation for one specific outcome without comparison, as would be generated by some simple local explanation methods. Option C (incorrect) The term "contrastive" by definition requires a comparison between actual and counterfactual scenarios to explain why a model, such as one built with Amazon SageMaker, arrived at a specific decision over another. Option D (incorrect) Explanation methods in AI, including contrastive explanations, are systematic and deterministic processes based on model logic and data, not random selection, which would provide inconsistent and unhelpful insights into an AI service''s behavior like Amazon Personalize recommendations.'
WHERE question_id = '1cba0b1f-ea24-49bf-b979-2746d03b3aba';

-- question_id: 1cc933a0-fe21-47d5-92c1-cbf5e41ba6d6
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Homomorphic encryption is specifically designed to allow mathematical operations and computations to be performed directly on data while it remains in an encrypted state, maintaining privacy during ML model training or inference without revealing the raw data, which is a significant advancement beyond standard AWS encryption services like KMS that require decryption before computation. Option B (incorrect) Regular encryption, such as that provided by AWS Key Management Service (KMS) or S3 server-side encryption, protects data at rest and in transit but necessitates decryption of the data before any computations or ML processing can be performed on it. Option C (incorrect) No encryption is contrary to fundamental AWS security best practices, which strongly advocate for encryption of sensitive data at rest using services like S3 or EBS with KMS, and in transit using TLS/SSL across all network communication. Option D (incorrect) Data compression is a technique used to reduce the size of data for storage or transmission efficiency, a feature supported by AWS services like S3 for storing compressed files, but it does not provide any cryptographic protection or enable computations on encrypted data.'
WHERE question_id = '1cc933a0-fe21-47d5-92c1-cbf5e41ba6d6';

-- question_id: 1ce27164-4cf9-42ea-9f6c-2ad5628ddfab
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increasing the provisioned IOPS of the primary database addresses disk I/O bottlenecks, but it does not offload the computational load or query processing from the primary database instance itself, which is essential for a read-heavy workload that frequently accesses the same data. Option B (correct) Implementing a caching layer, such as Amazon ElastiCache (Redis or Memcached), stores frequently accessed data in memory, significantly reducing the number of read requests that reach the primary database, thereby lowering latency and load on the database for read-heavy workloads. Option C (incorrect) Migrating the entire database to a data warehouse solution like Amazon Redshift is unsuitable because Redshift is optimized for analytical (OLAP) workloads over large datasets, not for transactional (OLTP) read-heavy operational workloads frequently accessing the same data, which would be a misuse of the service. Option D (incorrect) Creating a single read replica for the database is designed to offload read operations from the primary database, not write operations; the primary database always handles write operations in a read replica setup like Amazon RDS.'
WHERE question_id = '1ce27164-4cf9-42ea-9f6c-2ad5628ddfab';

-- question_id: 1db1bb25-78e4-41e0-9418-eaee2f4ed761
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Fine-tuning embeds knowledge into model weights and does not inherently provide real-time information, which is better handled by RAG that retrieves current data from external knowledge bases like Amazon OpenSearch Service at inference time. Option B (correct) Fine-tuning allows you to update a model''s weights with custom data, directly enabling it to adopt a specific style, tone, or deep domain expertise, such as making an Amazon Bedrock foundation model specialized for legal text generation. Option C (incorrect) Fine-tuning typically increases costs due to the need for large labeled datasets, extensive GPU compute for training (e.g., on Amazon SageMaker), and potentially higher inference costs for the specialized model, whereas RAG leverages existing foundation models and external knowledge bases. Option D (incorrect) Fine-tuning fundamentally requires a substantial amount of high-quality, task-specific training data to update the model''s parameters and learn new patterns, making it impossible to perform without such data.'
WHERE question_id = '1db1bb25-78e4-41e0-9418-eaee2f4ed761';

-- question_id: 1de540db-2d6a-4e07-b9df-9a809f6f1185
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Stopping an EC2 instance is distinct from terminating it, as termination permanently deletes the instance and its associated root EBS volume (unless explicitly configured otherwise), whereas stopping retains these resources. Option B (correct) When an EC2 instance is stopped, it transitions to a `stopped` state, where its Amazon Elastic Block Store (EBS) volumes remain attached and persistent, allowing the instance to be restarted later with all its data intact. Option C (incorrect) Instance data stored on persistent Amazon Elastic Block Store (EBS) volumes is preserved when an EC2 instance is stopped; only data on ephemeral instance store volumes is lost. Option D (incorrect) Stopping an EC2 instance does not relocate it; the instance remains logically situated within its original Availability Zone, and upon restart, it will launch within that same AZ.'
WHERE question_id = '1de540db-2d6a-4e07-b9df-9a809f6f1185';

-- question_id: 1ecf95ae-7eb9-4787-a266-33b32c02dbc9
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Amazon S3 is object storage primarily designed for durable, scalable storage of large files and objects, not for low-latency, sub-millisecond key-value access typical of user session data, and its API latency does not meet the sub-millisecond requirement. Option B (correct) Amazon ElastiCache for Redis is an in-memory data store specifically designed to provide sub-millisecond latency for read/write operations and offers high availability through replication and clustering, perfectly meeting the requirements for fast, scalable, and resilient session storage. Option C (incorrect) Storing session data directly on Amazon EBS volumes attached to individual application servers makes sessions local to a specific server, which means sessions would be lost if the server fails and prevents session sharing or failover across multiple application instances. Option D (incorrect) Amazon DynamoDB is a highly scalable and available NoSQL database that offers single-digit millisecond latency, which is excellent, but it typically does not consistently achieve the sub-millisecond latency requirement that an in-memory cache like ElastiCache for Redis can provide.'
WHERE question_id = '1ecf95ae-7eb9-4787-a266-33b32c02dbc9';

-- question_id: 1f01fe63-8c18-43de-8306-68399cc53b73
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Elastic weight consolidation (EWC) is a technique that prevents catastrophic forgetting by regularizing the learning process for new tasks, ensuring that weights important for previously learned tasks are not drastically altered, which is crucial for models deployed on Amazon SageMaker that need to adapt continually without retraining from scratch. Option B (incorrect) Forgetting everything is the definition of catastrophic forgetting itself, not a prevention mechanism, which would be an undesirable outcome for any machine learning model deployed or updated using AWS services like Amazon SageMaker. Option C (incorrect) No memory would mean the model cannot learn or retain any information, making continual learning impossible and rendering the concept of catastrophic forgetting moot, which contradicts the fundamental operation of models trained on AWS compute resources. Option D (incorrect) Random updates would destabilize a model and prevent it from learning any task effectively, let alone preventing catastrophic forgetting, as AWS SageMaker training jobs rely on systematic, gradient-based optimization for learning.'
WHERE question_id = '1f01fe63-8c18-43de-8306-68399cc53b73';

-- question_id: 1f1f3612-6135-4487-9802-601d23f1bab9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Kinesis Data Analytics with pattern recognition is primarily for real-time aggregation and anomaly detection within defined windows, and does not inherently provide a scalable, stateful mechanism for deduplicating across an arbitrary sliding window of records based on composite keys without external state management. Option B (correct) Storing record hashes in DynamoDB with a Time-To-Live (TTL) attribute provides a highly scalable, serverless, and cost-effective solution for sliding window deduplication, as it efficiently stores and expires seen keys, enabling atomic check-and-insert operations. Option C (incorrect) AWS Glue jobs with Delta Lake are typically used for batch or micro-batch processing and managing data lake tables, and while Delta Lake supports deduplication via merge operations, it is not the most efficient real-time method for preventing duplicates from continuous streams before they land. Option D (incorrect) While Lambda with ElastiCache Redis can perform in-memory deduplication using SETNX and EXPIRE, it introduces more operational overhead, requires managing cluster capacity and durability, and is generally less cost-effective and fully managed than DynamoDB for this specific high-volume, stateful deduplication task.'
WHERE question_id = '1f1f3612-6135-4487-9802-601d23f1bab9';

-- question_id: 1f66b7a7-8449-4759-aed1-f969e3a15187
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Predicting customer churn probability is a classic supervised machine learning classification problem, where models built with Amazon SageMaker can learn patterns from historical data to predict future customer behavior. Option B (correct) Calculating exact tax amounts based on fixed rules is a deterministic, rule-based process best handled by traditional programming logic and database lookups rather than probabilistic AI/ML models which are not designed for precise, auditable calculations. Option C (incorrect) Detecting fraudulent transactions is an excellent application for AI/ML, particularly anomaly detection or classification models, where Amazon Fraud Detector or Amazon SageMaker can identify complex patterns indicative of illicit activity. Option D (incorrect) Recommending products to customers is a core use case for AI/ML, efficiently handled by services like Amazon Personalize which leverage machine learning algorithms to provide relevant suggestions based on user behavior and item attributes.'
WHERE question_id = '1f66b7a7-8449-4759-aed1-f969e3a15187';

-- question_id: 1faac2b3-c124-4998-989c-81263be9d094
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) EMR clusters with Spark, while capable of unified batch and stream processing and ML, typically involve provisioning and managing clusters which may not be the most cost-optimized approach for diverse workload types compared to serverless alternatives.Option 1 (incorrect) Separate Kinesis and Batch processing with S3 data lake integration describes an ingestion and storage pattern but doesn''t provide a unified analytics platform for diverse workloads, nor does it specify services for cost-optimized ML or unified querying.Option 2 (correct) Glue for ETL (batch and streaming), Athena for serverless querying over the data lake, and SageMaker for managed ML workflows provide a comprehensive, serverless, and cost-optimized unified analytics architecture.Option 3 (incorrect) Lambda for stream processing and Redshift for batch analytics is less ideal as Lambda is typically for lightweight stream processing, and Redshift, a data warehouse, is a provisioned service that might not be the most flexible or cost-optimized for all data lake queries and ML aspects compared to serverless options.'
WHERE question_id = '1faac2b3-c124-4998-989c-81263be9d094';

-- question_id: 202f2acd-c5e9-40cb-9baa-ac0bdf2718d8
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) AWS CodeCommit is a managed source control service specifically designed for storing application code securely and versioning changes. Option 1 (incorrect) AWS Key Management Service (KMS) is the dedicated AWS service for creating, storing, and managing cryptographic keys and their lifecycle. Option 2 (correct) AWS Secrets Manager is purpose-built to securely store, audit, and automatically rotate various types of secrets, including database credentials, API keys, and other sensitive information, preventing hardcoding and improving security posture. Option 3 (incorrect) AWS CloudTrail logs API calls and related events for auditing, Amazon GuardDuty provides intelligent threat detection, and Amazon Security Hub offers a centralized view of security alerts and findings across AWS accounts.'
WHERE question_id = '202f2acd-c5e9-40cb-9baa-ac0bdf2718d8';

-- question_id: 20ee2c8a-c4cf-42fc-b056-5cf6d853be3e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Retrieval Augmented Generation (RAG) is designed to improve the quality and accuracy of model responses by providing external context, not to intentionally slow down model inference, although adding a retrieval step can introduce some latency. Option 1 (correct) RAG is indeed a technique that combines retrieving relevant information from a knowledge base, often stored in AWS services like Amazon OpenSearch Service or Amazon Aurora, and then feeding this information as context to a large language model (LLM) for more accurate and grounded generation via services like Amazon Bedrock. Option 2 (incorrect) RAG is not a method to delete model data; instead, it augments the model''s knowledge with external, up-to-date information without altering the foundational model''s weights or internal data. Option 3 (incorrect) RAG is an architectural pattern for enhancing LLM responses by providing external knowledge to the prompt, not a compression algorithm used for reducing data size or optimizing storage, which is handled by different techniques and services within AWS.'
WHERE question_id = '20ee2c8a-c4cf-42fc-b056-5cf6d853be3e';

-- question_id: 218c1c47-b958-403e-a6fd-c7526bbd71bf
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EC2 Launch Templates define parameters for launching EC2 instances, including which AMI to use, but they do not automate the creation or hardening of the AMI itself. Option B (correct) AWS Image Builder is specifically designed to automate the creation, patching, testing, hardening, and distribution of secure and customized AMIs. Option C (incorrect) There is no AWS service named "AWS AMI Lifecycle Manager"; while Image Builder manages the lifecycle of AMIs, this specific service name does not exist. Option D (incorrect) AWS Systems Manager Parameter Store is used for storing configuration data and secrets, including AMI IDs, but it does not automate the process of creating or hardening AMIs.'
WHERE question_id = '218c1c47-b958-403e-a6fd-c7526bbd71bf';

-- question_id: 21b0d483-982d-4a90-85b4-233b3f3176db
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EBS provides block storage to EC2 instances, not object storage like Amazon S3, and EFS provides shared file storage, not block storage. Option B (correct) Amazon EBS provides persistent block-level storage volumes for use with EC2 instances, while Amazon EFS provides scalable and elastic shared file storage accessible by multiple EC2 instances via NFS. Option C (incorrect) While EFS offers shared file storage, EBS provides block storage volumes that require a file system to be formatted and mounted by a single EC2 instance before files can be stored. Option D (incorrect) EBS provides block storage to EC2 instances, but EFS provides shared file storage accessible by multiple instances using standard file protocols like NFS, not block storage.'
WHERE question_id = '21b0d483-982d-4a90-85b4-233b3f3176db';

-- question_id: 226cddb5-042a-4c62-a733-f94d97dfeb32
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Secure enclaves, such as those provided by AWS Nitro Enclaves, offer hardware-protected computation environments that isolate sensitive data and code from the operating system, other users, and even administrators on the host instance, making them ideal for confidential machine learning workloads. Option B (incorrect) Regular computing refers to standard virtual machines or instances where the data in use is processed without the specific hardware-enforced isolation and cryptographic guarantees against the host environment that secure enclaves provide. Option C (incorrect) Secure enclaves are fundamentally designed to provide significant protection for sensitive data during processing, creating a trusted execution environment that enhances security far beyond having no protection. Option D (incorrect) Public processing implies that data is openly accessible or processed in an untrusted environment, which is directly contrary to the purpose of secure enclaves, which are built to enable highly private and confidential computing for sensitive data and models.'
WHERE question_id = '226cddb5-042a-4c62-a733-f94d97dfeb32';

-- question_id: 23351871-c9b0-42c9-abe7-638efabb5bb7
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using a single model is typically referred to as an individual model approach, which, while simpler to deploy on Amazon SageMaker Endpoints, does not leverage the combined intelligence of multiple models to potentially improve robustness or accuracy. Option B (correct) Ensemble learning is a powerful machine learning paradigm that combines the predictions from multiple base models, often trained with different algorithms or subsets of data, to achieve superior predictive performance compared to any single model, with techniques like XGBoost and Random Forest being popular implementations available on Amazon SageMaker. Option C (incorrect) Ensemble learning actually involves *increasing* the model count by bringing multiple models together, rather than reducing it, which contrasts with strategies focused on minimizing the number of models for deployment or management on AWS infrastructure. Option D (incorrect) While individual models within an ensemble are often trained separately, for example using distinct Amazon SageMaker Training Jobs, the defining characteristic of ensemble learning is the subsequent aggregation and combination of their predictions, not merely the isolated training of multiple models.'
WHERE question_id = '23351871-c9b0-42c9-abe7-638efabb5bb7';

-- question_id: 23d26a47-1eda-4da3-8432-0f67a8dc48fe
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon SageMaker Model Monitor continuously compares the statistical properties and distributions of incoming production data to a previously established baseline, using methods like statistical distance metrics (e.g., Earth Mover''s Distance) or statistical tests to detect significant changes in feature distributions. Option B (incorrect) Relying solely on manual inspection is impractical and inefficient for continuous monitoring of high-volume production data streams, as it cannot scale to detect subtle or gradual data drift and is prone to human error. Option C (incorrect) Never checking for data drift is a critical operational failure, as undetected drift will inevitably lead to degraded model performance, inaccurate predictions, and unreliable machine learning systems in production. Option D (incorrect) Annual review is insufficient for detecting data drift, which can occur much more frequently and subtly, necessitating continuous or regular automated monitoring to ensure timely detection and mitigation of performance degradation.'
WHERE question_id = '23d26a47-1eda-4da3-8432-0f67a8dc48fe';

-- question_id: 23db92f1-01c5-456d-82aa-654461fd8814
-- answer_correct: True | verified_indices: [1, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) GDPR is a data privacy regulation that sets rules for processing personal data of EU residents, which financial institutions must comply with if applicable, but it is not a compliance program demonstrating security controls specifically for financial institutions in the way a security framework is. Option B (correct) SOC 2 reports demonstrate that AWS has internal controls related to security, availability, processing integrity, confidentiality, and privacy, which are critical assurances for financial institutions leveraging AWS infrastructure. Option C (correct) PCI DSS is a global security standard for organizations that handle branded credit cards from the major card schemes, and AWS maintains PCI DSS compliance for its services, allowing financial institutions to build compliant cardholder data environments. Option D (incorrect) HIPAA is a U.S. law designed to protect sensitive patient health information, and while AWS provides services and a BAA to help healthcare organizations achieve compliance, it is not a compliance program focused on general security controls for financial institutions.'
WHERE question_id = '23db92f1-01c5-456d-82aa-654461fd8814';

-- question_id: 23f29c12-be17-470c-b026-2f57c43d011d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Rolling update deployments gradually replace old tasks with new ones, which can lead to a mixed version state and does not provide an instant rollback to the previous stable version across the entire service if issues are detected. Option B (correct) Blue/green deployments, typically implemented with AWS CodeDeploy for ECS and Application Load Balancer, launch the new application version completely separate from the old, allowing for thorough testing and instant traffic shifting back to the proven blue environment if any issues arise, ensuring zero downtime and instant rollback. Option C (incorrect) Recreate deployments involve terminating all old tasks before starting new ones, which inherently causes service downtime and does not meet the zero-downtime requirement. Option D (incorrect) Canary deployments gradually route a small percentage of traffic to the new version for testing, but while good for progressive release, they do not offer the instantaneous, full rollback capability to the entire previous environment that blue/green provides by keeping the old environment fully operational.'
WHERE question_id = '23f29c12-be17-470c-b026-2f57c43d011d';

-- question_id: 243e2e6f-ded1-4a1a-a27f-1d4b482900f5
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Manual snapshots are full backups taken at a specific point in time but do not allow recovery to an arbitrary second between when snapshots were created, thus failing to meet a low RPO for fine-grained recovery. Option B (incorrect) Daily automated backups are essential for recovery, but as a standalone feature, they primarily refer to the full daily snapshot, which by itself does not allow restoring to a *specific second* but rather to the time of the snapshot. Option C (correct) Point-in-time recovery for RDS combines daily full snapshots with continuous transaction log backups (write-ahead logs) to enable restoring a database to any specific second within the backup retention period, typically up to the last five minutes, perfectly addressing the low RPO requirement for precise recovery. Option D (incorrect) Cross-Region replication is a disaster recovery strategy that provides high availability and durability by copying data to another AWS region, but it does not inherently offer the capability to restore an instance to a specific second in time within the source region.'
WHERE question_id = '243e2e6f-ded1-4a1a-a27f-1d4b482900f5';

-- question_id: 24605842-9342-4a1c-ba1d-db608e3e3191
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) Cost Optimization focuses on avoiding unnecessary costs and maximizing business value, for example by using Reserved Instances or EC2 Spot Instances to reduce compute expenses, not primarily on environmental impact. Option B (incorrect) Performance Efficiency focuses on using computing resources efficiently to meet system requirements and maintain that efficiency as demand changes, such as by using Auto Scaling to dynamically adjust capacity or leveraging Amazon ElastiCache for low-latency data access. Option C (correct) Sustainability emphasizes reducing environmental impact by optimizing resource consumption, utilizing managed services, and selecting regions powered by renewable energy, directly aligning with efficient resource usage for environmental benefits. Option D (incorrect) Operational Excellence focuses on running and monitoring systems to deliver business value and continuously improving processes and procedures, such as by using AWS CloudWatch for monitoring and AWS Systems Manager for operational automation.'
WHERE question_id = '24605842-9342-4a1c-ba1d-db608e3e3191';

-- question_id: 24db01d1-81fd-4908-bb5d-7e96da45fd1d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) A single Availability Zone does not meet the AWS definition of a Region, which is designed to provide high availability and fault tolerance across physically separate data centers. Option B (correct) AWS defines a Region as a geographic area with two or more isolated locations called Availability Zones, enabling resilient and highly available architectures by distributing resources. Option C (incorrect) While many AWS Regions have three or more Availability Zones and three is often recommended for services requiring quorum or multi-AZ deployments, it is not the minimum required number for a Region. Option D (incorrect) Four Availability Zones are common in larger and more established AWS Regions, but this number far exceeds the minimum requirement for an AWS Region''s design.'
WHERE question_id = '24db01d1-81fd-4908-bb5d-7e96da45fd1d';

-- question_id: 25e8aba6-968f-4aea-93e3-d5f38bb7ccfe
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Utilizing Amazon EC2 Spot Instances are best suited for fault-tolerant, flexible, or stateless workloads that can withstand interruptions, rather than predictable, long-running critical workloads that require continuous availability. Option B (correct) Implementing Savings Plans or Reserved Instances provides significant discounts (up to 72%) in exchange for a 1-year or 3-year commitment, making them ideal for predictable, long-running EC2 workloads with stable resource requirements. Option C (incorrect) Right-sizing instances with AWS Compute Optimizer optimizes instance sizes by matching resources to actual usage, which reduces waste but does not offer the same deep discounts for long-term commitment as Savings Plans or RIs. Option D (incorrect) Moving data to Amazon S3 Glacier Deep Archive is a cost optimization strategy for long-term *data storage*, not for significantly reducing *EC2 compute costs*.'
WHERE question_id = '25e8aba6-968f-4aea-93e3-d5f38bb7ccfe';

-- question_id: 261a425d-a860-4358-8499-98e91ad98a61
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon Macie is a data security and data privacy service that uses machine learning and pattern matching to discover, classify, and protect sensitive data, such as Personally Identifiable Information (PII), in Amazon S3 buckets, which are frequently used to store AI datasets. Option B (incorrect) Amazon Polly is a text-to-speech service that turns text into lifelike speech, with no functionality related to identifying sensitive data in datasets. Option C (incorrect) Amazon Lex is a service for building conversational interfaces for applications using voice and text, and it does not provide capabilities for scanning or identifying sensitive data within datasets. Option D (incorrect) Amazon Transcribe is an automatic speech recognition (ASR) service that converts audio into text, and while it processes data that might contain sensitive information, its core purpose is transcription, not the identification or classification of sensitive data within AI datasets.'
WHERE question_id = '261a425d-a860-4358-8499-98e91ad98a61';

-- question_id: 275af2a8-28bd-47e6-ab7e-eb4181e67bc1
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Embeddings do not encrypt data; AWS services like Key Management Service (KMS) are used for data encryption to protect sensitive information. Option B (correct) Embeddings represent text, or other forms of data, as numerical vectors that capture semantic meaning, which is crucial for generative AI models like those accessible via Amazon Bedrock to understand and process information. Option C (incorrect) Embeddings are not used for image compression; services like Amazon S3 store images, and other tools or algorithms handle image compression. Option D (incorrect) The primary purpose of embeddings is not to increase model size, but to provide an efficient and semantically rich input representation for models to learn from, potentially making the model more effective rather than just larger.'
WHERE question_id = '275af2a8-28bd-47e6-ab7e-eb4181e67bc1';

-- question_id: 2787639e-6aa1-4549-903c-099a6e8778a3
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using AWS Glue auto-scaling and analyzing CloudWatch metrics for maximum DPU utilization is helpful for dynamic scaling during a job run but doesn''t provide the underlying diagnostic insight into resource bottlenecks (like memory pressure or I/O) necessary to determine the *optimal fixed DPU configuration* for cost minimization. Option B (incorrect) Running the job with different DPU configurations in a test environment is a brute-force trial-and-error method that can be time-consuming and costly, and it doesn''t diagnose the root cause of performance variability, leading to potentially suboptimal configurations. Option C (correct) Enabling AWS Glue job metrics and analyzing driver and executor memory utilization patterns is crucial because Spark job performance is often bottlenecked by memory; understanding memory utilization allows for precise tuning of executor memory, driver memory, or DPU count, which directly addresses the root causes of variability and leads to a truly optimal and cost-effective DPU configuration. Option D (incorrect) Starting with minimum DPUs and gradually increasing until job completion time meets requirements is a reactive approach that does not diagnose underlying performance issues like memory or I/O bottlenecks, potentially leading to over-provisioning and higher costs without truly optimizing the job.'
WHERE question_id = '2787639e-6aa1-4549-903c-099a6e8778a3';

-- question_id: 27aa8a89-8822-4372-a435-ec4c2112923f
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While Amazon SQS provides excellent decoupling and asynchronous processing for messages, acting as a buffer, it is primarily a queueing service and does not offer intrinsic event pattern matching or sophisticated routing for ''specific business events'' to initiate a multi-step workflow, nor does it orchestrate serverless workflows itself. Option B (incorrect) Amazon SNS is a pub/sub messaging service capable of broadcasting events to multiple subscribers like Lambda functions, offering decoupling and scalability, but it lacks the advanced event filtering capabilities of EventBridge and does not provide built-in orchestration for complex, multi-step serverless workflows. Option C (correct) Amazon EventBridge is ideal for capturing and filtering ''specific business events'' from various sources, including custom applications, and routing them based on event patterns; it then seamlessly triggers AWS Step Functions, which is a powerful serverless orchestrator designed to coordinate multi-step workflows involving AWS Lambda functions, fulfilling all requirements for scalability and loose coupling. Option D (incorrect) Using Amazon ECS tasks on AWS Fargate to poll an API Gateway endpoint for events is an inefficient and tightly coupled approach that contradicts event-driven best practices, as polling introduces latency and unnecessary resource consumption instead of reacting directly to pushed events, and it doesn''t natively provide serverless workflow orchestration.'
WHERE question_id = '27aa8a89-8822-4372-a435-ec4c2112923f';

-- question_id: 280f5749-9974-47c2-bea1-220892ba6787
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) VPN Gateway enables a site-to-site VPN connection over the public internet, which provides secure communication but is not a dedicated, private physical network connection. Option B (correct) AWS Direct Connect establishes a dedicated, private physical network connection between your on-premises data center and an AWS Direct Connect location, bypassing the public internet. Option C (incorrect) An Internet Gateway enables resources within a Virtual Private Cloud (VPC) to connect to the public internet and vice-versa, but it does not establish a dedicated connection from on-premises networks to AWS. Option D (incorrect) AWS PrivateLink enables private connectivity to specific AWS services or your own services hosted in AWS from your VPC without traversing the public internet, but it does not provide the underlying dedicated network connection from on-premises to your AWS environment.'
WHERE question_id = '280f5749-9974-47c2-bea1-220892ba6787';

-- question_id: 285e9da4-dfcf-46e7-bf74-9508f7386626
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Server color is a purely aesthetic characteristic of hardware and has absolutely no technical bearing on the performance, cost, or configuration of Large Language Models (LLMs) or any AWS service. Option B (correct) Setting input/output token length directly influences the cost of token-based billing for services like Amazon Bedrock and significantly impacts inference latency and resource utilization for models deployed on Amazon SageMaker, necessitating a balance between cost efficiency and desired performance. Option C (incorrect) While developer preference might play a minor role, it is overridden by fundamental technical and business constraints such as cost budgets, performance requirements, and the specific context window limitations of the chosen LLM on AWS. Option D (incorrect) The time of day does not technically influence the optimal input/output token length for an LLM; while demand might fluctuate, the inherent configuration and limitations related to token processing remain constant regardless of the hour.'
WHERE question_id = '285e9da4-dfcf-46e7-bf74-9508f7386626';

-- question_id: 28705cf8-7b56-4cd4-8532-a6e8fa2f4f26
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) This pillar focuses on running and monitoring systems, automating operations, and continually improving processes and procedures using services like Amazon CloudWatch for monitoring or AWS CloudFormation for infrastructure as code, which, while contributing to overall stability, is not primarily about recovering from disruptions. Option B (correct) This pillar specifically emphasizes the ability of a system to recover from infrastructure or service disruptions, dynamically acquire computing resources, and mitigate outages, employing strategies such as multi-AZ deployments, robust backup and restore using AWS Backup, or disaster recovery with services like Amazon Route 53 failover. Option C (incorrect) This pillar focuses on using computing resources efficiently to meet system requirements and maintain efficiency as demand changes, for example, selecting optimal EC2 instance types or utilizing Amazon ElastiCache for improved response times, rather than the system''s ability to recover from failures. Option D (incorrect) This pillar focuses on avoiding unnecessary costs by selecting appropriate resources, right-sizing services, and leveraging pricing models like EC2 Reserved Instances or S3 Intelligent-Tiering, rather than the intrinsic ability of the system to recover from disruptions.'
WHERE question_id = '28705cf8-7b56-4cd4-8532-a6e8fa2f4f26';

-- question_id: 28d46e5f-cae3-48b5-ad2c-1a7d4694427e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config is used for assessing, auditing, and evaluating the configurations of your AWS resources, tracking changes over time for compliance and governance, not for real-time operational monitoring of performance or health metrics. Option B (correct) Amazon CloudWatch is the primary monitoring and observability service that collects metrics, logs, and events from AWS resources and applications, enabling real-time insights, alarms, and dashboards to track performance and operational health. Option C (incorrect) AWS CloudTrail records API calls and user activity across AWS services, providing an audit trail for security analysis, change tracking, and troubleshooting, rather than real-time performance or operational health monitoring. Option D (incorrect) AWS Systems Manager is a suite of operational management tools for automating tasks, managing configurations, and gaining operational insights across AWS resources and on-premises servers, but it relies on services like CloudWatch for comprehensive real-time monitoring data.'
WHERE question_id = '28d46e5f-cae3-48b5-ad2c-1a7d4694427e';

-- question_id: 2935a5ee-ccbc-4b0d-b964-9e12ac4705f9
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deleting the IAM user would immediately stop access but is a drastic measure that also removes the user''s identity and history, potentially hindering forensic investigation and impacting other legitimate services if not managed carefully. Option B (incorrect) While CloudTrail Event History is essential for investigation, "rotating the key" involves creating a new key and deleting the old one, which is a multi-step process and might not immediately revoke access as quickly as deactivation, as the old key might remain active during the transition. Option C (correct) Deactivating the access key in IAM immediately revokes its permissions and prevents further unauthorized access, CloudTrail is the correct service to identify all past actions and affected resources, and a CloudWatch alarm provides immediate notification for any future attempts to use the compromised key. Option D (incorrect) Changing the IAM user password and enabling MFA are crucial security measures for console access, but they do not invalidate or deactivate an existing IAM access key used for programmatic access.'
WHERE question_id = '2935a5ee-ccbc-4b0d-b964-9e12ac4705f9';

-- question_id: 2a057bce-bfb0-4f7f-a425-6823028a302d
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon OpenSearch Service is a highly scalable, distributed search and analytics engine that natively supports full-text search, multiple languages via analyzers (e.g., Lucene analyzers), faceted filtering through aggregations, and advanced autocomplete suggestions using features like the completion suggester, making it the ideal solution for the stated requirements. Option B (incorrect) Amazon CloudSearch offers full-text search and faceted search but is generally less feature-rich and powerful than OpenSearch Service for complex multi-language support, advanced autocomplete logic, and large-scale, high-performance search requirements. Option C (incorrect) DynamoDB is a NoSQL database designed for high-performance, key-value and document data storage, but it does not provide native full-text search capabilities, linguistic analysis, faceted filtering, or autocomplete suggestions, even with Global Secondary Indexes. Option D (incorrect) Amazon Kendra is an intelligent enterprise search service powered by machine learning and natural language processing, optimized for semantic search and question answering within specific document sets, but it is not designed for building a generic full-text search engine with custom faceted filtering and precise autocomplete suggestions in the same way OpenSearch Service is.'
WHERE question_id = '2a057bce-bfb0-4f7f-a425-6823028a302d';

-- question_id: 2a66f851-edd7-4e4f-8a62-499a662483ef
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Transfer Acceleration leverages CloudFront''s globally distributed edge locations to accelerate data transfers to and from S3 buckets, primarily focusing on improving performance for distant users rather than automatically optimizing storage costs by moving data between storage classes. Option B (correct) S3 Lifecycle policies enable you to define rules to automatically transition objects between different S3 storage classes (e.g., from S3 Standard to S3 Standard-IA, S3 Glacier Instant Retrieval, or Amazon Glacier) based on age or other criteria, thereby directly optimizing storage costs. Option C (incorrect) S3 Cross-Region Replication automatically copies objects from a source S3 bucket in one AWS Region to a destination S3 bucket in a different AWS Region, serving purposes like disaster recovery, compliance, or reduced latency, but it does not automatically move data between storage classes for cost optimization within a single bucket. Option D (incorrect) S3 Versioning keeps multiple versions of an object in the same S3 bucket, protecting against accidental overwrites or deletions, and while it impacts storage costs, it is not the feature that automatically moves data between storage classes for cost optimization.'
WHERE question_id = '2a66f851-edd7-4e4f-8a62-499a662483ef';

-- question_id: 2a890c2e-8f1d-49a4-a691-c2f55ea6a250
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) When an AI system like a recruitment platform exhibits gender bias, it directly violates the principle of fairness and non-discrimination, as it makes prejudiced decisions based on protected attributes; AWS provides tools like Amazon SageMaker Clarify to detect and mitigate such biases in machine learning models during various stages of development and deployment. Option B (incorrect) Speed optimization refers to improving the inference or training time of an AI model or the response time of a system, which is a performance metric and not directly related to ethical bias; AWS services like Amazon SageMaker hosting options (e.g., real-time endpoints, serverless inference) or Elastic Inference are used for this purpose, but they don''t address the ethical issue of bias. Option C (incorrect) Cost efficiency relates to optimizing the financial expenditure of running an AI solution, for example by choosing appropriate instance types or scaling strategies; AWS services like Amazon SageMaker pricing models, Spot Instances for training, or serverless options help manage costs, but they do not inherently prevent or address gender bias. Option D (incorrect) User interface design pertains to how users interact with the system and its usability, focusing on the visual and interactive elements; while a well-designed UI can present information clearly, it does not prevent underlying algorithmic bias, which is a problem with the AI model''s logic and data, not its presentation, though AWS Amplify or frontend development tools can assist with UI aspects.'
WHERE question_id = '2a890c2e-8f1d-49a4-a691-c2f55ea6a250';

-- question_id: 2adfbb64-2068-4740-8a56-931ff98ea03b
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) Implementing a Retrieval Augmented Generation (RAG) pattern with Amazon Bedrock Knowledge Bases is ideal because it automatically indexes and retrieves relevant information from proprietary document repositories like S3, uses that information to ground foundation model responses, significantly reduces hallucinations, and automatically stays current with frequently updated documents with minimal manual effort. Option B (incorrect) Fine-tuning a foundation model is not suitable for frequently updated documents because each update would necessitate an expensive and time-consuming re-fine-tuning process, which contradicts the goal of minimizing effort to keep the knowledge base current. Option C (incorrect) While using advanced prompt engineering with document snippets is a form of RAG, it implies a more manual approach to retrieval and management of document indexing and chunking compared to the fully managed and automated capabilities offered by Amazon Bedrock Knowledge Bases, thus not minimizing effort as effectively. Option D (incorrect) Developing a custom search engine allows engineers to find documents but does not provide an "AI assistant" that can generate natural language answers, summarize information, or synthesize responses from the documents, which is a core requirement of the problem.'
WHERE question_id = '2adfbb64-2068-4740-8a56-931ff98ea03b';

-- question_id: 2bdedea2-3a2b-46f1-b367-59ab24ea1357
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) On-Demand instances provide flexibility with no long-term commitment and are priced at a fixed rate per second/hour, making them the most expensive option and not offering deep discounts. Option B (incorrect) Reserved Instances offer significant discounts (up to 75% compared to On-Demand) in exchange for a 1-year or 3-year commitment but do not have potential interruptions as they guarantee capacity for the duration of the reservation. Option C (correct) Spot Instances offer the deepest discounts (up to 90% off On-Demand pricing) by allowing users to bid on unused EC2 capacity, but they can be interrupted by AWS with a two-minute notice if the Spot price exceeds the user''s bid or if capacity is no longer available. Option D (incorrect) Dedicated Hosts provide physical EC2 servers dedicated for your use, offering visibility and control over server usage, but they are generally more expensive than On-Demand or Reserved Instances and do not offer deep discounts or interruptions based on capacity availability.'
WHERE question_id = '2bdedea2-3a2b-46f1-b367-59ab24ea1357';

-- question_id: 2c2958db-9229-40a9-97af-7861e6b7c1fd
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Snowball Edge is a physical device used for large-scale data transfer when network migration is infeasible or too slow, directly contradicting the requirement of "without requiring physical appliance shipping." Option B (incorrect) Manual SCP/rsync commands are not suitable for migrating several hundred terabytes of data with "minimal manual effort" due to lack of automation, resilience, and inherent optimization compared to dedicated AWS services. Option C (correct) AWS DataSync is specifically designed for securely and efficiently migrating large amounts of file data, including NFS shares, over the network to Amazon S3 with built-in automation and monitoring. Option D (incorrect) AWS Database Migration Service (DMS) is designed for migrating databases, not file data from NFS shares, making it unsuitable for this specific data migration requirement.'
WHERE question_id = '2c2958db-9229-40a9-97af-7861e6b7c1fd';

-- question_id: 2de32adc-3021-4be8-a2c2-08e6daf4a2af
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Marketplace is a public digital catalog for customers, not an internal platform or benefit store exclusively for AWS employees. Option B (correct) AWS Marketplace serves as a curated digital catalog that enables AWS customers to easily find, buy, and deploy third-party software, data products, and professional services directly onto their AWS environment. Option C (incorrect) AWS Marketplace does not list internal AWS services like EC2, S3, or Lambda; these core AWS services are managed and accessed directly through the AWS Management Console, CLI, or SDKs. Option D (incorrect) AWS is a cloud provider offering virtualized resources, and AWS Marketplace focuses on software, not the sale of physical computer hardware to customers, although AWS does provide some specialized hardware services like AWS Snow Family for data transfer.'
WHERE question_id = '2de32adc-3021-4be8-a2c2-08e6daf4a2af';

-- question_id: 2fb6ee7d-3294-4e29-bf92-104b21d738ca
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) A zero-shot prompting approach, relying solely on general instructions, would not effectively leverage the provided examples to guide the model towards the desired creative and factually accurate style for social media posts on Amazon Bedrock. Option B (correct) A few-shot prompting technique is most effective because it explicitly provides the foundation model on Amazon Bedrock with examples of product descriptions paired with well-written social media posts, directly teaching it the desired style, tone, and factual accuracy based on the team''s existing good examples. Option C (incorrect) While chain-of-thought prompting can enhance factual accuracy by having the model reason through steps, it is not the most direct method for leveraging *provided examples* to teach the model the specific creative and stylistic output format desired for social media posts. Option D (incorrect) ReAct prompting, which integrates reasoning with external tool use, is designed for tasks requiring dynamic information retrieval or complex multi-step interactions beyond the model''s training data, which is not indicated as necessary since the product descriptions are provided and examples are available.'
WHERE question_id = '2fb6ee7d-3294-4e29-bf92-104b21d738ca';

-- question_id: 2fcc5774-bc9e-4e80-bbea-ec4d6736381e
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deploying in a single region limits an organization''s reach and latency benefits to that specific geographic area, preventing it from truly going global. Option B (incorrect) A limited geographic presence means AWS is only available in a few locations, which directly contradicts the ability to "go global in minutes" by restricting worldwide resource availability. Option C (correct) AWS''s extensive global infrastructure, comprising dozens of regions worldwide, allows organizations to provision resources, deploy applications, and serve users in multiple geographic locations quickly and on-demand, leveraging services like Amazon EC2, Amazon S3, and Amazon RDS across regions for rapid global expansion. Option D (incorrect) Relying only on local data centers means an organization manages its own on-premises infrastructure, completely bypassing AWS''s global network and the agility it provides for rapid worldwide deployment.'
WHERE question_id = '2fcc5774-bc9e-4e80-bbea-ec4d6736381e';

-- question_id: 3006f95f-9345-412e-919c-4d3234a727d0
-- answer_correct: True | verified_indices: [3] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The Basic Support plan is free and provides access to customer service and public AWS documentation, but it does not include a Technical Account Manager for proactive architectural guidance or strategic planning. Option B (incorrect) The Developer Support plan offers technical support for development and testing issues during business hours, but it does not provide a dedicated Technical Account Manager for strategic oversight. Option C (incorrect) The Business Support plan provides 24/7 technical support and architectural guidance in the context of specific use cases, but it does not assign a dedicated Technical Account Manager to serve as a consistent strategic point of contact. Option D (correct) The Enterprise On-Ramp Support plan explicitly includes a designated Technical Account Manager (TAM) who provides proactive architectural guidance, operational reviews, and acts as a dedicated point of contact for strategic planning and issue resolution, directly meeting the enterprise''s complex needs.'
WHERE question_id = '3006f95f-9345-412e-919c-4d3234a727d0';

-- question_id: 304a1ca3-d3af-47c0-9b93-29f7ade76830
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) High availability ensures that an application remains accessible even if a component fails, typically by distributing resources across multiple Availability Zones with services like Application Load Balancers, rather than addressing sudden increases in demand. Option B (incorrect) Fault tolerance allows a system to continue functioning despite component failures by incorporating redundancy and automatic failover, as seen with AWS Auto Scaling automatically replacing unhealthy instances, but it does not primarily address scaling for increased load. Option C (correct) Elasticity enables the dynamic provisioning and de-provisioning of computing resources to automatically scale up or down in response to demand fluctuations, perfectly addressing sudden increases in trading volume through services like AWS Auto Scaling and AWS Lambda. Option D (incorrect) Global reach allows an application to be deployed across multiple geographic regions to serve users worldwide with low latency, using services such as Amazon CloudFront, but it does not directly relate to handling sudden spikes in workload within a region.'
WHERE question_id = '304a1ca3-d3af-47c0-9b93-29f7ade76830';

-- question_id: 3056196b-5e54-4408-836d-ff7096a0525d
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Domain registration is the process of reserving a domain name, which is a prerequisite for using a domain but does not inherently distribute traffic or provide high availability. Option B (incorrect) DNS caching stores DNS query results locally to speed up future lookups, improving performance but not distributing traffic across multiple resources for high availability. Option C (correct) Health checks and failover, such as those provided by AWS Route 53, enable DNS to monitor resource health and automatically redirect traffic away from unhealthy endpoints to healthy ones, ensuring high availability. Option D (incorrect) SSL certificates are used to encrypt communication and verify identity for secure connections, which is a security feature and not a mechanism for distributing traffic or ensuring high availability at the DNS level.'
WHERE question_id = '3056196b-5e54-4408-836d-ff7096a0525d';

-- question_id: 30c58454-63a5-4719-9ba6-cdf592dcd1a6
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) PCI DSS is relevant for organizations that process, store, or transmit credit card information, and while a healthcare organization might handle payments on AWS, it''s not the primary compliance framework for protecting general patient health data, which would leverage services like AWS WAF for web application protection but for cardholder data specifically. Option B (correct) HIPAA is specifically designed to protect the privacy and security of Electronic Protected Health Information (ePHI) for healthcare organizations, and AWS provides a Business Associate Addendum (BAA) and compliant services like Amazon S3 with server-side encryption and AWS Identity and Access Management (IAM) for granular access control to help customers meet HIPAA requirements. Option C (incorrect) SOX primarily addresses corporate governance and financial reporting integrity for publicly traded companies, and while AWS services like AWS CloudTrail for logging and AWS Config for configuration management can assist in SOX compliance, it does not directly regulate the privacy of patient health information. Option D (incorrect) GDPR regulates the protection of personal data for individuals within the European Union and EEA, and while a healthcare organization serving EU citizens would need to comply, it is a broad data privacy regulation and not the most relevant *specific* healthcare compliance framework in the same way HIPAA is, although AWS services such as AWS Key Management Service (KMS) for encryption and AWS Security Hub for compliance monitoring can support GDPR efforts.'
WHERE question_id = '30c58454-63a5-4719-9ba6-cdf592dcd1a6';

-- question_id: 30fc9d07-f043-4779-a461-0d4312728bef
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon WorkSpaces provides a fully managed, secure Desktop-as-a-Service (DaaS) solution, which offers virtual desktops but does not intrinsically provide contact center functionality like call routing or IVR. Option B (correct) Amazon Connect is a highly scalable, cloud-based contact center service that enables businesses to set up and manage customer service operations, including IVR, queues, and agent routing, in minutes. Option C (incorrect) AWS AppSync is a fully managed GraphQL service that simplifies application development by allowing you to create a flexible API to securely access, manipulate, and combine data from one or more data sources, which is unrelated to contact center services. Option D (incorrect) Amazon SES (Simple Email Service) is a cost-effective, flexible, and scalable email sending and receiving service for developers and businesses, used for transactional emails or marketing, not for contact center operations.'
WHERE question_id = '30fc9d07-f043-4779-a461-0d4312728bef';

-- question_id: 31ac4b3c-6ba6-444a-ae28-6d973634f0a6
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Inbound data transfer from the internet into AWS services like S3 or EC2 is generally free of charge. Option B (incorrect) Data transfer between AWS services located within the same Availability Zone (AZ) typically incurs no data transfer charges. Option C (correct) Data transfer out from AWS services to the public internet (egress) is a primary scenario where AWS charges for bandwidth consumption across almost all services like EC2, S3, and RDS. Option D (incorrect) Data transfer operations performed strictly within the confines of a single AWS service, such as internal processing within an EC2 instance or data movement within an S3 bucket in the same region, do not typically incur separate data transfer fees.'
WHERE question_id = '31ac4b3c-6ba6-444a-ae28-6d973634f0a6';

-- question_id: 322dc782-4afb-4bc7-a44d-4ca6e0af64a8
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While using Reserved Instances for core nodes and Spot instances for task nodes offers significant savings over On-Demand, it does not provide the maximum possible cost reduction because Reserved Instances are more expensive than Spot Instances, even for critical core nodes. Option B (correct) Using Spot instances for all nodes with diversified instance types and allocation strategies provides the maximum cost savings for fault-tolerant, scheduled Spark jobs on EMR by leveraging the highest available discounts while mitigating interruption risk for core nodes. Option C (incorrect) Switching to EMR on EKS, while offering flexibility and Spot instance usage, introduces a new architectural complexity and operational overhead, and might not yield maximum direct cost savings for an existing EMR workload compared to optimizing the current EMR setup with Spot. Option D (incorrect) Deploying EMR Serverless offers excellent operational simplicity and pay-per-use cost optimization, but its per-unit compute cost may be higher than a well-optimized EMR on EC2 cluster extensively using Spot Instances for predictable, fault-tolerant batch jobs, thus not providing the absolute maximum cost savings.'
WHERE question_id = '322dc782-4afb-4bc7-a44d-4ca6e0af64a8';

-- question_id: 325ad469-de43-4b6b-9006-094fd4e11b04
-- answer_correct: True | verified_indices: [2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Scheduling with EventBridge would run jobs periodically regardless of new data availability, failing the requirement to minimize costs by running only when new data is present. Option B (incorrect) While S3 event notifications triggering a Lambda function to start a Glue workflow is a viable pattern, AWS Glue workflows offer native event-driven triggers that can directly respond to events, providing a more integrated and often simpler solution for orchestrating Glue jobs without an intermediary Lambda for simple starts. Option C (correct) AWS Glue Workflows are purpose-built for orchestrating sequences of AWS Glue jobs and crawlers, and their event-driven triggers allow the workflow to start automatically only when new data arrives (e.g., via S3 events routed through EventBridge), minimizing costs by executing jobs solely when needed. Option D (incorrect) Amazon MWAA (Managed Workflows for Apache Airflow) provides powerful orchestration but its persistent environment incurs continuous costs, which does not align with the strict requirement to minimize costs by not running any part of the solution when no new data is available for a purely Glue-centric pipeline.'
WHERE question_id = '325ad469-de43-4b6b-9006-094fd4e11b04';

-- question_id: 3399017c-17c6-45a2-84d1-42ecd07f9ad1
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Internet Gateway allows instances in a public subnet to communicate directly with the internet, but it does not provide internet access for instances residing in private subnets, which lack public IP addresses. Option B (correct) NAT Gateway allows instances in a private subnet to initiate outbound internet access while preventing unsolicited inbound connections from the internet, by translating their private IP addresses to its own public IP address. Option C (incorrect) VPC Peering connects two Amazon VPCs privately, enabling instances in one VPC to communicate with instances in the other VPC using private IP addresses, rather than providing internet access. Option D (incorrect) Direct Connect establishes a dedicated private network connection between your on-premises data center and AWS, used for high-bandwidth, low-latency connectivity to AWS services, not for providing internet access to private subnet instances.'
WHERE question_id = '3399017c-17c6-45a2-84d1-42ecd07f9ad1';

-- question_id: 339cdfce-ef40-4236-99a9-150ae0174e03
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using multiple Availability Zones typically increases costs due to the need for duplicate resources and potential data transfer charges between zones, rather than lowering them. Option B (correct) Multiple Availability Zones provide increased fault tolerance by isolating resources across physically distinct locations within a region, ensuring application availability even if one zone experiences an outage, a core principle leveraged by services like Amazon RDS Multi-AZ deployments and EC2 Auto Scaling Groups. Option C (incorrect) While deploying resources closer to end-users (using different regions or edge locations) can improve performance, simply using multiple Availability Zones within the same region does not inherently lead to faster performance; in some cases, cross-AZ traffic might introduce minimal latency. Option D (incorrect) Managing resources across multiple Availability Zones generally adds complexity to infrastructure design and deployment, requiring careful planning for networking, load balancing, and data synchronization, rather than making management easier.'
WHERE question_id = '339cdfce-ef40-4236-99a9-150ae0174e03';

-- question_id: 3513b935-5b1d-49d9-967a-17b637aaddaa
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) Amazon EBS volumes are block storage devices that can only be attached to a single EC2 instance at a time within the same Availability Zone, making them unsuitable for concurrent access by multiple instances or cross-AZ sharing. Option B (incorrect) Amazon S3 is object storage, not a POSIX-compliant file system, and while highly available, mounting it as a file system using third-party tools introduces performance overhead, latency, and does not natively support all file system operations required for a performant content management system. Option C (correct) Amazon EFS (Elastic File System) is a fully managed, highly available, and durable shared file system that is POSIX-compliant, can be concurrently mounted by thousands of EC2 instances across multiple Availability Zones, and automatically scales its storage capacity and performance (throughput and IOPS) without manual intervention as data grows. Option D (incorrect) Amazon FSx for Windows File Server provides a fully managed, highly available file system primarily for Windows-based workloads using the SMB protocol, and while it scales capacity automatically, its performance scaling often involves provisioning throughput rather than being fully automatic based on data growth like EFS, and it''s less suitable for typical Linux-based CMS clusters.'
WHERE question_id = '3513b935-5b1d-49d9-967a-17b637aaddaa';

-- question_id: 35521e9b-0021-4cbf-8fef-88917be01970
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Prompt templates are text structures for guiding LLMs and do not influence the size of the underlying model, which is determined by its architecture and parameters, independent of how input is formatted for services like Amazon Bedrock. Option 1 (correct) Prompt templates standardize the input structure for large language models, such as those accessed through Amazon Bedrock, ensuring the model consistently receives instructions in a predictable format and produces outputs adhering to a desired schema or style, which is vital for reliable application integration. Option 2 (incorrect) Prompt templates do not inherently increase inference speed; the performance of services like Amazon SageMaker Endpoints or Amazon Bedrock depends on factors such as model complexity, allocated hardware, and batching, not simply the use of a template. Option 3 (incorrect) Prompt templates define how input data or context is presented to a model, but they do not remove the necessity for relevant data or information that the model processes to generate meaningful responses, often supplied through techniques like Retrieval Augmented Generation (RAG) with Amazon Kendra.'
WHERE question_id = '35521e9b-0021-4cbf-8fef-88917be01970';

-- question_id: 35d9f88c-db6d-497b-888e-5f011051af5c
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS IAM manages permanent users, groups, roles, and their permissions, defining what a federated user can do, but it does not directly issue temporary credentials. Option B (correct) AWS Security Token Service (STS) is specifically designed to issue temporary, limited-privilege credentials that federated users can use to assume an IAM role and access AWS resources. Option C (incorrect) AWS Organizations helps you centrally manage and govern multiple AWS accounts and their resources, primarily for consolidated billing and policy enforcement, not for issuing temporary user access. Option D (incorrect) AWS SSO, now known as AWS IAM Identity Center, provides a centralized single sign-on experience for users accessing multiple AWS accounts, but it relies on AWS STS in the background to issue the temporary credentials for assumed roles.'
WHERE question_id = '35d9f88c-db6d-497b-888e-5f011051af5c';

-- question_id: 360bc09d-744b-4b4b-af09-468dc318005a
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While properly managed IAM groups contribute to a secure posture by enforcing least privilege principles, their primary benefit isn''t directly "increasing security" beyond what individual user policies could achieve, but rather simplifying the management of that security. Option B (correct) IAM groups simplify permission management by allowing administrators to attach a set of permissions (policies) to a group once, and all users added to that group automatically inherit those permissions, eliminating the need to attach the same policy to each individual user. Option C (incorrect) IAM groups are an access management feature and have no direct impact on the runtime performance of AWS services or applications. Option D (incorrect) IAM is a free service, and therefore, using IAM groups does not directly reduce AWS service costs, though it optimizes administrative effort.'
WHERE question_id = '360bc09d-744b-4b4b-af09-468dc318005a';

-- question_id: 368589d5-0587-45a9-be28-0afde09f724a
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Cost allocation tags are metadata for organizing and tracking costs, not for directly optimizing the operational performance of AWS resources like EC2 instances or S3 buckets. Option B (correct) Cost allocation tags are key-value pairs applied to AWS resources, enabling detailed cost breakdown and reporting in AWS Cost Explorer and billing reports, allowing organizations to attribute expenses to specific projects, teams, or environments. Option C (incorrect) While tags can be used in conjunction with IAM policies to implement tag-based access control, which is a security mechanism, their main benefit is not to inherently increase overall security posture but to enable granular authorization and, primarily, cost tracking. Option D (incorrect) Cost allocation tags are used for financial tracking and resource organization, and they have no impact on network latency, which is determined by factors such as geographic distance, network configuration, and resource proximity.'
WHERE question_id = '368589d5-0587-45a9-be28-0afde09f724a';

-- question_id: 36a798c5-4656-46d3-a7b3-6d364caa0997
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS WAF (Web Application Firewall) protects web applications from common web exploits and unwanted bot traffic, but it is not the primary service for comprehensive DDoS protection across various layers. Option B (correct) AWS Shield is a managed Distributed Denial of Service (DDoS) protection service that safeguards applications running on AWS, offering both standard and advanced tiers to mitigate DDoS attacks. Option C (incorrect) Amazon GuardDuty is a threat detection service that continuously monitors for malicious activity and unauthorized behavior to protect AWS accounts and workloads, not DDoS attacks. Option D (incorrect) AWS Config enables you to assess, audit, and evaluate the configurations of your AWS resources, helping with compliance and governance, but it does not provide DDoS protection.'
WHERE question_id = '36a798c5-4656-46d3-a7b3-6d364caa0997';

-- question_id: 36b2c592-fe92-4ca5-b748-0c1007806853
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Predicting crop yields, which are continuous numerical values such as tons per acre or bushels per hectare, is a classic regression problem, often solved using algorithms like Amazon SageMaker''s built-in Linear Learner or XGBoost. Option B (incorrect) Binary classification predicts one of two discrete outcomes or categories (e.g., whether a crop will fail or succeed), not a continuous numerical yield. Option C (incorrect) Clustering is an unsupervised learning technique used to group unlabeled data points based on similarity (e.g., segmenting farms by climate or soil type), not to predict a specific output value. Option D (incorrect) Anomaly detection identifies unusual data points or outliers that deviate significantly from the normal pattern (e.g., detecting an unusually low yield due to an unexpected event), rather than predicting the expected yield itself.'
WHERE question_id = '36b2c592-fe92-4ca5-b748-0c1007806853';

-- question_id: 37ccc660-44ab-4e63-83db-717d97407837
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] (incorrect) Increasing model parameters directly increases the number of computations and memory required for both training and inference, leading to higher computational costs on AWS compute resources such as EC2 P-instances or during SageMaker model deployment. Option [1] (correct) Quantization reduces the precision of model weights and activations (e.g., from FP32 to INT8), which significantly decreases memory footprint and accelerates inference on AWS services like SageMaker endpoints, especially when leveraging specialized hardware such as AWS Inferentia or NVIDIA GPUs. Option [2] (incorrect) Adding more layers deepens the model architecture, leading to a greater number of sequential operations and increased memory consumption, thus raising the computational cost for processing on AWS. Option [3] (incorrect) Expanding vocabulary size increases the dimensionality of embedding layers and potentially the output softmax layer, requiring more memory and computational power for processing on AWS compute instances.'
WHERE question_id = '37ccc660-44ab-4e63-83db-717d97407837';

-- question_id: 37ce1e4c-8b49-4551-87d1-9c8b851785c5
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Concurrency scaling in Amazon Redshift automatically adds temporary capacity to a cluster to handle bursts of read queries, ensuring consistent performance during peak loads without over-provisioning the base cluster for average utilization, thus solving the cost waste problem. Option B (incorrect) Workload Management (WLM) with dynamic memory allocation optimizes resource utilization and query execution within the existing cluster capacity but does not add or remove compute capacity to handle variable workloads or reduce over-provisioning costs. Option C (incorrect) Using query priorities and off-peak scheduling helps to manage the execution order and resource allocation of queries on the current cluster, but it does not provide temporary additional capacity for query bursts or reduce costs associated with over-provisioning. Option D (incorrect) Amazon Redshift provisioned clusters do not offer automatic cluster resizing based on dynamic workload changes for temporary scaling; features like elastic resize are typically for manual, permanent cluster size adjustments, while Redshift Serverless provides automatic scaling for the entire data warehouse which is a different service.'
WHERE question_id = '37ce1e4c-8b49-4551-87d1-9c8b851785c5';

-- question_id: 37ce5ab1-0398-4c56-a5e3-afe1f8378d23
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS VPN provides a secure, encrypted connection over the public internet, which can be inconsistent in performance and typically does not offer the dedicated high-bandwidth necessary for large-scale migrations with stringent consistency requirements. Option B (incorrect) Amazon Route 53 is a highly available and scalable cloud Domain Name System (DNS) web service used for routing traffic and managing domain names, not for establishing a physical or logical network connection between on-premises and AWS. Option C (correct) AWS Direct Connect establishes a dedicated, private network connection from an on-premises data center directly to AWS, bypassing the public internet, which provides consistent network performance, reduced latency, increased bandwidth capacity, and enhanced security ideal for large-scale data transfers and sensitive data. Option D (incorrect) AWS Global Accelerator improves the availability and performance of applications for global users by directing traffic to optimal AWS endpoints over the AWS global network, but it does not provide the dedicated, private connectivity between an on-premises data center and AWS required for the migration.'
WHERE question_id = '37ce5ab1-0398-4c56-a5e3-afe1f8378d23';

-- question_id: 37f74b54-e9c3-455a-97f6-e94f67e77f2e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon SageMaker is a fully managed service that allows data scientists and developers to build, train, and deploy machine learning models, but it is not specifically designed for building conversational interfaces like chatbots. Option B (correct) Amazon Lex is a fully managed AI service that provides machine learning capabilities to build conversational interfaces, known as chatbots, for applications using voice and text. Option C (incorrect) Amazon Comprehend is a natural language processing (NLP) service that uses machine learning to find insights and relationships in text, such as sentiment analysis or entity recognition, rather than for building the conversational flow of a chatbot. Option D (incorrect) Amazon Rekognition is a machine learning service that provides image and video analysis capabilities, making it unrelated to building text or voice-based chatbots.'
WHERE question_id = '37f74b54-e9c3-455a-97f6-e94f67e77f2e';

-- question_id: 38404602-af6f-4cd9-b678-505c761188ca
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) Individual purchasing power does not enable massive economies of scale because the cost benefits come from AWS''s ability to buy hardware in bulk and operate data centers efficiently, which an individual customer cannot replicate. Option B (incorrect) Smaller infrastructure sharing does not represent massive economies of scale, as AWS leverages its global network of large-scale data centers and millions of servers to achieve significant cost reductions through optimized resource utilization for services like EC2 and S3. Option C (correct) AWS spreading costs across millions of customers is the fundamental mechanism for massive economies of scale, as the vast user base helps distribute the significant capital and operational expenses of building and maintaining global infrastructure, leading to lower per-unit costs for services like EC2 instances or S3 storage. Option D (incorrect) Limited service availability is contradictory to the benefits of cloud computing and massive economies of scale, as AWS focuses on high availability and global reach through multiple Regions and Availability Zones for services like EC2 and RDS.'
WHERE question_id = '38404602-af6f-4cd9-b678-505c761188ca';

-- question_id: 38f9b84a-e7a0-459a-b400-5b16b7487399
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) PCI DSS is crucial for AI in financial services because AI systems processing or storing credit card data (e.g., for fraud detection or transaction analysis) must adhere to its strict security requirements, which can be supported on AWS through services like AWS Security Hub for compliance monitoring and Amazon Macie for data discovery to identify cardholder data. Option B (correct) SOC 2 is highly relevant as AI in financial services involves handling sensitive customer data, requiring service organizations to demonstrate robust controls over security, availability, processing integrity, confidentiality, and privacy, which can be achieved on AWS by leveraging services like AWS CloudTrail for auditing and AWS Identity and Access Management (IAM) for access control. Option C (incorrect) HIPAA is not generally applicable to AI in financial services as it specifically pertains to the protection of protected health information (PHI) in the healthcare sector, not standard financial data. Option D (incorrect) FERPA is not relevant to AI in financial services because it exclusively governs the privacy of student educational records. Option E (incorrect) COPPA is typically not relevant to general AI applications in financial services as it focuses on the online collection of personal information from children under 13.'
WHERE question_id = '38f9b84a-e7a0-459a-b400-5b16b7487399';

-- question_id: 3a376948-b381-4c64-9fd4-9633066d4cb8
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS VPN establishes an encrypted connection over the public internet, which does not provide a dedicated, private network connection that bypasses the public internet as required. Option B (correct) AWS Direct Connect provides a dedicated, private physical network connection from an on-premises data center to an AWS Direct Connect location, explicitly bypassing the public internet. Option C (incorrect) VPC Peering connects two Amazon Virtual Private Clouds (VPCs) together within the AWS network, and is not used for connecting on-premises data centers to AWS. Option D (incorrect) AWS PrivateLink enables private connectivity between VPCs and AWS services or services hosted by other AWS accounts, it does not establish a network connection from an on-premises data center to AWS itself.'
WHERE question_id = '3a376948-b381-4c64-9fd4-9633066d4cb8';

-- question_id: 3ac56726-cafb-4231-ac67-716ad90e43a6
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Model decision criteria and fairness metrics are crucial for demonstrating the transparency, accountability, and non-discriminatory nature of an AI system, which can be measured and documented using tools like Amazon SageMaker Clarify for bias detection and model explainability. Option B (incorrect) Neglecting documentation for a critical AI system like loan approval directly violates regulatory requirements for explainability, auditability, and responsible AI, which are core tenets of the AWS Well-Architected Framework''s Operational Excellence pillar. Option C (incorrect) Documenting only final decisions provides insufficient detail for auditing the underlying logic, identifying potential biases, or explaining *why* a specific decision was made, falling short of compliance requirements that demand transparency into the decision-making process, even when using services like AWS Lambda to execute inference. Option D (incorrect) AI models for critical applications like loan approvals are designed to be deterministic and based on learned patterns and data, not random selections; documenting randomness would undermine the very purpose of an auditable and explainable system built with AWS Machine Learning services.'
WHERE question_id = '3ac56726-cafb-4231-ac67-716ad90e43a6';

-- question_id: 3af2ab79-3c44-4773-9924-0aae4dbcf68b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Encryption at rest protects data when it is stored on persistent storage, such as Amazon S3 objects or Amazon EBS volumes, using services like AWS KMS, not while it is being actively transmitted over a network. Option B (correct) Encryption in transit (or in-flight encryption) specifically protects data as it moves between systems or over a network, typically using protocols like TLS/SSL for secure communication with services like Amazon S3 via HTTPS or secure VPN connections. Option C (incorrect) File system encryption, such as Amazon EFS encryption or OS-level encryption, secures data stored within a file system, which is a form of encryption at rest, not for data actively moving across a network. Option D (incorrect) Database encryption, like Amazon RDS encryption at rest, secures data stored within a database, but data transmitted to and from the database still requires in-transit encryption, typically SSL/TLS, for network protection.'
WHERE question_id = '3af2ab79-3c44-4773-9924-0aae4dbcf68b';

-- question_id: 3b60af67-e698-41d7-85a8-01b3c7ab500d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While AWS managed services can contribute to lower operational costs by offloading infrastructure management, this is an economic benefit, not a primary security advantage. Option B (correct) AWS managed services like Amazon RDS, S3, or Lambda inherently include AWS''s responsibility for security patching, vulnerability management, and infrastructure updates, significantly reducing the customer''s security operational burden. Option C (incorrect) Faster performance is an operational benefit of well-optimized AWS services, but it is not a direct security advantage in the context of what managed services primarily offer for security. Option D (incorrect) "Unlimited access" is a misstatement and a security risk; AWS emphasizes the principle of least privilege, requiring customers to carefully manage access to resources using AWS IAM, which is the opposite of unlimited access.'
WHERE question_id = '3b60af67-e698-41d7-85a8-01b3c7ab500d';

-- question_id: 3be482e0-3f3c-4935-ad39-2bb730d7869b
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using the root account for daily tasks is strongly discouraged by AWS because the root user has unrestricted administrative access to all resources and cannot be restricted by IAM policies, making it a high-risk account. Option B (incorrect) Sharing passwords among team members is a critical security vulnerability that violates AWS security best practices, as it compromises individual accountability, complicates auditing, and makes it impossible to track specific user actions. Option C (correct) Implementing least privilege access is a fundamental AWS IAM best practice that ensures users and services are granted only the permissions absolutely necessary to perform their specific tasks, thereby minimizing the potential impact of a security compromise. Option D (incorrect) Granting administrator access to all users is a severe security risk that directly contradicts AWS best practices, as it provides unrestricted control over the AWS account to everyone, increases the attack surface, and eliminates the ability to enforce segregation of duties.'
WHERE question_id = '3be482e0-3f3c-4935-ad39-2bb730d7869b';

-- question_id: 3c74554f-aa21-4dfe-bb8e-90da268e4dad
-- answer_correct: True | verified_indices: [2] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon EBS provides block storage volumes for EC2 instances, but requires separate services like Amazon Data Lifecycle Manager or AWS Backup to automate snapshots for backup, and does not inherently provide file-level versioning. Option B (incorrect) Amazon EFS offers scalable file storage, but relies on services like AWS Backup for automatic, policy-driven backups, and does not natively support file versioning comparable to object versioning. Option C (correct) AWS Backup is a centralized, fully managed service that provides automatic and policy-driven backup and recovery for multiple AWS services, managing restore points that serve as versions of the data over time. Option D (incorrect) Amazon S3 provides highly durable object storage with a built-in Versioning feature for objects, but it is a storage service for objects itself, not a centralized backup service for other AWS resources.'
WHERE question_id = '3c74554f-aa21-4dfe-bb8e-90da268e4dad';

-- question_id: 3ddd2195-4ca1-4006-b0dc-2824f0bc450b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Lex is a service for building conversational interfaces (chatbots and voicebots) using automatic speech recognition and natural language understanding, not primarily a text-to-speech service itself. Option B (correct) Amazon Polly is the dedicated AWS service that converts text into lifelike speech using deep learning technologies. Option C (incorrect) Amazon Transcribe is an automatic speech recognition (ASR) service that converts spoken audio into text, which is the inverse operation of text-to-speech. Option D (incorrect) Amazon Comprehend is a natural language processing (NLP) service that extracts insights and relationships from unstructured text, not a service for converting text to speech.'
WHERE question_id = '3ddd2195-4ca1-4006-b0dc-2824f0bc450b';

-- question_id: 3ddebd3c-d5c4-41cf-b9a2-be8037d3c294
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config assesses, audits, and evaluates the configurations of your AWS resources, helping to identify non-compliant resources, rather than centralizing security findings from various services. Option B (correct) AWS Security Hub aggregates, organizes, and prioritizes security alerts and findings from various AWS services and partner solutions, providing a comprehensive view of your security posture across your AWS accounts. Option C (incorrect) AWS CloudFormation is an infrastructure as code service used to provision and manage AWS resources in a predictable way, not for identifying security findings or managing security posture. Option D (incorrect) AWS Systems Manager helps you gain operational insights and automate operational tasks across your AWS resources, including patch management and run command, but it does not centralize security findings or manage overall security posture.'
WHERE question_id = '3ddebd3c-d5c4-41cf-b9a2-be8037d3c294';

-- question_id: 3e53317d-4023-4b65-9b3f-ea8128ad646e
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) VPC endpoints, especially Interface Endpoints (powered by AWS PrivateLink) and Gateway Endpoints, provide secure and private connectivity from your Virtual Private Cloud (VPC) to supported AWS services, such as Amazon S3, Amazon SageMaker APIs, and Amazon ECR, without requiring an internet gateway, NAT gateway, or public IP addresses, thereby eliminating internet exposure. Option B (incorrect) VPC endpoints are specifically designed to enable private access to AWS services by keeping network traffic within the AWS global network, thus bypassing the public internet entirely rather than providing access to it. Option C (incorrect) By routing traffic directly over the AWS backbone and avoiding the public internet, VPC endpoints typically offer more consistent, lower-latency, and often faster connections to AWS services compared to internet-based access. Option D (incorrect) While VPC endpoints do incur charges (e.g., hourly rates for interface endpoints and data processing), their primary purpose is to enhance security, compliance, and performance, and they can sometimes reduce overall costs by eliminating the need for NAT Gateways for private subnet resources accessing AWS services.'
WHERE question_id = '3e53317d-4023-4b65-9b3f-ea8128ad646e';

-- question_id: 3f14c30e-f6d9-44a7-ad11-fc242119926d
-- answer_correct: True | verified_indices: [2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increasing SQS message retention time only dictates how long messages are stored in the queue before being deleted; it does not increase the processing capacity or speed up the consumption of messages. Option B (incorrect) While Lambda functions can process SQS messages, the problem''s implied constraint of "concurrent execution limits" could prevent the necessary scaling during a 100x spike, and a 30-second processing time per order might be better handled by dedicated workers for consistent performance and cost efficiency at scale. Option C (correct) Deploying an Auto Scaling group of EC2 workers configured to scale based on the SQS ApproximateNumberOfMessagesVisible metric directly addresses the need to dynamically adjust processing capacity in response to variable queue depths, ensuring messages are processed efficiently during peak and off-peak times. Option D (incorrect) SQS FIFO queues guarantee message ordering and exactly-once processing, which may be beneficial for orders, but they have lower default throughput limits than standard queues and their primary purpose is not to address the scaling of *processing capacity* which is the core problem described.'
WHERE question_id = '3f14c30e-f6d9-44a7-ad11-fc242119926d';

-- question_id: 3f7b1b8d-51d2-4ec8-aa09-62e63db94691
-- answer_correct: False | verified_indices: [] | confidence: 0%
UPDATE public.mock_test_questions
SET
    correct_answer = '{}'::integer[],
    explanation = 'Option 0 (correct) Step-by-step chain of thought is a prompting technique that guides Large Language Models (LLMs) hosted on services like Amazon Bedrock or Amazon SageMaker to break down complex mathematical problems into intermediate steps, which significantly improves accuracy and enables the model to self-correct by showing its logical progression. Option 1 (incorrect) Providing only a single answer to an LLM deployed via Amazon Bedrock for mathematical reasoning often results in lower accuracy and fewer opportunities for the model to perform intermediate computations, making the final output less reliable. Option 2 (incorrect) A prompt technique that provides no explanation from an LLM running on AWS services like Amazon SageMaker makes it impossible to trace the model''s mathematical reasoning, hindering debugging, validation, and the development of trustworthy AI applications. Option 3 (incorrect) Random guessing is not a prompt technique but rather an absence of strategic prompting, which is entirely counterproductive when working with AI models on AWS like those in Amazon Bedrock, as it would lead to unreliable and unguided outputs for mathematical reasoning.'
WHERE question_id = '3f7b1b8d-51d2-4ec8-aa09-62e63db94691';

-- question_id: 3f96c580-e42f-416d-a5ff-8c4d39ed10c9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] (incorrect) AWS Lambda is not designed for long-running applications due to its execution duration limits, typically best handled by services like Amazon EC2, AWS Fargate, or Amazon ECS/EKS for continuous processes. Option [1] (correct) AWS Lambda is primarily used for event-driven serverless computing, automatically running code in response to various events from AWS services like S3 or DynamoDB without requiring server provisioning. Option [2] (incorrect) AWS Lambda is a compute service and does not host databases; AWS provides dedicated database services such as Amazon RDS, Amazon DynamoDB, and Amazon Aurora for database hosting. Option [3] (incorrect) AWS Lambda does not perform load balancing; dedicated services like Elastic Load Balancing (ELB), including Application Load Balancer (ALB) and Network Load Balancer (NLB), are used for distributing incoming application traffic.'
WHERE question_id = '3f96c580-e42f-416d-a5ff-8c4d39ed10c9';

-- question_id: 3fe8bc98-c100-4380-93c3-0b1290400165
-- answer_correct: False | verified_indices: [1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Amazon ECS is AWS''s proprietary container orchestration service and does not provide Kubernetes. Option B (correct) Amazon EKS provides a managed Kubernetes control plane, and by utilizing AWS Fargate as the compute option for worker nodes, it allows running Kubernetes pods without managing the underlying EC2 instances. Option C (incorrect) AWS Fargate is a serverless compute engine for containers that can be used *with* services like EKS and ECS, but it is not a Kubernetes orchestration service itself. Option D (incorrect) AWS Batch is a service designed for running batch computing workloads, not a managed Kubernetes offering.'
WHERE question_id = '3fe8bc98-c100-4380-93c3-0b1290400165';

-- question_id: 404a9386-3669-472a-b68f-7957dfbd7183
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Network Access Control Lists (NACLs) operate at the subnet level and are stateless, meaning return traffic must be explicitly allowed. Option B (correct) Security Groups provide stateful traffic filtering at the instance or Elastic Network Interface (ENI) level, automatically allowing return traffic for allowed outbound or inbound connections. Option C (incorrect) VPC Flow Logs are a monitoring tool that captures information about IP traffic going to and from network interfaces, but they do not filter traffic. Option D (incorrect) AWS Shield is a managed Distributed Denial of Service (DDoS) protection service that safeguards applications running on AWS, not a granular instance-level traffic filtering mechanism.'
WHERE question_id = '404a9386-3669-472a-b68f-7957dfbd7183';

-- question_id: 41765520-9714-44b1-8788-59a12a9b86e2
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Chain-of-thought prompting is highly effective for complex reasoning tasks within AWS Bedrock''s foundational models as it guides the model to break down problems into intermediate steps, mirroring a logical thought process and leading to more accurate and verifiable outcomes for applications like complex data analysis or intricate code generation. Option B (incorrect) Simple keyword prompts provide insufficient context and guidance for foundational models on AWS Bedrock to perform multi-step or deep reasoning, often resulting in superficial or incomplete responses unsuitable for complex analytical tasks. Option C (incorrect) Random prompting introduces unstructured and irrelevant input, which would cause foundational models on AWS Bedrock to produce unpredictable, often nonsensical outputs, making it entirely ineffective for any meaningful reasoning task. Option D (incorrect) No prompting means there is no input provided to the foundational model on AWS Bedrock, which is required for the model to generate any response, thus yielding no output or functionality whatsoever.'
WHERE question_id = '41765520-9714-44b1-8788-59a12a9b86e2';

-- question_id: 41941a19-b0a7-41bb-884d-3ca01ce754a6
-- answer_correct: True | verified_indices: [1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) ANALYZE directly addresses the "table statistics are outdated" problem by updating metadata used by the query optimizer, but it does not reclaim space from deleted rows or re-sort tables. Option B (correct) VACUUM DELETE physically reclaims space occupied by rows marked for deletion, directly addressing "many deleted rows have not been reclaimed," and VACUUM SORT reorders data according to sort keys, directly addressing "tables are not sorted." Option C (incorrect) While reloading data can achieve similar results, it is a data loading operation and a highly inefficient and disruptive method for routine maintenance compared to using VACUUM. Option D (incorrect) This option describes a configuration to automate maintenance, not the specific maintenance operations themselves, and Redshift''s automation features might not cover all specific needs or configurations implied.'
WHERE question_id = '41941a19-b0a7-41bb-884d-3ca01ce754a6';

-- question_id: 420e50dc-00e0-4222-acd1-92b228b956dc
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Placing all instances in a single Availability Zone introduces a single point of failure at the AZ level, meaning an outage in that AZ would make the entire application unavailable, which contradicts the goal of eliminating single points of failure. Option 1 (incorrect) Manually restarting failed instances defeats the purpose of AWS Auto Scaling groups, which are designed to automatically detect and replace unhealthy instances without human intervention, and manual intervention does not inherently eliminate single points of failure. Option 2 (correct) Distributing instances across multiple Availability Zones ensures that the application remains available even if one AZ experiences an outage, while Auto Scaling groups continuously monitor instance health and automatically replace unhealthy instances, thereby eliminating single points of failure and providing high availability. Option 3 (incorrect) Relying on a single dedicated server is the definition of a single point of failure, as the failure of that one server would cause the entire application to become unavailable, directly opposing the principles of resilience and distributed system design in AWS.'
WHERE question_id = '420e50dc-00e0-4222-acd1-92b228b956dc';

-- question_id: 4274d879-4d99-4872-8f17-8d62a41953e7
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Higher costs are not a security advantage, and AWS managed services often lead to lower total cost of ownership by offloading operational burdens, including security, to AWS. Option B (correct) AWS managed services automatically handle the security patching and updates of the underlying infrastructure and ensure the service itself adheres to various compliance certifications, relieving customers of this burden. Option C (incorrect) Limited control over the underlying infrastructure is a characteristic of managed services, not a security advantage, as customers are trading granular control for the operational simplicity and security expertise provided by AWS. Option D (incorrect) Manual security updates are characteristic of self-managed infrastructure and are precisely what AWS managed services eliminate, as AWS takes responsibility for automatically applying security patches to the underlying service components.'
WHERE question_id = '4274d879-4d99-4872-8f17-8d62a41953e7';

-- question_id: 42bc4af9-906e-4ec5-ac62-8f44ab75c784
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Foundation models, while adept at understanding context, require explicit instructions for highly structured and consistent output formats like specific JSON schemas, as their default behavior prioritizes natural language generation over strict formatting without clear guidance. Option B (correct) This is the most effective prompt engineering technique for Amazon Bedrock models because explicitly defining the desired JSON schema and including a few-shot example provides unambiguous guidance, significantly increasing the model''s reliability in producing consistently structured outputs. Option C (incorrect) While a system prompt can influence the model''s behavior, merely emphasizing "structured data" without providing explicit formatting instructions or an example JSON schema is insufficient for consistently producing a specific JSON output from Amazon Bedrock. Option D (incorrect) While an AWS Lambda function can serve as a robust post-processing step for validating or transforming model outputs, it does not directly address the prompt engineering goal of ensuring the Amazon Bedrock model itself reliably produces the desired JSON format directly.'
WHERE question_id = '42bc4af9-906e-4ec5-ac62-8f44ab75c784';

-- question_id: 42c0a6af-745b-482d-95d1-75f97c14d7f9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Physical movement of servers is not model drift; AWS abstracts the underlying physical infrastructure from users and model drift relates to data and model performance, not hardware location. Option B (correct) Degradation of model performance over time is model drift, which occurs when real-world data diverges from the data the model was trained on, and AWS services like Amazon SageMaker Model Monitor are designed to detect this performance decay. Option C (incorrect) Network latency increase describes a delay in data transmission over a network, a separate operational concern that AWS Global Accelerator or Amazon CloudFront might address, distinct from a model''s predictive accuracy shifting. Option D (incorrect) Storage capacity reduction refers to running out of available storage space, a resource management issue AWS services like Amazon S3 and Amazon EBS are built to scale, unrelated to the internal predictive quality of an ML model.'
WHERE question_id = '42c0a6af-745b-482d-95d1-75f97c14d7f9';

-- question_id: 42ca09ce-b467-42ff-a735-ac59072162b7
-- answer_correct: True | verified_indices: [0] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon DynamoDB with DAX is purpose-built for microsecond latency for eventually consistent reads on high-throughput NoSQL data, directly addressing all requirements for user session data. Option B (incorrect) While ElastiCache Redis offers sub-millisecond latency and high availability, it would typically serve as a standalone cache or require application logic to manage caching for an underlying database, making it less optimal as a direct database acceleration strategy compared to DAX. Option C (incorrect) Amazon RDS with a write-through cache for ElastiCache would likely struggle to meet sub-millisecond latency requirements for high-traffic writes due to relational database overhead and is not optimized for eventual consistency. Option D (incorrect) Amazon Aurora with Global Database is primarily for global replication and disaster recovery, and its in-memory query caching is not designed for the ultra-low latency, high-volume, eventually consistent key-value lookups best handled by DAX.'
WHERE question_id = '42ca09ce-b467-42ff-a735-ac59072162b7';

-- question_id: 42e89e4b-2fa1-4928-be9f-fba2a1d8c792
-- answer_correct: True | verified_indices: [0, 1, 5] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Document retrieval is a key component, representing the "R" in RAG, where relevant information chunks are fetched from a knowledge base using vector similarity search, often facilitated by AWS services such as Amazon OpenSearch Service with vector engine or Amazon Aurora PostgreSQL with pgvector, or a managed service like Amazon Kendra. Option B (correct) Embedding generation is crucial as it converts both the user query and the source documents into numerical vector representations, enabling efficient semantic search for retrieval, utilizing services like Amazon Bedrock''s Titan Embeddings or custom models deployed on Amazon SageMaker. Option C (incorrect) While context integration is a vital step in preparing the prompt for the LLM by combining the retrieved documents with the user''s query, it is generally considered part of the augmentation phase leading to response generation rather than one of the three primary high-level components of the RAG pipeline. Option D (incorrect) Random selection is antithetical to the RAG pipeline''s purpose, which specifically aims to retrieve *semantically relevant* information to improve LLM responses, relying on sophisticated search algorithms rather than arbitrary choices. Option E (incorrect) Manual review for every query is not a fundamental component of an automated RAG pipeline, which is designed for scalable and efficient query processing, though human-in-the-loop processes might be implemented for quality assurance or specific edge cases. Option F (correct) Response generation is the "G" in RAG, where a Large Language Model processes the augmented prompt (user query combined with retrieved context) to formulate a coherent and informed answer, typically powered by models available through Amazon Bedrock or deployed via Amazon SageMaker JumpStart.'
WHERE question_id = '42e89e4b-2fa1-4928-be9f-fba2a1d8c792';

-- question_id: 42f1b53e-78fa-4a0b-bd07-21f6decd8dd0
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Moving from self-managed EC2 to Amazon RDS shifts more operational responsibility to AWS, reducing the customer''s burden for underlying infrastructure, operating system, and database software management. Option 1 (correct) Amazon RDS is a fully managed service where AWS assumes responsibility for automating tasks like database software patching, backups, point-in-time recovery, and underlying infrastructure maintenance. Option 2 (incorrect) The AWS Shared Responsibility Model clearly delineates different responsibilities for Infrastructure as a Service (IaaS) like EC2 versus Platform as a Service (PaaS) like RDS, meaning responsibilities are never identical between these service types. Option 3 (incorrect) While the customer remains responsible for "security in the cloud" aspects like data, application configuration, network security, and access control (IAM), AWS is responsible for "security of the cloud," which includes significant database security aspects like engine patching and infrastructure management.'
WHERE question_id = '42f1b53e-78fa-4a0b-bd07-21f6decd8dd0';

-- question_id: 42f547ec-8a03-4aa4-8f39-ef13440b237a
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Creating IAM users with access keys directly violates the security policy prohibiting the use of long-term IAM access keys, which are static credentials and a security risk if compromised. Option B (incorrect) Configuring S3 bucket policies by account ID is a necessary component for cross-account S3 access but does not alone provide a secure credential-free mechanism for workloads to obtain temporary access, as it doesn''t specify the principal or offer a method for dynamic credential acquisition. Option C (correct) Using cross-account IAM roles with trust relationships and STS AssumeRole is the AWS best practice for secure, programmatic cross-account access, as workloads in processing accounts assume a role in the data lake account to obtain temporary credentials, satisfying the no long-term access keys requirement. Option D (incorrect) AWS IAM Identity Center is primarily designed for human user access and federated identity management, not the most direct or common pattern for programmatic workloads requiring cross-account access to S3 buckets.'
WHERE question_id = '42f547ec-8a03-4aa4-8f39-ef13440b237a';

-- question_id: 4327da36-1c42-46b9-bc54-f3cd6cba21c9
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS Glue jobs assume an IAM role during execution, and by granting this role only the necessary S3 read/write permissions for specific buckets and Redshift data API or cluster access permissions for specific clusters, it strictly adheres to the least-privilege principle for the Glue service. Option B (incorrect) Attaching AdministratorAccess grants excessive permissions to the Glue job, violating the least-privilege principle and posing a significant security risk by allowing the job to perform actions far beyond its required scope. Option C (incorrect) While resource-based policies on S3 can complement identity-based policies, they are not the primary or most appropriate sole mechanism for granting cross-service permissions to a Glue service role, and Redshift access is primarily managed through IAM roles rather than resource-based policies. Option D (incorrect) Embedding IAM user access keys directly in Glue job parameters is a severe security anti-pattern, as it exposes long-lived credentials, complicates rotation, and bypasses the secure IAM role assumption mechanism designed for AWS services.'
WHERE question_id = '4327da36-1c42-46b9-bc54-f3cd6cba21c9';

-- question_id: 433efeaa-59a8-45ce-b585-704d33e7942c
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 server access logging provides basic access logs but does not inherently offer tamper-proofing through cryptographic validation and may not capture all denied API requests consistently for comprehensive audit needs. Option B (correct) AWS CloudTrail with S3 data events captures detailed successful and denied S3 API calls, including requester identity, source IP, timestamp, and objects accessed, while log file validation cryptographically ensures tamper-proofing, and logs stored in S3 can enforce 10-year retention with lifecycle policies. Option C (incorrect) VPC Flow Logs capture network traffic metadata (source/destination IP, port, protocol) but do not provide application-level details like the S3 object name, specific S3 API calls (e.g., GetObject, PutObject), or the IAM identity of the requester. Option D (incorrect) Application-level logging is inconsistent, prone to gaps, requires diligent implementation across all applications, and does not provide inherent tamper-proofing or a centralized, comprehensive audit trail required for regulatory compliance across an entire data lake.'
WHERE question_id = '433efeaa-59a8-45ce-b585-704d33e7942c';

-- question_id: 43b0ceb5-bf31-4fbb-affe-3b4894ca4d9e
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While AWS Backup offers robust automation, cross-service policies, and compliance monitoring, its managed nature may not provide the absolute level of granular control and bespoke customization required for extremely unique, niche, or highly specialized compliance standards and recovery procedures that explicitly call for custom verification beyond its predefined capabilities. Option B (correct) This architecture, despite its seemingly manual components, offers the highest degree of customization and granular control over backup, recovery, and verification processes for each individual service, enabling the implementation of bespoke scripting and tooling within "custom verification" to automate integrity testing, coordinate complex point-in-time recovery across diverse services, generate specific compliance reports, and derive highly accurate recovery time estimates tailored to very stringent or non-standard organizational recovery objectives. Option C (incorrect) Third-party backup solutions, despite AWS integration, introduce external dependencies, potential vendor lock-in, and an additional layer of complexity in managing cross-service consistency and deep customization compared to a solution built directly with AWS primitives and bespoke verification. Option D (incorrect) Custom backup scripts offer flexibility and automation but require significant operational overhead for maintenance, scalability, security, and especially the complex orchestration needed for truly integrated point-in-time recovery across multiple services, comprehensive verification, and compliance reporting without a robust underlying framework.'
WHERE question_id = '43b0ceb5-bf31-4fbb-affe-3b4894ca4d9e';

-- question_id: 4443e645-9ed2-4187-a9a9-e3596214175b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Migration Hub is a service that helps track the progress of application migrations across multiple AWS and partner solutions, focusing on the technical migration process rather than organizational skills assessment. Option B (correct) The AWS Cloud Adoption Framework (AWS CAF) includes a "People" perspective, which specifically helps organizations assess readiness, identify skills gaps, and plan training to prepare their workforce for cloud adoption. Option C (incorrect) The AWS Well-Architected Tool helps customers evaluate their workloads against AWS best practices across five pillars (Operational Excellence, Security, Reliability, Performance Efficiency, and Cost Optimization) to improve architectural design, not to identify human resource skills gaps. Option D (incorrect) AWS Cost Explorer is a tool that allows users to visualize, understand, and manage their AWS costs and usage over time, providing financial insights rather than guidance on skill development or training needs.'
WHERE question_id = '4443e645-9ed2-4187-a9a9-e3596214175b';

-- question_id: 44644889-3a30-49a8-9f45-008337a56396
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) EC2 instances in a cluster placement group provide the necessary low-latency, high-bandwidth interconnect between compute nodes, while FSx for Lustre offers a high-performance, shared file system optimized for throughput and low latency, ideal for large datasets in HPC workloads. Option B (incorrect) ECS with Fargate abstracts away the underlying infrastructure, preventing the granular control needed for specialized HPC configurations like low-latency interconnects, and EFS typically provides lower performance than FSx for Lustre for demanding HPC I/O. Option C (incorrect) Lambda functions are serverless, stateless, and event-driven, not designed for long-running, tightly coupled parallel computing with low-latency node communication, and S3 is object storage, not a high-speed POSIX-compliant shared file system. Option D (incorrect) While AWS Batch can manage compute jobs, this option lacks a suitable shared high-speed storage solution across compute nodes, as EBS volumes are typically single-instance attached and instance store is ephemeral and local to an instance.'
WHERE question_id = '44644889-3a30-49a8-9f45-008337a56396';

-- question_id: 44a6e7fc-77fd-4487-828f-4ee88a3099ba
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon SNS (Simple Notification Service) is a publish-subscribe messaging service used for sending notifications via various protocols including email, SMS, and push notifications, but it is not a dedicated email sending and receiving service for managing full email workflows or inbound email. Option B (incorrect) Amazon SQS (Simple Queue Service) is a message queuing service designed to decouple and scale microservices, distributed systems, and serverless applications, storing messages for processing and having no direct email sending or receiving capabilities. Option C (correct) Amazon SES (Simple Email Service) is a cloud-based email sending and receiving service that allows developers to send transactional email, marketing email, or any other type of high-volume email and also supports receiving inbound email for applications. Option D (incorrect) Amazon Connect is a cloud contact center service that helps businesses deliver customer service, primarily focused on voice, chat, and task management for customer interactions, and does not provide general-purpose email sending and receiving features for applications.'
WHERE question_id = '44a6e7fc-77fd-4487-828f-4ee88a3099ba';

-- question_id: 44f9bba6-2acf-461c-93ca-28a0c08eecd5
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Data transfer out to the internet typically incurs charges, as AWS charges for egress traffic from its network to external destinations across most services like EC2, S3, and RDS. Option B (incorrect) Data transfer between different AWS regions always incurs charges because it utilizes AWS''s backbone network across significant geographical distances. Option C (correct) Data transfer into AWS from the internet typically does not incur charges, as AWS generally provides free ingress data transfer to encourage users to bring data onto its platform. Option D (incorrect) Data transfer between different Availability Zones within the same AWS region typically incurs charges, as it utilizes AWS''s high-bandwidth, low-latency inter-AZ network infrastructure.'
WHERE question_id = '44f9bba6-2acf-461c-93ca-28a0c08eecd5';

-- question_id: 45225e16-31f2-4897-a221-0ec1fc3f0eea
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The maximum execution time for an AWS Lambda function was initially 5 minutes, but this limit has since been increased to accommodate a broader range of serverless use cases. Option B (incorrect) While the maximum execution time for an AWS Lambda function was increased to 10 minutes at an intermediate stage, it was further extended to provide even more flexibility for specific workloads. Option C (correct) The current maximum execution time for an AWS Lambda function is 15 minutes (900 seconds), allowing it to handle a wider variety of synchronous and asynchronous tasks without exceeding the service limit. Option D (incorrect) An execution time of 30 minutes exceeds the current maximum limit for AWS Lambda functions, as Lambda is optimized for short, event-driven compute and longer-running processes are typically better suited for services like AWS Step Functions integrating with AWS Fargate or EC2.'
WHERE question_id = '45225e16-31f2-4897-a221-0ec1fc3f0eea';

-- question_id: 4556cd90-43f7-467d-a269-cc8cb9b41abb
-- answer_correct: True | verified_indices: [1, 3] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The cost of Amazon Bedrock is not directly based on the number of users accessing the service, but rather on the usage metrics like tokens processed or provisioned throughput. Option B (correct) The primary cost factor for using Amazon Bedrock''s on-demand foundational models is the volume of input and output tokens processed by the models, which is a per-token charge. Option C (incorrect) Amazon Bedrock''s core service for model invocation does not directly charge for storage capacity in the same way services like Amazon S3 or Amazon EBS do; while related services like Knowledge Bases might use S3, the Bedrock inference cost itself is not tied to storage capacity. Option D (correct) Network bandwidth, specifically data transfer out from AWS to the internet or across regions, contributes to the overall cost of using Amazon Bedrock, similar to most AWS services. Option E (incorrect) Model training time is not a general cost factor for using pre-trained Amazon Bedrock models; while customization (fine-tuning) involves compute costs, the core Bedrock service for inference does not charge based on training time.'
WHERE question_id = '4556cd90-43f7-467d-a269-cc8cb9b41abb';

-- question_id: 4592bf26-8f5d-4268-be18-328c3871aa33
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The Security pillar focuses on protecting data and systems, managing access, and detecting security events using services like AWS IAM and AWS KMS, rather than primarily on recovering from disruptions or dynamic resource acquisition. Option B (incorrect) The Cost Optimization pillar focuses on avoiding unnecessary expenses, selecting appropriate resources, and maximizing business value through services like AWS Cost Explorer and Reserved Instances, not on system recovery or dynamic scaling for resilience. Option C (correct) The Reliability pillar focuses on ensuring a workload performs its intended function correctly and consistently, which includes the ability to recover from disruptions (e.g., using multi-AZ deployments or backup/restore strategies with services like AWS Backup) and dynamically acquire computing resources to meet demand and maintain availability (e.g., using Amazon EC2 Auto Scaling). Option D (incorrect) The Performance Efficiency pillar focuses on using computing resources efficiently to meet system requirements and maintain that efficiency as demand changes, selecting appropriate resource types, and monitoring performance using services like Amazon CloudWatch, but its primary emphasis is on effective resource scaling for performance, not specifically on recovery from failures.'
WHERE question_id = '4592bf26-8f5d-4268-be18-328c3871aa33';

-- question_id: 46048e09-454f-4386-82ec-a16890c3b9b4
-- answer_correct: True | verified_indices: [0, 1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Spot Instances are ideal for workloads that can tolerate interruptions, offering significant cost savings (up to 90%) by utilizing spare AWS capacity, perfectly matching the "can tolerate brief interruptions" requirement for cost optimization. Option B (correct) On-Demand instances allow the team to pay only for the exact hours (10 hours per day on weekdays) that the resources are consumed, providing flexibility and cost efficiency by avoiding long-term commitments for intermittent usage. Option C (incorrect) Standard Reserved Instances are designed for continuous 24/7 usage, and purchasing them for a workload running only 10 hours per day on weekdays would lead to paying for a large number of unused hours. Option D (incorrect) Scheduled Reserved Instances are for predictable recurring workloads but typically offer lower discounts compared to Spot Instances and still require a 1-year commitment, making them less optimal for maximum cost savings when interruptions are tolerable. Option E (incorrect) Savings Plans require a 1-year or 3-year commitment to a consistent compute spend, which would result in paying for many unused hours given the workload''s limited 10-hour daily, weekday-only schedule.'
WHERE question_id = '46048e09-454f-4386-82ec-a16890c3b9b4';

-- question_id: 46389502-72ca-4fbd-9b10-96229eb0d212
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Manually launching an instance does not meet the requirement for automatically replacing the unhealthy instance. Option B (correct) Configuring an Amazon CloudWatch Alarm on instance status checks to trigger EC2 Auto Recovery is the specific AWS feature designed to automatically recover an instance by migrating it to new healthy hardware when underlying host issues or OS crashes cause instance status checks to fail, preserving the instance''s configuration and attributes. Option C (incorrect) While EventBridge can detect events, directly terminating and launching a new instance via an EventBridge rule would require custom automation logic and would be a more complex solution compared to the purpose-built EC2 Auto Recovery feature for this scenario. Option D (incorrect) Using AWS Systems Manager Automation to merely reboot the instance will not address an operating system crash severe enough to cause instance status check failures, as these failures often indicate underlying host issues, and the requirement is to replace the instance, not just reboot it.'
WHERE question_id = '46389502-72ca-4fbd-9b10-96229eb0d212';

-- question_id: 4651605b-e298-463e-919b-289778623798
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) AWS Glue Workflows are purpose-built for orchestrating Glue jobs with dependencies, offering visual definition, monitoring, and failure handling as a fully managed service, directly meeting all requirements for simplicity and managed infrastructure. Option B (incorrect) Scheduling each AWS Glue ETL job independently using Amazon EventBridge cron expressions would not establish dependencies, meaning downstream jobs could run before upstream jobs complete, leading to data inconsistencies and processing errors. Option C (incorrect) While AWS Step Functions can orchestrate AWS Glue jobs and handle dependencies, they introduce more complexity than necessary for a straightforward sequential workflow of only Glue jobs, making them less "simple" than Glue Workflows for this specific scenario. Option D (incorrect) Writing custom shell scripts to invoke AWS Glue ETL jobs sequentially would require managing the underlying infrastructure to run the scripts, developing custom logic for dependency, monitoring, and error handling, which contradicts the requirement of "without managing additional orchestration infrastructure" and seeking a "simple way."'
WHERE question_id = '4651605b-e298-463e-919b-289778623798';

-- question_id: 4667afda-d55d-451a-930e-8b189a12d2b5
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) More efficient computation by activating only relevant parts. In Amazon SageMaker, algorithms like Factorization Machines efficiently handle sparse input features, processing only the non-zero feature interactions, which significantly reduces computational load during training and inference on instances like those powered by AWS Inferentia or AWS Trainium. Option B (incorrect) Using all parameters always. This statement describes dense models, which, when deployed on Amazon SageMaker for inference, would require all model parameters to be loaded and processed for every input, leading to higher memory and computational requirements compared to a sparse model. Option C (incorrect) Lower accuracy. Sparse models can often achieve comparable or even superior accuracy compared to dense models, especially when applied to high-dimensional data on Amazon SageMaker, as the inherent sparsity can act as a regularization mechanism preventing overfitting. Option D (incorrect) Simpler training. Training sparse models can sometimes be more complex due to the need for specialized data structures, optimizers, and distributed training techniques to handle the sparse representations efficiently, which might require more intricate configurations on Amazon SageMaker compared to training a standard dense model.'
WHERE question_id = '4667afda-d55d-451a-930e-8b189a12d2b5';

-- question_id: 466a72b8-faa1-4f72-9ea0-0db08c46b981
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Rehosting, often called "lift and shift," involves moving an application to AWS EC2 with minimal or no changes to its architecture, which does not align with breaking it into microservices. Option B (incorrect) Replatforming involves making minor cloud-specific optimizations, such as migrating a database to Amazon RDS, without fundamentally re-architecting the application into microservices. Option C (correct) Refactoring, also known as re-architecting, involves significantly modifying an application''s architecture to take full advantage of cloud-native features, such as breaking a monolithic application into microservices deployed on AWS Lambda or Amazon ECS. Option D (incorrect) Repurchasing involves replacing an existing application with a new cloud-based SaaS solution, such as moving from an on-premises CRM to Salesforce, rather than re-architecting the existing application into microservices.'
WHERE question_id = '466a72b8-faa1-4f72-9ea0-0db08c46b981';

-- question_id: 467edc38-da6b-4573-9142-67b05b793790
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increasing SQS visibility timeout merely gives existing processors more time for long-running tasks and delays redelivery in case of failure, while longer message retention prevents message loss but neither scales compute resources nor speeds up message processing to handle backlogs. Option B (correct) Using Auto Scaling for EC2 worker instances based on SQS queue depth metric directly scales the processing capacity by adding or removing workers dynamically, effectively handling variable message volumes and reducing queue backlogs for compute-intensive tasks. Option C (incorrect) Deploying Lambda functions with a maximum timeout might work for some tasks, but 5-15 minute compute-intensive tasks push the practical and cost-effective limits of Lambda''s 15-minute maximum runtime, making EC2-based solutions generally more suitable for such long-running, dedicated workloads. Option D (incorrect) Implementing SQS long polling improves the efficiency of message retrieval by reducing empty receives and API calls, but it does not increase the rate at which messages are processed or scale the underlying compute resources to address queue backlogs.'
WHERE question_id = '467edc38-da6b-4573-9142-67b05b793790';

-- question_id: 46fa6054-3ac8-49ec-a621-145bc5174ccb
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) Executing HDFS balancer redistributes existing data blocks evenly across DataNodes to balance storage utilization, but it does not free up any disk space or reduce the total number of small files on the cluster. Option B (incorrect) Running hdfs fsck checks for filesystem health and corruption, but the problem describes high HDFS usage from temporary files, not data integrity issues, so it would not restore performance in this scenario. Option C (correct) Cleaning Spark temporary directories and shuffle files from HDFS directly addresses the root cause of the degraded performance by freeing up significant disk space, reducing the millions of small files that stress the HDFS NameNode, and resolving the accumulation of shuffle outputs. Option D (incorrect) Increasing the HDFS replication factor would consume even more disk space, as it requires storing additional copies of data blocks, thereby worsening the problem of a nearly full HDFS cluster.'
WHERE question_id = '46fa6054-3ac8-49ec-a621-145bc5174ccb';

-- question_id: 476a11b2-de69-48bc-80e9-ce45af1b9894
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Kinesis Data Streams adds an additional real-time streaming layer and cost that is not strictly necessary when Kinesis Data Firehose with an integrated Lambda transform can handle the ingestion and enrichment more cost-effectively directly. Option B (correct) Kinesis Data Firehose''s built-in Lambda transform feature is specifically designed to perform inline record processing and enrichment from sources like DynamoDB before efficient batch delivery to S3, optimizing both latency and cost. Option C (incorrect) AWS Glue Streaming ETL jobs typically introduce higher latency and cost for continuous operations compared to Kinesis Data Firehose for this type of real-time clickstream enrichment. Option D (incorrect) SQS is a message queue, not a streaming data platform, and is unsuitable for the high-throughput, low-latency ingestion of clickstream events required by the problem statement.'
WHERE question_id = '476a11b2-de69-48bc-80e9-ce45af1b9894';

-- question_id: 4834b58c-5c58-4f12-8198-dd0287e717eb
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Fine-tuning directly modifies the model’s internal weights, allowing it to learn and internalize domain-specific language patterns, specialized vocabulary, and stylistic nuances, such as when using Amazon Bedrock to fine-tune a foundation model on a proprietary dataset. Option B (incorrect) RAG is preferable when external data changes frequently because new information can be quickly ingested into a vector database (e.g., Amazon OpenSearch Service or Amazon Aurora with pgvector) and retrieved, whereas fine-tuning requires a time-consuming and costly retraining process. Option C (incorrect) RAG solutions, especially those leveraging Amazon Bedrock Knowledge Bases integrated with Amazon S3 or other data sources, can generally be deployed more quickly than fine-tuning, which involves dataset preparation, extensive training (potentially hours or days), and model deployment. Option D (incorrect) RAG offers a simpler form of customization by grounding responses in specific external documents, suitable when minimal modification to the model''s inherent knowledge or style is needed, whereas fine-tuning represents a much deeper and more resource-intensive customization.'
WHERE question_id = '4834b58c-5c58-4f12-8198-dd0287e717eb';

-- question_id: 48b96b64-c5d0-44e6-912a-5355d200b334
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) A single Availability Zone deployment represents a single point of failure; if that specific AZ experiences an outage, the entire application would become unavailable, failing to meet the fundamental principles of high availability. Option B (correct) Deploying across a minimum of two Availability Zones provides redundancy and fault tolerance, allowing services like Elastic Load Balancing (ELB) and Auto Scaling Groups to distribute traffic and instances across separate, isolated locations within a region, ensuring the application remains available if one AZ fails. Option C (incorrect) While deploying across three Availability Zones offers enhanced resilience and is often preferred for quorum-based services like Amazon RDS Multi-AZ or specific distributed systems requiring a majority for writes, it exceeds the *minimum* recommendation for general high availability, which can be achieved with two AZs. Option D (incorrect) Deploying across four Availability Zones provides an exceptionally high level of fault tolerance but is generally considered over-provisioning for the *minimum* high availability requirement, adding unnecessary cost and management complexity without being strictly necessary for the baseline definition of high availability.'
WHERE question_id = '48b96b64-c5d0-44e6-912a-5355d200b334';

-- question_id: 48e98177-9293-43f5-aac0-9f00c85e55ad
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Database changes, such as those captured by DynamoDB Streams, can indeed trigger Lambda functions, but they are not the sole type of event that can do so. Option B (correct) S3 events (e.g., object uploads or deletions), API calls (via Amazon API Gateway), and scheduled events (configured through Amazon EventBridge) are all common and well-supported event sources for AWS Lambda functions. Option C (incorrect) While Lambda functions can be manually invoked via the AWS Management Console, CLI, or SDK, they are primarily designed for event-driven automation triggered by other services, making manual triggers not the exclusive method. Option D (incorrect) Lambda functions are triggered by specific events originating from various AWS services or custom applications rather than by generic network events, and this option incorrectly implies exclusivity.'
WHERE question_id = '48e98177-9293-43f5-aac0-9f00c85e55ad';

-- question_id: 4911c766-c220-4633-ac41-3c30941dfec4
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Temporary credentials, by their very nature, are designed for short-term access and have a limited lifespan, directly contradicting the concept of permanent access. Option B (incorrect) All temporary credentials issued by AWS Security Token Service (STS) or assumed by IAM roles are time-limited and have a mandatory expiration period, a core security feature to mitigate the risk of compromised credentials. Option C (correct) Temporary credentials issued through IAM roles have a defined expiration time, and upon expiration, they are automatically invalidated, requiring a new set of unique credentials to be issued, which acts as an automatic rotation mechanism without manual intervention. Option D (incorrect) A major benefit of using temporary credentials with IAM roles is the reduction or elimination of manual credential management, as AWS services or SDKs automatically handle the acquisition and refresh of these credentials, in contrast to managing long-lived access keys.'
WHERE question_id = '4911c766-c220-4633-ac41-3c30941dfec4';

-- question_id: 49ee50fd-6e48-4418-a936-ab8f1d8eafb3
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) ANALYZE updates table statistics to optimize query plans, which can improve query performance, but it does not reclaim disk space from undropped temporary tables or deleted rows. Option B (correct) VACUUM DELETE explicitly reclaims disk space from rows marked for deletion, directly addressing the issue of unreclaimed deleted rows, and general VACUUM operations, including VACUUM SORT, are fundamental Redshift maintenance mechanisms for optimizing disk usage and reclaiming space from fragmentation or blocks freed by dropped tables. Option C (incorrect) UNLOAD exports data and reloading it into new tables, while it would reclaim space and reorganize data, is a complex, highly disruptive, and inefficient workaround compared to dedicated VACUUM operations, and it is not a standard maintenance operation for these issues. Option D (incorrect) Enabling automatic VACUUM and ANALYZE through Redshift cluster configuration is a best practice for ongoing cluster health and future prevention, but it does not immediately resolve the existing accumulated backlog of undropped temporary tables or the large amount of unreclaimed deleted rows.'
WHERE question_id = '49ee50fd-6e48-4418-a936-ab8f1d8eafb3';

-- question_id: 4a52b18e-78fe-487a-a065-f2d89c06ca3f
-- answer_correct: True | verified_indices: [1, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While EventBridge Scheduler can trigger nightly and SNS can notify, it lacks native features for orchestrating complex sequences of 15 dependent jobs with parallel execution paths or a visual interface to monitor the overall pipeline''s flow. Option B (correct) Apache Airflow (MWAA) is purpose-built for scheduling complex data pipelines using DAGs, allowing for specific sequencing, parallel execution, built-in failure notifications, and a rich visual UI for monitoring job execution. Option C (correct) AWS Step Functions provides robust orchestration capabilities with sequential, parallel, and choice states for complex workflows, integrates with EventBridge for nightly scheduling, supports SNS for notifications, and offers a visual console for design and real-time execution monitoring. Option D (incorrect) While AWS Glue workflows can orchestrate dependent jobs and provide visual monitoring, they are primarily optimized for ETL pipelines leveraging AWS Glue jobs, making them less ideal as a general-purpose orchestrator for diverse job types compared to Step Functions or Airflow. Option E (incorrect) AWS Batch supports job dependencies and notifications, but it primarily manages compute for batch jobs and does not offer a dedicated visual interface for monitoring the overall execution flow and status of a complex, multi-job pipeline as a single entity.'
WHERE question_id = '4a52b18e-78fe-487a-a065-f2d89c06ca3f';

-- question_id: 4a6d0cb3-adb3-490b-a901-d123006c1ef0
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS primarily offers a pay-as-you-go model, not fixed pricing, which means costs scale with usage rather than being fixed, providing flexibility for experimentation. Option B (incorrect) Manual provisioning is a time-consuming and error-prone process that would slow down experimentation, whereas AWS promotes automation through services like AWS CloudFormation for rapid deployment. Option C (correct) The ability to provision and de-provision resources like Amazon EC2 instances or Amazon S3 buckets quickly, and pay only for what you use, significantly reduces the financial risk and cost associated with testing new ideas and iterating rapidly. Option D (incorrect) AWS abstracts away the underlying physical infrastructure, meaning users do not have direct physical server access, which is a characteristic of on-premises environments, not a cloud benefit for rapid innovation.'
WHERE question_id = '4a6d0cb3-adb3-490b-a901-d123006c1ef0';

-- question_id: 4b6a5dcb-ea9b-43ad-8daf-a355f9bd467d
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Session Manager provides interactive shell access to instances, not for automating recurring operational tasks with pre-defined or custom scripts. Option B (incorrect) Parameter Store is used for storing configuration data and secrets, not for executing scripts or automating operational tasks. Option C (correct) Systems Manager Automation runbooks are designed to define and execute automated workflows for operational tasks, including stopping/starting instances and applying patches, using pre-defined or custom scripts. Option D (incorrect) State Manager is used to maintain a consistent configuration (desired state) for instances, rather than orchestrating multi-step operational workflows with pre-defined or custom scripts like stopping and starting instances.'
WHERE question_id = '4b6a5dcb-ea9b-43ad-8daf-a355f9bd467d';

-- question_id: 4b881bf3-07aa-4f9b-b0f6-0a83e71864ef
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While security often involves trade-offs, such as balancing stringent AWS IAM policies and multi-factor authentication with user convenience, the Security pillar primarily focuses on applying controls, managing identity, and mitigating risks, rather than providing the overarching framework for general trade-off decision-making across all aspects. Option B (correct) Operational Excellence focuses on running and monitoring systems, and continually improving processes and procedures, which inherently requires making informed decisions about trade-offs, such as balancing the investment in automation (e.g., using AWS Systems Manager or AWS CodePipeline for CI/CD) against the benefits of reduced manual errors, faster deployments, and improved consistency. Option C (incorrect) Performance Efficiency focuses on using computing resources efficiently to meet system requirements, which includes making trade-offs (e.g., choosing between different EC2 instance types for optimal performance-to-cost ratio or leveraging Amazon RDS read replicas for scaling), but this pillar specifically addresses resource utilization, not the general organizational approach to making informed trade-off decisions across all areas. Option D (incorrect) Cost Optimization directly involves making trade-offs (e.g., using EC2 Savings Plans for lower compute costs in exchange for commitment, or selecting S3 Intelligent-Tiering to automate cost savings based on access patterns), but this pillar is specifically focused on financial efficiency rather than the broader principle of informed decision-making for all types of trade-offs.'
WHERE question_id = '4b881bf3-07aa-4f9b-b0f6-0a83e71864ef';

-- question_id: 4bb70d0f-0895-48ec-8a0c-5f1ca86801f0
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] (incorrect) Permanent free access to all AWS services is incorrect because the AWS Free Tier has specific usage limits and is typically available for a limited time (e.g., 12 months from account creation for many services), not permanently or for all AWS offerings. Option [1] (correct) Limited free usage of select AWS services for new customers accurately describes the AWS Free Tier, allowing new users to experiment with services like Amazon EC2, Amazon S3, and AWS Lambda up to certain thresholds for a defined period. Option [2] (incorrect) Enterprise support at no cost is incorrect because AWS Enterprise Support is a premium, paid support plan designed for large-scale operations with dedicated technical account managers, not a free offering. Option [3] (incorrect) Unlimited free storage is incorrect because the AWS Free Tier for storage services like Amazon S3 provides a specific, limited amount of free storage (e.g., 5GB of Standard Storage) for a defined period, not unlimited capacity.'
WHERE question_id = '4bb70d0f-0895-48ec-8a0c-5f1ca86801f0';

-- question_id: 4bba9427-00b1-4896-b474-340188ae0a63
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Accuracy can be misleading with imbalanced classes because a model might achieve high accuracy by simply predicting the majority class, which would be an undesirable outcome for models trained using Amazon SageMaker for critical tasks where detecting the minority class is important, such as fraud detection. Option B (correct) F1 Score is the harmonic mean of precision and recall, making it robust for imbalanced datasets as it balances the identification of true positives (recall) with the avoidance of false positives (precision), a crucial consideration when deploying models via Amazon SageMaker Endpoints where both types of errors have different costs. Option C (incorrect) Mean Squared Error is primarily used for regression problems to measure the average squared difference between predicted and actual continuous values, and it is not suitable for evaluating the performance of classification models, which predict discrete classes, whether trained with Amazon SageMaker''s built-in classification algorithms or custom models. Option D (incorrect) R-squared (coefficient of determination) is a regression metric that indicates the proportion of the variance in the dependent variable that is predictable from the independent variable(s) and is entirely inappropriate for assessing the performance of a classification model, which aims to categorize data rather than explain variance, a distinction well understood when selecting evaluation metrics in Amazon SageMaker Model Monitor.'
WHERE question_id = '4bba9427-00b1-4896-b474-340188ae0a63';

-- question_id: 4be05f96-38ba-4536-b284-b77812f9b4bc
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Rekognition is a pre-trained computer vision service that analyzes images and videos, but it does not provide functionality to label raw training data for custom machine learning models. Option B (correct) Amazon SageMaker Ground Truth is a data labeling service that helps build high-quality training datasets for machine learning by utilizing human annotators and offering automatic data labeling capabilities using active learning. Option C (incorrect) Amazon Comprehend is a natural language processing (NLP) service that extracts insights from text, rather than a service designed to label general training data for machine learning models. Option D (incorrect) Amazon Textract is an optical character recognition (OCR) service that automatically extracts text and data from documents, but it is not used for labeling training data for machine learning.'
WHERE question_id = '4be05f96-38ba-4536-b284-b77812f9b4bc';

-- question_id: 4bf6d3f9-b0df-40b8-834d-47d45d753512
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Spot Instances allow you to bid on unused EC2 capacity, meaning their price fluctuates based on market demand and they can be interrupted, thus not offering a fixed hourly rate. Option 1 (incorrect) Reserved Instances require a commitment for a 1-year or 3-year term, often involving significant upfront payments or a consistent monthly commitment, which contradicts the "no upfront costs" requirement. Option 2 (correct) On-Demand Instances allow you to pay a fixed hourly or per-second rate for your compute capacity with no long-term commitments or upfront payments, making them ideal for flexible workloads. Option 3 (incorrect) While Dedicated Hosts can be purchased On-Demand hourly without upfront costs, this option provides an entire physical server for specific licensing requirements, making it a specialized and typically much more expensive offering compared to general instance pricing models.'
WHERE question_id = '4bf6d3f9-b0df-40b8-834d-47d45d753512';

-- question_id: 4c16a09d-d604-4f73-a507-44df895e4183
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using video_id as the partition key would group events by content, meaning all events for a specific video would go to the same shard, but events from a single user interacting with multiple videos would be split across different shards, thus failing to guarantee per-user sequential processing for session state. Option B (incorrect) Using timestamp as the partition key would likely distribute events very widely across shards, as different events from the same user would have different timestamps, preventing Kinesis Data Streams from grouping all events from a single user onto the same shard for sequential processing. Option C (correct) Using user_id as the partition key is the correct approach because Kinesis Data Streams guarantees that all data records with the same partition key are routed to the same shard, which ensures that all events for a specific user are processed sequentially within that shard, enabling downstream analytics to maintain per-user session state. Option D (incorrect) Using a random UUID as the partition key for each event would achieve a uniform distribution but would cause events from the same user to be spread across multiple shards, completely negating the ability to process them sequentially and maintain session state for that user.'
WHERE question_id = '4c16a09d-d604-4f73-a507-44df895e4183';

-- question_id: 4c6ea14c-492c-4627-9c4b-4cb63ab835a3
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Cost Explorer provides tools to analyze and visualize your costs and usage after they have occurred, rather than estimating costs before deployment. Option B (incorrect) AWS Cost and Usage Reports deliver highly granular data about your costs and usage after resources are consumed, which is useful for detailed analysis but not for pre-deployment estimation. Option C (correct) AWS Pricing Calculator is specifically designed to help users estimate the costs of AWS services and solutions before deployment by allowing them to model various configurations. Option D (incorrect) AWS Budgets allows you to set custom thresholds and receive alerts for your actual or forecasted spend to manage costs after resources are deployed, not for initial pre-deployment estimation.'
WHERE question_id = '4c6ea14c-492c-4627-9c4b-4cb63ab835a3';

-- question_id: 4ce4f991-94bf-4bac-bd75-83939923a9b4
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) because Amazon Bedrock Agents are specifically designed to extend the capabilities of foundation models by enabling them to perform multi-step tasks, connect to enterprise systems like databases and APIs using tools (Lambda functions or API schemas), and fulfill user requests expressed in natural language by planning and executing a sequence of actions. Option B (incorrect) because Amazon Bedrock Knowledge Bases are used to ground foundation models with company-specific data for Retrieval Augmented Generation (RAG), enabling them to answer questions based on proprietary information, rather than orchestrating multi-step actions or interacting with external APIs for updates. Option C (incorrect) because Amazon Bedrock Model Evaluation is a tool for assessing the performance of foundation models using various metrics and datasets, which is unrelated to automating complex business workflows or orchestrating tasks. Option D (incorrect) because Amazon Bedrock Guardrails are used to implement safety policies and content filtering for foundation models, ensuring interactions align with company guidelines and preventing unsafe content, rather than automating or orchestrating multi-step operational tasks.'
WHERE question_id = '4ce4f991-94bf-4bac-bd75-83939923a9b4';

-- question_id: 4cf00352-1d92-42ff-a4c9-4c7acc22aabf
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) ApplyMapping transformation is used to map existing fields to a new schema, rename fields, or change data types, but it does not inherently unnest arrays or create multiple related tables from a single deeply nested structure. Option B (correct) The Relationalize transformation in AWS Glue is specifically designed to flatten deeply nested, hierarchical data, such as JSON with arrays, into multiple related tables, automatically inferring and creating primary and foreign keys to preserve relationships, which is ideal for loading into a relational database like Amazon Redshift. Option C (incorrect) While custom PySpark code using `explode` and `struct` functions can technically flatten nested data, the Relationalize transformation is an AWS Glue-native, high-level abstraction specifically built to perform this complex task automatically, including generating relational tables with inferred keys, which is more efficient and less error-prone than manual PySpark for this exact scenario. Option D (incorrect) ResolveChoice transformation is used to resolve ambiguous data types within a DynamicFrame, for instance, when a field can sometimes be a string and other times an integer, and does not perform any flattening or relationalization of nested structures.'
WHERE question_id = '4cf00352-1d92-42ff-a4c9-4c7acc22aabf';

-- question_id: 4cfca0d2-9382-47e0-8928-7738e2cf886a
-- answer_correct: True | verified_indices: [1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) EMR managed scaling dynamically adjusts the number of instances during job execution to optimize costs for the active period, but it does not address the primary cost driver of the cluster running continuously for 18 hours daily when no jobs are active. Option 1 (correct) Deploying transient EMR clusters that launch specifically for the 6-hour job window and terminate upon completion directly eliminates the cost of the cluster running for 18 hours daily when it is idle, resulting in the maximum possible cost reduction by only paying for the compute resources when they are actively processing data. Option 2 (incorrect) Migrating to Glue Spark jobs would provide cost savings through a serverless, pay-as-you-go model, but it involves re-platforming the existing jobs and may not offer a greater percentage cost reduction than simply running the current EMR cluster only when needed. Option 3 (incorrect) Switching to EMR on EKS with Kubernetes autoscaling can optimize resource utilization during active periods and potentially scale down EKS worker nodes, but it adds significant operational complexity and does not offer a more straightforward or necessarily greater cost reduction for eliminating idle cluster time compared to deploying transient EMR clusters.'
WHERE question_id = '4cfca0d2-9382-47e0-8928-7738e2cf886a';

-- question_id: 4d08ffab-3a75-4ec0-8959-79153a237b4d
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) A public cloud, like AWS, makes computing resources available over the internet to the general public or a large industry group, but it does not inherently combine on-premises infrastructure with AWS services as a deployment model itself. Option 1 (incorrect) A private cloud is infrastructure operated solely for a single organization, which can be managed on-premises or by a third party, but it does not intrinsically combine with external AWS cloud services as part of its fundamental definition. Option 2 (correct) A hybrid cloud deployment model seamlessly integrates on-premises infrastructure with AWS cloud services, allowing data and applications to be shared and moved between the two environments, often facilitated by services like AWS Direct Connect or Site-to-Site VPN. Option 3 (incorrect) A community cloud shares infrastructure among several organizations from a specific community with shared concerns, such as security or compliance requirements, but it does not specifically define a model that combines on-premises infrastructure with AWS cloud services.'
WHERE question_id = '4d08ffab-3a75-4ec0-8959-79153a237b4d';

-- question_id: 4d22de85-2cac-4586-9aa2-e31c4f35c75e
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) This combination of AWS CodeCommit for source control, AWS CodeBuild for automated building and testing, AWS CodePipeline for orchestrating the entire release process, and AWS CloudFormation for infrastructure as code deployments represents the standard AWS best practice for building a robust, automated, and scalable CI/CD pipeline, directly addressing all stated goals including version control, automated testing, seamless deployment, and reducing manual errors. Option B (incorrect) Manually uploading code via the AWS Management Console is a manual process that directly contradicts the goals of automation, reducing manual errors, and accelerating release cycles inherent in a CI/CD pipeline. Option C (incorrect) While a local Git repository provides version control, relying solely on custom shell scripts for deployment lacks the managed orchestration, integrated testing, advanced deployment strategies, and inherent robustness of a fully managed CI/CD service like AWS CodePipeline and CodeBuild, making it less scalable and more error-prone for a production environment. Option D (incorrect) Using Amazon S3 to store different versions of scripts offers artifact storage but does not provide source code version control features like branching and merging, nor does it automate the testing, deployment, or orchestration aspects of a CI/CD pipeline, instead relying on manual updates which is contrary to the stated goals.'
WHERE question_id = '4d22de85-2cac-4586-9aa2-e31c4f35c75e';

-- question_id: 4d3f7e12-1137-499a-b74a-040a180b307d
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) Chain-of-Thought (CoT) prompting is best suited because it explicitly instructs Amazon Bedrock''s foundation models, such as those from Anthropic or AI21 Labs, to break down complex problems into intermediate, visible steps, thereby revealing the model''s reasoning process and ensuring transparency and accuracy. Option B (incorrect) Zero-shot prompting relies on the model inferring the entire multi-step reasoning process and output format from the initial query alone, which is unlikely to consistently produce detailed, transparent reasoning steps without explicit guidance for complex scientific analysis on Amazon Bedrock. Option C (incorrect) One-shot prompting provides only a single example of the desired input-output pair, which might guide the final output format but typically does not explicitly detail or compel the model to show its step-by-step reasoning process for transparency when using models on Amazon Bedrock. Option D (incorrect) Using a very long context window for all scientific papers on Amazon Bedrock allows the model to access more information, but it does not inherently instruct the model to perform or articulate a specific multi-step reasoning process; it addresses data availability, not the methodology or transparency of reasoning.'
WHERE question_id = '4d3f7e12-1137-499a-b74a-040a180b307d';

-- question_id: 4e0271eb-e2b7-4a1e-babe-4b4681fb7c7f
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon EC2 requires users to provision and manage virtual servers, including operating system patches and scaling, which directly contradicts the requirement of "without managing servers." Option B (correct) AWS Lambda is a serverless compute service that automatically runs code in response to events, with AWS fully managing the underlying infrastructure like servers, operating systems, and scaling, thereby meeting the "without managing servers" criteria. Option C (incorrect) Amazon ECS is a container orchestration service that can run containers on EC2 instances, or on AWS Fargate which is a serverless compute engine for containers, but ECS itself is not solely serverless and often involves managing underlying EC2 server capacity. Option D (incorrect) AWS Batch is designed for running large-scale batch computing jobs and manages the provisioning of compute resources like EC2 instances for those jobs, meaning it still relies on and provisions servers, rather than being truly serverless in the way Lambda is for general code execution.'
WHERE question_id = '4e0271eb-e2b7-4a1e-babe-4b4681fb7c7f';

-- question_id: 4e1a28a2-2714-4a48-a6cb-8699d6eb8bdb
-- answer_correct: True | verified_indices: [2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deleting an IAM user does not immediately revoke active sessions, and recreating the user is not the fastest first response to a compromise as existing sessions may persist until their token expiration. Option B (incorrect) Changing the user password and enabling MFA only prevents future sign-ins using the old password or without MFA, but does not revoke active sessions that were established prior to these changes. Option C (correct) Attaching an IAM policy that explicitly denies all actions for the compromised user immediately takes precedence over any existing allow policies, thereby effectively revoking all permissions for any active session and preventing new harmful actions in real-time for all subsequent API calls. Option D (incorrect) Removing all IAM policies attached to the user revokes permissions but does not immediately or explicitly revoke active sessions in the same real-time and forceful manner as an explicit deny policy.'
WHERE question_id = '4e1a28a2-2714-4a48-a6cb-8699d6eb8bdb';

-- question_id: 4ea3ec97-cc78-4df3-a95f-2e3b4efec019
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) While some managed services might have a higher hourly rate than self-managing an open-source solution, the total cost of ownership often decreases significantly due to eliminating infrastructure maintenance, patching, and dedicated operational staff costs, as seen with services like Amazon RDS versus self-hosting a database on EC2. Option B (incorrect) AWS managed services intentionally abstract away the underlying infrastructure, meaning AWS takes responsibility for patching, scaling, and maintenance of the servers, as exemplified by Amazon S3 where users interact with objects and buckets, not the physical storage servers. Option C (correct) This is the main advantage, as AWS handles undifferentiated heavy lifting such as patching, backups, replication, and scaling for services like Amazon RDS, Amazon DynamoDB, and Amazon S3, allowing customers to focus on their core application development and business logic. Option D (incorrect) AWS managed services are typically designed for simplicity and quick provisioning, often requiring just a few clicks in the AWS Management Console or a single API call to launch a fully functional service like an Amazon S3 bucket or an Amazon RDS database instance, greatly simplifying deployment compared to setting up infrastructure from scratch.'
WHERE question_id = '4ea3ec97-cc78-4df3-a95f-2e3b4efec019';

-- question_id: 4efb01a0-68c5-4f32-8814-d3a65f9a2cdc
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Bagging algorithms, such as Random Forests, train multiple base models independently and in parallel on bootstrapped subsets of data, which can be efficiently distributed across multiple instances in Amazon SageMaker, while boosting algorithms like XGBoost, a popular built-in algorithm in SageMaker, train models sequentially, with each new model attempting to correct the errors of the previous ones. Option B (incorrect) While bagging methods train models in parallel to reduce variance, leveraging AWS compute resources, boosting algorithms fundamentally train models sequentially, with each subsequent model focusing on the errors made by its predecessors. Option C (incorrect) While boosting algorithms, such as those implemented with SageMaker''s XGBoost, train models sequentially, bagging algorithms, like Random Forests that can be deployed on AWS, explicitly train their constituent models in parallel to achieve robustness and reduce overfitting. Option D (incorrect) Both bagging (e.g., Random Forests) and boosting (e.g., XGBoost), both of which can be implemented or leveraged via Amazon SageMaker, are ensemble learning techniques that inherently involve combining the predictions from multiple individual models to improve overall predictive performance.'
WHERE question_id = '4efb01a0-68c5-4f32-8814-d3a65f9a2cdc';

-- question_id: 4f042431-67d5-477f-9c7b-e3d5ac7a8c42
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Few-shot learning requires providing a small number of examples within the prompt to guide the model''s response, which contradicts the condition of having no examples, as seen when using Amazon Bedrock with foundational models where examples demonstrate the desired output format. Option B (correct) Zero-shot learning is the technique where only the task description and instructions are given to the large language model without any specific examples, directly addressing tasks where no examples are provided, common when interacting with Amazon Titan Text models in Bedrock. Option C (incorrect) Multi-shot learning is not a standard, distinct prompt engineering term; rather, providing multiple examples falls under the umbrella of few-shot learning, which still necessitates examples, unlike the scenario presented. Option D (incorrect) Transfer learning is a machine learning concept where a model pre-trained on one task is adapted for a new, related task, often through fine-tuning on a specific dataset using services like AWS SageMaker, and is not a prompt engineering technique.'
WHERE question_id = '4f042431-67d5-477f-9c7b-e3d5ac7a8c42';

-- question_id: 4fd58eae-7bfb-405b-8abc-ac89af8580ff
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Diffusion models are not primarily used for text generation only; instead, Large Language Models (LLMs), often based on transformer architectures available through AWS Bedrock (e.g., Amazon Titan Text, Anthropic Claude), are the predominant models for text generation tasks. Option B (correct) Diffusion models are primarily used for image generation, a task supported on AWS through high-performance computing instances like Amazon EC2 P4d or G5 instances for model training and deployment, or through managed services like Amazon SageMaker or the Amazon Titan Image Generator within AWS Bedrock. Option C (incorrect) Diffusion models have no direct application in database queries, which are handled by specialized database services like Amazon RDS, Amazon DynamoDB, or Amazon Redshift using query languages like SQL. Option D (incorrect) Diffusion models are not primarily used for network security, a domain where AWS offers dedicated services like AWS WAF, AWS Shield, and Amazon GuardDuty for threat detection and protection.'
WHERE question_id = '4fd58eae-7bfb-405b-8abc-ac89af8580ff';

-- question_id: 5021c255-ee57-4ed4-97e3-d42142d900ff
-- answer_correct: False | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{3}'::integer[],
    explanation = 'Option A (incorrect) Purchasing 150 Reserved Instances for full capacity coverage is cost-inefficient because the company would be paying for 100 instances 24/7 that are only needed for occasional bursts, leading to significant wasted expenditure. Option B (incorrect) Using 50 Reserved Instances for baseline and On-Demand for burst capacity is a good approach but not the most optimized, as Savings Plans offer more flexibility in commitment (e.g., instance family, region) while providing comparable or better discounts for the steady-state compute. Option C (incorrect) Using 100 Reserved Instances is an over-commitment for the baseline of 50 instances, and relying on Spot Instances for consistent baseline capacity is risky due to potential interruptions, making it unsuitable for steady-state requirements. Option D (correct) Using Savings Plans covering the 50 steady-state instances provides deep discounts for the continuous workload with greater flexibility than Reserved Instances, while using On-Demand instances for occasional bursts ensures cost-effective scaling without long-term commitment for temporary needs.'
WHERE question_id = '5021c255-ee57-4ed4-97e3-d42142d900ff';

-- question_id: 505bb644-a800-460f-993b-e02653f07a09
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) General Purpose SSD (gp2) provides a good balance of price and performance, offering baseline IOPS with burst capability, but does not guarantee the extremely high and consistent IOPS required by a critical database needing the absolute lowest latency. Option 1 (incorrect) Throughput Optimized HDD (st1) is designed for large sequential I/O workloads like big data and streaming, offering high throughput but not the low-latency random I/O and consistent IOPS critical databases demand. Option 2 (correct) Provisioned IOPS SSD (io2 Block Express) is specifically engineered for the highest performance, lowest latency, and most demanding mission-critical applications, ensuring consistent and extremely high IOPS and throughput essential for a critical database. Option 3 (incorrect) Cold HDD (sc1) is optimized for the lowest cost for infrequently accessed data where performance is not a priority, making it entirely unsuitable for a critical database that requires high performance and low latency.'
WHERE question_id = '505bb644-a800-460f-993b-e02653f07a09';

-- question_id: 5088bda2-f727-4843-b8d7-fe1bb9440048
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon RDS requires users to provision and manage database instances, which are underlying servers, and while it offers some scaling features, the core compute component is not inherently serverless, requiring manual configuration or instance type changes for primary scaling. Option B (correct) Amazon DynamoDB is a fully managed NoSQL database service that automatically scales its throughput and storage capacity on demand without requiring users to provision or manage any servers, fitting the definition of both automatic scaling and serverless. Option C (incorrect) Amazon Redshift is a data warehousing service that requires users to provision and manage a cluster of compute nodes (servers), making it not serverless, although Redshift Serverless is a distinct offering. Option D (incorrect) Amazon ElastiCache is a caching service that requires users to provision and manage cache nodes (servers) and manually scale their clusters, which means it is not serverless.'
WHERE question_id = '5088bda2-f727-4843-b8d7-fe1bb9440048';

-- question_id: 50e1bca3-1cb4-45f5-95b9-7f3d0d485684
-- answer_correct: False | verified_indices: [3] | confidence: 90%
UPDATE public.mock_test_questions
SET
    correct_answer = '{3}'::integer[],
    explanation = 'Option 0 (incorrect) Creating individual IAM users with inline policies is an anti-pattern for scalable permission management, as it makes administration complex and error-prone for a growing number of users and various access needs. Option 1 (incorrect) While IAM groups and managed policies are best practices for internal teams, S3 bucket policies are not the most effective or granular mechanism for providing time-limited access to specific projects for external contractors. Option 2 (incorrect) AWS Lake Formation with LF-Tags is primarily designed for fine-grained access control within data lakes for analytical workloads at the table and column level, which is overkill and not the direct solution for general S3 file access and time-limited external contractor access for video files. Option 3 (correct) Generating S3 pre-signed URLs with expiration times is the ideal solution for granting time-limited access to specific S3 objects for external contractors, while IAM roles are the recommended best practice for internal teams and EMR to access resources securely via temporary credentials and least privilege.'
WHERE question_id = '50e1bca3-1cb4-45f5-95b9-7f3d0d485684';

-- question_id: 50e8b623-5b35-4f0f-9d28-1a9cca85a49b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Zero-shot learning involves instructing a model to perform a task without providing any specific examples in the prompt, relying solely on its pre-trained knowledge, similar to using Amazon Bedrock foundation models with a direct instruction like "Summarize this text" without prior examples. Option B (correct) Few-shot learning involves providing a small number of input-output examples directly within the prompt to demonstrate the desired task or output format, guiding the model''s response for tasks such as sentiment analysis or entity extraction in Amazon Bedrock. Option C (incorrect) Transfer learning is a machine learning technique where a model trained on one task is re-purposed for a second related task, often by fine-tuning a pre-trained model like those available through Amazon SageMaker JumpStart or Amazon Bedrock''s custom model capabilities, and is not a prompt engineering technique itself. Option D (incorrect) Reinforcement learning is a machine learning paradigm where an agent learns to make decisions by interacting with an environment and receiving rewards or penalties, such as training an optimal policy using Amazon SageMaker RL, and is distinct from prompt engineering methods.'
WHERE question_id = '50e8b623-5b35-4f0f-9d28-1a9cca85a49b';

-- question_id: 516cc11f-fb84-4a65-ba70-606b3db52488
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) The Reliability pillar specifically addresses minimizing downtime by focusing on recovery from failures, designing highly available systems using services like Amazon EC2 Auto Scaling across multiple Availability Zones, and implementing robust backup and disaster recovery strategies. Option B (correct) The Sustainability pillar directly focuses on minimizing the environmental impact of cloud workloads by promoting resource efficiency, selecting greener regions, and optimizing operational practices to reduce energy consumption and carbon footprint. Option C (incorrect) The Cost Optimization pillar focuses on avoiding unneeded costs and maximizing business value for the money spent, through strategies like right-sizing instances or using AWS Savings Plans, rather than directly addressing downtime or environmental impact. Option D (incorrect) The Security pillar focuses on protecting information, systems, and assets, including data confidentiality, integrity, and availability, through services like AWS WAF and AWS Identity and Access Management, which is distinct from minimizing downtime or environmental impact. Option E (incorrect) The Performance Efficiency pillar focuses on using computing resources efficiently to meet system requirements and adapting to changes in demand, optimizing for throughput and latency with services like Amazon CloudFront and Amazon ElastiCache, rather than minimizing downtime or environmental impact.'
WHERE question_id = '516cc11f-fb84-4a65-ba70-606b3db52488';

-- question_id: 51fd1d42-de87-45b9-b14e-9e28ddd185e7
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Managing infrastructure through code and templates is the essence of Infrastructure as Code, leveraging AWS services like AWS CloudFormation or AWS CDK to define and provision resources (e.g., EC2 instances, S3 buckets, VPCs) using declarative templates or programming languages for automation, consistency, and version control. Option B (incorrect) Manual server configuration is the traditional approach that IaC aims to replace and automate, as it is prone to errors, lacks scalability, and makes replication difficult, directly contradicting the principles of IaC. Option C (incorrect) Physical hardware management is primarily the responsibility of AWS under its shared responsibility model, where AWS manages the underlying infrastructure and customers manage resources deployed within the cloud. Option D (incorrect) Network cable management is a physical layer responsibility handled entirely by AWS for its data centers; customers manage virtual networking components like VPCs and subnets within their AWS accounts.'
WHERE question_id = '51fd1d42-de87-45b9-b14e-9e28ddd185e7';

-- question_id: 5278db23-ac88-4d8e-a082-5950d5b56855
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Services such as Amazon CloudWatch, AWS X-Ray, and Amazon CloudWatch Application Insights are specifically designed for monitoring application performance and operational health, not AWS Config. Option B (correct) AWS Config continuously monitors and records AWS resource configurations, allowing you to assess, audit, and evaluate the configurations of your AWS resources for desired settings and track changes over time. Option C (incorrect) Services like AWS CodeDeploy, AWS Elastic Beanstalk, AWS OpsWorks, or AWS CloudFormation are primarily used for deploying and managing applications and infrastructure. Option D (incorrect) AWS Identity and Access Management (IAM) is the dedicated service for securely managing access to AWS services and resources by controlling who is authenticated and authorized to use them.'
WHERE question_id = '5278db23-ac88-4d8e-a082-5950d5b56855';

-- question_id: 5340eba6-24fb-4907-8d61-08ff2de102c2
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While CloudFormation and StackSets enforce infrastructure as code and AWS Config monitors for drift, they primarily manage desired state and detect deviations post-facto rather than providing pre-approval workflows to prevent unauthorized changes or a comprehensive change management system. Option B (incorrect) Implementing manual procedures is a process control, not an AWS-native technical governance solution that actively prevents unauthorized changes or automates audit trail generation as effectively as AWS services. Option C (correct) AWS Systems Manager Change Manager is specifically designed to manage operational changes by enforcing approval workflows, which can prevent unauthorized changes, and all actions are logged to CloudTrail for a complete and traceable audit trail. Option D (incorrect) While a Jenkins pipeline could be customized with approval gates, it requires significant custom development and management overhead, and AWS Systems Manager Change Manager offers a more integrated, managed AWS-native service specifically for change governance and auditability.'
WHERE question_id = '5340eba6-24fb-4907-8d61-08ff2de102c2';

-- question_id: 5390c6c3-f1be-467a-b3af-ba609a76c306
-- answer_correct: True | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Standard is designed for frequently accessed data with high availability and is not the lowest cost option for rarely accessed data. Option B (incorrect) S3 Glacier Instant Retrieval offers low-cost archiving for data that requires millisecond retrieval, making it more expensive than other Glacier classes designed for longer retrieval times. Option C (incorrect) S3 Glacier Flexible Retrieval provides very low-cost storage for infrequently accessed data with retrieval times ranging from minutes to hours, but it is not the absolute lowest cost option among the choices. Option D (correct) S3 Glacier Deep Archive offers the absolute lowest storage cost for long-term data archiving, specifically for data accessed once or twice a year with retrieval times of several hours.'
WHERE question_id = '5390c6c3-f1be-467a-b3af-ba609a76c306';

-- question_id: 53a0435c-61a0-4f99-adc0-115148eb2788
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Continued pre-training is preferred when adapting a model to a new domain where extensive labeled data is scarce, allowing the model to learn the vocabulary, concepts, and structure of the new domain using large amounts of unlabeled data, a process effectively managed by AWS SageMaker training jobs utilizing S3 data lakes for domain-specific text or images. Option B (incorrect) When extensive labeled data is available, fine-tuning is the preferred approach as it directly optimizes the pre-trained model for a specific task using that labeled dataset, which is a common pattern for custom model training in AWS SageMaker or adapting foundation models in Amazon Bedrock. Option C (incorrect) For simple tasks, often a pre-trained model from Amazon Bedrock or SageMaker JumpStart can be used directly with zero-shot or few-shot prompting, or a smaller, quicker fine-tuning process is sufficient, making continued pre-training unnecessarily complex and resource-intensive. Option D (incorrect) Continued pre-training is a resource-intensive and time-consuming process involving training on vast datasets, which would significantly extend development cycles and delay deployment rather than accelerating it, whereas using pre-trained models or efficient fine-tuning techniques available in AWS can facilitate quicker deployment.'
WHERE question_id = '53a0435c-61a0-4f99-adc0-115148eb2788';

-- question_id: 53de1127-a6d5-443c-8222-39267f63d9a0
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Lifecycle policies automate the management of objects over their lifetime, such as transitioning storage classes or expiring objects, which does not prevent accidental deletion or overwriting but rather defines rules for data lifecycle. Option B (incorrect) S3 Glacier Deep Archive is a storage class optimized for long-term data archiving at the lowest cost, not a feature designed to protect active S3 objects from accidental deletion or overwriting. Option C (correct) S3 Versioning keeps multiple versions of an object in the same bucket, allowing for the retrieval of previous versions if an object is accidentally deleted or overwritten, thereby protecting critical data. Option D (incorrect) S3 Replication copies objects from a source bucket to a destination bucket, providing a geographically separate copy for disaster recovery or compliance, but it does not directly prevent accidental deletion or overwriting in the original source bucket itself.'
WHERE question_id = '53de1127-a6d5-443c-8222-39267f63d9a0';

-- question_id: 5405be18-5cdd-4824-b943-de66da369f3e
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Keeping unused IAM access keys active for future use violates the principle of least privilege and increases the attack surface, as a compromised or leaked key could grant unauthorized access to AWS resources. Option B (incorrect) While rotating *active* access keys regularly is a strong security best practice, it is not the appropriate action for *unused* keys; rotating an unused key simply replaces one unnecessary credential with another, rather than removing the security risk. Option C (correct) Deleting unused IAM access keys immediately is an essential security best practice that adheres to the principle of least privilege, minimizing the risk of unauthorized access should the keys ever be compromised or inadvertently exposed, aligning with AWS IAM security recommendations. Option D (incorrect) Sharing IAM access keys with teammates is a severe security violation that compromises accountability and greatly increases the risk of unauthorized access, as AWS IAM best practices mandate individual credentials or the use of IAM roles and identity federation for shared access.'
WHERE question_id = '5405be18-5cdd-4824-b943-de66da369f3e';

-- question_id: 55989fdd-b1f0-4aa7-a02e-b4f0b15ad538
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] (incorrect) ALB does not stop routing traffic to an entire Availability Zone by default unless all instances within that AZ in its target groups become unhealthy, as its health checks operate at the individual target instance level. Option [1] (incorrect) ALB is a health-aware load balancer that actively monitors the health of its registered targets and will not distribute traffic equally to unhealthy targets. Option [2] (correct) ALB continuously performs health checks on the EC2 instances registered in its target groups, automatically detecting when individual instances become unhealthy due to intermittent network issues or other problems and stopping the routing of new requests to those failed instances. Option [3] (incorrect) ALB automatically adjusts traffic routing based on the results of its health checks, requiring no manual intervention to reroute traffic away from unhealthy instances or AZs.'
WHERE question_id = '55989fdd-b1f0-4aa7-a02e-b4f0b15ad538';

-- question_id: 559ccc23-33ab-49e6-9359-f1c7173e45b4
-- answer_correct: True | verified_indices: [3] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Implementing workload management (WLM) primarily helps manage concurrent queries and resource contention, but with 60% idle capacity, the cluster has ample resources, indicating the issue is not contention but inefficient resource utilization. Option B (incorrect) While Redshift materialized views can significantly improve performance for frequently accessed aggregations by pre-computing results, the question implies a broader range of complex queries across 40% of data, and MVs add maintenance overhead without directly addressing fundamental data access inefficiency for all queries. Option C (incorrect) Enabling Redshift result caching reduces compute for exact repeated queries by returning cached results, but it doesn''t optimize the initial execution of complex, potentially dynamic queries that access 40% of the data. Option D (correct) Implementing data distribution and sort keys fundamentally optimizes how Redshift stores and retrieves data, allowing queries to scan significantly less data and reduce data movement (shuffling), which directly addresses the inefficiency of accessing 40% of data and enables cost reduction by allowing a smaller, more efficient cluster.'
WHERE question_id = '559ccc23-33ab-49e6-9359-f1c7173e45b4';

-- question_id: 55da9bfb-d605-4a2b-9ce4-3eff30bad11c
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Writing logs directly to Amazon S3 from EC2 instances lacks real-time streaming capabilities, proper buffering, and error handling mechanisms necessary for a scalable and efficient real-time logging solution, potentially leading to performance bottlenecks and incomplete data. Option B (correct) Amazon Kinesis Data Firehose is a fully managed service designed for real-time ingestion, buffering, transformation, and delivery of streaming data to destinations like Amazon S3, providing automatic scaling, durability, and cost-effectiveness for centralized log storage. Option C (incorrect) Installing a custom logging agent on EC2 instances to send logs to a self-managed Elasticsearch cluster on EC2 introduces significant operational overhead for managing the cluster, including scaling, patching, and monitoring, making it less efficient and cost-effective than managed services. Option D (incorrect) Sending logs to Amazon SQS and processing with AWS Lambda to store in Amazon DynamoDB is not ideal for large-scale raw log storage and analysis, as DynamoDB is optimized for transactional workloads and would be significantly more expensive and less efficient for typical log analytics compared to S3.'
WHERE question_id = '55da9bfb-d605-4a2b-9ce4-3eff30bad11c';

-- question_id: 568c3e54-a963-4b7f-94d5-309f99a4848c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Lambda is a serverless compute service where AWS fully manages the underlying operating system and infrastructure, providing no direct OS control to the user. Option B (incorrect) AWS Fargate is a serverless compute engine for containers where AWS manages the underlying infrastructure and operating system, thus offering no direct OS control. Option C (correct) Amazon EC2 provides virtual servers (instances) with root-level access to the operating system, allowing full control over installation, configuration, and kernel modifications necessary for high-performance computing workloads. Option D (incorrect) Amazon ECS is a container orchestration service that manages containers; while it can use EC2 instances for compute, ECS itself does not provide direct full control over the operating system of the underlying compute, as that control resides with the EC2 instances, not the ECS service directly.'
WHERE question_id = '568c3e54-a963-4b7f-94d5-309f99a4848c';

-- question_id: 56e1e950-aa80-49a3-9578-46bd7bb1d2b9
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) VPC peering connects two VPCs, not an on-premises network directly to AWS service endpoints like S3 and DynamoDB, as these services are not deployed within customer-peered VPCs. Option B (incorrect) A NAT Gateway allows resources in a private subnet to initiate connections to the public internet, which explicitly violates the requirement of "without routing traffic over the public internet" for accessing AWS services. Option C (correct) VPC Endpoints provide a private and secure connection from a VPC to supported AWS services like S3 (Gateway Endpoint) and DynamoDB (Interface Endpoint), and these endpoints are accessible from an on-premises network via a Direct Connect connection without traversing the public internet. Option D (incorrect) A VPN connection typically connects an on-premises network to a VPC, and accessing S3 or DynamoDB directly via their public endpoints even over a VPN still routes traffic to the public service endpoints, which violates the requirement for entirely private connectivity to the services themselves.'
WHERE question_id = '56e1e950-aa80-49a3-9578-46bd7bb1d2b9';

-- question_id: 5710e87d-a6af-4cf7-861f-b805a1727d76
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) This S3 lifecycle policy design is the most cost-optimized and addresses all requirements: objects remain in S3 Standard for the initial 7 days (implied), transition to S3 Standard-IA after 7 days for the 60-day infrequent auditing period, then move to S3 Glacier Instant Retrieval after 60 more days (67 days total) for continued low-cost archiving with millisecond retrieval, and finally transition to S3 Glacier Deep Archive after 5 years (from creation) for the lowest-cost, long-term compliance archiving. Option B (incorrect) Transitioning to Amazon S3 One Zone-IA after 7 days reduces durability by storing data in a single Availability Zone, which might not be suitable for critical logs, and it completely misses the requirement for 5-year compliance archiving in Glacier Deep Archive. Option C (incorrect) Keeping all objects in Amazon S3 Standard for 5 years would be excessively expensive as most of the data is infrequently accessed or archived, failing the "cost-optimized" requirement. Option D (incorrect) While Amazon S3 Intelligent-Tiering reduces operational overhead by automating tiering, it is generally not as cost-effective for predictably declining access patterns as specific lifecycle rules, especially for reaching the deep archive tier (Glacier Deep Archive) which often requires explicit configuration within Intelligent-Tiering and doesn''t guarantee the lowest cost compared to direct lifecycle transitions for compliance.'
WHERE question_id = '5710e87d-a6af-4cf7-861f-b805a1727d76';

-- question_id: 5763e458-0f25-4bf9-bd26-c27c484c1676
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudTrail focuses on logging API calls and account activity for governance, compliance, operational auditing, and risk auditing, not tracking or controlling costs. Option B (incorrect) AWS Config provides a detailed inventory of AWS resources and their configuration changes over time for compliance and security auditing, rather than financial management. Option C (correct) AWS Budgets allows organizations to set custom budgets, track their actual and forecasted costs and usage, and receive alerts when budget thresholds are exceeded. Option D (incorrect) AWS Systems Manager is a collection of operational capabilities that helps manage AWS resources and on-premises servers, such as patching, automation, and remote command execution, without direct cost tracking or control features.'
WHERE question_id = '5763e458-0f25-4bf9-bd26-c27c484c1676';

-- question_id: 57789ddd-e07f-4d57-993a-56bbd403340e
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Replatforming involves making some changes to optimize for the cloud, such as migrating a self-managed database to Amazon RDS, which goes beyond minimal changes. Option B (incorrect) Refactoring entails significantly re-architecting an application, often breaking it into microservices on AWS Lambda or Amazon ECS, requiring substantial code changes. Option C (correct) Rehosting, also known as "lift-and-shift," involves moving applications to Amazon EC2 instances with minimal or no changes to the application code, directly addressing the requirement for minimal changes. Option D (incorrect) Retiring is the strategy of decommissioning applications that are no longer needed, rather than migrating them to the cloud.'
WHERE question_id = '57789ddd-e07f-4d57-993a-56bbd403340e';

-- question_id: 579b1e76-57d2-4ff5-a334-03d9981eca24
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) Amazon SQS FIFO queues guarantee strict message ordering (first-in, first-out), exactly-once processing, and high throughput, while dead-letter queues provide a robust mechanism for automatically retrying failed messages with exponential backoff via configurable visibility timeouts and redrive policies. Option B (incorrect) Amazon SNS with SQS fanout pattern does not guarantee message order to its subscribers, failing to meet the "guaranteed processing order" requirement, although it excels at distributed processing. Option C (incorrect) Amazon MQ, while offering enterprise messaging with ordering capabilities, is generally a more operationally intensive and expensive solution compared to SQS FIFO for this specific problem, and SQS FIFO directly addresses the core ordering and retry requirements with a serverless, scalable approach. Option D (incorrect) Amazon Kinesis Data Streams ensure order only within a shard, making global guaranteed processing order across the entire stream complex to achieve, and its primary use case is typically for real-time data streaming and analytics rather than strict message queuing with built-in retry logic like SQS FIFO.'
WHERE question_id = '579b1e76-57d2-4ff5-a334-03d9981eca24';

-- question_id: 57c237a6-7a27-4e45-8550-823570136c8a
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Creating individual VPC peering connections between each VPC and the central shared services VPC would result in a complex mesh-like management overhead and does not support transitive routing, meaning spoke VPCs could not communicate with each other through the central hub, nor would it simplify routing for 12+ VPCs. Option B (correct) Utilizing AWS Transit Gateway is the ideal solution as it acts as a central hub to connect multiple VPCs and on-premises networks, enabling transitive routing, simplifying network architecture, and significantly reducing management overhead for a large number of VPCs across accounts in a hub-and-spoke model. Option C (incorrect) Setting up multiple AWS Site-to-Site VPN connections between each VPC is an overly complex, expensive, and unmanageable solution for inter-VPC communication within AWS, as VPNs are typically used for connecting on-premises networks or for secure point-to-point connections over the internet, not for internal VPC mesh connectivity. Option D (incorrect) Configuring a complex routing scheme using Amazon Route 53 Private Hosted Zones addresses DNS resolution within VPCs and connected networks, but it does not establish network connectivity or provide a mechanism for traffic routing between VPCs, which is the core requirement.'
WHERE question_id = '57c237a6-7a27-4e45-8550-823570136c8a';

-- question_id: 57c890cc-4c53-45ea-9363-8b63a8ec280b
-- answer_correct: True | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] (incorrect) S3 Standard is designed for frequently accessed data with high availability and low latency, making its storage costs significantly higher than archival classes for data accessed only once or twice per year. Option [1] (incorrect) S3 Standard-IA is for data accessed infrequently but requiring rapid access, and while cheaper than S3 Standard, it has higher per-GB storage costs and retrieval fees compared to Glacier classes for truly archival data. Option [2] (incorrect) S3 Glacier Flexible Retrieval is a cost-effective archival solution with retrieval options from minutes to hours, but S3 Glacier Deep Archive offers even lower storage costs, making it more economical for data accessed extremely rarely. Option [3] (correct) S3 Glacier Deep Archive provides the lowest cost storage for long-term archival data that can tolerate retrieval times of 12 hours or more, perfectly suiting the requirement for data accessed only once or twice per year.'
WHERE question_id = '57c890cc-4c53-45ea-9363-8b63a8ec280b';

-- question_id: 57cb95ec-b80a-466b-8d5b-b8148cf68179
-- answer_correct: False | verified_indices: [1, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1, 2}'::integer[],
    explanation = 'Option A (incorrect) Amazon EC2 is an Infrastructure-as-a-Service (IaaS) offering that provides virtual servers, not a fully managed Desktop-as-a-Service solution itself, as it requires users to provision, manage, and secure the desktop environment on top of the instances. Option B (correct) Amazon WorkSpaces is a fully managed, secure Desktop-as-a-Service (DaaS) solution that provides cloud-based virtual desktops, allowing users to access their desktops from anywhere on supported devices. Option C (correct) AWS AppStream 2.0 is a fully managed application and desktop streaming service that can stream full virtual desktops (both persistent and non-persistent) to users, making it a viable Desktop-as-a-Service option alongside its primary application streaming function. Option D (incorrect) Amazon Connect is a cloud-based contact center service that provides customer service capabilities, having no relation to virtual desktop or application delivery services.'
WHERE question_id = '57cb95ec-b80a-466b-8d5b-b8148cf68179';

-- question_id: 587af3cf-e9c0-49ed-9b3b-cb396f33f19f
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Database transcoding is not a recognized AWS service or concept; AWS services like Database Migration Service (DMS) or AWS Glue are used for data migration and ETL, not for media transcoding of databases. Option B (correct) Amazon Elastic Transcoder is an AWS service specifically designed to convert media files (like video and audio) from one format to another, optimizing them for playback on various devices. Option C (incorrect) Text translation is a capability provided by Amazon Translate, an AWS service that uses neural machine translation to convert text from one language to another. Option D (incorrect) Voice recognition, or more accurately speech-to-text conversion, is a service offered by Amazon Transcribe, which enables developers to easily add speech-to-text capabilities to their applications.'
WHERE question_id = '587af3cf-e9c0-49ed-9b3b-cb396f33f19f';

-- question_id: 58a6db98-b2df-4f96-883b-6d90830eb981
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS Batch is purpose-built for executing long-running, compute-intensive batch jobs efficiently, and its compute environments can be configured to use EC2 Spot instances for significant cost savings, automatically scaling based on the depth of jobs in the associated SQS queue. Option B (incorrect) AWS Lambda functions have a maximum execution duration of 15 minutes, making them unsuitable for batch jobs that can take "hours" to complete, even with SQS triggers and Dead Letter Queues for error handling. Option C (incorrect) While AWS Step Functions can orchestrate complex workflows and handle error states, it primarily coordinates underlying compute services like Lambda, which is limited to 15-minute executions, making it an inefficient or unsuitable choice for individual batch jobs that can run for "hours". Option D (incorrect) Amazon ECS with Fargate Spot can run long-duration tasks at a reduced cost, but this option specifies CloudWatch Events for *scheduling* rather than directly providing or implying an integrated solution for automatically scaling processing capacity based on SQS queue depth, which AWS Batch offers out-of-the-box.'
WHERE question_id = '58a6db98-b2df-4f96-883b-6d90830eb981';

-- question_id: 58ea33a9-e057-4c68-be34-8b1f45604cae
-- answer_correct: True | verified_indices: [0, 4] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS Transfer Family provides a fully managed SFTP server endpoint, allowing external suppliers to securely upload product catalog files directly to Amazon S3. Option B (incorrect) While essential for schema detection and cataloging, a Glue crawler is a processing component rather than an ingestion mechanism or the primary trigger for the initial file arrival in this workflow. Option C (incorrect) Amazon AppFlow is designed for ingesting data from SaaS applications or other AWS services, not directly from an SFTP endpoint provided by external suppliers. Option D (incorrect) AWS DataSync is used for transferring large amounts of data between on-premises storage and AWS, or between AWS storage services, and does not provide an SFTP endpoint for external suppliers to upload files. Option E (correct) After product catalog files are uploaded to an S3 bucket via Transfer Family, S3 event notifications can reliably trigger downstream processing, such as a Lambda function or a Glue job, for validation and loading into Redshift.'
WHERE question_id = '58ea33a9-e057-4c68-be34-8b1f45604cae';

-- question_id: 59cc11df-6fe2-42c0-a10e-4894c00e9caa
-- answer_correct: True | verified_indices: [2] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) While Intelligent-Tiering automatically moves data based on access, its per-object monitoring fee can accumulate significantly in a petabyte-scale data lake with potentially billions of objects, making manual lifecycle rules to Standard-IA potentially more cost-effective for known access patterns. Option 1 (incorrect) S3 Glacier is designed for archival data with retrieval times ranging from minutes to hours and associated retrieval fees, which would severely impede multi-year historical analysis queries and violate the requirement to maintain query performance. Option 2 (correct) This strategy optimally balances cost and performance by keeping frequently accessed recent data in S3 Standard (high performance, no retrieval fees) and moving less frequently accessed older data to S3 Standard-IA (lower storage cost, still millisecond access for queries) to maintain query performance for occasional historical analysis. Option 3 (incorrect) Keeping frequently accessed recent data in S3 Standard-IA would incur higher retrieval costs than S3 Standard due to its per-GB retrieval fee, potentially making it more expensive, and moving multi-year historical data to Glacier would introduce unacceptable delays for queries.'
WHERE question_id = '59cc11df-6fe2-42c0-a10e-4894c00e9caa';

-- question_id: 59da7199-2e0d-46e2-b714-96bc177d9462
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Individual account management is a benefit of using multiple accounts within AWS Organizations for governance and security, but it is not the primary cost benefit directly derived from consolidated billing itself. Option B (correct) Consolidated billing within AWS Organizations aggregates the usage of all member accounts, allowing the entire organization to benefit from volume pricing tiers, such as reduced rates for services like S3 storage or data transfer, as if it were a single large account. Option C (incorrect) Consolidated billing is designed to reduce overall costs by leveraging aggregated usage for discounts, not to result in higher individual costs. Option D (incorrect) Consolidated billing centralizes the billing and payment across all member accounts to the management account, directly contrasting with separate billing per account.'
WHERE question_id = '59da7199-2e0d-46e2-b714-96bc177d9462';

-- question_id: 59eec3b1-5b13-4856-aa8a-9b55d080f354
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Encryption at rest protects data stored persistently on a storage device, such as Amazon S3 objects, Amazon EBS volumes, or Amazon RDS databases, not while it is actively moving between systems. Option B (correct) Encryption in transit, often implemented using TLS/SSL, protects data as it travels over a network between a client and a server, which is precisely what happens during API calls (e.g., HTTPS) and file transfers (e.g., SFTP over TLS, S3 transfer over HTTPS). Option C (incorrect) Database encryption specifically secures data within a database system, primarily protecting it at rest within the database storage and backups, not generically across all API calls or file transfers that might occur outside the database interaction. Option D (incorrect) Application encryption involves the application itself encrypting data, which can apply to data at rest or in transit, but it refers to the layer where encryption is performed rather than the state (in transit) the data is in while protected during network communication.'
WHERE question_id = '59eec3b1-5b13-4856-aa8a-9b55d080f354';

-- question_id: 5af0a1e4-fa45-43db-b9d7-801a54539b97
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) AWS KMS with customer-managed keys does not provide complete data sovereignty because AWS maintains operational control over the underlying HSMs, and KMS HSMs are FIPS 140-2 Level 2, not Level 3, failing to meet the specified hardware control and compliance requirements. Option 1 (incorrect) AWS CloudHSM Classic is a deprecated service and while it offered dedicated HSMs, it did not meet FIPS 140-2 Level 3 and is not a current best practice for new deployments requiring strict sovereignty. Option 2 (correct) AWS CloudHSM clusters provide dedicated, single-tenant hardware security modules (HSMs) that customers exclusively control, allowing for hardware-based key generation and full management of keys within FIPS 140-2 Level 3 validated devices, directly addressing complete data sovereignty and domestic management requirements. Option 3 (incorrect) AWS Secrets Manager primarily manages secrets and relies on AWS KMS for encryption, which, as noted in option 0, does not provide the direct customer control over FIPS 140-2 Level 3 hardware and complete data sovereignty required by the government agency.'
WHERE question_id = '5af0a1e4-fa45-43db-b9d7-801a54539b97';

-- question_id: 5bae213c-96be-4d7b-9572-640dc13717f1
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CodeDeploy, AWS CodePipeline, and AWS CodeBuild are the primary services used for managing and automating code deployment processes, not AWS X-Ray. Option B (correct) AWS X-Ray provides end-to-end tracing of requests through distributed applications, helping identify performance bottlenecks and debug issues across services like Amazon EC2, AWS Lambda, and Amazon API Gateway. Option C (incorrect) AWS Backup, Amazon S3, and Amazon EBS Snapshots are dedicated AWS services used for creating and managing backups of data across various AWS resources, which is unrelated to X-Ray''s purpose. Option D (incorrect) AWS Identity and Access Management (IAM) is the service responsible for securely managing user identities and access to AWS services and resources, whereas X-Ray focuses on application performance insights.'
WHERE question_id = '5bae213c-96be-4d7b-9572-640dc13717f1';

-- question_id: 5bb9b6a6-0bf7-43cc-a44d-b4ec60ee6f49
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Load balancing is primarily handled by AWS Elastic Load Balancing (ELB) services, which distribute incoming application traffic across multiple targets. Option B (correct) Amazon Route 53 is a highly available and scalable cloud Domain Name System (DNS) web service that translates human-readable domain names into IP addresses. Option C (incorrect) Content delivery is primarily handled by Amazon CloudFront, which is a fast content delivery network (CDN) service. Option D (incorrect) Database hosting is primarily handled by various AWS database services such as Amazon RDS, DynamoDB, or Aurora.'
WHERE question_id = '5bb9b6a6-0bf7-43cc-a44d-b4ec60ee6f49';

-- question_id: 5bf9e373-3be7-4fbb-8faa-9bed8f92b90e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deploying resources in only one Availability Zone creates a single point of failure, meaning an outage in that AZ will make the entire application unavailable, thus not achieving high availability. Option B (correct) Deploying resources across two Availability Zones allows the application to continue operating even if one entire AZ experiences an outage, providing resilience against AZ-level failures and meeting the basic requirement for high availability. Option C (incorrect) While deploying across three Availability Zones provides even greater fault tolerance and is often recommended for quorum-based systems or enhanced resilience, it is not the *minimum* requirement to achieve high availability, as two AZs are sufficient to withstand a single AZ failure. Option D (incorrect) Deploying across four Availability Zones offers substantial redundancy but is well beyond the minimum needed for high availability, as two AZs already satisfy the capability to withstand the failure of one AZ.'
WHERE question_id = '5bf9e373-3be7-4fbb-8faa-9bed8f92b90e';

-- question_id: 5c2dd43b-0496-4837-8a06-28d8f41de208
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Global model interpretability, supported by AWS SageMaker Clarify, focuses on understanding the overall behavior of a machine learning model by providing insights into how features collectively influence predictions across the entire dataset. Option B (incorrect) Explaining single predictions, a feature also offered by AWS SageMaker Clarify for specific data points, represents local model interpretability, which is distinct from understanding the model''s global decision patterns. Option C (incorrect) Local approximations are often methods, like LIME, used for local model interpretability to explain individual predictions, rather than summarizing the entire model''s behavior, although such methods can be deployed on AWS SageMaker endpoints. Option D (incorrect) Instance-specific analysis is another term for local interpretability, where AWS SageMaker Clarify can generate detailed explanations for why a particular data point received a certain prediction, but this is not the definition of global interpretability.'
WHERE question_id = '5c2dd43b-0496-4837-8a06-28d8f41de208';

-- question_id: 5d0240f0-dacd-4849-ad6f-3bcc275f4b2c
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Serverless computing, such as AWS Lambda, still requires developers to write, package, and deploy their application code for execution. Option B (correct) Serverless computing abstracts away the underlying server infrastructure, including operating systems, patching, and automatic scaling, eliminating the need for customers to perform capacity planning. Option C (incorrect) While serverless applications often integrate with managed data storage services like Amazon DynamoDB or Amazon S3, serverless computing itself does not eliminate the need to design and manage a data persistence layer. Option D (incorrect) User authentication and authorization, often managed through services like Amazon Cognito or IAM, remain a critical application concern that serverless computing does not eliminate.'
WHERE question_id = '5d0240f0-dacd-4849-ad6f-3bcc275f4b2c';

-- question_id: 5d360277-f98c-4372-9cd2-c90cf6ec840b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Comprehend is an AWS service primarily used for natural language processing (NLP), which analyzes text for insights such as sentiment, key phrases, and entity recognition, but it does not process video content. Option B (correct) Amazon Rekognition is the AWS service designed for image and video analysis, capable of identifying objects, people, activities, and text, as well as detecting inappropriate content and recognizing faces. Option C (incorrect) Amazon Polly is an AWS service that turns text into lifelike speech, allowing you to create applications that talk, which is unrelated to video analysis. Option D (incorrect) Amazon Lex is an AWS service for building conversational interfaces for applications using voice and text, powering chatbots and virtual assistants, not for analyzing visual content in videos.'
WHERE question_id = '5d360277-f98c-4372-9cd2-c90cf6ec840b';

-- question_id: 5da139de-4fdb-474a-ba2f-01e63ca8dddf
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The speed of data processing refers to performance metrics and throughput, often optimized using services like Amazon Kinesis for real-time data ingestion or Amazon EMR for batch processing, not the historical path or transformations of data. Option B (correct) Data lineage precisely defines the ability to trace data from its origin through all subsequent transformations, aggregations, and movements, which is essential for auditability, compliance, and explainability in AI governance, often supported by metadata in AWS Glue Data Catalog or tracking within Amazon SageMaker. Option C (incorrect) Data compression ratio pertains to storage efficiency and cost reduction, achieved through various encoding techniques for data stored in services like Amazon S3 or Amazon Redshift, and has no direct relation to tracking the lifecycle or modifications of data. Option D (incorrect) Data storage location refers to where data resides (e.g., an Amazon S3 bucket, an Amazon RDS database), which is a component of data governance, but lineage encompasses the entire historical flow and changes to data, not just its current resting place.'
WHERE question_id = '5da139de-4fdb-474a-ba2f-01e63ca8dddf';

-- question_id: 5e1f83d0-bf48-45f1-8a32-927d8965a020
-- answer_correct: True | verified_indices: [2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Intelligent-Tiering is designed for unknown or changing access patterns and might not provide the optimal cost savings for truly archival data compared to a direct transition to Glacier Deep Archive, nor does it guarantee the absolute lowest cost for data with clearly defined long-term infrequent access. Option B (incorrect) Transitioning daily-accessed recent data to S3 Standard-IA after only 30 days would incur significant retrieval costs and potentially higher latency for operational analytics, failing the requirement for quick access to recent data. Option C (correct) Keeping the last 6 months in S3 Standard ensures quick and frequent access for daily operational analytics, while transitioning older data (after 6 months) to S3 Glacier Deep Archive drastically optimizes storage costs for the bulk of the data with acceptable retrieval times for monthly compliance reporting. Option D (incorrect) Using S3 One Zone-IA for all data is inappropriate as it is designed for infrequently accessed, re-creatable data with lower durability and would incur high retrieval costs for the daily operational analytics on recent data.'
WHERE question_id = '5e1f83d0-bf48-45f1-8a32-927d8965a020';

-- question_id: 5e2a4e77-f944-4a0f-92fa-c2a8efafac39
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Enabling schema inference with evolve schema in a relationalize transform is specific to flattening nested data and evolving that output schema, which does not directly provide the general mechanism for a DynamicFrame to gracefully handle arbitrary new fields across the entire job without failures. Option B (correct) Using a DynamicFrame with the resolveChoice transform is explicitly designed to handle schema variations and new fields gracefully by allowing the job to resolve ambiguous types or missing fields, preventing failures when new fields are introduced in the source data. Option C (incorrect) Configuring a Glue crawler to update the schema before job runs ensures the Data Catalog is current, but the Glue ETL job''s internal processing logic still requires a mechanism (like DynamicFrame with resolveChoice) to robustly handle schema changes during execution without failing. Option D (incorrect) Implementing custom Python code, while offering flexibility, is not leveraging a specific Glue feature designed for schema evolution and bypasses the built-in, optimized capabilities of DynamicFrames and transforms like resolveChoice.'
WHERE question_id = '5e2a4e77-f944-4a0f-92fa-c2a8efafac39';

-- question_id: 5e72d8ea-4eef-4e5b-a0a9-3186c3eb1fc3
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Budgets allows you to set custom budgets and receive alerts based on cost or usage thresholds, but it does not provide the underlying raw, detailed cost and usage information itself. Option B (incorrect) AWS Cost Explorer provides interactive visualizations and reports to analyze and manage your AWS costs and usage, offering granular filtering but typically presents aggregated data rather than the raw, individual line items. Option C (correct) AWS Cost and Usage Reports (CUR) delivers highly granular data about your AWS costs and usage to an S3 bucket, including every line item for each resource used, making it the most detailed source available. Option D (incorrect) AWS Pricing Calculator helps you estimate potential costs for new or existing workloads before deployment, but it does not provide actual past or current cost and usage information.'
WHERE question_id = '5e72d8ea-4eef-4e5b-a0a9-3186c3eb1fc3';

-- question_id: 5ea3506e-437f-454d-9f0f-a15886969f93
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Continuously monitoring and manually scaling instances is inefficient and unlikely to yield significant cost reductions for a predictable, steady-state 24/7 workload, which implies consistent resource consumption rather than fluctuating demand suitable for scaling. Option 1 (incorrect) Migrating the workload to Spot Instances is unsuitable for a predictable, steady-state 24/7 workload that requires continuous operation, as Spot Instances can be interrupted with short notice by AWS, leading to service disruption. Option 2 (correct) Purchasing Amazon EC2 Reserved Instances or committing to a Compute Savings Plan for a 3-year term offers the highest percentage discounts for predictable, long-term, steady-state compute usage, making it the most effective strategy for significant cost reduction. Option 3 (incorrect) Re-architecting the application to use AWS Lambda for all compute "regardless of suitability" is an extreme and potentially impractical solution, as not all steady-state EC2 workloads are suitable for a serverless event-driven architecture, and it introduces significant re-engineering costs and risks.'
WHERE question_id = '5ea3506e-437f-454d-9f0f-a15886969f93';

-- question_id: 5eae243a-050d-4601-a5f4-3e70a65dfae0
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Secrets Manager primarily manages the lifecycle, rotation, and access to secrets like database credentials and API keys, not the encryption keys themselves used for data encryption. Option B (correct) AWS Key Management Service (KMS) is a managed service that makes it easy for you to create and control the encryption keys used to encrypt your data and seamlessly integrates with many other AWS services for their encryption needs. Option C (incorrect) AWS Certificate Manager (ACM) is used for provisioning, managing, and deploying SSL/TLS certificates for websites and applications, not for managing general-purpose encryption keys. Option D (incorrect) AWS Identity and Access Management (IAM) is used to securely control access to AWS services and resources, defining who can perform actions, but it does not manage encryption keys.'
WHERE question_id = '5eae243a-050d-4601-a5f4-3e70a65dfae0';

-- question_id: 5ed31ee5-ebcd-4e80-ae0d-6276cc400681
-- answer_correct: True | verified_indices: [1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Versioning tracks multiple versions of individual objects, but it does not provide a consolidated mechanism to version an entire dataset (which often comprises multiple objects or S3 prefixes) or integrate with AWS Glue Data Catalog for dataset-level version tracking. Option B (correct) AWS Glue Data Catalog table versioning allows tracking schema and partition changes of a dataset represented as a Glue table, which directly supports reproducing model training using specific dataset versions, tracking lineage, rolling back, and integrates seamlessly with existing Glue ETL jobs. Option C (incorrect) AWS DataSync is a data transfer service used for moving data between storage systems and does not inherently provide a structured dataset versioning solution or integrate with Glue Data Catalog for this purpose. Option D (incorrect) Apache Hudi provides robust data versioning and ACID capabilities for data lakes on S3, but it requires data to be stored in Hudi table format, which might be a more significant architectural change than leveraging the native table versioning capabilities of the AWS Glue Data Catalog for existing S3 datasets and Glue ETL jobs.'
WHERE question_id = '5ed31ee5-ebcd-4e80-ae0d-6276cc400681';

-- question_id: 5f3edd50-fcbc-4536-b342-39467ec4cc98
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Physical server protection is managed by AWS as part of the shared responsibility model and involves infrastructure security measures, not prompt engineering guardrails which operate at the application layer for content moderation. Option B (correct) Guardrails in prompt engineering, such as those configurable in Amazon Bedrock, are specifically designed to define and enforce policies to prevent large language models from generating harmful, inappropriate, or off-topic content. Option C (incorrect) Increasing model speed is typically addressed through model optimization, efficient hardware like AWS EC2 instances with GPUs or AWS Inferentia chips, and optimized inference techniques, not the primary function of guardrails which may even introduce slight latency for content filtering. Option D (incorrect) Reducing storage costs is achieved by optimizing data storage solutions like Amazon S3 buckets or Amazon EBS volumes and choosing appropriate storage classes based on access patterns, completely unrelated to the function of guardrails in prompt engineering.'
WHERE question_id = '5f3edd50-fcbc-4536-b342-39467ec4cc98';

-- question_id: 5f84997b-56b2-465d-8ee4-961695b469ad
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) On-Demand instances offer no commitment and you pay for compute capacity by the hour or second, providing flexibility but no discount for long-term usage. Option B (incorrect) A 1-year Reserved Instance requires a commitment of one year and provides a significant discount over On-Demand, but it is not the longest commitment available nor does it offer the highest discount compared to the 3-year option. Option C (correct) A 3-year Reserved Instance requires the longest commitment of three years and in exchange provides the highest discount among all EC2 pricing models, making it ideal for applications with steady-state usage. Option D (incorrect) Spot Instances offer the largest discount (up to 90%) and require no commitment, as they allow you to bid on unused EC2 capacity and can be interrupted by AWS with a two-minute warning, which doesn''t fit the "longest commitment" criteria.'
WHERE question_id = '5f84997b-56b2-465d-8ee4-961695b469ad';

-- question_id: 5f883d2f-20c6-415e-8153-4d8572d339d6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Slower development cycles are antithetical to increased speed and agility, as cloud computing, via services like AWS CodePipeline for continuous integration and delivery, aims to accelerate the entire software development lifecycle. Option B (correct) On-demand resource availability, such as instantly provisioning Amazon EC2 instances or Amazon RDS databases, allows developers and operations teams to acquire and release infrastructure resources rapidly without manual approvals or long lead times, directly fostering increased speed and agility. Option C (incorrect) Manual provisioning processes introduce delays, human error, and inefficiencies that impede speed and agility; AWS promotes automation through services like AWS CloudFormation and AWS Systems Manager to streamline infrastructure deployment. Option D (incorrect) Physical hardware constraints, common in traditional on-premises environments like limited server capacity or long procurement cycles, are exactly what cloud computing seeks to eliminate to provide the elasticity and agility needed for rapid innovation.'
WHERE question_id = '5f883d2f-20c6-415e-8153-4d8572d339d6';

-- question_id: 60147cd0-0f61-4460-9861-9ee2573c36e1
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While Amazon ECS can utilize AWS Fargate for serverless container execution, ECS itself is a container orchestration service that can also deploy containers on Amazon EC2 instances, which necessitates managing underlying servers. Option B (correct) AWS Fargate is a serverless compute engine specifically designed to run containers for Amazon ECS and Amazon EKS without requiring you to provision, patch, or manage any servers. Option C (incorrect) While Amazon EKS can be configured to use AWS Fargate for serverless container execution, EKS is a managed Kubernetes service that fundamentally relies on Amazon EC2 instances as worker nodes for its default deployment model, requiring server management. Option D (incorrect) AWS Lambda is a serverless compute service primarily used for running event-driven functions, and while it supports container images for deployment, it does not manage persistent containerized applications in the same manner as dedicated container orchestration services like AWS Fargate.'
WHERE question_id = '60147cd0-0f61-4460-9861-9ee2573c36e1';

-- question_id: 6057075e-ddb9-4457-b6f9-3a21a801c0d3
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deleting root account access keys and setting up MFA are crucial security best practices to prevent programmatic access and secure console access, but they do not actively monitor or alert on actual console usage if the root account is logged in. Option B (correct) Creating a CloudWatch Events rule for root account sign-in events captured by CloudTrail, triggering an SNS notification, directly addresses the requirement to monitor and alert on any root account usage. Option C (incorrect) AWS Config rules are primarily for assessing and auditing resource configurations against compliance policies, not for real-time monitoring and alerting on specific user sign-in events or API calls. Option D (incorrect) The AWS root account is immutable and cannot have its login disabled or restricted by IAM policies, as IAM policies only apply to IAM users, groups, and roles, not the root user itself.'
WHERE question_id = '6057075e-ddb9-4457-b6f9-3a21a801c0d3';

-- question_id: 608d6e54-0d16-4644-a73d-1fa298657136
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Trusted Advisor does not specifically focus on "model architecture," which typically refers to the design of machine learning models or high-level system blueprints, as its primary domain is inspecting AWS resource configurations against best practices across broader pillars. Option B (correct) AWS Trusted Advisor explicitly provides recommendations across core pillars including Security, Performance, and Cost Optimization, alongside Fault Tolerance and Service Limits, aligning with the AWS Well-Architected Framework to help users optimize their AWS environment. Option C (incorrect) Data labeling is a specialized task typically handled by services like Amazon SageMaker Ground Truth for preparing datasets for machine learning, and it is entirely outside the operational and resource optimization scope of AWS Trusted Advisor. Option D (incorrect) UI design is a front-end development concern that falls outside of AWS infrastructure and operational best practices, and AWS Trusted Advisor focuses on the configuration and health of underlying AWS services, not the aesthetic or functionality of user interfaces built upon them.'
WHERE question_id = '608d6e54-0d16-4644-a73d-1fa298657136';

-- question_id: 60db7074-a242-48d0-8dfd-040a62b54f4b
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Model documentation provides detailed information about a model''s design, training data, evaluation metrics, and intended use, which is critical for understanding its behavior and fostering trust, a capability supported by AWS SageMaker Model Registry for managing and documenting model versions. Option B (correct) Decision explanation features, often referred to as Explainable AI (XAI), allow users to understand the rationale behind a model''s predictions or outputs, directly enhancing transparency and accountability, with AWS SageMaker Clarify offering tools to provide these explanations. Option C (incorrect) Data deletion is crucial for data privacy and regulatory compliance, such as GDPR, by removing personal information from datasets, but it does not directly make the AI model''s internal workings or decision-making process more transparent. Option D (incorrect) Model obfuscation involves intentionally making a model''s internal workings unclear or difficult to understand, which directly counteracts the goal of AI transparency and trust. Option E (incorrect) Closed-source development means the internal logic and implementation details of an AI model are proprietary and not publicly accessible, which inherently limits external scrutiny and understanding, thus reducing overall transparency.'
WHERE question_id = '60db7074-a242-48d0-8dfd-040a62b54f4b';

-- question_id: 60e6d31b-71c7-474d-9e71-4ead893d7fea
-- answer_correct: True | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) because while AWS DataSync can efficiently transfer data over AWS Direct Connect, DataSync itself incurs costs per GB transferred, and the fundamental cost reduction for ongoing data transfers from on-premises to S3 comes from establishing the Direct Connect link itself, which is addressed more directly by option D. Option B (incorrect) because S3 Transfer Acceleration is designed to speed up uploads over the public internet, not to reduce data transfer costs, and it actually adds to the transfer charges. Option C (incorrect) because AWS Snow family devices are primarily used for large-scale, one-time offline data migrations and are not a practical or cost-effective solution for ongoing, monthly 10TB data transfers due to the operational overhead of shipping physical devices. Option D (correct) because establishing AWS Direct Connect with a private Virtual Interface (VIF) provides a dedicated, private connection from on-premises to AWS, allowing data to be transferred to S3 at significantly lower costs than over the public internet, thus directly reducing ongoing data transfer costs and maintaining reliable uploads.'
WHERE question_id = '60e6d31b-71c7-474d-9e71-4ead893d7fea';

-- question_id: 61d2473e-2284-491e-8b50-e77748ac4942
-- answer_correct: False | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{3}'::integer[],
    explanation = 'Option A (incorrect) Amazon S3 Standard is designed for frequently accessed data with high durability and availability, making it significantly more expensive for rarely accessed archives than dedicated archival storage classes. Option B (incorrect) Amazon S3 Standard-Infrequent Access (S3 Standard-IA) is suitable for data accessed less frequently, but its storage cost is higher than deeper archive classes and it is not optimized for data accessed less than once a year. Option C (incorrect) Amazon S3 One Zone-Infrequent Access (S3 One Zone-IA) offers lower storage costs than S3 Standard-IA by storing data in a single Availability Zone, but it is still more expensive than S3 Glacier Deep Archive and does not meet the requirement for the absolute lowest possible cost for extremely infrequent access. Option D (correct) Amazon S3 Glacier Deep Archive is purpose-built for the lowest-cost storage of data that is rarely accessed (once or twice a year or less) and can tolerate retrieval times of several hours, perfectly aligning with the use case of large archives for compliance with the lowest possible storage cost.'
WHERE question_id = '61d2473e-2284-491e-8b50-e77748ac4942';

-- question_id: 61e68b45-0a74-40ed-8f28-ee3b9177b528
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) S3 Standard is too expensive for infrequently accessed data, and while Glacier Flexible Retrieval (formerly Glacier) meets the retrieval time, its cost is higher than Glacier Deep Archive for long-term archival, failing to minimize costs. Option 1 (incorrect) S3 Intelligent-Tiering introduces additional monitoring and automation charges per object, making it less cost-effective than a direct lifecycle policy for data with a known, infrequent access pattern. Option 2 (correct) S3 Standard-IA is cost-effective for infrequently accessed data that requires rapid access when needed, and Glacier Deep Archive offers the lowest storage cost for 7-year retention with its standard retrieval meeting the 12-hour requirement. Option 3 (incorrect) Direct upload to Glacier Deep Archive with bulk retrieval would not meet the "retrieved within 12 hours" requirement, as bulk retrievals from Glacier Deep Archive can take up to 48 hours.'
WHERE question_id = '61e68b45-0a74-40ed-8f28-ee3b9177b528';

-- question_id: 62d1320c-3f26-4210-8655-eb4140f8905c
-- answer_correct: True | verified_indices: [2] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While ECS can manage containers, running it on EC2 instances means you still provision and manage the underlying servers, which is not a serverless option and does not eliminate idle EC2 costs for intermittent workloads. Option B (incorrect) Although Fargate is a serverless compute engine for containers, EKS Fargate introduces the overhead of Kubernetes, and while serverless, for simple intermittent batch jobs, AWS Lambda typically offers a more granular pay-per-execution model and simpler management. Option C (correct) AWS Lambda is the ideal serverless compute option for intermittent workloads because it automatically scales to zero when not active and you only pay for the compute time consumed during execution, directly addressing idle time and high costs. Option D (incorrect) EC2 Spot Instances offer significant cost savings by utilizing spare EC2 capacity but are not a serverless compute option, as you still manage the underlying EC2 instances and they are subject to interruptions.'
WHERE question_id = '62d1320c-3f26-4210-8655-eb4140f8905c';

-- question_id: 62fabcee-45b4-4b99-a277-1e2ede00dd42
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The number of S3 buckets does not directly incur cost; S3 pricing is based on the data stored within them, requests made, and data transfer, not the count of buckets. Option B (correct) The amount of data stored, measured in GB-months, is the most significant cost factor for Amazon S3, with different storage classes offering varied per-GB pricing. Option C (incorrect) AWS Identity and Access Management (IAM), which includes the creation and management of access keys, is a free service and does not influence S3 costs. Option D (incorrect) While region selection does influence S3 costs by varying the per-GB storage rates and data transfer prices, it is not the *only* factor, as the fundamental cost is still driven by the actual amount of data stored, requests, and data transfer out.'
WHERE question_id = '62fabcee-45b4-4b99-a277-1e2ede00dd42';

-- question_id: 63b67858-93a2-4481-a64a-c22ce2e74e4e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Implementing tokenization typically replaces original sensitive data with non-sensitive tokens, which would require a separate process or vault access for auditors to retrieve the full unmasked data, adding complexity and not providing a unified role-based viewing of the same data asset. Option B (correct) AWS Lake Formation with cell-level filtering directly addresses these requirements by allowing specific column data (like credit card numbers) to be masked or unmasked dynamically based on the accessing user''s IAM role, ensuring data engineers see masked data while auditors see the full unmasked data from the same data lake tables. Option C (incorrect) Encrypting credit card columns with separate KMS keys where engineers lack decrypt permissions would prevent them from accessing or processing the credit card data in any form, including masked views, failing the requirement for them to run ETL jobs and query for debugging. Option D (incorrect) Storing credit card numbers in a separate encrypted S3 bucket with restricted IAM policies separates the data entirely, making it difficult for data engineers to process customer data *including* credit card numbers for ETL or debugging without complex re-integration, and requiring auditors to access and correlate data from disparate sources.'
WHERE question_id = '63b67858-93a2-4481-a64a-c22ce2e74e4e';

-- question_id: 6418bfec-ac58-4434-a706-f4ff252607ce
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config continuously monitors and records your AWS resource configurations and allows you to automate the evaluation of recorded configurations against desired configurations, but it does not provide network traffic monitoring or threat detection. Option B (incorrect) Amazon VPC allows you to provision a logically isolated section of the AWS Cloud where you can launch AWS resources, and while its VPC Flow Logs feature can capture metadata about IP traffic, Amazon VPC itself is a networking service and does not inherently provide threat detection capabilities. Option C (correct) Amazon GuardDuty is a threat detection service that continuously monitors for malicious activity and unauthorized behavior to protect your AWS accounts and workloads by analyzing data sources like VPC Flow Logs, AWS CloudTrail events, and DNS logs. Option D (incorrect) AWS CloudFormation allows you to model and provision all your AWS resources using infrastructure as code, but it is not a service for monitoring network traffic or detecting threats.'
WHERE question_id = '6418bfec-ac58-4434-a706-f4ff252607ce';

-- question_id: 6422e510-8686-4418-8659-6ecea4dc51e7
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Generative AI models, including foundational models available through Amazon Bedrock, require continuous updates, fine-tuning, and retraining with new data to maintain relevance, improve performance, and address evolving information or biases, rather than never needing updates. Option B (correct) Generative AI models, especially foundational models on AWS Bedrock or deployed via SageMaker, exhibit adaptability by allowing prompt engineering or fine-tuning with smaller datasets to perform various downstream tasks without the extensive computational cost and time of retraining a model from scratch for each new application. Option C (incorrect) Generative AI models are inherently stochastic and typically produce varied outputs even for identical inputs, particularly when configured for creativity, which can be controlled through parameters like temperature when interacting with models via AWS services. Option D (incorrect) Generative AI models are trained on massive datasets comprising text, images, or other modalities, requiring substantial data storage solutions like Amazon S3 and significant computational resources for initial training and ongoing fine-tuning on AWS.'
WHERE question_id = '6422e510-8686-4418-8659-6ecea4dc51e7';

-- question_id: 6481eab5-762c-4ed3-b256-2363c1484ac1
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Configuring Glue job auto-scaling dynamically adjusts DPU usage during processing to match workload demand, which can optimize efficiency and prevent over-provisioning but does not represent a distinct pricing model or offer specific discounts for flexible start times. Option B (correct) Switching to Glue Flex execution is specifically designed for non-time-sensitive batch jobs, offering up to 35% cost savings by allowing AWS Glue to opportunistically schedule jobs with a delayed start, perfectly aligning with the given flexible timing requirements. Option C (incorrect) Using Glue Python shell jobs instead of Spark is suitable only for small-scale data processing or orchestration tasks due to their lower DPU allocation (0.0625 DPU), making them impractical and inefficient for processing 800 GB of data daily. Option D (incorrect) AWS Glue DPU pricing is typically flat regardless of the time of day, meaning there are no specific "off-peak hour discounts" for standard DPU usage in the Glue pricing model.'
WHERE question_id = '6481eab5-762c-4ed3-b256-2363c1484ac1';

-- question_id: 64a19025-171a-4175-a867-df110dd0a160
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Glacier Instant Retrieval, while providing millisecond access, incurs retrieval costs per GB and per request which can quickly accumulate during extensive forensic analysis, potentially exceeding the cost of S3 Standard for the specific incident response window. Option B (correct) Keeping all 180 days in S3 Standard guarantees immediate millisecond access without any retrieval fees, providing the most reliable and often cost-effective solution when considering the total cost of ownership for critical incident response that requires frequent and rapid data access. Option C (incorrect) Glacier Flexible Retrieval with expedited retrieval still results in a retrieval time of 1-5 minutes, which does not meet the requirement for immediate (millisecond) access necessary for rapid incident response. Option D (incorrect) S3 Intelligent-Tiering automatically optimizes costs by moving data based on access patterns, but it would likely move older, less-accessed logs to the S3 Glacier Instant Retrieval tier, incurring retrieval fees similar to Option A, or potentially to colder archive tiers causing delays if not properly configured with an immediate access requirement in mind.'
WHERE question_id = '64a19025-171a-4175-a867-df110dd0a160';

-- question_id: 64ac3e8f-259c-49ef-8a39-a536a5bee7a2
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While using a LIKE operator with certain wildcard patterns (e.g., leading wildcards) on a partition column can prevent effective partition pruning by Athena, it does not universally bypass pruning for all LIKE operations, and it is not the most fundamental reason for a complete failure of partition pruning. Option B (correct) Athena relies entirely on the Glue Data Catalog for registered partition metadata; if partitions corresponding to the data are not registered (e.g., new data added without running MSCK REPAIR TABLE), Athena will perform a full table scan of the entire S3 path defined for the table, disregarding the WHERE clause for partition pruning and thus scanning significantly more data than expected. Option C (incorrect) A query syntax error in the WHERE clause would cause the Athena query to fail immediately with an error, preventing it from executing and scanning any data successfully, let alone excessive amounts. Option D (incorrect) An S3 bucket with too many small files increases the overhead for Athena due to file listing and opening many connections, leading to slower query performance and higher computational costs, but it does not directly cause Athena to scan a larger *volume* of data than it otherwise would if partition pruning were working correctly.'
WHERE question_id = '64ac3e8f-259c-49ef-8a39-a536a5bee7a2';

-- question_id: 651bdc16-8a4a-46ea-ba89-6c3d75646b63
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) CloudTrail logs both successful and failed API calls, providing a complete audit trail of all account activity, not just successful ones. Option B (correct) CloudTrail records most API calls made across AWS services in your account, including actions performed through the AWS Management Console, AWS SDKs, command line tools, and other AWS services. Option C (incorrect) CloudTrail captures events related to AWS service API calls, not detailed application-level logs generated by custom applications running within your AWS environment, which are typically handled by services like Amazon CloudWatch Logs. Option D (incorrect) CloudTrail focuses on recording API event history for auditing and compliance, while performance metrics for AWS resources are gathered and monitored by Amazon CloudWatch.'
WHERE question_id = '651bdc16-8a4a-46ea-ba89-6c3d75646b63';

-- question_id: 660d7068-7a0f-40da-a29a-e877fe2ca025
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] (incorrect) The role of human-in-the-loop is not to slow down processing but rather to enhance accuracy and reliability, even if a human step inherently introduces some latency compared to fully automated systems, as seen when using Amazon SageMaker Ground Truth for data labeling. Option [1] (correct) The primary role of human-in-the-loop in responsible AI is to provide essential oversight and validation for model predictions or data labeling, ensuring fairness, accuracy, and adherence to ethical guidelines, which is precisely what Amazon Augmented AI (Amazon A2I) enables by routing low-confidence predictions to human reviewers. Option [2] (incorrect) The role of human-in-the-loop is not to increase costs, but rather to mitigate risks and improve AI system quality, which can ultimately save costs by preventing errors, reputational damage, or regulatory non-compliance, with AWS services aiming to make HITL cost-effective through managed workflows. Option [3] (incorrect) The role of human-in-the-loop is not to complicate workflows, but to introduce a critical quality and ethical control point that services like Amazon A2I are designed to integrate seamlessly into existing AI pipelines, providing pre-built review mechanisms to streamline human involvement.'
WHERE question_id = '660d7068-7a0f-40da-a29a-e877fe2ca025';

-- question_id: 6618960d-c02f-48a6-b932-544fb4f2830d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Glue streaming ETL jobs typically operate with latencies in the order of seconds to minutes, which does not meet the sub-second latency requirement for live dashboards and anomaly detection. Option B (correct) Amazon Kinesis Data Analytics (Amazon Managed Service for Apache Flink) is purpose-built for real-time stream processing with sub-second latency, supports SQL or Apache Flink applications, and is a fully managed service. Option C (incorrect) Amazon EMR with Apache Spark Streaming processes data in micro-batches, making consistent sub-second latency challenging, and requires more operational management than a fully managed service like Kinesis Data Analytics. Option D (incorrect) Writing a custom application on Amazon EC2 violates the fully managed requirement, as it places the burden of infrastructure provisioning, scaling, patching, and application management on the user.'
WHERE question_id = '6618960d-c02f-48a6-b932-544fb4f2830d';

-- question_id: 664b8380-16c7-49b1-ad09-5ca38f418dd7
-- answer_correct: True | verified_indices: [0, 3] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Deploying a NAT Gateway in a public subnet allows instances in private subnets to initiate outbound connections to the internet while preventing unsolicited inbound connections, as the private subnet''s route table points internet-bound traffic to the NAT Gateway. Option B (incorrect) Using an Internet Gateway directly for private subnets exposes instances to the internet, as it provides both inbound and outbound access, which contradicts the requirement that instances should not be directly accessible from the internet. Option C (incorrect) AWS PrivateLink enables private connectivity to specific AWS services or endpoint services, not general outbound internet access to arbitrary internet hosts for software updates. Option D (correct) Configuring NAT Instances, typically deployed in a public subnet with a public IP and source/destination checks disabled, allows instances in private subnets to initiate outbound connections to the internet while preventing unsolicited inbound connections, serving as an older alternative to NAT Gateway. Option E (incorrect) VPC endpoints are used for private connectivity to supported AWS services like S3 or DynamoDB within the AWS network, and do not provide general internet connectivity for software updates from the broader internet.'
WHERE question_id = '664b8380-16c7-49b1-ad09-5ca38f418dd7';

-- question_id: 67ba0351-9dd4-432c-aff4-4117879709f8
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Tuning Spark''s `executor-memory` and `spark.executor.memoryOverhead` parameters in `spark-defaults` allows for more efficient utilization of the existing `m5.xlarge` instance''s 16 GiB of RAM, providing more memory to individual executors to prevent OutOfMemory errors without increasing the number or type of instances, thus keeping costs stable. Option B (incorrect) Adding more core nodes increases the cluster''s overall processing capacity and parallelism but does not directly address memory limits for individual executors running on the existing `m5.xlarge` instances, meaning the same memory errors would persist for demanding tasks, and it would significantly increase costs. Option C (incorrect) Using memory-optimized `r5.xlarge` instances (32 GiB RAM) would likely resolve the memory errors by providing more physical RAM per instance, but `r5.xlarge` instances are significantly more expensive than `m5.xlarge` instances, directly violating the "without increasing costs significantly" constraint. Option D (incorrect) Enabling dynamic allocation allows Spark to adjust the number of executors based on workload, which can improve resource utilization and potentially reduce costs during idle periods, but it does not increase the memory capacity of individual executors, so if a single executor requires more memory than it''s currently configured for, memory errors will still occur.'
WHERE question_id = '67ba0351-9dd4-432c-aff4-4117879709f8';

-- question_id: 681fbff0-11dc-4973-9084-a78b5447140b
-- answer_correct: False | verified_indices: [1, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1, 2}'::integer[],
    explanation = 'Option A (incorrect) Increasing the number of shards in the Kinesis stream improves the stream''s total write and read capacity, but it does not directly optimize the processing speed of individual consumer applications or address potential processing bottlenecks within them, and it increases Kinesis service costs. Option B (correct) Optimizing consumer applications to process records faster using batch processing significantly reduces overhead per record by processing multiple records in a single operation, directly addressing consumer lag cost-effectively. Option C (correct) Implementing parallel processing within consumers using multiple threads or asynchronous patterns allows individual consumer instances to process multiple records or batches concurrently, effectively increasing their processing throughput and reducing lag without additional Kinesis service costs. Option D (incorrect) Switching to enhanced fan-out consumers is explicitly stated in the question as exceeding budget constraints, making it an unsuitable solution for cost-effectively reducing consumer lag.'
WHERE question_id = '681fbff0-11dc-4973-9084-a78b5447140b';

-- question_id: 68e8afc8-cd4a-4555-aca7-61b2849a69cc
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Elastic IPs generally incur costs, especially if they are not associated with a running EC2 instance, thus not primarily designed to reduce costs. Option B (correct) An Elastic IP address is a static, public IPv4 address that can be remapped quickly to another EC2 instance or network interface in the event of an instance failure, providing fault tolerance. Option C (incorrect) Elastic IPs do not directly increase the performance (e.g., CPU, memory, network throughput) of an EC2 instance; performance is determined by the instance type and network configuration. Option D (incorrect) Elastic IPs are public IP addresses used for external communication, whereas private IP addresses are used for communication within an Amazon Virtual Private Cloud (VPC).'
WHERE question_id = '68e8afc8-cd4a-4555-aca7-61b2849a69cc';

-- question_id: 690f9655-8760-43c0-a9d1-9f00bfb4e5f8
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS PrivateLink establishes private connections within the AWS network and explicitly avoids routing traffic over the public internet, which is typically facilitated by Internet Gateways for inbound public access or NAT Gateways for outbound public access. Option B (correct) AWS PrivateLink enables private and secure connectivity between your Amazon Virtual Private Cloud (VPC) and AWS services, services hosted by other AWS accounts (VPC Endpoint Services), and on-premises applications without requiring traffic to traverse the public internet. Option C (incorrect) Data compression is a feature often handled at the application layer, by specific storage services like Amazon S3, or within database engines, and is not a core function provided by AWS PrivateLink, which focuses on network isolation and private connectivity. Option D (incorrect) Model training is a machine learning workflow performed by specialized AWS services such as Amazon SageMaker, or by compute instances like Amazon EC2 running ML frameworks, and is entirely unrelated to the network connectivity and security functions of AWS PrivateLink.'
WHERE question_id = '690f9655-8760-43c0-a9d1-9f00bfb4e5f8';

-- question_id: 6950b084-a1e4-4bdb-aa75-e5c3a3776af0
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS DMS Serverless automatically scales replication capacity up or down based on the actual data change volume, eliminating fixed instance costs during periods of low activity and charging only for consumed capacity, which perfectly matches variable workloads. Option B (incorrect) Traditional DMS replication instances do not offer automatic scaling of instance size based on workload, and reducing the instance size for a continuous workload would still incur fixed costs and potentially lead to performance issues during peak times. Option C (incorrect) Scheduling DMS tasks to stop and start manually or via automation adds operational complexity, may break the continuous replication requirement, and the underlying replication instance would still run continuously unless also manually managed. Option D (incorrect) Implementing DMS Multi-AZ enhances high availability by providing a standby instance in another Availability Zone, which *increases* costs rather than reducing them, as you pay for redundant resources.'
WHERE question_id = '6950b084-a1e4-4bdb-aa75-e5c3a3776af0';

-- question_id: 69538d75-5d2f-4ac0-a453-60a1ef608f76
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Logistic regression is a classification algorithm used in AWS SageMaker to predict probabilities for discrete outcomes, like whether an event will occur (binary classification). Option B (correct) Linear regression is a regression algorithm explicitly designed for predicting continuous numerical values, such as forecasting sales figures using Amazon SageMaker''s built-in Linear Learner algorithm. Option C (incorrect) Decision trees for classification is an algorithm used in AWS SageMaker to categorize data into discrete classes, not to predict a continuous numerical output. Option D (incorrect) K-means clustering is an unsupervised learning algorithm in AWS SageMaker used for grouping similar data points into clusters without predicting a specific target value.'
WHERE question_id = '69538d75-5d2f-4ac0-a453-60a1ef608f76';

-- question_id: 69c7bb92-371a-4932-91f4-984a16b32397
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Compute optimized instances, such as the C series, are designed for applications that benefit from high-performance processors, not primarily for large memory capacity. Option B (correct) Memory optimized instances, such as the R series or X series, are specifically designed to deliver fast performance for workloads that process large datasets in memory, making them ideal for high memory capacity requirements. Option C (incorrect) Storage optimized instances, such as the I series or D series, are designed for workloads that require high, sequential read and write access to very large datasets on local storage, not their in-memory capacity. Option D (incorrect) Accelerated computing instances, such as the P series or G series, use hardware accelerators like GPUs or FPGAs to perform functions more efficiently than CPUs, targeting specialized workloads like machine learning or graphics, not general high memory capacity.'
WHERE question_id = '69c7bb92-371a-4932-91f4-984a16b32397';

-- question_id: 69ccd854-3d78-4046-9184-4b74f594ea3c
-- answer_correct: True | verified_indices: [1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon ElastiCache does not use SQL, tables, rows, or predefined schemas for data storage like relational databases such as Amazon RDS or Amazon Aurora. Option B (correct) Amazon ElastiCache supports Redis and Memcached, both of which are key-value stores that fall under the broader category of NoSQL databases, offering flexible schemas and high performance. Option C (incorrect) While Amazon ElastiCache''s primary function is an in-memory caching service to improve application performance, "in-memory cache" describes its operational characteristic and primary use case rather than its fundamental database type, which is encompassed by NoSQL. Option D (incorrect) Amazon ElastiCache is not designed for complex analytical queries over large historical datasets like Amazon Redshift; instead, it provides high-speed data retrieval for operational workloads.'
WHERE question_id = '69ccd854-3d78-4046-9184-4b74f594ea3c';

-- question_id: 69d7f997-de44-497c-be09-2fb275f13072
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Custom widgets are elements used to display data within a dashboard but do not, by themselves, provide the mechanism for sharing the entire dashboard across accounts or regions. Option B (correct) CloudWatch Shared Dashboards are specifically designed to aggregate operational metrics into a centralized view and provide a direct mechanism for sharing that view with other users, accounts, or even publicly (with appropriate permissions) and can display data from multiple accounts and regions. Option C (incorrect) Metric Explorer is a tool for ad-hoc querying and visualizing metrics to discover insights, not for creating persistent, centralized, and easily shareable dashboards for broad stakeholder consumption across accounts and regions. Option D (incorrect) An Alarm status display is a specific component within a dashboard used to monitor the state of CloudWatch alarms, but it does not encompass the broader requirement of a centralized view for all operational metrics or the mechanism for sharing that view across accounts and regions.'
WHERE question_id = '69d7f997-de44-497c-be09-2fb275f13072';

-- question_id: 69d7fbe2-7f70-4f9b-b9d9-4aad0c810fc8
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The AWS Well-Architected Framework helps customers design and operate reliable, secure, efficient, cost-effective, and sustainable systems *in* the AWS Cloud, primarily focusing on improving existing or newly deployed cloud workloads, not assessing initial readiness for cloud adoption. Option B (correct) The AWS Cloud Adoption Framework (AWS CAF) provides guidance across six perspectives (Business, People, Governance, Platform, Security, Operations) to help organizations develop a comprehensive plan for cloud adoption and transformation, directly assessing their readiness and planning for the journey. Option C (incorrect) There is no standalone official "AWS Security Framework" for assessing overall cloud adoption readiness; instead, security is a crucial pillar within the AWS Well-Architected Framework and a key perspective within the AWS Cloud Adoption Framework, supported by various AWS security services like AWS IAM, GuardDuty, and Security Hub. Option D (incorrect) While AWS provides numerous tools and services for the migration process itself (e.g., AWS Application Migration Service, AWS Database Migration Service), there isn''t a broadly named "AWS Migration Framework" that encompasses the holistic assessment of readiness for cloud adoption across all organizational dimensions like business, people, and governance, which is the purview of the AWS CAF.'
WHERE question_id = '69d7fbe2-7f70-4f9b-b9d9-4aad0c810fc8';

-- question_id: 69e748a8-3f35-4efd-ba99-e8147c901149
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Security Groups and NACLs are used for filtering traffic at the instance (Security Group) or subnet (NACL) level, acting as virtual firewalls, but they are not the primary components for defining IP address ranges or the initial logical segmentation of a network. Option B (incorrect) Regions and Availability Zones define the physical geographical distribution and fault tolerance of AWS infrastructure, not the fundamental networking components for IP addressing or traffic isolation within a single VPC. Option C (correct) Subnets are logical subdivisions of a VPC''s IP address range, providing IP addressing for resources and creating distinct logical components, while Route Tables control the traffic flow between these subnets and other destinations. Option D (incorrect) Direct Connect and VPN are services used to establish connectivity between an AWS VPC and on-premises networks, not for segmenting the network or handling IP addressing within the VPC itself.'
WHERE question_id = '69e748a8-3f35-4efd-ba99-e8147c901149';

-- question_id: 69ed79a7-65d8-4da7-bb60-9633796c03f5
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Encryption in transit safeguards data confidentiality during transmission, whereas data corruption is primarily protected by data integrity checks and redundant storage systems, such as S3''s built-in object integrity validation. Option 1 (correct) Encryption in transit uses protocols like TLS/SSL to protect data from unauthorized interception and access while it moves between locations, ensuring confidentiality as implemented by AWS services such as Application Load Balancers or S3 with HTTPS. Option 2 (incorrect) Encryption in transit secures data''s confidentiality during movement, while protection against hardware failures is provided by redundancy, fault tolerance, and multi-AZ deployments, as seen with Amazon RDS Multi-AZ configurations. Option 3 (incorrect) Encryption in transit secures data confidentiality but does not address high latency, which is typically mitigated by network optimizations, using Content Delivery Networks like Amazon CloudFront, or selecting optimal AWS regions and Availability Zones.'
WHERE question_id = '69ed79a7-65d8-4da7-bb60-9633796c03f5';

-- question_id: 6aaca368-9b3d-4f82-8676-b972f4bc79cd
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Data augmentation for underrepresented groups helps increase the representation of minority classes or groups by creating synthetic but realistic examples, which can be implemented as a preprocessing step using AWS SageMaker Processing or during training data preparation using services like AWS Glue, improving model fairness and reducing representation bias. Option B (correct) Balanced sampling strategies, such as oversampling minority classes or undersampling majority classes, help ensure that the model is exposed to a proportional representation of all relevant groups or classes, which can be managed during data loading for SageMaker training jobs or via SageMaker Processing for dataset transformation, directly addressing sampling bias and class imbalance. Option C (incorrect) Using only majority class data exacerbates bias by completely ignoring minority classes or groups, leading to a model that discriminates against or performs poorly on those underrepresented populations, directly contradicting AWS responsible AI principles which advocate for fair and inclusive models. Option D (incorrect) Ignoring demographic information prevents the detection and understanding of existing biases in the dataset and model, as services like AWS SageMaker Clarify specifically require sensitive attribute information to detect and measure pre-training bias and group disparities, which is crucial for building fair machine learning systems. Option E (incorrect) Random data deletion does not strategically mitigate specific biases and can inadvertently remove valuable data points from underrepresented groups or reduce overall data quality, potentially worsening existing biases rather than resolving them.'
WHERE question_id = '6aaca368-9b3d-4f82-8676-b972f4bc79cd';

-- question_id: 6aaf26d1-f782-4dc6-9d75-9e5951546fc8
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Kinesis is primarily a real-time streaming data ingestion and processing service, not a service designed for batch transformation and preparation of data for subsequent analytics. Option B (correct) AWS Glue is a serverless ETL (Extract, Transform, Load) service specifically designed to discover, cleanse, transform, and prepare data for analytics workloads. Option C (incorrect) Amazon Athena is an interactive query service that allows you to analyze data directly in Amazon S3 using SQL, but it does not perform the transformation and preparation of the data itself. Option D (incorrect) Amazon QuickSight is a business intelligence (BI) service used for creating interactive dashboards and visualizations from prepared data, not for transforming or preparing the data itself.'
WHERE question_id = '6aaf26d1-f782-4dc6-9d75-9e5951546fc8';

-- question_id: 6ad26881-012e-45da-900c-2130f014df0d
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Data transfer into AWS from the internet is generally free for most AWS services, as AWS primarily charges for data egress from its network. Option 1 (incorrect) Data transfer between AWS services or EC2 instances within the same Availability Zone (AZ) is typically free, promoting highly available architectures within a single AZ without incurring data transfer costs. Option 2 (correct) Data transfer out from AWS to the internet (egress) typically incurs the highest charges, as AWS levies fees for data leaving its global network perimeter to the public internet. Option 3 (incorrect) Data transfer between AWS services in the same region, particularly if across different Availability Zones, incurs a charge, but these inter-AZ charges are significantly lower than the cost of data transfer out to the internet.'
WHERE question_id = '6ad26881-012e-45da-900c-2130f014df0d';

-- question_id: 6b1af64a-13d4-4642-bce8-85a09d98b229
-- answer_correct: False | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{3}'::integer[],
    explanation = 'Option A (incorrect) Refactor is incorrect because the question specifies that the vendor will *first* rehost the application on Amazon EC2, rather than immediately re-architecting the entire application. Option B (incorrect) Repurchase is incorrect because the vendor is moving and modernizing their existing application, not replacing it with a third-party Software-as-a-Service (SaaS) solution. Option C (incorrect) Retain is incorrect because the vendor is explicitly moving their application to AWS EC2, which contradicts keeping it on-premises indefinitely. Option D (correct) A phased approach combining Rehost and Refactor is correct because the initial move to Amazon EC2 represents a Rehost (lift-and-shift) strategy for immediate benefits, followed by gradually breaking it down into microservices using AWS Lambda and Amazon ECS, which is a Refactor (re-architect) strategy.'
WHERE question_id = '6b1af64a-13d4-4642-bce8-85a09d98b229';

-- question_id: 6b1b8b41-7bf9-4a3a-8a00-1a84368fa805
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While Amazon Redshift is a data warehouse solution using columnar storage suitable for complex queries, even with Reserved Instances, it involves provisioning and managing a cluster, incurring continuous costs that can be less cost-effective than serverless solutions for predictable batch processing windows. Option B (correct) Amazon Athena is a serverless query service that allows querying petabyte-scale data directly in S3, paying only for the data scanned (minimized by partitioned data and columnar formats like Parquet), perfectly balancing cost-effectiveness and performance for predictable batch processing without managing infrastructure. Option C (incorrect) Amazon EMR with Apache Spark on Spot instances is powerful for large-scale distributed processing and cost-effective for fault-tolerant workloads, but it still requires cluster management and is generally a more complex and feature-rich solution than strictly needed for a cost-optimized data warehousing query solution for existing data. Option D (incorrect) Amazon RDS is a relational database service best suited for transactional workloads, not for petabyte-scale analytical data warehousing, and does not natively support columnar storage optimization for such workloads.'
WHERE question_id = '6b1b8b41-7bf9-4a3a-8a00-1a84368fa805';

-- question_id: 6b8c4619-c83e-4fa8-8ffb-48defc8bd5d7
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) CloudWatch is primarily used for monitoring operational metrics and logs, not for detailed, comprehensive cost analysis and allocation directly from billing data, and creating such dashboards would be complex and inefficient for this purpose. Option B (correct) AWS Cost Explorer, especially when used with cost allocation tags that are applied to resources and then aggregated, provides a powerful native solution for detailed cost visibility and attribution across multiple accounts with minimal ongoing management. Option C (incorrect) Implementing third-party cost management tools can offer advanced features but introduces additional costs, integration complexity, and ongoing management overhead, which contradicts the "minimal ongoing management" requirement. Option D (incorrect) Exporting billing data to S3 and analyzing it with custom tools (like AWS CURs with Athena/QuickSight) provides ultimate flexibility but requires significant upfront development, ongoing maintenance of the analytical pipeline, and specialized expertise, thus not meeting the "minimal ongoing management" criterion.'
WHERE question_id = '6b8c4619-c83e-4fa8-8ffb-48defc8bd5d7';

-- question_id: 6b9dd72f-b896-4ffc-aac0-06895df48145
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Semi-supervised learning leverages both a small amount of labeled data and a large amount of unlabeled data, which is a common approach when using services like Amazon SageMaker for model training where acquiring fully labeled datasets via Amazon SageMaker Ground Truth can be costly or time-consuming. Option B (incorrect) Training with only labeled data describes supervised learning, a technique widely supported by AWS SageMaker built-in algorithms like XGBoost or Linear Learner for tasks such as classification and regression. Option C (incorrect) Training with only unlabeled data describes unsupervised learning, a technique such as clustering or dimensionality reduction often implemented using AWS SageMaker''s K-Means or PCA algorithms to discover patterns in raw data stored in Amazon S3. Option D (incorrect) Machine learning models inherently require data for training and evaluation, meaning "no data needed" is fundamentally incorrect for any machine learning paradigm, including those deployed and managed on AWS.'
WHERE question_id = '6b9dd72f-b896-4ffc-aac0-06895df48145';

-- question_id: 6ba06969-0361-4105-80e3-3b9a1d2cc6f1
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS AI services like Amazon Rekognition and Amazon Comprehend provide content moderation capabilities that, when integrated with Amazon Augmented AI (A2I), enable multi-layered filtering and human review workflows to ensure the safety and appropriateness of generated content before it reaches end-users. Option B (incorrect) AWS strongly advocates for responsible AI practices, which include implementing robust safeguards and filters to prevent the generation or dissemination of harmful, biased, or inappropriate content, making the absence of filters a dangerous and non-compliant approach. Option C (incorrect) Random generation does not inherently ensure content safety and can, in fact, inadvertently produce unsafe or undesirable outputs, contrasting with AWS''s focus on controlled and evaluated AI systems developed using services like Amazon SageMaker with built-in validation. Option D (incorrect) Allowing unrestricted output from content generation models goes against AWS''s responsible AI principles and could lead to the creation of harmful or undesirable content, necessitating strict controls and guardrails implemented through pre-processing, post-processing, and human oversight, rather than an absence of restrictions.'
WHERE question_id = '6ba06969-0361-4105-80e3-3b9a1d2cc6f1';

-- question_id: 6ba17b01-3069-475c-bcb2-24ef95f7ad4d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Prompt injection is not a performance optimization technique, as it focuses on manipulating AI model behavior through crafted inputs rather than improving the speed or efficiency of AI inference on services like Amazon SageMaker. Option B (correct) Prompt injection is indeed a security vulnerability where malicious inputs manipulate model behavior, allowing an attacker to bypass safety measures or elicit unintended responses from AI models, similar in concept to how AWS WAF protects web applications from injection attacks, but specifically targeting large language models (LLMs) available via Amazon Bedrock. Option C (incorrect) Prompt injection is not a data compression method, as its purpose is to exploit AI systems by altering their output through adversarial prompts, fundamentally unrelated to reducing the size of data stored in services like Amazon S3 or transmitted over AWS Direct Connect. Option D (incorrect) Prompt injection is not a model training technique; it is a post-training attack vector that occurs during the inference phase when a user interacts with a deployed AI model, rather than during the developmental stages involving data preparation and model fine-tuning in Amazon SageMaker.'
WHERE question_id = '6ba17b01-3069-475c-bcb2-24ef95f7ad4d';

-- question_id: 6c0b9fd9-fd86-4e7b-aba6-a6e2f35ab1d6
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Standard is designed for frequently accessed data with millisecond retrieval times, making it unsuitable for long-term archival with retrieval times of hours. Option B (incorrect) S3 Standard-IA is designed for infrequently accessed data requiring rapid access, offering millisecond retrieval times rather than multi-hour retrieval. Option C (correct) S3 Glacier Flexible Retrieval is specifically designed for long-term archival of data that is rarely accessed, offering various retrieval options including Standard (3-5 hours) and Bulk (5-12 hours). Option D (incorrect) S3 Intelligent-Tiering is designed to optimize storage costs by automatically moving data between access tiers based on changing patterns, not as a primary direct storage class for long-term archival with guaranteed hours-long retrieval from initial storage.'
WHERE question_id = '6c0b9fd9-fd86-4e7b-aba6-a6e2f35ab1d6';

-- question_id: 6c0e2849-69c3-419e-b8f9-a0876533a6de
-- answer_correct: True | verified_indices: [1, 2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS KMS CMKs have a mandatory waiting period (7-30 days) before key material deletion, which violates the "immediate key deletion capability" requirement. Option B (correct) AWS CloudHSM provides dedicated, customer-controlled HSMs for generating and managing keys, supports cross-region key synchronization for disaster recovery, and allows for immediate deletion of key material as the customer has direct control. Option C (correct) AWS Secrets Manager provides robust, automated rotation for database credentials and other application secrets, which is a critical component for securing access to patient data and fulfilling the "support automated key rotation" requirement for secrets in a broader security solution. Option D (incorrect) AWS Certificate Manager focuses on managing SSL/TLS certificates for encrypting data in transit and authentication, not the encryption keys for patient data at rest. Option E (incorrect) While Parameter Store can store secrets encrypted by KMS, it lacks the advanced automated rotation features of Secrets Manager and does not meet the "immediate key deletion capability" requirement for the underlying KMS keys.'
WHERE question_id = '6c0e2849-69c3-419e-b8f9-a0876533a6de';

-- question_id: 6c1e233a-0d03-4cb5-8159-0b87a7e00956
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) Amazon Cognito with advanced security features and risk-based authentication directly provides capabilities to detect suspicious login patterns, implement adaptive authentication based on risk scores, and challenge only high-risk attempts with MFA or CAPTCHA, thus maintaining a seamless experience for legitimate users and protecting against credential stuffing. Option B (incorrect) AWS WAF with rate-based rules and IP reputation lists can block high-volume attacks and known bad IPs at the network edge but lacks the behavioral analysis, user-specific risk scoring, and adaptive authentication features needed to detect nuanced credential stuffing patterns and respond intelligently without impacting legitimate users. Option C (incorrect) Amazon GuardDuty monitors AWS accounts and resources for malicious activity and unauthorized behavior but is not designed to be a frontline, real-time identity provider or to implement adaptive authentication for application login attempts. Option D (incorrect) API Gateway with throttling limits and custom authorizers can enforce basic rate limits and integrate with authentication logic, but it does not inherently offer advanced security features like behavioral pattern detection, risk-based authentication, or compromised credential detection required for comprehensive protection against credential stuffing attacks.'
WHERE question_id = '6c1e233a-0d03-4cb5-8159-0b87a7e00956';

-- question_id: 6c367e4a-fb6a-468e-8bc7-746c7add75d5
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon CloudWatch is a monitoring and observability service that collects metrics, logs, and events from AWS resources and applications, but its primary function is not to track configuration changes or compliance status. Option B (correct) AWS Config continuously monitors and records the configuration of AWS resources, tracks changes over time, and evaluates these configurations against desired compliance rules and best practices. Option C (incorrect) AWS CloudTrail provides an audit trail of API calls and related events made in your AWS account, showing who did what and when, but it does not track the actual configuration changes or compliance status of resources. Option D (incorrect) AWS Systems Manager is a suite of tools for operational control and management of AWS resources, including patching, automation, and remote command execution, but it is not specifically designed for tracking configuration changes and compliance status across all AWS resources.'
WHERE question_id = '6c367e4a-fb6a-468e-8bc7-746c7add75d5';

-- question_id: 6c59dfc2-6814-46bb-a073-291f113edbe9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using shared service accounts increases the blast radius because if the credentials for a single shared account are compromised, all resources and services that rely on it become vulnerable, making containment and remediation more complex. Option B (correct) Applying the principle of least privilege ensures that an IAM user or role has only the minimum necessary permissions, so if its credentials are compromised, an attacker''s access is strictly limited to a narrow scope of actions and resources, effectively reducing the potential damage. Option C (incorrect) Granting administrative access by default dramatically increases the blast radius because if those credentials are compromised, an attacker gains full control over the entire AWS account, allowing for maximum potential damage. Option D (incorrect) Relying on long-term credentials only increases the blast radius as they are harder to rotate frequently and provide persistent access to an attacker if compromised, whereas temporary credentials from IAM roles or AWS STS inherently limit the duration of access.'
WHERE question_id = '6c59dfc2-6814-46bb-a073-291f113edbe9';

-- question_id: 6c5ca630-db73-48bb-8632-52c0e53ce26c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increasing the compute capacity of the single database instance improves performance but does not eliminate a single point of failure, as the application would still go down if that sole instance or its Availability Zone fails. Option B (incorrect) Implementing database backups to Amazon S3 nightly provides data durability and a recovery point, but it does not prevent downtime if the primary instance fails, as a restore process would still be required. Option C (correct) Enabling multi-AZ deployment with synchronous replication for the database, such as with Amazon RDS, automatically provisions a standby replica in another Availability Zone, allowing for automatic failover and significantly improving availability by eliminating the single point of failure. Option D (incorrect) Migrating the database to an on-premises server shifts the operational responsibility and does not inherently eliminate a single point of failure, as it introduces new infrastructure management challenges and potential points of failure outside of AWS''s managed services for high availability.'
WHERE question_id = '6c5ca630-db73-48bb-8632-52c0e53ce26c';

-- question_id: 6c604014-46fa-4c28-865e-ce6bc2e48b26
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Accuracy is a metric used for classification models, measuring the proportion of correct predictions out of the total, which is not applicable when predicting a continuous numerical value like house prices, unlike AWS SageMaker''s text classification or image classification algorithms that would utilize it. Option B (incorrect) F1 Score is a classification metric that combines precision and recall, often used for imbalanced datasets in classification tasks, and thus irrelevant for evaluating a regression model predicting house prices, unlike how AWS Comprehend Custom classification models might report it. Option C (correct) Root Mean Squared Error (RMSE) is a standard and highly appropriate metric for regression models, as it quantifies the average magnitude of the errors between predicted and actual house prices in the same units as the target variable, a common evaluation metric provided by AWS SageMaker built-in algorithms like XGBoost or Linear Learner when performing regression. Option D (incorrect) Precision is a classification metric indicating the proportion of positive predictions that were truly positive, making it unsuitable for assessing the performance of a regression model predicting continuous house prices, unlike its use in evaluating AWS Rekognition''s object detection or image moderation outputs.'
WHERE question_id = '6c604014-46fa-4c28-865e-ce6bc2e48b26';

-- question_id: 6c77075f-8982-4267-97c5-59a1dc10c4e6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Random errors in predictions are typically statistical noise or variance that can be mitigated through larger datasets or robust model training techniques like cross-validation, often managed through Amazon SageMaker''s data processing and training jobs, rather than systematic unfairness. Option B (correct) Algorithmic bias refers to persistent and reproducible prejudice or discrimination embedded in an ML model''s output due to biased training data or flawed algorithms, which AWS addresses with services like Amazon SageMaker Clarify to detect and mitigate bias throughout the ML lifecycle. Option C (incorrect) Hardware limitations, such as insufficient GPU memory or CPU cores, primarily impact model training speed and capacity but do not inherently cause systematic unfairness in the model''s decision-making process, which AWS customers can address by scaling compute resources on Amazon EC2 or using SageMaker managed infrastructure. Option D (incorrect) Network latency issues affect the speed of data transfer and model inference response times, impacting application performance and user experience, but they are distinct from the inherent fairness or unfairness embedded within the model''s predictions, which AWS optimizes with services like Amazon CloudFront and AWS Global Accelerator.'
WHERE question_id = '6c77075f-8982-4267-97c5-59a1dc10c4e6';

-- question_id: 6cc54063-f649-4b96-a599-0c859f57285c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Cloud infrastructure is elastic and programmable, allowing resources to be dynamically provisioned and scaled using services like Amazon EC2 Auto Scaling or AWS Lambda, which contradicts the idea of "fixed" infrastructure. Option B (incorrect) Cloud computing heavily emphasizes automation through services like AWS CloudFormation for Infrastructure as Code, AWS CodePipeline for CI/CD, and AWS Systems Manager for operational tasks, which significantly reduces reliance on manual processes. Option C (correct) AWS enables self-service provisioning through its console, APIs, and CLI, allowing developers to instantly provision resources like EC2 instances, S3 buckets, or RDS databases without waiting for IT gatekeepers, thus accelerating development and experimentation. Option D (incorrect) AWS offers a vast and continually expanding portfolio of services across various domains like compute (EC2, Lambda), storage (S3, EBS), databases (RDS, DynamoDB), and machine learning (SageMaker), providing developers with abundant tools to innovate, contrary to limited options.'
WHERE question_id = '6cc54063-f649-4b96-a599-0c859f57285c';

-- question_id: 6ce63092-7354-4d2d-9825-433562bff099
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Infrastructure is never free, as AWS operates on a pay-as-you-go model where you are charged for the resources consumed, such as EC2 instance hours or S3 storage capacity. Option B (correct) This precisely describes the AWS pay-as-you-go model, where you only pay for the compute, storage, and networking resources you actually use, eliminating the need for large upfront hardware purchases or data center build-outs. Option C (incorrect) Cloud costs are highly variable and depend directly on the amount of resources consumed, so the bill will fluctuate based on usage of services like EC2, S3, or Lambda, making it unlikely to pay the exact same amount. Option D (incorrect) Cloud computing often reduces the total cost of ownership (TCO) by eliminating capital expenditures, offering economies of scale, and optimizing operational expenses compared to traditional on-premises infrastructure.'
WHERE question_id = '6ce63092-7354-4d2d-9825-433562bff099';

-- question_id: 6ceeaf8d-9195-420e-8aa7-0a44166ae518
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Glue job bookmarks track processed data to enable incremental processing by preserving the state of previous job runs, not to provide detailed data lineage about transformations applied, columns modified, or specific data flow within a job. Option B (incorrect) AWS CloudTrail logs API calls and management events for AWS Glue services, such as creating or starting jobs, but it does not track data plane operations like the actual data transformations, column-level changes, or data flow within a running Glue job. Option C (correct) AWS Glue DataBrew offers automatic, visual, and comprehensive lineage tracking for transformations performed within its recipes, detailing the source datasets, every transformation step applied, and the resulting output datasets, which satisfies the need for audit and impact analysis. Option D (incorrect) Implementing custom logging within Glue jobs to write lineage to DynamoDB is a manual, bespoke solution that requires significant development and maintenance effort, rather than an automatic, out-of-the-box AWS capability for data lineage tracking.'
WHERE question_id = '6ceeaf8d-9195-420e-8aa7-0a44166ae518';

-- question_id: 6cf055c6-5a7c-4dd1-a6ab-f2ce5f5ba9ab
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Prompt engineering allows leveraging the deep domain knowledge already embedded within a foundational model, but if a new, specific deep domain knowledge needs to be *ingested and specialized* into the model itself for consistent, nuanced responses, fine-tuning a model on Amazon SageMaker or via Bedrock''s Custom Models feature is generally preferred. Option B (correct) Prompt engineering is preferred when quick iteration and testing is required because changes to prompts can be implemented and evaluated immediately with foundational models on Amazon Bedrock or SageMaker endpoints, without the need for time-consuming data preparation, training jobs, or model deployments inherent to fine-tuning. Option C (incorrect) Permanent model changes, where the underlying weights of the model are modified to inherently learn new behaviors or data patterns, are achieved through fine-tuning a model (e.g., using Amazon SageMaker''s training capabilities or Bedrock''s Custom Models feature), not through prompt engineering. Option D (incorrect) When training data is abundant and high-quality, fine-tuning is typically the preferred method to specialize a foundational model (e.g., a Titan model on Bedrock or an open-source model on SageMaker) by leveraging that data to permanently embed specific knowledge or task performance, which prompt engineering alone cannot achieve.'
WHERE question_id = '6cf055c6-5a7c-4dd1-a6ab-f2ce5f5ba9ab';

-- question_id: 6d258754-7e56-4e4c-a974-df1f652d60dd
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) High availability ensures an application remains accessible and operational despite failures, typically through redundant resources across multiple Availability Zones, but it does not specifically address scaling resources up and down to match fluctuating demand. Option B (correct) Elasticity allows an e-commerce company to automatically scale compute resources, like EC2 instances managed by AWS Auto Scaling, up during Black Friday spikes and down during off-peak periods, efficiently avoiding over-provisioning and associated costs. Option C (incorrect) Durability refers to the long-term preservation and integrity of data, exemplified by services like Amazon S3 which is designed for 99.999999999% durability, and is unrelated to handling traffic spikes or resource scaling. Option D (incorrect) Global reach describes the ability to deploy applications and data across multiple AWS Regions worldwide to serve a global user base with low latency and meet data residency requirements, which is distinct from dynamically adjusting resources for traffic fluctuations.'
WHERE question_id = '6d258754-7e56-4e4c-a974-df1f652d60dd';

-- question_id: 6d3e53e9-2e3d-4566-80eb-5180d48327d9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While Savings Plans offer substantial cost reductions, they do not inherently guarantee universally higher discounts compared to the best traditional Reserved Instance pricing, as the primary advantage of Savings Plans is their flexibility across compute usage. Option B (correct) Compute Savings Plans uniquely apply their discounted rate to usage across various EC2 instance families, sizes, operating systems, and tenancies, as well as to AWS Fargate and AWS Lambda usage, offering a level of flexibility traditional EC2 Reserved Instances cannot match. Option C (incorrect) Both Compute Savings Plans and traditional Reserved Instances offer the same standard commitment periods of one year or three years, meaning Savings Plans do not provide inherently shorter commitment options. Option D (incorrect) Both Compute Savings Plans and traditional Reserved Instances support "No Upfront" payment options, allowing users to pay monthly without an initial lump sum, so this is not a unique flexibility advantage of Savings Plans.'
WHERE question_id = '6d3e53e9-2e3d-4566-80eb-5180d48327d9';

-- question_id: 6d83054a-1094-4ad3-b5d7-3d81208f966b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increasing the shard count to 200 shards would only increase the write capacity to 200,000 records/second and 200 MB/second, which is still insufficient to meet the required 500,000 records/second and 1 GB/second, thus not fully resolving the write throttling. Option B (correct) Switching to Kinesis Data Streams on-demand mode automatically scales the stream''s write capacity based on observed throughput, effectively eliminating write throttling without manual shard management or capacity calculations. Option C (incorrect) Implementing client-side batching with the PutRecords API optimizes the number of API calls but does not increase the underlying shard capacity limits of records per second or MB per second, therefore it will not resolve the write throttling issue. Option D (incorrect) Enabling enhanced fan-out is a consumer-side feature that provides dedicated read throughput for consumers and does not affect the write capacity of the Kinesis Data Stream, thus it will not alleviate write throttling on the producer side.'
WHERE question_id = '6d83054a-1094-4ad3-b5d7-3d81208f966b';

-- question_id: 6db2b9a9-e33c-4f6a-9cf6-aa279e09f305
-- answer_correct: True | verified_indices: [0] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Asynchronous API calls prevent the streaming pipeline from blocking on high-latency external requests, maintaining throughput, while connection pooling optimizes resource utilization and caching (e.g., with Amazon ElastiCache) reduces the need for slow external calls. Option B (incorrect) Synchronous API calls will cause the streaming pipeline to block for up to 2 seconds per enrichment, severely impacting throughput, even with timeout and retry logic which only adds overhead. Option C (incorrect) Pre-fetching API data to DynamoDB for lookup is a good strategy to avoid external API calls but does not address how to handle variable latency for calls that cannot be pre-fetched, and may be impractical for highly dynamic or large datasets. Option D (incorrect) Batching events and making bulk API requests can reduce overhead but still risks having the entire batch block if any part of the bulk request experiences high latency, failing to truly maintain throughput under variable API response times.'
WHERE question_id = '6db2b9a9-e33c-4f6a-9cf6-aa279e09f305';

-- question_id: 6dc86edb-8f75-427e-86f9-70e16570b67d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Deploying across multiple regions typically incurs additional costs for duplicated resources and cross-region data transfer, which is billed, making cost optimization generally not a primary benefit. Option 1 (correct) Multi-Region deployments provide robust disaster recovery by isolating workloads from region-wide outages and help meet stringent regulatory compliance requirements for data residency and business continuity, often leveraging services like AWS Route 53 for failover and cross-region data replication. Option 2 (incorrect) Managing resources across multiple regions significantly increases operational complexity, requiring robust tooling for cross-region deployment, monitoring, and incident response, rather than simplifying it. Option 3 (incorrect) While placing resources closer to users in different regions can improve latency, performance improvement is not the sole or primary benefit, and often can be achieved more efficiently through content delivery networks like Amazon CloudFront for static assets.'
WHERE question_id = '6dc86edb-8f75-427e-86f9-70e16570b67d';

-- question_id: 6e3508b2-5721-4508-be8c-ebf87bf98c5e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Reliability refers to the ability of a system to perform its intended function consistently and without failure, which AWS enhances through fault-tolerant architectures and redundant components like Multi-AZ deployments, but it does not directly address the dynamic adjustment to traffic fluctuations. Option B (correct) Scalability is the ability of a system to handle increasing or decreasing workloads by adding or removing resources dynamically, which AWS enables efficiently through services such as Amazon EC2 Auto Scaling and AWS Lambda, perfectly matching unpredictable traffic patterns. Option C (incorrect) Durability refers to the long-term persistence and protection of data, ensuring it remains intact and accessible over extended periods, a characteristic primarily associated with storage services like Amazon S3 which provides extreme data durability, but not with handling fluctuating compute traffic. Option D (incorrect) Availability refers to the percentage of time a system is operational and accessible to users, which AWS enhances through features like Elastic Load Balancing and redundant architectures, but it does not directly provide the dynamic resource adjustment needed for changing traffic volumes.'
WHERE question_id = '6e3508b2-5721-4508-be8c-ebf87bf98c5e';

-- question_id: 6e5b2a9b-cc8f-454d-8116-325214b589c3
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Service Control Policies help enforce security and compliance rules across accounts by restricting the maximum available permissions, which can indirectly prevent cost overruns by disallowing certain expensive services but are not a direct cost management feature. Option B (correct) Consolidated billing is a core feature of AWS Organizations that aggregates the usage across all accounts in an organization, often leading to volume discounts and a single bill, thereby directly simplifying and reducing costs. Option C (incorrect) Account creation within AWS Organizations allows for programmatic provisioning of new AWS accounts, which is fundamental for structuring an organization but is not itself a cost management feature. Option D (incorrect) Cross-account roles are an AWS Identity and Access Management feature used to securely delegate access between AWS accounts, primarily for operational and security purposes, and are not a feature of AWS Organizations that directly aids in cost management.'
WHERE question_id = '6e5b2a9b-cc8f-454d-8116-325214b589c3';

-- question_id: 6e9cf4f6-a599-43c4-9bcb-8abfdbd0c144
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Comprehend is an artificial intelligence (AI) service that uses pre-trained machine learning models to analyze text and extract insights, rather than providing an environment for building, training, and deploying custom ML models. Option B (correct) Amazon SageMaker is a fully managed service that provides an integrated development environment (IDE) and comprehensive tools for every step of the machine learning workflow, including building, training, and deploying ML models at scale. Option C (incorrect) Amazon Lex is a service for building conversational interfaces (chatbots and voice assistants) using automatic speech recognition and natural language understanding, not a general-purpose platform for the full ML model lifecycle. Option D (incorrect) AWS Glue is a serverless data integration service designed for extract, transform, and load (ETL) operations, data cataloging, and data preparation, which supports data for ML but does not provide the environment for model building, training, and deployment itself.'
WHERE question_id = '6e9cf4f6-a599-43c4-9bcb-8abfdbd0c144';

-- question_id: 6eb696ed-3dd9-4374-8c23-d10d2e33e965
-- answer_correct: True | verified_indices: [0, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Enabling Multi-Factor Authentication (MFA) on the AWS root user account is a critical security best practice, adding an extra layer of protection beyond just a password to prevent unauthorized access. Option B (incorrect) Using the AWS root user for daily tasks is a significant security risk and violates the principle of least privilege; instead, IAM users with specific permissions should be created for routine operations. Option C (correct) Creating a strong, unique password for the AWS root user is a fundamental security measure to protect against brute-force attacks and unauthorized access. Option D (incorrect) Sharing AWS root user credentials with a team severely compromises security, accountability, and traceability; IAM users or roles with appropriate permissions should be created for each team member instead. Option E (incorrect) The AWS root user account cannot be disabled or deleted as it is a permanent entity tied to the AWS account and is required for certain actions that only it can perform, such as closing the account.'
WHERE question_id = '6eb696ed-3dd9-4374-8c23-d10d2e33e965';

-- question_id: 6ef8ca70-0e85-487a-9cee-bfeaf2c77dec
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Routing network traffic in Amazon VPC is handled by Route Tables, which contain rules that determine where network traffic is directed. Option B (correct) Security Groups act as a stateful virtual firewall that controls inbound and outbound traffic for associated EC2 instances and other resources at the Elastic Network Interface (ENI) level. Option C (incorrect) Storing encryption keys in AWS is primarily the function of services like AWS Key Management Service (KMS) or AWS Secrets Manager, not Security Groups. Option D (incorrect) Monitoring performance in AWS is handled by services such as Amazon CloudWatch, which collects and tracks metrics, logs, and events.'
WHERE question_id = '6ef8ca70-0e85-487a-9cee-bfeaf2c77dec';

-- question_id: 6efb1dc9-6729-48ed-ac62-60560dc8a87f
-- answer_correct: True | verified_indices: [0, 4] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Increasing the number of DPUs allocated to the Glue job provides more memory and CPU resources to the underlying Apache Spark executors, directly addressing out-of-memory errors by giving the job more capacity to handle large datasets and complex transformations. Option B (incorrect) While data partitioning optimizes data access and can improve performance by allowing Glue to process subsets of data, it does not inherently resolve out-of-memory errors during complex transformations like joins and aggregations across a large dataset if the individual operations still require significant memory for intermediate results or shuffles. Option C (incorrect) Enabling job bookmarking helps track processed data for incremental runs, reducing the volume of data processed in subsequent executions, but it does not prevent out-of-memory errors during an initial or full load of the existing 500GB dataset. Option D (incorrect) Converting DynamicFrames to DataFrames can sometimes offer marginal performance and memory efficiency improvements due to DataFrames being more optimized for structured data and fixed schemas, but this change alone is typically not significant enough to resolve severe out-of-memory issues on a 500GB dataset with complex transformations compared to increasing DPU or data filtering. Option E (correct) Using pushdown predicates allows filtering data at the source (e.g., S3, JDBC) before it is loaded into the Glue job''s memory, substantially reducing the amount of data Spark has to process and store, which directly mitigates out-of-memory errors.'
WHERE question_id = '6efb1dc9-6729-48ed-ac62-60560dc8a87f';

-- question_id: 6f278c39-69c3-412d-b923-3860953fa380
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Internet Gateway connects a VPC directly to the public internet, which inherently lacks consistent network performance due to its shared and variable nature. Option B (correct) AWS Direct Connect establishes a dedicated, private network connection between your on-premises data center and AWS, bypassing the public internet to provide consistent network performance and reduced bandwidth costs. Option C (incorrect) VPN Gateway enables secure IPsec VPN connections over the public internet, which, despite being encrypted, still subjects network performance to the variability and inconsistency of the internet. Option D (incorrect) AWS PrivateLink provides private connectivity to AWS services or services hosted in other VPCs without traversing the public internet, but it is not a general service for establishing the foundational hybrid network link between an entire on-premises network and AWS.'
WHERE question_id = '6f278c39-69c3-412d-b923-3860953fa380';

-- question_id: 6fb392c8-f4ac-467f-adce-d9f96e3b685c
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Metadata filtering (e.g., using Amazon OpenSearch Service with attributes like document source, date, or user permissions) helps narrow down the search space to more relevant documents, while hybrid search (combining lexical search like BM25 and semantic search using vector embeddings, often stored in Amazon Kendra or Amazon OpenSearch Service) leverages the strengths of both methods to capture both exact keyword matches and contextual relevance, significantly improving the precision and recall of retrieved documents in a RAG system. Option B (incorrect) Random selection provides no mechanism to identify relevant documents and will almost certainly retrieve irrelevant information, leading to poor RAG output and hallucination, directly contradicting the goal of improving retrieval quality in a RAG system. Option C (incorrect) While single keyword search (e.g., a basic query against an Amazon S3 text file index) can retrieve some relevant documents, it often misses semantically related but lexically different content and struggles with complex queries, leading to lower recall and precision compared to more advanced techniques like vector search or hybrid search available through AWS services. Option D (incorrect) No filtering means retrieving documents from the entire corpus without any constraints, which increases the likelihood of fetching irrelevant information into the RAG system, diluting the quality of the generative model''s response and increasing computational overhead, an inefficient practice for RAG architectures on AWS.'
WHERE question_id = '6fb392c8-f4ac-467f-adce-d9f96e3b685c';

-- question_id: 6fbbfa03-811a-4e4d-aa28-dc7f2e3bca68
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) An S3 bucket policy controls access permissions to objects in S3 and does not directly influence CloudFront''s caching behavior or force a cache refresh. Option B (incorrect) Modifying CloudFront origin settings changes where CloudFront fetches content from but is not the direct or intended mechanism for forcing a refresh of currently cached, stale content. Option C (correct) Creating a CloudFront invalidation explicitly removes specified objects from CloudFront''s edge caches, forcing CloudFront to fetch the latest version from the origin upon the next request. Option D (incorrect) Changing the CloudFront price class only affects the geographical regions used for content delivery and has no impact on content freshness or cache invalidation.'
WHERE question_id = '6fbbfa03-811a-4e4d-aa28-dc7f2e3bca68';

-- question_id: 6fd3088e-048d-47c7-a118-6b8dba5c4c2d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Compressing data with GZIP reduces the overall data scanned by Athena, lowering costs, but it is a row-based compression and does not offer the same efficiency for column pruning as columnar formats, while Athena result caching only benefits repeated, identical queries, not the initial scan efficiency for filtered queries. Option B (correct) Converting data to Apache Parquet columnar format enables column pruning, meaning Athena only reads necessary columns, and implementing date-based partitioning allows for partition pruning, where Athena scans only relevant date partitions, both drastically reducing the amount of data scanned and thus significantly lowering costs. Option C (incorrect) Athena workgroups allow setting data scan limits to prevent excessive costs for individual queries but do not optimize the underlying data scanning process to reduce the actual data scanned for a successful query, thus not providing an efficiency-based cost reduction. Option D (incorrect) Switching to Amazon Redshift Spectrum would not inherently provide greater cost reduction without first implementing the same data format and partitioning optimizations, as Redshift Spectrum also charges based on data scanned from S3 and benefits from identical data organization for efficiency.'
WHERE question_id = '6fd3088e-048d-47c7-a118-6b8dba5c4c2d';

-- question_id: 701c41fb-ceba-4793-8930-f59a3d32c844
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Cost Explorer is primarily used for analyzing and visualizing historical cost and usage data after resources have been deployed, rather than for estimating costs before deployment. Option B (correct) AWS Pricing Calculator is specifically designed to help users estimate the cost of their AWS solutions before they deploy resources, allowing them to configure services and see potential spend. Option C (incorrect) AWS Budgets helps you set alerts for actual or forecasted costs and usage that exceed your defined thresholds, acting as a monitoring tool for ongoing operations rather than a pre-deployment estimator. Option D (incorrect) AWS Cost and Usage Report provides a comprehensive and detailed dataset of your costs and usage *after* resources have been consumed, which is used for deep analysis and billing reconciliation, not initial cost estimation.'
WHERE question_id = '701c41fb-ceba-4793-8930-f59a3d32c844';

-- question_id: 70623713-3e56-4bff-a5e2-48be217bfc8a
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) To find exact keyword matches describes lexical search, which relies on matching specific terms rather than understanding the query''s underlying meaning, unlike semantic search which focuses on conceptual similarity. Option B (correct) To identify conceptually similar content is the primary purpose of semantic search, as it uses vector embeddings, often stored in vector databases like Amazon OpenSearch Service or a vector engine for Amazon Aurora, to match the meaning of a query to relevant documents regardless of exact keyword presence. Option C (incorrect) To compress search results relates to data storage efficiency or network transfer optimization, which are separate concerns from the method by which search results are identified in an AWS RAG system. Option D (incorrect) To encrypt search queries pertains to data security and privacy, ensuring query data is protected in transit and at rest, a critical aspect of secure AWS architectures but not the functional purpose of semantic search itself.'
WHERE question_id = '70623713-3e56-4bff-a5e2-48be217bfc8a';

-- question_id: 7190fab7-18b7-4a2b-8e25-39ba3e7b4b69
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) CloudTrail does incur costs for event storage in S3 and event delivery beyond the free tier, but these costs are generally incremental and not "significant" in most standard scenarios, especially compared to the value of audit logging. Option B (correct) AWS CloudTrail''s primary purpose is to record API activity and related events across your AWS accounts, providing a comprehensive audit trail of actions taken. Option C (incorrect) AWS CloudTrail is an auditing and governance service that records API calls, and it does not directly impact or improve the performance of your applications. Option D (incorrect) AWS CloudTrail generates event logs that are stored in Amazon S3 buckets, which actually increases storage usage, not decreases it.'
WHERE question_id = '7190fab7-18b7-4a2b-8e25-39ba3e7b4b69';

-- question_id: 71995a5a-40c5-4bb7-834c-8ed4d5271293
-- answer_correct: True | verified_indices: [1, 2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] ReadProvisionedThroughputExceeded metric for throttling issues is incorrect because while Kinesis throttling can cause consumer lag and an increasing IteratorAge, application logs for internal processing issues and direct measurement of the lag (GetRecords.IteratorAgeMilliseconds) are more immediate and broadly applicable diagnostic steps. Option [1] GetRecords.IteratorAgeMilliseconds for consumer lag is correct because although the question states IteratorAge is increasing, analyzing this specific CloudWatch metric provides precise quantification of the consumer lag''s severity and trend, which is crucial for understanding the problem''s scope. Option [2] Application logs for processing errors and retry patterns is correct because the consumer application''s internal logic, including code inefficiencies, unhandled exceptions, or excessive retry mechanisms, is a very common root cause for increased processing latency and the consumer falling behind. Option [3] PutRecords.Success metric for producer issues is incorrect because this metric relates to whether the producer successfully writes data to the stream; if this metric shows issues, it would generally mean less data in the stream, which would likely decrease consumer lag, not increase it. Option [4] Stream-level shard count and utilization metrics is incorrect because while shard configuration affects overall stream capacity and consumer parallelism, it''s more of a scaling solution rather than a direct diagnostic for an existing consumer''s increased processing latency or why its IteratorAge is specifically increasing due to current operational issues.'
WHERE question_id = '71995a5a-40c5-4bb7-834c-8ed4d5271293';

-- question_id: 727e4c39-aa76-4c1e-961d-070eea7d371c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EC2 metrics monitor the performance of individual EC2 instances, such as CPU utilization or network I/O for a specific instance, and do not provide insights into the aggregate traffic or health of the Transit Gateway service. Option B (incorrect) RDS metrics are specific to Amazon Relational Database Service instances, tracking database performance metrics like CPU utilization, database connections, and disk I/O, which are irrelevant to network traffic bottlenecks on a Transit Gateway. Option C (correct) Transit Gateway metrics are specifically designed to monitor the performance and usage of the AWS Transit Gateway service, providing crucial data points like BytesIn, BytesOut, PacketDropCount, and ActiveFlowCount that directly identify traffic volume and potential packet loss. Option D (incorrect) S3 metrics track the usage and performance of Amazon S3 buckets, such as request counts and data transfer for object storage, and are unrelated to network connectivity or traffic flow through a Transit Gateway.'
WHERE question_id = '727e4c39-aa76-4c1e-961d-070eea7d371c';

-- question_id: 72b3c84b-5738-43ec-a54d-81aba37dc714
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) SQS Standard queues do not guarantee message ordering, which is a critical requirement for the system, although they do support DLQs and scale well with Lambda. Option B (correct) SQS FIFO queues guarantee exact message ordering, exactly-once processing, native dead-letter queue support, high availability, and integrate seamlessly with Lambda for automatic scaling based on queue depth, fulfilling all specified requirements. Option C (incorrect) Amazon MQ provides managed message brokers but typically incurs higher operational overhead and does not offer the same native, automatic scaling based on queue depth as SQS with Lambda, nor is it the most cloud-native solution for this specific problem. Option D (incorrect) Kinesis Data Streams guarantees ordering only within a shard, not globally across all messages, and requires custom consumer implementation for dead-letter handling rather than native support.'
WHERE question_id = '72b3c84b-5738-43ec-a54d-81aba37dc714';

-- question_id: 7374c6a9-9f28-463d-a4f0-5a91bc963b1b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using Reserved Instances for a predictable baseline and Spot for variable load is generally less effective for EMR''s typically ephemeral nature and may not provide maximum cost savings compared to an all-Spot strategy for interruptible workloads. Option B (correct) Using Spot instances for all nodes with instance fleet diversification offers maximum cost savings (up to 90% off On-Demand) because the EMR Spark jobs are scheduled, predictable, and gracefully handle node failures, making them ideal candidates for interruptible Spot instances while diversification enhances reliability. Option C (incorrect) Deploying EMR on Fargate is not a current AWS offering; while EMR Serverless exists, its pricing model typically doesn''t achieve the maximum cost savings possible with Spot instances for large, consistent, interruptible workloads. Option D (incorrect) Switching to AWS Glue is a re-platforming effort, not a direct cost optimization strategy for existing EMR Spark jobs, and while Glue is cost-effective, EMR with Spot instances can offer superior price/performance for 25 TB weekly processing when optimized for maximum savings.'
WHERE question_id = '7374c6a9-9f28-463d-a4f0-5a91bc963b1b';

-- question_id: 739a2944-94a8-4902-97dd-d9cb65325f19
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon CloudFront is primarily a Content Delivery Network (CDN) designed to cache and deliver static and dynamic web content (HTTP/S) closer to users, and while it can accelerate dynamic HTTP/S, it is not optimized for raw non-cacheable TCP and UDP traffic. Option B (correct) AWS Global Accelerator directs user traffic from optimal AWS edge locations over the AWS global network to application endpoints, providing static IP addresses that improve performance for non-cacheable TCP and UDP traffic by bypassing congested public internet segments. Option C (incorrect) Route 53 Geolocation routing is a DNS routing policy that routes users to specific resources based on their geographic origin, but it does not optimize the network path over the AWS global network for the actual data transfer in the same way Global Accelerator does. Option D (incorrect) VPC Endpoint Services allow private connectivity between VPCs or from on-premises networks to services running in AWS without traversing the public internet, which is unrelated to directing global user traffic to optimal AWS edge locations.'
WHERE question_id = '739a2944-94a8-4902-97dd-d9cb65325f19';

-- question_id: 73dd3a56-4d3a-4dca-a8f9-1c2886bc8a88
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EMR''s built-in auto-termination features detect general cluster idleness based on the absence of steps or interactive sessions, but they do not provide the granular control to specifically detect "no Spark jobs running" or the capability to "check application logs for errors before termination" as required by the problem statement. Option B (correct) A CloudWatch Events (now Amazon EventBridge) rule can be configured to trigger a Lambda function on a schedule, enabling the Lambda to programmatically query EMR metrics for active Spark jobs, access and parse application logs stored in S3 for errors, and then conditionally invoke the EMR API to terminate the cluster, thereby satisfying all custom monitoring and termination requirements. Option C (incorrect) Implementing an EMR step to monitor and self-terminate the cluster is not a best practice for cluster lifecycle management, as the step itself consumes resources, and its execution state might complicate the accurate detection of true idleness or the efficient analysis of external logs before termination. Option D (incorrect) CloudWatch Alarms trigger based on predefined metric thresholds and cannot inherently perform complex conditional logic, such as reading and analyzing application logs for errors, which is a critical requirement before termination; while an alarm can trigger a Lambda, the decision logic involving both metrics and log analysis is more effectively implemented within a single, scheduled Lambda function.'
WHERE question_id = '73dd3a56-4d3a-4dca-a8f9-1c2886bc8a88';

-- question_id: 73e7c06f-eaad-4613-977d-cb34c60be75d
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) On-Demand Instances offer flexibility and pay-as-you-go pricing without interruption, but they do not provide the most significant cost savings compared to other options. Option B (incorrect) Reserved Instances offer substantial cost savings by committing to a 1-year or 3-year term for predictable workloads, providing a capacity reservation that is not interrupted by AWS. Option C (correct) Spot Instances allow users to bid on unused EC2 capacity, offering the most significant cost savings (up to 90% off On-Demand) with the condition that AWS can reclaim the capacity with a two-minute interruption notice. Option D (incorrect) Dedicated Hosts provide dedicated physical EC2 servers for specific licensing requirements and are the most expensive option, not subject to interruption by AWS for capacity reclamation.'
WHERE question_id = '73e7c06f-eaad-4613-977d-cb34c60be75d';

-- question_id: 73f1fb48-e0fc-407b-8b21-48057b0803a0
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) IAM policies with condition statements based on resource tags and user attributes provide a form of Attribute-Based Access Control (ABAC), which is highly granular, but this option does not explicitly mention the integration with an identity management solution like AWS IAM Identity Center or the auditing component, making it less comprehensive than the correct answer for this specific scenario. Option B (correct) AWS IAM Identity Center, when combined with ABAC policies, provides the most scalable and fine-grained access control by allowing policies to dynamically evaluate user attributes (like clearance levels) against S3 resource tags (like data classification levels) at the time of access, with AWS CloudTrail ensuring all access attempts are logged for audit purposes. Option C (incorrect) S3 bucket policies with IP address restrictions and MFA requirements provide network-level and authentication security, respectively, but they do not offer fine-grained access control based on user roles, individual clearance levels, or data classification attributes, which are central to the question''s requirements. Option D (incorrect) S3 Access Points with individual access policies for each user group can provide some granularity for specific application access, but managing separate policies for numerous user groups and correlating them with changing user clearance levels or data classifications becomes complex and less scalable than an ABAC approach facilitated by AWS IAM Identity Center.'
WHERE question_id = '73f1fb48-e0fc-407b-8b21-48057b0803a0';

-- question_id: 74b82308-fa1a-4c46-b8f1-fa31c3e66936
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Model signing and verification helps ensure the integrity and authenticity of the deployed model, preventing tampering or unauthorized model replacements by cryptographically verifying its origin and content before deployment and inference. Option B (correct) Access logging and monitoring, utilizing services like Amazon CloudWatch Logs and AWS Security Hub for Amazon SageMaker endpoints, are critical for detecting unauthorized access attempts, misuse, or unusual activity patterns, enabling timely incident response. Option C (incorrect) Providing no protection for production ML models leaves them highly vulnerable to attacks like model poisoning, data exfiltration, and unauthorized resource usage, directly contradicting fundamental AWS security best practices. Option D (incorrect) Making ML models publicly accessible without robust authentication and authorization mechanisms significantly broadens the attack surface, increasing the risk of abuse, data breaches, and service disruption. Option E (incorrect) Unrestricted access to production ML models is a severe security misconfiguration that violates the principle of least privilege, enabling any entity to interact with the model, potentially leading to data compromise or service manipulation.'
WHERE question_id = '74b82308-fa1a-4c46-b8f1-fa31c3e66936';

-- question_id: 75527886-39b4-4d7f-be02-0f3c5e6dc000
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Cost and Usage Reports are delivered periodically (daily or hourly) to an S3 bucket, meaning they provide historical or near-real-time data, not real-time monitoring which is better suited for AWS Cost Explorer or CloudWatch billing metrics. Option B (correct) AWS Cost and Usage Reports provide the most granular level of detail regarding your AWS costs and usage, including line-item data for every charge, resource tags, usage types, and pricing information, essential for in-depth analysis and cost allocation. Option C (incorrect) AWS Cost and Usage Reports provide the raw data required to *identify* cost optimization opportunities, but they do not *automatically perform* cost optimization; services like AWS Compute Optimizer or AWS Trusted Advisor provide recommendations or automate certain aspects of optimization. Option D (incorrect) While the detailed information from CUR can inform the setup of budgets, AWS Budgets is the specific service designed for creating, tracking, and alerting on cost and usage budgets, and CUR is a data source for analysis rather than a budget creation tool itself.'
WHERE question_id = '75527886-39b4-4d7f-be02-0f3c5e6dc000';

-- question_id: 7559efd6-81da-4185-bc2a-ef98eb0c566a
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using AWS managed encryption keys (SSE-S3) does not provide full customer control over encryption keys, the ability to audit all key usage, or directly revoke access to the master key material, as AWS fully manages these keys. Option B (correct) Implementing AWS KMS customer managed keys (CMKs) provides full customer control over key policies, integrates with AWS CloudTrail for auditing all key usage, allows immediate revocation by disabling or deleting CMKs, and supports automatic annual key rotation. Option C (incorrect) Deploying an AWS CloudHSM cluster offers complete hardware control over keys but does not provide built-in automatic key rotation, requiring significant custom implementation, and introduces more operational overhead than KMS CMKs for the specified requirements. Option D (incorrect) Using client-side encryption with keys stored in AWS Secrets Manager would require the customer to build and manage the entire encryption and key rotation logic, including ensuring secure key material handling and comprehensive auditing, which is complex and does not offer the automatic key rotation or native auditing features provided by KMS.'
WHERE question_id = '7559efd6-81da-4185-bc2a-ef98eb0c566a';

-- question_id: 75912809-7870-4046-bf8e-a2d98eefdea0
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) This option correctly defines the core principle of zero-trust architecture, which is to never implicitly trust any user, device, or network, and to always verify every access request to AI systems and their underlying data and infrastructure in AWS, often enforced through strict AWS IAM policies and continuous authentication. Option B (incorrect) This option directly contradicts the fundamental principle of zero-trust, as it advocates for implicit trust, which would lead to severe security vulnerabilities for AI models, data, and SageMaker resources without proper authentication or authorization in AWS. Option C (incorrect) This option is entirely false; zero-trust is a highly robust security model that inherently implies a strong need for comprehensive security measures, utilizing AWS services like Amazon GuardDuty and AWS Security Hub to monitor and protect AI environments. Option D (incorrect) This option is a critical security anti-pattern and directly opposes zero-trust, as making AI systems or their supporting resources like S3 buckets publicly accessible by default would expose sensitive data and models to unauthorized access, violating AWS security best practices and the principle of least privilege.'
WHERE question_id = '75912809-7870-4046-bf8e-a2d98eefdea0';

-- question_id: 764ac67e-9af2-4876-bd2d-592e20aad354
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Using Spot Instances primarily reduces the hourly cost of compute but does not inherently manage the runtime of instances, meaning they could still run unnecessarily for many hours when not in active use, failing to fully optimize costs for intermittent workloads. Option 1 (correct) Implementing infrastructure as code with automatic start/stop scheduling is the best strategy because it ensures consistent configurations for environment recreation and directly optimizes costs by only running resources during their intermittent usage periods, leveraging services like AWS Instance Scheduler or custom Lambda functions. Option 2 (incorrect) Purchasing Reserved Instances is designed for consistent and predictable capacity needs over a 1 or 3-year term, making them unsuitable and potentially more expensive for intermittently used non-production environments where resources are frequently idle. Option 3 (incorrect) Savings Plans offer discounts on committed compute spend and provide flexibility across instance types, but they are most effective for covering a predictable baseline of usage, and for intermittently used environments, the primary cost saving comes from shutting down resources rather than securing a lower hourly rate for idle time.'
WHERE question_id = '764ac67e-9af2-4876-bd2d-592e20aad354';

-- question_id: 76a5eb5d-8c51-4420-8c39-1493ad3e3284
-- answer_correct: True | verified_indices: [1, 4] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon DynamoDB Global Tables provide multi-region replication and allow strong consistency reads within a region, but they do not offer automatic application-level failover for write operations to a secondary region during an outage, requiring manual intervention or custom logic. Option B (correct) Aurora Global Database provides automated cross-region failover capabilities with an RPO typically measured in seconds (often under 1 minute) due to physical replication, maintaining high data consistency and meeting all specified requirements. Option C (incorrect) Amazon RDS with Multi-AZ deployment provides intra-region failover, and while cross-region read replicas allow for read distribution, promoting a cross-region replica to handle writes during a regional outage is a manual or semi-manual process, not an automated cross-region failover. Option D (incorrect) Amazon DocumentDB currently lacks a native "cross-region cluster" or "global database" feature that provides automated write failover to a secondary region during an outage, requiring manual intervention for cross-region disaster recovery. Option E (correct) Amazon ElastiCache with Global Datastore provides automatic, sub-second failover to a healthy secondary region with no data loss, thus achieving an RPO of 0 for failover, and supports multi-region distribution of real-time tracking data efficiently.'
WHERE question_id = '76a5eb5d-8c51-4420-8c39-1493ad3e3284';

-- question_id: 77281a1a-3c2e-4abd-89ed-3fa1ef468073
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) The self-attention mechanism in transformer models has a computational and memory complexity that scales quadratically with the input sequence length, making it the primary bottleneck for scaling these models to handle longer sequences and larger contexts even with advanced AWS compute resources like EC2 P4d instances or SageMaker’s distributed training. Option B (incorrect) Transformer models do not scale linearly with respect to sequence length due to the quadratic complexity of their attention mechanism, which means resource requirements grow much faster than linearly, posing a significant challenge for efficient resource provisioning on AWS. Option C (incorrect) All computational models, including transformers, have inherent limitations, particularly concerning resource consumption and algorithmic complexity, which means even the extensive resources available on AWS cannot overcome fundamental design constraints like quadratic attention. Option D (incorrect) While AWS provides highly scalable and vast compute capacity, it is not infinite; physical and financial constraints, along with the algorithmic limitations of transformer models, prevent the notion of infinite capacity for training or deploying such models.'
WHERE question_id = '77281a1a-3c2e-4abd-89ed-3fa1ef468073';

-- question_id: 772b9575-4ced-4d67-9ace-ce5ae90e1aff
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Convolutional Neural Networks are primarily designed for processing grid-like data such as images, making them unsuitable for generating complex, long-form sequential text like movie scripts, where models need to understand long-range dependencies and context. Option 1 (correct) Transformer-based language models are specifically designed for sequential data and excel at natural language generation, making them highly suitable for creating coherent and contextually relevant movie scripts, as demonstrated by foundation models available via Amazon Bedrock or fine-tuned on Amazon SageMaker. Option 2 (incorrect) Support Vector Machines are primarily used for classification and regression tasks, distinguishing between categories or predicting numerical values, and are not designed for generating creative, free-form text like movie scripts. Option 3 (incorrect) Decision Trees are supervised learning algorithms used for classification and regression based on a series of if-then rules, which are not capable of generating new, complex, and contextually rich sequential text required for movie scripts.'
WHERE question_id = '772b9575-4ced-4d67-9ace-ce5ae90e1aff';

-- question_id: 772e50d4-a709-49e7-a075-b683a0b98e10
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Individual account separation is a fundamental best practice for resource isolation and management in AWS Organizations, but consolidated billing''s primary benefit is not the separation itself, rather it''s how costs are managed across these separate accounts. Option B (correct) Volume pricing discounts across accounts is the primary benefit of consolidated billing in AWS Organizations, as it aggregates the usage from all linked member accounts into a single bill, allowing the entire organization to benefit from lower pricing tiers for services like S3 storage or EC2 data transfer that offer volume-based discounts. Option C (incorrect) Higher security is not a direct benefit of consolidated billing, as security in AWS is primarily achieved through other AWS Organizations features like Service Control Policies (SCPs), AWS IAM, and dedicated security services such as GuardDuty or AWS WAF. Option D (incorrect) Better performance is unrelated to consolidated billing, as performance of AWS services is determined by factors such as instance types, regional selection, network configuration, and application architecture, not by how billing is aggregated.'
WHERE question_id = '772e50d4-a709-49e7-a075-b683a0b98e10';

-- question_id: 77434887-001a-4908-929b-70f3d86f44bf
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) If Parquet files are corrupted, their internal schema metadata may be unreadable or malformed, directly leading to the "Unable to infer schema" error that Spark experiences. Option B (incorrect) AWS Glue Schema Registry is primarily for managing schemas for data streams like Avro or JSON, and not typically used to validate the integrity or schema inference of Parquet files stored in S3 for Glue ETL jobs. Option C (incorrect) An empty Parquet file (zero rows) still contains valid schema metadata that Spark can successfully infer, resulting in an empty DataFrame rather than an "Unable to infer schema" error. Option D (incorrect) Enabling schema merging in Spark is used when individual Parquet files have valid but differing schemas that can be successfully inferred, allowing Spark to combine them, which is distinct from an inability to infer any schema from a single file.'
WHERE question_id = '77434887-001a-4908-929b-70f3d86f44bf';

-- question_id: 77c2c786-21c9-4d83-ad1b-4e71f9005e0b
-- answer_correct: True | verified_indices: [3] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While Amazon Cognito User Pools can authenticate users via SAML federation and integrate with corporate identity, it is primarily designed for customer-facing applications and doesn''t inherently provide detailed CloudTrail logging for application API calls or native fine-grained permissions management for corporate users accessing AWS resources like IAM Identity Center does. Option B (incorrect) AWS IAM with SAML identity provider is primarily for authenticating and authorizing corporate users to access AWS services and resources directly, not typically for end-user authentication to custom application APIs, and requiring users to make API calls using AWS IAM credentials is not standard practice for application users. Option C (incorrect) API Gateway with Lambda authorizers can implement custom authentication logic connecting to corporate LDAP, but it represents a custom solution with higher operational overhead for identity management and does not natively integrate with AWS CloudTrail for detailed audit logging of application API calls or provide AWS-managed fine-grained permissions. Option D (correct) AWS IAM Identity Center integrates directly with corporate Active Directory, authenticating users who can then assume IAM roles to access application APIs protected by IAM authorization, ensuring detailed audit logging of all API calls in CloudTrail and supporting fine-grained permissions via IAM policies.'
WHERE question_id = '77c2c786-21c9-4d83-ad1b-4e71f9005e0b';

-- question_id: 782f1c6b-10a4-4c89-b2cb-33953cbcd69f
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Generating property descriptions requires a model that can interpret and produce text rich in spatial details (e.g., "spacious backyard") and descriptive adjectives (e.g., "modern kitchen"), which is a core capability of large language models available through Amazon Bedrock, such as Amazon Titan Text or Anthropic Claude, allowing them to transform structured property data into narrative text. Option B (incorrect) Voice synthesis, performed by services like Amazon Polly, converts existing text into speech, but the initial task is to generate the textual description itself, not to vocalize it. Option C (incorrect) Video generation involves creating visual media, which is entirely unrelated to the requirement of producing written property descriptions. Option D (incorrect) Code completion, provided by services such as Amazon CodeWhisperer, assists developers in writing programming code, a function completely irrelevant to generating natural language text for property listings.'
WHERE question_id = '782f1c6b-10a4-4c89-b2cb-33953cbcd69f';

-- question_id: 78697109-b4c6-4118-a00e-8e2dfeb4ef88
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS DMS is primarily designed for database migration and change data capture, making it less suitable and potentially more complex for continuous ingestion of raw log files from Apache Kafka compared to purpose-built Kafka integration tools. Option B (correct) Amazon MSK Connect is a fully managed service for Apache Kafka Connect that allows deployment of pre-built connectors like the S3 Sink Connector, directly consuming from Kafka and writing to S3 with built-in features for ordering, compression, and minimal operational overhead. Option C (incorrect) Amazon Kinesis Data Firehose does not natively consume from on-premises Apache Kafka clusters directly, requiring an additional intermediary service or custom application to bridge Kafka to Firehose, thereby increasing operational complexity. Option D (incorrect) AWS Glue streaming ETL jobs can consume from Kafka and write to S3 but require writing and managing Spark code for the ETL process, introducing higher operational overhead and complexity compared to a fully managed connector solution like MSK Connect.'
WHERE question_id = '78697109-b4c6-4118-a00e-8e2dfeb4ef88';

-- question_id: 788b76e8-9211-48e5-a5be-6c74f5e0861a
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon CloudWatch primarily collects and monitors metrics, logs, and events for operational health and performance, but it does not directly record individual API calls for security and compliance auditing. Option B (correct) AWS CloudTrail records API calls and related events made in your AWS account, providing an audit trail for security analysis, change tracking, and compliance auditing. Option C (incorrect) AWS Config continuously monitors and records the configuration changes of your AWS resources, evaluating them against desired baselines for compliance, but it does not log API call history. Option D (incorrect) Amazon GuardDuty is a threat detection service that monitors for malicious activity and unauthorized behavior by analyzing data sources like VPC Flow Logs and CloudTrail events, rather than recording the API calls itself.'
WHERE question_id = '788b76e8-9211-48e5-a5be-6c74f5e0861a';

-- question_id: 78a63efe-01c7-4897-be1a-3041c2e60294
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) The Security pillar focuses on protecting information, systems, and assets, which involves confidentiality, integrity, and availability, but not primarily on the ability to recover from failures as a core tenet. Option B (correct) The Reliability pillar specifically focuses on the ability of a system to recover from infrastructure or service disruptions, dynamically acquire computing resources to meet demand, and mitigate disruptions such as misconfigurations, using practices like multi-AZ deployments and automated backups. Option C (incorrect) The Performance Efficiency pillar focuses on using computing resources efficiently to meet system requirements and maintaining that efficiency as demand changes, rather than the ability to recover from failures. Option D (incorrect) The Cost Optimization pillar focuses on avoiding unnecessary costs and maximizing the business value of AWS resources by choosing optimal services and resources, not on the system''s ability to recover from failures.'
WHERE question_id = '78a63efe-01c7-4897-be1a-3041c2e60294';

-- question_id: 78bfeed5-b478-44fa-9e7b-e91b5c32f6e7
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) System performance metrics are primarily captured by services like Amazon CloudWatch, which monitors resources and applications in real-time. Option B (correct) API calls and management events are precisely what AWS CloudTrail logs, providing a historical record of actions taken within your AWS account by users, roles, or AWS services. Option C (incorrect) Network traffic patterns are recorded by Amazon VPC Flow Logs, which capture information about the IP traffic going to and from network interfaces in your VPC. Option D (incorrect) Application debug logs are typically generated by applications running on AWS services and are collected and monitored using services such as Amazon CloudWatch Logs.'
WHERE question_id = '78bfeed5-b478-44fa-9e7b-e91b5c32f6e7';

-- question_id: 78c1d911-8292-4f39-ace3-aedaf577028a
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon S3 is an object storage service used for storing data and model artifacts, but it does not provide functionality to detect or mitigate bias within machine learning models. Option B (correct) Amazon SageMaker Clarify is a feature within Amazon SageMaker specifically designed to detect potential bias in machine learning models and data, as well as to provide explainability for model predictions. Option C (incorrect) AWS Lambda is a serverless compute service for running code in response to events and while it can be part of an ML pipeline, it does not inherently offer capabilities for detecting or mitigating bias in ML models. Option D (incorrect) Amazon CloudFront is a content delivery network (CDN) service that securely delivers data, videos, applications, and APIs to customers globally, and it has no direct functionality related to detecting or mitigating bias in ML models.'
WHERE question_id = '78c1d911-8292-4f39-ace3-aedaf577028a';

-- question_id: 78f8e71e-b346-4d73-ab42-58ad3b965ce7
-- answer_correct: True | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Rehosting, also known as lift-and-shift, involves moving applications as-is from on-premises to the cloud, typically to Amazon EC2 instances, which does not align with the requirement of purchasing a new cloud-based solution. Option B (incorrect) Replatforming involves making minor modifications to an application while moving it to the cloud, such as migrating a self-managed database to Amazon RDS, but it still focuses on migrating an existing application rather than purchasing a new one. Option C (incorrect) Refactoring involves re-architecting an application to fully leverage cloud-native features like AWS Lambda or Amazon DynamoDB, which requires significant development effort, not simply purchasing a solution. Option D (correct) Repurchasing, also known as drop and shop, involves replacing an existing legacy application with a new, typically Software-as-a-Service (SaaS) solution available in the cloud, perfectly matching the scenario of purchasing a cloud-based solution to replace a legacy system.'
WHERE question_id = '78f8e71e-b346-4d73-ab42-58ad3b965ce7';

-- question_id: 79028951-65a1-4b4b-8bce-ae63e1095622
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Starting with administrative access violates the principle of least privilege, a core AWS security best practice, and significantly increases the potential impact of a compromised credential by allowing unlimited actions across all services. Option B (incorrect) Granting broad permissions initially, such as `s3:*` for all S3 resources, creates an unnecessarily large attack surface and allows users to perform actions or access data they do not require, contrary to fine-grained IAM policy recommendations. Option C (correct) Beginning with minimal access and expanding as needed is the embodiment of the principle of least privilege, an AWS security best practice, ensuring that IAM users and roles only have the permissions absolutely necessary to perform their required tasks, thus reducing potential harm from unauthorized or malicious activity. Option D (incorrect) Using only shared accounts is an anti-pattern in AWS security, as it prevents individual accountability, complicates auditing of specific user actions through AWS CloudTrail, and makes it impossible to revoke access for one individual without impacting others.'
WHERE question_id = '79028951-65a1-4b4b-8bce-ae63e1095622';

-- question_id: 7945ba76-b443-4b8a-8f17-dd3ba4b2ef60
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Inspector is not designed for general data analysis; services like Amazon Redshift or Amazon QuickSight are utilized for various data analysis needs. Option B (correct) Amazon Inspector is primarily used to automatically discover and scan EC2 instances, container images, and Lambda functions for software vulnerabilities and unintended network exposure to improve application security. Option C (incorrect) Amazon Inspector does not perform model training; services such as Amazon SageMaker are specifically designed for machine learning model development and training. Option D (incorrect) Amazon Inspector is not a cost optimization tool; AWS Cost Explorer, AWS Budgets, and Savings Plans are examples of services used for managing and reducing AWS expenditure.'
WHERE question_id = '7945ba76-b443-4b8a-8f17-dd3ba4b2ef60';

-- question_id: 7a380fae-f1e5-4470-9a61-458414fb2d70
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using only structured data would lead to an incomplete fraud detection system as valuable insights from unstructured customer support emails, which AWS AI services like Amazon Comprehend could process, would be missed, directly contradicting the requirement for a comprehensive solution. Option B (correct) Processing each data type with appropriate models and combining insights aligns with AWS best practices, where services like Amazon SageMaker can handle structured transaction data and Amazon Comprehend can analyze unstructured email data, allowing for a comprehensive fraud detection system by integrating their outputs. Option C (incorrect) Converting all structured transaction data into an unstructured format would result in a significant loss of critical metadata and relationships essential for accurate fraud detection, making analysis less efficient and potentially less accurate than processing data in its native format using AWS services. Option D (incorrect) Ignoring the email data would prevent the development of a truly comprehensive fraud detection system, as it would overlook crucial contextual information and early warning signs that can be extracted from unstructured text using AWS AI services.'
WHERE question_id = '7a380fae-f1e5-4470-9a61-458414fb2d70';

-- question_id: 7aeb3f2e-cbb4-4bca-a372-d1110d6e44a5
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The Basic Support plan provides access to customer service for account and billing questions and includes AWS Personal Health Dashboard and forums, but it does not offer 24/7 technical support via phone, email, or chat for operational issues. Option B (incorrect) The Developer Support plan offers technical support during business hours via email for general guidance and system impaired issues, but it does not include 24/7 phone or chat access. Option C (correct) The Business Support plan is the first tier that provides 24/7 access to Cloud Support Engineers via phone, email, and chat for an unlimited number of contacts, making it suitable for production workloads. Option D (incorrect) Not all AWS Support plans provide 24/7 support via phone, email, and chat; specifically, the Basic and Developer plans have more limited support channels and hours.'
WHERE question_id = '7aeb3f2e-cbb4-4bca-a372-d1110d6e44a5';

-- question_id: 7af7de63-fb30-4244-a071-cf1f62fd97d8
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EMR managed scaling optimizes resource utilization during job execution by adjusting cluster resources based on workload metrics but does not address the 16 hours of idle time when the cluster is completely unused. Option B (correct) Deploying transient EMR clusters that launch for scheduled jobs and terminate on completion directly eliminates the 16 hours of idle cluster time by only incurring costs during active processing, providing maximum cost reduction for this scenario. Option C (incorrect) While AWS Glue offers a serverless, on-demand Spark environment that eliminates idle time, migrating from EMR to Glue is a platform change that might involve refactoring and is not as direct a solution to the immediate problem of an idle EMR cluster as making the existing EMR cluster transient. Option D (incorrect) Migrating to EMR on EKS introduces significant operational overhead with Kubernetes and, while potentially offering efficiency gains through autoscaling, does not inherently solve the problem of a continuously provisioned, idle cluster unless the underlying EKS cluster can scale down to zero when not in use.'
WHERE question_id = '7af7de63-fb30-4244-a071-cf1f62fd97d8';

-- question_id: 7b21fc88-9968-4793-ab96-fd8c8e340544
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Amazon DynamoDB recently launched vector search capabilities, but it is a relatively newer offering compared to established solutions and the "only" qualifier makes it incorrect as it''s not the sole most mature option. Option 1 (correct) Amazon OpenSearch Service offers mature k-NN search capabilities for vector similarity, and RDS PostgreSQL with the pgvector extension is a widely adopted and production-ready solution for vector storage and search, making this option the most comprehensive for mature vector search. Option 2 (incorrect) Amazon S3 is an object storage service and does not natively provide vector similarity search capabilities for real-time querying in RAG applications. Option 3 (incorrect) Amazon ElastiCache is primarily a caching service and, while Redis can be extended for vector search, it is not its native or most mature offering for this purpose compared to dedicated vector databases or extensions like pgvector.'
WHERE question_id = '7b21fc88-9968-4793-ab96-fd8c8e340544';

-- question_id: 7b2762d2-4169-4a0b-9fea-e798aa726bc1
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) This describes model underfitting, where the model is too simple to capture the underlying patterns in the training data, often due to insufficient features or a model with too little capacity, which can be observed when evaluating a model trained with Amazon SageMaker''s built-in algorithms. Option B (correct) This accurately defines overfitting, where a model has learned the training data and its noise too precisely, leading to excellent performance on the training set but poor performance on new, unseen data, a common challenge addressed by techniques like regularization or early stopping in Amazon SageMaker training jobs. Option C (incorrect) A model that is "too small" (lacking sufficient complexity or parameters) typically leads to underfitting, not overfitting, as it lacks the capacity to learn complex patterns, which might be observed when designing custom model architectures for deployment on Amazon SageMaker. Option D (incorrect) Model runtime speed is a performance characteristic related to computational efficiency, not a definition of model overfitting, which concerns a model''s ability to generalize to new data, although overfit models can sometimes be complex and thus run slowly even with optimized Amazon EC2 instances.'
WHERE question_id = '7b2762d2-4169-4a0b-9fea-e798aa726bc1';

-- question_id: 7b55d984-ed9e-413e-b333-c3b6d3c4e151
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Supervised classification with full labeling is unsuitable because it requires a large, fully labeled dataset of both defective and non-defective images to train a model, directly contradicting the requirement to identify defects "without labeling all images." Option B (correct) Anomaly detection with normal product images is the most suitable approach because it allows a model, such as one built with Amazon Lookout for Vision or Amazon SageMaker, to learn the characteristics of "normal" images from a dataset of only good products and then flag any image that deviates significantly as a potential defect without needing labels for defects. Option C (incorrect) Regression analysis is inappropriate because it is an ML technique used for predicting continuous numerical values, such as sales figures or temperatures, rather than classifying images into discrete categories like "defective" or "non-defective." Option D (incorrect) Natural language processing is irrelevant as it is a field of AI focused on understanding, processing, and generating human language from text or speech data, not for analyzing visual information in product images to detect manufacturing defects.'
WHERE question_id = '7b55d984-ed9e-413e-b333-c3b6d3c4e151';

-- question_id: 7b5dce7c-e706-4db8-9f40-df077db17760
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config continuously monitors and records your AWS resource configurations and evaluates them against desired baselines for compliance and security, not for cost optimization recommendations. Option B (correct) AWS Trusted Advisor provides real-time guidance to help you provision your resources following AWS best practices across five categories, including specific recommendations for cost optimization. Option C (incorrect) AWS CloudFormation allows you to define and provision your AWS infrastructure as code, automating resource deployment and management, but it does not offer cost optimization recommendations for existing resources. Option D (incorrect) AWS Systems Manager helps you gain operational insights and automate tasks across your AWS resources for operational excellence, patching, and resource inventory, but it does not provide cost optimization recommendations.'
WHERE question_id = '7b5dce7c-e706-4db8-9f40-df077db17760';

-- question_id: 7b9ab654-0419-409d-90fd-1d9d3d037c26
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deploying instances across multiple AZs for resilience intentionally places instances in physically distinct data centers, which inherently increases network latency between them, rather than minimizing it. Option B (correct) A cluster placement group packs instances closely together within a single Availability Zone to achieve the lowest possible network latency and high-throughput performance, which is critical for tightly coupled HPC applications. Option C (incorrect) Partition placement groups are designed to spread instances across different racks to reduce the impact of hardware failures across partitions, prioritizing fault tolerance over minimizing inter-node communication latency within a single, tightly coupled cluster. Option D (incorrect) A spread placement group places each instance on distinct underlying hardware to maximize fault tolerance, which increases the physical distance and thus network latency between instances, directly conflicting with the goal of minimizing inter-node communication latency.'
WHERE question_id = '7b9ab654-0419-409d-90fd-1d9d3d037c26';

-- question_id: 7bc63276-7c6a-4ecb-b92b-9743cd61ac67
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using IAM policies does not inherently lead to better application performance, as the overhead for credential retrieval via IAM roles or STS is negligible and primarily impacts security and operational management, not runtime execution speed. Option B (correct) IAM policies provide centralized permission management, allowing administrators to define and control access to AWS resources for IAM users, groups, and roles from a single point, ensuring consistent security posture across all applications. Option C (incorrect) IAM is a free service, but its primary benefit is enhanced security and operational efficiency, not direct cost reduction for AWS resources, though preventing security breaches can indirectly save significant costs. Option D (incorrect) While IAM roles and policies can streamline secure deployments by eliminating the need to embed credentials, making the deployment process more secure and less error-prone, "faster deployment" is not the primary or most direct benefit compared to the fundamental security and management advantages of centralized permission control.'
WHERE question_id = '7bc63276-7c6a-4ecb-b92b-9743cd61ac67';

-- question_id: 7c337c4e-3249-4e2c-a49c-0a45c117c28d
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Storing secrets in environment variables on EC2 instances is not a secure or scalable solution for sensitive data as it lacks built-in rotation, centralized management, and can expose secrets through process inspection or logging. Option B (incorrect) Hardcoding secrets directly into application source code is a critical security vulnerability, making credentials easily discoverable, difficult to rotate, and prone to compromise during code sharing or deployment. Option C (correct) AWS Secrets Manager is the designated service for securely storing, managing, and automatically rotating sensitive credentials like database passwords and API keys, offering programmatic access, auditing, and integration with AWS services for secure secret lifecycle management. Option D (incorrect) Encrypting secrets with KMS is a good practice, but storing them in an S3 bucket with public access completely undermines any security benefits by making the encrypted data accessible to the entire internet, and S3 itself does not provide credential rotation capabilities.'
WHERE question_id = '7c337c4e-3249-4e2c-a49c-0a45c117c28d';

-- question_id: 7cbe99a9-4c7b-490f-8460-f3200eb477af
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Granting maximum access for productivity directly contradicts fundamental AWS security best practices and increases the attack surface for potential unauthorized access or accidental misconfigurations, making it harder to track and audit specific actions using AWS CloudTrail. Option B (correct) The principle of least privilege is a core AWS security best practice, ensuring that IAM users, roles, and services are granted only the permissions required to perform their specific tasks, thereby minimizing security risks and enabling precise auditing via AWS CloudTrail. Option C (incorrect) Assigning the same permissions to everyone in AWS violates the principle of least privilege and role separation, leading to over-privileged access for many users and making it impossible to enforce fine-grained access control based on job function, which is managed through IAM policies and groups. Option D (incorrect) Operating with no restrictions needed on IAM permissions is an extremely dangerous security posture, exposing the AWS account to severe risks like unauthorized resource manipulation, data breaches, and compliance failures, directly opposing the robust access control mechanisms provided by AWS IAM and the shared responsibility model.'
WHERE question_id = '7cbe99a9-4c7b-490f-8460-f3200eb477af';

-- question_id: 7da245bb-6afd-49fa-9e6b-d1d247ddc904
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS DMS (Database Migration Service) is primarily used for migrating data from source databases to target databases, handling data replication and data type conversions, but it does not convert the actual database schemas (tables, views, stored procedures, functions, triggers) between different database engines. Option B (correct) AWS SCT (Schema Conversion Tool) is specifically designed to analyze and convert existing database schemas, including stored procedures, functions, and triggers, from one database engine to another, providing detailed assessment reports and helping automate much of the migration process. Option C (incorrect) AWS DataSync is a data transfer service that simplifies, automates, and accelerates moving large amounts of data between on-premises storage and AWS storage services like S3, EFS, or FSx for Windows File Server, and is not involved in database schema conversion. Option D (incorrect) AWS Storage Gateway is a hybrid cloud storage service that connects an on-premises software appliance with cloud-based storage, providing file, volume, or tape gateway solutions, and is unrelated to database schema conversion or database migration.'
WHERE question_id = '7da245bb-6afd-49fa-9e6b-d1d247ddc904';

-- question_id: 7dff6adf-59fe-481c-9f75-a450f5ebb83f
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Selection bias specifically occurs when the training data used for a machine learning model, such as one built in Amazon SageMaker, is not representative of the real-world target population it''s intended to serve, leading to inaccurate or unfair predictions, which AWS FairPlay or SageMaker Clarify aim to detect and mitigate by analyzing feature group imbalances in datasets. Option B (incorrect) Confirmation bias is the human tendency to favor information that confirms existing beliefs or hypotheses, which in an AWS ML context might lead a data scientist using Amazon SageMaker Studio to subconsciously select features or interpret model results in a way that supports a pre-conceived outcome, rather than objectively evaluating performance with SageMaker Experiments. Option C (incorrect) Recency bias is the tendency to give more weight to recent events or information, which in a machine learning scenario like building a forecasting model with Amazon Forecast could lead to overemphasizing the most recent data trends while neglecting important longer-term patterns from older historical data stored in Amazon S3. Option D (incorrect) Anchoring bias is the reliance on an initial piece of information (the anchor) when making decisions, which in an AWS ML development workflow could manifest if the performance of an initial baseline model unduly influences expectations for subsequent, potentially more powerful, models developed using SageMaker Autopilot or SageMaker Pipelines, hindering objective evaluation of improvements.'
WHERE question_id = '7dff6adf-59fe-481c-9f75-a450f5ebb83f';

-- question_id: 7e342e02-56eb-4510-846b-fcfa5f878e55
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Examining CloudFront logs is irrelevant as CloudFront is a Content Delivery Network service primarily concerned with delivering content to end-users, not troubleshooting an EC2 instance''s outbound connectivity from within a VPC. Option B (incorrect) Reviewing Route 53 health checks is not the next logical step because Route 53 health checks are typically used to monitor the health of endpoints for DNS routing, not to diagnose an EC2 instance''s direct outbound network connectivity at the subnet level. Option C (correct) Checking Network Access Control Lists (NACLs) is the correct next logical step because NACLs are stateless firewalls that operate at the subnet level, controlling both inbound and outbound traffic, and can explicitly deny connections that Security Groups (checked previously) might allow. Option D (incorrect) Analyzing ELB access logs will not help resolve this issue as ELB (Elastic Load Balancing) logs record traffic directed to the load balancer and its targets, not outbound connection attempts initiated from an EC2 instance to an external service.'
WHERE question_id = '7e342e02-56eb-4510-846b-fcfa5f878e55';

-- question_id: 7e63cb2d-752b-4df2-815f-bbda1c425c61
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While S3 Standard with a lifecycle transition to S3 Glacier after 30 days is a viable strategy for cost savings and meets the 24-hour retrieval requirement, it requires explicit lifecycle management and does not dynamically adapt to potential, infrequent accesses between 30 days and the Glacier transition without incurring retrieval costs from Glacier. Option B (correct) S3 Intelligent-Tiering automatically moves objects between frequent and infrequent access tiers based on actual access patterns without operational overhead or retrieval charges between those tiers, and can optionally move data to Archive Access tiers (Glacier Flexible Retrieval) if not accessed for 90 days, which fully meets the 24-hour retrieval requirement for audit requests, thus providing optimal cost savings for uncertain access patterns. Option C (incorrect) Direct upload to S3 Glacier is not suitable for constantly generated application logs that may require initial frequent writes and potentially immediate access within the first 30 days, as Glacier is designed for archiving infrequently accessed data with higher write latencies and is not optimized for initial logging ingest. Option D (incorrect) S3 Standard-IA is a reasonable intermediate tier, but transitioning to Glacier Deep Archive introduces a higher risk for the 24-hour retrieval requirement because its standard retrieval option takes 12 hours, which is close to the limit, and expedited retrievals are not available, making it less reliable for critical 24-hour audits compared to S3 Glacier Flexible Retrieval.'
WHERE question_id = '7e63cb2d-752b-4df2-815f-bbda1c425c61';

-- question_id: 7ec7786a-9b49-49a3-97e1-7d661eaffe79
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Prompt injection is a security vulnerability, not a technique intended to improve model performance; while prompt engineering helps optimize model output, prompt injection subverts the model''s intended function, which AWS SageMaker and Bedrock aim to prevent through responsible AI practices. Option B (correct) Prompt injection is indeed a security risk where malicious prompts are crafted to manipulate a large language model''s (LLM) behavior, potentially overriding its instructions, extracting sensitive information, or generating harmful content, a risk AWS Bedrock''s guardrails and responsible AI tools are designed to help mitigate. Option C (incorrect) Prompt injection does not relate to speeding up inference; optimizing inference typically involves techniques like model quantization, hardware acceleration (e.g., AWS Inferentia), or efficient model serving via Amazon SageMaker endpoints. Option D (incorrect) Prompt injection is not a data compression technique; data compression focuses on reducing the size of data for storage or transmission efficiency, a function unrelated to model prompts and handled by services like Amazon S3 for object storage.'
WHERE question_id = '7ec7786a-9b49-49a3-97e1-7d661eaffe79';

-- question_id: 7ecb2603-908c-4d80-9b5b-49c4653e33b6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Data does not persist on instance store volumes when an instance is stopped because instance stores are ephemeral block storage physically attached to the host machine and are tied to the lifecycle of that specific instance. Option B (correct) Data is lost on instance store volumes when an instance is stopped, hibernated, or terminated because these volumes are temporary and their underlying physical storage is deallocated. Option C (incorrect) Data on instance store volumes is not automatically backed up by AWS upon instance stop because instance store is designed for temporary storage and users are responsible for data replication or migration if persistence is required. Option D (incorrect) Data is not automatically moved to EBS when an instance is stopped; instance store data is simply lost, requiring manual data transfer to a persistent storage solution like EBS if preservation is desired.'
WHERE question_id = '7ecb2603-908c-4d80-9b5b-49c4653e33b6';

-- question_id: 7ed7df20-6ea3-4e8b-b1a3-1fb75ef26f70
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Data labeling involves annotating raw data to create training datasets, often done using services like Amazon SageMaker Ground Truth, whereas hyperparameter tuning optimizes the training process of an already labeled model. Option B (correct) Hyperparameter tuning, available through Amazon SageMaker Automatic Model Tuning, systematically explores different hyperparameter values to find the combination that yields the best model performance metrics, such as accuracy or F1 score. Option C (incorrect) Model deployment involves making a trained model available for predictions through an endpoint, typically using Amazon SageMaker Endpoints, which occurs after the model has been trained and tuned. Option D (incorrect) Monitoring drift, facilitated by services like Amazon SageMaker Model Monitor, involves detecting changes in data patterns or model behavior after a model has been deployed, a post-deployment operational task distinct from pre-deployment optimization.'
WHERE question_id = '7ed7df20-6ea3-4e8b-b1a3-1fb75ef26f70';

-- question_id: 7efe64be-0953-4bf8-bf8b-b01c87b3a040
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Manufacturing defect detection heavily relies on analyzing visual data like images or videos to identify anomalies, cracks, or imperfections, making computer vision, specifically object detection models (trainable via Amazon SageMaker or Amazon Rekognition Custom Labels), the most suitable approach to locate and classify defects on products. Option B (incorrect) Text analysis (e.g., using Amazon Comprehend) is designed to process and understand written language for tasks like extracting entities or key phrases from documents, which is not applicable to the visual inspection of physical manufactured goods. Option C (incorrect) Voice recognition (e.g., using Amazon Transcribe) focuses on converting spoken audio into text, a process unrelated to the visual identification of physical defects during manufacturing quality control. Option D (incorrect) Sentiment analysis, often a feature of Amazon Comprehend, is used to determine the emotional tone of text data, such as customer feedback, and offers no utility for visually identifying physical defects on a product.'
WHERE question_id = '7efe64be-0953-4bf8-bf8b-b01c87b3a040';

-- question_id: 7f9a8479-47da-46bd-a6a4-6d5918ab381f
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Creating IAM users is a crucial security best practice for granting least privilege access, but the root account retains full administrative power and must be secured first to prevent a complete compromise of the entire AWS account. Option B (incorrect) Deleting the default VPC is a network configuration task that might be part of a broader security architecture strategy, but it does not address the fundamental security of the AWS account''s primary authentication mechanism. Option C (correct) Enabling Multi-Factor Authentication (MFA) for the AWS root account is the most critical first security step because the root user has unrestricted access to all services and resources, and MFA adds a vital layer of protection against unauthorized access even if the password is compromised. Option D (incorrect) Launching EC2 instances is an operational step to deploy compute resources and is not a security measure; it should only be performed after fundamental account security, like securing the root user, is established.'
WHERE question_id = '7f9a8479-47da-46bd-a6a4-6d5918ab381f';

-- question_id: 81a8059c-5196-49b7-b9fb-2d2a38529410
-- answer_correct: True | verified_indices: [1, 3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Route 53 geolocation routing directs users to a specific region based on their geographical location, not dynamically to the nearest healthy region based on real-time latency or network performance across multiple regions for active-active routing. Option B (correct) AWS Global Accelerator provides static IP addresses that use the AWS global network backbone to route users to the nearest healthy regional endpoint, optimizing performance and providing seamless failover during outages. Option C (incorrect) CloudFront is primarily a CDN for content delivery and caching at edge locations, and while it can route to the nearest edge and perform origin failover, its core function is not intelligent multi-region traffic management for active-active application backends based on lowest latency to the application. Option D (correct) Route 53 latency-based routing directs users to the AWS region with the lowest latency, and when combined with health checks and failover, it provides automatic routing to the nearest healthy region with seamless failover. Option E (incorrect) An Elastic Load Balancer (ELB) operates within a single AWS region and cannot inherently perform cross-region load balancing; a global service like Route 53 or Global Accelerator is required in front of regional ELBs for multi-region active-active setups.'
WHERE question_id = '81a8059c-5196-49b7-b9fb-2d2a38529410';

-- question_id: 82829cb1-7e02-4b79-82d2-a19d8be81e4a
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Vertical scaling involves increasing the resources of a single instance, not adding more instances, while horizontal scaling is about adding or removing instances, not primarily adding power to a single one. Option B (correct) Vertical scaling, also known as "scaling up," involves increasing the computational power (CPU, RAM) of a single server or instance, like upgrading an Amazon EC2 instance type, whereas horizontal scaling, or "scaling out," involves adding more servers or instances to a system, typically managed by AWS Auto Scaling Groups and load balancers to distribute traffic. Option C (incorrect) Both vertical and horizontal scaling are fundamentally different approaches to handling increased load, with distinct implications for resilience, cost, and architecture in AWS environments; vertical scaling upgrades a single resource, while horizontal scaling distributes load across multiple resources. Option D (incorrect) Both vertical and horizontal scaling are methods specifically designed to change (increase or decrease) the capacity of an application or system to handle varying workloads and traffic in AWS, whether by enhancing individual resources or by multiplying them.'
WHERE question_id = '82829cb1-7e02-4b79-82d2-a19d8be81e4a';

-- question_id: 82e13de7-efd0-4d0a-9a52-414e87f64cb0
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Restoring EBS snapshots and launching EC2 instances, along with RDS point-in-time recovery and application configuration, would likely exceed the 30-minute RTO. Option B (correct) By having minimal resources like cross-region RDS read replicas and pre-configured AMIs ready, a pilot light strategy can meet the 5-minute RPO and 30-minute RTO, while being very cost-effective by only scaling up EC2 and other components during a disaster. Option C (incorrect) While meeting the RTO and RPO, maintaining a continuously running, scaled-down version of the entire application in a warm standby configuration is more expensive than a pilot light strategy and is not optimal for cost given the 30-minute RTO. Option D (incorrect) Multi-site active-active involves running a full production environment in two regions simultaneously, which effectively doubles operational costs and is far from cost-effective for a DR site that is "not in use."'
WHERE question_id = '82e13de7-efd0-4d0a-9a52-414e87f64cb0';

-- question_id: 83836719-9bf9-4844-ab37-1408d621d6cb
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) AWS Application Migration Service (AWS MGN) provides continuous block-level replication of on-premises VMware virtual machines to a staging area in AWS, enabling low RPO (minimal data loss) and rapid failover to fully provisioned EC2 instances within minutes, meeting the 30-minute RTO requirement for disaster recovery. Option B (incorrect) VM Import/Export is a migration tool that requires manual export, upload, and import of VM images, which is not suitable for continuous synchronized replication, low RPO, or a rapid 30-minute RTO for disaster recovery. Option C (incorrect) AWS DataSync is a data transfer service designed for file and object data synchronization, not for replicating entire running virtual machines or automatically launching application servers within a 30-minute RTO, and an hourly sync schedule does not provide minimal data loss. Option D (incorrect) AWS Database Migration Service (DMS) specifically focuses on replicating databases and does not provide a comprehensive solution for disaster recovery of an entire on-premises VMware environment running business-critical applications, including the operating system and application servers.'
WHERE question_id = '83836719-9bf9-4844-ab37-1408d621d6cb';

-- question_id: 83996bdc-2018-4873-885b-085aa2312cc3
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Physical server procurement is a time-consuming process involving purchasing, shipping, and installing hardware in traditional data centers, directly hindering the speed and agility that cloud computing provides by offering virtualized resources. Option B (incorrect) Manual capacity planning requires significant human effort and can lead to over-provisioning or under-provisioning of resources, slowing down adjustments and updates, whereas AWS services like Auto Scaling automate resource adjustments to meet demand efficiently. Option C (correct) On-demand resource provisioning allows users to instantly access and scale computing resources like Amazon EC2 instances or Amazon S3 storage as needed, enabling rapid deployment, experimentation, and adaptation to changing business requirements without waiting for physical hardware. Option D (incorrect) Long-term hardware commitments restrict an organization''s ability to quickly adapt to new technologies or changing business needs due to fixed infrastructure, which is contrary to the flexibility and agility offered by AWS''s pay-as-you-go and on-demand pricing models.'
WHERE question_id = '83996bdc-2018-4873-885b-085aa2312cc3';

-- question_id: 83e14d73-644d-49f7-8dc8-17213a0d5e50
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Robust input filtering and safety classifiers are crucial for preventing jailbreaking attacks, leveraging AWS WAF for pre-LLM prompt filtering and Amazon Comprehend or custom SageMaker models for semantic analysis and content moderation to detect and block malicious inputs. Option B (incorrect) Allowing all inputs would directly expose the LLM to various prompt injection and jailbreaking techniques, bypassing fundamental AWS security best practices for input validation and threat prevention. Option C (incorrect) Implementing no restrictions would leave the LLM completely vulnerable to malicious actors seeking to exploit its behavior or extract sensitive information, contrary to the layered security approach recommended by AWS Well-Architected Framework. Option D (incorrect) Maximum openness without strong accompanying security measures like AWS GuardDuty for anomaly detection or Amazon Detective for investigative capabilities creates an exploitable environment, enabling jailbreaking attacks rather than preventing them.'
WHERE question_id = '83e14d73-644d-49f7-8dc8-17213a0d5e50';

-- question_id: 83ed57bf-7175-4739-981a-f357f2dfc073
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Manual server management is characteristic of traditional IaaS models like EC2, where users provision and manage virtual servers, rather than serverless computing like AWS Lambda. Option B (correct) No server management required is a defining feature of serverless computing, as AWS services like Lambda, S3, and DynamoDB abstract away all underlying infrastructure concerns from the developer. Option C (incorrect) Fixed capacity provisioning is contrary to the elastic and auto-scaling nature of serverless computing, where services such as AWS Lambda automatically scale based on the incoming request load. Option D (incorrect) Physical server access is not available in serverless computing, as AWS fully manages the underlying infrastructure and abstracts it from the user, unlike traditional on-premises or even some IaaS solutions.'
WHERE question_id = '83ed57bf-7175-4739-981a-f357f2dfc073';

-- question_id: 8466d562-5727-41b3-9d32-85af70034fc9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Granting maximum permissions for efficiency directly contradicts the principle of least privilege, as it exposes resources to unnecessary risks and increases the potential blast radius in case of compromise, rather than following AWS security best practices. Option B (correct) Granting only the minimum permissions required is the definition of the principle of least privilege, ensuring that IAM users, groups, and roles can perform only their intended tasks and nothing more, which is crucial for reducing security risks as emphasized by AWS Well-Architected Framework''s Security Pillar. Option C (incorrect) Denying all permissions by default would render AWS resources unusable and is not the principle of least privilege; while IAM inherently operates on an explicit deny by default for unallowed actions, the principle aims to grant necessary, minimum permissions, not to entirely prevent access. Option D (incorrect) Granting permissions to all users equally undermines granular access control and the principle of least privilege, as different IAM users and roles have varying job functions and responsibilities, requiring distinct sets of permissions for secure operation within an AWS environment.'
WHERE question_id = '8466d562-5727-41b3-9d32-85af70034fc9';

-- question_id: 84d1ee4a-504f-4fdd-b4b9-14dd97b87c74
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Transfer Acceleration is designed to speed up transfers over long distances by routing data through CloudFront edge locations, which does not eliminate intra-region data transfer costs between S3 and SageMaker and might incur additional charges. Option B (incorrect) S3 buckets are regional resources and do not reside in a single Availability Zone, making it impossible to deploy SageMaker in the "same Availability Zone as S3" to avoid transfer costs. Option C (correct) Configuring S3 Gateway VPC Endpoints for private connectivity allows data transfer between S3 and resources within the same VPC and region, such as SageMaker, to incur no data transfer charges. Option D (incorrect) S3 Select allows you to retrieve only a portion of the data, which reduces the total data transferred and thus the total cost, but it does not eliminate the per-GB transfer charge for the data that is still transferred.'
WHERE question_id = '84d1ee4a-504f-4fdd-b4b9-14dd97b87c74';

-- question_id: 853c4918-b026-4956-a750-5d6280561548
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] (incorrect) AWS Marketplace specifically features solutions from third-party vendors, not solely AWS native services which are directly provided by Amazon Web Services. Option [1] (correct) AWS Marketplace serves as a digital catalog where customers can discover, subscribe to, and deploy a wide range of third-party software, including Amazon Machine Images (AMIs) for EC2 instances, Software as a Service (SaaS) applications, and container products. Option [2] (incorrect) AWS Marketplace primarily offers software solutions, not physical hardware, as AWS operates on a cloud computing model where resources are virtualized. Option [3] (incorrect) While AWS provides training and certification programs, these are typically found on the AWS Training and Certification website, not as the primary or sole offering within the AWS Marketplace, which focuses on deployable software solutions.'
WHERE question_id = '853c4918-b026-4956-a750-5d6280561548';

-- question_id: 854243d8-bc1a-4b24-93a7-f7ccc036477a
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) On-Demand pricing is typically more expensive than Reserved Instances because it offers maximum flexibility without any long-term commitment or upfront payment. Option B (correct) Reserved Instances provide significant discounts, up to 75% compared to On-Demand, in exchange for a 1-year or 3-year commitment and often require an upfront payment (All Upfront, Partial Upfront, or No Upfront options) to secure these lower rates. Option C (incorrect) On-Demand pricing is the standard pay-as-you-go rate without commitment, while Reserved Instance pricing offers discounted rates based on a commitment, so they do not have the same pricing. Option D (incorrect) On-Demand pricing is characterized by its flexibility and lack of commitment, allowing users to pay only for the compute capacity they use without signing long-term contracts.'
WHERE question_id = '854243d8-bc1a-4b24-93a7-f7ccc036477a';

-- question_id: 85b04d50-2750-476f-90a9-feecabf3d3e9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Auto Scaling specifically aims to automate and reduce the need for manual server management by dynamically adjusting resources. Option B (correct) AWS Auto Scaling automatically adjusts the number of EC2 instances, containers, or other resources in a group based on demand, using scaling policies tied to metrics like CPU utilization to ensure application performance. Option C (incorrect) Fixed resource allocation is the opposite of Auto Scaling''s purpose, which is to provide dynamic and flexible resource allocation. Option D (incorrect) Auto Scaling is designed to optimize costs by ensuring you only pay for the capacity needed, preventing over-provisioning and terminating underutilized resources, rather than primarily causing a cost increase.'
WHERE question_id = '85b04d50-2750-476f-90a9-feecabf3d3e9';

-- question_id: 85eba334-1f89-47aa-81fb-9cb2e39cc312
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) CloudTrail logs record API activity and user events within your AWS account, not the actual network traffic flow between IP addresses and resources inside a VPC. Option B (incorrect) CloudWatch Logs is a service for aggregating, monitoring, and storing various types of logs, but it does not generate the network traffic flow information itself; rather, VPC Flow Logs can deliver their data to CloudWatch Logs. Option C (correct) VPC Flow Logs capture detailed information about IP traffic that goes to and from network interfaces in your VPC, including source and destination IP addresses, ports, protocols, and whether traffic was accepted or rejected, which is crucial for troubleshooting network reachability issues. Option D (incorrect) Elastic Load Balancer access logs provide details about requests made to an ELB, such as client IP, request latency, and backend response, but they only cover traffic passing through the load balancer and not all network interfaces within the VPC.'
WHERE question_id = '85eba334-1f89-47aa-81fb-9cb2e39cc312';

-- question_id: 85f0389e-62be-4139-a1d0-8982855d9e56
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) This strategy relies on restoring data and applications from backups (e.g., S3, AWS Backup) to a new environment after a disaster, resulting in the highest Recovery Time Objective (RTO) compared to other options. Option B (incorrect) Warm Standby involves maintaining a scaled-down but fully functional duplicate of the primary environment in another region, with most services already running and ready to take over with minimal activation rather than just "minimal" components requiring significant scaling up. Option C (correct) Pilot Light maintains a minimal, continuously running set of core resources (e.g., a database or base infrastructure) in a separate region, which can be rapidly scaled up by provisioning additional compute and network resources (e.g., EC2 instances, load balancers) when a disaster occurs. Option D (incorrect) Multi-AZ deployment provides high availability within a single AWS Region by distributing resources across distinct Availability Zones to protect against single AZ failures, not against regional disasters.'
WHERE question_id = '85f0389e-62be-4139-a1d0-8982855d9e56';

-- question_id: 861ebd35-23c7-46af-b4f8-21d528fbe992
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) DynamoDB encryption at rest encrypts the entire table at the block level on storage, not individual fields at the application layer, and it does not allow for different encryption keys per field. Option B (correct) The AWS Encryption SDK is designed for application-layer encryption and allows you to programmatically encrypt individual data fields using different customer managed KMS keys, fulfilling the requirement for field-level encryption with multiple keys for separation of duties. Option C (incorrect) Encrypting all fields with the same KMS key at the application layer does not meet the requirement for "different fields require different encryption keys for separation of duties," as it uses a single key for all sensitive data. Option D (incorrect) AWS Certificate Manager (ACM) is primarily used for managing SSL/TLS certificates for network security, not for direct encryption of application data fields at rest within a database.'
WHERE question_id = '861ebd35-23c7-46af-b4f8-21d528fbe992';

-- question_id: 86a447ce-0ba5-4c0a-9356-e59e1af9b079
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Training from scratch involves initializing a model with random weights and training it on a specific dataset without any prior knowledge, which is the opposite of transfer learning and would typically require extensive computational resources managed by services like Amazon SageMaker for full training cycles. Option B (correct) Transfer learning leverages the vast knowledge embedded in a pre-trained foundation model, like those accessible through Amazon Bedrock (e.g., Amazon Titan, Anthropic Claude), by adapting or fine-tuning it with a smaller, task-specific dataset to perform new, related tasks efficiently without starting from zero. Option C (incorrect) Transferring data between systems refers to data movement operations, such as using AWS DataSync to migrate data to Amazon S3 or utilizing S3 Transfer Acceleration for faster uploads, and is a data management concept distinct from machine learning model training methodologies. Option D (incorrect) Moving models between servers or deploying them, for example, from an Amazon SageMaker training job artifact to a SageMaker hosting endpoint for inference, is a model deployment and MLOps process, not the specific technique of leveraging pre-trained knowledge for new tasks known as transfer learning.'
WHERE question_id = '86a447ce-0ba5-4c0a-9356-e59e1af9b079';

-- question_id: 87cc95ff-5f02-486e-95ee-316ab6a89c7b
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Monitoring prediction distributions over time is a key method for detecting concept drift, as a change in the model''s output distribution, even if input data distribution remains stable, indicates that the relationship the model learned no longer holds true, a capability supported by AWS services like Amazon SageMaker Model Monitor which can track shifts in model quality and output characteristics. Option B (incorrect) Ignoring all metrics makes it impossible to detect concept drift or any other model performance issues, directly contradicting fundamental MLOps best practices and the purpose of AWS monitoring services like Amazon CloudWatch and Amazon SageMaker Model Monitor. Option C (incorrect) Checking model performance and data only once annually is insufficient for detecting concept drift, as drift can occur much more frequently and lead to significant degradation in model performance over shorter periods, making continuous or frequent monitoring (e.g., daily or hourly with Amazon SageMaker Model Monitor) essential. Option D (incorrect) While accuracy is an important metric, focusing only on it for concept drift detection is insufficient because accuracy often requires delayed ground truth labels, and drift can manifest in other ways, such as changes in specific class predictions or increased uncertainty, which might not immediately affect overall accuracy but are detectable by monitoring prediction distributions or other model quality metrics as supported by AWS MLOps tools.'
WHERE question_id = '87cc95ff-5f02-486e-95ee-316ab6a89c7b';

-- question_id: 87ced102-3622-47ec-a397-92b1172f9ace
-- answer_correct: True | verified_indices: [0] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS Macie specifically identifies sensitive data within S3, and AWS Config monitors and reports on the security configurations and compliance of resources like S3, RDS, and DynamoDB, providing a comprehensive approach to data protection and reporting across these services. Option B (incorrect) AWS GuardDuty focuses on threat detection for malicious activity, and Amazon Inspector assesses vulnerabilities in EC2 instances and container images, neither of which directly address automated sensitive data classification within S3, RDS, or DynamoDB data stores. Option C (incorrect) AWS Security Hub centralizes security findings and compliance status but does not perform the actual sensitive data discovery across data stores itself, and AWS Config Rules manage resource configurations but do not scan the content for sensitive data. Option D (incorrect) Amazon Macie, even with custom data identifiers, is primarily designed for sensitive data discovery and classification in S3 and does not natively extend its content scanning capabilities to RDS or DynamoDB, making it less comprehensive for multiple data stores.'
WHERE question_id = '87ced102-3622-47ec-a397-92b1172f9ace';

-- question_id: 880f59fc-0d69-49b7-a9a7-ae7a409f378b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The AWS Billing Console provides information related to costs, invoices, and payment methods, not AWS security and compliance reports or certifications. Option B (correct) AWS Artifact is a central, on-demand portal for customers to access AWS security and compliance reports, such as SOC, PCI, and ISO certifications, and online agreements. Option C (incorrect) The AWS Support Center is used for opening support cases, accessing technical documentation, and finding answers to service-related questions, but it is not the repository for compliance certifications. Option D (incorrect) AWS Marketplace is a digital catalog where customers can find, purchase, and deploy third-party software, not AWS''s own security and compliance documentation.'
WHERE question_id = '880f59fc-0d69-49b7-a9a7-ae7a409f378b';

-- question_id: 8995c863-34ad-491f-a14b-4ed4d6bb8372
-- answer_correct: True | verified_indices: [0, 1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) The ISO/IEC 23053 standard for AI trustworthiness, or related standards like ISO/IEC 42001, provides a structured framework for managing AI systems responsibly, and AWS customers leverage services like Amazon SageMaker''s responsible AI capabilities and AWS audit logs to demonstrate adherence to such international standards. Option B (correct) The NIST AI Risk Management Framework offers a systematic approach to identify, assess, manage, and communicate AI risks, aligning with AWS''s responsible AI best practices and services such as Amazon SageMaker Clarify for bias detection and SageMaker Model Monitor for performance drift. Option C (incorrect) "Random guidelines" lack the systematic structure, broad acceptance, and comprehensiveness required for effective AI governance, whereas AWS promotes consistent policy enforcement across accounts using services like AWS Organizations. Option D (incorrect) Operating without governance frameworks for AI introduces significant ethical, legal, and operational risks, underscoring the need for structured approaches that AWS services like AWS Key Management Service (KMS) and Amazon GuardDuty help address by ensuring secure and compliant AI deployments. Option E (incorrect) Relying solely on informal processes for AI governance is insufficient due to their lack of consistency, auditability, and scalability, contrasting with AWS''s emphasis on formal, auditable processes using tools like AWS CloudFormation for Infrastructure as Code and AWS CloudTrail for activity logging.'
WHERE question_id = '8995c863-34ad-491f-a14b-4ed4d6bb8372';

-- question_id: 89bf1238-c5c4-405f-84af-8d40f8bba30f
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Giving users maximum access for productivity is an anti-pattern in security, as it violates the principle of least privilege and increases the blast radius in case of compromised credentials, contrary to AWS security best practices that advocate for fine-grained control via IAM policies. Option B (correct) Granting minimum permissions necessary to perform job functions is the fundamental definition of the principle of least privilege, which is implemented in AWS by crafting specific IAM policies that allow only the required actions on specific resources (e.g., `s3:GetObject` on `arn:aws:s3:::my-bucket/*`) rather than broad permissions. Option C (incorrect) Denying all access by default is a secure starting point for policy evaluation in AWS IAM, but it is not the definition of least privilege itself; the principle focuses on carefully defining what *to allow* (the minimum necessary) rather than simply denying everything. Option D (incorrect) Sharing permissions among all users goes against the principle of least privilege because it would inherently grant unnecessary access to many individuals, leading to over-privileging and making it impossible to enforce the "need-to-know" or "separation of duties" concepts through AWS IAM roles or groups.'
WHERE question_id = '89bf1238-c5c4-405f-84af-8d40f8bba30f';

-- question_id: 89d9d79b-d90d-45fd-963d-e7bf14429829
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) AWS Glue Auto Scaling automatically adjusts the number of worker nodes (DPUs) during job execution based on the workload, ensuring optimal resource utilization and eliminating the need for manual DPU tuning. Option B (incorrect) Using AWS Glue job metrics to manually adjust DPU settings directly contradicts the requirement to optimize DPU allocation "without manually tuning each job". Option C (incorrect) AWS Glue Flex execution optimizes costs by running non-urgent jobs on spare capacity at a lower price, but it does not automatically right-size the DPU capacity based on the active workload of a running job. Option D (incorrect) AWS Compute Optimizer provides recommendations for services like EC2, EBS, Lambda, and ECS Fargate, but it does not currently offer automatic right-sizing or recommendations specifically for AWS Glue job DPU allocation.'
WHERE question_id = '89d9d79b-d90d-45fd-963d-e7bf14429829';

-- question_id: 89f3c5a6-2396-4cd0-bbd6-9396690675d9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Ignoring missing values often leads to biased models or errors during training, as many AWS ML services like Amazon SageMaker''s built-in algorithms expect clean, complete datasets and may fail or produce NaN outputs. Option B (correct) Imputation techniques involve filling in missing values using various strategies (mean, median, mode, predictive models), which is a common data preprocessing step often performed using AWS Glue DataBrew or custom SageMaker processing jobs to prepare high-quality input for ML models. Option C (incorrect) Deleting all records is an extreme and impractical approach as it would eliminate the entire dataset, leaving no data for model training with AWS ML services, making it impossible to build any predictive models. Option D (incorrect) Using raw data as-is without handling missing values is generally a bad practice as it can cause errors in ML pipelines, lead to inaccurate predictions, or prevent AWS ML services from training effective models, thus violating data quality best practices in an ML workflow.'
WHERE question_id = '89f3c5a6-2396-4cd0-bbd6-9396690675d9';

-- question_id: 8a1d9c10-5e1a-4048-90f0-a78a45bad0e0
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Regional data centers house AWS Regions which are geographically distinct areas, but content still needs to travel a significant distance to end-users from these central locations. Option B (incorrect) Availability Zones are distinct physical locations within a single AWS Region designed for fault tolerance and high availability, not for minimizing latency for global content delivery to end-users. Option C (correct) Edge locations, powered by services like Amazon CloudFront, are strategically placed globally to cache content nearest to end-users, significantly reducing latency for content delivery compared to regional data centers. Option D (incorrect) Local Zones extend an AWS Region to bring compute and storage services closer to end-users in a specific metropolitan area, primarily for workloads requiring extremely low latency access to the full AWS API, rather than globally optimized content caching.'
WHERE question_id = '8a1d9c10-5e1a-4048-90f0-a78a45bad0e0';

-- question_id: 8adae3c2-e89d-4dd6-b41d-afbf86cdfc77
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Chunking is a data preprocessing technique for managing input context, not a method for directly increasing the parameter count or overall size of a generative AI model hosted on services like Amazon SageMaker. Option B (correct) Chunking breaks down large input texts or documents into smaller segments to fit within the limited context window of generative AI models, such as those available via Amazon Bedrock, especially for applications like Retrieval Augmented Generation (RAG). Option C (incorrect) Chunking is a text segmentation strategy and does not provide data encryption; data encryption on AWS is handled by services like AWS Key Management Service (KMS) or server-side encryption for Amazon S3. Option D (incorrect) While efficient data handling can indirectly support training, the primary purpose of chunking is not to speed up model training, which is typically optimized through specialized GPU instances (e.g., Amazon EC2 P4d), distributed training frameworks, and optimized data loading pipelines on AWS.'
WHERE question_id = '8adae3c2-e89d-4dd6-b41d-afbf86cdfc77';

-- question_id: 8b0b73b4-60ed-47d3-99db-53f72d2e6939
-- answer_correct: True | verified_indices: [0, 4] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon AppFlow provides managed connectors for various SaaS applications and APIs, handling data transfer and transformation, while AWS Transfer Family offers a fully managed SFTP service, directly addressing multiple heterogeneous delivery methods. Option B (incorrect) While technically feasible, implementing and maintaining 20 distinct AWS Lambda functions for custom ingestion and normalization logic across all sources can become operationally complex and costly due to the extensive custom code development and ongoing management overhead. Option C (incorrect) Although Amazon MSK with Kafka Connect is powerful for streaming data, it may require significant custom connector development for each of the 20 distinct broker systems and their specific SFTP, diverse REST API, and message queue implementations, adding considerable complexity. Option D (incorrect) Amazon Kinesis Data Firehose is a delivery service for streaming data and, while it supports transformation, it lacks native direct ingestion capabilities from heterogeneous sources like SFTP, diverse REST APIs, or arbitrary message queues, necessitating additional services to capture the data. Option E (correct) AWS Glue workflows with custom Python shell jobs provide the flexibility to write specific code to interact with each of the 20 diverse broker systems, including SFTP, REST APIs, and message queues, allowing for tailored ingestion and robust normalization within a serverless ETL framework.'
WHERE question_id = '8b0b73b4-60ed-47d3-99db-53f72d2e6939';

-- question_id: 8bde2ab5-23da-44d7-93b6-1e897081e76c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Scaling up underutilized instances would increase their cost without providing additional value, further exacerbating the problem of underutilization rather than optimizing spending. Option B (incorrect) Idle resources such as EC2 instances and EBS volumes continue to incur charges, including instance-hour costs and storage costs, making their cost significant over time and directly contradicting the goal of reducing spending. Option C (correct) Right-sizing involves downgrading underutilized EC2 instances to smaller, less expensive instance types to match actual workload requirements, while eliminating unused assets means terminating idle EC2 instances and deleting unused EBS volumes to stop incurring costs for resources providing no value. Option D (incorrect) Increasing network bandwidth for all instances, especially underutilized ones, would likely increase costs without addressing the core issue of underutilization or idleness, and is not a relevant cost optimization strategy for the identified problem.'
WHERE question_id = '8bde2ab5-23da-44d7-93b6-1e897081e76c';

-- question_id: 8c1cfc98-01cc-461d-9c75-552d4d88fecd
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Adding effective_date, end_date, and is_current columns is the standard and most efficient design for SCD Type 2 in Redshift, allowing easy identification of current records using the is_current flag and fast historical lookups when customer_id and is_current are used as SORTKEY or DISTKEY for optimized columnar storage and querying. Option B (incorrect) Creating separate current and historical tables introduces significant ETL complexity for maintaining data consistency and querying across multiple tables, which is less efficient and more cumbersome than managing versions within a single dimension table for standard SCD Type 2 in Redshift. Option C (incorrect) While a version_number column can track changes, relying on MAX() to find current records in a large Redshift table is generally less performant than using a dedicated is_current flag, especially when that flag can be part of the SORTKEY for direct and rapid filtering. Option D (incorrect) Redshift does not natively support SQL standard temporal tables with system-versioned timestamps, meaning this approach would require complex manual implementation and would not be an efficient, built-in solution.'
WHERE question_id = '8c1cfc98-01cc-461d-9c75-552d4d88fecd';

-- question_id: 8c27e0ed-ab20-4e9e-aed9-e86417e5f9d9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While EC2 Spot instances with GPU support and checkpointing can provide cost savings and fault tolerance for interruptible jobs, this approach requires significant manual effort for instance management, environment setup, and checkpointing logic, increasing operational overhead compared to a managed service. Option B (correct) SageMaker training jobs with managed spot training directly addresses all requirements by providing a fully managed service for ML training with GPU support, automatically using cost-effective Spot instances, and handling interruptions by resuming jobs from checkpoints, thus balancing performance and cost with minimal operational overhead. Option C (incorrect) ECS with Fargate Spot does not support GPU instances, which is a critical requirement for training machine learning models, and while EFS provides shared storage, it may not offer the "high-speed" performance required for very large datasets and intense GPU training. Option D (incorrect) Batch processing with On-Demand instances does not meet the "cost optimization is critical" requirement, as On-Demand instances are significantly more expensive than Spot instances, and while EBS volumes can be performant, they are not ideal for shared access across multiple ephemeral instances in a burst capacity scenario without additional complex setup.'
WHERE question_id = '8c27e0ed-ab20-4e9e-aed9-e86417e5f9d9';

-- question_id: 8c5a310b-03a5-4ad1-8684-c4900d099616
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Enabling audit logging to S3 captures detailed Redshift database activity, including queries and connections, while enabling CloudTrail for API calls logs management plane operations related to the Redshift cluster, providing comprehensive visibility into both data access and infrastructure changes critical for HIPAA. Option B (incorrect) While enabling user activity, connection, and database audit logs captures crucial internal Redshift events, this option doesn''t specify the persistent storage mechanism (like S3) for these logs or include management plane logging via CloudTrail, making it less comprehensive than Option A for HIPAA compliance. Option C (incorrect) Redshift does not natively send its detailed audit and activity logs directly to CloudWatch Logs; instead, it delivers them to S3, and CloudWatch Logs is primarily used for operational metrics or other service logs. Option D (incorrect) AWS Config tracks and records changes to the configuration of Redshift resources themselves, such as parameter group modifications or security group changes, but it does not log queries executed within the database or actual data access events.'
WHERE question_id = '8c5a310b-03a5-4ad1-8684-c4900d099616';

-- question_id: 8c6d794f-8f73-4250-b55b-a732d59c530b
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) IAM Roles are used to delegate temporary access to AWS resources, often to AWS services, applications, or to users external to your AWS account, rather than assigning permissions directly to multiple IAM Users simultaneously within your account. Option B (incorrect) IAM Policies are JSON documents that define permissions, but they are the permission definitions themselves, not the entity that groups multiple users to receive those permissions. Option C (correct) IAM Groups are a collection of IAM users, allowing you to attach one or more IAM policies to the group, which then grants all users within that group the specified permissions simultaneously. Option D (incorrect) IAM Users represent individual entities, such as a person or application, and while policies can be attached directly to individual users, they do not provide a mechanism to assign permissions to multiple other users simultaneously.'
WHERE question_id = '8c6d794f-8f73-4250-b55b-a732d59c530b';

-- question_id: 8d0bb942-efe8-499d-b1af-958d05898f61
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Inspector primarily focuses on identifying software vulnerabilities and unintended network exposure within EC2 instances, not on evaluating the compliance of AWS resource configurations like security groups or IAM instance profiles against predefined organizational standards. Option B (correct) AWS Config continuously monitors and records AWS resource configurations and can evaluate these configurations against desired states using managed or custom rules, making it ideal for detecting non-compliant security groups and IAM instance profiles and reporting on them. Option C (incorrect) AWS Systems Manager Compliance focuses on aggregated compliance data for patching status and desired state configurations *within* EC2 instances (e.g., software installation, services), not on the compliance of AWS-level resources attached to the instance such as security groups or IAM instance profiles. Option D (incorrect) CloudWatch Events (now Amazon EventBridge) can detect instance launch events but it is an event bus that triggers actions; it does not inherently evaluate resource configurations against compliance rules or continuously report on their compliance status without another integrated service like AWS Config or a custom Lambda function performing the evaluation logic.'
WHERE question_id = '8d0bb942-efe8-499d-b1af-958d05898f61';

-- question_id: 8d18af64-98ed-4b05-84e6-71ccd1583753
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) SageMaker JumpStart does not provide only data storage; data storage is typically handled by services like Amazon S3 and is a foundational component for any ML workflow, not the sole offering of JumpStart. Option 1 (correct) SageMaker JumpStart provides a comprehensive set of pre-trained models, including foundation models for generative AI, along with solution templates for common use cases, enabling developers to quickly get started with ML projects. Option 2 (incorrect) SageMaker JumpStart does not provide only compute resources; while SageMaker utilizes underlying compute instances for model training and inference, JumpStart''s value is in the ready-to-use assets and templates it offers, not just raw compute. Option 3 (incorrect) SageMaker JumpStart does not provide only visualization tools; while SageMaker Studio includes visualization capabilities, JumpStart''s primary function is to accelerate ML development by providing pre-built models and solutions, not exclusively visualization.'
WHERE question_id = '8d18af64-98ed-4b05-84e6-71ccd1583753';

-- question_id: 8ea2b862-a05f-4abb-8c7b-18e75eeece1b
-- answer_correct: True | verified_indices: [0, 1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS Glue job properties include a "Maximum retries" setting that enables automated retry logic with a built-in exponential backoff strategy to handle transient failures. Option B (correct) AWS Step Functions allows defining `Retry` policies within its states for tasks like invoking Glue jobs, providing explicit control over `IntervalSeconds`, `MaxAttempts`, and `BackoffRate` for custom exponential backoff. Option C (incorrect) Implementing custom retry logic using try-catch blocks within the Glue job''s Python code is possible but less ideal for external transient issues, adds complexity to the job''s business logic, and is generally less robust or manageable than external orchestration services. Option D (incorrect) AWS Glue workflow conditional triggers are designed to initiate subsequent actions or jobs based on the success or failure of a preceding job, not to automatically retry the *same* failed job with an exponential backoff strategy. Option E (incorrect) While CloudWatch Events can detect Glue job failures and trigger a Lambda, implementing robust exponential backoff and retry management within a Lambda function for job restarts requires significant custom code, state management, and complexity, making it less straightforward and less native than other AWS service features.'
WHERE question_id = '8ea2b862-a05f-4abb-8c7b-18e75eeece1b';

-- question_id: 8f33eb6b-1dd5-4c08-8ef1-9e7bf27314b3
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) The Principle of Least Privilege dictates that IAM roles attached to ML pipelines, such as those used by Amazon SageMaker or AWS Glue, should only be granted the minimum necessary permissions to perform their specific tasks, like reading from an S3 bucket or writing to a DynamoDB table, thereby minimizing potential security risks. Option B (incorrect) Granting maximum access for efficiency creates a significant security vulnerability, as a compromised ML pipeline could then be used to access or modify resources it doesn''t need, violating AWS security best practices and increasing the blast radius of any security incident. Option C (incorrect) ML pipelines often process sensitive data and intellectual property; applying public access by default would expose these critical assets to unauthorized users, leading to data breaches and non-compliance with data governance regulations, directly contradicting the shared responsibility model. Option D (incorrect) Implementing no access controls for ML pipelines would leave valuable data, compute resources, and the models completely unprotected, making them highly vulnerable to unauthorized access, manipulation, and denial-of-service attacks, which is an unacceptable security posture for any AWS workload.'
WHERE question_id = '8f33eb6b-1dd5-4c08-8ef1-9e7bf27314b3';

-- question_id: 8f82f82c-af1a-4ce4-9d91-80b64fead791
-- answer_correct: True | verified_indices: [1, 4] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Using AWS Lake Formation for column-level security is effective for structured data within tables, but Macie identifies sensitive content within files, and Lake Formation doesn''t directly secure the raw identified S3 files without prior ETL processing to create a Glue Data Catalog table. Option 1 (correct) Moving identified files to a separate S3 bucket allows for the application of more stringent and dedicated bucket policies and access controls specifically tailored to highly sensitive data, effectively isolating and protecting it. Option 2 (incorrect) While masking or tokenizing PII with AWS Glue ETL is a valid data transformation strategy, it modifies the data rather than immediately securing the identified original files from unauthorized access in their current state. Option 3 (incorrect) Configuring S3 Block Public Access at the account level is a foundational best practice to prevent public exposure of S3 buckets, but it does not specifically address securing sensitive data from authorized internal users or specific PII identified within an existing data lake context. Option 4 (correct) Enabling AWS KMS encryption with restrictive key policies provides robust encryption at rest for the sensitive data, ensuring that only authorized users or services with permissions to the KMS key can decrypt and access the identified files.'
WHERE question_id = '8f82f82c-af1a-4ce4-9d91-80b64fead791';

-- question_id: 8f876da0-f7ff-4f71-94d2-3654e646be9c
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The retrieval phase in RAG, often involving querying a vector database like Amazon OpenSearch Service or Amazon Aurora''s pgvector extension, adds an extra step to the inference pipeline, thereby increasing overall latency compared to directly querying a foundational model on Amazon Bedrock. Option B (correct) By integrating with a vector database that stores embeddings of external, current data (e.g., in Amazon S3, processed via AWS Glue, and indexed in Amazon OpenSearch Service), RAG enables a foundational model accessed via Amazon Bedrock to provide answers based on the latest information without requiring expensive and time-consuming retraining or fine-tuning of the model itself. Option C (incorrect) RAG itself is an architectural pattern that combines a retriever and a generator; it does not directly shrink the size of the underlying foundational model (like those available in Amazon Bedrock) but rather allows it to access external knowledge, potentially reducing the need for extensive fine-tuning on domain-specific data that would otherwise inflate model parameters. Option D (incorrect) While RAG avoids the significant computational expense of continually retraining or extensively fine-tuning large language models on services like Amazon SageMaker, it introduces new costs for maintaining and querying a vector database (e.g., Amazon OpenSearch Service) and performing an additional embedding generation step using services like Amazon Titan Embeddings, which can increase the overall operational computational cost compared to a direct foundational model inference.'
WHERE question_id = '8f876da0-f7ff-4f71-94d2-3654e646be9c';

-- question_id: 8fd6beb7-cc1d-4b66-a7b3-dcc097a1b29e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) IAM Access Analyzer is a security feature that helps identify unintended access to your AWS resources by analyzing resource policies, not a service for identity federation or single sign-on. Option B (correct) AWS IAM Identity Center (SSO) is specifically designed to provide a single sign-on experience for users accessing multiple AWS accounts and applications, allowing integration with an existing corporate Active Directory for identity federation. Option C (incorrect) IAM Roles define permissions that federated users assume to access AWS resources, but they do not provide the identity federation or single sign-on capability from a corporate Active Directory themselves. Option D (incorrect) AWS Directory Service provides managed Active Directory instances or a connector to an on-premises Active Directory, serving as an identity source for federation, but it doesn''t directly enable the single sign-on experience to AWS resources on its own.'
WHERE question_id = '8fd6beb7-cc1d-4b66-a7b3-dcc097a1b29e';

-- question_id: 91b35f8c-8e4a-4fb9-847c-0d91d2ab7241
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using multiple AWS Regions generally increases costs due to redundant resource deployment, inter-region data transfer charges, and potential additional operational overhead for managing distributed infrastructure. Option B (correct) A primary advantage of using multiple AWS Regions is to achieve robust disaster recovery by distributing workloads across geographically separate locations, ensuring business continuity even during a regional outage, and to meet stringent compliance requirements for data residency and availability across different geopolitical boundaries. Option C (incorrect) Managing resources across multiple AWS Regions introduces complexity related to cross-region networking, data synchronization, deployment pipelines, and consolidated monitoring, which often requires more sophisticated architectural patterns and operational processes. Option D (incorrect) While deploying resources in multiple regions can reduce latency for end-users by serving them from a region closer to their geographic location, this is often a secondary benefit or an enabler for performance optimization, not the main overarching advantage when compared to disaster recovery and compliance needs.'
WHERE question_id = '91b35f8c-8e4a-4fb9-847c-0d91d2ab7241';

-- question_id: 91eefe51-17dc-46cd-94e7-06233386b5e6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Resetting after each message would explicitly erase any previously established state or session attributes, preventing the chatbot from recalling earlier parts of the conversation, which is the opposite of maintaining context in AWS Lex. Option B (correct) Maintaining conversation history, often through session attributes, slot values, or explicit storage like Amazon DynamoDB for custom solutions, allows the chatbot to recall previous turns and respond contextually, as supported by Amazon Lex''s context management features. Option C (incorrect) Using random responses indicates a lack of contextual understanding and a failure to process user input meaningfully, which actively prevents any coherent conversation flow and is never a best practice for conversational AI. Option D (incorrect) Ignoring previous messages means each interaction is treated as a new, isolated query, effectively discarding all context and making it impossible for the chatbot to handle follow-up questions or refer to prior information, which Amazon Lex''s context and session management features are designed to overcome.'
WHERE question_id = '91eefe51-17dc-46cd-94e7-06233386b5e6';

-- question_id: 92571506-4e56-4a4b-9328-e29a0b9fac6e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Negative prompts do not primarily increase generation speed; they can sometimes even slightly increase processing time as the model needs to incorporate additional constraints during inference on services like Amazon Bedrock or SageMaker. Option B (correct) Negative prompts are specifically designed to guide generative AI models, such as those available through Amazon Bedrock (e.g., Stable Diffusion XL), by explicitly telling them what elements, styles, or concepts to *avoid* in the generated output. Option C (incorrect) Negative prompts do not inherently reduce costs; the cost of generative AI services on AWS, like Amazon Bedrock, is typically based on input/output tokens or requests, which a negative prompt might minimally increase due to added complexity. Option D (incorrect) Negative prompts are a method for content control within the generation process and have no function related to encrypting outputs, which is a security feature handled by AWS services using mechanisms like KMS for data protection.'
WHERE question_id = '92571506-4e56-4a4b-9328-e29a0b9fac6e';

-- question_id: 926bcbf7-df85-451d-a58e-b45c15b9ac9e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudWatch is the primary service used for monitoring applications, collecting metrics, and logging, while CloudFormation focuses on resource provisioning. Option B (correct) AWS CloudFormation allows users to define their AWS infrastructure and resources as code using declarative templates (JSON or YAML) for automated provisioning and management. Option C (incorrect) AWS Identity and Access Management (IAM) is the service specifically designed for managing user access and permissions to AWS resources. Option D (incorrect) AWS Cost Explorer, AWS Budgets, and the AWS Billing and Cost Management console are the services and tools used for analyzing and managing AWS costs.'
WHERE question_id = '926bcbf7-df85-451d-a58e-b45c15b9ac9e';

-- question_id: 926d1da4-e8ba-47ab-9815-ae7a09e5804b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Granting broad permissions initially violates the principle of least privilege by providing more access than necessary, which increases the potential attack surface and goes against AWS security best practices for IAM policy definition. Option B (correct) Starting with minimal permissions and adding as needed directly embodies the principle of least privilege, ensuring that IAM users and roles only have the necessary permissions to perform their specific tasks, thereby minimizing security risks and aligning with AWS''s recommended approach for fine-grained access control. Option C (incorrect) Using only administrative access for all users or roles is a severe breach of the least privilege principle, providing overly permissive access that drastically increases the risk of unauthorized actions or data breaches, contrary to AWS''s guidance on creating specific, functional IAM policies. Option D (incorrect) Sharing credentials among users is a critical security anti-pattern and directly violates AWS IAM best practices, as it eliminates individual accountability for actions recorded in CloudTrail logs, complicates access management, and compromises the security of individual user identities.'
WHERE question_id = '926d1da4-e8ba-47ab-9815-ae7a09e5804b';

-- question_id: 92e557c3-1afa-44b2-b72a-2d47245dbd23
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Pre-training from scratch is the most computationally intensive approach, requiring vast datasets, extensive GPU clusters (e.g., Amazon EC2 P4d/P5 instances or SageMaker HyperPod), and weeks to months of training to build a foundation model from the ground up. Option B (incorrect) Full fine-tuning is computationally intensive as it involves updating a significant portion or all of a large foundation model''s parameters using GPU instances (like those on Amazon SageMaker such as ml.g5 or ml.p3) and a substantial amount of labeled data, consuming significant training resources. Option C (correct) In-context learning (also known as prompt engineering or few-shot learning) requires the least computational resources because it leverages a pre-trained foundation model as-is without modifying its weights or requiring any model training, only utilizing prompt construction and potentially embedding lookups (e.g., via Amazon Kendra or Amazon OpenSearch Service for RAG) during inference. Option D (incorrect) Continuous pre-training is a highly resource-intensive process that involves extending the pre-training of an existing foundation model on new or updated datasets, still demanding significant GPU compute (e.g., SageMaker training jobs) and data processing, similar in scale to initial pre-training.'
WHERE question_id = '92e557c3-1afa-44b2-b72a-2d47245dbd23';

-- question_id: 93276109-10fa-49b5-a4e9-439a5cc1ef10
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) CloudFront primarily caches static content and, while it can proxy dynamic requests, it doesn''t optimize the end-to-end network path over the AWS backbone for dynamic API calls from global edge locations to a single origin in the same way Global Accelerator does, and caching might not be suitable for all API responses. Option B (correct) AWS Global Accelerator uses the AWS global network backbone to route user traffic from the closest AWS edge location directly to the ALB in us-east-1, significantly reducing latency and improving consistency for global users accessing dynamic API endpoints without requiring multi-region deployment. Option C (incorrect) Route 53 latency-based routing requires multiple regional endpoints to distribute traffic based on latency, which contradicts the requirement of a single-region deployment for the backend. Option D (incorrect) Cross-region VPC peering connects private networks between regions and does not address improving the public internet network path or latency for external global users accessing an application''s public API endpoints.'
WHERE question_id = '93276109-10fa-49b5-a4e9-439a5cc1ef10';

-- question_id: 93d1320c-3c14-4025-a78f-c7d8cb1d7d02
-- answer_correct: True | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While Amazon RDS for Oracle is a managed relational database service, it still relies on traditional instance scaling which is less suitable for unpredictable, high-volume write operations compared to cloud-native, auto-scaling solutions. Option B (incorrect) Amazon DynamoDB is a NoSQL database optimized for high-performance key-value and document workloads, which would require significant application re-architecture for a traditional relational database struggling with transactional scalability, and is not a direct fit for maintaining relational semantics. Option C (incorrect) Amazon Redshift is a data warehousing service designed for analytical processing (OLAP) and is not intended for the transactional (OLTP) workloads described in the question. Option D (correct) Amazon Aurora Serverless is a relational database service that automatically scales its compute and memory capacity based on workload demand, making it ideal for unpredictable, high-volume transactional write operations and variable read patterns while maintaining relational database functionality.'
WHERE question_id = '93d1320c-3c14-4025-a78f-c7d8cb1d7d02';

-- question_id: 93d2d97c-19a1-43b7-969d-b4de4f474b5a
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Regions are large geographic areas that host multiple Availability Zones and house core AWS services, serving as primary deployment areas for applications rather than content caching points closest to end users. Option B (incorrect) Availability Zones are isolated locations within a Region, designed for high availability and fault tolerance by separating resources like compute and storage, but they do not function as content caching locations for end users. Option C (correct) Edge locations, powered by services like Amazon CloudFront, are strategically distributed worldwide to cache content and optimize network routing, delivering content with the lowest latency to end users. Option D (incorrect) Data centers are the physical facilities that house servers and networking equipment for AWS infrastructure, including Regions and Availability Zones, but "data centers" is a general term and not the specific AWS global infrastructure component optimized for edge content caching.'
WHERE question_id = '93d2d97c-19a1-43b7-969d-b4de4f474b5a';

-- question_id: 946cc1d7-c305-4abd-94d2-adb183ece7fa
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Lambda functions with provisioned concurrency for consistent performance will minimize cold start latency but are not the most cost-effective during prolonged low-demand periods as provisioned concurrency incurs charges regardless of invocation. Option B (incorrect) ECS with Fargate Spot instances and Application Auto Scaling offers significant cost savings but Fargate Spot instances are subject to interruptions, which can negatively impact consistent response times for an inference service. Option C (correct) SageMaker real-time endpoints with automatic scaling enabled are purpose-built for ML inference, inherently minimize cold start latency by keeping instances warm, and optimize costs by scaling instance count up and down based on demand. Option D (incorrect) API Gateway with Lambda integration and response caching enabled can improve response times for cached requests but does not inherently minimize cold start latency for all unique inference requests processed by the underlying Lambda function.'
WHERE question_id = '946cc1d7-c305-4abd-94d2-adb183ece7fa';

-- question_id: 94983f4e-ca65-4978-9a18-c4f07271aaae
-- answer_correct: True | verified_indices: [2, 3] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increasing Glue DPU allocation provides more total resources and potentially more memory per executor, but it is primarily a scaling measure rather than an optimization that addresses the underlying inefficiency of memory-intensive join operations. Option B (incorrect) Enabling dynamic resource allocation helps manage the number of executors based on workload for cost and efficiency, but it does not prevent individual executors from exceeding memory limits during specific memory-intensive operations like joins. Option C (correct) Implementing broadcast joins for smaller lookup tables avoids shuffling the larger dataset, significantly reducing network I/O, disk I/O, and executor memory pressure associated with intermediate shuffle data during join operations. Option D (correct) Using bucketing on join keys for both tables ensures that corresponding data partitions are co-located, allowing for an efficient bucketed join that significantly reduces data shuffling and memory consumption during join operations.'
WHERE question_id = '94983f4e-ca65-4978-9a18-c4f07271aaae';

-- question_id: 94b0cd86-b7a0-4cae-9dcd-f84d0913ac71
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Diffusion models operate by gradually transforming random noise into a coherent image through an iterative denoising process, a computationally intensive task often accelerated by GPU-enabled instances on AWS SageMaker, such as `ml.g5` or `ml.p4d` types, to perform the thousands of inference steps efficiently. Option B (incorrect) Image generation with diffusion models is an iterative, multi-step process, not instant, requiring a measurable amount of time for each denoising step, which can be managed for scale and performance on AWS using services like Amazon EC2 with powerful GPUs or AWS Batch for parallel processing. Option C (incorrect) While diffusion models can be conditioned by text prompts (text-to-image), their core function is image synthesis, not text analysis, a task better suited for dedicated AWS natural language processing services like Amazon Comprehend. Option D (incorrect) Diffusion models are specifically designed as generative AI models with robust image creation capabilities, enabling the generation of diverse and high-quality visuals for various applications when deployed on scalable AWS compute infrastructure like SageMaker inference endpoints.'
WHERE question_id = '94b0cd86-b7a0-4cae-9dcd-f84d0913ac71';

-- question_id: 95e733c5-ec51-4a5a-b2d8-e49e411aae52
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Dynamic prompting should be used for context-dependent variable responses, leveraging AWS services like Amazon Bedrock where prompts are dynamically constructed, perhaps by AWS Lambda functions, to incorporate real-time user input, session state, or external data from databases like Amazon DynamoDB to generate highly relevant and personalized outputs from foundation models. Option B (incorrect) For static responses, dynamic prompting is unnecessary and introduces undue complexity, as a fixed prompt or pre-computed response would be more efficient, without requiring the runtime logic to vary prompt content. Option C (incorrect) Never varying prompts severely restricts the utility of generative AI applications on AWS, preventing them from adapting to diverse user needs, real-time data, or evolving scenarios, thereby limiting the effectiveness of foundation models accessed via Amazon Bedrock. Option D (incorrect) While fixed templates provide a baseline for prompt engineering, solely using them prevents an application from dynamically injecting variable data, user-specific information, or real-time context into the prompt, thereby hindering the generative AI model''s ability to produce truly adaptive and personalized responses.'
WHERE question_id = '95e733c5-ec51-4a5a-b2d8-e49e411aae52';

-- question_id: 95e9df82-ceef-4b25-9be1-08675e0328b7
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Performance Efficiency focuses on using computing resources efficiently to meet system requirements and maintain efficiency as demand changes, for example, by right-sizing EC2 instances or utilizing Auto Scaling to match capacity with demand. Option B (correct) Reliability encompasses the ability of a system to recover quickly from infrastructure or service disruptions, ensuring business continuity through strategies like multi-AZ deployments, backup and restore procedures using AWS Backup, and robust disaster recovery plans. Option C (incorrect) Cost Optimization focuses on avoiding unneeded costs and choosing optimal resources for a workload by, for instance, utilizing Reserved Instances, Spot Instances, or Graviton processors to reduce operational expenditure. Option D (incorrect) Sustainability primarily focuses on minimizing the environmental impacts of running cloud workloads through actions such as optimizing resource utilization, selecting energy-efficient services, and leveraging newer, more efficient hardware.'
WHERE question_id = '95e9df82-ceef-4b25-9be1-08675e0328b7';

-- question_id: 95f1f213-b2d3-4a1c-bde3-48014ff6bb6f
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) because Memory Optimized instances (e.g., R-series, X-series, U-series) are designed for workloads requiring high memory performance and large datasets in RAM, such as high-performance databases or real-time big data analytics, not primarily CPU-intensive computations. Option 1 (incorrect) because Storage Optimized instances (e.g., I-series, D-series) are designed for workloads that require high, sequential read and write access to very large datasets on local storage, like NoSQL databases, data warehousing, or distributed file systems, rather than raw compute power. Option 2 (correct) because Compute Optimized instances (e.g., C-series) are specifically engineered to provide very high-performance processors and are ideal for compute-bound applications like high-performance computing (HPC), scientific modeling, gaming servers, and video encoding. Option 3 (incorrect) because General Purpose instances (e.g., M-series, T-series) offer a balance of compute, memory, and networking resources and are suitable for a wide range of diverse workloads like web servers or small-to-medium databases, but are not specifically optimized for the highest CPU demands.'
WHERE question_id = '95f1f213-b2d3-4a1c-bde3-48014ff6bb6f';

-- question_id: 960b4f45-c855-4d93-90dc-66ecde2295e6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Auto Scaling automatically adjusts the number of EC2 instances in response to demand, but it relies on a load balancer to distribute traffic to those instances. Option B (correct) Elastic Load Balancing (ELB) is the specific AWS service designed to automatically distribute incoming application traffic across multiple targets, such as EC2 instances, containers, and IP addresses. Option C (incorrect) CloudFront is a content delivery network (CDN) service that caches content at edge locations to improve delivery speed, rather than distributing live application traffic across backend servers. Option D (incorrect) Route 53 is a highly available and scalable cloud Domain Name System (DNS) web service that translates domain names to IP addresses and can route traffic at the DNS level, but it does not automatically distribute incoming application traffic across multiple targets at the application layer.'
WHERE question_id = '960b4f45-c855-4d93-90dc-66ecde2295e6';

-- question_id: 9664778d-78aa-4f9e-8d80-5b7a8b8a4086
-- answer_correct: False | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{3}'::integer[],
    explanation = 'Option A (incorrect) An Internet Gateway enables public internet access for the VPC, meaning data would traverse the public internet, which violates the requirement for a private connection. Option B (incorrect) VPC Peering allows private network communication between two Amazon VPCs within AWS, not between an on-premises network and an AWS VPC. Option C (incorrect) AWS PrivateLink creates private endpoints for accessing AWS services or partner services privately from within a VPC, but it does not establish the fundamental private network connection between an on-premises data center and the entire VPC. Option D (correct) AWS Direct Connect establishes a dedicated, private physical network connection from an on-premises data center directly to an AWS Direct Connect location, ensuring high bandwidth, low latency, and bypassing the public internet, thereby meeting all specified requirements.'
WHERE question_id = '9664778d-78aa-4f9e-8d80-5b7a8b8a4086';

-- question_id: 96ca9e84-3aa3-45b9-b9ba-e26c1446e430
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Fault tolerance refers to a system''s ability to continue operating despite the failure of one or more components, often achieved in AWS by distributing resources across multiple Availability Zones with services like Elastic Load Balancing. Option B (correct) Elasticity is the ability to acquire computing resources dynamically as needed and release them when no longer required, a core feature of AWS implemented through services like Amazon EC2 Auto Scaling. Option C (incorrect) High availability ensures that a system or service remains operational for a specified period, often achieved in AWS by deploying redundant resources across multiple Availability Zones or Regions. Option D (incorrect) Durability refers to the long-term persistence of data without degradation or loss, exemplified by Amazon S3''s 11 nines of durability, which redundantly stores data across multiple devices.'
WHERE question_id = '96ca9e84-3aa3-45b9-b9ba-e26c1446e430';

-- question_id: 96f755d0-11fc-454d-8e1d-03d2486734b2
-- answer_correct: True | verified_indices: [2] | confidence: 95%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Inbound data transfer from the internet into AWS services like EC2 or S3 is generally free of charge. Option B (incorrect) While data transfer between services in different Availability Zones within the same region (e.g., between two EC2 instances) does incur a cost, data transfer within the same Availability Zone is often free and this type of transfer is distinct from the primary "data transfer out to the internet" charges. Option C (correct) Data transferred out from AWS to the internet, also known as egress traffic, is almost always charged per gigabyte and is a primary component of AWS data transfer costs. Option D (incorrect) Data stored in S3 is subject to storage costs based on the volume of data stored and its storage class, which is a separate charge from data transfer costs.'
WHERE question_id = '96f755d0-11fc-454d-8e1d-03d2486734b2';

-- question_id: 9793f88c-327a-4c0f-8a6f-aee6dc2d0500
-- answer_correct: True | verified_indices: [3] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While technically possible, this approach involves significant operational overhead for managing EC2 instances, operating systems, and transcoding software, making it less efficient than leveraging a fully managed service for video transcoding. Option B (incorrect) AWS Batch with Spot instances is highly scalable and cost-effective for custom batch processing, but it still requires building and maintaining custom container images and transcoding logic, incurring more operational overhead than a specialized managed service for this common task. Option C (incorrect) CloudWatch Events is an unsuitable trigger for S3 object uploads; S3 event notifications are the correct and standard mechanism for detecting new video uploads, and this solution also requires managing custom transcoding software. Option D (correct) This architecture efficiently combines S3 event notifications for automatic triggering, Lambda for lightweight orchestration, and AWS Elemental MediaConvert, which is a fully managed, serverless, and purpose-built service for professional video transcoding that inherently scales and optimizes costs without requiring any underlying infrastructure management.'
WHERE question_id = '9793f88c-327a-4c0f-8a6f-aee6dc2d0500';

-- question_id: 979f1148-bb46-4d7b-8501-fdc15176d09a
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) AWS CloudTrail primarily provides a record of API calls and events for auditing and security analysis, not continuous compliance monitoring or configuration drift detection against defined rules. Option B (correct) AWS Config continuously monitors and records your AWS resource configurations, evaluating them against desired configurations and identifying non-compliance or configuration drift using configurable rules. Option C (incorrect) Amazon CloudWatch is primarily used for monitoring operational performance and health through logs, metrics, and events, rather than directly assessing continuous compliance or detecting configuration drift. Option D (incorrect) AWS Systems Manager offers various operational management capabilities like patch management and state enforcement, but it does not natively provide continuous compliance monitoring or configuration drift detection based on defined rules like AWS Config.'
WHERE question_id = '979f1148-bb46-4d7b-8501-fdc15176d09a';

-- question_id: 97a720cc-4d71-4fd9-90b6-746fd8cdae1d
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) Reducing Glue DPU allocation addresses over-provisioning for Glue, but provisioned Redshift clusters do not have compute node auto-scaling that would scale down to zero during idle times, only concurrency scaling for read queries. Option B (incorrect) Migrating to AWS Step Functions primarily improves orchestration, and AWS Lambda is suitable for lightweight transformations but may not be appropriate or cost-effective for data-intensive transformations currently handled by Glue jobs. Option C (correct) Glue job auto-scaling dynamically adjusts DPU allocation based on workload, ensuring payment only for utilized resources, and Redshift Serverless provides true consumption-based pricing by automatically scaling capacity and pausing during inactivity, directly addressing idle costs for both services. Option D (incorrect) Scheduling exact start times for Glue jobs is good practice but doesn''t solve DPU over-provisioning within the job, and while pausing a Redshift cluster saves costs, it requires manual or programmatic management and is less seamless than the automatic scaling and pausing offered by Redshift Serverless.'
WHERE question_id = '97a720cc-4d71-4fd9-90b6-746fd8cdae1d';

-- question_id: 97fa7d4d-624c-42d6-808e-e5d15f9d8d9f
-- answer_correct: True | verified_indices: [0] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) This approach is highly effective because creating a Redshift snapshot and restoring it to a development cluster provides an exact copy of the production data, which can then be directly transformed using SQL to mask PII while retaining data structure and relationships. Option B (incorrect) Redshift data sharing allows sharing live data, but Lake Formation masking capabilities are primarily for data lakes and external tables, and do not directly apply dynamic, cell-level masking policies to shared Redshift cluster data for consumer clusters. Option C (incorrect) While technically feasible, exporting to S3 and using Glue for masking introduces additional data movement and an external ETL process, which can be more complex and potentially slower or more costly than direct SQL transformations within Redshift for this specific use case. Option D (incorrect) Manually creating synthetic data is impractical for production-scale datasets as it is labor-intensive, difficult to maintain data realism, and highly prone to inconsistencies compared to transforming actual production data.'
WHERE question_id = '97fa7d4d-624c-42d6-808e-e5d15f9d8d9f';

-- question_id: 98a5fd95-048a-4c2e-8df2-7e49cd83027e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Marketplace does not offer only AWS services; AWS services are directly available to customers via the AWS Management Console, CLI, and APIs, while the Marketplace focuses on offerings from third-party vendors. Option B (correct) AWS Marketplace serves as a curated digital catalog where customers can discover, subscribe to, and deploy third-party software solutions, data products, and professional services that are validated to run on AWS infrastructure, often delivered as AMIs, SaaS, containers, or machine learning models. Option C (incorrect) AWS Marketplace does not offer physical hardware; AWS provides virtualized cloud computing resources, and customers do not purchase physical hardware directly through the Marketplace. Option D (incorrect) AWS Marketplace does not primarily offer training courses; AWS Training and Certification provides official training and certification programs, which are separate from the software and data products cataloged in the Marketplace.'
WHERE question_id = '98a5fd95-048a-4c2e-8df2-7e49cd83027e';

-- question_id: 99626ee1-7311-41ac-aae8-fc46ec41c26c
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS Glue allows users to define custom classifiers using Grok patterns or XML/JSON structures to parse data formats that are not natively supported by its built-in classifiers, enabling the crawler to correctly infer the schema for custom file formats. Option B (incorrect) Applying a JSON classifier to files that are not actually in JSON format will lead to classification failures or incorrect schema inference because the data structure does not conform to JSON syntax. Option C (incorrect) Increasing the maximum concurrent runs for a Glue crawler only affects the parallel execution capacity and performance of the crawler, not its ability to understand and infer schemas from custom file formats. Option D (incorrect) Skipping schema inference would prevent the crawler from generating any schema for the custom files, which directly contradicts the goal of properly classifying and cataloging the data in the Glue Data Catalog.'
WHERE question_id = '99626ee1-7311-41ac-aae8-fc46ec41c26c';

-- question_id: 9963294c-49de-4e88-bfa3-a3c5ff8a1947
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Tagging data with customer IDs is useful for identification and management, but AWS Organizations primarily offers policy enforcement through Service Control Policies (SCPs) and doesn''t provide a native, centralized mechanism to automate the deletion of customer data across diverse services like active databases, S3, Redshift, and backups based solely on tags. Option B (correct) Implementing data lifecycle management with customer ID as a partition key (or primary identifier) enables efficient and targeted deletion of all customer data across active databases (e.g., DynamoDB, RDS through application logic), S3 data lakes (via prefixes and S3 Lifecycle rules), and Redshift warehouses (through `DELETE` statements), making it feasible to locate and remove all related data systematically within the required timeframe. Option C (incorrect) While AWS Backup with deletion policies and RDS automated snapshots with retention limits manage the lifecycle of backups, this option focuses primarily on system-level backup expiration rather than the targeted identification and deletion of specific customer data from active systems and backups across all required services. Option D (incorrect) S3 Object Lock is designed for data immutability, preventing objects from being deleted or overwritten for a specified period, which directly contradicts the requirement to permanently delete customer data within 30 days under the right to erasure.'
WHERE question_id = '9963294c-49de-4e88-bfa3-a3c5ff8a1947';

-- question_id: 99fa6f44-bc6a-4b59-aec8-31207b69e05e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon CloudWatch is a monitoring and observability service that collects logs, metrics, and events from various AWS services and applications, but it is not the service that *generates* the primary audit logs of AWS API calls. Option B (correct) AWS CloudTrail provides a record of actions taken by a user, role, or an AWS service in AWS by logging all API calls and related events, which is crucial for governance, compliance, operational auditing, and security analysis. Option C (incorrect) AWS Config continuously monitors and records your AWS resource configurations and provides compliance reporting on resource changes, rather than providing audit logs of API calls made to your account. Option D (incorrect) Amazon GuardDuty is a threat detection service that continuously monitors for malicious activity and unauthorized behavior by analyzing data sources like VPC Flow Logs, DNS logs, and CloudTrail event logs, but it does not *provide* the audit logs itself.'
WHERE question_id = '99fa6f44-bc6a-4b59-aec8-31207b69e05e';

-- question_id: 9a02bfc2-fb8f-40f1-84a3-b6de1bdcfbcb
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Moving models between servers refers to deployment or infrastructure management tasks, such as hosting a model on an Amazon SageMaker Endpoint or migrating a custom model between Amazon EC2 instances, not the machine learning methodology of transfer learning. Option B (correct) Transfer learning in foundation models involves taking a model pre-trained on a massive dataset for a general task and then fine-tuning it with a smaller, task-specific dataset to apply its learned knowledge to a new, related task, a practice heavily supported by AWS services like Amazon Bedrock and Amazon SageMaker JumpStart. Option C (incorrect) Transferring data between databases, often accomplished using AWS services like AWS Database Migration Service (DMS) or data pipelines built with AWS Glue, is a data engineering task unrelated to the machine learning concept of transfer learning. Option D (incorrect) While copying model weights is a foundational step in implementing transfer learning, often by initializing a new model with weights from a pre-trained model available through Amazon SageMaker JumpStart, it is not the complete definition of transfer learning, which includes the subsequent fine-tuning and adaptation to a new task.'
WHERE question_id = '9a02bfc2-fb8f-40f1-84a3-b6de1bdcfbcb';

-- question_id: 9a31e335-6c59-4991-a83f-07965ff21680
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using shared accounts makes it impossible to audit individual actions via AWS CloudTrail logs and creates difficulty in revoking access for a specific departing employee without impacting others still using the shared account. Option B (correct) Assigning individual IAM users allows for precise control over each employee''s permissions and actions, enabling an administrator to easily disable or delete a specific user''s access via the IAM console or CLI when they leave, ensuring their access is immediately revoked without affecting others. Option C (incorrect) Using root account sharing is a critical security vulnerability because the AWS root user has unrestricted access to all services and resources, making it impossible to audit individual actions and creating a massive attack surface if compromised. Option D (incorrect) Creating generic credentials for multiple users prevents individual accountability, makes it difficult to audit specific actions via AWS CloudTrail logs, and does not allow for targeted access revocation for a single departing employee.'
WHERE question_id = '9a31e335-6c59-4991-a83f-07965ff21680';

-- question_id: 9a4cfb70-de67-41a0-bd71-13f74119fec2
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) While AWS CodeCommit provides version control for files, it does not offer a standardized, structured framework specifically designed for AI model documentation and governance, which is critical for compliance. Option B (incorrect) AWS Audit Manager is used to collect and organize evidence from other AWS services for compliance reports, but it does not serve as the primary system for *creating* or *housing* the detailed model documentation itself. Option C (correct) Amazon SageMaker Model Cards are purpose-built to standardize and centralize documentation for AI/ML models, including purpose, data sources, training methodology, and performance metrics, directly addressing the requirements for industry regulations and internal governance. Option D (incorrect) A custom wiki page, while allowing manual entry, lacks the standardized structure, integration with ML workflows, and robust governance features necessary for rigorous compliance and auditability in a financial services environment compared to a dedicated service.'
WHERE question_id = '9a4cfb70-de67-41a0-bd71-13f74119fec2';

-- question_id: 9a4d79ed-65d9-4869-a8a9-9f9b3f4e970a
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While AWS Organizations facilitates consolidated billing, sharing AMIs by individually modifying permissions for each customer account is not a scalable or efficient method for a growing SaaS application. Option B (correct) AWS Control Tower establishes a well-architected multi-account environment with consolidated billing via AWS Organizations, and AWS Resource Access Manager (RAM) provides the most efficient and scalable way to share AMIs across accounts within an organization. Option C (incorrect) Manually configuring cross-account IAM roles for sharing AMIs across potentially many customer accounts is unscalable, complex, and error-prone, making it an impractical solution for a SaaS provider. Option D (incorrect) Using AWS Organizations with Service Control Policies (SCPs) to prevent resource sharing directly contradicts the requirement to share AMIs across all customer accounts.'
WHERE question_id = '9a4d79ed-65d9-4869-a8a9-9f9b3f4e970a';

-- question_id: 9a74ee6c-0d20-42f9-a77a-af5cd287f127
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Availability Zones are isolated locations within an AWS Region designed for high availability and fault tolerance, providing low latency within that specific Region but not globally to end-users. Option B (incorrect) AWS Regions are large geographical areas containing multiple Availability Zones, offering data residency and isolation, but are still too geographically distant from many global end-users for the absolute lowest latency content delivery. Option C (correct) Edge locations are data centers strategically placed around the world, specifically designed to cache content and terminate user connections closer to end-users, leveraging services like Amazon CloudFront to deliver content with the lowest possible latency. Option D (incorrect) Local Zones are extensions of an AWS Region that place compute, storage, and database services closer to large population centers for ultra-low latency application workloads, but they are not as globally distributed or purpose-built for last-mile content caching as Edge locations.'
WHERE question_id = '9a74ee6c-0d20-42f9-a77a-af5cd287f127';

-- question_id: 9ae566b3-a3b6-4df8-ba98-090a8f3f8db8
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Encryption in transit secures data as it moves between locations, such as between a client and an Amazon RDS database, but does not protect the data once it is persistently stored. Option 1 (correct) Encryption at rest protects the actual data files, backups, and underlying storage of a database, like those managed by Amazon RDS or Amazon DynamoDB, when they are not actively being accessed, typically utilizing AWS Key Management Service (KMS). Option 2 (incorrect) Transport layer encryption, a specific form of encryption in transit, secures the communication channel, for instance using TLS/SSL to connect to an Amazon Aurora instance, but does not protect the data stored on disk. Option 3 (incorrect) Application layer encryption protects specific sensitive data fields before they even reach the database, often implemented by the application itself using tools like the AWS Encryption SDK, which is supplementary to, rather than a replacement for, foundational encryption at rest for the entire database storage.'
WHERE question_id = '9ae566b3-a3b6-4df8-ba98-090a8f3f8db8';

-- question_id: 9af8fe62-31f8-4d39-ae83-13de539eafd7
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Polly is a text-to-speech service that turns text into lifelike speech, rather than converting spoken language into written text. Option B (correct) Amazon Transcribe is a fully managed artificial intelligence service that accurately converts speech from audio and video files into text, directly performing the speech-to-text function. Option C (incorrect) Amazon Lex is a service for building conversational interfaces for applications using voice and text, which incorporates speech recognition and natural language understanding but is not solely a speech-to-text transcription service. Option D (incorrect) Amazon Comprehend is a natural language processing (NLP) service that uses machine learning to find insights and relationships in text, such as sentiment analysis and entity recognition, and does not handle speech input.'
WHERE question_id = '9af8fe62-31f8-4d39-ae83-13de539eafd7';

-- question_id: 9b1d59f3-0f29-46e4-b04a-62bfd4bda775
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Knowledge distillation is a technique where a smaller, "student" model is trained to mimic the behavior and outputs of a larger, more complex "teacher" model, enabling more efficient deployment on AWS services like Amazon SageMaker for inference at a lower cost and latency. Option B (incorrect) Knowledge distillation''s primary goal is to produce smaller, more efficient models suitable for resource-constrained environments or faster inference, not to make models larger, which would typically increase computational requirements on AWS. Option C (incorrect) Knowledge distillation focuses on transferring and retaining critical knowledge from a robust teacher model to a student model, rather than removing all knowledge, which would render the model useless and defeat the purpose of optimization for AWS deployments. Option D (incorrect) Random initialization is the process of setting the initial weights of a neural network before training begins and is a foundational step in model training, distinct from knowledge distillation which is an advanced optimization technique for transferring learned knowledge between models for efficient deployment on AWS.'
WHERE question_id = '9b1d59f3-0f29-46e4-b04a-62bfd4bda775';

-- question_id: 9bb98802-9a92-47c4-91b7-f88f65ef883f
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Always overestimating resource needs negates a primary benefit of cloud computing by leading to significant wasted costs in AWS, where you pay for provisioned capacity even if it''s unused. Option B (correct) Provisioning resources based on actual demand is the core principle of "stop guessing capacity," enabling cost optimization and performance by leveraging AWS services like Auto Scaling Groups for EC2 or Lambda''s serverless model to match resources to real-time workload fluctuations. Option C (incorrect) Using fixed capacity only in AWS would reintroduce the problems of traditional on-premises infrastructure, leading to either under-provisioning and poor performance or over-provisioning and unnecessary costs, failing to leverage cloud elasticity. Option D (incorrect) Avoiding scaling altogether in AWS would mean losing the ability to dynamically adjust compute, storage, or database resources, which is a fundamental capability for efficiently handling unpredictable or variable demand without manual intervention.'
WHERE question_id = '9bb98802-9a92-47c4-91b7-f88f65ef883f';

-- question_id: 9bc6b190-ea72-4aa1-ab30-4f76437ca388
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While AWS Lambda functions can be invoked manually via the AWS Console, AWS CLI, or SDKs, this is not the exclusive method, as Lambda is fundamentally an event-driven service. Option B (incorrect) AWS Lambda functions can be triggered by time schedules using services like Amazon EventBridge (formerly CloudWatch Events), but this represents only one category among a vast array of supported event sources. Option C (correct) AWS Lambda is an event-driven compute service designed to execute code in response to events published by over 200 AWS services (e.g., S3 object uploads, DynamoDB table updates, SQS messages) or custom applications invoking it directly via API Gateway or SDKs. Option D (incorrect) AWS Lambda is a serverless service where AWS manages the underlying infrastructure, abstracting away physical servers entirely from the user, meaning it does not respond to direct physical server requests.'
WHERE question_id = '9bc6b190-ea72-4aa1-ab30-4f76437ca388';

-- question_id: 9c656482-352f-40fe-939a-50607963de94
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudWatch is a monitoring and observability service that collects metrics, logs, and events, but it does not generate actionable recommendations for right-sizing resources itself. Option B (incorrect) AWS Trusted Advisor offers cost optimization checks, including identifying low-utilization EC2 instances, but it provides general advice rather than the detailed, machine-learning-driven right-sizing recommendations for optimal instance types. Option C (correct) AWS Compute Optimizer specifically provides actionable recommendations for optimizing AWS resources, including right-sizing underutilized EC2 instances, by analyzing historical utilization data using machine learning. Option D (incorrect) AWS Config records and evaluates the configurations of AWS resources, tracking changes over time for auditing and compliance, but it does not provide cost optimization or right-sizing recommendations.'
WHERE question_id = '9c656482-352f-40fe-939a-50607963de94';

-- question_id: 9c6681ef-6bf7-45e3-bc6d-c158e690b7ba
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Elasticity refers to the ability to automatically acquire and release compute resources to match changes in demand, ensuring cost-efficiency and performance under varying loads rather than specifically ensuring operation despite component failure. Option B (incorrect) Scalability is the ability of a system to handle a growing amount of work by adding resources, enabling it to accommodate increased load or data volumes, but it does not inherently guarantee continued operation if a specific component fails without other design considerations. Option C (correct) High availability ensures that an application or service remains accessible and operational even if underlying components or infrastructure fail, often achieved through redundancy, fault tolerance across multiple Availability Zones, and automatic failover mechanisms like those used by Multi-AZ RDS deployments or Elastic Load Balancers with Auto Scaling. Option D (incorrect) Agility in AWS refers to the ability to rapidly provision and de-provision resources, experiment with new ideas, and quickly innovate, focusing on speed and responsiveness to change rather than the inherent resilience of services to component failures.'
WHERE question_id = '9c6681ef-6bf7-45e3-bc6d-c158e690b7ba';

-- question_id: 9cea5979-cbab-471d-b20a-104bb8314b23
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Supervised learning involves training a model on a labeled dataset, where the model learns to map input features to known output labels, often using services like Amazon SageMaker for classification or regression tasks. Option B (incorrect) Unsupervised learning focuses on finding hidden patterns or structures in unlabeled data, such as clustering or dimensionality reduction, with AWS services like Amazon SageMaker K-Means algorithm being a common tool. Option C (correct) Reinforcement learning is precisely the type of learning where an agent learns through interaction with an environment, performing actions and receiving rewards or penalties to optimize behavior, as exemplified by AWS DeepRacer, where the car agent learns to navigate a track through trial and error. Option D (incorrect) Transfer learning involves taking a pre-trained model and fine-tuning it for a new, related task with a smaller dataset, leveraging existing knowledge rather than learning from direct environmental interaction from scratch, often facilitated by pre-trained models available via Amazon SageMaker JumpStart.'
WHERE question_id = '9cea5979-cbab-471d-b20a-104bb8314b23';

-- question_id: 9d207f41-9f20-42a6-9ffc-955af13bbe99
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deploying all resources in a single Availability Zone makes the entire application vulnerable to an outage in that specific zone, directly contradicting the goal of high availability. Option B (incorrect) Storing all data on a single EBS volume creates a single point of failure for data, meaning an issue with that volume or its Availability Zone could lead to data loss or unavailability, compromising both durability and availability. Option C (correct) Distributing resources and data across multiple Availability Zones is a core AWS best practice that ensures the application can continue operating even if one Availability Zone experiences an outage, providing both high availability and increased data durability. Option D (incorrect) Relying solely on on-premises backups does not contribute to the real-time high availability or data durability of an application running on AWS infrastructure, as it only offers a recovery mechanism for disaster recovery rather than preventing downtime due to AWS infrastructure failures.'
WHERE question_id = '9d207f41-9f20-42a6-9ffc-955af13bbe99';

-- question_id: 9e6dfb3f-c70d-4b42-91b9-d255a7b75625
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon EC2 provides virtual servers for running applications, but it is a foundational compute service, not a managed container orchestration service itself. Option B (correct) Amazon Elastic Container Service (ECS) is a fully managed container orchestration service that allows you to run, stop, and manage Docker containers on a cluster of EC2 instances or using AWS Fargate. Option C (incorrect) AWS Lambda is a serverless compute service for running functions in response to events and is not designed as a container orchestration platform for managing continuous containerized applications. Option D (incorrect) Amazon S3 is an object storage service for data storage and retrieval, and it has no functionality related to container orchestration.'
WHERE question_id = '9e6dfb3f-c70d-4b42-91b9-d255a7b75625';

-- question_id: 9f06e840-0f7d-4751-b081-b24349d558e7
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Data storage is primarily handled by services like Amazon S3, Amazon EBS, or Amazon EFS, which are used to store the raw datasets or model artifacts, not by SageMaker Experiments itself. Option B (correct) Amazon SageMaker Experiments is designed to organize, track, compare, and evaluate machine learning model training runs, including parameters, metrics, and lineage, to determine the most effective models. Option C (incorrect) Model deployment in SageMaker is performed using SageMaker Endpoints for real-time inference or SageMaker Batch Transform for offline predictions, which are distinct functionalities from SageMaker Experiments. Option D (incorrect) Data labeling is a specific task handled by Amazon SageMaker Ground Truth, a service that helps build high-quality training datasets through human annotation, which is separate from tracking ML experiments.'
WHERE question_id = '9f06e840-0f7d-4751-b081-b24349d558e7';

-- question_id: 9f1e258e-b7c5-487b-9014-9046b8d0940f
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The AWS Support Center is primarily for managing support cases, accessing technical support resources, and monitoring service health, not for direct download of compliance reports and certifications. Option B (correct) AWS Artifact is the dedicated service that provides on-demand access to AWS security and compliance reports, such as SOC reports, PCI reports, and ISO certifications, to help customers with their audit and compliance needs. Option C (incorrect) AWS Documentation provides technical information, user guides, and API references for AWS services, but it does not host the actual auditable compliance reports or certifications that prove AWS adherence to regulatory standards. Option D (incorrect) AWS Marketplace is an online catalog where customers can discover, purchase, and deploy third-party software and services, and it is not a repository for AWS''s internal compliance documentation.'
WHERE question_id = '9f1e258e-b7c5-487b-9014-9046b8d0940f';

-- question_id: 9fcd3a38-88be-4ada-9c83-c066f38405d7
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Hybrid search leverages both traditional keyword matching (like that found in Amazon OpenSearch Service for exact term hits or specific identifiers) and vector similarity search (often powered by Amazon Bedrock-integrated embedding models or Amazon Kendra''s semantic capabilities) to provide a more comprehensive and contextually relevant set of results to the Large Language Model, improving the overall accuracy and relevance of the RAG system''s output. Option B (incorrect) This describes a purely keyword-based search approach, such as might be used with Amazon OpenSearch Service without vector search extensions, which misses the nuanced understanding of context and meaning that semantic search provides and is therefore not characteristic of hybrid search. Option C (incorrect) This describes a purely semantic search approach, often implemented using vector databases like those found in Amazon OpenSearch Service with k-NN or Amazon Aurora PostgreSQL with pgvector, which can struggle with exact term matching or specific identifier retrieval that keyword search excels at, thus not representing the combined power of hybrid search. Option D (incorrect) While combining multiple search methods might introduce some overhead, optimized hybrid search implementations, particularly those leveraging services like Amazon OpenSearch Service''s unified query APIs or Amazon Kendra''s intelligent ranking, are designed to enhance retrieval quality and relevance, which is often prioritized over marginal increases in latency in RAG systems where accuracy is paramount, and performance is managed through scalable AWS infrastructure.'
WHERE question_id = '9fcd3a38-88be-4ada-9c83-c066f38405d7';

-- question_id: 9fdc16be-0eb3-4f2f-92e0-d3d5c6a118a2
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Encryption at rest protects data when it is stored on persistent storage devices like S3 buckets, EBS volumes, or RDS databases, not while it''s moving across a network. Option B (correct) Encryption in transit, often implemented using TLS/SSL, protects data as it moves between clients and servers, or between AWS services, ensuring confidentiality and integrity over public or private networks. Option C (incorrect) Database encryption primarily refers to encrypting the data stored within a database (data at rest) using features like Amazon RDS encryption or Amazon DynamoDB encryption, although secure connections to the database use TLS. Option D (incorrect) File system encryption, such as that provided by Amazon EFS encryption or operating system-level encryption, protects data stored on a file system (data at rest) on disk, not data actively being transmitted over a network.'
WHERE question_id = '9fdc16be-0eb3-4f2f-92e0-d3d5c6a118a2';

-- question_id: a018a405-5e97-4199-b01a-45634820a54c
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Secrets Manager is designed to securely store and manage secrets such as database credentials, API keys, and other sensitive data, not to provision or deploy SSL/TLS certificates for web traffic to services. Option B (correct) AWS Certificate Manager (ACM) is precisely designed to provision, manage, and deploy SSL/TLS certificates for securing web traffic to integrated AWS services like Elastic Load Balancers, CloudFront, and API Gateway. Option C (incorrect) AWS Key Management Service (KMS) is used to create and manage cryptographic keys and control their use across various AWS services, but it does not provision or manage SSL/TLS certificates themselves. Option D (incorrect) AWS Config provides a detailed inventory of your AWS resources, records configuration changes, and helps assess and audit configurations, which is unrelated to the provisioning or deployment of SSL/TLS certificates.'
WHERE question_id = 'a018a405-5e97-4199-b01a-45634820a54c';

-- question_id: a0205ea8-ca54-4368-a8cb-621ceb8bbd68
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Route 53 is a highly available and scalable cloud DNS web service and does not provide database hosting; AWS services like Amazon RDS, Amazon DynamoDB, or Amazon Aurora are used for database hosting. Option B (correct) Route 53 offers advanced features such as configuring health checks for AWS resources and external endpoints, which enables DNS failover to redirect traffic away from unhealthy resources, going beyond simple name resolution. Option C (incorrect) Route 53''s primary function is DNS management and it does not offer file storage capabilities; services like Amazon S3, Amazon EFS, or Amazon FSx are designed for file storage. Option D (incorrect) While Route 53 supports various routing policies that can contribute to a load balancing strategy (e.g., weighted routing), it performs DNS resolution and traffic routing, not the direct computation or distribution of load that an Elastic Load Balancer (ELB) would handle.'
WHERE question_id = 'a0205ea8-ca54-4368-a8cb-621ceb8bbd68';

-- question_id: a0324319-bcd4-47ce-88cf-ee0afc7147ea
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) SageMaker Feature Store is specifically designed to centralize the storage, management, and sharing of curated machine learning features, ensuring consistency between training and inference and promoting feature reusability across ML projects. Option B (incorrect) Model storage is primarily handled by Amazon S3 for storing model artifacts and SageMaker Model Registry for cataloging and versioning models, not by SageMaker Feature Store. Option C (incorrect) While SageMaker Feature Store does support operations for managing the lifecycle of feature data, including deletion, its core purpose is not data deletion but rather the persistent storage, retrieval, and serving of features for machine learning. Option D (incorrect) A code repository, used for storing and versioning source code, is a function provided by services like AWS CodeCommit, not by SageMaker Feature Store which focuses on ML feature data.'
WHERE question_id = 'a0324319-bcd4-47ce-88cf-ee0afc7147ea';

-- question_id: a12eb792-137b-4dcf-afa0-2bc0d0f0d498
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) This strategy utilizes the cost benefits of Reserved Instances for the predictable, continuous baseline workload and leverages the significant cost savings of Spot Instances for the flexible, interruptible, and unpredictable burst capacity, effectively minimizing total compute costs. Option B (incorrect) While Reserved Instances are optimal for the baseline, using On-Demand instances for burst capacity is more expensive than using Spot Instances, failing to fully minimize total compute costs for the unpredictable, short-duration bursts. Option C (incorrect) Purchasing 200 Reserved Instances would lead to significant underutilization and wasted costs during non-burst periods when only 100 instances are needed, as Reserved Instances are best for consistent, predictable usage. Option D (incorrect) Savings Plans covering 150 instances would mean committing to paying for capacity that may not be consistently utilized beyond the baseline, especially for the unpredictable and short-lived burst component, making it less cost-effective than using Spot Instances for those bursts.'
WHERE question_id = 'a12eb792-137b-4dcf-afa0-2bc0d0f0d498';

-- question_id: a1370b09-cf7a-40e1-910e-85246b26a381
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon Forecast is a fully managed machine learning service specifically designed for time-series forecasting, making it the ideal choice for accurate demand forecasting in supply chains using historical data. Option B (incorrect) Amazon Rekognition is a computer vision service for image and video analysis, such as object detection, facial recognition, and text in images, and does not provide demand forecasting capabilities. Option C (incorrect) Amazon Transcribe is an automatic speech recognition service that converts audio into text, which is unrelated to the task of predicting future demand for a supply chain. Option D (incorrect) Amazon Polly is a text-to-speech service that turns text into lifelike speech, serving a completely different purpose from analytics or predictive modeling for demand.'
WHERE question_id = 'a1370b09-cf7a-40e1-910e-85246b26a381';

-- question_id: a1564319-21f8-4e0a-b026-4bad6af49ebc
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Using structured prompt templates defines clear instructions, output formats, and often includes few-shot examples, a best practice for foundation models on Amazon Bedrock, which significantly reduces variability and ensures consistent contract analysis. Option B (incorrect) Randomizing prompts introduces variability in the input, leading to inconsistent and unpredictable outputs from the large language model, directly counteracting the goal of consistent analysis. Option C (incorrect) Avoiding any examples (zero-shot prompting) provides less specific guidance to the LLM, potentially resulting in less predictable and less consistent contract analysis compared to providing few-shot examples within the prompt. Option D (incorrect) Using maximum creativity settings (e.g., high temperature) on an LLM encourages diverse and varied outputs, which is antithetical to the need for consistent, repeatable, and predictable contract analysis required by a legal firm.'
WHERE question_id = 'a1564319-21f8-4e0a-b026-4bad6af49ebc';

-- question_id: a15be668-4729-4054-b2c3-104275f0a032
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) One-time deployment fails to address the ongoing need for model performance checks and bias detection, which AWS SageMaker Model Monitor facilitates continuously rather than just at a single deployment event. Option B (correct) Continuous monitoring and review cadence is a fundamental practice in AI governance, directly supported by AWS SageMaker Model Monitor''s ability to track data quality, model quality, and bias metrics over time for responsible AI. Option C (incorrect) Ignoring model drift leads to degraded performance and potentially biased outcomes, directly contradicting the purpose of AWS SageMaker Model Monitor, which is designed to detect such drifts. Option D (incorrect) Never updating models ensures they become outdated and ineffective as data patterns evolve, undermining the continuous improvement philosophy inherent in AWS MLOps best practices for model retraining and redeployment.'
WHERE question_id = 'a15be668-4729-4054-b2c3-104275f0a032';

-- question_id: a1688e3c-6912-4aa4-90e0-8e3ba8722074
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Storing user credentials is handled by services like AWS Identity and Access Management (IAM), AWS Secrets Manager, or Amazon Cognito, not by Amazon Bedrock Knowledge Bases, which focus on enterprise data retrieval for AI models. Option B (correct) Amazon Bedrock Knowledge Bases are specifically designed to implement Retrieval Augmented Generation (RAG) by allowing foundation models to securely access and retrieve information from private data sources like S3 buckets or OpenSearch Serverless collections to improve response accuracy. Option C (incorrect) Compressing model weights is a machine learning optimization technique related to model training and deployment to reduce model size and inference latency, which is separate from the function of Bedrock Knowledge Bases. Option D (incorrect) Monitoring API usage is typically handled by services such as Amazon CloudWatch, AWS CloudTrail, or AWS Cost Explorer, which track and log API calls and metrics, rather than being a function of Bedrock Knowledge Bases.'
WHERE question_id = 'a1688e3c-6912-4aa4-90e0-8e3ba8722074';

-- question_id: a1b112af-7c80-42a7-b692-8ba8934d43bc
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudFormation is an infrastructure as code service used to provision and manage AWS resources, not to provide compliance documentation. Option B (correct) AWS Artifact is the central repository for on-demand access to AWS security and compliance reports and select online agreements, such as SOC reports or HIPAA BAAs. Option C (incorrect) AWS Systems Manager is a suite of tools for operational management of AWS resources, helping to maintain compliance through automation but not providing compliance documentation. Option D (incorrect) AWS Organizations helps you centrally manage and govern multiple AWS accounts, including enforcing compliance policies, but it does not provide compliance documentation or agreements.'
WHERE question_id = 'a1b112af-7c80-42a7-b692-8ba8934d43bc';

-- question_id: a273e25a-1de3-489f-8989-a484219c1235
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) This option correctly places internet-facing web servers in public subnets with an Internet Gateway to accept HTTPS traffic from users and isolates database servers in private subnets, ensuring they are not directly accessible from the internet, while security groups enforce secure communication between the tiers following the principle of least privilege. Option B (incorrect) Deploying all resources, including the database, in public subnets contradicts the requirement for the database to be completely isolated from the internet, as public subnets are directly routed to the Internet Gateway, even if security groups provide some control. Option C (incorrect) Using private subnets for all resources means the web tier would not be able to accept direct HTTPS traffic from public internet users without an internet-facing load balancer or a similar proxy, and AWS PrivateLink is primarily for private connectivity to AWS services or between VPCs, not for direct public user access to an application. Option D (incorrect) Placing web servers and databases in the same subnet significantly reduces network segmentation and increases the blast radius in case of a breach, which is a poor security practice, even with Network ACLs, as separating tiers into distinct subnets is fundamental for security best practices.'
WHERE question_id = 'a273e25a-1de3-489f-8989-a484219c1235';

-- question_id: a2ddde5b-f3d2-4e6d-8b5c-e7adad01ca83
-- answer_correct: True | verified_indices: [0, 2, 3] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS CloudFormation is AWS''s native Infrastructure as Code (IaC) service that allows defining, provisioning, and updating AWS resources in a declarative template, enabling parameterized creation of isolated environments and automated lifecycle management for cost efficiency. Option B (incorrect) Manual EC2 instance creation is a highly inefficient and error-prone approach that prevents automated provisioning and deprovisioning, directly contradicting the requirements for automation and cost efficiency, regardless of tagging. Option C (correct) The AWS Cloud Development Kit (CDK) is an IaC framework that compiles into CloudFormation templates, providing the same benefits of defining infrastructure programmatically and enabling automated deployment and deletion of isolated environments for feature testing and cost efficiency. Option D (correct) Terraform is a widely used open-source IaC tool that can provision and manage AWS resources, and with remote state management, it enables automated, consistent, and collaborative provisioning and deprovisioning of isolated environments through CI/CD pipelines, aligning with all requirements.'
WHERE question_id = 'a2ddde5b-f3d2-4e6d-8b5c-e7adad01ca83';

-- question_id: a345a944-bdaa-426d-9bc2-cd617aa2b33c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3-managed keys (SSE-S3) provide encryption at rest, but AWS fully manages the encryption keys, offering no customer control over the key lifecycle or immediate key deletion capability by the customer. Option B (incorrect) AWS Key Management Service (KMS) with customer-managed keys (CMKs) offers significant control over key policies and usage, but the underlying key material deletion is subject to a mandatory 7-30 day waiting period, not immediate, and the hardware itself is still managed by AWS. Option C (correct) AWS CloudHSM provides dedicated, FIPS 140-2 Level 3 validated hardware security modules where customers have exclusive control over the HSMs and key material, enabling full control over the key lifecycle and immediate key deletion. Option D (incorrect) AWS Certificate Manager (ACM) is designed for managing SSL/TLS certificates used for encryption in transit, not for managing encryption keys for data at rest.'
WHERE question_id = 'a345a944-bdaa-426d-9bc2-cd617aa2b33c';

-- question_id: a3a884b8-3687-4456-8271-afd6e985ee55
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) BERTScore is a metric for evaluating natural language generation, not server performance, which is typically monitored using services like Amazon CloudWatch for CPU utilization, network I/O, and latency on EC2 instances or other compute services. Option B (correct) BERTScore leverages pre-trained contextual embeddings from models like BERT to compute a similarity score between a candidate text and a reference text, focusing on the meaning rather than just exact word overlap, which is crucial for evaluating tasks like summarization or translation within AWS AI/ML services like Amazon SageMaker or Amazon Comprehend. Option C (incorrect) BERTScore is a natural language processing metric and has no relevance to image resolution, which is a property of digital images typically processed and analyzed using computer vision services like Amazon Rekognition or custom models on SageMaker. Option D (incorrect) BERTScore does not measure database query speed, which is a performance metric for databases like Amazon RDS or Amazon DynamoDB, often monitored through CloudWatch metrics for latency and throughput.'
WHERE question_id = 'a3a884b8-3687-4456-8271-afd6e985ee55';

-- question_id: a3b1e96e-f416-476b-9ccb-8d5a241baa7a
-- answer_correct: False | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{3}'::integer[],
    explanation = 'Option A (incorrect) AWS CloudTrail records API activity and events for governance, compliance, operational auditing, and risk auditing, but it does not aggregate, normalize, or prioritize security findings from services like Amazon GuardDuty, Amazon Inspector, or Amazon Macie into a central dashboard. Option B (incorrect) AWS Config continuously monitors and records your AWS resource configurations and allows you to automate the evaluation of recorded configurations against desired baselines, primarily focused on compliance and configuration drift, not aggregating security threat findings from dedicated security services. Option C (incorrect) Amazon Detective helps security teams investigate potential security issues or anomalous activities by automatically collecting and analyzing log data, providing a unified view of resource behaviors, but it is an investigative tool rather than a central aggregation and prioritization service for security findings across multiple AWS security services. Option D (correct) AWS Security Hub provides a comprehensive view of your security posture across multiple AWS accounts, aggregating, organizing, and prioritizing security findings from services like Amazon GuardDuty, Amazon Inspector, Amazon Macie, and many others, as well as running automated compliance checks against security industry standards.'
WHERE question_id = 'a3b1e96e-f416-476b-9ccb-8d5a241baa7a';

-- question_id: a42295a4-a327-447b-b6b2-97d60d2cdbde
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While Amazon S3 is an excellent object storage service for direct HTTP/HTTPS access and global distribution, many Content Management Systems require a POSIX-compliant shared file system for internal file management across multiple instances, which S3 does not natively provide. Option B (correct) Amazon EFS provides a shared, highly available, and durable POSIX-compliant file system that multiple EC2 instances can concurrently mount, allowing the CMS to manage files with traditional file system semantics while the EC2 instances serve them via HTTP/HTTPS to a global audience. Option C (incorrect) Amazon EBS is block storage attached to a single EC2 instance (or with limited multi-attach), which lacks the inherent shared file system capabilities needed for a highly available, multi-instance CMS and is not optimized for serving files directly to a global audience. Option D (incorrect) Amazon S3 Glacier Deep Archive is an archiving service designed for rarely accessed, long-term data retention with retrieval times measured in hours, making it unsuitable for "frequently accessed" files.'
WHERE question_id = 'a42295a4-a327-447b-b6b2-97d60d2cdbde';

-- question_id: a42bd2db-e797-428e-bbcb-5db5b621d585
-- answer_correct: True | verified_indices: [1, 4] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Glue Python Shell jobs are single-threaded and suitable for lightweight orchestration tasks, not for efficiently processing 100,000 records daily by making individual API calls to Amazon Comprehend for each record, which would be extremely slow and inefficient. Option B (correct) AWS Glue ETL jobs leverage Apache Spark, enabling parallel processing of large datasets; using the AWS SDK within Spark allows for efficient batching of multiple text documents into a single Amazon Comprehend BatchDetectSentiment API call, which is highly performant and cost-effective for the given volume. Option C (incorrect) Invoking an Amazon SageMaker endpoint via a Lambda function for 100,000 records daily would introduce significant overhead, latency, and cost, as Lambda functions are not ideal for processing large batch datasets record-by-record or in many small batches during a core ETL transformation. Option D (incorrect) AWS Glue DataBrew does not currently offer a built-in, native transformation for sentiment analysis using Amazon Comprehend or other services as part of its standard recipe transformations, focusing more on data cleaning and preparation. Option E (correct) AWS Glue ETL jobs run on Apache Spark, which fully supports deploying and executing custom Python or Scala code, allowing for the integration of open-source sentiment analysis libraries directly within the distributed Spark environment for efficient, in-pipeline processing of the data.'
WHERE question_id = 'a42bd2db-e797-428e-bbcb-5db5b621d585';

-- question_id: a447a59f-06a1-4a10-9979-6ce253f14ee6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) For very large language models, there is typically an abundance of text data available for collection and storage, easily managed on AWS with services like Amazon S3 which can handle petabytes of data. Option B (correct) Training very large language models requires immense computational power, involving thousands of high-performance GPUs, vast memory, and high-bandwidth networking, typically provisioned using AWS EC2 P-instances (e.g., P4d, P5) with NVIDIA GPUs and distributed training solutions like AWS ParallelCluster. Option C (incorrect) Large language models are built on complex transformer architectures with billions or trillions of parameters, demanding sophisticated distributed training frameworks rather than simple designs. Option D (incorrect) The primary challenge of training LLMs is not their inherent low accuracy, but rather the monumental resources required to achieve and optimize their often exceptionally high performance and accuracy, which can be fine-tuned using AWS SageMaker.'
WHERE question_id = 'a447a59f-06a1-4a10-9979-6ce253f14ee6';

-- question_id: a455b8bb-8e55-43a2-be06-75363432567a
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The Cost Optimization pillar focuses on avoiding unnecessary costs and maximizing business value through strategies like Rightsizing EC2 instances or utilizing AWS Savings Plans, rather than minimizing environmental impact. Option B (incorrect) The Performance Efficiency pillar focuses on using computing resources efficiently to meet system requirements and adapt to changing demand, for instance, by leveraging Amazon SQS for asynchronous processing or AWS Auto Scaling, not primarily environmental impact. Option C (correct) The Sustainability pillar specifically focuses on minimizing the environmental impacts of running cloud workloads, encompassing resource utilization efficiency, choosing environmentally friendly regions, and designing for a reduced carbon footprint. Option D (incorrect) The Reliability pillar focuses on ensuring a workload performs its intended function correctly and consistently, which includes designing for fault tolerance using multiple Availability Zones or implementing disaster recovery strategies, not primarily environmental impact.'
WHERE question_id = 'a455b8bb-8e55-43a2-be06-75363432567a';

-- question_id: a4caaf8f-4df6-4c86-af5e-e958b464f1d4
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Unsupervised anomaly detection on sensor data is the best approach because vehicle anomalies are often rare, undefined, or lack sufficient labeled historical data for supervised learning, making unsupervised algorithms (e.g., Isolation Forest, Random Cut Forest on Amazon SageMaker or Amazon Lookout for Equipment) ideal for learning normal operational patterns from continuous sensor data (e.g., collected via AWS IoT Core and streamed via Amazon Kinesis) and identifying deviations from those patterns. Option B (incorrect) Manual inspection only is not a scalable or efficient solution for a transportation company with many vehicles, as it is highly prone to human error, cannot process large volumes of real-time sensor data, and lacks the automation and precision offered by AWS machine learning services. Option C (incorrect) Ignoring anomalies is a dangerous and detrimental approach that can lead to vehicle breakdowns, safety hazards, increased maintenance costs, and operational downtime, directly contradicting the goal of proactive anomaly detection and fleet management that AWS solutions can enable. Option D (incorrect) Random sampling is not an effective anomaly detection strategy because anomalies are often infrequent and critical events that could easily be missed by mere random checks, failing to provide the comprehensive and continuous monitoring necessary for reliable anomaly detection that can be achieved with AWS IoT and ML services.'
WHERE question_id = 'a4caaf8f-4df6-4c86-af5e-e958b464f1d4';

-- question_id: a4d3b16d-25ee-431e-a4ad-b8fc60e21d7a
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon Textract is the most appropriate service because it is specifically designed for automatically extracting text, handwriting, and data from scanned documents and PDFs, making it ideal for extracting structured information like meter readings. Option B (incorrect) Amazon Comprehend is a natural language processing (NLP) service used for extracting insights and relationships from unstructured text, such as sentiment analysis or entity recognition, not for extracting data from scanned images. Option C (incorrect) Amazon Translate is a neural machine translation service that translates text between languages, which is irrelevant to extracting meter readings from documents. Option D (incorrect) Amazon Personalize is a machine learning service that helps developers add personalized recommendations to applications, which has no function in document processing or data extraction.'
WHERE question_id = 'a4d3b16d-25ee-431e-a4ad-b8fc60e21d7a';

-- question_id: a4fb21f3-5760-4018-8d22-a53b2e6581c3
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS KMS customer-managed keys have a mandatory waiting period of 7 to 30 days before deletion, failing the immediate key deletion compliance requirement. Option B (incorrect) While client-side encryption using the AWS Encryption SDK provides strong encryption, storing keys in AWS Secrets Manager does not offer the same FIPS 140-2 Level 3 hardware security and immediate key destruction guarantees as a dedicated HSM for the key material itself. Option C (correct) AWS CloudHSM provides dedicated FIPS 140-2 Level 3 validated hardware security modules, allowing for immediate key deletion and comprehensive auditing of all cryptographic operations, fulfilling all security and compliance requirements. Option D (incorrect) Amazon S3 default encryption with AWS managed keys does not allow for customer auditing of key usage or immediate key deletion, as AWS fully manages the encryption keys.'
WHERE question_id = 'a4fb21f3-5760-4018-8d22-a53b2e6581c3';

-- question_id: a5f2e086-b328-4767-bddb-6e1e11c96f18
-- answer_correct: True | verified_indices: [1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) M-series instances, while versatile and offering a balanced set of resources, are not specifically optimized for the highest network performance compared to other specialized families. Option B (correct) C-series instances are designed for compute-intensive workloads and often feature enhanced networking capabilities like Elastic Network Adapter (ENA) and higher packet per second (PPS) performance, making them ideal for applications requiring high network throughput. Option C (incorrect) I-series instances are optimized for applications needing high sequential read/write access to large datasets on local NVMe SSDs, such as NoSQL databases, and are not primarily focused on high network performance. Option D (incorrect) P-series instances are designed for accelerated computing using GPUs for tasks like machine learning and scientific simulations, and while they can have good network capabilities, high network performance is not their primary design goal or distinguishing feature.'
WHERE question_id = 'a5f2e086-b328-4767-bddb-6e1e11c96f18';

-- question_id: a60ccd07-5ab3-4438-835b-9a3c966985fa
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon S3 Glacier is designed for long-term archival with infrequent access, and its retrieval times typically range from minutes to hours, which is not considered low latency. Option B (correct) Amazon S3 Standard provides low-latency access (milliseconds) to objects and is specifically designed for frequently accessed data, making it the optimal choice for rapid retrieval among the S3 storage classes. Option C (incorrect) Amazon EFS offers low-latency file system access suitable for shared workloads across EC2 instances, but its latency characteristics for general data access are typically higher than S3 Standard for individual object retrieval due to the overhead of a distributed file system. Option D (incorrect) Amazon S3 Standard-IA is designed for infrequently accessed data that requires rapid access when needed, but it has slightly higher latency and a different pricing model compared to S3 Standard, thus not providing the absolute lowest latency for frequently accessed data.'
WHERE question_id = 'a60ccd07-5ab3-4438-835b-9a3c966985fa';

-- question_id: a655f5af-a8fd-499d-854a-62a44a9db819
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Route 53 health checks monitor the health of endpoints and resources, not the internal performance or operational metrics of databases themselves, which are typically monitored by services like Amazon CloudWatch, RDS Enhanced Monitoring, or Performance Insights. Option B (correct) Route 53 health checks continuously monitor the health of specified endpoints or other AWS resources, enabling DNS failover by automatically redirecting user traffic to healthy alternative resources when an unhealthy endpoint is detected. Option C (incorrect) Route 53 health checks identify if an endpoint is unhealthy, but they do not provide the detailed logs, traces, or metrics required for debugging application code or logic, which are functionalities offered by services like AWS X-Ray, CloudWatch Logs, or CloudWatch Application Insights. Option D (incorrect) Route 53 health checks are a feature designed for improving application availability and reliability through intelligent traffic routing, not a primary service or strategy for directly optimizing AWS infrastructure costs.'
WHERE question_id = 'a655f5af-a8fd-499d-854a-62a44a9db819';

-- question_id: a65c93b7-5e41-453c-b842-e4dfbb11d03d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) CloudFormation is an infrastructure provisioning tool, not directly impacting application runtime performance; application performance depends on the underlying AWS resources configured (e.g., EC2 instance types, database optimization, network design) which CloudFormation can deploy, but not inherently make faster. Option B (correct) CloudFormation templates define infrastructure as code, enabling automated, idempotent provisioning of resources to ensure environments are identical and deployments are consistent and repeatable across development, test, and production stages. Option C (incorrect) While CloudFormation can help manage resources efficiently by preventing resource sprawl or "drift," it does not automatically lower costs; cost optimization requires deliberate design choices and resource selection (e.g., instance types, auto-scaling policies), which CloudFormation can deploy but does not make these cost-saving decisions automatically. Option D (incorrect) CloudFormation provides a secure method for deploying resources but does not inherently make the deployed infrastructure more secure by default; security depends on the template''s design and configuration of services like IAM policies, security groups, and encryption (KMS) by the user, adhering to the shared responsibility model.'
WHERE question_id = 'a65c93b7-5e41-453c-b842-e4dfbb11d03d';

-- question_id: a6af522b-fede-44c4-9a28-8178bfa91817
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) CloudFront is a Content Delivery Network primarily designed for edge caching and distributing web content to global end-users, not for accelerating high-throughput, iterative backend reads of a massive dataset by ML training jobs running within a private network. Option B (correct) FSx for Lustre is a high-performance, POSIX-compliant file system specifically optimized for HPC and machine learning workloads, providing extremely low latency and hundreds of GB/s of throughput for iterative data access, and its S3 integration efficiently ingests and caches the 200TB dataset for fast processing. Option C (incorrect) EBS volumes, while offering high performance for individual EC2 instances, would be highly complex and costly to provision, manage, and coordinate access across multiple volumes and instances for a 200TB shared dataset, and the initial data transfer from S3 would be slow. Option D (incorrect) S3 Select allows querying and retrieving only a subset of data from S3 objects, which reduces data transfer for specific queries but is not designed for accelerating iterative full-dataset reads required for comprehensive machine learning model training.'
WHERE question_id = 'a6af522b-fede-44c4-9a28-8178bfa91817';

-- question_id: a76d000a-e223-4b06-9530-01d4d5b182a2
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Resource Record Sets are configurations within a hosted zone that dictate how DNS names resolve, they do not provide a mechanism for logging or analyzing DNS queries themselves. Option B (incorrect) Route 53 Health Checks monitor the availability and health of your application endpoints or other resources, not the flow or content of DNS queries originating from your VPC. Option C (correct) Query logging for Route 53 Resolver is specifically designed to capture and log all DNS queries originating from within a VPC, sending them to destinations like Amazon S3 or CloudWatch Logs for security analysis. Option D (incorrect) Alias Records are a specific type of resource record used for mapping DNS names to AWS resources and do not provide any functionality for logging or monitoring DNS query traffic.'
WHERE question_id = 'a76d000a-e223-4b06-9530-01d4d5b182a2';

-- question_id: a8805561-a736-42be-9c21-dc006b81b700
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Data versioning allows tracking dataset changes and ensures reproducibility of machine learning models and experiments, aligning with MLOps best practices on AWS through services like Amazon S3 Versioning or integrated into AWS SageMaker Pipelines. Option B (incorrect) While storing multiple data versions can consume more storage, the purpose of data versioning is not to intentionally increase storage but rather to preserve historical states, as seen with Amazon S3 Versioning protecting against accidental overwrites or deletions. Option C (incorrect) Data versioning is a data management practice that does not inherently slow down the training process; instead, it ensures the integrity and traceability of data used for training, impacting data preparation and governance rather than compute speed on AWS SageMaker. Option D (incorrect) Data versioning''s purpose is to preserve and manage historical states of data, not to remove all data; for example, Amazon S3 Versioning retains previous object versions, safeguarding against data loss and enabling point-in-time recovery.'
WHERE question_id = 'a8805561-a736-42be-9c21-dc006b81b700';

-- question_id: a899bdc8-d2e1-449f-91bf-410f97c22847
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) because Aurora Global Database is purpose-built for multi-region disaster recovery, offering automated failover to a secondary region with an RTO often under one minute and an RPO typically in seconds, ensuring strong data consistency. Option B (incorrect) because RDS Multi-AZ provides high availability within a single region, and cross-region manual snapshots with restore procedures do not offer automated failover and result in a significantly higher recovery time objective (RTO) and potential data loss (RPO). Option C (incorrect) because while DynamoDB Global Tables provide multi-region replication and low recovery time, they employ eventually consistent multi-master replication, which does not guarantee immediate data consistency across regions as required. Option D (incorrect) because S3 Cross-Region Replication is for object storage and does not inherently provide automated failover capabilities or transactional consistency for application workloads across regions; Lambda-triggered automation would be complex and custom, not a standard solution for database-level failover.'
WHERE question_id = 'a899bdc8-d2e1-449f-91bf-410f97c22847';

-- question_id: a9e5d904-54cc-43ef-a646-374adbd97f60
-- answer_correct: True | verified_indices: [2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While AWS Backup provides automated backups, the RTO for full restoration and provisioning of new infrastructure from scratch in a different region typically takes multiple hours to days, which does not meet the "less than an hour" RTO requirement. Option B (incorrect) Pilot Light strategy involves maintaining a minimal but functional set of core resources in the DR region, but the process of scaling up and provisioning the full application stack takes several hours, exceeding the "less than an hour" RTO. Option C (correct) Warm Standby maintains a scaled-down but fully functional version of the application in the DR region, allowing for continuous data replication (e.g., using RDS cross-region read replicas or DynamoDB Global Tables) to achieve minutes RPO and enabling a rapid scale-up and Route 53 traffic redirection to meet an RTO of less than an hour. Option D (incorrect) While Multi-site Active/Active strategy provides near-zero RPO and RTO, it is significantly more complex and expensive than Warm Standby, and Warm Standby can already satisfy the "minutes" RPO and "less than an hour" RTO requirements more cost-effectively, making Active/Active an over-engineered solution for the specified targets.'
WHERE question_id = 'a9e5d904-54cc-43ef-a646-374adbd97f60';

-- question_id: aa8246c8-4145-43a5-b960-38567e4429f0
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS CloudFormation StackSets provide a powerful mechanism for deploying and managing identical infrastructure stacks across multiple AWS accounts and regions from a single template, enabling automated infrastructure recreation and application deployment for DR. Lambda-based automation can then orchestrate data replication, failover logic, and resource scaling required for both pilot light and warm standby approaches. Option B (incorrect) AWS CodePipeline is primarily a CI/CD service focused on automating software release processes, including deployments across regions, and S3 Cross-Region Replication handles S3 data, but it doesn''t inherently provide the comprehensive infrastructure recreation and orchestration capabilities needed for full disaster recovery beyond application code deployment. Option C (incorrect) AWS Control Tower helps establish a secure, multi-account AWS environment and manage accounts through Account Factory and automated resource provisioning at an organizational level, but it does not directly provide the automated infrastructure recreation, data replication, and application deployment mechanisms for specific DR scenarios of existing workloads. Option D (incorrect) While Infrastructure as Code with Terraform is excellent for defining and provisioning infrastructure, the inclusion of "manual failover procedures" contradicts the key requirement for "automated infrastructure recreation" and "application deployment across regions" in a flexible DR strategy.'
WHERE question_id = 'aa8246c8-4145-43a5-b960-38567e4429f0';

-- question_id: ab8c5cb0-4354-44da-b9e7-cfe3a7b91775
-- answer_correct: True | verified_indices: [2, 3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The Basic Support plan provides access to customer service, documentation, whitepapers, and the AWS Support Forums, but does not include direct access to Cloud Support Engineers for technical issues at any time. Option B (incorrect) The Developer Support plan provides access to Cloud Support Engineers via email during business hours for general guidance and system-impaired issues, but does not offer 24/7 access. Option C (correct) The Business Support plan provides 24/7 phone, chat, and email access to Cloud Support Engineers for production system issues and impaired functionality, making it one of the plans that fulfills the requirement. Option D (correct) The Enterprise Support plan provides 24/7 phone, chat, and email access to Cloud Support Engineers for mission-critical workloads, along with a Technical Account Manager (TAM) and other proactive services, clearly meeting the 24/7 access requirement.'
WHERE question_id = 'ab8c5cb0-4354-44da-b9e7-cfe3a7b91775';

-- question_id: ab9fde9b-5d2e-496a-bf6a-58ed3937aac0
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Reinforcement learning is highly effective for dynamic route optimization because an agent can learn optimal policies by interacting with a simulated or real-world environment, receiving rewards for efficient routes (e.g., lower travel time, reduced fuel consumption) and penalties for poor choices, adapting in real-time to changing traffic patterns, a capability supported by AWS SageMaker Reinforcement Learning. Option B (incorrect) Image classification using services like Amazon Rekognition can analyze images to detect traffic density or road conditions, but it provides observational data rather than performing the dynamic optimization of a route itself. Option C (incorrect) Sentiment analysis, achievable with Amazon Comprehend, analyzes the emotional tone of text, which could be used to gauge driver satisfaction with routes but does not directly optimize delivery routes based on traffic. Option D (incorrect) Voice recognition, offered by services like Amazon Transcribe or Amazon Lex, converts spoken commands into text for navigation systems, serving as an input method rather than an underlying algorithm for route optimization and traffic pattern analysis.'
WHERE question_id = 'ab9fde9b-5d2e-496a-bf6a-58ed3937aac0';

-- question_id: ac5306a1-b0c8-49ce-b0c8-6507b4962ee1
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] (incorrect) Turning fixed costs into variable costs in cloud economics aims to optimize and often reduce overall spending by aligning costs directly with usage, rather than necessarily increasing it. Option [1] (correct) This phrase accurately describes how cloud computing converts significant upfront capital expenditures for infrastructure, like purchasing servers and storage, into operational expenses paid only for the resources consumed, such as AWS EC2 instances or S3 storage. Option [2] (incorrect) Paying the same amount monthly suggests a fixed cost model, whereas variable costs in the cloud fluctuate based on actual resource consumption, scaling up or down with services like AWS Auto Scaling or Lambda functions. Option [3] (incorrect) Cloud computing does not eliminate all costs; instead, it allows organizations to pay only for the AWS resources they use, effectively shifting capital expenditure to operational expenditure while still incurring expenses for services consumed.'
WHERE question_id = 'ac5306a1-b0c8-49ce-b0c8-6507b4962ee1';

-- question_id: ad1dd131-4ad6-418f-b584-da1148f185a4
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudFormation is an Infrastructure as Code service for provisioning resources, not for performing automatic scaling, and AWS Config monitors resource configurations, neither of which directly scale compute or distribute traffic. Option B (correct) Amazon EC2 Auto Scaling automatically adjusts compute capacity by adding or removing instances based on demand, and Elastic Load Balancing distributes incoming application traffic across those instances to ensure high availability and elasticity. Option C (incorrect) AWS Systems Manager helps manage AWS resources and applications, and AWS Organizations manages multiple AWS accounts, neither of which directly provide automatic compute scaling or traffic distribution. Option D (incorrect) Amazon S3 is an object storage service and Amazon Glacier is for archive storage, neither of which are compute services or distribute application traffic.'
WHERE question_id = 'ad1dd131-4ad6-418f-b584-da1148f185a4';

-- question_id: ad81167f-349f-49be-8b9e-5312d3eb1256
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The AWS Bills page provides a summary of monthly charges and detailed line items but lacks the granular filtering, customizable visualizations, and advanced analytical capabilities required to deeply understand spending patterns and identify top cost drivers over time. Option B (correct) AWS Cost Explorer is specifically designed for visualizing, understanding, and managing AWS costs and usage over time, offering granular data filtering by services, regions, tags, and accounts, along with customizable reports and forecasts to identify trends and top cost drivers effectively. Option C (incorrect) The AWS Pricing Calculator is used to estimate the cost of new AWS solutions and services before they are deployed, not for analyzing historical or current spending patterns or visualizing existing costs. Option D (incorrect) AWS Control Tower helps set up and govern a secure, multi-account AWS environment with automated best practices and policy enforcement, but it does not provide tools for detailed cost analysis or visualization of spending patterns.'
WHERE question_id = 'ad81167f-349f-49be-8b9e-5312d3eb1256';

-- question_id: aeaede7c-8b58-4406-8401-815ff6e63d35
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) Basic Support is the default, free tier that provides access to documentation, forums, and health status, but does not include any personalized guidance, architectural reviews, or dedicated points of contact for strategic initiatives. Option B (incorrect) Developer Support offers email access to cloud support associates and general guidance on how to use AWS services, but it does not provide proactive architectural reviews, strategic guidance, or a dedicated technical account manager for complex enterprise needs. Option C (correct) Enterprise Support is designed for large enterprises and includes a dedicated Technical Account Manager (TAM) who provides proactive guidance, performs architectural reviews, acts as a primary point of contact for strategic initiatives, and offers operations support management and event management. Option D (incorrect) Business Support provides 24/7 phone, chat, and email access to cloud support engineers, along with some architectural guidance for common use cases, but it lacks the dedicated Technical Account Manager and proactive strategic partnership required for highly personalized enterprise needs.'
WHERE question_id = 'aeaede7c-8b58-4406-8401-815ff6e63d35';

-- question_id: af09b75d-fb5e-473f-9f44-b2c7323af476
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Direct Connect establishes a dedicated private network connection from an on-premises data center to AWS, not directly between two AWS VPCs. Option B (correct) VPC Peering allows private network connectivity by directly connecting two VPCs so they can communicate as if they are on the same network using AWS''s private infrastructure. Option C (incorrect) An Internet Gateway enables communication between a VPC and the public internet, providing public connectivity rather than private connectivity between VPCs. Option D (incorrect) An Elastic Load Balancer distributes incoming application traffic across multiple targets within or across Availability Zones and is an application delivery service, not a service for inter-VPC private network connectivity.'
WHERE question_id = 'af09b75d-fb5e-473f-9f44-b2c7323af476';

-- question_id: af1d21e1-7a5b-4791-9532-3c771267612a
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Comprehensive logging is fundamental for AI auditability as AWS CloudTrail tracks API calls and user activity across AWS services, including those used for AI/ML, while Amazon CloudWatch can collect and monitor logs from Amazon SageMaker, EC2 instances, and other compute resources running AI applications, providing a detailed audit trail of operations, data access, and system events. Option B (correct) Version control for models is crucial for reproducibility and accountability, allowing auditors to trace which model version was used for specific inferences or decisions; Amazon SageMaker Model Registry facilitates managing and versioning trained models, and Amazon S3 can store model artifacts with versioning enabled to track changes over time. Option C (incorrect) No records directly contradicts the very definition of auditability, as without records, there is no evidence to review or verify the actions, inputs, outputs, or behavior of an AI system, making any form of audit impossible. Option D (incorrect) Hidden operations undermine auditability by obscuring the internal workings, data flows, and decision-making processes of an AI system, making it impossible for auditors to understand or validate how the system functions or arrived at a particular outcome. Option E (incorrect) Anonymous usage, while sometimes relevant for user privacy, does not inherently ensure AI auditability; auditability focuses on the system''s internal processes, model versions, and data lineage, requiring operational logs and traceable steps irrespective of whether the end-user''s identity is known to the system or stored.'
WHERE question_id = 'af1d21e1-7a5b-4791-9532-3c771267612a';

-- question_id: af71553d-ac39-4a53-8398-eb7d759871a0
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Linear regression is used for predicting continuous numerical values, such as future sales amounts, rather than for grouping customers into segments, which is an unsupervised learning task. Option 1 (incorrect) Random forest classification is a supervised learning algorithm used to predict discrete categories for new data points based on pre-labeled training data, which is not applicable when the goal is to discover unknown customer segments. Option 2 (correct) K-means clustering is an unsupervised learning algorithm ideal for segmenting customers based on similarities in their purchasing behavior by grouping them into ''k'' distinct clusters without requiring pre-labeled data, a capability offered by Amazon SageMaker''s built-in algorithms. Option 3 (incorrect) Time series forecasting is designed for predicting future values based on historical time-ordered data, such as future demand, and is not suitable for identifying customer segments based on their current purchasing patterns.'
WHERE question_id = 'af71553d-ac39-4a53-8398-eb7d759871a0';

-- question_id: afdedb86-5c66-44cc-9484-f7f982c47243
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) A Single-AZ deployment means the database instance is provisioned in only one Availability Zone, which makes it vulnerable to an outage in that specific AZ and does not provide automatic failover. Option B (incorrect) Read Replicas are used to improve read performance by offloading read traffic and can be deployed in different AZs or regions, but they do not provide automatic failover for the primary database in the event of an AZ outage as they are not synchronous standbys for write operations. Option C (correct) A Multi-AZ deployment automatically provisions a synchronous standby replica in a different Availability Zone, ensuring high availability and automatic failover to the standby in case of an Availability Zone outage or primary instance failure. Option D (incorrect) Cross-Region replication involves creating Read Replicas or using other methods to copy data to a different AWS region, which primarily serves as a disaster recovery solution for regional outages, not automatic failover within the same region during an AZ outage.'
WHERE question_id = 'afdedb86-5c66-44cc-9484-f7f982c47243';

-- question_id: b054bba8-c144-4195-8427-8a267cd6a157
-- answer_correct: True | verified_indices: [2] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) RDS Multi-AZ provides high availability within a single region, not cross-region disaster recovery, and thus does not protect against a full regional outage. Option B (incorrect) Configuring an RDS cross-region read replica with automated backups may struggle to consistently meet the 10-minute RTO for promotion and DNS changes, and the RPO is subject to asynchronous replication lag, potentially exceeding 5 minutes under high load or during a disaster. Option C (correct) Aurora Global Database, although requiring a migration from RDS MySQL to Aurora, is purpose-built for stringent RTO (typically less than 5 minutes for unplanned failover) and RPO (seconds) objectives across regions, making it the most optimal and cost-efficient solution that meets the specified requirements. Option D (incorrect) Taking hourly RDS snapshots and copying to a secondary region will result in an RPO of up to an hour and an RTO of tens of minutes to hours for restoration, far exceeding the 5-minute RPO and 10-minute RTO requirements.'
WHERE question_id = 'b054bba8-c144-4195-8427-8a267cd6a157';

-- question_id: b0c942bd-70ae-4775-91a3-783ddb8d0ad0
-- answer_correct: True | verified_indices: [1] | confidence: 80%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Marketplace is a digital catalog for discovering, procuring, and deploying third-party software, data, and professional services, not the primary source for AWS''s native security best practices and guidance. Option B (correct) AWS Security Center, conceptually representing the comprehensive suite of AWS security services, frameworks like the AWS Well-Architected Framework''s Security Pillar, and related documentation, is the primary place to find centralized best practices, guidance, and tools like AWS Security Hub for monitoring security posture. Option C (incorrect) AWS Cost Explorer is a tool used for visualizing, understanding, and managing your AWS costs and usage over time, offering no direct functionality related to security best practices. Option D (incorrect) AWS Quick Starts are automated reference deployments that help users deploy popular technologies on AWS following best practices, but they are solutions for deploying applications rather than the central repository for general security best practices and guidance themselves.'
WHERE question_id = 'b0c942bd-70ae-4775-91a3-783ddb8d0ad0';

-- question_id: b0da661b-86c3-49b9-ac19-e6523f7beaff
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Guardrails introduce additional processing steps to filter and moderate content, which can slightly increase latency rather than directly increasing the speed of content generation. Option 1 (correct) Guardrails in generative AI applications, such as those configurable in Amazon Bedrock, are specifically designed to enforce safety, content policies, and responsible AI guidelines by detecting and blocking undesirable content like hate speech, PII, or disallowed topics. Option 2 (incorrect) While guardrails can prevent misuse that might lead to reputational or legal costs, their primary role is not direct cost reduction, and their implementation and operation can sometimes introduce additional infrastructure or service costs. Option 3 (incorrect) Guardrails focus on the safety, appropriateness, and compliance of the generated output with defined policies, rather than directly improving the factual accuracy or correctness of the information produced by the model.'
WHERE question_id = 'b0da661b-86c3-49b9-ac19-e6523f7beaff';

-- question_id: b131bb2d-86ff-4046-8623-536d385de58c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Backup and Restore involves restoring data from backups and provisioning infrastructure from scratch, which typically results in an RTO of hours or days and an RPO of minutes to hours, not meeting the required RTO of minutes or RPO of seconds for a critical application. Option B (incorrect) Pilot Light involves replicating data and having core infrastructure like a database running in a minimal state, but often requires significant effort to provision or scale up non-core application components during recovery, leading to an RTO that can be tens of minutes to hours, potentially exceeding the required minutes. Option C (correct) Warm Standby involves maintaining a continuously updated, scaled-down but fully functional replica of the application in another region, enabling recovery within minutes by scaling up the existing environment and achieving an RPO of seconds through continuous data replication using services like AWS RDS Cross-Region Read Replicas or AWS DMS. Option D (incorrect) Multi-Site Active-Active strategy involves running full-scale, active environments in multiple regions simultaneously, serving traffic from all sites, which provides near-zero RTO and RPO but is significantly more complex and costly than maintaining a scaled-down replica.'
WHERE question_id = 'b131bb2d-86ff-4046-8623-536d385de58c';

-- question_id: b1b6d268-9113-439d-91d0-76e1dc3570df
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EventBridge is not designed for data storage; AWS services such as Amazon S3, Amazon RDS, or Amazon DynamoDB are specifically built for various data storage needs. Option B (correct) Amazon EventBridge is a serverless event bus that facilitates building event-driven architectures by routing events from sources like AWS services, custom applications, and SaaS partners to various targets for processing. Option C (incorrect) EventBridge does not handle user authentication; AWS services like Amazon Cognito and AWS IAM are dedicated to managing user identities and access. Option D (incorrect) EventBridge is not used for content delivery; Amazon CloudFront and Amazon S3 are the primary AWS services for content delivery network (CDN) and static content hosting respectively.'
WHERE question_id = 'b1b6d268-9113-439d-91d0-76e1dc3570df';

-- question_id: b1cb5722-f45e-4797-88e5-4894fa593bac
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon GuardDuty is a managed threat detection service that continuously monitors for malicious activity and unauthorized behavior across AWS accounts and workloads, automatically identifying and alerting on potential threats. Option B (correct) AWS Security Hub provides a comprehensive view of your security posture across AWS accounts, aggregates security findings from various AWS services and partner solutions, and enables automated remediation actions through custom actions and Amazon EventBridge. Option C (incorrect) Amazon S3 is an object storage service that does not natively provide automated threat detection or response capabilities, though its logs can be monitored by other security services for threats. Option D (incorrect) AWS Lambda is a serverless compute service used to run code in response to events and can be part of an automated response, but it does not inherently provide threat detection capabilities itself. Option E (incorrect) Amazon EC2 provides resizable compute capacity in the cloud and does not inherently offer automated threat detection or response capabilities; security monitoring for EC2 is handled by other services like GuardDuty.'
WHERE question_id = 'b1cb5722-f45e-4797-88e5-4894fa593bac';

-- question_id: b1d64ce7-9115-40c4-a540-f3f82bee13c1
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Amazon RDS is a relational database service that supports various SQL database engines like MySQL, PostgreSQL, and SQL Server, but does not inherently offer NoSQL capabilities. Option 1 (correct) Amazon DynamoDB is a NoSQL key-value and document database service that also provides SQL capabilities through PartiQL, a SQL-compatible query language for querying, inserting, updating, and deleting data. Option 2 (incorrect) Amazon DocumentDB is a fully managed NoSQL document database service that is compatible with MongoDB APIs, and therefore does not natively offer SQL capabilities. Option 3 (incorrect) Amazon Aurora is a high-performance relational database service compatible with MySQL and PostgreSQL, exclusively providing SQL capabilities for structured data.'
WHERE question_id = 'b1d64ce7-9115-40c4-a540-f3f82bee13c1';

-- question_id: b1e0afd5-8f55-4b72-bbc3-c1ac906f59b9
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Lowering the temperature makes the model''s output more deterministic and focused on the most probable tokens, reducing the likelihood of generating less likely, fabricated information, which is a common technique used with models like those accessible via Amazon Bedrock (e.g., Anthropic Claude, AI21 Labs Jurassic). Option B (correct) Retrieval Augmented Generation (RAG) enhances model accuracy by grounding its responses in external, verified data sources, such as documents stored in Amazon S3 or a knowledge base powered by Amazon Kendra or vector databases like Amazon OpenSearch Service, before generating an answer, significantly reducing the model''s reliance on its internal, potentially outdated or incorrect training data. Option C (incorrect) Increasing the temperature makes the model''s output more random and diverse, encouraging it to explore less probable tokens, which increases the chance of generating imaginative but factually incorrect or fabricated content, contrary to the goal of reducing hallucination in models on Amazon Bedrock. Option D (incorrect) Removing all constraints from a language model, such as those related to content moderation or output formatting, would allow it to generate arbitrary content without guidance, potentially increasing the risk of irrelevant, nonsensical, or hallucinated responses, contradicting best practices for responsible AI on AWS. Option E (incorrect) Unlimited token generation implies no maximum length for the output, which could lead to excessively verbose, repetitive, or rambling responses where the model might start generating fabricated content to fill the requested length, and in practical AWS applications, models like those in Amazon Bedrock have defined maximum output token limits to manage cost and relevance.'
WHERE question_id = 'b1e0afd5-8f55-4b72-bbc3-c1ac906f59b9';

-- question_id: b1e97be7-4323-4c64-96e1-eef224df62e6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Lambda is a serverless compute service that runs code in response to events and automatically manages the underlying compute resources, but it does not manage or scale EC2 instances. Option B (correct) Amazon EC2 Auto Scaling is the specific AWS service designed to automatically add or remove EC2 instances based on demand, as defined by scaling policies, ensuring application availability and optimizing costs. Option C (incorrect) AWS CloudFront is a content delivery network (CDN) service that accelerates the delivery of web content to users, but it is not involved in the scaling of EC2 compute capacity. Option D (incorrect) AWS Elastic Beanstalk is a platform as a service (PaaS) that simplifies the deployment and management of applications, and while it leverages Amazon EC2 Auto Scaling to manage the underlying EC2 instances, it is not the direct service for defining the granular scaling policies for EC2 instances described.'
WHERE question_id = 'b1e97be7-4323-4c64-96e1-eef224df62e6';

-- question_id: b299cfd0-bb84-4a9d-9285-d93ff6d6e597
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) io2 Block Express volumes are specifically designed for the highest performance and lowest latency workloads, delivering sub-millisecond latency and millions of IOPS, making them ideal for the most demanding transactional databases. Option B (incorrect) While increasing gp2 volume size can increase IOPS, gp2 volumes have a burstable performance model and do not offer the consistently high, low-latency performance required compared to dedicated provisioned IOPS volumes like io2 Block Express. Option C (incorrect) Amazon EBS gp3 volumes offer improved performance over gp2 with independently provisionable IOPS and throughput, but they do not provide the absolute highest sustained performance and lowest latency available compared to io2 Block Express. Option D (incorrect) Amazon EFS is a shared network file system with higher latency than block storage and is not suitable for the extremely low-latency, high-performance block storage requirements of a transactional database on a single EC2 instance.'
WHERE question_id = 'b299cfd0-bb84-4a9d-9285-d93ff6d6e597';

-- question_id: b2a7583d-d4e5-43c0-914f-a0a48a89e8f6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The instance name is a user-defined tag or label for organizational purposes and has no direct impact on the Amazon EC2 billing rate. Option B (correct) Amazon EC2 instance pricing is primarily determined by the instance type and size (e.g., t3.medium, m5.xlarge) because these specifications directly dictate the allocated compute, memory, and network resources, which are the core components billed by AWS. Option C (incorrect) While the duration an instance runs (from launch to termination) is a key factor in total cost, the specific time of day or date an EC2 instance is launched does not influence its per-hour or per-second pricing rate. Option D (incorrect) Within a single AWS region, the per-hour or per-second pricing for a specific EC2 instance type remains consistent across all Availability Zones, although data transfer costs might vary for traffic crossing AZ boundaries.'
WHERE question_id = 'b2a7583d-d4e5-43c0-914f-a0a48a89e8f6';

-- question_id: b2cabf05-e320-4a8c-b209-b80a48986570
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Relational databases like Amazon RDS (e.g., PostgreSQL, MySQL) or Amazon Aurora store data in predefined schemas with tables, rows, and columns, enforcing relationships through foreign keys, which is not how DynamoDB operates. Option B (correct) Amazon DynamoDB is a fully managed, serverless NoSQL database service that provides fast and flexible key-value and document database capabilities for virtually any scale, offering flexible schemas and horizontal scalability. Option C (incorrect) Data warehouses like Amazon Redshift are specialized for large-scale analytical processing and complex querying over historical data for business intelligence, not for high-performance transactional operations like DynamoDB. Option D (incorrect) While DynamoDB offers single-digit millisecond performance, it is a persistent, disk-backed database, whereas in-memory databases like Amazon ElastiCache (Redis, Memcached) or Amazon MemoryDB store data primarily in RAM for even lower latency and are often used for caching or real-time analytics.'
WHERE question_id = 'b2cabf05-e320-4a8c-b209-b80a48986570';

-- question_id: b37b7f2b-13f5-4205-ac54-e4c91fb544c1
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While AWS provides high-performance options like Amazon EC2 instances optimized for compute-intensive workloads, performance is a capability and not the primary *cost* advantage in shifting from traditional data centers, which can also achieve high performance with significant upfront investment. Option B (incorrect) AWS offers a robust shared responsibility model for security, handling "security of the cloud" at a foundational level with services like AWS Identity and Access Management (IAM) and AWS Shield, but security is a fundamental benefit and ongoing responsibility, not primarily the core *cost* advantage that defines the financial shift from traditional data centers. Option C (correct) Cloud computing with AWS eliminates the need for large upfront capital expenditures (CapEx) on hardware, cooling, power, and data center space, allowing businesses to shift to an operational expenditure (OpEx) model where they pay only for the resources consumed (e.g., Amazon EC2, Amazon S3) on a pay-as-you-go basis. Option D (incorrect) While AWS provides highly scalable and vast pools of resources for services like Amazon S3 or Amazon DynamoDB, offering a perception of "unlimited" capacity, the sheer volume of available resources is a scalability benefit, not the primary *cost* advantage itself, as users still incur costs for all consumed resources.'
WHERE question_id = 'b37b7f2b-13f5-4205-ac54-e4c91fb544c1';

-- question_id: b4084f11-dc3e-4b46-af29-16fb556d0c43
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Spot Instances offer significant cost savings for fault-tolerant workloads but do not provide capacity assurance and can be interrupted with a two-minute warning by AWS. Option 1 (incorrect) Reserved Instances provide a billing discount for a committed term of 1 or 3 years, which constitutes a long-term billing commitment, and only guarantee capacity if purchased with an explicit Capacity Reservation attribute. Option 2 (correct) On-Demand Capacity Reservations allow you to reserve EC2 capacity for a specific instance type in a particular Availability Zone, ensuring its availability for any duration without requiring a long-term billing commitment. Option 3 (incorrect) Dedicated Hosts provide dedicated physical EC2 servers for your use but involve a significant billing commitment for the entire host, which is not aligned with "without billing commitment" in this context.'
WHERE question_id = 'b4084f11-dc3e-4b46-af29-16fb556d0c43';

-- question_id: b45d4ce4-7244-4cbb-9a9e-cb69e18124bd
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Linking multiple models together describes a model orchestration pattern, potentially utilizing AWS Step Functions to manage workflows between different Amazon SageMaker endpoints or Amazon Bedrock models, rather than a prompting technique within a single model. Option B (correct) Guiding the model to show reasoning steps is precisely what chain-of-thought prompting entails, where examples provided in the prompt encourage foundational models, such as those accessed through Amazon Bedrock, to generate intermediate thought processes, leading to more accurate and verifiable answers. Option C (incorrect) Encrypting prompts pertains to data security, ensuring prompt data is protected in transit and at rest using services like AWS Key Management Service (KMS) in conjunction with AWS Generative AI services, which is unrelated to the logical content strategy of the prompt. Option D (incorrect) Compressing prompt size is a technique to optimize token usage for cost-efficiency or context window limits with models on Amazon Bedrock, whereas chain-of-thought prompting often increases prompt length by adding reasoning examples, not reducing it.'
WHERE question_id = 'b45d4ce4-7244-4cbb-9a9e-cb69e18124bd';

-- question_id: b4a45a0b-524a-4f72-b284-d114cc781a36
-- answer_correct: False | verified_indices: [1, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1, 2}'::integer[],
    explanation = 'Option A (incorrect) Physical security of AWS data centers is an AWS responsibility under the "Security of the Cloud" portion of the shared responsibility model, as AWS manages the physical infrastructure. Option B (correct) Operating system updates on EC2 instances are a customer responsibility under the "Security in the Cloud" model, as customers are responsible for managing the guest operating system, including patching and configuration. Option C (correct) Identity and access management is a customer responsibility, as customers configure IAM users, roles, and policies to control access to their resources in the cloud. Option D (incorrect) Hardware maintenance for the underlying infrastructure is an AWS responsibility, falling under "Security of the Cloud" to ensure the reliability and security of its global infrastructure. Option E (incorrect) Power and cooling are aspects of the physical facility infrastructure, which are managed by AWS as part of their "Security of the Cloud" responsibilities.'
WHERE question_id = 'b4a45a0b-524a-4f72-b284-d114cc781a36';

-- question_id: b4b6bc4c-a70c-4178-825b-bf5c0fe907d1
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS DataSync is a data transfer service that simplifies, automates, and accelerates moving large amounts of data between on-premises storage and AWS storage services, but it does not convert database schemas or code between different database engines. Option B (correct) AWS Schema Conversion Tool (SCT) automatically converts the source database schema and a majority of the custom code, including views, stored procedures, and functions, into a format compatible with the target database engine, which is essential for heterogeneous migrations. Option C (incorrect) AWS Storage Gateway is a hybrid cloud storage service that provides on-premises applications access to cloud storage, but it does not perform database engine migration or schema conversion. Option D (incorrect) AWS Direct Connect is a networking service that provides a dedicated private connection between your data center and AWS, facilitating network connectivity for migrations but not performing the actual database engine conversion.'
WHERE question_id = 'b4b6bc4c-a70c-4178-825b-bf5c0fe907d1';

-- question_id: b545b177-5480-4fbc-9ff8-f212b346f39d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) A rolling update can minimize downtime by gradually updating instances but manual testing of each batch can introduce delays and complicate achieving a truly quick rollback compared to a full environment swap. Option B (correct) A blue/green deployment strategy provides minimal downtime by deploying the new application version to a separate, identical environment (easily provisioned by CloudFormation), allowing for thorough testing before instantly shifting traffic (e.g., via an Application Load Balancer or Route 53) to the new environment, and enabling an immediate rollback to the old environment if issues are detected. Option C (incorrect) Deploying directly over the old version (in-place upgrade) inherently causes downtime during the update process, and relying on backups for rollback is a time-consuming data recovery method, not a quick application version rollback. Option D (incorrect) While a canary release gradually routes small traffic to minimize impact, the explicit lack of a "full rollback plan" makes it unsuitable for the stated requirement of quick rollback capability, as a robust rollback mechanism is crucial for a successful canary strategy.'
WHERE question_id = 'b545b177-5480-4fbc-9ff8-f212b346f39d';

-- question_id: b554a71b-a6f0-4643-9239-8353a83ba226
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS S3 does not directly charge for the creation of buckets; instead, costs are incurred based on the data stored within them and operations performed. Option B (correct) AWS S3 pricing is primarily determined by the total volume of data stored and the specific S3 storage class selected, as different classes (e.g., S3 Standard, S3 Glacier) have vastly different per-GB-per-month rates and associated costs. Option C (incorrect) While access frequency (request types like GET/PUT) contributes to S3 costs, it is generally a smaller factor compared to the storage cost itself, and stating "only" ignores the significant impact of data volume and storage class. Option D (incorrect) The geographic region where S3 data is stored does affect pricing, but it is typically a less significant factor compared to the storage class and sheer volume of data, and stating "only" makes it incorrect.'
WHERE question_id = 'b554a71b-a6f0-4643-9239-8353a83ba226';

-- question_id: b572fe43-d962-4741-a438-15eeba239bce
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS employee marketplace is not the purpose of AWS Marketplace, which is a public-facing digital catalog for external AWS customers to find and purchase third-party solutions. Option B (correct) AWS Marketplace is a curated digital catalog where customers can discover, purchase, and deploy third-party software, data products, and professional services, often integrated with their AWS infrastructure. Option C (incorrect) AWS training materials are primarily accessed through AWS Skill Builder, the AWS Training and Certification website, or official authorized training partners, not through the AWS Marketplace which focuses on commercial software and services. Option D (incorrect) Hardware procurement is not a function of AWS Marketplace; AWS provides virtualized cloud resources, and while services like AWS Outposts offer AWS-managed hardware on-premises, the Marketplace itself is for software and services, not direct hardware sales to customers.'
WHERE question_id = 'b572fe43-d962-4741-a438-15eeba239bce';

-- question_id: b5ba4730-edac-432b-8639-f7010370c406
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) High availability ensures an application remains operational and accessible despite failures in underlying infrastructure through services like Multi-AZ deployments and Elastic Load Balancing, but it doesn''t directly describe the ability to scale resources up and down for fluctuating demand. Option B (correct) Elasticity is the ability of a cloud system to acquire and release computing resources dynamically as needed, allowing a retail company to automatically scale up resources using Amazon EC2 Auto Scaling groups during seasonal traffic spikes and scale down when demand subsides. Option C (incorrect) Durability refers to the long-term preservation of data, ensuring its integrity and preventing loss, a characteristic exemplified by Amazon S3''s eleven nines of durability, which is unrelated to handling fluctuating compute or network traffic. Option D (incorrect) Security involves protecting data, systems, and assets from unauthorized access, use, or disruption through features like AWS Identity and Access Management (IAM) and Virtual Private Clouds (VPC), which is a foundational aspect of AWS but not the characteristic specifically describing handling traffic spikes.'
WHERE question_id = 'b5ba4730-edac-432b-8639-f7010370c406';

-- question_id: b5ce02b7-2ec1-49d3-ac35-36b215ab9c55
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Cloud computing generally reduces or eliminates higher upfront costs by shifting from large capital expenditures to operational expenses. Option B (correct) Cloud computing allows organizations to convert large capital expenditures (CAPEX) for hardware and infrastructure into flexible operational expenditures (OPEX) by paying for services like Amazon EC2, Amazon S3, or Amazon RDS on a pay-as-you-go basis. Option C (incorrect) Cloud computing typically reduces maintenance costs for customers because AWS is responsible for the underlying infrastructure maintenance and operational tasks for services such as Amazon EC2 and Amazon S3. Option D (incorrect) While AWS offers options like Reserved Instances and Savings Plans, the primary financial advantage and characteristic of cloud computing is its flexible, pay-as-you-go, and variable pricing model based on actual consumption rather than fixed pricing.'
WHERE question_id = 'b5ce02b7-2ec1-49d3-ac35-36b215ab9c55';

-- question_id: b5e2b965-cd0b-40cc-8928-d70773d0bb72
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon OpenSearch Service is a fully managed service that provides full-text indexing, faceted search, and sub-second response times across millions of documents, automatically scaling to meet demand and offering high availability with Multi-AZ deployments, directly fulfilling all requirements. Option B (incorrect) While Amazon CloudSearch offers full-text and faceted search with automatic scaling, it is an older service generally less performant and feature-rich than OpenSearch Service for large-scale, high-demand search applications across millions of documents. Option C (incorrect) Amazon Kendra is an intelligent search service focused on natural language processing and answer retrieval, not primarily designed for the low-latency, full-text, and faceted search capabilities required for a typical content management system''s document indexing. Option D (incorrect) Amazon DynamoDB is a NoSQL database optimized for key-value lookups and lacks native full-text indexing and faceted search capabilities, making it unsuitable as a primary search solution even with Global Secondary Indexes and Lambda for custom processing, which would be complex and inefficient.'
WHERE question_id = 'b5e2b965-cd0b-40cc-8928-d70773d0bb72';

-- question_id: b6732510-1f69-44d3-b0ea-ab43ce617c3d
-- answer_correct: False | verified_indices: [1, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1, 2}'::integer[],
    explanation = 'Option A (incorrect) While Amazon API Gateway with WebSocket APIs can establish real-time bidirectional communication channels for chat features, it primarily provides the protocol layer and requires more custom backend logic to manage real-time data synchronization, message persistence, and offline capabilities compared to higher-level services. Option B (correct) AWS AppSync with GraphQL subscriptions is a managed service specifically designed for building real-time data-driven applications, making it ideal for chat features, real-time data synchronization, and supports offline message synchronization for mobile applications. Option C (correct) Amazon Pinpoint is a comprehensive customer engagement service that includes robust capabilities for sending targeted push notifications across various mobile platforms, directly addressing the push notification requirement for the mobile application. Option D (incorrect) Amazon Simple Email Service (SES) is an email sending service used for transactional emails, marketing campaigns, and email notifications, but it does not provide real-time chat, push notifications to mobile devices, or offline message synchronization capabilities required for this scenario. Option E (incorrect) AWS Lambda with EventBridge is excellent for serverless event processing and asynchronous task orchestration within a backend system, but it does not inherently provide the real-time communication infrastructure, concurrent connection management, or direct support for chat, push notifications, or offline sync required by the mobile application.'
WHERE question_id = 'b6732510-1f69-44d3-b0ea-ab43ce617c3d';

-- question_id: b6ad5822-8ccb-4bc3-a1fb-4c87a10bb3aa
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) There is a fundamental difference between APN Consulting Partners and APN Technology Partners, as Consulting Partners focus on professional services and Technology Partners focus on software solutions that integrate with AWS. Option B (correct) APN Consulting Partners specialize in providing professional services such as migration, managed services, and architectural design on AWS, while APN Technology Partners offer software products and platforms that run on or integrate with AWS services like Amazon EC2 or Amazon S3. Option C (incorrect) Only APN Technology Partners primarily provide software solutions, whereas APN Consulting Partners deliver services to help customers design, build, and manage their AWS environments. Option D (incorrect) Only APN Consulting Partners provide consulting services, while APN Technology Partners deliver software that is compatible with or enhanced by AWS infrastructure.'
WHERE question_id = 'b6ad5822-8ccb-4bc3-a1fb-4c87a10bb3aa';

-- question_id: b777ecfa-fce6-4c9b-b034-a30a92d909a2
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Reviewing system logs only during incidents is a reactive approach that fails to provide the continuous insight and trend analysis necessary to proactively identify performance bottlenecks and ensure consistent KPI adherence, which AWS CloudWatch Logs and S3 can store but still require proactive analysis. Option B (correct) Monitoring KPIs and SLAs consistently through AWS CloudWatch metrics, dashboards, and alarms, and analyzing trends, is the most effective proactive strategy to identify performance bottlenecks, anticipate issues, and ensure the application continuously meets its performance targets. Option C (incorrect) Conducting annual performance tests offers only a periodic snapshot of performance, missing the daily fluctuations, gradual degradation, and real-time insights required for continuous KPI adherence and proactive bottleneck identification, unlike continuous monitoring provided by AWS CloudWatch. Option D (incorrect) Relying solely on cost reports, such as those from AWS Cost Explorer, provides financial data rather than direct operational performance metrics (like latency, throughput, or error rates), making it ineffective for directly identifying technical performance bottlenecks or ensuring application KPIs.'
WHERE question_id = 'b777ecfa-fce6-4c9b-b034-a30a92d909a2';

-- question_id: b7d6e717-1b83-4e71-b04a-712b8e61e4ad
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Storing all data in a single unencrypted S3 bucket creates a single point of failure and exposes sensitive data to unauthorized access, violating AWS security best practices for data at rest. Option B (incorrect) Disabling versioning for critical S3 buckets eliminates the ability to recover from accidental deletions or overwrites, directly hindering data resilience and recovery efforts. Option C (correct) Implementing regular backups using services like AWS Backup and employing encryption for data at rest (e.g., S3 SSE-KMS) and in transit (e.g., TLS) are fundamental AWS security and resilience best practices that protect data confidentiality and ensure recovery capabilities. Option D (incorrect) Granting unrestricted public access to all data repositories is a severe security misconfiguration that directly leads to data breaches and unauthorized data exposure, contradicting the goal of hardening an environment.'
WHERE question_id = 'b7d6e717-1b83-4e71-b04a-712b8e61e4ad';

-- question_id: b7f68f50-8339-45d8-b9fc-73abe929c558
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deployment is a later stage in the foundation model lifecycle, occurring after the model has been trained, fine-tuned, and validated, making it available for inference via services like Amazon SageMaker Endpoints. Option B (incorrect) Fine-tuning is performed after a foundation model has been pre-trained, adapting it to a specific downstream task or dataset using services such as Amazon SageMaker, often leveraging pre-trained models from SageMaker JumpStart. Option C (correct) Data selection is the foundational first stage, where vast and diverse datasets are gathered, prepared, and often stored in services like Amazon S3 for pre-training a foundation model. Option D (incorrect) Evaluation is an iterative process that takes place at various stages, including after pre-training, fine-tuning, and during ongoing production monitoring, assessing model performance using tools like Amazon SageMaker Experiments or SageMaker Model Monitor.'
WHERE question_id = 'b7f68f50-8339-45d8-b9fc-73abe929c558';

-- question_id: b7f6d8c0-31a9-42c2-b109-4bffda2e309f
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Creating IAM users is an important security practice for daily operations but should only be done after the root account itself is secured. Option B (correct) Enabling MFA on the root account is the absolute first and most critical security action because the root account possesses unrestricted administrative privileges and must be protected with an additional layer of security beyond just a password. Option C (incorrect) Launching EC2 instances is an operational task related to utilizing AWS services and should only be performed after fundamental security measures, including securing the root account and setting up proper IAM, are established. Option D (incorrect) Setting up billing alerts is a crucial financial management practice to monitor costs, but it is a subsequent step after initial security configurations and before or during active resource deployment, not the very first action.'
WHERE question_id = 'b7f6d8c0-31a9-42c2-b109-4bffda2e309f';

-- question_id: b8b0f7c3-ce2b-4d08-ac76-ca9e8d992821
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Automatic model training is primarily a function of services like Amazon SageMaker, particularly SageMaker Autopilot, which automates the end-to-end process of building, training, and tuning ML models, not A2I. Option B (correct) Amazon A2I is specifically designed to incorporate human review into machine learning workflows, creating human review loops for tasks where high confidence and accuracy are critical, integrating with services like Amazon Rekognition, Amazon Textract, and Amazon SageMaker. Option C (incorrect) Data storage on AWS is handled by services such as Amazon S3, Amazon RDS, Amazon DynamoDB, or Amazon EBS, which are dedicated storage solutions and not the primary function of A2I. Option D (incorrect) Network optimization is managed by services like Amazon CloudFront, Amazon Route 53, or AWS Global Accelerator, which focus on improving network performance and availability, distinct from A2I''s role in ML prediction review.'
WHERE question_id = 'b8b0f7c3-ce2b-4d08-ac76-ca9e8d992821';

-- question_id: b9218df8-78a8-4b0d-8941-c979fc11782e
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Predictive scaling is ineffective for unpredictable traffic patterns because it relies on historical data and machine learning to forecast future demand, which fails when spikes are sudden and unanticipated. Option B (incorrect) Target tracking scaling, while reactive, might not be aggressive or immediate enough to handle a 1000% load increase within minutes as it aims to maintain a target metric, which often involves smoother adjustments over time. Option C (correct) Step scaling with aggressive scale-out policies allows for immediate and significant increases in capacity (e.g., adding many instances) upon breaching alarm thresholds, effectively handling sudden, large spikes, while gradual scale-in optimizes costs during low traffic by preventing instance flapping. Option D (incorrect) Scheduled scaling is unsuitable for unpredictable traffic because it provisions capacity at predefined times based on known patterns, and thus cannot respond to sudden, unforeseen spikes.'
WHERE question_id = 'b9218df8-78a8-4b0d-8941-c979fc11782e';

-- question_id: b9a1609f-3b1e-450b-8de9-27518e9db0b2
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) AWS global infrastructure, through services like AWS WAF and Security Groups deployed across multiple regions and Availability Zones, actually provides more opportunities for robust security postures, disaster recovery, and compliance, rather than reducing security. Option 1 (correct) By deploying application components closer to users in different AWS Regions and leveraging Amazon CloudFront''s global network of edge locations, the physical distance data travels is minimized, significantly reducing network latency for users worldwide. Option 2 (incorrect) While deploying across multiple AWS Regions can involve additional resource costs, the primary benefit of global infrastructure is not higher costs; instead, it provides enhanced availability, resilience, and improved user experience, which often delivers greater long-term business value. Option 3 (incorrect) Global infrastructure deployments, by distributing resources across multiple AWS Regions and Availability Zones and requiring services like Amazon Route 53''s global routing policies or cross-region data replication, inherently lead to a more complex architecture compared to a single-region setup.'
WHERE question_id = 'b9a1609f-3b1e-450b-8de9-27518e9db0b2';

-- question_id: ba9c6c63-5baf-43b6-ada3-816deb3aee37
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Manually SSH into each instance is highly inefficient, error-prone, and not scalable for a large EC2 fleet, directly contradicting the goal of reducing operational overhead and desiring an automated approach. Option B (correct) AWS Systems Manager is specifically designed for centralized operational management, offering Patch Manager for automated patching, Run Command for executing scripts remotely, and State Manager for enforcing desired configurations across EC2 instances, directly addressing the need for centralized, automated configuration management and patching. Option C (incorrect) Developing custom scripts and cron jobs is a decentralized approach that lacks centralized reporting and control, is difficult to manage across a large EC2 fleet, and would still involve significant operational overhead for script maintenance and monitoring compared to AWS Systems Manager''s built-in features. Option D (incorrect) Terminating and recreating instances weekly with new AMIs can ensure up-to-date instances but is a disruptive and high-overhead approach for routine patching and configuration, especially "without a state management tool" to handle application configuration and data persistence, making it unsuitable for reducing operational overhead for configuration management.'
WHERE question_id = 'ba9c6c63-5baf-43b6-ada3-816deb3aee37';

-- question_id: bbbff746-2e23-4fa5-9d90-e07db7923aab
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Flash Attention is a memory-efficient attention computation technique that reduces the number of reads and writes to High Bandwidth Memory (HBM) on GPUs by reordering operations and leveraging fast on-chip SRAM, which is crucial for training large transformer models efficiently on AWS GPU instances like EC2 P4d or P5 instances and within Amazon SageMaker. Option B (incorrect) Flash Attention is designed to significantly speed up processing and reduce training/inference times for transformer models, directly benefiting performance and cost-efficiency on AWS compute resources. Option C (incorrect) Flash Attention explicitly aims to reduce GPU memory usage, allowing larger models or longer sequences to fit into memory without requiring costly model parallelism or CPU offloading on AWS GPU instances. Option D (incorrect) Flash Attention is an advanced optimization technique for the attention mechanism''s computation rather than a simplification of the overall transformer model architecture itself, requiring specific library and kernel support when implemented on AWS infrastructure.'
WHERE question_id = 'bbbff746-2e23-4fa5-9d90-e07db7923aab';

-- question_id: bc0345a3-cd44-438f-8556-8772a53c97bb
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EBS io2 volumes are network-attached block storage and, despite offering high performance and durability, inherently incur more latency due to network hops compared to directly attached storage. Option B (incorrect) EBS gp3 volumes are general-purpose, network-attached block storage and, while cost-effective and performant for many workloads, are not designed for the absolute lowest latency required by high-frequency trading applications compared to local storage. Option C (correct) EC2 instance store volumes, especially those backed by NVMe SSDs, are physically attached to the host server, providing the lowest possible latency for ephemeral data by eliminating network overhead inherent in other AWS storage services. Option D (incorrect) EFS is a network file system and, even with Max I/O performance mode, introduces significant network latency and distributed file system overhead, making it unsuitable for the absolute lowest latency requirement of a high-frequency trading application.'
WHERE question_id = 'bc0345a3-cd44-438f-8556-8772a53c97bb';

-- question_id: bc18a71a-1457-4573-8ffc-9e1a00675b1c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Spot Instances are unsuitable because they can be interrupted with a two-minute warning when EC2 capacity is reclaimed, which violates the requirement for workloads that "cannot tolerate interruptions". Option B (incorrect) On-Demand Instances are incorrect because while they provide uninterrupted service, they are the most expensive pricing model and do not offer "significant savings" for consistent, long-running workloads compared to commitment-based options. Option C (correct) Reserved Instances or Savings Plans are the correct choice because they offer substantial discounts (up to 72%) in exchange for a 1-year or 3-year commitment to consistent usage, perfectly aligning with the need for cost optimization for steady-state, uninterrupted database workloads. Option D (incorrect) Dedicated Hosts are incorrect because their primary use case is for specific licensing requirements or compliance and they are generally a more expensive option than Reserved Instances or Savings Plans, not primarily designed for "significant savings" on standard database workloads.'
WHERE question_id = 'bc18a71a-1457-4573-8ffc-9e1a00675b1c';

-- question_id: bc52c6ea-59c9-4d61-a4d0-24f1b258a9fc
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (Images) incorrect Amazon Rekognition is the AWS service specifically designed for analyzing images and videos to identify objects, people, text, and activities. Option 1 (Speech) incorrect While AWS offers Amazon Transcribe for converting speech to text, Amazon Comprehend itself does not directly analyze raw audio speech; it analyzes the textual output from services like Transcribe. Option 2 (Text) correct Amazon Comprehend is an AWS natural language processing (NLP) service that analyzes unstructured text to extract insights such as sentiment, entities, key phrases, and language. Option 3 (Videos) incorrect Amazon Rekognition is the AWS service used for analyzing video content, enabling tasks like content moderation, celebrity recognition, and activity detection.'
WHERE question_id = 'bc52c6ea-59c9-4d61-a4d0-24f1b258a9fc';

-- question_id: bc641eaf-1aa2-46ec-bb94-023e61d7cb34
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) Cost Optimization focuses on achieving business value by minimizing costs, for example by using Graviton processors for better price-performance or reserved instances. Option B (correct) Performance Efficiency focuses on using computing resources efficiently to meet requirements, adapting to changes, and maintaining efficiency as demand evolves, for example by selecting appropriate EC2 instance types or utilizing serverless architectures like AWS Lambda. Option C (incorrect) Reliability focuses on ensuring a workload performs its intended function correctly and consistently, recovering from infrastructure or service disruptions, for example by deploying applications across multiple Availability Zones or implementing backup and restore strategies. Option D (incorrect) Operational Excellence focuses on running and monitoring systems effectively, gaining insights, and continually improving processes and procedures, for example by automating deployments with AWS CloudFormation or monitoring applications with Amazon CloudWatch.'
WHERE question_id = 'bc641eaf-1aa2-46ec-bb94-023e61d7cb34';

-- question_id: bc76af22-2790-4860-a639-fe8a6ba6558d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudFormation is an infrastructure as code service used to provision and manage AWS resources, not to provide automated backup functionality. Option B (correct) AWS Backup is a fully managed, centralized backup service designed to automate and consolidate backup operations across a wide range of AWS services. Option C (incorrect) AWS Config is a service that assesses, audits, and evaluates the configurations of your AWS resources, providing compliance and historical configuration data, but it does not perform backups. Option D (incorrect) AWS Systems Manager is an operational hub that helps manage and automate operational tasks across AWS resources, and while it can orchestrate some operational tasks related to snapshots, it is not the dedicated service for centralized, automated backup of multiple AWS services like AWS Backup.'
WHERE question_id = 'bc76af22-2790-4860-a639-fe8a6ba6558d';

-- question_id: bcc1a05c-be9f-479a-beca-528329401d97
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The customer has less responsibility with RDS because AWS manages underlying infrastructure, operating system patching, and database software patching, which would otherwise be customer responsibilities on EC2. Option B (correct) AWS takes more responsibility with RDS by managing tasks such as operating system patching, database software installation and patching, automated backups, and multi-AZ high availability, significantly reducing the customer''s operational burden compared to EC2. Option C (incorrect) Responsibility does not remain identical; the AWS Shared Responsibility Model shifts more operational responsibility to AWS for managed services like RDS compared to IaaS services like EC2. Option D (incorrect) The customer does not manage hardware in either case at the physical level; with EC2, the customer chooses instance types and storage, representing virtual hardware, while with RDS, AWS completely abstracts and manages all underlying hardware infrastructure.'
WHERE question_id = 'bcc1a05c-be9f-479a-beca-528329401d97';

-- question_id: bcfd1cc6-8614-4b51-bc46-ed5c49be18a0
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Foundation models inherently require vast amounts of data for their initial pre-training, making "less data" an inaccurate distinction compared to traditional models trained from scratch. Option B (correct) Foundation models are indeed distinguished by their extensive pre-training on massive, diverse datasets, which allows them to be effectively fine-tuned or adapted via prompt engineering for a wide array of downstream tasks, as demonstrated by services like Amazon Bedrock. Option C (incorrect) Foundation models are typically much larger in terms of parameter count and model size than traditional machine learning models, requiring significant computational resources for training and inference, often utilizing powerful AWS EC2 instances like P4d or Inf2. Option D (incorrect) Foundation models excel at processing and generating unstructured data such as text, images, and audio, contrasting with traditional models that might be primarily focused on structured data found in databases like Amazon RDS or Amazon DynamoDB.'
WHERE question_id = 'bcfd1cc6-8614-4b51-bc46-ed5c49be18a0';

-- question_id: bd018302-9883-4f56-a073-7698d862fa7e
-- answer_correct: True | verified_indices: [1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudFormation with parameters and automated stack lifecycle management provides declarative infrastructure definition for identical configurations, but CloudFormation itself does not inherently automate its own provisioning and destruction based on external development lifecycle events; it requires an external orchestration mechanism like a CI/CD pipeline to manage its stack lifecycle. Option B (correct) AWS CDK (Cloud Development Kit) enables defining infrastructure programmatically using common programming languages, which allows for direct integration into CI/CD pipelines to programmatically deploy and destroy environments based on development lifecycle events (e.g., feature branch creation/deletion), thereby automating environment management and optimizing costs. Option C (incorrect) Terraform with remote state management and automated provisioning workflows is an excellent Infrastructure as Code tool, but similar to CloudFormation, it relies on external tools (e.g., CI/CD pipelines) to trigger its apply and destroy commands, rather than providing the programmatic logic for automated environment lifecycle management based on development events directly within Terraform itself. Option D (incorrect) AWS Service Catalog with pre-approved templates and automated provisioning is designed for self-service provisioning of standardized, approved IT services, not for dynamic, ephemeral environments that are automatically provisioned and destroyed based on development lifecycle events or inactivity.'
WHERE question_id = 'bd018302-9883-4f56-a073-7698d862fa7e';

-- question_id: bdf057cb-159d-4fdb-a02e-0c43008596c6
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Content delivery is the primary purpose of Amazon CloudFront, which is a global content delivery network (CDN) service, not Amazon VPC. Option B (correct) Amazon VPC (Virtual Private Cloud) allows you to provision a logically isolated section of the AWS Cloud where you can launch AWS resources in a virtual network that you define, providing a virtual private networking environment. Option C (incorrect) Database management is primarily handled by services like Amazon RDS, Amazon DynamoDB, or Amazon Aurora, which are distinct managed database services that can operate within a VPC. Option D (incorrect) File storage is provided by services such as Amazon S3, Amazon EFS, or Amazon FSx, which handle data persistence, while VPC provides the network for accessing these storage solutions.'
WHERE question_id = 'bdf057cb-159d-4fdb-a02e-0c43008596c6';

-- question_id: bdfd3060-34f0-40b5-bf5d-66bd9fe474af
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While 5 minutes was the previous maximum execution duration for AWS Lambda functions, this limit was increased in 2019. Option B (incorrect) 10 minutes is not the current maximum execution duration for an AWS Lambda function, as the service allows for a longer timeout. Option C (correct) AWS Lambda functions currently support a maximum execution duration of 15 minutes (900 seconds), which can be configured as the function''s timeout setting. Option D (incorrect) 60 minutes significantly exceeds the current maximum allowable execution duration for an AWS Lambda function, which is 15 minutes.'
WHERE question_id = 'bdfd3060-34f0-40b5-bf5d-66bd9fe474af';

-- question_id: be051f91-82a2-4586-81f4-c1220dda1b86
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Availability Zones are isolated locations within a Region designed for high availability and fault tolerance of application infrastructure, not primarily for lowest latency content delivery to a globally distributed end-user base. Option B (incorrect) Regions are large geographical areas that host multiple Availability Zones and provide data residency, but they are too geographically distant from many end-users to provide the absolute lowest latency for content delivery compared to a more distributed network. Option C (correct) Edge locations with CloudFront are a global network of Points of Presence that cache content geographically closest to end-users, significantly reducing latency and improving content delivery speed by serving content from the nearest available cache. Option D (incorrect) Local Zones extend an AWS Region into a specific metropolitan area to provide ultra-low latency for applications requiring local processing, but they are not as globally distributed or numerous as CloudFront Edge locations for widespread low-latency content delivery.'
WHERE question_id = 'be051f91-82a2-4586-81f4-c1220dda1b86';

-- question_id: bebe604c-edcd-47e0-989b-4105bc8404d4
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Certificate Manager focuses on provisioning, managing, and deploying SSL/TLS certificates for services like ELB and CloudFront, not on managing cryptographic keys for general data encryption. Option B (correct) AWS KMS (Key Management Service) is purpose-built for creating, storing, and controlling cryptographic keys that seamlessly integrate with a vast array of other AWS services like S3, EBS, and RDS for data encryption. Option C (incorrect) AWS Secrets Manager is used for managing, rotating, and retrieving database credentials, API keys, and other secrets, often using AWS KMS for their encryption, but it is not the core service for general key management. Option D (incorrect) AWS IAM (Identity and Access Management) is an access control service that manages user permissions and authentication to AWS resources, not an encryption or key management service.'
WHERE question_id = 'bebe604c-edcd-47e0-989b-4105bc8404d4';

-- question_id: beda1040-64c3-4cef-a3d4-498c64597cef
-- answer_correct: True | verified_indices: [2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) While Aurora Global Database provides fast cross-region replication and failover capabilities for the data layer, Route 53 health checks with failover routing policy typically imply an active-passive setup for the application tier, which does not represent the highest active-active availability. Option 1 (incorrect) CloudFront with multiple regional origins is suitable for global content delivery and routing, but it does not address the dynamic nature of an application using ALB and EC2, and S3 cross-region replication is for object storage, not for the relational database (RDS) customer data mentioned in the question. Option 2 (correct) Implementing an active-active deployment in two regions with Global Accelerator provides superior global traffic routing to the nearest healthy endpoint, ensuring highest availability for the application tier, and DynamoDB Global Tables offer fully managed, multi-region, active-active data replication with automatic failover and conflict resolution, which is a gold standard for highest availability for customer data across regions. Option 3 (incorrect) A primary region with standby infrastructure in a secondary region using RDS cross-region read replicas represents an active-passive disaster recovery solution, which requires a failover process and does not provide active-active availability or automatic write failover for the database across regions.'
WHERE question_id = 'beda1040-64c3-4cef-a3d4-498c64597cef';

-- question_id: bef3f3fb-1227-45d7-8819-782b81d430f1
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Security Groups operate at the instance level and provide stateful packet filtering, automatically allowing return traffic for any established connection, which does not meet the stateless requirement. Option B (incorrect) Route Tables are used to determine where network traffic is directed by specifying next hops for various destinations, not for filtering inbound or outbound traffic. Option C (correct) Network Access Control Lists (NACLs) operate at the subnet level and provide stateless packet filtering, requiring separate rules for inbound and outbound traffic to explicitly allow or deny connections, directly addressing the requirement. Option D (incorrect) VPC Endpoints provide private connectivity from your VPC to supported AWS services or other VPCs without requiring an internet gateway, and they do not perform packet filtering functions.'
WHERE question_id = 'bef3f3fb-1227-45d7-8819-782b81d430f1';

-- question_id: bf07e73b-0c68-4ce4-a605-8fc1dd733b4c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config continuously monitors and records your AWS resource configurations and allows you to automate the evaluation of recorded configurations against desired configurations, but it does not provide automated recommendations for cost, security, and performance optimization directly. Option B (incorrect) AWS Systems Manager helps you automate operational tasks across your AWS resources, such as patching, executing runbooks, and managing instances, but its primary function is not to provide automated recommendations for cost, security, and performance optimization. Option C (correct) AWS Trusted Advisor inspects your AWS environment and provides real-time guidance and automated recommendations across five categories: cost optimization, security, fault tolerance, performance, and service limits, making it the direct answer to the question. Option D (incorrect) AWS CloudFormation allows you to define and provision AWS infrastructure as code, enabling automation of resource creation and management, but it does not provide automated recommendations for optimizing existing deployments.'
WHERE question_id = 'bf07e73b-0c68-4ce4-a605-8fc1dd733b4c';

-- question_id: bf53815f-b6bc-4644-b523-b26a6f1475d5
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS VPN establishes an encrypted connection over the public internet, which is not a dedicated physical network connection. Option B (correct) AWS Direct Connect establishes a dedicated, private physical network connection from your on-premises data center to an AWS Direct Connect location, bypassing the public internet. Option C (incorrect) Amazon Route 53 is a highly available and scalable cloud Domain Name System (DNS) web service, used for routing internet traffic and managing domain names, not for establishing network connectivity. Option D (incorrect) AWS PrivateLink enables private connectivity between VPCs and AWS services or services hosted in other VPCs, but it does not establish the foundational dedicated network connection from on-premises to AWS.'
WHERE question_id = 'bf53815f-b6bc-4644-b523-b26a6f1475d5';

-- question_id: bfcbfb72-e6ae-4643-a575-2ba3a0c194cc
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon S3 is object storage and does not provide POSIX-compliant file system access, offering objects and buckets rather than a traditional hierarchical file system with features like file locking. Option B (incorrect) Amazon EBS provides block storage that can be formatted as a POSIX-compliant file system for a single EC2 instance, but standard EBS volumes cannot be attached to multiple EC2 instances simultaneously for shared access. Option C (correct) Amazon EFS is a fully managed NFS file system that provides POSIX-compliant file system access, allowing multiple EC2 instances to concurrently connect and share the same file system. Option D (incorrect) AWS Storage Gateway is a hybrid cloud storage service that connects on-premises environments to AWS cloud storage, and while its File Gateway configuration offers NFS/SMB (POSIX-compliant) interfaces, it''s primarily for on-premises access to S3, not a direct shared file system for multiple EC2 instances in the cloud.'
WHERE question_id = 'bfcbfb72-e6ae-4643-a575-2ba3a0c194cc';

-- question_id: bfd7b774-9ae9-4211-8532-edfde303268b
-- answer_correct: True | verified_indices: [0] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Automated snapshots are a native Redshift feature that can be configured for cross-region replication, and when configured for frequent intervals (effectively ensuring the latest snapshot is within 15 minutes) and copied cross-region, they meet both the 15-minute RPO and 1-hour RTO for region failure by allowing restoration of the cluster in the secondary region. Option B (incorrect) While AWS Backup can orchestrate Redshift snapshot management and cross-region copies, Option A describes the direct, native Redshift feature that precisely meets the requirements without adding an extra layer of abstraction, making it a more direct and often preferred strategy for Redshift DR. Option C (incorrect) Redshift data sharing allows near real-time data access across clusters, including cross-region, but it is not a complete backup and recovery solution for the entire producer cluster''s state (including metadata, configurations, and users) and would require additional steps to fully restore the primary cluster’s functionality in a DR scenario, potentially exceeding the 1-hour RTO. Option D (incorrect) Implementing manual snapshots after each data load is unreliable for meeting a strict 15-minute RPO due to human intervention and does not guarantee the required frequency, nor does it inherently include cross-region replication necessary for region failure.'
WHERE question_id = 'bfd7b774-9ae9-4211-8532-edfde303268b';

-- question_id: c03d0764-bfc0-42d4-a357-b9aba2170392
-- answer_correct: True | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Standard is designed for frequently accessed data with low latency and high throughput, making it too expensive for 800TB of data accessed less than once per year over 10 years. Option B (incorrect) S3 Standard-IA is optimized for infrequent access but has significantly higher storage costs compared to S3 Glacier storage classes, making it not the most cost-effective for data accessed less than once per year for 10 years. Option C (incorrect) S3 Glacier Flexible Retrieval, while cost-effective for archival, is not the absolute lowest-cost option as S3 Glacier Deep Archive offers even lower per-GB storage costs for data accessed very rarely. Option D (correct) S3 Glacier Deep Archive is the lowest-cost S3 storage class, specifically designed for long-term archival data accessed once or twice a year, and its Standard retrieval option guarantees data restoration within 12 hours, meeting the 24-hour requirement.'
WHERE question_id = 'c03d0764-bfc0-42d4-a357-b9aba2170392';

-- question_id: c0b18ad9-5278-4b84-a93e-83d1dfadb4f9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS WAF (Web Application Firewall) primarily protects web applications from common web exploits like SQL injection and cross-site scripting, rather than providing comprehensive protection against volumetric DDoS attacks. Option B (correct) AWS Shield is a managed Distributed Denial of Service (DDoS) protection service that offers always-on detection and automatic inline mitigations against various types of DDoS attacks for applications on AWS. Option C (incorrect) Amazon GuardDuty is a threat detection service that continuously monitors for malicious activity and unauthorized behavior to protect AWS accounts and workloads, identifying threats such as cryptocurrency mining or compromised EC2 instances, but not direct DDoS mitigation. Option D (incorrect) AWS Inspector is an automated security assessment service that identifies security vulnerabilities and deviations from best practices in applications and infrastructure, but it does not provide real-time protection against DDoS attacks.'
WHERE question_id = 'c0b18ad9-5278-4b84-a93e-83d1dfadb4f9';

-- question_id: c1d07a09-e236-4691-beb9-b028846be8a9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config tracks resource configuration changes and evaluates compliance, and AWS Trusted Advisor provides general security recommendations, but neither primarily audits API calls nor comprehensively analyzes access policies for unintended external access. Option B (correct) AWS CloudTrail logs all API calls and other events for auditing and governance, while AWS Access Analyzer identifies resources, including S3 buckets, that are shared with an external entity by analyzing their access policies, directly addressing both requirements. Option C (incorrect) AWS KMS manages encryption keys, and AWS Secrets Manager helps manage secrets, neither of which are designed for auditing API calls or identifying unintended external access to S3 buckets. Option D (incorrect) AWS GuardDuty is a threat detection service that monitors for malicious activity, and AWS Inspector is a vulnerability management service for EC2 instances and workloads, neither of which efficiently address auditing API calls or analyzing S3 bucket access policies for external sharing.'
WHERE question_id = 'c1d07a09-e236-4691-beb9-b028846be8a9';

-- question_id: c1f62bb5-0e6a-4532-b919-978c5c865118
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Amazon Kinesis is not designed for static data storage; AWS S3 is the primary service for durable, scalable, and cost-effective object storage of static and unstructured data. Option 1 (correct) Amazon Kinesis is a fully managed service that provides capabilities to collect, process, and analyze real-time streaming data, enabling immediate insights and rapid reactions through services like Kinesis Data Streams, Kinesis Data Firehose, and Kinesis Data Analytics. Option 2 (incorrect) While data collected by Kinesis can eventually be processed in batches, Kinesis itself is fundamentally designed for real-time, continuous data flow, with services like AWS Glue or Amazon EMR being more suited for dedicated batch data processing. Option 3 (incorrect) Kinesis manages data streams, not databases; AWS offers dedicated database services such as Amazon RDS, Amazon DynamoDB, Amazon Aurora, and Amazon Redshift for various database management needs.'
WHERE question_id = 'c1f62bb5-0e6a-4532-b919-978c5c865118';

-- question_id: c23c127e-afd4-4c0e-ae54-f45d381196de
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Implementing exponential backoff and retry logic handles throttling gracefully by reattempting failed requests with increasing delays, but it does not prevent the initial "S3 Slow Down" errors from occurring in the first place, which is what the question asks for. Option B (incorrect) S3 Transfer Acceleration utilizes Amazon CloudFront''s globally distributed edge locations to accelerate data transfers over long distances for uploads and downloads, but it does not increase the underlying S3 request rate limits for a bucket or its prefixes. Option C (correct) Distributing S3 object keys across multiple prefixes is an AWS best practice because S3 organizes data by prefixes and allocates dedicated request rate capacity to each prefix, thereby allowing for higher aggregate request rates across the bucket and preventing throttling. Option D (incorrect) Scheduling Glue jobs sequentially instead of concurrently would reduce the immediate load on S3 and likely mitigate throttling, but it would significantly increase the overall processing time for the daily transaction files, defeating the purpose of a scalable data pipeline and not truly solving the underlying S3 request rate capacity issue for concurrent access.'
WHERE question_id = 'c23c127e-afd4-4c0e-ae54-f45d381196de';

-- question_id: c2bc1262-7dec-469f-86b5-397694e002ca
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Monitoring server health is typically handled by services like Amazon CloudWatch or AWS Systems Manager, which are distinct from the purpose of Agents for Amazon Bedrock. Option B (correct) Agents for Amazon Bedrock are specifically designed to enable foundation models to break down complex requests into multiple steps, orchestrate these steps, and interact with external tools and knowledge bases to accomplish tasks. Option C (incorrect) Data compression is a function handled by various storage and transfer services like Amazon S3 or application-level mechanisms, not by Agents for Amazon Bedrock. Option D (incorrect) User authentication and authorization are managed by services such as AWS Identity and Access Management (IAM) or Amazon Cognito, which is unrelated to the AI task orchestration capabilities of Agents for Amazon Bedrock.'
WHERE question_id = 'c2bc1262-7dec-469f-86b5-397694e002ca';

-- question_id: c3a00314-6cf6-4655-99b4-69ef30eb5ea1
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Forecast is designed for time-series forecasting, such as predicting future sales or resource needs, not for generating personalized product recommendations for individual users. Option B (correct) Amazon Personalize is a machine learning service specifically built to help developers create personalized recommendations for their users, making it ideal for e-commerce product recommendations. Option C (incorrect) Amazon Comprehend is an artificial intelligence service that uses natural language processing to extract insights and relationships from text, which is unrelated to generating personalized product recommendations. Option D (incorrect) Amazon Kendra is an intelligent enterprise search service that helps users find information across various data sources using natural language, not for creating personalized product recommendation engines.'
WHERE question_id = 'c3a00314-6cf6-4655-99b4-69ef30eb5ea1';

-- question_id: c3abe79f-0e6d-49c3-96a1-f34677fed8a1
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Publishing algorithm documentation and performance metrics fosters transparency and allows for independent scrutiny, aligning with AWS responsible AI best practices that leverage services like Amazon SageMaker for model lineage and AWS CloudWatch for monitoring comprehensive performance data, including explainability features of SageMaker Clarify. Option B (incorrect) Publishing nothing public directly undermines the goal of building public trust, as secrecy breeds suspicion, contrary to the transparency principles encouraged by robust AI/ML governance frameworks on AWS. Option C (incorrect) Publishing only successes creates a biased view and conceals potential failures or biases, eroding long-term trust and contradicting the comprehensive model monitoring and drift detection capabilities available through AWS services like Amazon SageMaker Model Monitor, which are designed for full disclosure. Option D (incorrect) Publishing random information offers no meaningful insight into the AI system, failing to address the need for informed public understanding and accountability, which is contrary to the structured logging, auditing, and performance data provided by AWS services like AWS CloudTrail and Amazon CloudWatch for governance and compliance.'
WHERE question_id = 'c3abe79f-0e6d-49c3-96a1-f34677fed8a1';

-- question_id: c3b1daae-a375-4412-915c-426fa18a6c4c
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deploying applications across multiple AWS Regions typically increases costs due to duplicated infrastructure and cross-region data transfer fees, not reduces them. Option B (correct) Deploying across multiple AWS Regions ensures geographical isolation, protecting against widespread outages and meeting stringent data residency and sovereignty compliance requirements. Option C (incorrect) Managing applications across multiple regions significantly increases operational complexity due to challenges in data synchronization, traffic routing, and consistent configuration management. Option D (incorrect) While deploying applications closer to global users across multiple regions can reduce latency and improve performance for those specific users, it is not the sole or primary reason, as disaster recovery and compliance are more fundamental drivers for multi-region architectures.'
WHERE question_id = 'c3b1daae-a375-4412-915c-426fa18a6c4c';

-- question_id: c3b5d61f-ac5c-4c31-95c4-706a0e692dce
-- answer_correct: True | verified_indices: [2] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) While prompt engineering with services like Amazon Bedrock is rapid for initial setup and avoids direct model training costs, achieving the desired level of unique personalization, consistent brand voice, and factual accuracy for a million distinct items would likely require very complex and lengthy prompts, leading to higher inference costs per item and potentially inconsistent output quality over such a large catalog, requiring more manual review. Option 1 (incorrect) Developing a custom neural network model from scratch using Amazon SageMaker would involve significant time, expertise, and cost for data collection, labeling, model architecture design, training, and optimization, directly contradicting the requirement for a solution without high cost and time investment for custom model training. Option 2 (correct) Fine-tuning a large foundation model (e.g., via Amazon Bedrock) on a custom dataset of existing product descriptions leverages the immense pre-trained knowledge of the foundation model while quickly adapting it to the specific style, tone, and nuances of the marketing team''s brand, providing highly personalized and consistent outputs more efficiently and cost-effectively than training from scratch or relying solely on complex prompt engineering for a million items. Option 3 (incorrect) A manually written template-based system, while potentially low-cost to develop initially, would struggle to generate truly unique and personalized descriptions, especially for a catalog of over a million items, as it inherently lacks the variability and creativity of generative AI, resulting in repetitive and generic content that fails to meet the "unique, personalized" requirement at scale.'
WHERE question_id = 'c3b5d61f-ac5c-4c31-95c4-706a0e692dce';

-- question_id: c40961e0-fc3e-423b-90a5-3eb350209a76
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EBS Multi-Attach provides block-level sharing requiring a complex clustered file system on top to manage concurrent read/write access and prevent data corruption, which is not an inherent feature of shared storage for general use. Option B (incorrect) EFS with Provisioned Throughput and Max I/O performance mode supports shared access but typically does not achieve 200,000 IOPS with the low latency and predictable performance demanded by high-performance scientific research applications. Option C (correct) FSx for Lustre is a high-performance parallel file system specifically designed for scientific computing and HPC workloads, offering sub-millisecond latencies, millions of IOPS, and scalable concurrent read/write access. Option D (incorrect) S3 is object storage, not a file system, and while it supports concurrent access, it does not provide the high IOPS, low latency, or POSIX file system semantics required for scientific research applications processing datasets.'
WHERE question_id = 'c40961e0-fc3e-423b-90a5-3eb350209a76';

-- question_id: c461b304-7854-44d9-96c9-e979ba1cc7c0
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) AWS Artifact provides on-demand access to AWS security and compliance documents, such as ISO certifications, PCI reports, and SOC reports, which customers can use to meet their own audit and regulatory requirements. Option B (incorrect) Amazon S3 is an object storage service used for storing and retrieving data, but it does not intrinsically provide compliance reports or certifications; it can store them, but does not generate or issue them from AWS. Option C (incorrect) AWS Lambda is a serverless compute service that runs code in response to events, and while it can be used to build custom compliance automation or reporting solutions, it does not provide pre-built compliance reports or certifications from AWS itself. Option D (incorrect) Amazon EC2 (Elastic Compute Cloud) provides resizable compute capacity in the cloud, allowing users to run virtual servers, but it is not a service designed to deliver compliance reports or certifications.'
WHERE question_id = 'c461b304-7854-44d9-96c9-e979ba1cc7c0';

-- question_id: c496a432-f059-4c01-aac5-d2e764a11bcd
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) While Amazon S3 is an excellent object storage service for static content, serving directly from S3 does not leverage a global Content Delivery Network (CDN) to cache content at edge locations, meaning users far from the S3 bucket''s region will still experience higher latency. Option B (correct) Amazon CloudFront is a global Content Delivery Network (CDN) that caches static content at edge locations worldwide, significantly reducing latency for users by serving content from the closest geographical point and offloading requests from the origin server (S3), which is the most effective strategy for global static content delivery. Option C (incorrect) Amazon ElastiCache for Redis is an in-memory data store used for caching dynamic data, database query results, or session state within the application''s region, making it unsuitable for globally distributing and caching large static files like images, CSS, or JavaScript. Option D (incorrect) Increasing EC2 instance network bandwidth and EBS volume size only improves the capacity of the origin servers in a specific region, but it does not address the fundamental need for global content distribution and edge caching to reduce latency for users worldwide.'
WHERE question_id = 'c496a432-f059-4c01-aac5-d2e764a11bcd';

-- question_id: c4c4d8a1-4cab-4475-b561-82d5a2ae54ca
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS recommends and provides robust features like S3 server-side encryption with KMS and TLS/SSL for securing data at rest and in transit for AI workloads, protecting sensitive training data, models, and inference data from unauthorized access. Option B (correct) AWS IAM enables granular Role-Based Access Control (RBAC) to define who can access and perform actions on AI resources such as Amazon SageMaker notebooks, training jobs, or S3 data buckets, enforcing the principle of least privilege. Option C (incorrect) Setting maximum model size limits is primarily a resource management or cost optimization strategy, not an essential security measure, as a small model can still harbor vulnerabilities or be used maliciously. Option D (incorrect) While AWS cloud storage (e.g., S3) offers robust security features, making cloud storage "mandatory" is not a security measure itself; rather, it''s the implementation of security features within that storage (like encryption and access controls) that provides protection, and AI workloads can technically use on-premise storage if properly secured. Option E (incorrect) Publicly exposing AI workload endpoints without strong authentication and authorization is a significant security risk, increasing the attack surface and potential for unauthorized access, data exfiltration, or model manipulation.'
WHERE question_id = 'c4c4d8a1-4cab-4475-b561-82d5a2ae54ca';

-- question_id: c4d0e0fa-9109-4b85-9159-3a92f299132f
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Cost reduction is a significant benefit of cloud computing by avoiding large capital expenditures, but it''s a consequence of not building local infrastructure rather than the direct enabler of launching globally without it. Option B (correct) Going global in minutes is a direct cloud benefit achieved by leveraging AWS''s global network of Regions and Availability Zones, allowing companies to deploy applications and services closer to new markets with a few clicks or API calls, eliminating the need for physical data centers. Option C (incorrect) Increased security is a major advantage of the cloud due to AWS''s robust security posture and services like IAM and KMS, but it''s not the specific benefit that facilitates launching products in new markets without physical infrastructure. Option D (incorrect) Better performance can be achieved in the cloud by deploying resources closer to users and utilizing services like Amazon CloudFront, but the ability to launch without local infrastructure is the foundational enabler, with performance being a potential outcome or goal.'
WHERE question_id = 'c4d0e0fa-9109-4b85-9159-3a92f299132f';

-- question_id: c4f8939d-5fb9-4968-b944-9f7997c92243
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS DMS is excellent for replicating change data capture (CDC) from transactional sources to Redshift, but it typically delivers raw changes or full loads and does not natively perform the complex merge, upsert, and delete logic within Redshift necessary to maintain dimension history like Type 2 SCD without additional processing. Option B (correct) The Redshift MERGE statement is specifically designed for efficiently applying incremental changes from a staging table to a target table, directly supporting the insertion of new records, modification of existing ones, and deletion of records, which is ideal for maintaining dimension history without full table reloads. Option C (incorrect) Redshift materialized views are designed to pre-compute and store the results of queries on existing Redshift tables for faster retrieval, not to manage and update a dimension table with complex history (e.g., Type 2 SCD) by integrating changes from external source systems. Option D (incorrect) While AWS Glue ETL jobs can implement custom logic for incremental updates, using Redshift''s native MERGE statement is generally more efficient and performant for operations that involve comparing and modifying large datasets directly within the Redshift cluster, minimizing data movement and leveraging its MPP architecture.'
WHERE question_id = 'c4f8939d-5fb9-4968-b944-9f7997c92243';

-- question_id: c579e1a6-73f0-4755-893a-ef7b323ad930
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon GuardDuty is a threat detection service that continuously monitors for malicious activity and unauthorized behavior within AWS accounts and workloads, rather than directly protecting web applications from common web exploits like SQL injection. Option B (correct) AWS WAF (Web Application Firewall) helps protect web applications or APIs from common web exploits that could affect availability, compromise security, or consume excessive resources, by allowing customers to create custom rules to filter malicious traffic. Option C (incorrect) AWS Shield is a managed Distributed Denial of Service (DDoS) protection service that safeguards applications running on AWS from network and transport layer attacks, with Shield Advanced offering additional protection against more sophisticated application layer DDoS attacks, but it does not specifically target common web exploits. Option D (incorrect) Amazon Inspector is an automated security assessment service that helps improve the security and compliance of applications deployed on AWS by identifying vulnerabilities and deviations from best practices, rather than actively protecting web applications from ongoing web exploits.'
WHERE question_id = 'c579e1a6-73f0-4755-893a-ef7b323ad930';

-- question_id: c57e6aae-fa16-4559-baed-767800bd9618
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon Comprehend is a natural language processing (NLP) service specifically designed to analyze text, extracting insights such as sentiment (positive, negative, neutral) and identifying entities (people, places, organizations, key phrases), which is perfect for processing feedback forms. Option B (incorrect) Real-time voice transcription is the primary function of Amazon Transcribe, a separate AWS service that converts speech into text. Option C (incorrect) Image recognition capabilities are provided by Amazon Rekognition, an AWS service focused on analyzing images and videos to identify objects, people, text, and activities. Option D (incorrect) Database management is handled by various AWS database services like Amazon RDS, Amazon DynamoDB, or Amazon Aurora, which are used for storing and querying structured and unstructured data.'
WHERE question_id = 'c57e6aae-fa16-4559-baed-767800bd9618';

-- question_id: c5863a3e-9b6b-4260-ae9d-3f521a540476
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) DynamoDB with DAX and Global Secondary Indexes provides a highly scalable NoSQL database with sub-millisecond read latency via DAX''s in-memory caching and supports strong consistency directly from DynamoDB for critical events, perfectly meeting the requirements for millions of concurrent players and real-time data access. Option B (incorrect) ElastiCache Redis, while offering ultra-low latency, is primarily an in-memory cache/data store and typically does not provide the robust persistence and strong consistency guarantees required for a primary database storing critical game event data without significant architectural overhead. Option C (incorrect) Aurora with read replicas and RDS Proxy, while performant for relational workloads, typically provides single-digit millisecond latency and may struggle to consistently achieve sub-millisecond reads at the scale of millions of concurrent players required by the application. Option D (incorrect) RDS with Provisioned IOPS and read replicas, despite offering improved I/O performance and availability, generally exhibits higher latency compared to Aurora or NoSQL solutions and cannot meet the demanding sub-millisecond read response times at scale.'
WHERE question_id = 'c5863a3e-9b6b-4260-ae9d-3f521a540476';

-- question_id: c5ce117e-de40-4af9-aed6-477c8c4765eb
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Durability refers to the long-term data protection and resilience, such as S3''s eleven nines of durability for object storage or EBS snapshots for volume backups, which does not address automatic resource scaling for varying loads. Option B (correct) Elasticity is the ability of a system to automatically scale computing resources up or down based on demand, exemplified by AWS Auto Scaling Groups for EC2 instances or the inherent automatic scaling of serverless services like AWS Lambda and DynamoDB, perfectly matching the need to adjust to varying student loads. Option C (incorrect) Security involves protecting cloud resources and data through services like AWS IAM for access control or Security Groups for network filtering, which is crucial but distinct from dynamically adjusting capacity based on demand. Option D (incorrect) Portability is the ability to move applications and data between different environments, such as migrating on-premises applications to AWS using containers with ECS or EKS, which is unrelated to automatically scaling resources based on fluctuating demand.'
WHERE question_id = 'c5ce117e-de40-4af9-aed6-477c8c4765eb';

-- question_id: c62ca01a-c620-4787-8430-359fa90ec21e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Faster processing speeds is an operational benefit of generative AI, often achieved using AWS services like Amazon SageMaker and high-performance EC2 instances with GPUs for distributed training and inference, not a legal risk. Option B (correct) Intellectual property infringement is a significant legal risk because generative AI models trained on vast datasets might generate outputs that resemble or reproduce copyrighted, patented, or trademarked material, and AWS customers are responsible for ensuring their use of models and generated content complies with IP laws, reflecting the shared responsibility model for AI governance. Option C (incorrect) Reduced storage costs is an economic benefit of leveraging cloud storage services like Amazon S3 or Amazon S3 Glacier for large AI datasets and models, not a legal risk. Option D (incorrect) Improved accuracy is a performance objective and desired outcome for generative AI models, often enhanced through fine-tuning on services like Amazon Bedrock or SageMaker, not a legal risk.'
WHERE question_id = 'c62ca01a-c620-4787-8430-359fa90ec21e';

-- question_id: c6dc7c46-ccf3-4f9b-9fa5-07dac90a8892
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudTrail is primarily used for auditing and logging API calls and user activity, not for real-time monitoring of resource performance metrics or triggering scaling actions based on thresholds. Option B (correct) Amazon CloudWatch is the service that collects monitoring data, creates alarms based on metrics like CPU utilization thresholds and durations, and integrates directly with Auto Scaling groups to trigger scaling policies. Option C (incorrect) Amazon S3 is an object storage service used for data storage and retrieval, and it does not provide functionality for monitoring EC2 performance or triggering auto-scaling actions. Option D (incorrect) AWS Config continuously monitors and records AWS resource configurations and evaluates them against desired rules, but it is not designed to trigger auto-scaling based on real-time operational performance metrics like CPU utilization.'
WHERE question_id = 'c6dc7c46-ccf3-4f9b-9fa5-07dac90a8892';

-- question_id: c72a9114-c9c6-4b14-9c92-0ce1570eb511
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) RDS Multi-AZ provides high availability within a single region and automated failover to a standby in a different AZ, but cross-region automated backups require manual restoration and configuration, which is slow and cannot meet the 15-minute RTO or 5-minute RPO for automatic cross-region failover. Option B (correct) Aurora Global Database provides fully managed, fast, and automatic cross-region failover capabilities with an RTO typically under 1 minute and RPO in seconds due to very low-latency asynchronous replication, easily meeting the specified RTO and RPO while maintaining strong data consistency for high transaction volumes. Option C (incorrect) DynamoDB Global Tables offer eventual consistency for cross-region replication, which does not satisfy the strict requirement to "maintain data consistency" for high-transaction workloads that typically demand strong consistency across regions for disaster recovery. Option D (incorrect) RDS with read replicas in another region requires manual promotion procedures and manual application endpoint updates during a disaster, failing to meet the automatic failover requirement and potentially exceeding the 5-minute RPO due to asynchronous replication lag variations.'
WHERE question_id = 'c72a9114-c9c6-4b14-9c92-0ce1570eb511';

-- question_id: c76fe103-c7eb-435c-a159-73bb8e3941e5
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While CloudTrail logs can show if CloudWatch attempted to publish to SNS, checking the SNS topic''s access policy and subscription status is a more common and direct first step to troubleshoot why messages are not being received by subscribers. Option B (correct) A CloudWatch alarm requires the necessary permissions within the SNS topic''s access policy to publish messages, and all intended recipients must have active, confirmed subscriptions to that SNS topic to receive notifications. Option C (incorrect) CloudWatch alarms are a service-level feature of AWS and operate independently of a CloudWatch agent, which is used for collecting custom metrics or logs from EC2 instances or on-premises servers. Option D (incorrect) Increasing the alarm threshold would make it harder for the alarm to transition into an ALARM state, which is relevant if the alarm is not triggering as expected, but not if notifications are missing after the alarm has already triggered.'
WHERE question_id = 'c76fe103-c7eb-435c-a159-73bb8e3941e5';

-- question_id: c78c5eb9-abda-47e8-b1d4-9d8d1117eb20
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) An Internet Gateway enables internet access for a VPC, allowing communication between the VPC and the public internet, not private connectivity directly between two VPCs. Option B (correct) VPC Peering creates a private, one-to-one network connection between two VPCs, enabling resources in each VPC to communicate using private IP addresses as if they were in the same network. Option C (incorrect) A NAT Gateway allows instances in a private subnet to initiate outbound connections to the internet or other AWS services while preventing unsolicited inbound connections, but it does not provide direct private connectivity between two VPCs. Option D (incorrect) An Elastic IP address is a static, public IPv4 address used to provide a persistent public endpoint for an EC2 instance or other AWS resources, and it does not facilitate private connectivity between two different VPCs.'
WHERE question_id = 'c78c5eb9-abda-47e8-b1d4-9d8d1117eb20';

-- question_id: c7cad7c1-2e8a-4cb8-bb97-868404ef184d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) IAM Policies define permissions for identities or resources within a single AWS account, but they are not an AWS Organizations feature for enforcing preventative controls across all accounts at an organizational level, as an account administrator could still define non-compliant IAM policies within their account unless constrained by an SCP. Option B (correct) Service Control Policies (SCPs) are an AWS Organizations feature that set the maximum available permissions for all IAM users and roles in member accounts, effectively acting as preventative guardrails to prevent the deployment of non-compliant resources across the entire organization. Option C (incorrect) Resource Access Manager (RAM) is used to share AWS resources securely across accounts within an organization, but it does not provide a mechanism for enforcing preventative security policies or preventing the deployment of non-compliant resources. Option D (incorrect) AWS Config Rules are detective controls that assess and audit resource configurations for compliance after they have been deployed, rather than preventing the initial deployment of non-compliant resources in a preventative manner across the organization.'
WHERE question_id = 'c7cad7c1-2e8a-4cb8-bb97-868404ef184d';

-- question_id: c7ea9c27-0957-4507-aad7-8a12ef7ec4a9
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) AWS Batch is primarily designed for batch computing workloads and is not natively optimized for handling real-time streaming data processing, even with mixed instance types and job queue management. Option B (incorrect) Kinesis Analytics with Lambda functions is highly effective for real-time streaming data processing and event-driven tasks, but it is not inherently designed to efficiently handle large-scale, long-running batch workloads taking minutes to hours within the same architectural context. Option C (correct) Amazon EMR is a managed cluster platform that can run big data frameworks like Apache Spark and Apache Flink, which natively support both streaming and batch processing, and its automatic scaling combined with Spot instance integration perfectly optimizes for variable workloads and cost efficiency. Option D (incorrect) ECS with Fargate Auto Scaling is a general-purpose container orchestration service that can run various applications, but it lacks the built-in, optimized big data frameworks and integrated capabilities of EMR for handling complex streaming and batch data processing pipelines at scale.'
WHERE question_id = 'c7ea9c27-0957-4507-aad7-8a12ef7ec4a9';

-- question_id: c81d78d5-2065-46a0-8afc-ca71ac600de8
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Building physical infrastructure is handled by AWS itself in its global infrastructure regions and Availability Zones, not by customers through prompt engineering, which leverages services like Amazon SageMaker for model deployment. Option B (correct) Designing effective inputs to guide model outputs is the core of prompt engineering, crucial when interacting with large language models (LLMs) available through AWS services like Amazon Bedrock to obtain desired responses from models such as Anthropic''s Claude or Amazon''s Titan. Option C (incorrect) Creating new programming languages is a highly specialized field unrelated to prompt engineering, which focuses on leveraging existing tools and models often deployed or accessed via services like Amazon Bedrock or Amazon SageMaker. Option D (incorrect) Managing cloud storage involves services like Amazon S3 for object storage, Amazon EBS for block storage, or Amazon EFS for file storage, which are distinct from prompt engineering''s focus on guiding AI model behavior.'
WHERE question_id = 'c81d78d5-2065-46a0-8afc-ca71ac600de8';

-- question_id: c8204a3c-08eb-4eef-b909-3075228be09b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Redshift Spectrum requires an active Amazon Redshift cluster to execute queries against data in S3, which incurs hourly costs for the cluster and does not meet the requirement of not requiring a persistent cluster for infrequent use. Option B (correct) Amazon Athena is a serverless query service that allows SQL queries directly on S3 data, incurring costs only for the data scanned by queries, and partitioning along with columnar format conversion are best practices that significantly reduce data scanned and thus minimize costs and improve performance for unpredictable, infrequent queries without a persistent cluster. Option C (incorrect) An Amazon EMR cluster, even with Presto for SQL queries, involves provisioning and managing EC2 instances, which constitutes a persistent cluster during query execution and is more costly and operationally complex than serverless options for infrequent ad-hoc queries. Option D (incorrect) AWS Glue Data Catalog is a metadata repository, and AWS Glue ETL jobs are primarily used for data transformation and processing, not for interactive ad-hoc SQL querying by users directly against S3 data, and they run on serverless Spark environments which still incur DPU-hour costs for processing.'
WHERE question_id = 'c8204a3c-08eb-4eef-b909-3075228be09b';

-- question_id: c84becf3-9ea4-490b-be78-79c227be8141
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (incorrect) Amazon RDS for MySQL is a relational database service that requires a predefined schema, which contradicts the requirement for a highly flexible, schema-less design. Option B (incorrect) Amazon Aurora PostgreSQL-Compatible Edition is a relational database service that, despite its high performance, still mandates a strict schema and is not optimized for the flexible, schema-less data models required for user profiles and activity feeds at extreme scale and low latency. Option C (correct) Amazon DynamoDB is a fully managed NoSQL database service specifically designed for applications requiring consistent single-digit millisecond latency at any scale, capable of handling millions of requests per second with a flexible, schema-less design, making it ideal for user profiles and activity feeds. Option D (incorrect) Amazon Redshift is a data warehouse service optimized for analytical queries over large datasets, not for high-throughput, low-latency transactional workloads or storing real-time operational data like individual user profiles and activity feeds.'
WHERE question_id = 'c84becf3-9ea4-490b-be78-79c227be8141';

-- question_id: c8939508-c813-4627-89aa-cb3625c005b5
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Transparency focuses on understanding an AI model''s decision-making process and its limitations, such as using Amazon SageMaker Clarify to generate explanations for predictions, rather than directly ensuring equitable treatment across all groups. Option B (correct) Fairness is the principle dedicated to ensuring AI models produce impartial outcomes and treat all groups equitably, which can be evaluated and mitigated using features like bias detection in Amazon SageMaker Clarify. Option C (incorrect) Privacy pertains to safeguarding sensitive personal data used by AI systems, utilizing AWS services like AWS Key Management Service (KMS) for encryption and adhering to data protection regulations, not the equitable treatment of different user groups. Option D (incorrect) Robustness addresses a model''s resilience to malicious attacks or unexpected variations in input data, maintaining its performance and reliability through practices like MLOps and model monitoring in Amazon SageMaker, not ensuring equitable outcomes for diverse groups.'
WHERE question_id = 'c8939508-c813-4627-89aa-cb3625c005b5';

-- question_id: c8bccc63-bd1c-4362-ab32-c85cf1d1cacb
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Standardized templates with structured variables ensures uniformity by guiding data input and output into predefined formats, similar to how AWS Glue workflows enforce schema for consistent data transformation or how Amazon Bedrock prompts can be engineered with specific XML/JSON structures to generate predictable responses for report generation. Option B (incorrect) Random prompting each time directly contradicts the need for uniformity and consistency, making it impossible to produce predictable report structures or utilize AWS services like Amazon QuickSight for consistent visualization of data. Option C (incorrect) No specific format for prompting would lead to highly inconsistent output, making it impossible to automate report processing or guarantee data integrity across different reports generated using AWS data analytics services. Option D (incorrect) Maximum creativity, while valuable in other contexts, actively works against the goal of uniformity and consistency in report generation, preventing the establishment of repeatable processes or standardized data schemas required by services like Amazon Redshift.'
WHERE question_id = 'c8bccc63-bd1c-4362-ab32-c85cf1d1cacb';

-- question_id: c8ca0fc1-ecc9-4c5b-bf32-29e464be4183
-- answer_correct: True | verified_indices: [0, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS Glue DataBrew is purpose-built for visual data preparation and quality, allowing users to define data quality rules (e.g., validity, completeness, consistency, uniqueness) and then apply recipes to cleanse, transform, and split datasets into valid and invalid outputs. Option B (incorrect) While an AWS Lambda function can implement custom validation logic and route records, it requires writing and maintaining all the validation code from scratch and lacks the built-in data profiling and rule-based data quality features of more specialized services like Glue DataBrew or Glue ETL. Option C (correct) An AWS Glue ETL job (using Apache Spark or Python shell) provides a robust framework to implement complex custom validation logic, apply conditional transformations to identify invalid records, handle errors by directing them to a separate path or S3 prefix, and continue processing valid data, effectively quarantining bad data. Option D (incorrect) Amazon Kinesis Data Firehose with Lambda transformation is primarily designed for real-time streaming data ingestion and light transformations, making it less suitable for comprehensive batch data quality checks, historical duplicate detection against a larger dataset, or complex data consistency validations described in the question. Option E (incorrect) Creating SQL views in Amazon Athena with WHERE clauses only filters data at query time, meaning the invalid data still resides within the original dataset; it does not physically segregate or "quarantine" invalid records into a separate location for manual review or allow valid data to proceed through a separate processing path.'
WHERE question_id = 'c8ca0fc1-ecc9-4c5b-bf32-29e464be4183';

-- question_id: c92a66ca-aff5-4475-b8f0-4da33923e5fa
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Glacier Deep Archive is designed for long-term archival storage with the lowest costs but features the longest retrieval times (hours) and high retrieval fees, making it unsuitable for frequently accessed data requiring immediate access. Option B (incorrect) S3 Standard-Infrequent Access (S3 Standard-IA) is optimized for data accessed less frequently but requiring rapid access when needed, incurring a retrieval fee per GB, which makes it less cost-effective for frequently accessed data. Option C (correct) Amazon S3 Standard is specifically designed for general-purpose storage of frequently accessed data, providing high durability, high availability, and immediate access without retrieval fees, directly matching the question''s requirements. Option D (incorrect) S3 One Zone-Infrequent Access (S3 One Zone-IA) is for infrequently accessed, re-creatable data stored within a single Availability Zone, offering lower cost than S3 Standard-IA but without multi-AZ resilience and incurring retrieval fees, thus not suitable for frequently accessed data requiring multi-AZ high availability.'
WHERE question_id = 'c92a66ca-aff5-4475-b8f0-4da33923e5fa';

-- question_id: c959619b-f921-4396-9e8c-763e5b95f56c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS is not responsible for everything as the customer still retains responsibility for security configuration and data within their AI/ML workloads, such as IAM policies for Sagemaker access or encryption of data in S3. Option B (incorrect) The customer is not responsible for everything because AWS manages the underlying infrastructure, including the physical security of data centers and the global network that hosts AI/ML services like Amazon Sagemaker. Option C (correct) AWS manages the security of the underlying infrastructure, such as the hardware, software, networking, and facilities for AI/ML services, while the customer is responsible for the security in the cloud, including their training data, ML models, Sagemaker endpoint configurations, and IAM permissions. Option D (incorrect) Both AWS and the customer have distinct and critical responsibilities for security within the Shared Responsibility Model, ensuring a comprehensive approach to protecting AI/ML workloads.'
WHERE question_id = 'c959619b-f921-4396-9e8c-763e5b95f56c';

-- question_id: c9f23ff6-27bc-4335-b687-c37cccf33111
-- answer_correct: False | verified_indices: [1, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1, 2}'::integer[],
    explanation = 'Option A (incorrect) The Developer support plan offers technical support via email for general guidance and system impaired issues but does not include access to the AWS Support API for programmatic case management. Option B (correct) The Business support plan includes full access to the AWS Support API, allowing customers to programmatically create, manage, and retrieve information about support cases for automated operations. Option C (correct) The Enterprise support plan, being the highest tier, provides all features of the Business plan, which inherently includes full access to the AWS Support API for advanced automated case management. Option D (incorrect) Not all plans include access to the AWS Support API; specifically, the Basic and Developer plans do not offer this feature, which is reserved for Business and Enterprise support tiers.'
WHERE question_id = 'c9f23ff6-27bc-4335-b687-c37cccf33111';

-- question_id: c9fab98a-b2c3-4b2d-92b2-0fa48c44cde1
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Including conversation history in prompts is a fundamental pattern used by AWS services like Amazon Lex V2 and large language models (LLMs) integrated via Amazon Bedrock to provide the conversational AI with the necessary context from previous turns to understand follow-up questions and generate contextually relevant responses. Option B (incorrect) Ignoring previous messages would result in a stateless conversation where each turn is treated in isolation, making it impossible for AWS conversational AI services to understand multi-turn dialogues, track intent fulfillment, or maintain user preferences. Option C (incorrect) Resetting after each turn effectively discards all accumulated context or session attributes, preventing AWS services like Amazon Lex from tracking slot values, intent state, or historical dialogue, which is essential for successful multi-turn interactions. Option D (incorrect) Using random responses is a nonsensical approach that offers no method for maintaining conversation context and would lead to irrelevant and frustrating interactions, completely defeating the purpose of sophisticated AWS conversational AI systems designed for goal-oriented dialogues.'
WHERE question_id = 'c9fab98a-b2c3-4b2d-92b2-0fa48c44cde1';

-- question_id: ca7411a9-6742-4a79-896c-e0715f5c62b5
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using the root account for all tasks grants an attacker unrestricted access to all AWS services and resources if compromised, maximizing the impact rather than reducing it, which contradicts AWS security best practices that recommend using the root account only for initial setup and highly sensitive administrative tasks. Option B (correct) Implementing the principle of least privilege ensures that even if credentials are compromised, an attacker can only access and manipulate the specific AWS resources and actions explicitly permitted to that user or role through IAM policies, thereby significantly limiting the potential damage. Option C (incorrect) Sharing credentials among team members eliminates individual accountability, makes it impossible to trace actions back to a specific user, and increases the attack surface for credential compromise, directly violating AWS IAM best practices for unique user accounts and strong authentication. Option D (incorrect) Disabling all monitoring, such as AWS CloudTrail for API activity or Amazon GuardDuty for threat detection, would prevent the organization from detecting the unauthorized use of compromised credentials or suspicious activities within their AWS environment, allowing an attacker to operate undetected and exacerbate the impact.'
WHERE question_id = 'ca7411a9-6742-4a79-896c-e0715f5c62b5';

-- question_id: ca87cecb-2200-4b25-9b5e-8b85ccafaa8a
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deploying resources across multiple Availability Zones typically increases costs due to the need for redundant resources and inter-AZ data transfer fees, rather than reducing them. Option B (correct) Availability Zones are distinct physical locations within an AWS Region, isolated from failures in other AZs, enabling services like Multi-AZ RDS deployments, Auto Scaling Groups, and Elastic Load Balancers to maintain continuous operation during an outage in a single AZ. Option C (incorrect) While deploying a highly available architecture across multiple Availability Zones can introduce architectural considerations, the explicit purpose of AZs is not to increase complexity but to provide resilience and reliability. Option D (incorrect) Availability Zones are designed to facilitate the distribution and accessibility of services within a Region, not to limit service access, which is typically controlled by AWS Identity and Access Management (IAM) policies or network configurations like Security Groups.'
WHERE question_id = 'ca87cecb-2200-4b25-9b5e-8b85ccafaa8a';

-- question_id: ca9d2cd3-6bbc-40e9-9726-073ab1f371bd
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) RLHF is an advanced fine-tuning technique that adds steps to the model development lifecycle, and while it requires additional computational resources and time on services like Amazon SageMaker, its purpose is not to intentionally slow down training. Option 1 (correct) RLHF is a critical method for post-training alignment of large language models (LLMs), using human rankings of model outputs to train a reward model which then guides a reinforcement learning agent to refine the LLM''s behavior to be more helpful, harmless, and honest, a process often applied to models deployed via Amazon Bedrock or fine-tuned on Amazon SageMaker. Option 2 (incorrect) RLHF is not a data compression technique, which focuses on reducing the size of data files or streams for efficient storage and transmission, a function distinct from model alignment and typically handled by storage services like Amazon S3 or data transfer mechanisms. Option 3 (incorrect) RLHF is a computationally intensive process that involves training multiple models and requires significant GPU resources on services like Amazon EC2 or Amazon SageMaker, thereby adding to development costs rather than reducing them, although it aims to improve model quality and user satisfaction.'
WHERE question_id = 'ca9d2cd3-6bbc-40e9-9726-073ab1f371bd';

-- question_id: cb2dd014-36e7-4784-904b-ab852b3a27d9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Manual configuration involves manually provisioning resources through the AWS Management Console or ad-hoc AWS CLI commands, which lacks version control, reproducibility, and scalability, making it difficult to define and deploy infrastructure as code. Option B (correct) Infrastructure as Code (IaC) defines and provisions infrastructure resources like EC2 instances or S3 buckets using definition files (e.g., AWS CloudFormation templates or AWS CDK constructs) that are version-controlled and automatable. Option C (incorrect) GUI-only management, utilizing the AWS Management Console, is a form of manual configuration that does not involve writing code to define and deploy infrastructure, leading to inconsistent environments and slower deployments. Option D (incorrect) While AWS CLI commands can be scripted, "CLI commands only" typically refers to imperative scripts that perform actions rather than declaratively defining the desired state of the entire infrastructure in a version-controlled code repository, which is a hallmark of IaC.'
WHERE question_id = 'cb2dd014-36e7-4784-904b-ab852b3a27d9';

-- question_id: cc26bc26-8bed-475a-bfd3-d4146db7b8b4
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config continuously monitors and records resource configurations for compliance and auditing, but it does not use machine learning for threat detection. Option B (incorrect) AWS CloudTrail provides a history of API calls and events for auditing and governance, but it does not employ machine learning to proactively detect threats. Option C (correct) Amazon GuardDuty is a threat detection service that specifically uses machine learning, anomaly detection, and integrated threat intelligence to identify and alert on potential security threats. Option D (incorrect) AWS Identity and Access Management (IAM) is a service for managing user identities and their permissions to AWS resources, not for machine learning-driven threat detection.'
WHERE question_id = 'cc26bc26-8bed-475a-bfd3-d4146db7b8b4';

-- question_id: cc77c394-1bec-4148-b8c1-9d7544cab36d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Systems Manager Parameter Store SecureString parameters provide encryption but lack built-in automatic secret rotation, which would require a custom solution. Option B (correct) AWS Secrets Manager natively supports automatic secret rotation, stores secrets encrypted, and allows applications to retrieve the latest values at runtime via API calls without requiring a restart. Option C (incorrect) Encrypting environment variables directly with AWS KMS is not a standard secret management practice and this option explicitly states manual rotation, failing the automatic rotation requirement. Option D (incorrect) Storing secrets in an encrypted S3 bucket would be a complex custom solution for rotation and distribution, and retrieving updated secrets on EC2 instances without a restart is not a native or simple feature of S3.'
WHERE question_id = 'cc77c394-1bec-4148-b8c1-9d7544cab36d';

-- question_id: cca6a928-7487-430a-a3ac-4b8b85bb39b4
-- answer_correct: True | verified_indices: [3] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Global tables inherently provide eventual consistency across regions, meaning write operations are asynchronously replicated and "last writer wins" conflict resolution does not guarantee strong consistency for reads immediately after a write in a different region. Option 1 (incorrect) DynamoDB transactions ensure ACID properties only within a single AWS region and account, and do not extend strong consistency guarantees or atomic commits across global tables in multiple regions. Option 2 (incorrect) DynamoDB Accelerator (DAX) is an in-memory cache designed to improve read performance for eventually consistent data and does not provide features for implementing strong consistency or cross-region locking for write operations. Option 3 (correct) Using conditional writes with version numbers implements optimistic locking, which ensures that an update to an item succeeds only if its current version matches an expected value, thereby preventing lost updates from concurrent writes across different regions and maintaining logical consistency for write operations.'
WHERE question_id = 'cca6a928-7487-430a-a3ac-4b8b85bb39b4';

-- question_id: ccff876f-bb2a-4d61-b675-426dc69ce8de
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Model parallelism specifically involves distributing different layers or parts of a large deep learning model across multiple GPUs or compute instances, allowing models too large for a single device to be trained or run, which is often facilitated on AWS by using multi-GPU EC2 instances like p4d.24xlarge or SageMaker Distributed Training. Option B (incorrect) Using one device only negates the concept of parallelism, as model parallelism by definition requires partitioning the model across multiple computational units to handle its scale, rather than confining it to a single resource. Option C (incorrect) While data flows sequentially through the distributed layers in model parallelism, the distribution of the model itself across devices is a form of parallelization, and this option incorrectly implies a lack of concurrent processing benefits across different parts of the model. Option D (incorrect) Model parallelism is fundamentally a strategy for parallelizing the processing of extremely large deep learning models, enabling scale-out training and inference on AWS services like SageMaker that support distributed architectures for computational efficiency.'
WHERE question_id = 'ccff876f-bb2a-4d61-b675-426dc69ce8de';

-- question_id: cd26dc7a-bdec-440b-b654-1f3681f1a090
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Content moderation in generative AI is primarily designed to identify and filter out content that is inappropriate, harmful, unsafe, or violates policy guidelines, a capability directly supported by AWS services such as Amazon Rekognition for image/video moderation, Amazon Comprehend for text analysis, and Bedrock''s guardrails which can be configured to detect and prevent generation of harmful content across various categories. Option B (incorrect) Content moderation processes, whether applied before, during, or after content generation, add computational overhead and introduce additional steps, which inherently increases processing time rather than increasing generation speed. Option C (incorrect) Content moderation involves using dedicated services and computational resources to analyze and filter generated content, which incurs additional costs based on usage (e.g., API calls, data processed) rather than reducing them. Option D (incorrect) Content moderation focuses on ensuring the safety and appropriateness of the generated output by filtering undesirable content, not on improving the factual correctness, relevance, or quality of the model''s response to a given prompt.'
WHERE question_id = 'cd26dc7a-bdec-440b-b654-1f3681f1a090';

-- question_id: cd297748-e0f2-4433-a5db-b3ba2833ff7c
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS operates on a pay-as-you-go model, and while a free tier exists for certain services, generative AI applications typically consume extensive and specialized resources like GPU-accelerated Amazon EC2 instances (e.g., P3, P4) or large-scale Amazon SageMaker instances which incur significant costs beyond free tier limits. Option B (correct) AWS provides a robust shared responsibility model with extensive built-in security services such as AWS Identity and Access Management (IAM), Amazon VPC for network isolation, AWS Key Management Service (KMS) for data encryption, AWS GuardDuty for threat detection, and numerous compliance certifications (e.g., SOC 2, HIPAA, ISO) vital for protecting sensitive data and intellectual property in AI workloads. Option C (incorrect) AWS is a cloud platform that inherently requires an internet connection or dedicated network links like AWS Direct Connect or AWS VPN to access its services and manage resources; while applications can run within a private Amazon VPC, interaction with the cloud environment typically requires network connectivity. Option D (incorrect) While AWS offers developer tools like AWS CodeWhisperer to assist with code generation, the primary benefit of the AWS infrastructure itself for generative AI is not automatic code writing, but rather providing the scalable, secure, and performant environments necessary for training, deploying, and inferring with complex AI models.'
WHERE question_id = 'cd297748-e0f2-4433-a5db-b3ba2833ff7c';

-- question_id: cd9809d1-6b1d-43a3-97b2-2753adac1cd4
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Glue Data Catalog is AWS''s serverless metadata repository that stores schema definitions for data in S3, while Athena is a serverless interactive query service that uses SQL to query data directly from S3 based on those schemas, effectively enabling schema-on-read for both structured and semi-structured data. Option B (incorrect) Redshift Spectrum allows querying S3 data using SQL but it consumes schema definitions from an external catalog like Glue Data Catalog or a Hive metastore, rather than being the primary catalog solution itself for a general data lake. Option C (incorrect) EMR with Hive metastore and Presto can technically query diverse data in S3 with SQL and schema-on-read, but it requires managing clusters, which is less efficient and more complex than the serverless Glue/Athena combination for interactive queries. Option D (incorrect) Lake Formation provides security and governance for data lakes by controlling access to data and its metadata in the Glue Data Catalog, but it is not the catalog solution itself, and QuickSight is a visualization tool, not the primary query engine for raw data.'
WHERE question_id = 'cd9809d1-6b1d-43a3-97b2-2753adac1cd4';

-- question_id: cdc43863-cd2d-4568-b621-4d55ea2cbaf4
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Serverless architectures, utilizing services like AWS Lambda, aim to simplify the operational aspects of applications by abstracting away server management, allowing developers to focus more on business logic rather than the underlying infrastructure complexity. Option B (correct) Serverless fundamentally changes architecture by eliminating the need for infrastructure management, as AWS services such as Lambda, API Gateway, and S3 automatically provision and manage underlying resources, while also providing inherent automatic scaling based on demand without manual intervention. Option C (incorrect) Serverless design patterns abstract away the concept of individual servers from the developer; while physical servers still exist within AWS data centers, the user does not provision, manage, or interact with them directly, fundamentally reducing server-centric thinking. Option D (incorrect) Serverless architectures, leveraging services like Amazon DynamoDB or AWS Fargate, significantly reduce operational overhead by offloading undifferentiated heavy lifting such as server provisioning, patching, maintenance, and scaling to AWS, freeing up teams to innovate.'
WHERE question_id = 'cdc43863-cd2d-4568-b621-4d55ea2cbaf4';

-- question_id: ce146252-5355-4606-9b66-f6965833e770
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) RDS is not necessarily cheaper than running a database on EC2, as costs vary greatly based on specific configuration, scale, and the value of managed services versus self-management. Option B (correct) RDS is fully managed by AWS, which handles database administration tasks like patching, backups, replication, and failover, allowing users to focus on application development rather than operational overhead. Option C (incorrect) EC2 databases are not inherently faster; performance for both RDS and EC2 depends on chosen instance types, storage configurations like EBS volume types, and database tuning, with RDS often providing optimized and high-performance options like Amazon Aurora. Option D (incorrect) RDS does not have a "limited" number of database engines, as it supports a wide array of popular relational databases including MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, and Amazon Aurora, catering to most common enterprise requirements.'
WHERE question_id = 'ce146252-5355-4606-9b66-f6965833e770';

-- question_id: ce7d70ba-e725-4420-a833-2176ad1cd9fb
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) Employing few-shot prompting with clear instructions and examples is a highly effective prompt engineering technique within Amazon Bedrock to guide the model towards specific output formats, tones, and structures, directly addressing inconsistency and reducing the need for manual post-generation editing. Option B (incorrect) Using zero-shot prompting relies solely on the model''s inherent capabilities without specific guidance, which the problem statement indicates is already failing to produce consistent, on-brand content and would likely perpetuate the existing issues. Option C (incorrect) Implementing a generic system prompt like ''Act as a marketing copywriter'' without further detailed guidance on tone, structure, and brand specifics would be insufficient to solve the consistency and brand alignment problems, still leading to significant manual editing. Option D (incorrect) Continuously increasing the model''s temperature parameter would encourage more diverse, creative, and therefore less consistent outputs, directly contradicting the goal of achieving specific tone, structure, and adherence to brand guidelines, and would likely increase manual editing.'
WHERE question_id = 'ce7d70ba-e725-4420-a833-2176ad1cd9fb';

-- question_id: cebf01e2-3d40-41ff-bb0c-a4b72edab658
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Autoregressive models generate text token by token, sequentially conditioning on all previously generated tokens, meaning the total inference time for a response scales linearly with its length, which can be slow, impacting real-time applications deployed on Amazon SageMaker Endpoints where latency is critical. Option B (incorrect) No language model, including autoregressive ones, possesses perfect accuracy; they are probabilistic predictors and can still generate incorrect, inconsistent, or hallucinated information, even advanced models available through Amazon Bedrock. Option C (incorrect) All language models have a finite context window or token limit, meaning they can only consider a specific amount of past text (input prompt plus generated output) when making predictions, and exceeding this limit, common with models deployed via Amazon SageMaker, results in truncation or a loss of coherence. Option D (incorrect) Autoregressive models are not infinitely fast; their sequential generation process inherently imposes a performance limit, and while AWS provides powerful compute resources like GPU instances on Amazon EC2 or SageMaker, the time taken for inference scales with the output length and model complexity.'
WHERE question_id = 'cebf01e2-3d40-41ff-bb0c-a4b72edab658';

-- question_id: cf08ee8e-f21d-4c70-afd9-0971ffce1436
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Public cloud, despite offering robust security services and compliance certifications, operates on a shared responsibility model where AWS secures the underlying infrastructure (security *of* the cloud) but customers are responsible for securing their data, applications, and configurations (security *in* the cloud), inherently providing less direct control over the physical infrastructure compared to a private deployment. Option B (correct) Private cloud provides the highest level of security and control because the organization owns, manages, and maintains the entire infrastructure stack, including physical hardware, network, and operating systems (e.g., on-premises data centers or dedicated environments like those extended by AWS Outposts), allowing for maximum customization of security policies, strict isolation, and compliance with specific regulatory requirements. Option C (incorrect) Hybrid cloud combines elements of both public (like AWS) and private clouds, meaning that while parts of the environment offer high control, the public cloud components still adhere to the shared responsibility model, resulting in a blended level of security and control rather than the absolute highest. Option D (incorrect) Multi-cloud involves using multiple public cloud providers (e.g., AWS and Azure), which increases operational complexity for security management, identity and access control across disparate platforms, and consistent policy enforcement, thereby not offering the highest unified level of security or control.'
WHERE question_id = 'cf08ee8e-f21d-4c70-afd9-0971ffce1436';

-- question_id: cf19d400-1467-4063-910d-f2d1864cfa98
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Enabling CloudTrail logging has a negligible impact on the system performance of AWS services because CloudTrail operates asynchronously and is designed to capture API calls without interfering with service operations. Option B (correct) Comprehensive CloudTrail logging captures a complete audit trail of API activity, including management events and optionally data events, providing detailed records of actions taken within your AWS account. Option C (incorrect) CloudTrail logging enhances security posture by providing visibility into account activity, which aids in detecting unauthorized actions and identifying potential security incidents, rather than increasing vulnerabilities. Option D (incorrect) CloudTrail is a foundational service for achieving and demonstrating compliance with various regulatory standards by providing an immutable record of actions performed in an AWS account, thereby enhancing compliance capabilities.'
WHERE question_id = 'cf19d400-1467-4063-910d-f2d1864cfa98';

-- question_id: cffde8e0-3f3e-4fbe-9f16-9b4e27e2634d
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) CloudTrail''s primary function is to record API calls made to AWS services, including those from the console, SDKs, CLI, and other services, making this information a core component of its logs. Option B (incorrect) User login activities, such as successful or failed console sign-ins, are captured by CloudTrail as specific management events, providing an audit trail for access to the AWS account. Option C (correct) CloudTrail does not log application-level information, such as logs generated by the code running within an EC2 instance, Lambda function, or container; services like Amazon CloudWatch Logs or direct application logging to S3 are used for this purpose. Option D (incorrect) Any change to AWS resources, such as creating an EC2 instance or modifying an S3 bucket, is performed via an AWS API call, and CloudTrail logs these API calls, thereby tracking resource changes.'
WHERE question_id = 'cffde8e0-3f3e-4fbe-9f16-9b4e27e2634d';

-- question_id: d02a064b-cf34-4851-abaa-864d930911a0
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The database name is a logical identifier within RDS and does not contribute to the underlying compute, storage, or I/O resources that dictate pricing. Option B (correct) The database engine choice significantly impacts licensing and operational costs (e.g., Aurora vs. SQL Server), while the instance size (e.g., db.m5.large) directly determines the allocated CPU, memory, and network performance, which are primary components of RDS billing. Option C (incorrect) The number of users accessing a database is not a direct pricing factor for Amazon RDS; instead, it is the resource consumption (CPU, memory, I/O) generated by user activity that contributes to the overall cost. Option D (incorrect) Application complexity is a subjective measure of software design and does not serve as a direct pricing metric for AWS RDS, although highly complex or inefficient applications might indirectly lead to higher resource utilization and thus increased costs.'
WHERE question_id = 'd02a064b-cf34-4851-abaa-864d930911a0';

-- question_id: d06744fb-00dc-4591-9e96-5f966de2e6cd
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deploying an RDS instance in a single Availability Zone means it will be unavailable during an AZ outage, and restoring from S3 backups is a manual process for disaster recovery, not automatic high availability with minimal downtime. Option B (correct) Configuring an RDS instance as a Multi-AZ deployment automatically provisions a synchronous standby replica in a different Availability Zone and performs an automatic failover during an AZ outage, ensuring continuous availability with minimal downtime. Option C (incorrect) Amazon S3 is an object storage service and is not designed to function as a primary relational database for applications requiring transactional database capabilities. Option D (incorrect) Manually creating a read replica in a different Region and promoting it is a strategy for cross-region disaster recovery, not for automatic high availability within a single region during an Availability Zone outage, and involves manual intervention and potential data loss.'
WHERE question_id = 'd06744fb-00dc-4591-9e96-5f966de2e6cd';

-- question_id: d06753f4-e072-4851-a0d5-5803afde31dc
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Inspector is an automated security assessment service that helps improve the security and compliance of applications deployed on AWS by identifying vulnerabilities and deviations from best practices, not AI bias. Option B (correct) Amazon SageMaker Clarify is specifically designed to help detect potential bias in machine learning models and data, as well as provide explainability for model predictions, directly addressing the need for trust in AI through bias detection. Option C (incorrect) AWS Trusted Advisor is an online tool that provides real-time guidance to help you provision your resources following AWS best practices in areas like cost optimization, performance, and security, but does not address AI bias detection. Option D (incorrect) Amazon Detective is a security service that helps investigate security findings or suspicious activities by automatically collecting log data and using machine learning to analyze events, rather than detecting AI model bias.'
WHERE question_id = 'd06753f4-e072-4851-a0d5-5803afde31dc';

-- question_id: d105cb7d-ccfe-46b3-9378-0a7ca0349a20
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) PCI DSS is a compliance standard designed to protect credit card holder data, not specifically healthcare data, though AWS services like Amazon EC2 and Amazon S3 can be configured by customers to process payment information in a PCI DSS compliant manner. Option B (incorrect) GDPR is a broad regulation for general data protection and privacy for individuals in the EU/EEA, encompassing health data but not exclusively designed for it, whereas AWS provides features like data residency controls and encryption using AWS KMS to aid in GDPR compliance. Option C (correct) HIPAA is the specific US compliance standard designed to protect sensitive patient health information (PHI), with AWS offering a Business Associate Addendum (BAA) for eligible services like Amazon S3, Amazon EC2, and Amazon RDS, allowing customers to process PHI securely. Option D (incorrect) SOX is a US federal law primarily focused on financial record keeping and reporting for public companies to prevent accounting fraud, not on the protection of patient health data, though AWS services like AWS CloudTrail and Amazon S3 can assist in maintaining SOX-compliant financial records.'
WHERE question_id = 'd105cb7d-ccfe-46b3-9378-0a7ca0349a20';

-- question_id: d2203584-49e8-45f9-9ac5-8d3af4f616b4
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option [0] (incorrect) AWS CDK ultimately synthesizes into CloudFormation templates, meaning the same AWS resources are provisioned with the same cost implications, therefore it does not inherently lower costs compared to raw CloudFormation. Option [1] (correct) AWS CDK allows developers to define cloud infrastructure using familiar programming languages like Python, TypeScript, Java, and C#, abstracting away the verbose JSON or YAML syntax of raw CloudFormation templates. Option [2] (incorrect) AWS CDK synthesizes to CloudFormation templates, and the actual deployment speed is governed by CloudFormation''s provisioning process, which is not made faster by using CDK for definition. Option [3] (incorrect) Security is determined by the configuration of the AWS resources defined, such as IAM policies and security groups, which can be defined securely or insecurely using either AWS CDK or raw CloudFormation.'
WHERE question_id = 'd2203584-49e8-45f9-9ac5-8d3af4f616b4';

-- question_id: d258b679-7582-4eb2-ba33-c583735d6edb
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Cost Optimization focuses on achieving business value by managing resources efficiently and minimizing expenses, for example, by utilizing Amazon S3 Intelligent-Tiering or Reserved Instances, rather than primarily reducing operational burden through automation. Option B (correct) Operational Excellence emphasizes automating operations and procedures, defining infrastructure as code with services like AWS CloudFormation, and continually improving processes to reduce manual effort and operational burden. Option C (incorrect) Security focuses on protecting data and systems, implementing detective controls, and automating security responses with services like AWS GuardDuty and Security Hub, where automation serves to enhance protection rather than primarily reduce operational burden. Option D (incorrect) Reliability focuses on ensuring a workload performs its intended function consistently, automatically recovering from failures using solutions like Auto Scaling Groups and Multi-AZ deployments, and scaling resources to meet demand, which aims for availability and resilience rather than direct reduction of operational burden.'
WHERE question_id = 'd258b679-7582-4eb2-ba33-c583735d6edb';

-- question_id: d2a8b1c5-15d1-4f35-adc8-9b431bc5710d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Standard is designed for frequently accessed data, offering the lowest latency and highest throughput, but it is not the most cost-effective for data accessed infrequently due to its higher storage costs compared to other options. Option B (correct) S3 Standard-IA is specifically designed for long-lived, infrequently accessed data that requires rapid access when needed, offering lower storage costs than S3 Standard while still providing millisecond retrieval times. Option C (incorrect) S3 Glacier is designed for archival data with retrieval times ranging from minutes to hours, which does not meet the requirement for rapid access when needed. Option D (incorrect) S3 Glacier Deep Archive is for long-term archiving with the lowest storage costs but has retrieval times ranging from hours to days, making it unsuitable for data requiring rapid access.'
WHERE question_id = 'd2a8b1c5-15d1-4f35-adc8-9b431bc5710d';

-- question_id: d48be158-f753-4d6f-a2fc-b5f6c5741a3e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Lex is a service for building conversational interfaces like chatbots and voice assistants, utilizing Automatic Speech Recognition and Natural Language Understanding (NLU), which is a component of NLP, but it is not a general-purpose natural language processing service for text analysis. Option B (correct) Amazon Comprehend is a dedicated natural language processing (NLP) service that uses machine learning to find insights and relationships in text, offering capabilities such as sentiment analysis, entity recognition, and keyphrase extraction. Option C (incorrect) Amazon Polly is a Text-to-Speech (TTS) service that synthesizes human-like speech from text, rather than performing natural language processing to extract meaning or insights from text. Option D (incorrect) Amazon Transcribe is an Automatic Speech Recognition (ASR) service that converts spoken audio into text, which can then be used as input for NLP services, but it does not perform the natural language processing itself.'
WHERE question_id = 'd48be158-f753-4d6f-a2fc-b5f6c5741a3e';

-- question_id: d4a08d2f-36de-41a2-9104-0e91339d474b
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudFormation is an Infrastructure as Code service primarily used for provisioning and managing AWS resources, not for automating post-provisioning operational tasks like patching EC2 instances or managing runbooks. Option B (correct) AWS Systems Manager is specifically designed for operational insights and actions, including its Patch Manager feature to automate OS and application patching and its Automation capability for creating and executing runbooks across EC2 instances. Option C (incorrect) AWS Lambda is a serverless compute service used to run code in response to events and while it can be used to trigger or integrate with automation, it is not the primary service for managing the patching process or hosting operational runbooks itself. Option D (incorrect) Amazon S3 is an object storage service used for data storage, backup, and static website hosting, and it does not provide capabilities for automating EC2 instance patching or managing operational runbooks.'
WHERE question_id = 'd4a08d2f-36de-41a2-9104-0e91339d474b';

-- question_id: d4d07cbd-9e69-4b95-8ba0-09b9764587f6
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Large-scale pre-training on diverse data enables few-shot learning in foundation models by allowing them to learn a vast amount of general knowledge and representations from diverse sources, which they can then leverage and quickly adapt to new tasks with minimal examples, similar to how Amazon Bedrock provides access to large pre-trained models like Amazon Titan. Option B (incorrect) Small datasets are used *in* few-shot learning for adaptation, but they are not the *enabling factor*; a foundation model''s ability to perform few-shot learning stems from its initial large-scale pre-training, not from being trained exclusively on small datasets. Option C (incorrect) No pre-training would result in a randomly initialized model that lacks any learned representations and would require extensive data to learn even a single task, making few-shot learning impossible due to the absence of prior knowledge that is fundamental to AWS''s approach to large language models. Option D (incorrect) Foundation models are characterized by their *large* number of parameters, not limited parameters; these extensive parameters are crucial for capturing the complex patterns and generalized knowledge from pre-training data that underpins few-shot learning, differentiating them from smaller, task-specific models often deployed via Amazon SageMaker Endpoints without such broad capabilities.'
WHERE question_id = 'd4d07cbd-9e69-4b95-8ba0-09b9764587f6';

-- question_id: d6455d3d-0281-4ef6-a565-fc01ecba2d80
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Implementing data encryption with separate decryption permissions for analysts typically applies to data at rest or in transit; if engineers need to process the data, they would either process encrypted data (without understanding PII context) or have decryption access, negating the requirement to not view PII. Option B (correct) AWS Lake Formation data filtering with column-level access control and cell-level filtering precisely addresses this by allowing engineers to view non-PII columns and process PII columns with masked or redacted values, while authorized analysts can be granted access to view the full, unmasked data based on their permissions. Option C (incorrect) Applying data tokenization with a separate tokenization service means analysts would also need access to the tokenization service to de-tokenize data to view full PII values, adding complexity for direct full data access and not natively supported by standard query engines in a data lake for unmasking on the fly. Option D (incorrect) Storing PII in a separate encrypted database with application-level access control significantly complicates the data pipeline and analytics by requiring joins across different data stores and introducing custom application logic for access, instead of leveraging a unified data lake security model.'
WHERE question_id = 'd6455d3d-0281-4ef6-a565-fc01ecba2d80';

-- question_id: d64801ba-713a-48ff-b5e6-b43b8990d9fd
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EventBridge scheduled rules are time-based triggers that would periodically poll S3 for new files, introducing latency and inefficiency rather than reacting immediately to file arrivals. Option B (correct) S3 event notifications (e.g., for s3:ObjectCreated events) directly trigger a Lambda function immediately upon file arrival, and Lambda can then programmatically start an AWS Glue workflow or job run, fulfilling the real-time, event-driven requirement and allowing for custom logic to track processed files. Option C (incorrect) AWS Glue workflow time-based triggers are periodic and would introduce a delay (e.g., 5 minutes) between file arrival and job execution, which does not meet the "start immediately" requirement. Option D (incorrect) While Amazon MWAA with S3 sensors can detect new files, sensors typically operate by polling S3, which introduces latency and is less efficient than native S3 event notifications for immediate, event-driven triggers.'
WHERE question_id = 'd64801ba-713a-48ff-b5e6-b43b8990d9fd';

-- question_id: d6d7e3f3-9a5b-437a-b380-17ec4c1d6e99
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Accuracy is unsuitable for highly imbalanced datasets because a model predicting the majority class (no disease) all the time can still achieve high accuracy, making it misleading, a pitfall often highlighted in AWS SageMaker training where data scientists are advised to consider appropriate metrics for their specific problem, especially with imbalanced data. Option B (correct) Precision-Recall AUC (Area Under the Precision-Recall Curve) is ideal for imbalanced datasets because it focuses on the performance of the positive class, providing a more reliable measure of a model''s ability to identify rare events without being overly influenced by the large number of true negatives, a critical consideration when evaluating models built with AWS SageMaker for anomaly detection or rare event prediction. Option C (incorrect) Mean Absolute Error is a metric for regression tasks, measuring the average magnitude of errors between predicted and actual numerical values, and is not applicable for classification problems like predicting disease occurrences, which are typically binary (yes/no), a fundamental distinction emphasized in AWS machine learning courses and documentation when choosing between regression and classification algorithms. Option D (incorrect) R-squared (coefficient of determination) is another metric exclusively used for regression tasks, indicating the proportion of variance in the dependent variable that can be predicted from the independent variables, making it irrelevant for evaluating the performance of a classification model predicting rare disease occurrences, a concept clearly separated from classification tasks in AWS SageMaker''s built-in algorithm selection and evaluation tools.'
WHERE question_id = 'd6d7e3f3-9a5b-437a-b380-17ec4c1d6e99';

-- question_id: d74809d8-5945-4540-b365-43c6f183b8cf
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deploying larger SageMaker instances primarily provides more compute resources to handle a higher volume of requests or larger batches, or to accelerate computationally intensive models, but it does not inherently reduce the stated 100ms inference time of the machine learning model itself. Option B (correct) ElastiCache (Redis or Memcached) provides extremely low-latency in-memory data retrieval, making it ideal for caching frequently accessed recommendation results using the user ID as a key, thereby serving subsequent requests for the same user well within the 50ms latency requirement without needing to re-run the 100ms ML inference. Option C (incorrect) While Lambda provisioned concurrency reduces cold start latency for serverless functions, it does not decrease the 100ms inherent inference time of the machine learning model itself, which is the primary bottleneck for meeting the sub-50ms requirement. Option D (incorrect) Request batching can improve overall throughput and cost efficiency by processing multiple requests in a single inference call, but it does not reduce the individual end-to-end latency for a single user''s request, and can even increase it due to the need to wait for a batch to form, still leaving the core 100ms model inference time as a bottleneck for individual requests.'
WHERE question_id = 'd74809d8-5945-4540-b365-43c6f183b8cf';

-- question_id: d83b0089-d76d-4c8e-a9a3-9e7315d00221
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) All data on instance store volumes is lost immediately upon termination and the root EBS volume is deleted by default due to its `DeleteOnTermination` attribute being set to true. Option B (correct) By default, the `DeleteOnTermination` attribute for the root EBS volume is set to true, causing it to be deleted, while additional EBS volumes attached later typically have `DeleteOnTermination` set to false, allowing them to persist. Option C (incorrect) Data on additional EBS volumes attached to the instance with their `DeleteOnTermination` attribute set to false (the default for non-root volumes) will persist and is not lost immediately upon termination. Option D (incorrect) EC2 instance termination does not automatically trigger a backup process; users must manually create EBS snapshots or configure AWS Backup policies to preserve data.'
WHERE question_id = 'd83b0089-d76d-4c8e-a9a3-9e7315d00221';

-- question_id: d8452b21-037c-4219-a226-265cdf761f6e
-- answer_correct: True | verified_indices: [0] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Enabling Athena query result caching directly addresses the 40% identical dashboard refresh queries by reusing previously computed results for identical queries, eliminating redundant data scans and significantly reducing costs. Option B (incorrect) Athena prepared statements improve query performance by reducing compilation overhead for parameterized queries, but they do not inherently reduce the amount of data scanned, which is the primary cost driver for Athena. Option C (incorrect) Using Athena workgroups to enforce data scan limits is a cost control mechanism that prevents runaway queries from incurring excessive costs, but it does not optimize legitimate data scans by avoiding redundant processing like caching does. Option D (incorrect) Implementing Amazon QuickSight with SPICE dataset caching would indeed reduce Athena costs for dashboard refreshes by offloading the data access to SPICE, but this represents a larger architectural change and introduces a new service rather than directly optimizing Athena''s existing query patterns using its native features.'
WHERE question_id = 'd8452b21-037c-4219-a226-265cdf761f6e';

-- question_id: d919fe86-45b3-45d3-8598-77b8d98506a5
-- answer_correct: True | verified_indices: [0, 2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) The Operational Excellence pillar focuses on running and monitoring systems to deliver business value and continually improving processes and procedures, exemplified by using services like AWS CloudWatch for monitoring and AWS Systems Manager for operational automation. Option B (incorrect) Code Optimization is a best practice that contributes to principles like Performance Efficiency and Cost Optimization, but it is not one of the six distinct pillars of the AWS Well-Architected Framework itself. Option C (correct) The Performance Efficiency pillar focuses on using computing resources efficiently to meet system requirements and maintain that efficiency as demand changes, often achieved through serverless architectures like AWS Lambda or auto-scaling groups on Amazon EC2. Option D (incorrect) Server Management is generally abstracted away or minimized by AWS services (e.g., using Amazon RDS for managed databases instead of self-managing EC2 instances), and while operational aspects are covered by Operational Excellence, "Server Management" is not a separate pillar. Option E (incorrect) Hardware Selection is primarily an AWS responsibility, as the framework encourages customers to focus on designing distributed and resilient architectures using AWS services, rather than managing underlying physical infrastructure details like CPU or storage types directly, which are abstracted by services like Amazon S3 or EC2 instance types.'
WHERE question_id = 'd919fe86-45b3-45d3-8598-77b8d98506a5';

-- question_id: d9bd54c0-238c-46d9-8ad8-67d0c7dc5eec
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) API authentication and authorization are essential to ensure only authorized users and services can interact with the deployed model''s endpoint, preventing unauthorized access, data exfiltration, or model tampering, often implemented using AWS API Gateway with IAM or Cognito authorizers. Option B (correct) Model versioning and rollback capabilities are critical for operational security, allowing quick reversion to a stable, known-good model version in case a new deployment introduces security vulnerabilities, performance issues, or unintended biases, a feature supported by Amazon SageMaker. Option C (incorrect) Public model weights expose proprietary intellectual property and can enable reverse-engineering or adversarial attacks, making it a security risk rather than a measure; model artifacts should be stored securely in services like Amazon S3 with restricted access. Option D (incorrect) Unrestricted access to deployed models or their underlying infrastructure is a major security vulnerability that violates the principle of least privilege, enabling unauthorized use, data breaches, or model poisoning, directly opposing secure access practices enforced by AWS IAM. Option E (incorrect) No monitoring prevents the timely detection of anomalies, unauthorized access attempts, performance degradation, or data drift, which are all crucial for identifying and mitigating security incidents and ensuring the integrity and reliability of the deployed model, making services like AWS CloudWatch and SageMaker Model Monitor indispensable.'
WHERE question_id = 'd9bd54c0-238c-46d9-8ad8-67d0c7dc5eec';

-- question_id: da87a166-57f0-4c7b-9829-f4a8564ec6b5
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increasing model size, while potentially enhancing a model''s general capabilities (like those available through Amazon Bedrock), does not inherently prevent or mitigate prompt injection attacks, as a larger model can still be tricked into overriding its instructions if not properly secured. Option B (correct) Input validation and sanitization, often implemented through pre-processing logic in an AWS Lambda function or by configuring AWS WAF to filter malicious patterns, helps prevent prompt injection by neutralizing or rejecting adversarial inputs before they reach the language model (e.g., an Amazon Bedrock foundation model). Option C (incorrect) Using more tokens, either for input context or output length when interacting with a service like Amazon Bedrock, merely affects the amount of information processed or generated and does not provide any security against prompt injection attempts. Option D (incorrect) Faster inference, achieved through optimized deployments on AWS services like Amazon SageMaker endpoints, improves the speed of model response but offers no protection against the content of a prompt injection attack.'
WHERE question_id = 'da87a166-57f0-4c7b-9829-f4a8564ec6b5';

-- question_id: dafc92f0-2f3d-4eef-8102-a1b8648a2339
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While compressing data files reduces the storage footprint and the raw amount of data transferred, Athena still needs to decompress and scan the entire compressed file if the relevant data for filtering by date and region is scattered across it, failing to reduce the initial scope of the data scanned. Option B (correct) Partitioning S3 data by date and region, and configuring Athena to use these partitions, enables Athena to perform partition pruning, scanning only the specific S3 directories and files that match the date and region specified in the query''s WHERE clause, significantly reducing the data scanned. Option C (partially correct but not the primary solution for this specific problem) Converting data to a columnar format like Parquet significantly reduces data scanned by allowing Athena to read only the necessary columns, but without partitioning, Athena would still scan the entire file(s) to find the relevant columns if the files are not structured to skip irrelevant data based on the date and region filter. Option D (incorrect) Amazon Athena is a serverless query service that does not offer a native, built-in query result caching mechanism to reduce costs for frequent or identical queries like some traditional data warehouse services.'
WHERE question_id = 'dafc92f0-2f3d-4eef-8102-a1b8648a2339';

-- question_id: db26f69a-559f-4cc4-8cc4-34e99018e48a
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) A text-only model, such as those used by Amazon Comprehend or specific large language models on Amazon Bedrock like Anthropic Claude 2, would be unable to process and extract information from the visual input (photos), which is a key requirement for claim processing. Option B (correct) A multi-modal model is specifically designed to understand and process information from multiple data types simultaneously, such as text and images, making it ideal for extracting information from both photos and written descriptions as offered by models like Anthropic Claude 3 on Amazon Bedrock. Option C (incorrect) An image-only model, like the capabilities offered by Amazon Rekognition, specializes in analyzing images but cannot process or extract information from the written descriptions provided, failing to meet the full requirements of the scenario. Option D (incorrect) An audio model, such as those powering Amazon Transcribe or Amazon Polly, is designed for processing spoken language or generating speech and is irrelevant to the specified inputs of photos and written descriptions for claim processing.'
WHERE question_id = 'db26f69a-559f-4cc4-8cc4-34e99018e48a';

-- question_id: db5681cd-ec80-4115-90a2-22464c804b84
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS Route 53 is a highly available and scalable cloud Domain Name System (DNS) web service and offers domain name registration services. Option B (incorrect) Amazon CloudFront is a content delivery network (CDN) service used to distribute web content to users with low latency. Option C (incorrect) AWS Direct Connect is a networking service that provides a dedicated private connection from your on-premises data center to AWS. Option D (incorrect) Amazon VPC (Virtual Private Cloud) allows you to provision a logically isolated section of the AWS Cloud to launch resources in a virtual network you define.'
WHERE question_id = 'db5681cd-ec80-4115-90a2-22464c804b84';

-- question_id: db81f838-d0d1-49be-9042-7c8c5cfed75f
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While DynamoDB Global Secondary Indexes (GSIs) can be used for querying, maintaining a GSI sorted by score with millions of updates per minute would lead to very high write costs, potential throttling issues, and eventual consistency delays, making real-time precise ranking challenging and expensive. Option B (incorrect) RDS MySQL, even with an indexed score column, is a traditional relational database that would struggle to handle millions of real-time updates per minute and maintain sub-10ms latency for complex ranking queries due to disk I/O overhead, transaction processing, and locking mechanisms inherent to its architecture. Option C (correct) ElastiCache Redis using Sorted Sets is specifically designed for this use case, efficiently handling millions of score updates per minute with `ZADD` and providing sub-millisecond latency for retrieving top N players (`ZREVRANGE`) and individual player rankings (`ZRANK` or `ZREVRANK`) because all operations are performed in-memory. Option D (incorrect) Amazon Aurora, despite its performance improvements over standard relational databases, still fundamentally operates as a relational database, making it ill-suited for extremely high write throughput of rapidly changing scores and real-time aggregate ranking queries with sub-10ms latency due to its transactional overhead and persistence model.'
WHERE question_id = 'db81f838-d0d1-49be-9042-7c8c5cfed75f';

-- question_id: db94f900-be65-4b98-8c67-30214e4047b8
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) In the context of AWS, security credentials for API access are typically managed through AWS Identity and Access Management (IAM) roles, users, access keys, or temporary credentials from AWS STS, not generic "tokens" defined by LLMs themselves. Option B (correct) Tokens are indeed the basic units of text—like words, subwords, or punctuation marks—that large language models, such as those accessible via Amazon Bedrock (e.g., Anthropic Claude, Amazon Titan models), break down input into for processing and use to generate output. Option C (incorrect) Training data samples are the complete examples or datasets used to train an LLM, for instance, on Amazon SageMaker or during fine-tuning on Amazon Bedrock, rather than the discrete units resulting from text tokenization. Option D (incorrect) Model parameters are the numerous internal weights and biases learned by the LLM during its training phase, which determine the model''s behavior and performance, and are distinct from the textual tokens it processes, as managed by services like Amazon SageMaker.'
WHERE question_id = 'db94f900-be65-4b98-8c67-30214e4047b8';

-- question_id: dbaa8f4c-2347-4075-ab62-30dae50fed20
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Service Control Policies (SCPs) are guardrails that define the maximum permissions for accounts, preventing unauthorized or potentially costly actions, but they do not directly provide cost benefits like consolidated pricing or volume discounts. Option B (correct) Consolidated billing aggregates usage and costs across all member accounts within an organization, allowing for volume discounts, shared Reserved Instances, and Savings Plans, which directly leads to cost reduction. Option C (incorrect) Account isolation is a security and operational best practice for separating workloads and data, but it does not inherently offer direct financial cost benefits such as discounted service pricing. Option D (incorrect) Cross-account roles are an AWS Identity and Access Management (IAM) feature that enables secure access and management across different AWS accounts, primarily for operational efficiency and security, not direct cost reduction on services.'
WHERE question_id = 'dbaa8f4c-2347-4075-ab62-30dae50fed20';

-- question_id: dbb7f728-f27f-423b-9982-f0d087876275
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS services like Elastic Load Balancing (ELB) are responsible for distributing incoming application traffic across multiple targets to achieve load balancing, a function separate from a route table''s purpose. Option B (correct) A route table contains a set of rules, called routes, that determine where network traffic from a subnet or gateway is directed, specifying the next hop for various IP address ranges. Option C (incorrect) AWS services such as Amazon S3, Amazon EBS, and Amazon RDS are designed for storing various types of data, whereas a route table''s sole function is network traffic control. Option D (incorrect) AWS Identity and Access Management (IAM) is the service used to securely control access to AWS services and resources, managing user authentication and authorization, which is distinct from network routing functions.'
WHERE question_id = 'dbb7f728-f27f-423b-9982-f0d087876275';

-- question_id: dbc2e2d6-1673-42f8-ab11-daa7e31ac709
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) S3 bucket policies are resource-based controls that apply only to specific S3 buckets and can potentially be circumvented by creating new buckets without such policies or by accessing other non-S3 resources, failing to provide a comprehensive, non-circumventable preventive control across all accounts and services. Option 1 (incorrect) AWS Config rules are detective controls that identify non-compliant resources after they have been created or modified, and while they can trigger remediation, they do not prevent the initial non-compliant action from occurring, thus failing the "preventive" requirement. Option 2 (correct) AWS Organizations Service Control Policies (SCPs) are preventive, top-level controls that deny specific AWS service actions across an entire organization or organizational unit, effectively preventing any principal within the affected accounts from performing operations in non-EU regions or accessing EU data from non-EU accounts, making them impossible to circumvent. Option 3 (incorrect) AWS CloudTrail and CloudWatch alarms are detective controls that log events and alert administrators after an action has occurred, meaning data access attempts would already have taken place, which does not satisfy the requirement for a preventive control.'
WHERE question_id = 'dbc2e2d6-1673-42f8-ab11-daa7e31ac709';

-- question_id: dc027525-566c-4a31-94be-18aecff75280
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Model training is performed by specialized AI/ML services like Amazon SageMaker or EC2 instances with deep learning AMIs, while AWS Config monitors the configuration of those resources, not the training process itself. Option B (correct) AWS Config continuously monitors and records the configurations of AWS resources used in AI systems, such as Amazon SageMaker endpoints, S3 buckets, and EC2 instances, and can assess them against compliance rules for governance. Option C (incorrect) Data compression is handled by other AWS services like Amazon S3 or specific application logic to optimize storage and transfer, and is not a function provided by AWS Config. Option D (incorrect) Network routing is managed by services like Amazon VPC, AWS Transit Gateway, or Amazon Route 53 to direct network traffic, which is distinct from AWS Config''s role in resource configuration tracking.'
WHERE question_id = 'dc027525-566c-4a31-94be-18aecff75280';

-- question_id: dc699ad1-f4f9-4f37-9235-ead467b82cf0
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon Redshift does not natively support the MERGE statement, which is a common feature in other database systems, making this approach unfeasible. Option B (correct) AWS Glue is an excellent choice for implementing complex ETL transformations like SCD Type 2 using serverless Apache Spark, allowing robust custom logic to identify changes, update old records, and insert new ones efficiently into Redshift. Option C (incorrect) While Redshift supports stored procedures, implementing complex SCD Type 2 logic within them can be resource-intensive for the data warehouse itself and less scalable or maintainable compared to external ETL tools. Option D (incorrect) AWS Database Migration Service (DMS) primarily focuses on data replication and basic transformations, lacking built-in, sophisticated SCD Type 2 transformation capabilities required for full historical tracking.'
WHERE question_id = 'dc699ad1-f4f9-4f37-9235-ead467b82cf0';

-- question_id: dcb0c4bd-b008-46c0-aae9-61b0b1d975a2
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Refactoring involves significant code and architectural changes to adopt cloud-native patterns, such as breaking monolithic applications into microservices running on AWS Lambda or Amazon ECS. Option B (incorrect) Replatforming requires modifying applications to run on a new platform, for example, migrating from self-managed databases to Amazon RDS or containerizing an application to run on Amazon ECS or Amazon EKS. Option C (correct) Rehosting involves migrating virtual machines or servers directly to Amazon EC2 instances without application code changes, often using tools like AWS Server Migration Service (SMS) or CloudEndure Migration. Option D (incorrect) Repurchasing involves abandoning the existing application entirely and adopting a Software-as-a-Service (SaaS) solution on AWS Marketplace or an AWS partner solution, which is a complete replacement rather than minimal changes.'
WHERE question_id = 'dcb0c4bd-b008-46c0-aae9-61b0b1d975a2';

-- question_id: dcbec543-a3d2-4d84-a5ce-cabad2e9ee17
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Classic Load Balancer operates at Layer 4 (TCP) and Layer 7 (HTTP/HTTPS), but its Layer 7 capabilities are limited to basic path-based routing and it is considered a legacy service that does not offer the advanced content-based routing features of modern load balancers. Option B (correct) Application Load Balancer operates exclusively at Layer 7 (HTTP/HTTPS) and is specifically designed to route traffic based on content, including host headers, URL paths, query strings, and HTTP headers. Option C (incorrect) Network Load Balancer operates exclusively at Layer 4 (TCP/UDP/TLS) and provides ultra-high performance and static IP addresses, but it does not inspect or route traffic based on content. Option D (incorrect) Gateway Load Balancer operates at Layer 3 (IP) and Layer 4 (TCP/UDP) and is specifically designed for deploying and scaling virtual appliances like firewalls and intrusion detection systems, not for content-based routing.'
WHERE question_id = 'dcbec543-a3d2-4d84-a5ce-cabad2e9ee17';

-- question_id: dcda01a8-0dfd-4838-bd78-f4b9c84a9fcc
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Backup and Restore focuses on restoring data and infrastructure from backups in a secondary region only after a disaster, which does not involve critical core services continuously running. Option B (correct) Pilot Light accurately describes maintaining a continuously running, minimal set of critical core services in a secondary region while non-critical components are deployed and scaled up only in the event of a disaster, utilizing services like Amazon RDS or a small EC2 fleet for the core. Option C (incorrect) Warm Standby involves having a scaled-down, fully functional version of the application running with all components in the secondary region, rather than launching non-critical components only during a disaster. Option D (incorrect) Multi-site Active/Active entails running the full application stack concurrently in multiple regions with live traffic, which is a much higher level of readiness and cost than launching non-critical components only when needed.'
WHERE question_id = 'dcda01a8-0dfd-4838-bd78-f4b9c84a9fcc';

-- question_id: dd32b5cc-8c8f-4a38-aa2a-8c3ebf9afebe
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon SNS (Simple Notification Service) is a fully managed messaging service for application-to-person (A2P) and application-to-application (A2A) communication, primarily used for sending push notifications, SMS, and email notifications to subscribers, but it does not provide the comprehensive features for managing email marketing campaigns or tracking transactional email performance. Option B (incorrect) Amazon SQS (Simple Queue Service) is a fully managed message queuing service that enables you to decouple and scale microservices, distributed systems, and serverless applications, primarily used for asynchronous messaging between components, not for sending or managing email directly. Option C (correct) Amazon SES (Simple Email Service) is a highly scalable, cost-effective, and flexible cloud-based email sending service designed for digital marketers and application developers to send marketing, notification, and transactional emails at scale, offering features like bounce and complaint handling, reputation management, and email analytics essential for both marketing and transactional email capabilities. Option D (incorrect) Amazon Connect is an omnichannel cloud contact center service that helps you provide superior customer service, primarily used for managing voice, chat, and task-based customer interactions, not for sending email marketing campaigns or transactional emails.'
WHERE question_id = 'dd32b5cc-8c8f-4a38-aa2a-8c3ebf9afebe';

-- question_id: dd8ebc47-6b2b-4c7e-a5f7-dccbd790f5fc
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Manual scaling adjustments based on predicted loads are prone to human error and can lead to either over-provisioning (wasted cost) or under-provisioning (continued performance bottlenecks), lacking the dynamic responsiveness and reliability of automated AWS services like Auto Scaling. Option B (incorrect) Implementing a single, larger database instance is a vertical scaling approach that has inherent limits and introduces a single point of failure, which does not effectively improve distributed application throughput or availability during peak loads and may still become a bottleneck. Option C (correct) Utilizing Auto Scaling groups combined with load balancing (e.g., AWS ELB) is the most effective solution because Auto Scaling dynamically adjusts the number of EC2 instances based on real-time demand, ensuring optimal resource utilization and automatic recovery from failures, while the load balancer efficiently distributes incoming traffic across healthy instances, preventing bottlenecks and improving overall throughput and availability. Option D (incorrect) Migrating to a serverless architecture without monitoring is a significant anti-pattern; while serverless (e.g., AWS Lambda) offers excellent scalability, operating without monitoring (e.g., Amazon CloudWatch) makes it impossible to observe performance, identify issues, manage costs, or ensure the health of the application.'
WHERE question_id = 'dd8ebc47-6b2b-4c7e-a5f7-dccbd790f5fc';

-- question_id: dda2546d-5021-4eee-a92a-9004db60bdd0
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) Deploying resources across multiple Availability Zones within a Region is the AWS recommended best practice to achieve high availability and fault tolerance against the failure of a single data center because AZs are physically isolated locations within a Region, designed to be independent failures domains. Option B (incorrect) Deploying all resources in a single Availability Zone creates a single point of failure, meaning that if that specific AZ (which represents a data center) experiences an outage, the entire application would become unavailable, directly violating the requirement for fault tolerance. Option C (incorrect) Distributing resources across multiple AWS Regions provides excellent disaster recovery and global reach, but the question specifically asks for solutions "within a single geographic area," making a multi-Region deployment an over-engineered solution for the stated constraint. Option D (incorrect) AWS Edge Locations are primarily used for caching content, DNS resolution, and accelerating traffic for services like Amazon CloudFront and Route 53, and are not designed for hosting an entire application to provide high availability and fault tolerance against data center failures.'
WHERE question_id = 'dda2546d-5021-4eee-a92a-9004db60bdd0';

-- question_id: de2d0fa5-f996-44e2-988d-149cadfc9bb2
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Reserved Instances do not inherently provide better performance; the performance of an EC2 instance is determined by its chosen instance type (e.g., m5.large, c6g.xlarge) and underlying hardware, not by the pricing model. Option B (incorrect) Reserved Instances do not guarantee higher availability in terms of uptime or fault tolerance compared to On-Demand instances, as AWS strives for high availability across all purchase options, and true high availability is achieved through architectural patterns like multi-AZ deployments and Auto Scaling Groups. Option C (correct) Reserved Instances offer significant cost savings, typically up to 75% or more compared to On-Demand pricing, by committing to a specific EC2 instance configuration for a 1-year or 3-year term. Option D (incorrect) Reserved Instances do not provide more features; they are a pricing and capacity reservation model, and an EC2 instance purchased as an RI has the same set of features and capabilities as an On-Demand instance of the same type.'
WHERE question_id = 'de2d0fa5-f996-44e2-988d-149cadfc9bb2';

-- question_id: de785781-27c8-4e99-84f8-8ad2b647eef3
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Systems Manager is a suite of tools for operational management of AWS resources and on-premises servers, focused on automation, patching, and configuration management, not AI bias detection. Option B (correct) Amazon SageMaker Clarify is a specific feature within Amazon SageMaker designed to help detect potential bias in machine learning models and data, and provides model explainability. Option C (incorrect) AWS Certificate Manager (ACM) is used for provisioning, managing, and deploying SSL/TLS certificates for secure communication, and has no function related to AI bias. Option D (incorrect) Amazon Route 53 is a scalable cloud Domain Name System (DNS) web service that routes user requests to internet applications, and is unrelated to AI model analysis.'
WHERE question_id = 'de785781-27c8-4e99-84f8-8ad2b647eef3';

-- question_id: df7446e6-d5d6-433d-a60a-a098450dcb4d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) DynamoDB is not designed for complex analytical queries, which are better handled by services like Amazon Redshift for data warehousing or Amazon Athena for ad-hoc querying of data in S3. Option B (correct) DynamoDB is specifically designed for high-performance, low-latency applications due to its consistent single-digit millisecond response times at any scale and fully managed nature. Option C (incorrect) Data warehousing is not DynamoDB''s primary use case; AWS offers Amazon Redshift as a dedicated, petabyte-scale data warehouse service for analytical workloads. Option D (incorrect) DynamoDB is a persistent database, not an in-memory caching solution; services like Amazon ElastiCache (Redis or Memcached) are purpose-built for in-memory caching to achieve ultra-low latency.'
WHERE question_id = 'df7446e6-d5d6-433d-a60a-a098450dcb4d';

-- question_id: df7637eb-8ba7-4a34-b4e0-73ff7c50a5f0
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Model understanding of visual content directly impacts the quality because AWS services like Amazon Rekognition Video rely on sophisticated deep learning models to accurately identify objects, scenes, activities, and sentiments within video frames, and if these models misinterpret the visual data, the generated descriptions will be inaccurate or incomplete. Option B (correct) Temporal coherence across frames is crucial because generating a narrative video description requires an AI model to understand the sequence of events and how they unfold over time, a capability provided by services like Amazon Rekognition Video''s ability to track objects and activities, ensuring the description flows logically and accurately represents the video''s progression. Option C (incorrect) Server brand has no impact on generation quality because AWS abstracts the underlying hardware, and the performance and quality of managed services like Amazon Rekognition are determined by the service design, algorithms, and computational resources allocated, not the physical server manufacturer. Option D (incorrect) Network cable color is irrelevant to generation quality as it is purely an aesthetic characteristic and has absolutely no technical effect on data transmission speed, reliability, or the processing capabilities of AWS AI/ML services used for video description. Option E (incorrect) Monitor resolution does not affect generation quality because it pertains to the display resolution of the screen used by a human to view the results, not the input video resolution processed by AWS services or the internal workings of the AI models that generate the descriptions.'
WHERE question_id = 'df7637eb-8ba7-4a34-b4e0-73ff7c50a5f0';

-- question_id: df8ec5df-acf5-4c4d-aee9-cbe04a73f656
-- answer_correct: True | verified_indices: [2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon EC2 with Reserved Instances is incorrect because Reserved Instances are primarily a billing discount for predictable, sustained workloads and do not inherently provide automatic scaling up or down based on fluctuating demand, leading to idle cost if traffic drops. Option B (incorrect) AWS Lambda with Auto Scaling is incorrect because while AWS Lambda is a serverless compute service that scales automatically and handles unpredictable traffic efficiently without incurring costs for idle resources, its scaling is intrinsic to the service and does not utilize the "Auto Scaling" feature in the same way EC2 does, which is typically implied when referring to a compute service and scaling feature combination. Option C (correct) Amazon EC2 with Auto Scaling is correct because Amazon EC2 provides flexible compute capacity and the Auto Scaling feature can automatically adjust the number of EC2 instances up and down based on real-time demand, perfectly matching unpredictable traffic patterns and minimizing costs for idle resources by terminating unneeded instances. Option D (incorrect) Amazon Lightsail with fixed plans is incorrect because Lightsail provides fixed-size virtual private servers and does not offer automatic scaling capabilities to adapt to unpredictable traffic patterns, meaning it cannot scale compute capacity up and down or minimize costs for idle resources.'
WHERE question_id = 'df8ec5df-acf5-4c4d-aee9-cbe04a73f656';

-- question_id: dfa08d09-2cef-4a15-913c-e71710f5082d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon CloudWatch is a general monitoring service that can collect and track metrics and logs, but it does not inherently understand or automatically detect machine learning model specific degradation like data drift or model quality issues without extensive manual configuration. Option B (correct) Amazon SageMaker Model Monitor is specifically designed to continuously monitor the quality of machine learning models in production, automatically detecting data drift, model quality drift, and bias drift that lead to performance degradation over time. Option C (incorrect) AWS Config records and evaluates the configurations of your AWS resources and assesses compliance, but it does not monitor the operational performance or quality of deployed machine learning models. Option D (incorrect) Amazon GuardDuty is a threat detection service that monitors for malicious activity and unauthorized behavior to protect your AWS accounts and workloads, and it is not designed to monitor machine learning model performance.'
WHERE question_id = 'dfa08d09-2cef-4a15-913c-e71710f5082d';

-- question_id: dfbe4984-0810-4a91-9028-004c85bfa700
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EC2 instances with auto-scaling still incur significant operational overhead for managing the underlying operating systems, patching, and security, which is higher than serverless alternatives for minimizing operational overhead. Option B (incorrect) EKS on EC2 with manual scaling introduces substantial operational overhead for managing Kubernetes worker nodes and completely fails to address the varying-load requirement, leading to inefficient resource utilization and higher costs or performance issues. Option C (correct) AWS Fargate for ECS is a serverless compute engine that eliminates operational overhead by removing the need to provision or manage EC2 instances, and its pay-per-second billing automatically scales compute resources with varying load, significantly minimizing compute cost for high-concurrency applications. Option D (incorrect) EC2 Spot Instances reduce cost but introduce management complexity due to potential interruptions, and while RDS Multi-AZ ensures database availability, this combination does not fully minimize the operational overhead for the compute layer compared to serverless solutions for varying-load applications.'
WHERE question_id = 'dfbe4984-0810-4a91-9028-004c85bfa700';

-- question_id: e0f1f870-d856-4e1a-a42b-4f31556dda05
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Task-specific performance benchmarks are crucial because different foundation models, such as those available through Amazon Bedrock (e.g., Anthropic Claude, Amazon Titan), excel at various tasks like summarization, code generation, or sentiment analysis, making it essential to choose a model that performs optimally for the intended application. Option B (correct) Inference latency requirements are critical for real-time applications, as the speed at which a foundation model processes requests and generates responses directly impacts user experience and system responsiveness, a factor heavily influenced by the model''s architecture and the deployment infrastructure like Amazon SageMaker endpoints. Option C (incorrect) Physical server location is abstracted by AWS; while choosing an AWS Region for data residency and compliance is important for deployment, the specific physical server location within a data center is not a consideration when selecting a foundation model itself. Option D (incorrect) Keyboard manufacturer is entirely irrelevant to the technical characteristics or selection criteria of a foundation model, as it pertains to end-user input hardware and not AI model capabilities or performance. Option E (incorrect) Cable specifications are low-level infrastructure details managed by AWS and have no bearing on the decision-making process for selecting a foundation model, which focuses on model performance, cost, and suitability for AI tasks.'
WHERE question_id = 'e0f1f870-d856-4e1a-a42b-4f31556dda05';

-- question_id: e11ea8e5-ff29-45ed-93d4-401a38d46c98
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) AWS Trusted Advisor provides recommendations for optimizing AWS resources, security, and performance based on best practices, but it does not simulate policy evaluation or effective permissions for specific users. Option 1 (incorrect) AWS Access Analyzer helps identify resources that are shared with an external entity or publicly accessible, focusing on potential security vulnerabilities, rather than simulating the combined effect of multiple policies for an internal IAM user. Option 2 (correct) AWS IAM Policy Simulator is specifically designed to simulate and determine the effective permissions granted or denied to an IAM entity for specific actions on resources, taking into account all relevant identity-based, resource-based, and organization policies. Option 3 (incorrect) AWS CloudTrail provides a history of API calls and events in your account, which can show that access was denied, but it does not simulate future policy evaluations or the combined effect of policies.'
WHERE question_id = 'e11ea8e5-ff29-45ed-93d4-401a38d46c98';

-- question_id: e17f321d-afd2-42fa-a312-d89458b5e8c1
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Migrating all critical applications first introduces high risk and potential for significant disruption due to the team''s initial lack of experience with AWS migration processes and services like AWS Application Migration Service. Option 1 (incorrect) Prioritizing complex applications with high business value early in the migration journey increases the likelihood of encountering difficult issues without a mature understanding of AWS best practices or the use of advanced services, thereby increasing risk. Option 2 (correct) Starting with simpler, less critical applications allows the organization to build invaluable experience with AWS migration tools (e.g., AWS MGN, AWS DMS), operational procedures, and the cloud environment with minimal business impact, thereby minimizing risk and disruption. Option 3 (incorrect) Migrating applications solely based on the highest TCO first does not inherently consider their complexity or criticality, potentially leading to high-risk migrations of complex systems without the foundational experience needed to ensure success.'
WHERE question_id = 'e17f321d-afd2-42fa-a312-d89458b5e8c1';

-- question_id: e1ec3211-d526-4189-bac1-90f2bd46d354
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS IAM is not designed for monitoring application performance, which is a function handled by services like Amazon CloudWatch for metrics and logs or AWS X-Ray for tracing. Option B (correct) AWS IAM (Identity and Access Management) is fundamentally used to securely manage access to AWS services and resources, allowing you to define granular permissions for users, groups, and roles. Option C (incorrect) Storing application data is not the purpose of AWS IAM; rather, services such as Amazon S3, Amazon RDS, or Amazon DynamoDB are utilized for various data storage needs. Option D (incorrect) AWS IAM does not deploy applications; application deployment is managed by services like AWS Elastic Beanstalk, AWS CodeDeploy, or containers orchestrated with Amazon ECS or Amazon EKS.'
WHERE question_id = 'e1ec3211-d526-4189-bac1-90f2bd46d354';

-- question_id: e2e2c39d-0484-4726-bda4-ea84fe83c5fd
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) ECS with Fargate Spot instances provides cost savings but Spot instances can be interrupted with short notice, which jeopardizes consistent API response times and performance stability during sudden traffic spikes. Option 1 (correct) EKS with Cluster Autoscaler and Horizontal Pod Autoscaler ensures rapid scaling by allowing Horizontal Pod Autoscaler to quickly scale the number of application pods based on demand and Cluster Autoscaler to dynamically add or remove underlying EC2 instances (nodes) to support the scaled pods, maintaining consistent performance under traffic surges. Option 2 (incorrect) ECS on EC2 with capacity providers and target tracking scaling can scale, but launching new EC2 instances to meet sudden capacity demands can introduce provisioning delays that might exceed the strict 200ms API response time requirement compared to the more agile scaling offered by Kubernetes''s native autoscaling mechanisms. Option 3 (incorrect) Lambda functions, while excellent for scaling, are a serverless function service and do not represent a deployment strategy for "containerized microservices" as explicitly stated in the question, despite container image support for Lambda.'
WHERE question_id = 'e2e2c39d-0484-4726-bda4-ea84fe83c5fd';

-- question_id: e3411524-256a-4497-8c02-3d9b25341095
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Purchasing 60 Reserved Instances would result in paying for 40 instances that are only utilized for 2-3 hours daily, leading to significant unnecessary costs for idle reserved capacity during non-peak hours. Option B (correct) This strategy optimizes costs by leveraging Reserved Instances for the predictable 24/7 baseline workload, offering significant savings, and utilizing flexible On-Demand instances for the short, daily traffic spikes, paying only for the capacity needed during peak times. Option C (incorrect) While Auto Scaling handles elasticity well, using 60 On-Demand instances for a 24/7 baseline of 20 instances would be more expensive than using Reserved Instances or Savings Plans for that consistent capacity, failing to optimize the primary cost component. Option D (incorrect) Purchasing Savings Plans for 40 instances would likely misallocate the commitment, as only 20 instances are continuously required, leaving the 24/7 baseline on the more expensive On-Demand pricing and potentially over-committing to the temporary spike capacity.'
WHERE question_id = 'e3411524-256a-4497-8c02-3d9b25341095';

-- question_id: e3960002-e9d8-483d-9ba0-abfc1f26531f
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Security groups only control network reachability, not user authentication or MFA enforcement, and requiring MFA at the application level delegates a core security function outside of native AWS IAM for Redshift. Option B (correct) An IAM policy is the appropriate mechanism to enforce both MFA authentication and IP address restrictions using `aws:MultiFactorAuthPresent` and `aws:SourceIp` conditions for Redshift access. Option C (incorrect) Redshift Enhanced VPC Routing routes COPY/UNLOAD traffic between Redshift and other AWS services, not client connection authentication, and a NAT gateway is for outbound internet access, not inbound MFA enforcement for Redshift. Option D (incorrect) While AWS IAM Identity Center can facilitate access management and deploy policies with MFA and IP restrictions via permission sets, Option B describes the fundamental IAM policy mechanism that directly enforces these requirements, which Identity Center itself utilizes.'
WHERE question_id = 'e3960002-e9d8-483d-9ba0-abfc1f26531f';

-- question_id: e3d16134-8697-424e-8cae-00547ad3846a
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Authentication is the process by which an IAM user or role proves their identity using credentials like passwords, access keys, or STS temporary credentials, while authorization is the subsequent process where AWS determines what actions that authenticated identity is permitted to perform based on attached IAM policies. Option B (incorrect) Authentication explicitly verifies identity through mechanisms such as an IAM user providing their password and potentially MFA, whereas authorization, controlled by IAM policies, determines resource access permissions for an already verified identity, not re-verifying it. Option C (incorrect) Authorization is solely responsible for determining permissions for an authenticated principal using IAM policies, which define specific actions on AWS resources, while authentication''s role is to establish and verify that principal''s identity. Option D (incorrect) Authentication and authorization are fundamentally different security concepts in AWS; authentication confirms the identity of a principal (e.g., an IAM user), and authorization defines the scope of actions that principal can execute on AWS resources (e.g., via IAM policies).'
WHERE question_id = 'e3d16134-8697-424e-8cae-00547ad3846a';

-- question_id: e443c69c-cfbf-4315-9c06-3738dd6f4916
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Amazon SageMaker is a fully managed service for building, training, and deploying machine learning models, but it is not the specific generative AI service that powers PartyRock. Option 1 (correct) Amazon Bedrock is the generative AI service that powers PartyRock, an experimental playground application that allows users to build mini-apps using foundation models. Option 2 (incorrect) Amazon Comprehend is a natural language processing (NLP) service for extracting insights and relationships from text, which is different from the generative AI capabilities PartyRock offers. Option 3 (incorrect) AWS Lambda is a serverless compute service for running code without provisioning servers, which is a foundational compute service but not the specific generative AI service associated with PartyRock.'
WHERE question_id = 'e443c69c-cfbf-4315-9c06-3738dd6f4916';

-- question_id: e4f12a78-4db9-4bc1-a659-bef07efcc986
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) M-series instances offer a balance of compute, memory, and networking resources, making them suitable for diverse applications but not specifically optimized for high sequential I/O operations. Option B (incorrect) R-series instances are designed for memory-intensive applications requiring large amounts of RAM, not primarily for high sequential disk read/write performance. Option C (correct) I-series instances, specifically the Storage Optimized family, are built to deliver high sequential read and write performance to very large datasets on local storage, often using NVMe SSDs, making them ideal for applications like NoSQL databases, data warehousing, and distributed file systems. Option D (incorrect) C-series instances are optimized for compute-intensive workloads that benefit from high-performance processors, not for high sequential disk I/O operations.'
WHERE question_id = 'e4f12a78-4db9-4bc1-a659-bef07efcc986';

-- question_id: e5e49ddb-3748-4ede-85b6-8b68bc0a6d1e
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 bucket policies are resource-level controls that can deny cross-region access for specific buckets but do not prevent users from creating new resources in non-EU regions or moving data if their IAM permissions allow it. Option B (incorrect) AWS Config rules are primarily detective controls that detect non-compliance and can remediate *after* an action has occurred, which does not meet the requirement for a preventive control that cannot be bypassed. Option C (correct) AWS Organizations Service Control Policies (SCPs) are preventive guardrails that apply at the account or OU level, preventing actions (like creating resources or moving data) in specified non-compliant regions and cannot be bypassed by member account users. Option D (incorrect) CloudTrail monitoring with alarms is a detective control that records events and alerts *after* a cross-region data transfer has occurred, failing to prevent the action from happening in the first place.'
WHERE question_id = 'e5e49ddb-3748-4ede-85b6-8b68bc0a6d1e';

-- question_id: e5e9f588-eb1b-412b-9718-b3add8f7fb98
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Continuing normal operations allows an attacker to potentially cause further damage, exfiltrate more data, or deploy malicious resources, violating immediate incident response best practices and potentially increasing financial loss or data breach impact. Option B (correct) Changing all passwords, especially the root user and IAM user credentials, immediately revokes an attacker''s current access while contacting AWS Support initiates a coordinated incident response, leveraging their expertise to identify the breach source and mitigate further risks, which aligns with AWS security best practices. Option C (incorrect) Deleting all resources without proper investigation can destroy valuable forensic evidence needed to understand how the compromise occurred, prevent future attacks, and potentially lead to irreversible data loss or business disruption, violating sound incident response and disaster recovery principles. Option D (incorrect) Sharing account details like access keys, secret keys, or passwords with unauthorized parties further compromises your security posture and violates the AWS Shared Responsibility Model, which designates customers as solely responsible for the security *in* the cloud, including their credentials.'
WHERE question_id = 'e5e9f588-eb1b-412b-9718-b3add8f7fb98';

-- question_id: e640a2f5-c9b5-4098-96d4-7fa827ebedf7
-- answer_correct: True | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The Basic Support plan is free and provides access to documentation, forums, and the AWS Personal Health Dashboard, but it does not include direct access to a Technical Account Manager for proactive guidance. Option B (incorrect) The Developer Support plan offers email-based technical support for general guidance and system impaired issues with a 12-24 hour response time, but it does not feature a dedicated Technical Account Manager. Option C (incorrect) The Business Support plan provides 24/7 phone, chat, and email access to Cloud Support Engineers for production system issues, including a 1-hour response time for production system impaired issues, but it does not assign a Technical Account Manager. Option D (correct) The Enterprise Support plan is specifically designed for large-scale and mission-critical workloads, offering a dedicated Technical Account Manager (TAM) who provides proactive support, architecture guidance, and operational best practices.'
WHERE question_id = 'e640a2f5-c9b5-4098-96d4-7fa827ebedf7';

-- question_id: e65279ed-57aa-49c4-b848-a282e8d8e0af
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) The "zero trust" security model inherently means that no user, device, or application is trusted by default, regardless of whether it is inside or outside the network perimeter, requiring continuous verification and authorization for every access request, as enforced by AWS services like IAM with MFA, granular Security Group rules, and AWS WAF. Option B (incorrect) Trusting all internal traffic contradicts the core principle of zero trust, which mandates that even traffic originating from within the trusted network must be authenticated and authorized, preventing lateral movement, a concept addressed by enforcing least privilege and network segmentation using AWS Security Groups and Network ACLs even within a VPC. Option C (incorrect) "No security needed" is fundamentally incorrect and irresponsible, as the AWS Shared Responsibility Model dictates that customers are responsible for security *in* the cloud, requiring robust security controls like IAM, encryption, and network isolation using AWS VPC and subnets to protect customer data and applications. Option D (incorrect) Zero trust is not about exclusively trusting AWS services; rather, it''s about using AWS services like IAM, AWS WAF, and AWS KMS to enforce granular access controls, authentication, and authorization for *your* resources and data, ensuring every interaction is verified and adheres to the principle of least privilege.'
WHERE question_id = 'e65279ed-57aa-49c4-b848-a282e8d8e0af';

-- question_id: e6a3ea16-136b-438b-b418-f669afe7895e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) More complex models, such as deep neural networks often trained on Amazon SageMaker, are generally less interpretable because their internal workings and decision paths are opaque, making it difficult to understand individual predictions. Option B (correct) Simpler models, like those built with Amazon SageMaker''s Linear Learner or K-Nearest Neighbors algorithms, are typically easier to understand and explain, but they may not capture the intricate patterns in complex datasets as effectively, leading to lower predictive performance. Option C (incorrect) There is a well-established relationship, often described as a tradeoff, where increasing model complexity to achieve higher performance typically reduces interpretability, a challenge AWS addresses with services like Amazon SageMaker Clarify for model explainability. Option D (incorrect) Interpretability itself does not inherently improve a model''s performance metrics like accuracy or F1-score; rather, it provides insights that can help data scientists refine and debug a model, potentially leading to performance improvements after further development, but not as a direct consequence of being interpretable.'
WHERE question_id = 'e6a3ea16-136b-438b-b418-f669afe7895e';

-- question_id: e6df7ceb-cb82-423d-9ca1-b924d28a1da0
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Purchasing Reserved Instances for underutilized instances locks in a commitment for oversized resources, continuing to pay for unused capacity at a discounted rate rather than addressing the core issue of underutilization. Option B (incorrect) Terminating instances without assessing workload suitability or re-architecting to serverless (like AWS Lambda) is a drastic step that could disrupt critical applications and may not be appropriate for all workloads that require persistent servers. Option C (correct) Right-sizing directly addresses underutilization by scaling down the instance type based on CloudWatch metrics to match actual resource consumption, thereby reducing compute costs by paying only for what is needed. Option D (incorrect) Enabling enhanced monitoring provides more granular data but is a diagnostic step for gathering information, not an action that directly optimizes costs for underutilized instances.'
WHERE question_id = 'e6df7ceb-cb82-423d-9ca1-b924d28a1da0';

-- question_id: e71e3abd-95ed-4d3f-bab7-527c998cec3e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increased accuracy is not a direct benefit of caching, as caching stores previously computed results without inherently improving the underlying accuracy of the RAG model''s retrieval or generation logic, which is more dependent on factors like embedding quality or LLM capabilities. Option B (correct) Reduced latency and cost is a primary benefit, as caching frequently asked questions or expensive computations in services like Amazon ElastiCache (Redis) avoids reprocessing the full RAG pipeline, thereby saving on inference calls to Amazon Bedrock and retrieval from Amazon OpenSearch Service, leading to faster responses and lower operational expenses. Option C (incorrect) Better security is not a direct benefit, as caching itself does not enhance the security posture of the RAG system; security is maintained through AWS IAM, encryption with AWS KMS, and network controls like VPCs, while caching might even introduce new security considerations if not properly implemented. Option D (incorrect) More hallucinations is not a benefit, nor is it caused by caching; hallucinations are a characteristic of the underlying Large Language Model (LLM) (e.g., accessed via Amazon Bedrock), and caching merely stores the output of the RAG system, not influencing the LLM''s tendency to generate incorrect information.'
WHERE question_id = 'e71e3abd-95ed-4d3f-bab7-527c998cec3e';

-- question_id: e7a9ee9e-c0e9-49d4-943f-49dca6f0d983
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Slower provisioning directly contradicts the benefit of increased speed and agility, as cloud computing, particularly AWS, is designed for rapid resource deployment, not delays. Option B (correct) Self-service resource provisioning allows users and teams to quickly provision and de-provision AWS services like EC2 instances, S3 buckets, or RDS databases on demand via the AWS Management Console, CLI, or SDKs, eliminating manual wait times and significantly accelerating development and deployment cycles. Option C (incorrect) Manual approval processes introduce bottlenecks and delays, hindering the ability to quickly provision resources and directly reducing speed and agility, which is contrary to the cloud''s promise. Option D (incorrect) Physical hardware limitations are characteristic of traditional on-premises environments and are overcome by cloud computing''s virtualized, on-demand infrastructure, which allows for instant scaling without waiting for physical procurement or setup, thereby increasing agility rather than enabling it through limitation.'
WHERE question_id = 'e7a9ee9e-c0e9-49d4-943f-49dca6f0d983';

-- question_id: e7d33631-e58c-4548-acb3-d2e5ec56ff94
-- answer_correct: True | verified_indices: [2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) CloudFront with Lambda@Edge for dynamic content optimization and S3 origins for static content is a valid and powerful setup, but Option C''s emphasis on custom behaviors for differentiating content types and explicit mention of AWS analytics makes it a more comprehensive answer for the specific requirements. Option B (incorrect) Global Accelerator with Application Load Balancers improves network performance to application endpoints but does not provide content caching capabilities at the edge, which is essential for optimizing static media files as a content delivery network. Option C (correct) CloudFront with custom behaviors allows defining distinct caching and forwarding rules for dynamic API responses and static media files, ensuring optimal performance for different content types, and integrates directly with AWS services for detailed analytics and content personalization. Option D (incorrect) Route 53 latency-based routing with regional CloudFront distributions is a less optimal and complex approach, as CloudFront distributions are designed to be global by default, and this configuration does not efficiently leverage CloudFront''s global edge network for content delivery.'
WHERE question_id = 'e7d33631-e58c-4548-acb3-d2e5ec56ff94';

-- question_id: e81dea49-00a7-46a0-8b9a-bef6afe56ec9
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) A computer vision model, like those powered by Amazon Rekognition, is designed to understand and process visual data (images, videos) to identify objects, text, or faces, not to generate new textual content for product descriptions. Option B (incorrect) A speech recognition model, such as Amazon Transcribe, is used to convert audio input into written text, which is not the task of generating new product descriptions at scale. Option C (correct) A generative text model, available through services like Amazon Bedrock or custom models deployed on Amazon SageMaker, is specifically designed to create new, human-like text content based on input prompts or data, making it ideal for generating product descriptions at scale. Option D (incorrect) A time series forecasting model, often implemented with Amazon Forecast, is used to predict future events or values based on historical, time-stamped data, which is unrelated to generating textual product descriptions.'
WHERE question_id = 'e81dea49-00a7-46a0-8b9a-bef6afe56ec9';

-- question_id: e85cc4f6-b00a-41cb-a7d5-96b108502f56
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) RDS PostgreSQL, even with read replicas, is a relational database optimized for transactional consistency; complex personalized queries across 10 million products are unlikely to consistently achieve under 50ms latency without a dedicated in-memory caching layer for the *recommendation results themselves*, and PostgreSQL''s built-in query cache is limited or deprecated. Option B (correct) DynamoDB is a highly scalable NoSQL database known for consistent single-digit millisecond latency at any scale, making it ideal for storing and serving personalized recommendations, and DynamoDB Streams enables real-time processing of user behavior to update recommendations rapidly. Option C (incorrect) While ElastiCache Redis is excellent for serving pre-computed recommendation scores with sub-millisecond latency, it typically functions as a cache or an in-memory database and would usually require a separate persistent database like DynamoDB to store the detailed 10 million product catalog or for long-term persistence, potentially adding latency for fetching product details. Option D (incorrect) Aurora offers high performance for relational workloads, but it is still a relational database that might struggle to consistently meet sub-50ms latency for complex personalized queries on 10 million products without aggressive application-level caching of results, and Global Database primarily addresses low-latency global replication, not necessarily intra-region query performance for this specific use case.'
WHERE question_id = 'e85cc4f6-b00a-41cb-a7d5-96b108502f56';

-- question_id: e9824db0-95cc-4085-8e49-e6f162f1e27c
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Fixed capacity is antithetical to cloud computing''s elastic nature, where resources are dynamically provisioned and de-provisioned to match demand, unlike the predetermined and often over-provisioned resources of traditional on-premises infrastructure, which hinders rapid adaptation. Option B (correct) Agility, enabled by cloud computing, allows businesses to rapidly provision, de-provision, and reconfigure IT resources, such as spinning up new AWS EC2 instances or deploying new services with AWS Elastic Beanstalk in minutes, thereby enabling quick responses to market shifts without significant upfront investment. Option C (incorrect) While manual scaling is possible, the characteristic that allows quick adaptation in cloud computing is primarily automated scaling capabilities, like AWS Auto Scaling, which dynamically adjusts resources based on demand, far surpassing the speed and efficiency of manual intervention. Option D (incorrect) Cloud computing abstracts away the management of physical infrastructure; businesses consume resources as a service without owning or maintaining the underlying hardware, which is managed by AWS and is a contributor to agility rather than being the characteristic itself that allows adaptation.'
WHERE question_id = 'e9824db0-95cc-4085-8e49-e6f162f1e27c';

-- question_id: e99ac1e4-e1c7-4ce1-a7b2-5187559f807d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Embedding models transform data for semantic search, not primarily for size reduction, which is handled by data compression algorithms or services like Amazon S3 Intelligent-Tiering. Option B (correct) In RAG, embedding models (e.g., those available via Amazon SageMaker JumpStart or Amazon Bedrock) convert unstructured text into high-dimensional numerical vectors (embeddings) that capture semantic meaning, enabling efficient similarity search in vector databases like Amazon OpenSearch Service or Amazon Aurora PostgreSQL with pgvector. Option C (incorrect) Encryption (e.g., using AWS Key Management Service (KMS) for data at rest and in transit) is a security measure to protect data confidentiality, distinct from the function of embedding models which is to represent data for retrieval. Option D (incorrect) Generating images is the function of generative AI models designed for image synthesis (e.g., Stable Diffusion available on Amazon SageMaker), not the purpose of embedding models which focus on numerical representation of text or other data types for retrieval.'
WHERE question_id = 'e99ac1e4-e1c7-4ce1-a7b2-5187559f807d';

-- question_id: ea83fa17-a4fe-4d30-b12a-d2cfd603da8e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Relying on a single strong security control, such as only a robust AWS WAF without other layers like Security Groups or IAM policies, creates a single point of failure and contradicts the multi-layered approach of defense in depth. Option B (correct) Defense in depth fundamentally involves employing multiple overlapping security layers, such as combining AWS WAF, Security Groups, Network ACLs, IAM policies, and encryption via AWS KMS to protect resources even if one layer is bypassed. Option C (incorrect) The notion of needing no security controls is antithetical to any robust security posture on AWS, as unsecured resources like Amazon S3 buckets or EC2 instances would be immediately vulnerable to unauthorized access or compromise. Option D (incorrect) While perimeter security, like using AWS Network ACLs or AWS Shield, is a vital component, defense in depth extends beyond just the perimeter to include internal controls like instance-level Security Groups, IAM least privilege access, and data encryption with AWS KMS.'
WHERE question_id = 'ea83fa17-a4fe-4d30-b12a-d2cfd603da8e';

-- question_id: ea9b6161-3ba4-4870-b8d8-19b28b94755e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) EMR managed scaling would adjust cluster size during its 24/7 operation but would not eliminate the cost of the cluster running for 18 unnecessary hours each day. Option B (correct) Deploying a transient EMR cluster ensures compute resources are provisioned only for the 6 hours of job execution and terminated afterward, directly eliminating 18 hours of idle cluster cost daily. Option C (incorrect) While AWS Glue is a serverless and cost-effective option, it would require re-platforming existing Spark jobs from EMR and is not necessarily more effective than optimizing the existing EMR usage for this specific scenario. Option D (incorrect) Using EC2 Spot instances would reduce the hourly cost of the EMR cluster while it''s running, but it does not address the fundamental issue of the cluster running unnecessarily for 18 hours daily.'
WHERE question_id = 'ea9b6161-3ba4-4870-b8d8-19b28b94755e';

-- question_id: ec32f2d1-d31c-4029-bbba-0ed01d3a362c
-- answer_correct: True | verified_indices: [0] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Kinesis Data Analytics with Apache Flink is specifically designed for real-time streaming analytics, offering robust support for tumbling windows and sophisticated mechanisms like watermarks and allowed lateness to correctly process late-arriving data up to 2 hours old within the 1-hour aggregation windows. Option B (incorrect) A Lambda function combined with DynamoDB for stateful aggregation would require complex custom logic to manage continuous windows and handle late data over extended periods, making it a less efficient, more complex, and error-prone solution compared to dedicated streaming analytics services. Option C (incorrect) While AWS Glue streaming jobs with Spark Structured Streaming are capable of handling windowed aggregations and late data using watermarking, Kinesis Data Analytics is often a more purpose-built and optimized service for continuous, low-latency real-time stream analytics, offering more direct control and performance for precise windowing and late data policies. Option D (incorrect) EMR with Spark Structured Streaming can technically meet the requirements, but it is a less managed service compared to Kinesis Data Analytics or AWS Glue, incurring higher operational overhead for cluster management, which makes it a less ideal choice for a managed data pipeline if a more serverless option is available and suitable.'
WHERE question_id = 'ec32f2d1-d31c-4029-bbba-0ed01d3a362c';

-- question_id: ec45621c-31df-408f-963a-2c2fac7c8e26
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Systems Manager is designed to reduce operational overhead and often lowers costs by automating tasks, standardizing configurations, and improving efficiency, rather than leading to higher costs. Option B (correct) AWS Systems Manager offers a unified management experience for infrastructure, allowing users to manage not only AWS resources like EC2 instances but also on-premises servers and virtual machines by installing the Systems Manager Agent (SSM Agent). Option C (incorrect) AWS Systems Manager explicitly supports hybrid environments, enabling the management of non-AWS servers and VMs alongside AWS resources, demonstrating it is not limited to AWS resources only. Option D (incorrect) AWS Systems Manager is primarily an automation and orchestration service, providing capabilities like Run Command, State Manager, Patch Manager, and Automation documents to reduce manual operations and implement Infrastructure as Code principles.'
WHERE question_id = 'ec45621c-31df-408f-963a-2c2fac7c8e26';

-- question_id: ed8e35b7-e992-46ee-8576-392285a6f049
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config continuously monitors and records your AWS resource configurations and provides compliance auditing against predefined rules, rather than performing vulnerability assessments of the software on EC2 instances or container images. Option B (correct) Amazon Inspector is designed to perform automated security assessments, including identifying software vulnerabilities and unintended network exposure on Amazon EC2 instances, and analyzing container images stored in Amazon ECR for known vulnerabilities. Option C (incorrect) AWS CloudTrail records API calls and related events in your AWS account, providing a history of actions for governance, compliance, and auditing, but it does not scan for vulnerabilities. Option D (incorrect) Amazon GuardDuty is a threat detection service that continuously monitors for malicious activity and unauthorized behavior to protect your AWS accounts and workloads, rather than conducting vulnerability assessments on instances or container images.'
WHERE question_id = 'ed8e35b7-e992-46ee-8576-392285a6f049';

-- question_id: edd7a495-b6f0-4e10-85d1-cac40570adac
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Per-user licensing is not typically used for foundational model services like Amazon Bedrock because it is an API-driven service where consumption is based on model usage, not individual end-users accessing an application built on top of it. Option B (correct) Token-based pricing is the primary and typical model for Amazon Bedrock, where customers pay per 1,000 input tokens (prompts) and 1,000 output tokens (completions) generated by the various foundational models, reflecting a true pay-as-you-go consumption. Option C (incorrect) A flat monthly fee is not the typical pricing model for Amazon Bedrock''s generative AI services, as its default offering is pay-per-use based on tokens, although dedicated throughput can be reserved which involves a commitment fee. Option D (incorrect) Per-CPU hour pricing is common for compute resources like Amazon EC2 instances or AWS Fargate, but generative AI services like Amazon Bedrock are serverless and managed, abstracting away the underlying infrastructure so customers pay for the model''s output (tokens) rather than raw compute cycles.'
WHERE question_id = 'edd7a495-b6f0-4e10-85d1-cac40570adac';

-- question_id: ee0a32d7-2aa2-4aef-95f3-4b6a19563370
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) SOC 2 compliance requires formal controls for security, availability, and confidentiality (three of the five Trust Service Criteria) for AI services, ensuring sensitive data processed by services like Amazon SageMaker or Amazon Comprehend is protected using AWS features such as IAM for access control, KMS for encryption, VPC for network isolation, and multi-AZ deployments for resilience. Option B (incorrect) Stating no requirements is false because SOC 2 is a rigorous auditing standard designed to ensure service providers securely manage data and maintain system integrity, a critical aspect for any AI service processing customer data on AWS. Option C (incorrect) SOC 2 compliance demands systematic and documented controls, policies, and procedures, not just sporadic random checks, which are insufficient to demonstrate continuous adherence to security principles and are evidenced by AWS services like CloudTrail for logging and GuardDuty for continuous threat detection. Option D (incorrect) SOC 2 mandates formal and auditable processes to demonstrate compliance and operational effectiveness, making informal processes unacceptable for managing data security and system integrity for AI services leveraging the AWS global infrastructure.'
WHERE question_id = 'ee0a32d7-2aa2-4aef-95f3-4b6a19563370';

-- question_id: ee0f085e-5f96-4c4d-8e11-f11fd0ba76ed
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Higher costs due to shared infrastructure is incorrect because AWS''s shared infrastructure model allows for efficient resource utilization across numerous customers, leading to cost optimization and lower prices for services like EC2 and S3, not higher costs. Option B (correct) Lower costs due to AWS massive scale is correct because AWS''s ability to purchase, operate, and maintain hardware and infrastructure at an enormous scale allows them to achieve significant volume discounts and operational efficiencies, passing these savings on to customers through lower pricing for services like compute, storage, and networking. Option C (incorrect) No cost benefits is incorrect because cloud computing on AWS offers substantial cost benefits through its pay-as-you-go model, elimination of upfront capital expenditures, and ability to scale resources up or down as needed, preventing over-provisioning and reducing waste. Option D (incorrect) Increased complexity is incorrect because while adopting cloud can introduce new architectural considerations, economies of scale specifically refer to cost advantages, and AWS actually reduces operational complexity by managing the underlying infrastructure, patching, and maintenance for services like RDS and ECS, allowing customers to focus on their applications.'
WHERE question_id = 'ee0f085e-5f96-4c4d-8e11-f11fd0ba76ed';

-- question_id: ee70d366-b1dd-43b7-85f4-a50dac6987c4
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Secrets Manager is used for managing, retrieving, and rotating sensitive data like database credentials, API keys, and other secrets, rather than primarily managing encryption keys for data at rest in services like S3 and RDS. Option B (correct) AWS Key Management Service (KMS) is a managed service specifically designed for creating, controlling, and managing encryption keys, and it seamlessly integrates with services like S3 and RDS to encrypt data at rest using customer-managed keys (CMKs). Option C (incorrect) AWS Certificate Manager (ACM) is used for provisioning, managing, and deploying SSL/TLS certificates for securing network communications (data in transit), not for managing encryption keys for data at rest in S3 or RDS. Option D (incorrect) AWS CloudHSM provides dedicated Hardware Security Module (HSM) instances for customers who require FIPS 140-2 Level 3 validated hardware for their encryption keys, offering higher control and compliance, but KMS is the more commonly and primarily used managed service for integrating encryption key management with S3 and RDS without the operational overhead of managing HSMs directly.'
WHERE question_id = 'ee70d366-b1dd-43b7-85f4-a50dac6987c4';

-- question_id: ef3c8042-0c5a-4b21-9478-40c96031b3b3
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudWatch is primarily a monitoring and observability service that collects metrics, logs, and events, allowing you to observe operational health and set alarms, but it does not directly provide actionable optimization recommendations. Option B (correct) AWS Trusted Advisor provides real-time guidance and actionable recommendations across five categories including Cost Optimization and Performance, helping users follow AWS best practices and improve their AWS environment. Option C (incorrect) AWS Config continuously monitors and records your AWS resource configurations and evaluates them against desired configurations, focusing on compliance and change management rather than providing performance or cost optimization recommendations. Option D (incorrect) AWS Systems Manager is a collection of capabilities that helps automate operational tasks and manage AWS resources, such as patching and running commands, but it does not natively provide recommendations for optimizing performance and costs.'
WHERE question_id = 'ef3c8042-0c5a-4b21-9478-40c96031b3b3';

-- question_id: ef9ef203-f6f7-4905-bf84-b985d1add9a9
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Transfer Acceleration is designed to speed up transfers over the internet using CloudFront edge locations and incurs additional charges, it does not eliminate data transfer costs within the same AWS region. Option B (incorrect) S3 is a regional service, not confined to a single Availability Zone, so deploying SageMaker instances in a specific AZ relative to an S3 bucket provides no cost benefit for data transfer within the same region. Option C (correct) Configuring VPC endpoints for S3 ensures data transfer between SageMaker and S3 occurs over the AWS private network, bypassing the internet, which eliminates data transfer charges for S3 gateway endpoints within the same region. Option D (incorrect) S3 Select reduces the volume of data transferred by filtering at the source, thereby lowering the total data transfer cost, but it does not eliminate the per-GB transfer charges themselves.'
WHERE question_id = 'ef9ef203-f6f7-4905-bf84-b985d1add9a9';

-- question_id: efce5246-1667-4fb4-8f48-c0cf33f0ce82
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Software as a Service (SaaS) provides a complete application managed by the vendor, offering the least control over the underlying infrastructure, like with Amazon WorkDocs or Salesforce. Option B (incorrect) Platform as a Service (PaaS) abstracts away the underlying operating system and infrastructure, allowing developers to deploy applications without managing servers, as seen with AWS Elastic Beanstalk. Option C (correct) Infrastructure as a Service (IaaS) provides virtualized computing resources, such as Amazon EC2 instances, giving customers full control over operating systems, applications, and network configuration, down to the virtual server level. Option D (incorrect) Function as a Service (FaaS), exemplified by AWS Lambda, is a serverless execution model where users only manage their code, with AWS completely handling the underlying infrastructure provisioning and scaling.'
WHERE question_id = 'efce5246-1667-4fb4-8f48-c0cf33f0ce82';

-- question_id: efe88f19-13a5-4b58-97d3-220e0362bc72
-- answer_correct: True | verified_indices: [3] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) The problem describes a capacity and metadata management issue due to many small files, not filesystem corruption; HDFS fsck is used to check and repair data integrity, not to free up disk space from valid but unwanted files. Option 1 (incorrect) HDFS balancer redistributes existing data blocks more evenly across DataNodes to prevent hot spots, but it does not free up any disk space or reduce the total number of files when the HDFS cluster is already near full capacity. Option 2 (incorrect) While a beneficial long-term architectural change for EMR to decouple storage and avoid HDFS capacity problems, configuring Spark to use Amazon S3 for intermediate data is a future configuration change and not a maintenance action to immediately restore performance by clearing existing accumulated files from HDFS. Option 3 (correct) Spark shuffle files and temporary data directories on HDFS are often the primary culprits for rapidly accumulating many small files, consuming significant HDFS space and NameNode memory, and cleaning these up directly addresses the stated problem of HDFS being 85% full with small intermediate files, restoring performance.'
WHERE question_id = 'efe88f19-13a5-4b58-97d3-220e0362bc72';

-- question_id: efef439e-ae5e-4a72-8ae8-66c848947afe
-- answer_correct: True | verified_indices: [0, 1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Homomorphic encryption allows computations to be performed on encrypted data without decrypting it, which is critical for protecting sensitive customer data within ML models on platforms like AWS SageMaker while maintaining confidentiality throughout the entire lifecycle. Option B (correct) Differential privacy adds controlled noise to data or model outputs to prevent the inference of individual sensitive information, a technique that aligns with AWS best practices for privacy-preserving ML and responsible AI when training models. Option C (incorrect) Publishing all customer data directly violates data privacy regulations and fundamental AWS security best practices for protecting sensitive information, making it an inappropriate technique for a financial institution. Option D (incorrect) Removing all security measures is a severe breach of AWS security best practices and compliance requirements for financial institutions, leading to the complete exposure of sensitive customer data. Option E (incorrect) Using public endpoints without robust access controls, encryption, and network segmentation (like AWS PrivateLink for SageMaker) significantly increases the attack surface and risk of exposing sensitive customer data, contrary to AWS security recommendations for financial institutions.'
WHERE question_id = 'efef439e-ae5e-4a72-8ae8-66c848947afe';

-- question_id: f04f707b-2d1a-4e70-9cf7-5c19b4d7269f
-- answer_correct: True | verified_indices: [1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While AWS Glue ETL jobs are powerful for large-scale data processing, parsing complex log formats like Apache Common Log Format and performing GeoIP lookups typically require custom PySpark/Scala code rather than solely relying on built-in ApplyMapping and ResolveChoice transformations, making it less efficient for the specific parsing and enrichment needs without significant custom development. Option B (correct) AWS Glue DataBrew is purpose-built for data preparation and transformation using a visual interface, allowing users to define parsing rules (e.g., with regex for ACL), apply enrichment steps (e.g., GeoIP lookup via dataset joins or custom formulas), and convert to Parquet with proper schema and typing, efficiently handling continuous data with minimal code. Option C (incorrect) Amazon EMR with Apache Spark structured streaming is a robust solution for real-time processing, but it introduces significant operational overhead for cluster management and requires extensive coding (PySpark/Scala with UDFs) compared to the managed, low-code approach offered by AWS Glue DataBrew for these specific data preparation tasks. Option D (incorrect) AWS Lambda functions with Python and pandas are suitable for smaller, event-driven tasks, but are generally inefficient for large-file, compute-intensive data transformations like continuously parsing complex web server logs, performing external GeoIP lookups, and converting to Parquet, due to execution limits and the need for extensive custom library management for large-scale processing.'
WHERE question_id = 'f04f707b-2d1a-4e70-9cf7-5c19b4d7269f';

-- question_id: f070b5f6-c9d3-42b8-974f-057addbe4032
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Amazon SageMaker Model Monitor is specifically designed to detect data and model quality issues, such as data drift, model bias, and unexpected changes in model performance, for machine learning models deployed in production environments. Option B (incorrect) Amazon SNS (Simple Notification Service) is a messaging service used for sending notifications, and while it can be used to deliver alerts about model performance issues, it does not itself monitor or analyze model performance. Option C (incorrect) AWS Cost Explorer is a cost management tool that allows users to visualize, understand, and manage their AWS costs and usage over time, and it has no functionality for monitoring model performance. Option D (incorrect) Amazon WorkSpaces is a Desktop-as-a-Service (DaaS) solution that provides virtual desktops to users, and it is unrelated to monitoring the performance of machine learning models or other backend services.'
WHERE question_id = 'f070b5f6-c9d3-42b8-974f-057addbe4032';

-- question_id: f07286d7-0157-44f8-87e0-cba41c8bf02f
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Relying on a single security layer is contrary to the principle of defense in depth, as it creates a single point of failure and leaves an organization vulnerable if that one layer is breached, such as only using an AWS Security Group without additional controls. Option B (correct) Defense in depth means implementing multiple, overlapping security controls across different layers of an AWS environment, such as combining AWS Network ACLs, Security Groups, AWS WAF, IAM policies, and encryption with AWS KMS to protect a web application. Option C (incorrect) The concept of "no security needed" directly contradicts the fundamental purpose of defense in depth and any responsible cloud security strategy, which AWS emphasizes through its shared responsibility model. Option D (incorrect) While physical security is a crucial component of the AWS shared responsibility model (managed by AWS), defense in depth extends beyond physical controls to encompass logical, network, data, identity, and application security layers that customers configure, such as using AWS IAM and VPC Flow Logs.'
WHERE question_id = 'f07286d7-0157-44f8-87e0-cba41c8bf02f';

-- question_id: f16eb9d3-a589-4da0-8faf-08766add50ee
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Temporary credentials issued by AWS STS always have a defined expiration time, typically ranging from 15 minutes to 36 hours, making them inherently time-limited and not permanent. Option B (correct) Temporary credentials issued by AWS STS have a limited lifespan and are effectively "rotated" by requesting new credentials when the old ones expire, significantly reducing the security risk associated with compromised long-term keys. Option C (incorrect) Temporary credentials issued by AWS STS require less manual management than long-term access keys because their lifecycle is automatically handled by the service, invalidating them upon expiration. Option D (incorrect) Temporary credentials from AWS STS provide time-limited access, reinforcing the principle of least privilege and preventing permanent access to AWS resources.'
WHERE question_id = 'f16eb9d3-a589-4da0-8faf-08766add50ee';

-- question_id: f23ebd74-a4f0-4d54-a6c3-43e21f96a611
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) ROUGE is a metric for text evaluation, not for measuring image quality, which would involve different metrics like PSNR or SSIM and potentially AWS services like Amazon Rekognition for image analysis. Option B (correct) ROUGE (Recall-Oriented Understudy for Gisting Evaluation) is a standard set of metrics used in Natural Language Processing (NLP) to evaluate the quality of automatically generated summaries or translations by comparing them to human-written reference texts, a task often performed with machine learning models trained and deployed on AWS SageMaker. Option C (incorrect) Calculating inference speed measures the time a machine learning model takes to make a prediction, a performance metric independent of ROUGE, and is typically optimized on AWS using services like Amazon SageMaker Inference Endpoints with appropriate EC2 instances. Option D (incorrect) Determining storage requirements involves estimating data volume and growth for services like Amazon S3 or EBS, which is unrelated to the ROUGE metric for text evaluation.'
WHERE question_id = 'f23ebd74-a4f0-4d54-a6c3-43e21f96a611';

-- question_id: f2a0cfde-b889-4916-b64b-2ed2cba0dedd
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Glue and AWS Athena are data analytics services used for ETL and querying data in S3, not for assessing configuration changes or applying security patches. Option B (incorrect) AWS CodePipeline and AWS CodeBuild are continuous integration and continuous delivery services used for automating software release processes, not for compliance auditing or instance patching. Option C (correct) AWS Config automatically assesses configuration changes against predefined rules to ensure compliance and security posture, while AWS Systems Manager Patch Manager automates the application of security patches to EC2 instances. Option D (incorrect) AWS Global Accelerator and Amazon CloudFront are networking and content delivery services designed to improve application performance and availability, not for security configuration assessment or patch management.'
WHERE question_id = 'f2a0cfde-b889-4916-b64b-2ed2cba0dedd';

-- question_id: f2cbd5a3-a175-44d8-a094-95520a8866fb
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) API Gateway caching reduces the load on backend services and improves response times for subsequent requests to the same endpoint, but it does not reduce the initial network latency experienced by international users connecting to a single region. Option B (correct) Configuring API Gateway with edge-optimized endpoints leverages Amazon CloudFront''s global network of edge locations, allowing international users to connect to the closest edge and have their requests routed over the optimized AWS backbone network to the us-east-1 API Gateway, thereby significantly reducing perceived network latency without deploying the backend Lambda functions in additional regions. Option C (incorrect) Deploying Lambda functions in multiple regions would reduce latency by bringing compute closer to users, but the question explicitly states "without deploying additional regions" for the backend, making this solution invalid. Option D (incorrect) Route 53 latency-based routing directs users to the AWS endpoint that offers the lowest latency, but it requires multiple regional endpoints to choose from, which is not applicable here as the backend is confined to a single region and the constraint disallows deploying additional regions.'
WHERE question_id = 'f2cbd5a3-a175-44d8-a094-95520a8866fb';

-- question_id: f30a77b8-60d6-4946-a08a-283d45b285f9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) While AWS managed AI services like Amazon Rekognition offer high accuracy for common tasks, custom models built and optimized with Amazon SageMaker can often achieve even higher accuracy for specific, niche use cases by leveraging highly specialized data and fine-tuned algorithms. Option 1 (correct) Managed AI services such as Amazon Comprehend and Amazon Polly provide pre-trained, ready-to-use APIs that abstract away model development, infrastructure management, and scaling, enabling developers to integrate AI capabilities into applications much faster and with reduced operational burden compared to building custom models. Option 2 (incorrect) Building custom models using services like Amazon SageMaker provides significantly more granular control over model architecture, training data, algorithms, and deployment strategies, whereas managed AI services abstract away these details to simplify usage. Option 3 (incorrect) AWS managed AI services, including Amazon Translate and Amazon Transcribe, offer a free tier for initial usage, but beyond these limits, they operate on a pay-as-you-go model based on consumption and are not entirely free services.'
WHERE question_id = 'f30a77b8-60d6-4946-a08a-283d45b285f9';

-- question_id: f383a819-e2d1-4b63-a163-f1a9914bc2be
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Dynamic partitioning helps organize files into logical S3 prefixes for improved query pruning but does not reduce the number of files written or the associated PUT request costs. Option B (correct) Increasing the Firehose buffer size and interval to 128 MB and 300 seconds respectively will cause Firehose to accumulate more data before writing, resulting in fewer, larger files that reduce S3 PUT request costs and enhance query performance, all while staying within the 5-minute latency tolerance. Option C (incorrect) Configuring Firehose compression reduces the storage size of files on S3, saving storage costs, but it does not decrease the total number of files written or the PUT request costs associated with them. Option D (incorrect) Using S3 batch operations to merge small files post-delivery is a reactive solution that adds complexity, latency, and additional costs for processing, whereas optimizing Firehose buffering prevents the problem proactively.'
WHERE question_id = 'f383a819-e2d1-4b63-a163-f1a9914bc2be';

-- question_id: f398c756-ee7a-4e64-bac4-42dd176cf205
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The AWS Billing Dashboard provides a high-level overview of your current and past AWS charges and payment history but lacks detailed visualization and forecasting tools for spending patterns. Option B (correct) AWS Cost Explorer is the primary service designed for visualizing, understanding, and forecasting your AWS costs and usage over time, offering granular analysis and predictive capabilities. Option C (incorrect) AWS Budgets allows you to set custom cost and usage budgets and receive alerts when those thresholds are approached or exceeded, but it is not primarily a visualization or forecasting tool itself. Option D (incorrect) AWS Trusted Advisor offers recommendations across five pillars (cost optimization, performance, security, fault tolerance, and service limits) to help you follow AWS best practices, but it does not visualize or forecast spending patterns.'
WHERE question_id = 'f398c756-ee7a-4e64-bac4-42dd176cf205';

-- question_id: f3a2d82d-84cf-49a4-bc37-6d5b985e5866
-- answer_correct: True | verified_indices: [0, 1] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) AWS Organizations with consolidated billing centralizes invoices and discounts across multiple accounts, while Service Control Policies (SCPs) provide preventative spending controls by restricting resource provisioning at an organizational unit or account level, enforcing spending limits. Option B (correct) AWS Cost Explorer with cost allocation tags enables detailed financial analytics and visualization of spending patterns across teams and projects, providing granular attribution through custom reports. Option C (incorrect) AWS Budgets with automated actions is critical for proactive cost alerts and enforcing spending controls through monetary thresholds, but the question asks for the two components providing complete *governance* and *attribution*, for which Organizations and Cost Explorer lay the foundational structure and visibility. Option D (incorrect) AWS Trusted Advisor provides valuable recommendations for cost optimization by identifying idle or underutilized resources, but it does not offer the comprehensive multi-account management, detailed attribution, or automated spending controls central to complete cost governance. Option E (incorrect) AWS Config tracks resource configurations and compliance over time, which can indirectly support cost governance by enforcing policy adherence, but it is not designed for detailed cost attribution, spending alerts, or aggregated cost analytics across multiple accounts.'
WHERE question_id = 'f3a2d82d-84cf-49a4-bc37-6d5b985e5866';

-- question_id: f3be7405-abf7-4b6e-982f-2bee0e6563c8
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While Savings Plans offer significant discounts, the key benefit compared to Reserved Instances is not necessarily *higher* discounts across the board, as both mechanisms aim for similar savings percentages based on commitment, and some specific Reserved Instances might even offer slightly higher discounts for rigid commitments. Option B (correct) Savings Plans provide unmatched flexibility across different instance types within an instance family and even across various compute services like EC2, AWS Fargate, and AWS Lambda with Compute Savings Plans, whereas Reserved Instances are typically tied to a specific instance family, operating system, tenancy, or even a precise instance type (for Standard RIs). Option C (incorrect) Both AWS Savings Plans and Reserved Instances typically offer 1-year or 3-year commitment periods, so Savings Plans do not inherently provide shorter commitment options compared to Reserved Instances. Option D (incorrect) Both AWS Savings Plans and Reserved Instances offer flexible payment options, including No Upfront, Partial Upfront, and All Upfront payments, meaning "no upfront payment required" is not a unique benefit of Savings Plans over RIs.'
WHERE question_id = 'f3be7405-abf7-4b6e-982f-2bee0e6563c8';

-- question_id: f44665e3-e8c6-4cce-9f79-6b4506621d2e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Application Load Balancer primarily distributes incoming traffic and uses health checks to route away from unhealthy targets, but it does not provide client-side circuit breakers, automatic retries, or distributed tracing for inter-service communication within a microservices mesh. Option B (correct) AWS App Mesh is a service mesh that uses Envoy proxy sidecars to inject capabilities like circuit breakers, automatic retries, and integrates with AWS X-Ray for distributed tracing, directly addressing all the specified requirements for handling cascading failures. Option C (incorrect) API Gateway manages API ingress, rate limiting, and authentication, and while it can integrate with Lambda and CloudWatch for monitoring, it does not provide the specific service mesh capabilities like client-side circuit breakers or automatic retries for internal service-to-service calls. Option D (incorrect) Service discovery using Route 53 helps locate service endpoints and can use health checks for DNS failover, but it does not implement advanced service mesh patterns such as circuit breakers, automatic retries, or distributed tracing for the communication itself.'
WHERE question_id = 'f44665e3-e8c6-4cce-9f79-6b4506621d2e';

-- question_id: f451582d-6a85-48f2-9c87-ce5ba6a90a14
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Using dropDuplicates on a DynamicFrame only removes records that are exact duplicates based on the specified subset of columns but does not provide a mechanism to define *which* duplicate record to keep when ordering by a processing timestamp. Option B (correct) Converting the DynamicFrame to a Spark DataFrame and applying window functions with row_number() partitioned by the composite key (user_id, timestamp, event_type) and ordered by the processing timestamp allows for precisely identifying and keeping the first occurrence. Option C (incorrect) Implementing a custom transformation with a Python dictionary to track seen keys would not scale for a large, distributed dataset with duplicates across multiple S3 files, as the dictionary would be local to a single worker or not efficiently shared across a Spark cluster. Option D (incorrect) AWS Glue FindMatches ML transform is designed for identifying fuzzy matches or similar records (record linkage) where exact keys may not exist, which is an overly complex and unsuitable solution for exact key-based deduplication specified in the question.'
WHERE question_id = 'f451582d-6a85-48f2-9c87-ce5ba6a90a14';

-- question_id: f4ed463f-7f98-474d-8d63-12301450d04e
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) There is a significant difference between stopping and terminating an EC2 instance in terms of billing, resource availability, and recovery options. Option 1 (correct) Stopped instances retain their EBS volumes and configuration, allowing them to be restarted at a later time, while terminated instances have their underlying compute resources released and their root EBS volume deleted (by default), making them unrecoverable. Option 2 (incorrect) Terminated instances release their compute resources and, by default, delete their root EBS volume, meaning the specific instance cannot be restarted. Option 3 (incorrect) Stopping an EC2 instance pauses compute charges while retaining the instance''s configuration and data on its EBS volumes, whereas terminating an instance permanently deletes the instance and its root volume (by default), making it unrecoverable.'
WHERE question_id = 'f4ed463f-7f98-474d-8d63-12301450d04e';

-- question_id: f5d736b7-4efb-4dda-ac0d-4ca3787a0b82
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Deploying production workloads immediately is premature and highly insecure because foundational security measures, such as securing the root account and setting up proper IAM, must be established first to protect sensitive data and resources as per the AWS Shared Responsibility Model. Option B (correct) Enabling Multi-Factor Authentication (MFA) and securing the root account is the immediate priority because the root account has unrestricted access to all services and resources, making it the most critical target for compromise, and MFA adds a crucial layer of protection against unauthorized access. Option C (incorrect) While creating multiple IAM users and applying the principle of least privilege is a fundamental security practice, it comes after securing the root account, as the root account itself is the primary entry point to secure before delegating permissions to others. Option D (incorrect) Setting up billing and cost management is an important operational task for financial oversight and preventing unexpected charges, but it is not a direct security measure that protects the account from unauthorized access or breaches.'
WHERE question_id = 'f5d736b7-4efb-4dda-ac0d-4ca3787a0b82';

-- question_id: f608c074-3f29-4fdf-b8e4-3625f0ae908c
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Cost reduction is generally not the primary business reason for using multiple AWS Regions, as inter-region data transfer costs and duplicating infrastructure typically increase overall expenditure. Option B (correct) Disaster recovery is a major reason, leveraging the isolation of regions to ensure business continuity against regional outages, and regulatory compliance is also key, allowing organizations to meet data residency requirements by deploying resources in specific geographical locations. Option C (incorrect) Multi-region deployments inherently increase architectural complexity due to the need for distributed data synchronization, traffic routing, and consistent deployments across distinct geographical boundaries. Option D (incorrect) While using multiple regions does result in increased complexity, this is a consequence or a trade-off, not the main business driver for adopting a multi-region strategy.'
WHERE question_id = 'f608c074-3f29-4fdf-b8e4-3625f0ae908c';

-- question_id: f661ae6b-d1fe-4f78-ac6c-a30ce9c97e5f
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The AWS Management Console is a web-based graphical user interface used for interacting with AWS services manually, not for managing infrastructure through JSON or YAML templates. Option B (incorrect) The AWS CLI is a command-line tool for interacting with AWS services programmatically, but it is used to execute commands, including deploying CloudFormation templates, not to define or manage infrastructure using JSON or YAML templates as its primary method. Option C (correct) AWS CloudFormation is a service specifically designed to help you model and provision all your AWS resources using declarative JSON or YAML templates, allowing for infrastructure as code. Option D (incorrect) Manual configuration involves individually setting up resources through the Console or CLI without the use of structured JSON or YAML templates to define the infrastructure.'
WHERE question_id = 'f661ae6b-d1fe-4f78-ac6c-a30ce9c97e5f';

-- question_id: f6b0e999-3bbe-48bf-bb6a-f041ec5e1b11
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Multiple AWS Snowball Edge devices enable parallel offline data transfer, bypassing limited on-premises network bandwidth entirely and providing the necessary throughput for 1PB within a 4-week timeline. Option B (incorrect) AWS DataSync relies on existing network bandwidth, and even with throttling, transferring 1PB within 4 weeks over limited current bandwidth would be unfeasible given the massive data volume. Option C (incorrect) AWS Direct Connect establishes a dedicated high-bandwidth connection, but the provisioning and setup time for a new Direct Connect circuit typically exceeds the 4-week deadline, making it unsuitable for immediate large-scale migration. Option D (incorrect) AWS Storage Gateway with cached volumes uploads data over existing network bandwidth, which would be too slow to transfer 1PB within 4 weeks given the constraint of limited current bandwidth.'
WHERE question_id = 'f6b0e999-3bbe-48bf-bb6a-f041ec5e1b11';

-- question_id: f6b1ff9f-fb4b-4ba8-9f41-7ad3e361c475
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS operates a massive, globally distributed infrastructure across regions and Availability Zones, far exceeding the scale of most traditional hosting providers. Option B (incorrect) AWS offers an extensive and continuously expanding portfolio of over 200 fully featured services, from compute and storage to advanced machine learning and IoT, not a limited set. Option C (correct) AWS leverages its enormous customer base and global infrastructure to achieve significant economies of scale in hardware procurement, data center operations, and power consumption, allowing it to offer lower per-unit prices for services like EC2 and S3. Option D (incorrect) AWS has a history of consistently lowering prices for its services, reflecting a strategy of driving adoption and maximizing volume through cost efficiency rather than maintaining exceptionally high profit margins.'
WHERE question_id = 'f6b1ff9f-fb4b-4ba8-9f41-7ad3e361c475';

-- question_id: f6f58e20-46c5-4974-9928-8b68299a6ac9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS services like Amazon RDS, Amazon DynamoDB, Amazon Aurora, and Amazon Redshift are specifically designed for database management, not API Gateway. Option B (correct) Amazon API Gateway is a fully managed service that enables developers to create, publish, maintain, monitor, and secure REST, HTTP, and WebSocket APIs at scale, acting as the "front door" for applications. Option C (incorrect) Amazon S3 (Simple Storage Service) is the primary AWS service for highly scalable, durable, and secure object storage for files, not API Gateway. Option D (incorrect) While API Gateway can integrate with authentication services such as Amazon Cognito, IAM, or custom Lambda authorizers to secure access to APIs, its primary purpose is not user authentication itself but rather API creation and management.'
WHERE question_id = 'f6f58e20-46c5-4974-9928-8b68299a6ac9';

-- question_id: f7831e56-ee97-4642-838a-3c35588e415d
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Manual server setup is the antithesis of infrastructure as code, as IaC aims to automate and standardize infrastructure provisioning through scripts and templates, rather than relying on error-prone and inconsistent manual processes in AWS. Option B (correct) Managing infrastructure through code and templates is the core concept of infrastructure as code, exemplified by AWS CloudFormation which allows defining and provisioning AWS resources using declarative JSON or YAML templates. Option C (incorrect) Physical hardware management is primarily the responsibility of AWS in a cloud environment, whereas infrastructure as code focuses on programmatically defining and managing the virtual resources and services provisioned on top of that physical infrastructure. Option D (incorrect) GUI-only management is inefficient and non-scalable, directly opposing infrastructure as code principles which prioritize automation, version control, and programmatic provisioning via tools like AWS CLI, SDKs, or CloudFormation over manual clicks in the AWS Management Console.'
WHERE question_id = 'f7831e56-ee97-4642-838a-3c35588e415d';

-- question_id: f87554fd-bc2e-4725-8b7f-2378c2417e29
-- answer_correct: True | verified_indices: [2] | confidence: 0%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudFront is a Content Delivery Network (CDN) primarily designed for content caching and acceleration, not for automatically directing user traffic to healthy application endpoints across regions based on health checks and failover routing. Option B (incorrect) Amazon S3 is an object storage service and lacks the functionality to monitor application endpoint health and dynamically redirect user traffic for business continuity. Option C (correct) Amazon Route 53 with health checks and failover routing policies is explicitly designed to monitor the health of application endpoints and automatically update DNS records to direct user traffic to healthy endpoints, even across different AWS Regions, ensuring business continuity. Option D (incorrect) AWS Global Accelerator enhances application performance and availability by directing traffic to the nearest healthy endpoint via the AWS global network; however, Route 53 directly provides the health check and failover routing policies at the DNS level for the described automated traffic redirection for business continuity.'
WHERE question_id = 'f87554fd-bc2e-4725-8b7f-2378c2417e29';

-- question_id: f8a7187c-efef-4c3a-8e70-31ffadd5fd96
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Zero-shot prompting is a technique where an Amazon Bedrock foundation model is asked to perform a task without any examples or demonstrations, relying entirely on its pre-trained knowledge to generate a response. Option B (correct) Chain-of-thought prompting involves providing an Amazon Bedrock model with intermediate reasoning steps and step-by-step examples within the prompt, guiding it to produce more logical and accurate multi-step answers. Option C (incorrect) Random prompting is not a recognized or effective prompt engineering technique within AWS machine learning practices, as successful interaction with services like Amazon Bedrock requires intentional and structured input design. Option D (incorrect) Negative prompting is a technique primarily used in generative image models, often accessible via Amazon SageMaker JumpStart, where the prompt specifies elements to *exclude* from the output rather than providing reasoning steps.'
WHERE question_id = 'f8a7187c-efef-4c3a-8e70-31ffadd5fd96';

-- question_id: f8b4c099-872a-430d-b411-bd37a1a70942
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The AWS Well-Architected Review is a process to evaluate existing workloads against architectural best practices across six pillars, not an overall strategy for assessing an organization''s current state and planning its initial cloud journey. Option B (correct) The AWS Cloud Adoption Framework (CAF) provides comprehensive guidance across six perspectives (Business, People, Governance, Platform, Security, Operations) to help organizations assess their readiness, identify gaps, and strategically plan their entire cloud adoption journey. Option C (incorrect) AWS Migration Hub is a service for tracking the progress of application migrations from various AWS and partner tools, rather than a framework for initial cloud strategy and current state assessment. Option D (incorrect) AWS Cost Explorer is a financial management tool used to visualize, understand, and manage AWS costs and usage over time, which does not serve as a cloud adoption strategy or planning framework.'
WHERE question_id = 'f8b4c099-872a-430d-b411-bd37a1a70942';

-- question_id: f91cfa05-544c-4447-a36c-a252ae9a97be
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) CloudTrail records API calls and account events, providing an audit trail of actions taken in your AWS account, but it does not evaluate resource configurations against compliance rules. Option B (correct) AWS Config continuously monitors and records the configuration changes of your AWS resources, and allows you to define rules to assess whether your resources comply with desired configurations and best practices. Option C (incorrect) Amazon CloudWatch collects metrics and logs from AWS services and applications to monitor performance and set alarms, but it does not primarily focus on evaluating resource configurations for compliance. Option D (incorrect) AWS Systems Manager provides operational insights and allows you to automate operational tasks across your AWS resources, including managing patches and enforcing desired states, but it is not the dedicated service for continuous configuration compliance monitoring itself.'
WHERE question_id = 'f91cfa05-544c-4447-a36c-a252ae9a97be';

-- question_id: f9e7f430-d5dc-482f-af85-1b9aa7eefb12
-- answer_correct: False | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{2}'::integer[],
    explanation = 'Option A (Public cloud) is incorrect because this model entails running all applications entirely on a third-party public cloud provider like AWS, which conflicts with the company''s need to keep some applications on-premises due to compliance. Option B (Private cloud) is incorrect because while it would allow applications to remain on-premises in a dedicated environment, the company explicitly wants to move *other* applications to AWS, indicating a need for public cloud resources beyond a purely private setup. Option C (Hybrid cloud) is correct because it allows the company to seamlessly integrate its on-premises infrastructure for compliance-sensitive applications with AWS cloud services for other applications, typically using services like AWS Direct Connect or Site-to-Site VPN for secure connectivity. Option D (Multi-cloud) is incorrect because this model refers to using services from *multiple public cloud providers* (e.g., AWS and Azure simultaneously), which does not directly address the requirement of integrating on-premises systems with a single public cloud like AWS for this specific scenario.'
WHERE question_id = 'f9e7f430-d5dc-482f-af85-1b9aa7eefb12';

-- question_id: f9fcbb2a-0c26-4ca1-985f-eba72417f7b2
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon SageMaker is a fully managed service for building, training, and deploying machine learning models, and while it can be used with foundation models (e.g., via SageMaker JumpStart for deployment), its primary purpose is not providing direct, high-level access to a broad range of FMs for generative AI application development. Option B (correct) Amazon Bedrock is a fully managed service that provides direct access to a selection of high-performing foundation models from Amazon and leading AI companies through a single API, specifically designed for building and scaling generative AI applications. Option C (incorrect) Amazon Comprehend is an artificial intelligence service focused on natural language processing (NLP), designed for tasks such as sentiment analysis, entity recognition, and topic modeling, not for providing access to foundation models for generative AI. Option D (incorrect) AWS Lambda is a serverless compute service that lets you run code without provisioning or managing servers, and while it can be used to integrate with AI services, it does not directly provide access to foundation models itself.'
WHERE question_id = 'f9fcbb2a-0c26-4ca1-985f-eba72417f7b2';

-- question_id: fa6715ef-912a-454c-af7b-7a55fa990e65
-- answer_correct: True | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (correct) Fact-checking against reliable sources is a robust method to detect hallucinations, as AWS best practices for responsible AI recommend integrating generative AI models with authoritative knowledge bases, often using services like Amazon Kendra to retrieve verifiable facts from enterprise data, enabling validation of generated content against established truths. Option B (incorrect) Accepting all outputs without verification directly contradicts AWS''s responsible AI guidelines, which stress the importance of human oversight and robust evaluation metrics to ensure the accuracy and trustworthiness of AI systems, especially when dealing with the inherent risk of hallucinations in large language models. Option C (incorrect) Stating that no verification is needed completely disregards AWS''s commitment to responsible AI, which advocates for continuous evaluation, validation, and human-in-the-loop processes to mitigate risks such as factual inaccuracies or hallucinations in generative AI models before they impact production environments. Option D (incorrect) While random checking might offer a superficial glance, it is an insufficient and unreliable method for systematically detecting hallucinations in production-grade generative AI applications at scale, as AWS Responsible AI principles require comprehensive evaluation and often integration with factual knowledge bases to ensure factual accuracy, not just intermittent review.'
WHERE question_id = 'fa6715ef-912a-454c-af7b-7a55fa990e65';

-- question_id: fac40af6-8724-475b-9c28-d024317fa81d
-- answer_correct: True | verified_indices: [1, 4] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) While optimizing Glue job code and using efficient Glue versions (like 2.0 or newer) are good practices to reduce execution time and thus DPU-hours, and reducing DPU settings can save cost if the job is over-provisioned, these are less impactful and direct cost optimizations compared to the explicit features provided by Glue Flex or the fundamental efficiency of incremental loading for this scenario. Option B (correct) AWS Glue Flex execution class is specifically designed for non-urgent ETL jobs with flexible start times, offering up to 35% cost savings by utilizing spare capacity, which directly aligns with the company''s need for cost reduction and flexible timing. Option C (incorrect) Reducing the Redshift cluster size during a 200 GB data load operation would likely increase the load duration and overall Redshift cluster costs, as larger clusters typically load data faster, and elastic resize also incurs performance overhead or downtime. Option D (incorrect) AWS Lambda has a 15-minute execution limit, making it unsuitable for a complex 200 GB data loading job that currently takes 90 minutes with Glue, which requires a distributed processing framework. Option E (correct) Implementing incremental loading would reduce the daily data volume processed by Glue from 200 GB to only the new or changed data, significantly decreasing Glue''s processing time, DPU-hours, and thus overall costs.'
WHERE question_id = 'fac40af6-8724-475b-9c28-d024317fa81d';

-- question_id: fbd7f98a-a447-4463-b03c-d5134361d1f3
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option 0 (incorrect) Amazon Textract is designed for processing documents to extract text and data, whereas AWS services like Amazon Transcribe are used for converting audio content into text. Option 1 (correct) Amazon Textract is an optical character recognition (OCR) service that precisely extracts printed text, handwriting, and structured data, such as forms and tables, from scanned documents and images. Option 2 (incorrect) While Amazon Textract processes document images, its core purpose is to extract the textual and data content from within those images, not to extract or output the images themselves as its primary result. Option 3 (incorrect) While Amazon Textract can generate structural information about the extracted content, its primary function is to extract the actual text, forms, and tables from documents, rather than merely providing high-level file or document metadata.'
WHERE question_id = 'fbd7f98a-a447-4463-b03c-d5134361d1f3';

-- question_id: fc042310-b7aa-41c4-93db-e3a6e5bd6377
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS CloudTrail records API calls and other events as a logging and auditing service, but it does not use artificial intelligence to detect security threats. Option B (incorrect) AWS Config continuously monitors and assesses AWS resource configurations for compliance, but it does not employ artificial intelligence for threat detection. Option C (correct) Amazon GuardDuty is a threat detection service that continuously monitors AWS accounts and workloads for malicious activity and unauthorized behavior using machine learning, anomaly detection, and integrated threat intelligence. Option D (incorrect) AWS WAF is a web application firewall that protects web applications from common web exploits using rule-based filtering, but it does not primarily utilize artificial intelligence for broad security threat detection like GuardDuty.'
WHERE question_id = 'fc042310-b7aa-41c4-93db-e3a6e5bd6377';

-- question_id: fd397bbe-781a-4f57-94de-11c4b9077c8c
-- answer_correct: True | verified_indices: [1] | confidence: 90%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS Config focuses on evaluating resource configurations against desired states or predefined rules for compliance and configuration drift, rather than offering direct recommendations for security best practices violations like Trusted Advisor. Option B (correct) AWS Trusted Advisor provides real-time guidance across multiple categories, including security, specifically identifying security best practice violations and misconfigurations like overly permissive security groups or unencrypted S3 buckets. Option C (incorrect) AWS CloudFormation is a provisioning service used for defining and deploying infrastructure as code, not for auditing or identifying security best practice violations in deployed resources. Option D (incorrect) AWS Systems Manager is primarily an operational hub for automating management tasks across AWS resources, such as patching and running commands, and does not specialize in identifying security best practice violations across an entire AWS account.'
WHERE question_id = 'fd397bbe-781a-4f57-94de-11c4b9077c8c';

-- question_id: fd96dcfb-7030-4ea9-99a8-43d3689911ea
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Fine-tuning a model on proprietary data for real-time updates is expensive, time-consuming due to the need for frequent retraining as data changes, and risks model hallucination on specific facts not well-represented in the training data, making it less efficient than retrieval-based methods. Option B (correct) Retrieval Augmented Generation (RAG) with a vector database (e.g., using Amazon Aurora with pgvector or Amazon OpenSearch Service for vector storage, integrated with Amazon Bedrock) allows the model to retrieve up-to-date, external knowledge from the product database and company policies, ensuring accurate and grounded responses without the need for constant model retraining. Option C (incorrect) Training a large language model from scratch requires immense computational resources, vast amounts of proprietary data, and significant expertise, making it prohibitively expensive and time-consuming for most organizations compared to leveraging existing foundational models. Option D (incorrect) Using only zero-shot prompting with a foundational model (e.g., via Amazon Bedrock) relies solely on the model''s pre-trained knowledge and cannot access specific, proprietary, and constantly updated information from the company''s product database or policies, leading to generic or potentially incorrect responses.'
WHERE question_id = 'fd96dcfb-7030-4ea9-99a8-43d3689911ea';

-- question_id: fdde7775-9f67-4b9a-8a79-0232bbf9f1fb
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) AWS DataSync is designed for transferring large amounts of file or object data between on-premises storage and AWS, or between AWS storage services, not specifically for database migrations with minimal downtime. Option B (correct) AWS Database Migration Service (DMS) is specifically designed to facilitate the migration of databases to AWS with minimal downtime by keeping the source database operational during the migration process. Option C (incorrect) AWS Storage Gateway is used to connect on-premises environments to cloud storage, providing hybrid storage solutions, and is not designed for database migration. Option D (incorrect) AWS Direct Connect provides a dedicated network connection between your on-premises data center and AWS, which can accelerate data transfer but does not perform the database migration itself or offer specific minimal downtime features for databases.'
WHERE question_id = 'fdde7775-9f67-4b9a-8a79-0232bbf9f1fb';

-- question_id: fdf30e00-e41e-4549-815c-7a9c7cfdf8fc
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) refers to an organization''s internal efforts to optimize their cloud spend using tools like AWS Cost Explorer and AWS Budgets, rather than how the cloud provider''s scale inherently creates savings. Option B (correct) accurately describes how AWS''s vast global infrastructure, massive purchasing power for hardware, and highly efficient operations lead to lower per-unit costs for resources like EC2 instances or S3 storage, which AWS then translates into lower prices for all customers. Option C (incorrect) is the opposite of how economies of scale work in cloud computing, as the goal is to reduce costs for individual customers through efficiency and volume, not increase them. Option D (incorrect) would impede economies of scale, as cloud providers achieve significant cost savings through extensive infrastructure sharing and multi-tenancy across thousands of customers, efficiently utilizing resources like EC2 host servers and networking equipment.'
WHERE question_id = 'fdf30e00-e41e-4549-815c-7a9c7cfdf8fc';

-- question_id: fe2c5485-2b7f-45ed-9c58-49d6a51b7916
-- answer_correct: False | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{1}'::integer[],
    explanation = 'Option A (incorrect) DynamoDB with Global Secondary Index on score field would require complex and potentially slow pagination or scans to retrieve the top N players from millions of items, and GSIs are eventually consistent which might not meet real-time expectations for an actively changing leaderboard. Option B (correct) ElastiCache for Redis using sorted sets is specifically designed for ranking, allowing very fast O(log N) updates and O(log N + M) retrieval of the top M elements, ensuring sub-millisecond latency for real-time leaderboards at scale. Option C (incorrect) RDS MySQL with an indexed score column, while helpful, would likely struggle with the performance requirements for frequently updated real-time ranking of 5 million players, as `ORDER BY LIMIT` operations on large tables can be costly even with indexing. Option D (incorrect) Neptune graph database is optimized for relationships and complex traversals, making it an overly complex and inefficient choice for a simple scalar-value ranking problem like a leaderboard, which doesn''t leverage its core strengths.'
WHERE question_id = 'fe2c5485-2b7f-45ed-9c58-49d6a51b7916';

-- question_id: fe3543d2-8e61-4e9b-b069-902942dd587c
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) The Security pillar focuses on protecting information and systems, implementing controls like AWS WAF for application security or AWS IAM for access management, rather than primarily minimizing costs. Option B (incorrect) The Reliability pillar focuses on ensuring a workload performs its intended function correctly and consistently, building resilient architectures with services like multi-AZ deployments for RDS or automated failover, not on cost minimization. Option C (correct) The Cost Optimization pillar specifically focuses on running systems to deliver business value while minimizing costs by choosing appropriate resources, optimizing spend through services like EC2 Savings Plans, and managing expenditure with AWS Cost Explorer. Option D (incorrect) The Performance Efficiency pillar focuses on using computing resources efficiently to meet system requirements and maintain efficiency as demand changes, leveraging services like Amazon CloudFront for content delivery or Auto Scaling groups for dynamic capacity, not on direct cost reduction.'
WHERE question_id = 'fe3543d2-8e61-4e9b-b069-902942dd587c';

-- question_id: febcff23-7225-4aa8-bfe9-6247f66e3cfa
-- answer_correct: False | verified_indices: [0] | confidence: 100%
UPDATE public.mock_test_questions
SET
    correct_answer = '{0}'::integer[],
    explanation = 'Option A (correct) Amazon Bedrock Knowledge Bases for RAG is specifically designed to enable foundation models to generate responses using proprietary data by retrieving relevant information first, directly meeting the requirement to use internal data without modifying the underlying model or expensive fine-tuning. Option B (incorrect) Fine-tuning a pre-trained foundation model directly modifies the model''s weights and is an expensive process, which contradicts the stated key constraint of not modifying the underlying foundation model and avoiding expensive fine-tuning. Option C (incorrect) Amazon Bedrock Guardrails are used to enforce safety policies and filter harmful content, not to provide foundation models with access to and generation capabilities from private, proprietary datasets. Option D (incorrect) Selecting the largest available foundation model and relying on its general knowledge will not provide accurate or up-to-date answers from the company''s specific *internal, proprietary* research papers and drug formulations, as these models are trained on publicly available data.'
WHERE question_id = 'febcff23-7225-4aa8-bfe9-6247f66e3cfa';

-- question_id: fee3dd77-97f7-4029-a3e6-0720ec686d8e
-- answer_correct: True | verified_indices: [2] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Enabling Athena workgroup query result caching allows Athena to return results instantly for identical, previously run queries without re-executing them, but it does not bypass or optimize the initial query planning phase where Athena interacts with the Glue Data Catalog. Option B (incorrect) Consolidating physical partitions on S3 would reduce the total number of partitions in the Glue Data Catalog, which could help, but it requires significant data rewriting and ETL, and might still leave a substantial number of partitions if fine-grained access is needed, not directly addressing the catalog lookup overhead for planning as dramatically. Option C (correct) Implementing partition projection allows Athena to infer partition locations based on a defined pattern and query filters, completely bypassing the need to list thousands of partitions from the Glue Data Catalog during the planning phase, which dramatically reduces query planning time for time-series data. Option D (incorrect) Using Athena federated queries allows querying data from external data sources like RDS or DynamoDB, but it is not relevant for optimizing query planning time for existing data stored in Amazon S3 and cataloged in the Glue Data Catalog.'
WHERE question_id = 'fee3dd77-97f7-4029-a3e6-0720ec686d8e';

-- question_id: fef81f36-04f8-42c3-b962-4b55ac1d8437
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Model weights are stored as model artifacts, typically in Amazon S3, and are managed by SageMaker Model Registry or SageMaker Pipelines, not directly by SageMaker Model Cards. Option B (correct) SageMaker Model Cards are specifically designed to centralize and document essential information about a model''s purpose, training, performance, and ethical considerations, promoting transparency and explainability throughout its lifecycle. Option C (incorrect) Processing payments is a function of AWS Billing and payment processing services, which is entirely unrelated to the purpose of SageMaker Model Cards for machine learning models. Option D (incorrect) Model compression involves techniques applied to the model itself to reduce its size or complexity, and while a Model Card might describe if compression was used, it does not perform the compression.'
WHERE question_id = 'fef81f36-04f8-42c3-b962-4b55ac1d8437';

-- question_id: ff776a0b-224f-4088-ac0f-ede8397ab4a9
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Increasing the temperature parameter would make the chatbot''s responses more creative and varied, leading to less consistent information about return policies when using Amazon Bedrock inference configurations. Option B (correct) Using prompt templates with specific instructions directly guides the model, for example via Amazon Bedrock, to generate predefined and consistent information about return policies, ensuring factual accuracy and uniformity. Option C (incorrect) Reducing model size primarily impacts computational cost and performance but does not inherently guarantee more consistent information generation; consistency is more related to prompting and training rather than just model scale. Option D (incorrect) Disabling all safety features, such as those provided by Amazon Bedrock Guardrails, would remove safeguards that filter undesirable content, potentially leading to inconsistent or inappropriate responses rather than improving policy consistency.'
WHERE question_id = 'ff776a0b-224f-4088-ac0f-ede8397ab4a9';

-- question_id: ffd9b077-f889-427f-a4bf-3816ab9e0937
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) Amazon CloudWatch is a monitoring and observability service that collects data from your applications and AWS resources, but it does not have native capabilities to detect or analyze bias within machine learning models. Option B (correct) Amazon SageMaker Clarify is specifically designed to help detect potential bias in machine learning models by providing tools to analyze datasets for pre-training bias and model predictions for post-training bias. Option C (incorrect) AWS Config is a service that enables you to assess, audit, and evaluate the configurations of your AWS resources, helping with compliance and security, but it does not analyze ML models for bias. Option D (incorrect) Amazon Inspector is an automated security assessment service that helps improve the security and compliance of applications deployed on AWS by identifying vulnerabilities, not by detecting bias in machine learning models.'
WHERE question_id = 'ffd9b077-f889-427f-a4bf-3816ab9e0937';

-- question_id: fff48bbf-cfa9-42f4-9ce9-8f4fe8259563
-- answer_correct: True | verified_indices: [1] | confidence: 100%
UPDATE public.mock_test_questions
SET
    explanation = 'Option A (incorrect) S3 Glacier is optimized for long-term archiving and very infrequent access, incurring significant retrieval costs and delays that are not suitable for "occasionally needing full historical data." Option B (correct) Maintaining recent, frequently queried data in Redshift and offloading older, less frequently accessed data to S3 Standard (which can be queried via Redshift Spectrum) provides the optimal balance of query performance for hot data and cost efficiency for cold data. Option C (incorrect) While Redshift offers different node types or managed storage, keeping all 5 years of data within Redshift itself, even on tiered nodes, is generally more expensive than offloading older, cold data to S3. Option D (incorrect) Reloading large volumes of historical data into Redshift whenever it''s needed for occasional queries would be an operationally complex, time-consuming, and expensive process, failing to leverage Redshift Spectrum''s ability to directly query data in S3.'
WHERE question_id = 'fff48bbf-cfa9-42f4-9ce9-8f4fe8259563';

COMMIT;
