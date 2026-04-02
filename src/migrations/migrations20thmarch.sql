-- ═══════════════════════════════════════════════════════
-- Generated Hub Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Exam Guide Version: SOA-C03
-- Generated: 2026-03-20T03:20:13.723Z
-- Questions: 50 (50 validated, 4 rejected)
-- Quiz ID: quiz_domain24_5
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Module: m_24_2
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_133',
  'Match each AWS Systems Manager capability to its primary function.',
  'matching',
  '{"A":"AWS Systems Manager Run Command","B":"AWS Systems Manager Session Manager","C":"AWS Systems Manager Patch Manager"}'::json,
  NULL,
  'AWS Systems Manager Run Command (left[0]) is designed to execute commands on EC2 instances (right[0]) and on-premises servers. AWS Systems Manager Session Manager (left[1]) provides secure, interactive shell access to EC2 instances (right[1]) without needing to open inbound ports or manage SSH keys. AWS Systems Manager Patch Manager (left[2]) automates the process of scanning and patching managed instances with security updates (right[2]).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  1,
  '{"left":["AWS Systems Manager Run Command","AWS Systems Manager Session Manager","AWS Systems Manager Patch Manager"],"right":["Execute commands on EC2 instances","Securely access EC2 instances","Automate OS updates"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_134',
  'Match each service to its primary automation use case.',
  'matching',
  '{"A":"AWS Lambda","B":"Amazon EventBridge","C":"AWS Systems Manager State Manager"}'::json,
  NULL,
  'AWS Lambda (left[0]) is a serverless compute service that allows you to run code without provisioning or managing servers, making it ideal for serverless operational automation (right[0]). Amazon EventBridge (left[1]) is a serverless event bus that makes it easy to connect applications together using data from your own applications, integrated SaaS applications, and AWS services, enabling event-driven scheduling and routing (right[1]). AWS Systems Manager State Manager (left[2]) is used to maintain a defined configuration for your instances, ensuring configuration compliance enforcement (right[2]).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  2,
  '{"left":["AWS Lambda","Amazon EventBridge","AWS Systems Manager State Manager"],"right":["Serverless operational automation","Event-driven scheduling and routing","Configuration compliance enforcement"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_135',
  'Match each AWS Systems Manager feature to its key benefit.',
  'matching',
  '{"A":"AWS Systems Manager Session Manager","B":"AWS Systems Manager Patch Manager","C":"AWS Systems Manager Run Command"}'::json,
  NULL,
  'AWS Systems Manager Session Manager (left[0]) provides secure, audited access to instances, which eliminates the need for open inbound ports (right[0]) like SSH or RDP. AWS Systems Manager Patch Manager (left[1]) offers a centralized and automated solution for applying OS and software patches (right[1]) across a fleet of instances. AWS Systems Manager Run Command (left[2]) enables remote execution of scripts and commands (right[2]) across multiple instances simultaneously.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  3,
  '{"left":["AWS Systems Manager Session Manager","AWS Systems Manager Patch Manager","AWS Systems Manager Run Command"],"right":["Eliminates need for open inbound ports","Centralized and automated OS patching","Remote execution of scripts and commands"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_136',
  'Match the automation service to its primary scope.',
  'matching',
  '{"A":"AWS Systems Manager","B":"AWS Lambda","C":"Amazon EventBridge"}'::json,
  NULL,
  'AWS Systems Manager (left[0]) primarily focuses on operational insights and control over EC2 instances and OS management (right[0]), including patching, configuration, and remote access. AWS Lambda (left[1]) is a serverless compute service for running event-driven serverless functions (right[1]) in response to various triggers. Amazon EventBridge (left[2]) acts as a serverless event bus for centralized event routing and filtering (right[2]) from AWS services, SaaS applications, and custom applications.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  4,
  '{"left":["AWS Systems Manager","AWS Lambda","Amazon EventBridge"],"right":["EC2 instance and OS management","Event-driven serverless functions","Centralized event routing and filtering"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_137',
  'Match the AWS Systems Manager tool to its specific use.',
  'matching',
  '{"A":"AWS Systems Manager Session Manager","B":"AWS Systems Manager Patch Manager","C":"AWS Systems Manager State Manager"}'::json,
  NULL,
  'AWS Systems Manager Session Manager (left[0]) provides interactive shell access to instances (right[0]) without requiring SSH keys or bastion hosts. AWS Systems Manager Patch Manager (left[1]) automates the application of security updates for operating systems (right[1]) and applications. AWS Systems Manager State Manager (left[2]) ensures that instances maintain a desired state configuration enforcement (right[2]) over time.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  5,
  '{"left":["AWS Systems Manager Session Manager","AWS Systems Manager Patch Manager","AWS Systems Manager State Manager"],"right":["Interactive shell access to instances","Automated security updates for OS","Desired state configuration enforcement"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_138',
  'Match the service to its role in event-driven automation.',
  'matching',
  '{"A":"Amazon EventBridge","B":"AWS Lambda","C":"AWS Systems Manager Run Command"}'::json,
  NULL,
  'Amazon EventBridge (left[0]) is primarily used to route events to specific targets (right[0]) based on rules, acting as a central event bus. AWS Lambda (left[1]) is a serverless compute service that executes code in response to events (right[1]), such as S3 object uploads or API Gateway requests. AWS Systems Manager Run Command (left[2]) allows you to execute commands on demand or schedule (right[2]) on your managed instances, often triggered by other automation services.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  6,
  '{"left":["Amazon EventBridge","AWS Lambda","AWS Systems Manager Run Command"],"right":["Routes events to specific targets","Executes code in response to events","Executes commands on demand or schedule"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_139',
  'Match the AWS service to its operating system management function.',
  'matching',
  '{"A":"AWS Systems Manager Patch Manager","B":"AWS Systems Manager State Manager","C":"AWS Systems Manager Session Manager"}'::json,
  NULL,
  'AWS Systems Manager Patch Manager (left[0]) automates the process of scanning and applying OS and application updates (right[0]) to your instances. AWS Systems Manager State Manager (left[1]) is used to define and enforce consistent OS configurations (right[1]) across your server fleet. AWS Systems Manager Session Manager (left[2]) provides secure remote shell access (right[2]) to your EC2 instances without requiring direct SSH/RDP access.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  7,
  '{"left":["AWS Systems Manager Patch Manager","AWS Systems Manager State Manager","AWS Systems Manager Session Manager"],"right":["Automates OS and application updates","Enforces consistent OS configurations","Provides secure remote shell access"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_140',
  'Match the automation service to its typical trigger.',
  'matching',
  '{"A":"AWS Lambda","B":"Amazon EventBridge","C":"AWS Systems Manager Run Command"}'::json,
  NULL,
  'AWS Lambda (left[0]) functions are typically triggered by API calls or various AWS events (right[0]), such as S3 object changes or DynamoDB stream updates. Amazon EventBridge (left[1]) routes events from scheduled events or external sources (right[1]) to target services. AWS Systems Manager Run Command (left[2]) is initiated by manual or scheduled execution on instances (right[2]) through the Systems Manager console, CLI, or API.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  8,
  '{"left":["AWS Lambda","Amazon EventBridge","AWS Systems Manager Run Command"],"right":["API calls or various AWS events","Scheduled events or external sources","Manual or scheduled execution on instances"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_141',
  'Match the AWS service to its compliance or configuration management role.',
  'matching',
  '{"A":"AWS Systems Manager State Manager","B":"AWS Systems Manager Patch Manager","C":"AWS Systems Manager Session Manager"}'::json,
  NULL,
  'AWS Systems Manager State Manager (left[0]) ensures that your instances maintain a desired configuration state (right[0]) by applying policies. AWS Systems Manager Patch Manager (left[1]) manages OS security patches (right[1]) and application updates across your fleet. AWS Systems Manager Session Manager (left[2]) facilitates secure remote access (right[2]) to instances, which can be crucial for troubleshooting and maintaining compliance.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  9,
  '{"left":["AWS Systems Manager State Manager","AWS Systems Manager Patch Manager","AWS Systems Manager Session Manager"],"right":["Ensures desired configuration state","Manages OS security patches","Facilitates secure remote access"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_142',
  'Match each AWS Systems Manager capability to its primary function.',
  'matching',
  '{"A":"Systems Manager Run Command","B":"Systems Manager Session Manager","C":"Systems Manager Patch Manager"}'::json,
  NULL,
  'Systems Manager Run Command (left: 0) allows you to execute commands on multiple instances remotely (right: 1). Systems Manager Session Manager (left: 1) provides secure, interactive shell access to EC2 instances without opening inbound ports (right: 2). Systems Manager Patch Manager (left: 2) automates the process of patching operating systems and applications on EC2 instances (right: 0).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  10,
  '{"left":["Systems Manager Run Command","Systems Manager Session Manager","Systems Manager Patch Manager"],"right":["Automate OS and application patching","Execute commands on multiple instances remotely","Secure interactive shell access to instances"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_143',
  'Match the AWS Systems Manager feature to its specific automation purpose.',
  'matching',
  '{"A":"Systems Manager State Manager","B":"Systems Manager Patch Manager","C":"Systems Manager Run Command"}'::json,
  NULL,
  'Systems Manager State Manager (left: 0) is used to enforce configuration compliance across your EC2 instances by defining and applying desired states (right: 0). Systems Manager Patch Manager (left: 1) automates the patching of operating systems and applications (right: 2). Systems Manager Run Command (left: 2) is used to execute ad-hoc commands or scripts on instances (right: 1).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  11,
  '{"left":["Systems Manager State Manager","Systems Manager Patch Manager","Systems Manager Run Command"],"right":["Enforce configuration compliance across instances","Execute ad-hoc commands or scripts on instances","Automate the patching of operating systems"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_144',
  'Match the remote access method to its security and operational characteristics.',
  'matching',
  '{"A":"Systems Manager Session Manager","B":"SSH/RDP directly to EC2","C":"Bastion Host with SSH"}'::json,
  NULL,
  'Systems Manager Session Manager (left: 0) provides secure interactive shell access to EC2 instances without requiring open inbound ports or managing SSH keys (right: 1). Using SSH/RDP directly to EC2 instances (left: 1) requires open inbound ports on security groups and careful management of SSH keys or RDP credentials (right: 0). A Bastion Host with SSH (left: 2) is a dedicated server used to provide secure access to instances in private subnets, but it still relies on SSH and key management (right: 2).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  12,
  '{"left":["Systems Manager Session Manager","SSH/RDP directly to EC2","Bastion Host with SSH"],"right":["Requires open inbound ports and key management","Provides secure shell access without open inbound ports","Dedicated server for secure access, still requires SSH"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_145',
  'Match the AWS service to its primary role in operational automation.',
  'matching',
  '{"A":"AWS Lambda","B":"Amazon EventBridge","C":"Systems Manager Run Command"}'::json,
  NULL,
  'AWS Lambda (left: 0) provides serverless compute, allowing you to run code in response to events (right: 0). Amazon EventBridge (left: 1) is a serverless event bus that enables routing and scheduling events from various sources to targets (right: 2). Systems Manager Run Command (left: 2) is used to execute commands on EC2 instances remotely and at scale (right: 1).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  13,
  '{"left":["AWS Lambda","Amazon EventBridge","Systems Manager Run Command"],"right":["Serverless compute for event-driven code execution","Execute commands on EC2 instances remotely","Serverless event bus for routing and scheduling events"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_146',
  'Match the AWS service to its function in scheduling and event-driven automation.',
  'matching',
  '{"A":"Amazon EventBridge","B":"AWS Lambda","C":"Systems Manager State Manager"}'::json,
  NULL,
  'Amazon EventBridge (left: 0) is used to schedule tasks and route events from various sources to different targets (right: 2). AWS Lambda (left: 1) allows you to execute code in response to events or on a schedule (right: 1). Systems Manager State Manager (left: 2) is primarily used to maintain the desired configuration state of instances, not for general event routing or scheduling (right: 0).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  14,
  '{"left":["Amazon EventBridge","AWS Lambda","Systems Manager State Manager"],"right":["Maintain desired configuration state of instances","Execute code in response to events or schedules","Schedule tasks and route events to targets"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_147',
  'Match the AWS Systems Manager feature to its specific OS management task.',
  'matching',
  '{"A":"Systems Manager Patch Manager","B":"Systems Manager State Manager","C":"Systems Manager Run Command"}'::json,
  NULL,
  'Systems Manager Patch Manager (left: 0) automates the application of OS and software patches to EC2 instances (right: 0). Systems Manager State Manager (left: 1) ensures instances adhere to defined configurations and compliance policies (right: 2). Systems Manager Run Command (left: 2) is used to execute ad-hoc scripts or commands on instances for various operational tasks (right: 1).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  15,
  '{"left":["Systems Manager Patch Manager","Systems Manager State Manager","Systems Manager Run Command"],"right":["Automate the application of OS and software patches","Execute ad-hoc scripts or commands on instances","Ensure instances adhere to defined configurations"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_148',
  'Match the AWS service to its role in configuration and compliance management.',
  'matching',
  '{"A":"Systems Manager State Manager","B":"Systems Manager Patch Manager","C":"AWS Service Catalog"}'::json,
  NULL,
  'Systems Manager State Manager (left: 0) is used to enforce desired instance configurations and maintain compliance over time (right: 1). Systems Manager Patch Manager (left: 1) automates security updates for operating systems and applications (right: 0). AWS Service Catalog (left: 2) is used to standardize the provisioning of IT services, not directly for instance configuration compliance (right: 2).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  16,
  '{"left":["Systems Manager State Manager","Systems Manager Patch Manager","AWS Service Catalog"],"right":["Automate security updates for operating systems","Enforce desired instance configurations and compliance","Standardize provisioning of IT services"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_149',
  'Match the AWS service to its primary function in event-driven automation.',
  'matching',
  '{"A":"AWS Lambda","B":"Amazon EventBridge","C":"Systems Manager Run Command"}'::json,
  NULL,
  'AWS Lambda (left: 0) is a serverless compute service that executes code in response to events (right: 0). Amazon EventBridge (left: 1) acts as a centralized event bus for routing events from various sources to different targets (right: 1). Systems Manager Run Command (left: 2) enables the remote execution of commands on instances, often triggered by events but not primarily an event bus itself (right: 2).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  17,
  '{"left":["AWS Lambda","Amazon EventBridge","Systems Manager Run Command"],"right":["Execute serverless code in response to events","Centralized event bus for routing events","Remote execution of commands on instances"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_150',
  'Match the AWS service to its role in centralized operational management.',
  'matching',
  '{"A":"AWS Systems Manager","B":"AWS Service Catalog","C":"AWS CloudFormation"}'::json,
  NULL,
  'AWS Systems Manager (left: 0) provides operational insights and automation for AWS resources and on-premises servers (right: 0). AWS Service Catalog (left: 1) enables standardized provisioning and governance of IT services within an organization (right: 1). AWS CloudFormation (left: 2) is primarily used for Infrastructure as Code, provisioning and managing AWS resources through templates (right: 2).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  18,
  '{"left":["AWS Systems Manager","AWS Service Catalog","AWS CloudFormation"],"right":["Operational insights and automation for AWS resources","Standardized provisioning and governance of IT services","Infrastructure as Code for resource provisioning"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_2',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_151',
  'An operations team manages a critical application deployed on Amazon EC2 instances. They need to automate various operational tasks, including responding to specific events, scheduling routine maintenance, and orchestrating complex multi-step workflows. The team prioritizes a serverless approach to minimize operational overhead for the automation infrastructure itself. Match the appropriate AWS services to their primary roles in this automation strategy.',
  'matching',
  '{"A":"Triggering automation based on events","B":"Executing serverless code for tasks","C":"Scheduling recurring tasks","D":"Orchestrating complex operational runbooks"}'::json,
  NULL,
  'Option A (Triggering automation based on events) is a core capability of Amazon EventBridge, which acts as a serverless event bus to route events from AWS services, SaaS applications, and custom applications to various targets. Option B (Executing serverless code for tasks) is the domain of AWS Lambda, allowing execution of code without provisioning or managing servers. Option C (Scheduling recurring tasks) is efficiently handled by Amazon EventBridge Scheduler, which provides a flexible, serverless way to schedule tasks at scale. Option D (Orchestrating complex operational runbooks) is a key feature of AWS Systems Manager Automation, enabling multi-step workflows for operational tasks.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  19,
  '{"left":["Triggering automation based on events","Executing serverless code for tasks","Scheduling recurring tasks","Orchestrating complex operational runbooks"],"right":["AWS Lambda","Amazon EventBridge","AWS Systems Manager Automation","Amazon EventBridge Scheduler"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_152',
  'A development team is migrating a legacy application to AWS and needs to establish a robust CI/CD pipeline. They require a service that can automate the deployment of application code to various compute environments, including Amazon EC2 instances and serverless functions. The solution must support different deployment strategies like in-place and blue/green deployments, and integrate seamlessly with existing source control. Match the deployment-related AWS services to their primary functions in this scenario.',
  'matching',
  '{"A":"Automated application deployment","B":"Serverless compute for custom tasks","C":"Infrastructure as Code for resources","D":"Configuration management for instances"}'::json,
  NULL,
  'Option A (Automated application deployment) is the primary function of AWS CodeDeploy, which automates software deployments to various compute services such as Amazon EC2, AWS Lambda, and on-premises servers. Option B (Serverless compute for custom tasks) is provided by AWS Lambda, which can be used for event-driven automation or custom deployment hooks. Option C (Infrastructure as Code for resources) is handled by AWS CloudFormation, which allows defining and provisioning all AWS infrastructure resources in a declarative way. Option D (Configuration management for instances) is a capability of AWS Systems Manager State Manager, used to define and maintain a consistent configuration for EC2 instances.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  20,
  '{"left":["Automated application deployment","Serverless compute for custom tasks","Infrastructure as Code for resources","Configuration management for instances"],"right":["AWS Systems Manager State Manager","AWS CloudFormation","AWS CodeDeploy","AWS Lambda"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_153',
  'An organization is implementing a new security policy that mandates all remote access to Amazon EC2 instances must be fully audited, require no open inbound ports on the instances, and be managed centrally. The current practice involves using SSH/RDP, which poses security risks and operational overhead due to key management and firewall rules. The operations team needs to transition to a more secure and efficient method. Match the access methods to their characteristics in this context.',
  'matching',
  '{"A":"Secure, audited shell access without open ports","B":"Direct access requiring open inbound ports and key management","C":"Non-interactive script execution across instances","D":"Automated application deployment"}'::json,
  NULL,
  'Option A (Secure, audited shell access without open ports) is precisely what AWS Systems Manager Session Manager provides, eliminating the need for SSH keys or bastion hosts. Option B (Direct access requiring open inbound ports and key management) describes the traditional SSH/RDP approach, which is an anti-pattern (ap-3.2-001) due to its security and operational challenges. Option C (Non-interactive script execution across instances) is a capability of AWS Systems Manager Run Command, used for executing commands or scripts without interactive access. Option D (Automated application deployment) is the function of AWS CodeDeploy, which focuses on deploying application code, not remote access.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  21,
  '{"left":["Secure, audited shell access without open ports","Direct access requiring open inbound ports and key management","Non-interactive script execution across instances","Automated application deployment"],"right":["AWS Systems Manager Session Manager","SSH/RDP directly to EC2 instances","AWS Systems Manager Run Command","AWS CodeDeploy"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_154',
  'An e-commerce platform experiences fluctuating traffic and needs to scale its backend services efficiently. The operations team wants to implement automation for common tasks like starting/stopping instances, applying configuration changes, and responding to alerts, all while minimizing manual intervention. They are evaluating different AWS services to build a resilient and automated operational environment. Match the automation services to their most suitable use cases in this scenario.',
  'matching',
  '{"A":"Event-driven serverless compute","B":"Centralized event routing and scheduling","C":"Multi-step operational workflows","D":"Automated application deployment"}'::json,
  NULL,
  'Option A (Event-driven serverless compute) is a core use case for AWS Lambda, allowing execution of code in response to events without managing servers. Option B (Centralized event routing and scheduling) is the function of Amazon EventBridge, which can route events from various sources and schedule tasks. Option C (Multi-step operational workflows) is best handled by AWS Systems Manager Automation, which allows defining and executing complex runbooks for common operational tasks. Option D (Automated application deployment) is the primary purpose of AWS CodeDeploy, which automates software deployments to various compute services.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  22,
  '{"left":["Event-driven serverless compute","Centralized event routing and scheduling","Multi-step operational workflows","Automated application deployment"],"right":["AWS Lambda","Amazon EventBridge","AWS Systems Manager Automation","AWS CodeDeploy"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_155',
  'A company is looking to modernize its IT operations by adopting infrastructure as code and event-driven automation. They have a mix of legacy applications on Amazon EC2 and new serverless components. The goal is to reduce manual toil, improve consistency, and ensure faster response times to operational events. They need to understand how different AWS services can integrate to achieve these goals. Match the operational automation tools to their specific capabilities.',
  'matching',
  '{"A":"Automating responses to operational events","B":"Executing scheduled tasks at scale","C":"Centralizing configuration management for instances","D":"Deploying application code automatically"}'::json,
  NULL,
  'Option A (Automating responses to operational events) is a common use case for AWS Lambda, which can be invoked by various event sources to perform actions. Option B (Executing scheduled tasks at scale) is efficiently managed by Amazon EventBridge Scheduler, offering a serverless way to schedule recurring tasks. Option C (Centralizing configuration management for instances) is a key capability of AWS Systems Manager State Manager, which ensures instances maintain a desired configuration. Option D (Deploying application code automatically) is the primary function of AWS CodeDeploy, which automates the release process for applications.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  23,
  '{"left":["Automating responses to operational events","Executing scheduled tasks at scale","Centralizing configuration management for instances","Deploying application code automatically"],"right":["AWS Lambda","Amazon EventBridge Scheduler","AWS Systems Manager State Manager","AWS CodeDeploy"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_156',
  'An operations team needs to implement a robust patching strategy for their Amazon EC2 fleet, ensuring all instances receive critical security updates regularly without significant manual effort. They also need to ensure that specific applications and services are consistently configured across the fleet. The solution must be highly automated and provide clear visibility into compliance status. Match the AWS Systems Manager capabilities to these specific requirements.',
  'matching',
  '{"A":"Automated patching of operating systems","B":"Maintaining desired software configurations","C":"Running ad-hoc scripts on instances","D":"Secure interactive access to instances"}'::json,
  NULL,
  'Option A (Automated patching of operating systems) is the core function of AWS Systems Manager Patch Manager, designed for scanning and applying security updates. Option B (Maintaining desired software configurations) is handled by AWS Systems Manager State Manager, which ensures instances adhere to a predefined configuration. Option C (Running ad-hoc scripts on instances) is performed using AWS Systems Manager Run Command, allowing execution of commands or scripts across a fleet. Option D (Secure interactive access to instances) is provided by AWS Systems Manager Session Manager, offering a secure shell without opening ports.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  24,
  '{"left":["Automated patching of operating systems","Maintaining desired software configurations","Running ad-hoc scripts on instances","Secure interactive access to instances"],"right":["AWS Systems Manager Patch Manager","AWS Systems Manager State Manager","AWS Systems Manager Run Command","AWS Systems Manager Session Manager"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_2_157',
  'A company is building a new application and wants to adopt a serverless-first approach for its operational automation. They need to process data from Amazon S3, react to changes in AWS resources, and execute custom logic without managing underlying servers. The architecture should be highly scalable, cost-effective, and event-driven. Match the AWS services to their roles in this serverless automation strategy.',
  'matching',
  '{"A":"Executing event-driven code","B":"Centralized event bus for routing","C":"Object storage with event notifications","D":"Scheduling recurring tasks"}'::json,
  NULL,
  'Option A (Executing event-driven code) is the primary role of AWS Lambda, which runs code in response to events. Option B (Centralized event bus for routing) is provided by Amazon EventBridge, allowing events from various sources to trigger targets. Option C (Object storage with event notifications) is Amazon S3, which can publish events (e.g., object creation) that can trigger Lambda functions or EventBridge rules. Option D (Scheduling recurring tasks) is handled by Amazon EventBridge Scheduler, offering a serverless way to define cron-like jobs.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  25,
  '{"left":["Executing event-driven code","Centralized event bus for routing","Object storage with event notifications","Scheduling recurring tasks"],"right":["AWS Lambda","Amazon EventBridge","Amazon S3","Amazon EventBridge Scheduler"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_2',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Module: m_24_1
-- ─────────────────────────────────────────

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_126',
  'Match the AWS service to its primary function in infrastructure provisioning.',
  'matching',
  '{"A":"AWS CloudFormation","B":"AWS Service Catalog","C":"Amazon Machine Images (AMIs)"}'::json,
  NULL,
  'AWS CloudFormation (left[0]) is used for infrastructure as code deployment (right[0]), allowing you to define and provision AWS infrastructure in a declarative way. AWS Service Catalog (left[1]) enables organizations to create and manage catalogs of IT services that are approved for use on AWS, facilitating standardized resource provisioning (right[1]). Amazon Machine Images (AMIs) (left[2]) provide the information required to launch an EC2 instance, serving as standardized EC2 instance builds (right[2]) with pre-configured OS and software.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  26,
  '{"left":["AWS CloudFormation","AWS Service Catalog","Amazon Machine Images (AMIs)"],"right":["Infrastructure as code deployment","Standardized resource provisioning","Standardized EC2 instance builds"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_127',
  'Match the AWS CloudFormation feature to its purpose.',
  'matching',
  '{"A":"AWS CloudFormation Stacks","B":"AWS CloudFormation Templates","C":"AWS CloudFormation Change Sets"}'::json,
  NULL,
  'AWS CloudFormation Stacks (left[0]) are a collection of AWS resources (right[0]) that you manage as a single unit. AWS CloudFormation Templates (left[1]) are text files that define the AWS resources you want to deploy, acting as a blueprint for AWS resources (right[1]). AWS CloudFormation Change Sets (left[2]) allow you to preview how proposed changes to your stack template will affect your running resources before you implement them, enabling previewing infrastructure changes (right[2]).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  27,
  '{"left":["AWS CloudFormation Stacks","AWS CloudFormation Templates","AWS CloudFormation Change Sets"],"right":["Collection of AWS resources","Blueprint for AWS resources","Previewing infrastructure changes"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_128',
  'Match the AWS provisioning tool to its capability for large-scale deployments.',
  'matching',
  '{"A":"CloudFormation StackSets","B":"AWS Service Catalog","C":"Amazon Machine Images (AMIs)"}'::json,
  NULL,
  'CloudFormation StackSets (left[0]) extend CloudFormation functionality to enable deploying across accounts and Regions (right[0]) from a single template. AWS Service Catalog (left[1]) provides a centralized IT product catalog (right[1]) for end-users to provision approved AWS resources. Amazon Machine Images (AMIs) (left[2]) ensure a consistent EC2 instance base (right[2]) by providing a pre-configured operating system and software.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  28,
  '{"left":["CloudFormation StackSets","AWS Service Catalog","Amazon Machine Images (AMIs)"],"right":["Deploy across accounts and Regions","Centralized IT product catalog","Consistent EC2 instance base"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_129',
  'Match the AWS service to its role in managing cloud resources.',
  'matching',
  '{"A":"AWS CloudFormation","B":"AWS Service Catalog","C":"EC2 Launch Templates"}'::json,
  NULL,
  'AWS CloudFormation (left[0]) is used to define and provision infrastructure (right[0]) as code. AWS Service Catalog (left[1]) helps organizations govern approved IT products (right[1]) and ensure compliance. EC2 Launch Templates (left[2]) allow you to specify EC2 instance details (right[2]) such as AMI, instance type, and network settings for consistent instance launches.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  29,
  '{"left":["AWS CloudFormation","AWS Service Catalog","EC2 Launch Templates"],"right":["Define and provision infrastructure","Govern approved IT products","Specify EC2 instance details"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_130',
  'Match the AWS service to its primary use in deployment automation.',
  'matching',
  '{"A":"AWS CodeDeploy","B":"AWS OpsWorks","C":"AWS CloudFormation"}'::json,
  NULL,
  'AWS CodeDeploy (left[0]) is a service that automates application deployment (right[0]) to various compute services like EC2, AWS Fargate, and AWS Lambda. AWS OpsWorks (left[1]) is a configuration management service that uses Chef and Puppet to automate server configuration, deployment, and management (right[1]). AWS CloudFormation (left[2]) enables infrastructure provisioning as code (right[2]), defining all the AWS resources needed for an application.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  30,
  '{"left":["AWS CodeDeploy","AWS OpsWorks","AWS CloudFormation"],"right":["Automated application deployment","Configuration management and automation","Infrastructure provisioning as code"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_131',
  'Match the AWS CloudFormation concept to its stage in the resource lifecycle.',
  'matching',
  '{"A":"AWS CloudFormation Templates","B":"AWS CloudFormation Stacks","C":"AWS CloudFormation Drift detection"}'::json,
  NULL,
  'AWS CloudFormation Templates (left[0]) define resources to be provisioned (right[0]) in a declarative manner. AWS CloudFormation Stacks (left[1]) represent a deployed collection of resources (right[1]) managed by a single template. AWS CloudFormation Drift detection (left[2]) is a feature used to identify manual changes to resources (right[2]) that were originally provisioned by CloudFormation, indicating a deviation from the template.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  31,
  '{"left":["AWS CloudFormation Templates","AWS CloudFormation Stacks","AWS CloudFormation Drift detection"],"right":["Define resources to be provisioned","Deployed collection of resources","Identify manual changes to resources"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_132',
  'Match the EC2 provisioning component to its function.',
  'matching',
  '{"A":"Amazon Machine Images (AMIs)","B":"EC2 Launch Templates","C":"AWS CloudFormation"}'::json,
  NULL,
  'Amazon Machine Images (AMIs) (left[0]) provide a standardized instance OS and software (right[0]) environment for launching EC2 instances. EC2 Launch Templates (left[1]) serve as a configuration for EC2 instance launches (right[1]), specifying parameters like AMI, instance type, and security groups. AWS CloudFormation (left[2]) provides a declarative infrastructure definition (right[2]) for provisioning and managing all AWS resources, including EC2 instances and their associated components.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  32,
  '{"left":["Amazon Machine Images (AMIs)","EC2 Launch Templates","AWS CloudFormation"],"right":["Standardized instance OS and software","Configuration for EC2 instance launches","Declarative infrastructure definition"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_133',
  'Match the AWS service to its role in governance and control over resource provisioning.',
  'matching',
  '{"A":"AWS Service Catalog","B":"AWS CloudFormation","C":"CloudFormation StackSets"}'::json,
  NULL,
  'AWS Service Catalog (left[0]) allows organizations to create and manage a catalog of curated IT services for end-users (right[0]), ensuring compliance and governance. AWS CloudFormation (left[1]) provides infrastructure as code enforcement (right[1]) by defining resources in templates, preventing manual deviations. CloudFormation StackSets (left[2]) enable consistent multi-account and multi-Region governance (right[2]) by deploying common CloudFormation stacks across multiple AWS accounts and Regions.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  33,
  '{"left":["AWS Service Catalog","AWS CloudFormation","CloudFormation StackSets"],"right":["Curated IT services for end-users","Infrastructure as code enforcement","Multi-account and multi-Region governance"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_134',
  'Match the AWS tool to its contribution to infrastructure consistency.',
  'matching',
  '{"A":"AWS CloudFormation","B":"Amazon Machine Images (AMIs)","C":"EC2 Launch Templates"}'::json,
  NULL,
  'AWS CloudFormation (left[0]) ensures infrastructure consistency through its declarative infrastructure definition (right[0]), allowing resources to be provisioned and updated reliably. Amazon Machine Images (AMIs) (left[1]) provide a consistent base for EC2 instances (right[1]) by encapsulating the OS, applications, and configurations. EC2 Launch Templates (left[2]) enforce standardized EC2 launch parameters (right[2]), ensuring that all instances launched from the template adhere to predefined settings.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  34,
  '{"left":["AWS CloudFormation","Amazon Machine Images (AMIs)","EC2 Launch Templates"],"right":["Declarative infrastructure definition","Consistent base for EC2 instances","Standardized EC2 launch parameters"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'easy'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_135',
  'Match each AWS CloudFormation concept to its description.',
  'matching',
  '{"A":"CloudFormation Template","B":"CloudFormation Stack","C":"CloudFormation Change Set"}'::json,
  NULL,
  'CloudFormation Templates (left: 0) are JSON or YAML files that define the AWS resources you want to provision (right: 1). A CloudFormation Stack (left: 1) is the collection of AWS resources provisioned by a template (right: 0). A CloudFormation Change Set (left: 2) provides a preview of how proposed updates will affect your running resources before you implement them (right: 2).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  35,
  '{"left":["CloudFormation Template","CloudFormation Stack","CloudFormation Change Set"],"right":["A collection of AWS resources provisioned by a template","A JSON or YAML file defining AWS resources","A preview of proposed updates to a stack"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_136',
  'Match the AWS resource provisioning tool to its primary function.',
  'matching',
  '{"A":"AWS CloudFormation","B":"AWS Service Catalog","C":"AWS CDK"}'::json,
  NULL,
  'AWS CloudFormation (left: 0) is used to provision and manage AWS infrastructure as code (right: 2). AWS Service Catalog (left: 1) allows organizations to manage a catalog of approved IT services for users to provision (right: 1). AWS CDK (Cloud Development Kit) (left: 2) enables developers to define cloud infrastructure using familiar programming languages (right: 0).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  36,
  '{"left":["AWS CloudFormation","AWS Service Catalog","AWS CDK"],"right":["Define cloud infrastructure using familiar programming languages","Manage a catalog of approved IT services for users","Provision and manage AWS infrastructure as code"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_137',
  'Match each EC2 image and launch configuration component to its purpose.',
  'matching',
  '{"A":"Amazon Machine Image (AMI)","B":"EC2 Launch Template","C":"EC2 Launch Configuration"}'::json,
  NULL,
  'An Amazon Machine Image (AMI) (left: 0) provides the information required to launch an EC2 instance, serving as a standardized base image (right: 0). An EC2 Launch Template (left: 1) is the modern and recommended method for defining instance parameters for Auto Scaling groups and on-demand instances (right: 1). An EC2 Launch Configuration (left: 2) is an older, legacy method for defining instance parameters for Auto Scaling groups (right: 2).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  37,
  '{"left":["Amazon Machine Image (AMI)","EC2 Launch Template","EC2 Launch Configuration"],"right":["A standardized base image for EC2 instances","A modern method to define instance parameters for Auto Scaling groups","A legacy method to define instance parameters for Auto Scaling groups"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_138',
  'Match the deployment and configuration management service to its primary use case.',
  'matching',
  '{"A":"AWS CodeDeploy","B":"AWS OpsWorks","C":"AWS CloudFormation"}'::json,
  NULL,
  'AWS CodeDeploy (left: 0) automates application deployments to various compute services like EC2, AWS Lambda, and Amazon ECS (right: 0). AWS OpsWorks (left: 1) is a configuration management service that uses Chef or Puppet to automate server configuration (right: 2). AWS CloudFormation (left: 2) is used to provision and manage AWS infrastructure as code (right: 1).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  38,
  '{"left":["AWS CodeDeploy","AWS OpsWorks","AWS CloudFormation"],"right":["Automates application deployments to various compute services","Provisions and manages AWS infrastructure as code","Configuration management service using Chef or Puppet"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_139',
  'Match the AWS CloudFormation feature to its capability.',
  'matching',
  '{"A":"CloudFormation Drift Detection","B":"CloudFormation StackSets","C":"CloudFormation Nested Stacks"}'::json,
  NULL,
  'CloudFormation Drift Detection (left: 0) identifies manual changes made to stack resources that cause them to deviate from the template (right: 1). CloudFormation StackSets (left: 1) allow you to deploy stacks across multiple accounts and AWS Regions from a single CloudFormation template (right: 0). CloudFormation Nested Stacks (left: 2) enable you to create reusable components within a single stack, promoting modularity (right: 2).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  39,
  '{"left":["CloudFormation Drift Detection","CloudFormation StackSets","CloudFormation Nested Stacks"],"right":["Deploys stacks across multiple accounts and AWS Regions","Identifies manual changes made to stack resources","Enables reusable components within a single stack"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_140',
  'Match the AWS service or concept to its role in standardized resource provisioning.',
  'matching',
  '{"A":"AWS Service Catalog","B":"Amazon Machine Image (AMI)","C":"AWS CloudFormation"}'::json,
  NULL,
  'AWS Service Catalog (left: 0) provides a centralized catalog for approved IT services that users can provision (right: 1). An Amazon Machine Image (AMI) (left: 1) serves as a base image for launching EC2 instances with a predefined configuration (right: 0). AWS CloudFormation (left: 2) enables declarative infrastructure provisioning using templates, ensuring consistent deployments (right: 2).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  40,
  '{"left":["AWS Service Catalog","Amazon Machine Image (AMI)","AWS CloudFormation"],"right":["A base image for launching EC2 instances","A centralized catalog for approved IT services","Declarative infrastructure provisioning using templates"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_141',
  'Match the Infrastructure as Code (IaC) tool to its primary method of operation.',
  'matching',
  '{"A":"AWS CloudFormation","B":"AWS CDK","C":"AWS CodeDeploy"}'::json,
  NULL,
  'AWS CloudFormation (left: 0) defines infrastructure using declarative JSON or YAML templates (right: 0). AWS CDK (Cloud Development Kit) (left: 1) allows defining infrastructure using familiar programming languages like Python or TypeScript (right: 2). AWS CodeDeploy (left: 2) automates the application deployment lifecycle, not infrastructure provisioning (right: 1).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  41,
  '{"left":["AWS CloudFormation","AWS CDK","AWS CodeDeploy"],"right":["Defines infrastructure using JSON/YAML templates","Automates application deployment lifecycle","Defines infrastructure using programming languages"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_142',
  'Match the AWS service to its capability for multi-account or standardized deployments.',
  'matching',
  '{"A":"CloudFormation StackSets","B":"AWS CDK","C":"AWS Service Catalog"}'::json,
  NULL,
  'CloudFormation StackSets (left: 0) enable you to deploy CloudFormation stacks across multiple AWS accounts and Regions from a single template (right: 1). AWS CDK (left: 1) allows you to programmatically define and deploy infrastructure using high-level programming languages (right: 0). AWS Service Catalog (left: 2) is used to offer a curated catalog of IT services for users to provision securely (right: 2).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  42,
  '{"left":["CloudFormation StackSets","AWS CDK","AWS Service Catalog"],"right":["Programmatically define and deploy infrastructure","Deploy CloudFormation stacks across multiple accounts/Regions","Offer a curated catalog of IT services for users"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_143',
  'Match the CloudFormation approach to its outcome regarding stack consistency.',
  'matching',
  '{"A":"Manual changes to resources","B":"Using CloudFormation Change Sets","C":"Applying all changes via CloudFormation"}'::json,
  NULL,
  'Making manual changes to CloudFormation-managed resources (left: 0) causes stack drift, making the deployed infrastructure inconsistent with the template (right: 1). Using CloudFormation Change Sets (left: 1) allows you to preview proposed updates to a stack before executing them (right: 2). Applying all infrastructure changes exclusively via CloudFormation (left: 2) ensures consistency between your template and actual resources, maintaining traceability (right: 0).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  43,
  '{"left":["Manual changes to resources","Using CloudFormation Change Sets","Applying all changes via CloudFormation"],"right":["Ensures infrastructure consistency and traceability","Causes stack drift and template inconsistency","Previews proposed updates before execution"]}'::json,
  '{"left":[0,1,2],"right":[0,1,2]}'::jsonb,
  'm_24_1',
  'medium'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_144',
  'An organization is standardizing its infrastructure provisioning process using Infrastructure as Code (IaC) to ensure consistency, repeatability, and version control. They manage environments across multiple AWS accounts and Regions, and need a way to provision common baseline resources efficiently. Furthermore, they want to empower development teams with self-service provisioning of approved AWS resources while maintaining governance. Match the AWS services to their roles in this comprehensive provisioning strategy.',
  'matching',
  '{"A":"Defining infrastructure as code","B":"Deploying stacks across accounts/Regions","C":"Self-service provisioning of approved resources","D":"Identifying manual changes to IaC resources"}'::json,
  NULL,
  'Option A (Defining infrastructure as code) is the core function of AWS CloudFormation, allowing declarative definition of AWS resources. Option B (Deploying stacks across accounts/Regions) is achieved using AWS CloudFormation StackSets, which extends CloudFormation to manage stacks across multiple target accounts and Regions. Option C (Self-service provisioning of approved resources) is the purpose of AWS Service Catalog, enabling organizations to create and manage catalogs of IT services that are approved for use on AWS. Option D (Identifying manual changes to IaC resources) is handled by AWS CloudFormation Drift Detection, which identifies when a stack''s actual configuration differs from its CloudFormation template, addressing anti-pattern ap-3.1-001.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  44,
  '{"left":["Defining infrastructure as code","Deploying stacks across accounts/Regions","Self-service provisioning of approved resources","Identifying manual changes to IaC resources"],"right":["AWS CloudFormation","AWS CloudFormation StackSets","AWS Service Catalog","AWS CloudFormation Drift Detection"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_145',
  'An IT department wants to provide a self-service portal for developers to provision approved AWS resources, such as specific EC2 instances, Amazon RDS databases, and S3 buckets, without granting them full AWS console access. The resources must adhere to organizational standards and cost controls. Additionally, the department needs to manage the underlying infrastructure definitions using code and detect any unauthorized changes. Match the AWS services to these governance and provisioning requirements.',
  'matching',
  '{"A":"Curated self-service resource provisioning","B":"Declarative infrastructure definition","C":"Identifying configuration drift in IaC","D":"Programmatic infrastructure definition"}'::json,
  NULL,
  'Option A (Curated self-service resource provisioning) is the primary function of AWS Service Catalog, allowing organizations to create and manage catalogs of IT services approved for use on AWS. Option B (Declarative infrastructure definition) is achieved with AWS CloudFormation, which uses templates to define AWS resources. Option C (Identifying configuration drift in IaC) is handled by AWS CloudFormation Drift Detection, which identifies when actual resource configurations deviate from their CloudFormation template, addressing anti-pattern ap-3.1-001. Option D (Programmatic infrastructure definition) is a capability of AWS CDK, which allows defining cloud infrastructure using familiar programming languages.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  45,
  '{"left":["Curated self-service resource provisioning","Declarative infrastructure definition","Identifying configuration drift in IaC","Programmatic infrastructure definition"],"right":["AWS Service Catalog","AWS CloudFormation","AWS CloudFormation Drift Detection","AWS CDK"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_146',
  'An organization is committed to maintaining a secure and consistent environment for its Amazon EC2 instances. This involves ensuring that all new instances are launched from approved, hardened images and that any deviations from the desired infrastructure state are promptly identified and remediated. They also need a streamlined process for updating the underlying infrastructure definitions. Match the AWS services and features to these image management and infrastructure maintenance practices.',
  'matching',
  '{"A":"Automated creation of secure AMIs","B":"Identifying unauthorized changes to CloudFormation resources","C":"Previewing proposed CloudFormation changes","D":"Defining base server images for EC2"}'::json,
  NULL,
  'Option A (Automated creation of secure AMIs) is a key feature of EC2 Image Builder, which automates the pipeline for creating and maintaining custom images. Option B (Identifying unauthorized changes to CloudFormation resources) is the role of AWS CloudFormation Drift Detection, which helps identify manual changes to resources managed by CloudFormation (anti-pattern ap-3.1-001). Option C (Previewing proposed CloudFormation changes) is done using AWS CloudFormation Change Sets, allowing administrators to see how proposed changes to a stack might impact running resources. Option D (Defining base server images for EC2) is the fundamental purpose of an Amazon Machine Image (AMI), which serves as a template for launching EC2 instances.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  46,
  '{"left":["Automated creation of secure AMIs","Identifying unauthorized changes to CloudFormation resources","Previewing proposed CloudFormation changes","Defining base server images for EC2"],"right":["EC2 Image Builder","AWS CloudFormation Drift Detection","AWS CloudFormation Change Sets","Amazon Machine Image (AMI)"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_147',
  'A DevOps team is responsible for managing the lifecycle of infrastructure and applications. They need to define their infrastructure using code, automate application deployments, and ensure that developers can provision approved resources without direct access to the underlying infrastructure. The team also wants to detect any manual modifications to their infrastructure to prevent configuration drift. Match the AWS services to their primary functions in this integrated DevOps environment.',
  'matching',
  '{"A":"Infrastructure as Code for resource provisioning","B":"Automated application deployment to various targets","C":"Self-service portal for approved resources","D":"Detecting configuration changes outside of IaC"}'::json,
  NULL,
  'Option A (Infrastructure as Code for resource provisioning) is the core capability of AWS CloudFormation, allowing declarative definition of AWS resources. Option B (Automated application deployment to various targets) is the primary function of AWS CodeDeploy, which automates software deployments to EC2, Lambda, and on-premises servers. Option C (Self-service portal for approved resources) is provided by AWS Service Catalog, enabling controlled provisioning of IT services. Option D (Detecting configuration changes outside of IaC) is handled by AWS CloudFormation Drift Detection, which identifies manual modifications to CloudFormation-managed resources (anti-pattern ap-3.1-001).',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  47,
  '{"left":["Infrastructure as Code for resource provisioning","Automated application deployment to various targets","Self-service portal for approved resources","Detecting configuration changes outside of IaC"],"right":["AWS CloudFormation","AWS CodeDeploy","AWS Service Catalog","AWS CloudFormation Drift Detection"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_148',
  'An operations team needs to manage a fleet of Amazon EC2 instances, ensuring they are consistently configured and updated. They are evaluating different methods for defining instance launch parameters and managing the underlying operating system images. The goal is to maximize flexibility, support versioning, and enable automated image pipelines. Match the AWS services and features to their specific roles in this instance management strategy.',
  'matching',
  '{"A":"Template for EC2 instance launch parameters","B":"Automated pipeline for custom OS images","C":"Standardized base image for EC2 instances","D":"Defining infrastructure using programming languages"}'::json,
  NULL,
  'Option A (Template for EC2 instance launch parameters) is provided by EC2 Launch Templates, which offer a modern and flexible way to define instance configurations for various launch scenarios. Option B (Automated pipeline for custom OS images) is the primary function of EC2 Image Builder, which automates the creation and maintenance of secure and up-to-date AMIs. Option C (Standardized base image for EC2 instances) is an Amazon Machine Image (AMI), which serves as a template for launching instances. Option D (Defining infrastructure using programming languages) is the purpose of AWS CDK, which allows programmatic definition of infrastructure, including components that might use AMIs and Launch Templates.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  48,
  '{"left":["Template for EC2 instance launch parameters","Automated pipeline for custom OS images","Standardized base image for EC2 instances","Defining infrastructure using programming languages"],"right":["EC2 Launch Templates","EC2 Image Builder","Amazon Machine Image (AMI)","AWS CDK"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_149',
  'A company is adopting Infrastructure as Code (IaC) using AWS CloudFormation to manage its cloud resources. They want to ensure that all infrastructure changes are reviewed and applied through CloudFormation, and that any manual modifications to resources are identified and corrected. The team also needs to manage standardized resource offerings for internal users. Match the CloudFormation features and related services to these IaC governance and maintenance requirements.',
  'matching',
  '{"A":"Previewing proposed infrastructure changes","B":"Detecting manual changes to CloudFormation resources","C":"Standardized self-service provisioning","D":"Defining infrastructure in code"}'::json,
  NULL,
  'Option A (Previewing proposed infrastructure changes) is the function of AWS CloudFormation Change Sets, which allows administrators to see how changes to a stack template will affect running resources before applying them. Option B (Detecting manual changes to CloudFormation resources) is handled by AWS CloudFormation Drift Detection, which identifies when a stack''s actual configuration deviates from its template, addressing anti-pattern ap-3.1-001. Option C (Standardized self-service provisioning) is provided by AWS Service Catalog, enabling users to provision approved AWS resources. Option D (Defining infrastructure in code) is the core purpose of AWS CloudFormation, which uses templates to describe desired resources.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  49,
  '{"left":["Previewing proposed infrastructure changes","Detecting manual changes to CloudFormation resources","Standardized self-service provisioning","Defining infrastructure in code"],"right":["AWS CloudFormation Change Sets","AWS CloudFormation Drift Detection","AWS Service Catalog","AWS CloudFormation"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id, difficulty)
VALUES (
  'q_24_m_24_1_150',
  'An organization is implementing a new strategy for provisioning and managing its AWS infrastructure. They aim to automate as much as possible, ensure consistency across environments, and provide developers with tools that integrate seamlessly into their existing development workflows. This includes defining infrastructure programmatically, deploying common resource sets across multiple accounts, and maintaining standardized server images. Match the AWS services to their roles in this advanced provisioning strategy.',
  'matching',
  '{"A":"Programmatic infrastructure definition","B":"Deploying common stacks across accounts","C":"Automated custom AMI creation","D":"Centralized self-service for approved resources"}'::json,
  NULL,
  'Option A (Programmatic infrastructure definition) is the primary benefit of AWS CDK, allowing developers to define cloud resources using familiar programming languages. Option B (Deploying common stacks across accounts) is a key capability of AWS CloudFormation StackSets, enabling centralized, consistent deployments across multiple AWS accounts and Regions. Option C (Automated custom AMI creation) is handled by EC2 Image Builder, which streamlines the process of building, testing, and distributing secure and compliant AMIs. Option D (Centralized self-service for approved resources) is the function of AWS Service Catalog, providing a curated portfolio of IT services for end-users.',
  NOW(),
  'quiz_domain24_5',
  NOW(),
  50,
  '{"left":["Programmatic infrastructure definition","Deploying common stacks across accounts","Automated custom AMI creation","Centralized self-service for approved resources"],"right":["AWS CDK","AWS CloudFormation StackSets","EC2 Image Builder","AWS Service Catalog"]}'::json,
  '{"left":[0,1,2,3],"right":[0,1,2,3]}'::jsonb,
  'm_24_1',
  'hard'
) ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Link questions to quiz
-- ─────────────────────────────────────────
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_133'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_134'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_135'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_136'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_137'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_138'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_139'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_140'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_141'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_142'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_143'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_144'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_145'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_146'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_147'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_148'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_149'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_150'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_151'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_152'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_153'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_154'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_155'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_156'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_2_157'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_126'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_127'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_128'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_129'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_130'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_131'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_132'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_133'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_134'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_135'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_136'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_137'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_138'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_139'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_140'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_141'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_142'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_143'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_144'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_145'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_146'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_147'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_148'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_149'),
  (NOW(), 'quiz_domain24_5', 'q_24_m_24_1_150')
ON CONFLICT DO NOTHING;

-- Update quiz question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain24_5'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;
