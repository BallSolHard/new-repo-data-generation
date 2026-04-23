-- MCQ Questions Verification - Invalid Questions
-- Generated SQL UPDATE statements for questions requiring review
-- ============================================================================
-- Questions are appended as they are verified

BEGIN;

-- Question ID: q_20_m_20_2_26
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon EC2 Spot Instances (Option A) are ideal for fault-tolerant, flexible batch jobs as they offer significant cost savings (up to 90% off On-Demand prices) in exchange for potential interruptions. Since the job is fault-tolerant and can be resumed, it''s a perfect fit. AWS Lambda (Option B) has a maximum execution duration of 15 minutes, making it unsuitable for a 3-hour job. Reserved Instances (Option C) provide cost savings for predictable, long-term workloads but do not offer the same level of savings as Spot Instances for fault-tolerant batch jobs. Running On-Demand during off-peak hours (Option D) does not inherently reduce compute costs, only potentially network transfer costs, and still misses the significant savings of Spot Instances.'
WHERE id = 'q_20_m_20_2_26';

-- Question ID: q_20_m_20_2_27
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing an Amazon EC2 Auto Scaling group with dynamic scaling policies (Option B) allows the application to automatically adjust its EC2 instance capacity based on real-time demand, ensuring responsiveness during spikes and minimizing resource waste during off-peak periods. Manually scaling (Option A) is reactive, prone to human error, and does not minimize resource waste effectively. Provisioning larger instances (Option C) leads to continuous over-provisioning and higher costs during low demand. Using AWS Lambda (Option D) is a serverless approach, but it has a 15-minute execution limit, which might not be suitable for all API processes, and the question implies existing EC2 instances are in use, suggesting a scaling solution for them.'
WHERE id = 'q_20_m_20_2_27';

-- Question ID: q_20_m_20_2_28
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Implementing the image processing as AWS Lambda functions triggered by Amazon S3 object creation events (Option C) is the most suitable serverless solution. Lambda allows the development team to focus solely on application code without managing servers, and its execution model is perfect for event-driven, short-duration tasks like image processing. Deploying on Amazon EC2 (Option A) or Amazon ECS with EC2 launch type (Option B) requires managing underlying servers or container instances, which contradicts the requirement to avoid server management. Amazon EMR (Option D) is designed for big data processing, which is overkill and more complex for individual image processing tasks.'
WHERE id = 'q_20_m_20_2_28';

-- Question ID: q_20_m_20_2_29
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Deploying containerized microservices on Amazon ECS using the AWS Fargate launch type (Option B) is the correct solution. Fargate provides serverless compute for containers, completely abstracting away the need to provision, patch, or scale the underlying virtual machines, allowing the team to focus on application logic. Using Amazon ECS with the EC2 launch type (Option A) still requires managing the underlying EC2 instances. Running containers directly on EC2 (Option C) involves significant manual operational overhead. AWS Batch (Option D) is designed for batch processing, not for continuously running microservices like a product catalog.'
WHERE id = 'q_20_m_20_2_29';

-- Question ID: q_20_m_20_2_30
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Containerizing the application and running it as jobs on AWS Batch (Option C) is the most appropriate solution. AWS Batch is designed for running large-scale batch computing workloads, managing the compute environment, and scaling resources to handle many concurrent jobs efficiently. AWS Lambda (Option A) has a maximum execution duration of 15 minutes, making it unsuitable for tasks that take 45 minutes. Deploying on Amazon EC2 with Auto Scaling (Option B) is a valid approach but requires more operational overhead for server management compared to AWS Batch. Amazon EMR (Option D) is primarily for big data processing frameworks like Spark or Hadoop, which might be overkill if the application is a standalone complex calculation.'
WHERE id = 'q_20_m_20_2_30';

-- Question ID: q_20_m_20_2_31
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Deploying an Amazon EMR cluster (Option C) is the most suitable choice. Amazon EMR is a managed service specifically designed for running big data frameworks like Apache Spark, Hadoop, and Hive, simplifying the provisioning, scaling, and management of clusters. Manually installing Spark on EC2 instances (Option A) would incur significant operational overhead. AWS Glue (Option B) is a serverless ETL service that can run Spark jobs, but EMR offers more control and flexibility over the Spark environment and cluster configuration, which is often preferred for complex research workloads. AWS Lambda (Option D) is unsuitable for long-running, compute-intensive Spark jobs due to its 15-minute execution limit.'
WHERE id = 'q_20_m_20_2_31';

-- Question ID: q_20_m_20_2_32
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Implementing the backend service using AWS Lambda functions triggered by Amazon API Gateway (Option C) provides a fully serverless solution that meets all requirements. It offers high availability, automatically scales to handle millions of concurrent requests, and incurs costs only when requests are being processed, minimizing operational overhead. Deploying on Amazon EC2 (Option A) or Amazon ECS with EC2 launch type (Option B) requires managing underlying servers or container instances, which increases operational overhead. Provisioning a single large EC2 instance (Option D) creates a single point of failure, does not scale automatically, and is prone to over-provisioning or under-provisioning.'
WHERE id = 'q_20_m_20_2_32';

-- Question ID: q_20_m_20_2_33
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Leveraging AWS Batch (Option C) is the most suitable solution for long-running, compute-intensive video transcoding jobs. AWS Batch can manage a fleet of compute resources, execute jobs that run for hours, and scale efficiently based on the workload. AWS Lambda (Option A) has a hard execution limit of 15 minutes, making it unsuitable for tasks that take several hours. Deploying a custom fleet of EC2 instances (Option B) requires significant operational overhead for managing the infrastructure and job queue. Amazon Kinesis Data Streams (Option D) is designed for real-time streaming data, not for long-running batch processing of large video files.'
WHERE id = 'q_20_m_20_2_33';

-- Question ID: q_20_m_20_2_34
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Running the containerized build agents on Amazon ECS using the AWS Fargate launch type (Option C) is the ideal serverless container solution. Fargate eliminates the need to manage EC2 instances, allowing the team to focus on their CI/CD tasks while providing rapid scaling for compute-intensive containerized workloads. Deploying on Amazon EC2 instances (Option A) requires managing the underlying EC2 infrastructure, which the team wants to avoid. AWS Lambda (Option B) has a 15-minute execution limit, making it unsuitable for tasks that can run for up to 20 minutes. Amazon EMR (Option D) is for big data processing, not general-purpose CI/CD build agents.'
WHERE id = 'q_20_m_20_2_34';

-- Question ID: q_20_m_20_2_35
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'AWS Batch is designed for running batch computing workloads and can handle jobs that run for extended periods, far exceeding the 15-minute timeout of AWS Lambda. By using Spot Instances, it also offers significant cost savings, and it integrates well with Amazon S3 event notifications for automated triggering. Option B is correct. Option C is incorrect because AWS Lambda has a maximum execution duration of 15 minutes, which is insufficient for tasks that can take up to 45 minutes. Option D involves managing EC2 instances and custom polling scripts, which increases operational overhead compared to a fully managed service like AWS Batch. Option 4, while using Fargate for serverless containers, suggests manual launching for each job, which does not meet the requirement for automated processing without manual intervention.'
WHERE id = 'q_20_m_20_2_35';

-- Question ID: q_20_m_20_2_36
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'An Amazon EC2 Auto Scaling group with a target tracking scaling policy based on average CPU utilization allows the application to automatically add or remove instances to maintain a desired CPU level, effectively scaling with demand and minimizing costs during off-peak times. Option B is correct. Option C is incorrect because manually provisioning a fixed number of instances for peak load leads to over-provisioning and wasted resources during low demand. Option D is incorrect because a full web application with potentially long-running sessions or complex server-side logic is generally not suitable for AWS Lambda functions due to execution limits and cold start considerations, and it would require significant re-architecture. Option 4 provides some cost savings but does not allow for automatic scaling in response to unexpected traffic spikes or variations within business hours.'
WHERE id = 'q_20_m_20_2_36';

-- Question ID: q_20_m_20_2_37
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon EC2 Spot Instances are ideal for fault-tolerant batch workloads that can tolerate interruptions, offering up to 90% savings compared to On-Demand prices. This directly addresses the goal of significantly reducing compute costs for non-time-sensitive, interruptible jobs. Option C is correct. Option B is incorrect because On-Demand Instances are the most expensive option and do not provide cost savings for interruptible workloads. Option A is incorrect because Reserved Instances provide a discount for consistent, long-term usage, but Spot Instances offer much greater savings for interruptible workloads. Option D is incorrect because Dedicated Hosts are used for specific licensing or compliance requirements and are not a cost-optimization strategy for general batch processing.'
WHERE id = 'q_20_m_20_2_37';

-- Question ID: q_20_m_20_2_38
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon ECS with AWS Fargate launch type provides a serverless compute engine for containers, eliminating the need to provision, configure, or scale clusters of virtual machines. This allows the team to focus solely on their application code and containers, meeting the requirement for the least infrastructure management. Option C is correct. Option A is incorrect because Amazon ECS with EC2 launch type requires managing the underlying EC2 instances, including patching and scaling. Option B is incorrect because AWS Lambda has a 15-minute execution limit, which is generally not suitable for continuous containerized applications, and Step Functions orchestrate workflows, not directly run continuous applications. Option D is incorrect because Amazon EKS on Amazon EC2 instances involves significant operational overhead for managing the Kubernetes control plane and worker nodes.'
WHERE id = 'q_20_m_20_2_38';

-- Question ID: q_20_m_20_2_39
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'AWS Lambda is a serverless, event-driven compute service that automatically scales from zero to meet demand and charges only for the compute time consumed, making it ideal for short-duration, independent requests with minimal idle costs. Option A is correct. Option B, Amazon EC2 instances with Auto Scaling, would incur costs even when instances are idle, and managing the scaling configuration adds operational overhead compared to Lambda. Option C, Amazon ECS on EC2, also requires managing underlying EC2 instances and incurs costs for idle capacity. Option D, Amazon EKS, is a container orchestration service that introduces significant management complexity and cost for this specific, simple, event-driven use case.'
WHERE id = 'q_20_m_20_2_39';

-- Question ID: q_20_m_20_4_26
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Deploying Amazon CloudFront with caching enabled for static assets (Option B) is the most effective solution. CloudFront is a Content Delivery Network (CDN) that caches static content at edge locations worldwide, significantly reducing latency for users regardless of their geographical location. Increasing EC2 bandwidth (Option A) only helps at the origin and does not address global latency. AWS Site-to-Site VPN (Option C) is for private network connectivity between on-premises and AWS, not for public website performance. Migrating to S3 Standard-IA (Option D) is a cost optimization for storage, not a performance improvement for content delivery.'
WHERE id = 'q_20_m_20_4_26';

-- Question ID: q_64_m_64_1_1
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Validating feasibility through proof-of-concepts (PoC) is crucial for complex GenAI integrations before full-scale development, as per the module description.'
WHERE id = 'q_64_m_64_1_1';

-- Question ID: q_20_m_20_4_27
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing AWS Global Accelerator (Option B) is the most effective way to improve network performance and reduce latency for a global player base. Global Accelerator uses AWS''s global network backbone to route user traffic to the closest healthy endpoint, bypassing congested public internet routes and providing consistent performance. Amazon Route 53 latency-based routing (Option A) uses DNS, which can be cached and does not always route over the optimal network path. ALBs (Option C) distribute traffic within a Region, not globally. AWS Direct Connect (Option D) provides private connectivity from on-premises to AWS, which is not feasible for individual players.'
WHERE id = 'q_20_m_20_4_27';

-- Question ID: q_20_m_20_4_28
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing AWS Transit Gateway (Option B) is the correct solution for centralizing routing and simplifying inter-VPC communication in a hub-and-spoke model. For 15+ VPCs, VPC peering connections become unmanageable due to their non-transitive nature and the O(n^2) complexity. Creating additional VPC peering connections (Option A) exacerbates the management complexity. Deploying EC2 routing appliances (Option C) adds significant operational overhead and is not a managed solution. AWS PrivateLink (Option D) is for providing private access to specific services, not for general inter-VPC network communication.'
WHERE id = 'q_20_m_20_4_28';

-- Question ID: q_20_m_20_4_29
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Establishing an AWS Direct Connect connection (Option B) provides a dedicated, private network link between the on-premises data center and AWS, offering consistent low latency and high bandwidth, which is superior to VPN over the public internet. Upgrading a VPN connection (Option A) may improve throughput but will still contend with the variable nature of the public internet. AWS Global Accelerator (Option C) optimizes routing over the public internet but does not provide a private, dedicated connection. Amazon CloudFront (Option D) is a CDN for content delivery to end-users, not for private data center connectivity.'
WHERE id = 'q_20_m_20_4_29';

-- Question ID: q_20_m_20_4_30
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Configuring an Application Load Balancer (ALB) (Option B) is the correct choice. ALBs operate at the application layer (Layer 7) and support advanced routing features such as path-based routing, host-based routing, and HTTP/HTTPS traffic distribution across multiple EC2 instances in different Availability Zones for high availability. A Network Load Balancer (NLB) (Option A) operates at Layer 4 and does not support application-level routing features. Amazon Route 53 DNS failover (Option C) provides high availability at the DNS level but does not distribute traffic across multiple instances within a healthy endpoint. A Classic Load Balancer (CLB) (Option D) provides basic HTTP/HTTPS load balancing but lacks the advanced routing features of an ALB.'
WHERE id = 'q_20_m_20_4_30';

-- Question ID: q_20_m_20_4_31
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Implementing Amazon CloudFront with separate behaviors for static content caching and dynamic content proxying (Option C) is the optimal solution. CloudFront can cache static assets at edge locations for low-latency delivery and also optimize dynamic content delivery by maintaining persistent connections to the origin and performing TLS termination at the edge. Deploying in a single Region (Option A) will result in high latency for global users. AWS Global Accelerator (Option B) improves routing to origins but does not cache content. Route 53 latency-based routing (Option D) uses DNS, which can be cached, and doesn''t offer the same performance optimizations as CloudFront for dynamic content or caching for static content.'
WHERE id = 'q_20_m_20_4_31';

-- Question ID: q_20_m_20_4_32
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Utilizing AWS DataSync (Option B) to automate and accelerate online data transfer over a dedicated network connection (like AWS Direct Connect, implied by ''high-throughput and reliable way'') to Amazon S3 is the most effective solution. DataSync is optimized for large-scale, high-performance data transfers. Increasing internet bandwidth (Option A) may help but doesn''t guarantee reliability or consistent high throughput for large files over the public internet. An AWS Site-to-Site VPN (Option C) provides encryption but may not offer the required throughput or reliability for hundreds of GBs compared to DataSync over a dedicated linkif VPN is chosen for high throughput). AWS Snowball (Option D) is for offline data transfer of extremely large datasets (100+ TB) when network transfer is infeasible, not for frequent online uploads.'
WHERE id = 'q_20_m_20_4_32';

-- Question ID: q_20_m_20_4_33
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Direct Connect provides a dedicated private network connection from an on-premises data center to AWS, bypassing the public internet. This ensures consistent low-latency and high-throughput, which is critical for financial transactions and meets the 10 Gbps requirement. Option B is correct. Option A is incorrect because AWS Site-to-Site VPN traverses the public internet, which can result in variable latency and throughput, making it unsuitable for consistent low-latency requirements. Option C is incorrect as an EC2-based VPN still relies on the public internet and adds management overhead. Option D is incorrect because an internet gateway provides public internet access and does not create a private connection to the VPC.'
WHERE id = 'q_20_m_20_4_33';

-- Question ID: q_20_m_20_4_34
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS Transit Gateway is designed for connecting thousands of VPCs and on-premises networks through a central hub, simplifying network management and providing transitive routing. This is ideal for a hub-and-spoke topology with many VPCs. Option C is correct. Option A is incorrect because VPC peering connections are non-transitive and would require an O(n^2) number of connections for a fully meshed network or a complex web of connections for hub-and-spoke with 15+ VPCs, making it unscalable and difficult to manage. Option B is incorrect because VPN connections are typically used for connecting to on-premises networks, not for inter-VPC connectivity at this scale. Option D is incorrect because an ALB operates at the application layer and is used for distributing HTTP/HTTPS traffic to targets, not for inter-VPC routing.'
WHERE id = 'q_20_m_20_4_34';

-- Question ID: q_20_m_20_4_35
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Global Accelerator uses the AWS global network to route user traffic to the optimal endpoint, improving performance and reliability for applications, especially those using non-HTTP protocols like TCP/UDP. It provides static IP addresses that act as a fixed entry point to your application endpoints in multiple AWS Regions, reducing latency by directing traffic over the AWS backbone network. Option B is correct. Option A, Amazon CloudFront, is primarily for HTTP/HTTPS content delivery and caching, not for raw TCP/UDP game traffic. Option C, an Application Load Balancer, operates at Layer 7 (HTTP/HTTPS) and is not suitable for custom TCP/UDP protocols. Option D, Amazon Route 53 latency-based routing, directs users to the nearest endpoint based on DNS resolution but still relies on the public internet for the actual data transfer, which Global Accelerator aims to optimize by using the AWS network.'
WHERE id = 'q_20_m_20_4_35';

-- Question ID: q_20_m_20_1_26
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Provisioning an Amazon EFS file system and mounting it across all Linux-based Amazon EC2 instances (Option C) is the correct solution. Amazon EFS provides a scalable, shared file system that supports POSIX permissions, allows concurrent access from multiple EC2 instances, and scales automatically. Storing data in Amazon S3 (Option A) is object storage and does not support POSIX file system semantics or concurrent file modification patterns directly. Attaching individual EBS volumes (Option B) does not provide shared access, and custom synchronization is complex and error-prone. Amazon FSx for Windows File Server (Option D) is designed for Windows environments and SMB protocol, not native Linux POSIX file systems.'
WHERE id = 'q_20_m_20_1_26';

-- Question ID: q_20_m_20_1_27
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Provisioning an Amazon EBS gp3 volume and attaching it to the EC2 instance (Option C) is the correct solution. EBS gp3 volumes provide consistent baseline performance (3,000 IOPS and 125 MiB/s included) and allow independent provisioning of IOPS and throughput, making them ideal for relational databases requiring low latency and predictable performance. Amazon S3 (Option A) is object storage, not block storage, and cannot be directly attached to an EC2 instance for a database. Amazon EFS (Option B) is a network file system, which introduces higher latency than block storage and is not suitable for a single-instance relational database. Amazon FSx for Lustre (Option D) is a high-performance file system for compute-intensive workloads, but EBS is the standard for directly attached block storage for databases on EC2.'
WHERE id = 'q_20_m_20_1_27';

-- Question ID: q_20_m_20_1_28
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Using Amazon S3 Glacier Flexible Retrieval (Option B) for the video archives is the most cost-effective solution for rarely accessed, immutable data that can tolerate retrieval times of several hours. It offers significant cost savings compared to other S3 storage classes. Amazon S3 Standard-IA (Option A) is for infrequently accessed data that requires millisecond retrieval, which is more expensive than Glacier and not necessary given the several-hour retrieval tolerance. Amazon S3 Standard (Option C) is the most expensive S3 storage class and is unsuitable for rarely accessed archives. Amazon EBS Snapshots (Option D) are for backing up EBS volumes, not for general-purpose archiving of petabytes of video files.'
WHERE id = 'q_20_m_20_1_28';

-- Question ID: q_20_m_20_1_29
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon EBS General Purpose SSD (gp3) volumes provide a consistent baseline performance (3,000 IOPS and 125 MiB/s throughput included) independent of volume size, and allows provisioning additional IOPS and throughput separately. This eliminates the reliance on burst credits that gp2 volumes have, ensuring consistent high performance during sustained I/O activity while being more cost-effective than gp2 for many workloads. Option C is correct. Option A is incorrect because while increasing gp2 size provides more burst credits, it still relies on a burst model and can deplete under sustained load. Option B, Cold HDD (sc1), is for infrequently accessed, large sequential workloads and is not suitable for a critical database requiring high performance. Option D, Throughput Optimized HDD (st1), is for frequently accessed, throughput-intensive workloads like big data, but not for the IOPS-intensive needs of a database.'
WHERE id = 'q_20_m_20_1_29';

-- Question ID: q_20_m_20_1_30
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon Elastic File System (Amazon EFS) provides a scalable, elastic, shared file system that is fully managed and supports POSIX file system semantics, including file locking and strong consistency, making it ideal for applications requiring shared file access from multiple EC2 instances. Option B is correct. Option A is incorrect because Amazon S3 is object storage and does not support POSIX file system semantics like file locking or append operations, making it unsuitable for frequently modified data requiring such features. Option C is incorrect because attaching EBS volumes to each instance would not provide a shared file system and would require complex manual synchronization. Option D is incorrect because S3 Glacier Flexible Retrieval is for archival data with retrieval times in hours, not for frequently modified files requiring immediate access.'
WHERE id = 'q_20_m_20_1_30';

-- Question ID: q_20_m_20_1_31
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon EBS Provisioned IOPS SSD (io2) volumes provide block storage that is directly attached to a single EC2 instance, offering the lowest latency and highest performance for single-instance workloads. Option A is correct. Option B is incorrect because Amazon EFS is a network file system that introduces network latency, making it suboptimal for latency-sensitive single-instance workloads compared to direct-attached block storage. Option C, Amazon S3, is object storage and is not suitable for block-level, low-latency access required by HPC applications. Option D, Amazon FSx for Lustre, is a high-performance file system, but it''s typically used for shared access across multiple compute instances and still involves network latency, which is higher than direct-attached EBS for a single instance.'
WHERE id = 'q_20_m_20_1_31';

-- Question ID: q_20_m_20_1_32
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'An S3 Lifecycle policy that transitions objects to S3 Standard-IA after 90 days (for infrequently accessed data) and then to S3 Glacier Flexible Retrieval after 365 days (for archival data with retrieval within hours) directly addresses the access patterns and cost optimization requirements. Option B is correct. Option A, S3 Intelligent-Tiering, could work but might incur per-object monitoring and automation fees that could be higher than a well-defined lifecycle policy for predictable access patterns. Option C is incorrect because S3 Glacier Deep Archive has a minimum retrieval time of 12 hours, which might not reliably meet the ''within a few hours'' requirement. Option D, S3 Standard, is the most expensive option for infrequently accessed and archival data, failing to minimize storage costs.'
WHERE id = 'q_20_m_20_1_32';

-- Question ID: q_20_m_20_1_33
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Storage Gateway''s File Gateway configuration presents an NFS or SMB file interface to on-premises applications, allowing them to store files locally while asynchronously uploading them to Amazon S3. This provides seamless integration with existing file-based tools, continuous backup, and leverages S3''s durability and scalability. Option B is correct. Option A, manual uploads, is not continuous, requires manual intervention, and increases operational overhead. Option C, AWS DataSync, is primarily for large-scale, one-time, or scheduled transfers, not for continuous, real-time synchronization via a local mount point. Option D, mounting Amazon EFS over the internet, is generally not recommended for performance and security reasons for continuous, high-volume log ingestion and would require Direct Connect or VPN for optimal performance.'
WHERE id = 'q_20_m_20_1_33';

-- Question ID: q_20_m_20_3_26
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon RDS for MySQL is a fully managed relational database service that supports complex SQL queries, multi-table joins, transactions, foreign keys, and stored procedures, making it the most appropriate choice for migrating a legacy relational application with minimal code changes. Option A is correct. Option B is incorrect because Amazon DynamoDB is a NoSQL key-value and document database that is not designed for complex relational joins and transactions. Option C, Amazon Redshift, is a data warehouse service optimized for analytical queries on large datasets, not for transactional applications requiring complex joins and real-time updates. Option D, Amazon ElastiCache for Redis, is an in-memory data store used for caching, not as a primary transactional database.'
WHERE id = 'q_20_m_20_3_26';

-- Question ID: q_20_m_20_5_26
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'For non-time-ordered data that needs to be processed in batches, using Amazon SQS to queue incoming data and then writing it to Amazon S3 for storage is a cost-effective and simple solution. S3 is ideal for large-scale batch processing, and SQS provides reliable message queuing. Option A is correct. Option B is incorrect because Amazon Kinesis Data Streams is optimized for real-time, time-ordered streaming data, which is an overkill and more expensive for non-time-ordered batch processing. Option C is incorrect because Amazon Kinesis Data Firehose delivering to Redshift is more suited for streaming data analytics, not simple batch ingestion to S3. Option D describes components for a data lake query, not the ingestion pipeline itself.'
WHERE id = 'q_20_m_20_5_26';

-- Question ID: q_20_m_20_5_27
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'For transferring large datasets (100+ TB) like 200 TB, AWS Snowball provides physical devices that can be shipped to AWS for offline data transfer, which is significantly faster and more cost-effective than transferring over the network, especially with limited internet bandwidth. Option B is correct. Option A is incorrect because transferring 200 TB over the network, even with AWS DataSync''s acceleration, would still take a considerable amount of time and might be impractical given the limited bandwidth. Option C, AWS Direct Connect, provides a dedicated network connection but setting it up can take time, and for a one-time migration of 200 TB, Snowball is often more efficient. Option D, manual copy via AWS CLI, would be slow and unreliable over limited internet bandwidth.'
WHERE id = 'q_20_m_20_5_27';

-- Question ID: q_20_m_20_5_28
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Glue is a fully managed, serverless ETL service that automatically provisions and scales the necessary compute resources for ETL jobs. It integrates with the AWS Glue Data Catalog and is designed for large datasets, minimizing operational overhead. Option B is correct. Option A is incorrect because provisioning EC2 instances and installing Spark requires significant operational overhead for server management, patching, and scaling. Option C, Amazon EMR, is a managed service for big data processing but still requires cluster management and configuration, which is more operational overhead than AWS Glue. Option D, custom Python scripts on AWS Lambda, is suitable for small, short-running transformations but not typically for complex, large-scale ETL jobs that might exceed Lambda''s resource limits.'
WHERE id = 'q_20_m_20_5_28';

-- Question ID: q_20_m_20_5_29
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS DataSync is a data transfer service that simplifies, automates, and accelerates moving data between on-premises storage systems (like NAS) and AWS storage services like Amazon S3. It handles scripting, scheduling, monitoring, and data integrity, making it ideal for continuous, high-performance synchronization. Option C is correct. Option A, manually copying with `aws s3 sync`, is not automated, lacks acceleration, and requires manual management. Option B, AWS Transfer Family, is for providing fully managed SFTP, FTPS, and FTP endpoints for external users, not for internal, automated data synchronization from on-premises NAS to S3. Option D, mounting EFS on-premises, is possible but EFS is a file system, not a transfer service, and DataSync is specifically designed for high-performance, automated transfers to S3.'
WHERE id = 'q_20_m_20_5_29';

-- Question ID: q_20_m_20_5_30
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon Athena is a serverless, interactive query service that makes it easy to analyze data directly in Amazon S3 using standard SQL. It requires no infrastructure to manage, and users pay only for the queries they run, making it ideal for ad-hoc analysis of large datasets in a data lake. Option B is correct. Option A, Amazon Redshift, is a data warehouse that requires loading data and managing a cluster, which contradicts the ''no traditional database or infrastructure management'' requirement. Option C, Amazon RDS for PostgreSQL, is a transactional database and would require loading the data and managing the instance, which is not serverless. Option D, AWS Glue, is an ETL service for transforming data, not an interactive query service itself, although it can prepare data for Athena.'
WHERE id = 'q_20_m_20_5_30';

-- Question ID: q_20_m_20_2_40
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS Batch (Option C) is designed for running large-scale batch computing workloads efficiently. It supports containerized jobs, automatically provisions compute resources, and integrates well with S3 events for triggering. Its ability to handle long-running jobs (exceeding 15 minutes) and scale automatically makes it ideal for this scenario. AWS Lambda (Option A) has a maximum execution duration of 15 minutes, which is insufficient for 45-minute video conversions. While Amazon EC2 with Auto Scaling (Option B) can handle the workload, it requires more operational overhead for managing the EC2 instances, operating system, and container runtime compared to AWS Batch. Amazon EMR (Option D) is typically used for big data processing frameworks like Hadoop and Spark, which might be overkill and more complex for simple file conversions, increasing operational overhead.'
WHERE id = 'q_20_m_20_2_40';

-- Question ID: q_20_m_20_2_41
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon ECS with AWS Fargate launch type (Option C) is a serverless compute engine for containers that removes the need to provision, configure, and scale clusters of virtual machines. This aligns perfectly with the requirement for the least infrastructure management effort, allowing the team to focus on application code. Amazon ECS with EC2 launch type (Option A) requires managing the underlying EC2 instances, including patching and scaling, which the team wants to avoid. Running Docker Swarm on Amazon EC2 instances (Option B) involves significant operational overhead for managing the EC2 instances and the Swarm cluster itself. Amazon EKS (Option D) also requires managing the underlying EC2 instances or using Fargate. If EKS is used with self-managed EC2 instances, it still requires infrastructure management.'
WHERE id = 'q_20_m_20_2_41';

-- Question ID: q_20_m_20_2_42
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Spot Instances (Option D) are ideal for fault-tolerant, flexible batch processing jobs that can tolerate interruptions. They offer significant cost savings (up to 90% off On-Demand prices) by utilizing unused EC2 capacity. This directly addresses the company''s goal of minimizing costs for interruptible workloads if On-Demand instances were chosen. On-Demand Instances (Option A) provide guaranteed capacity but at a higher cost, which is not optimal for interruptible jobs. Reserved Instances (Option B) offer discounts for consistent, long-term workloads but require a commitment and are not as cost-effective for flexible, interruptible batch jobs as Spot Instances. Dedicated Hosts (Option C) are used for specific licensing or regulatory requirements and are the most expensive option, not suitable for cost optimization of general batch processing.'
WHERE id = 'q_20_m_20_2_42';

-- Question ID: q_20_m_20_4_36
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon CloudFront (Option B) is a global content delivery network (CDN) that caches both static and dynamic content at edge locations worldwide. This significantly reduces latency for global users by serving content closer to them and optimizing network paths to the origin for dynamic content. AWS Global Accelerator (Option A) improves performance for TCP/UDP traffic by routing it through the AWS global network, but it does not cache content at edge locations like CloudFront. AWS Direct Connect (Option C) provides a private connection between an on-premises data center and AWS, which is not applicable for improving end-user latency from different continents to a web application. Amazon Route 53 latency-based routing (Option D) would only direct users to the single `us-east-1` endpoint, which still incurs high latency for users far from that region and does not cache content.'
WHERE id = 'q_20_m_20_4_36';

-- Question ID: q_20_m_20_4_37
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS Direct Connect (Option C) provides a dedicated, private network connection from an on-premises data center to AWS. This ensures consistent high bandwidth and predictable low latency, bypassing the public internet, which directly addresses the requirements. An AWS Site-to-Site VPN connection (Option A) uses the public internet, which can introduce variable latency and bandwidth, making it unsuitable for consistent low-latency and high-bandwidth requirements. VPC peering (Option B) connects two VPCs within AWS, not an on-premises network to a VPC. An Internet Gateway (Option D) is used for public internet access from a VPC and does not provide a private, dedicated connection to an on-premises data center.'
WHERE id = 'q_20_m_20_4_37';

-- Question ID: q_20_m_20_4_38
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Transit Gateway (Option B) is designed for connecting thousands of VPCs and on-premises networks to a central hub, creating a scalable hub-and-spoke architecture. It simplifies network management and routing, which is ideal for this scenario. Establishing individual VPC peering connections (Option A) between every pair of VPCs becomes unmanageable and unscalable as the number of VPCs grows (O(n^2) connections), and VPC peering is non-transitive. Configuring Virtual Private Gateways and connecting them via VPN (Option C) is primarily for connecting VPCs to on-premises networks, not for inter-VPC communication within AWS in a scalable hub-and-spoke manner. NAT Gateway (Option D) is used to allow private subnets to access the internet, not for inter-VPC communication.'
WHERE id = 'q_20_m_20_4_38';

-- Question ID: q_20_m_20_4_39
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'An Application Load Balancer (ALB) (Option C) operates at the application layer (Layer 7) and supports advanced routing features such as path-based routing (`/api/*`, `/images/*`), host-based routing, and query string parameters. It is ideal for HTTP and HTTPS traffic, provides high availability, and integrates seamlessly with Auto Scaling groups. A Network Load Balancer (NLB) (Option A) operates at the transport layer (Layer 4) and is optimized for extreme performance and static IP addresses, but it does not support content-based routing. A Classic Load Balancer (CLB) (Option B) is an older generation load balancer that supports basic HTTP/HTTPS routing but lacks the advanced content-based routing capabilities of an ALB. Amazon Route 53 (Option D) is a DNS service and can direct traffic to a load balancer, but it does not perform load balancing or content-based routing at the application layer itself.'
WHERE id = 'q_20_m_20_4_39';

-- Question ID: q_20_m_20_1_34
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon S3 File Gateway, a component of AWS Storage Gateway (Option B), provides a file interface (NFS or SMB) that allows on-premises applications to store files in Amazon S3. It includes local caching for frequently accessed data, meeting the requirement to integrate without application modification and cache recent reports. AWS DataSync (Option A) is a data transfer service for moving large amounts of data between on-premises storage and AWS, but it doesn''t provide a continuous file interface with local caching for an existing application. Amazon S3 Glacier (Option C) is for archival storage and does not offer a file system interface or local caching for active applications. AWS Transfer Family (Option D) provides fully managed SFTP, FTPS, and FTP services for transferring files directly into and out of Amazon S3, but it''s not a file gateway with local caching for an existing application.'
WHERE id = 'q_20_m_20_1_34';

-- Question ID: q_20_m_20_3_27
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon Aurora PostgreSQL-Compatible Edition with Multi-AZ deployment (Option B) is a fully managed relational database service that supports complex relational queries, multi-table joins, and ACID transactions, making it ideal for a legacy relational application. Its Multi-AZ deployment ensures high availability. Amazon DynamoDB (Option A) is a NoSQL key-value and document database that is not optimized for complex relational joins and transactions. Amazon Redshift (Option C) is a data warehousing service optimized for analytical queries over large datasets, not for transactional processing of an operational application. Amazon ElastiCache for Redis (Option D) is an in-memory caching service, not a primary database, and would not fulfill the core database requirements.'
WHERE id = 'q_20_m_20_3_27';

-- Question ID: q_20_m_20_3_28
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon ElastiCache for Memcached (Option C) is an in-memory caching service that is excellent for caching frequently accessed data, such as popular articles. By caching these query results, it significantly reduces the load on the primary database and improves read performance. Migrating to Amazon DynamoDB (Option A) would require significant application re-architecture and is not a direct solution for caching repeated queries on an existing relational database. While adding Amazon RDS Read Replicas (Option B) can distribute read load, it still involves database queries for every request. Caching with ElastiCache is more efficient for highly repetitive reads. Upgrading the Amazon RDS instance (Option D) can provide more capacity but does not prevent repeated queries from hitting the database, which is less efficient than caching for this access pattern.'
WHERE id = 'q_20_m_20_3_28';

-- Question ID: q_20_m_20_3_29
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Creating Amazon RDS Read Replicas (Option B) allows you to offload read traffic from the primary database instance, distributing the read load and improving the performance of both read and write operations. This is the standard solution for scaling read-heavy relational databases. Enabling Multi-AZ deployment (Option A) provides high availability and disaster recovery by creating a standby instance, but it does not scale read capacity. Migrating to Amazon Aurora with a multi-master configuration (Option C) would provide write scaling, but the requirement is for read scaling, and using read replicas is a simpler, more direct solution for read-heavy applications, making multi-master overkill and potentially representing anti-pattern-001 if the goal was solely read scaling. Increasing provisioned IOPS (Option D) improves the performance of a single instance but does not scale out read capacity to handle increased concurrent read requests.'
WHERE id = 'q_20_m_20_3_29';

-- Question ID: q_20_m_20_3_30
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon RDS Proxy (Option C) is a fully managed, highly available database proxy that pools and shares database connections, making them available to Lambda functions. This prevents connection exhaustion and improves application scalability and resilience. While increasing the maximum connections parameter (Option A) might temporarily alleviate the issue, it has limits and consumes more database resources, which can still be exhausted by a highly concurrent serverless application. Amazon ElastiCache for Redis (Option B) is for caching data to reduce database load, not for managing database connections themselves. Migrating to Amazon DynamoDB (Option D) would require a complete re-architecture of the application and database, which is not the most direct solution for managing connections to an existing relational database.'
WHERE id = 'q_20_m_20_3_30';

-- Question ID: q_20_m_20_5_31
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon Kinesis Data Streams (Option B) is specifically designed for real-time ingestion and processing of large, continuous streams of data, such as sensor data from IoT devices. It ensures data is time-ordered and available for immediate processing by downstream applications. Amazon SQS (Option A) is a message queuing service primarily for decoupling microservices and batch processing, not optimized for real-time, time-ordered streaming data. Amazon S3 (Option C) is object storage, suitable for storing raw data for later batch analysis, but not for real-time ingestion and processing. AWS Glue (Option D) is an ETL service primarily for batch data transformation and loading, not for real-time data ingestion from streaming sources.'
WHERE id = 'q_20_m_20_5_31';

-- Question ID: q_20_m_20_5_32
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Snowball (Option B) is a petabyte-scale data transport solution that uses secure appliances to physically transfer large amounts of data into and out of AWS. For 500 TB, it is significantly faster and more cost-effective than transferring over a limited internet connection. AWS DataSync (Option A) is suitable for online data transfer but would be too slow and potentially costly for 500 TB over limited bandwidth. AWS Direct Connect (Option C) provides a dedicated network connection but still relies on network transfer, which would take too long for 500 TB with the given time constraint. Uploading via AWS CLI (Option D) also relies on internet bandwidth and would be impractical for such a large dataset.'
WHERE id = 'q_20_m_20_5_32';

-- Question ID: q_20_m_20_5_33
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Glue (Option B) is a fully managed, serverless ETL service that automatically scales resources as needed. It integrates directly with Amazon S3 and the AWS Glue Data Catalog, making it ideal for building data lake ETL pipelines with minimal operational overhead. Provisioning and managing Apache Spark clusters on Amazon EC2 (Option A) requires significant infrastructure management, which the team wants to avoid. Amazon EMR (Option C) is a managed service for big data frameworks, but it still involves managing clusters and instance types, incurring more operational overhead than serverless AWS Glue. AWS Lambda (Option D) has a 15-minute execution limit and is not suitable for processing large datasets that require long-running or memory-intensive transformations.'
WHERE id = 'q_20_m_20_5_33';

-- Question ID: q_20_m_20_5_34
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Transfer Family (Option B) provides fully managed support for SFTP, FTPS, and FTP, allowing external partners to securely exchange files with Amazon S3 using their existing clients. It eliminates the operational overhead of managing SFTP servers and integrates seamlessly with S3 for storage. Setting up an Amazon EC2 instance with an SFTP server (Option A) requires manual provisioning, configuration, and ongoing management of the server, which the company wants to avoid. Configuring an Amazon S3 bucket for public access (Option C) is insecure and not suitable for controlled file exchange with partners. AWS Storage Gateway File Gateway (Option D) provides an NFS or SMB file interface for on-premises applications to access S3, not an SFTP endpoint for external partners.'
WHERE id = 'q_20_m_20_5_34';

-- Question ID: q_20_m_20_2_43
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS Fargate (Option C) is the most appropriate solution. It allows running containers without managing the underlying EC2 instances, providing a serverless experience. Its primary advantage here is that it supports longer-running tasks (up to 1440 minutes) compared to AWS Lambda, and you only pay for the compute resources consumed during the task''s execution, perfectly aligning with the goal of minimizing idle capacity costs for variable, long-running jobs. AWS Lambda (Option B) has a maximum execution duration of 15 minutes, which is insufficient for tasks that can take up to 20 minutes. Deploying on Amazon EC2 with Auto Scaling (Option A) would require managing EC2 instances and potentially incur costs for idle capacity during low demand, even with scaling policies. AWS Batch (Option D) is suitable for batch processing but typically involves managing compute environments or using Fargate as a compute environment; for variable, individual long-running tasks, Fargate directly offers a more serverless and cost-effective approach without the overhead of batch job orchestration if not strictly needed.'
WHERE id = 'q_20_m_20_2_43';

-- Question ID: q_20_m_20_2_44
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Configuring AWS Batch to use EC2 Spot Instances (Option A) is the most cost-effective solution for fault-tolerant batch jobs. Spot Instances offer significant savings (up to 90%) compared to On-Demand pricing, and AWS Batch can manage the interruptions by automatically provisioning new instances or resuming jobs. This aligns with the requirement for the lowest possible compute cost for flexible workloads. Provisioning Amazon EC2 On-Demand Instances (Option B) would be significantly more expensive. AWS Lambda (Option C) has a 15-minute execution limit, which might not be suitable for large dataset processing, and its cost model might not be the lowest for sustained, large-scale batch processing. Using Amazon EMR with On-Demand Instances (Option D) is also more expensive than using Spot Instances for fault-tolerant workloads.'
WHERE id = 'q_20_m_20_2_44';

-- Question ID: q_20_m_20_2_45
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing an Amazon EC2 Auto Scaling group with dynamic scaling policies (Option B) is the ideal automated solution. Auto Scaling groups automatically adjust the number of EC2 instances in response to actual demand, preventing both over-provisioning (wasted costs) and under-provisioning (poor user experience). Manually adjusting instances (Option A) is precisely the problem the company is trying to solve and is not an automated solution. AWS Fargate (Option C) is a serverless container service that can scale, but the question specifically mentions EC2 instances and the need for an automated solution for existing EC2-based applications. AWS Lambda (Option D) is serverless and scales automatically, but it''s typically used for event-driven functions, not as a direct replacement for a traditional web application running on EC2 instances, and may require significant re-architecture.'
WHERE id = 'q_20_m_20_2_45';

-- Question ID: q_20_m_20_2_46
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Migrating the application to a larger Amazon EC2 instance type (Option A) is the most straightforward way to meet increased memory and CPU requirements for a single-instance legacy application without increasing operational complexity. This is known as vertical scaling. Implementing an Amazon EC2 Auto Scaling group (Option B) is for horizontal scaling, which would involve re-architecting the application to be distributed, adding significant operational complexity for a single-instance legacy application. Re-architecting to AWS Lambda (Option C) or containerizing for AWS Fargate (Option D) would involve substantial re-development and testing, which goes against the requirement of ''without increasing operational complexity'' for a legacy application.'
WHERE id = 'q_20_m_20_2_46';

-- Question ID: q_20_m_20_4_40
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Utilizing Amazon CloudFront (Option B) is the most effective solution for improving content delivery speed globally for both static and dynamic content. CloudFront caches static assets at edge locations close to users, significantly reducing latency. For dynamic content, CloudFront can optimize the connection to the origin, perform TLS termination at the edge, and forward requests, improving performance even if the content is not cached. Amazon Route 53 latency-based routing (Option A) only directs DNS queries to the closest DNS server, not the content itself, and doesn''t cache content. AWS Global Accelerator (Option C) improves network routing to the application endpoints but does not cache content, making it less suitable for static content delivery. Serving static content directly from Amazon S3 (Option D) would not leverage a global CDN, meaning users far from the S3 bucket''s region would still experience high latency.'
WHERE id = 'q_20_m_20_4_40';

-- Question ID: q_20_m_20_4_41
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Implementing AWS Transit Gateway (Option C) is the most scalable and manageable solution for connecting multiple VPCs in a hub-and-spoke model and providing centralized egress. Transit Gateway acts as a central hub, simplifying network architecture and management, especially with a growing number of VPCs. Creating a mesh of VPC peering connections (Option A) becomes unmanageable as the number of VPCs grows (O(n^2) connections). A central Transit VPC with an EC2 instance (Option B) is an older pattern that introduces a single point of failure and requires managing the EC2 instance, which is less scalable and more operationally complex than Transit Gateway. Using AWS VPN connections to an on-premises firewall (Option D) is for hybrid connectivity, not for inter-VPC communication within AWS.'
WHERE id = 'q_20_m_20_4_41';

-- Question ID: q_20_m_20_4_42
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Implementing AWS Direct Connect (Option A) is the correct solution for establishing a dedicated, private, consistent high-bandwidth, and low-latency connection between an on-premises data center and AWS. It bypasses the public internet, offering predictable performance. The existing internet-based VPN (Option B) is explicitly stated as insufficient due to inconsistent performance and throughput. AWS Storage Gateway (Option C) is for data transfer and synchronization, not for establishing a general-purpose network connection for all applications. A dedicated EC2 instance as a proxy (Option D) introduces a single point of failure, adds latency, and is not a scalable or secure solution for a dedicated private connection.'
WHERE id = 'q_20_m_20_4_42';

-- Question ID: q_20_m_20_4_43
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Deploying an Application Load Balancer (ALB) (Option C) is the most appropriate solution. ALBs are designed for HTTP/HTTPS traffic, can distribute requests across multiple EC2 instances, integrate seamlessly with Auto Scaling groups for automatic scaling, and perform health checks to ensure traffic is only sent to healthy instances. This provides high availability and minimal management overhead. A Network Load Balancer (NLB) (Option A) operates at the TCP layer and is not ideal for HTTP/HTTPS specific features like path-based routing or host-based routing. An EC2 instance with Nginx (Option B) would require significant manual management for scaling, health checks, and high availability, increasing operational overhead. Amazon CloudFront (Option D) is a Content Delivery Network (CDN) primarily for caching and global distribution, not for load balancing internal EC2 instances within a VPC for a primary application backend.'
WHERE id = 'q_20_m_20_4_43';

-- Question ID: q_20_m_20_4_44
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'AWS Global Accelerator (Option D) is designed for this exact scenario. It uses the AWS global network to route user traffic to the closest healthy endpoint, providing a single entry point and optimizing network performance and fault tolerance for non-HTTP/HTTPS traffic like game servers. Amazon CloudFront (Option A) is primarily a CDN for caching web content and is less suitable for direct game server connections. Amazon Route 53 with latency-based routing (Option B) relies on DNS resolution, which can be cached by clients and doesn''t optimize the actual network path beyond the DNS lookup. An Application Load Balancer (ALB) (Option C) is for HTTP/HTTPS traffic and is regional, requiring an additional global routing mechanism, which Global Accelerator provides more effectively.'
WHERE id = 'q_20_m_20_4_44';

-- Question ID: q_20_m_20_1_35
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Storing the data in Amazon S3 Glacier Flexible Retrieval (Option A) is the most cost-effective solution that meets the retrieval requirement. It offers very low storage costs and allows retrieval within minutes to hours (typically 3-5 hours for standard retrieval), which is well within the ''few hours'' acceptable timeframe. Amazon S3 Standard-IA (Option B) would be significantly more expensive for rarely accessed petabytes of data. Amazon EBS Cold HDD (sc1) volumes (Option C) are block storage, not object storage, and are not designed for petabyte-scale archival of immutable files, nor would they be as cost-effective or durable as S3 Glacier. Amazon S3 Glacier Deep Archive (Option D) offers even lower costs but has a minimum retrieval time of 12 hours for standard retrieval, which might not consistently meet the ''few hours'' requirement.'
WHERE id = 'q_20_m_20_1_35';

-- Question ID: q_20_m_20_1_36
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Provisioning an Amazon EBS General Purpose SSD (gp3) volume (Option B) is the most cost-effective way to achieve consistent baseline performance for IOPS and throughput. gp3 volumes allow you to provision IOPS and throughput independently of storage size, and they provide a consistent baseline performance without relying on burst credits. Amazon EBS General Purpose SSD (gp2) (Option A) relies on burst credits for high performance and would not provide consistent baseline performance for sustained high IOPS and throughput. Amazon EBS Provisioned IOPS SSD (io2) (Option C) would also meet the performance requirements but is typically more expensive than gp3 for these specific performance levels. Amazon DynamoDB (Option D) is a NoSQL database and not a block storage solution for an Amazon RDS instance, requiring a significant re-architecture of the database.'
WHERE id = 'q_20_m_20_1_36';

-- Question ID: q_20_m_20_1_37
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Attaching an Amazon EBS General Purpose SSD (gp3) volume (Option C) is the best solution. EBS provides block storage that can be formatted with a POSIX-compliant file system (e.g., ext4, XFS) and offers the lowest latency for a single EC2 instance, directly addressing the low-latency requirement for single-instance workloads. Amazon S3 (Option A) is object storage and does not support POSIX file system semantics like file locking or append operations. Amazon EFS (Option B) provides shared POSIX-compliant file storage but introduces network latency, making it suboptimal for latency-sensitive single-instance workloads. AWS Storage Gateway File Gateway (Option D) provides an NFS interface to S3 but is typically used for hybrid cloud scenarios and would add more latency and complexity than direct EBS attachment for a single instance.'
WHERE id = 'q_20_m_20_1_37';

-- Question ID: q_20_m_20_1_38
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Implementing Amazon EFS (Option C) is the most suitable solution. Amazon EFS provides a scalable, shared, and fully managed NFS file system that is POSIX-compliant, allowing multiple Linux servers to access and modify the same data concurrently. This directly addresses the requirement for a shared file system with horizontal scaling. Amazon S3 (Option A) is object storage and does not support POSIX file system semantics like file locking or append operations, making it unsuitable for this use case. Attaching individual Amazon EBS volumes (Option B) to each server would create isolated storage, requiring complex manual data synchronization, which is not scalable or efficient. Amazon FSx for Lustre (Option D) is a high-performance file system for specific HPC workloads, which might be overkill and more complex than needed for a general shared file system, and EFS is generally preferred for broader Linux file sharing needs.'
WHERE id = 'q_20_m_20_1_38';

-- Question ID: q_20_m_20_3_31
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Implementing Amazon ElastiCache for Redis (Option C) is the most effective solution to reduce database load and improve read latency for frequently accessed, identical queries without modifying the database schema. ElastiCache is an in-memory caching service that stores query results, serving subsequent identical requests directly from the cache, bypassing the database. Adding more Amazon RDS read replicas (Option A) would distribute the read load but would still hit the database for every query, not eliminating the database load for identical queries. Migrating data to Amazon DynamoDB (Option B) would require significant application code changes and schema modification, which is against the constraint. Upgrading the Amazon RDS instance (Option D) might provide some relief but is a vertical scaling solution that doesn''t address the root cause of repeated identical queries hitting the database.'
WHERE id = 'q_20_m_20_3_31';

-- Question ID: q_20_m_20_3_32
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon DynamoDB (Option A) is the ideal choice for this scenario. It is a fully managed, serverless NoSQL database service designed for high-performance, low-latency key-value workloads that require massive scale and predictable performance. Its architecture is optimized for single-item access patterns and can handle millions of requests per second. Amazon Aurora PostgreSQL (Option B) is a relational database, and while highly scalable, it is not optimized for the extreme key-value throughput described and is designed for complex relational queriesis about *not* using DynamoDB for complex joins, this question highlights when it *is* appropriate). Amazon RDS for MySQL (Option C) is a relational database and would struggle to achieve ''millions of transactions per second'' with extremely low latency for individual items without significant sharding and operational complexity. Amazon Redshift (Option D) is a data warehouse service optimized for analytical queries over large datasets, not for high-volume transactional processing.'
WHERE id = 'q_20_m_20_3_32';

-- Question ID: q_20_m_20_3_33
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing Amazon RDS Proxy (Option B) is the most effective solution. RDS Proxy is a fully managed, highly available database proxy that pools and shares database connections, significantly reducing the load on the RDS instance caused by a high volume of short-lived connections from AWS Lambda functions. Increasing the maximum connections parameter (Option A) might temporarily alleviate the issue but can lead to performance degradation on the RDS instance itself due to increased resource consumption. Refactoring Lambda functions for persistent connections (Option C) is complex and often not fully effective due to the ephemeral nature of Lambda execution environments. Migrating to Amazon Aurora MySQL (Option D) might offer higher connection limits but does not fundamentally solve the connection management challenge posed by high-concurrency serverless applications as efficiently as RDS Proxy.'
WHERE id = 'q_20_m_20_3_33';

-- Question ID: q_20_m_20_3_34
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Creating an Amazon Aurora read replica (Option B) and directing all reporting application queries to it is the standard and most effective way to offload read-heavy analytical workloads from the primary database instance. Read replicas are designed to handle read traffic, allowing the primary instance to focus on transactional writes and reads, thereby improving the performance of the main application. Aurora Multi-Master (Option A) is designed for write scaling and high availability across multiple masters, not specifically for offloading read-heavy analytical queries from a single primaryis about using read replicas for write scaling, this question is about using them for read scaling). Migrating reporting data to Amazon Redshift (Option C) is a valid option for very complex, large-scale analytics, but for simply offloading read queries from an existing Aurora database, a read replica is a simpler and often sufficient solution. Amazon ElastiCache (Option D) is for caching frequently accessed data, not for processing long-running, complex analytical queries.'
WHERE id = 'q_20_m_20_3_34';

-- Question ID: q_64_m_64_1_2
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'The AWS Well-Architected Framework, along with the Generative AI Lens, provides prescriptive guidance for building secure, high-performing, resilient, and efficient infrastructure for GenAI.'
WHERE id = 'q_64_m_64_1_2';

-- Question ID: q_20_m_20_3_35
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Implementing Amazon Aurora MySQL with Aurora Auto Scaling for read replicas (Option C) is the best solution. Aurora Auto Scaling automatically adjusts the number of Aurora Replicas to handle sudden, massive spikes in read traffic, ensuring high availability and scalability without manual intervention. Amazon RDS for MySQL with Multi-AZ (Option A) provides high availability but requires manual scaling of read replicas, which doesn''t meet the ''automatically scale'' requirement. Amazon DynamoDB (Option B) is a NoSQL database, not a relational one, and would require a significant re-architecture of a relational application. Setting up a sharded database on Amazon EC2 (Option D) involves significant operational overhead for manual management and scaling, which is contrary to the goal of automatic scaling and high availability with minimal intervention.'
WHERE id = 'q_20_m_20_3_35';

-- Question ID: q_64_m_64_1_3
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Creating reusable, standardized components requires adherence to modularity and well-defined interfaces (API contracts) for easy integration and maintenance.'
WHERE id = 'q_64_m_64_1_3';

-- Question ID: q_64_m_64_1_4
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Designing comprehensive GenAI architectures involves aligning with business and technical constraints, which includes balancing performance, capacity, and cost for scalable components like vector stores.'
WHERE id = 'q_64_m_64_1_4';

-- Question ID: q_64_m_64_4_1
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon Aurora PostgreSQL with the pgvector extension is explicitly mentioned for scalable, high-performance vector databases and integrates well with existing PostgreSQL data.'
WHERE id = 'q_64_m_64_4_1';

-- Question ID: q_64_m_64_4_2
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Vector database solutions support rich metadata, allowing developers to store additional attributes alongside embeddings for more refined filtering and context.'
WHERE id = 'q_64_m_64_4_2';

-- Question ID: q_68_m_68_1_17
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'A/B testing allows comparing two versions of a system by exposing different user groups to each version and measuring their responses.'
WHERE id = 'q_68_m_68_1_17';

-- Question ID: q_20_m_20_5_35
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Utilizing AWS Snowball (Option A) is the most efficient and cost-effective method for transferring 300 TB of data when the on-premises internet connection is limited. Snowball devices are designed for large-scale data transfers (100+ TB) that would take too long or be too expensive over the network. AWS DataSync (Option B) is for online data transfer and synchronization, but for 300 TB over a limited internet connection, it would still take a very long time. Increasing internet bandwidth (Option C) can be very expensive and may not be feasible or quick to implement. AWS Storage Gateway File Gateway (Option D) is for continuous synchronization and hybrid cloud storage, not for a one-time bulk transfer of this magnitude with limited network capacity.'
WHERE id = 'q_20_m_20_5_35';

-- Question ID: q_20_m_20_5_36
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Using Amazon Kinesis Data Streams (Option B) is the most appropriate solution. Kinesis Data Streams is designed for real-time, time-ordered streaming data ingestion, capable of handling high throughput and low latency, making it ideal for immediate analytics and dashboard updatesis about *not* using Kinesis when batch processing suffices, this question highlights when it *is* appropriate). Storing data in Amazon S3 and processing with AWS Glue batch jobs (Option A) would introduce significant latency, as it''s a batch-oriented approach. Sending data to an Amazon SQS queue (Option C) is suitable for message queuing and decoupling, but SQS does not guarantee message order and is not optimized for time-ordered streaming analytics. Uploading to an Amazon RDS database (Option D) would quickly become a performance bottleneck for millions of real-time transactions per second.'
WHERE id = 'q_20_m_20_5_36';

-- Question ID: q_64_m_64_4_3
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon Bedrock Knowledge Bases provide a fully managed vector store solution, designed for seamless integration with Amazon Bedrock FMs for RAG workflows.'
WHERE id = 'q_64_m_64_4_3';

-- Question ID: q_64_m_64_4_4
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Automated sync mechanisms (e.g., CDC or scheduled batch updates) are essential for keeping vector stores updated with the latest source content.'
WHERE id = 'q_64_m_64_4_4';

-- Question ID: q_64_m_64_5_1
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Document chunking breaks down large documents into smaller, manageable pieces to ensure they fit within the embedding model''s context window and can be retrieved more precisely.'
WHERE id = 'q_64_m_64_5_1';

-- Question ID: q_64_m_64_5_2
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Embedding models like Amazon Titan convert text into high-dimensional numerical vectors, allowing for semantic similarity searches in vector stores.'
WHERE id = 'q_64_m_64_5_2';

-- Question ID: q_64_m_64_5_3
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Reranking mechanisms refine the initial search results by applying more sophisticated models to score and reorder documents, improving their relevance to the user''s query.'
WHERE id = 'q_64_m_64_5_3';

-- Question ID: q_64_m_64_5_4
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Query decomposition breaks down complex, multi-faceted queries into simpler, more granular questions, allowing the retrieval system to find more precise and relevant information for each part.'
WHERE id = 'q_64_m_64_5_4';

-- Question ID: q_64_m_64_3_1
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon Comprehend can be used to identify and redact sensitive information like PII, helping to enhance input quality and comply with data privacy requirements.'
WHERE id = 'q_64_m_64_3_1';

-- Question ID: q_64_m_64_3_2
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Formatting inputs according to model requirements is crucial and involves adhering to its specified structure, token limits, and special tokens for optimal performance.'
WHERE id = 'q_64_m_64_3_2';

-- Question ID: q_64_m_64_3_3
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Glue Data Quality allows developers to define rules and monitor data quality, which is essential for ensuring data integrity before FM consumption, especially for tabular data.'
WHERE id = 'q_64_m_64_3_3';

-- Question ID: q_64_m_64_3_4
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon Transcribe is specifically designed to convert speech to text, making it suitable for processing audio data in multimodal pipelines for FM consumption.'
WHERE id = 'q_64_m_64_3_4';

-- Question ID: q_64_m_64_6_1
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Providing clear instructions for structured output within the prompt is a key prompt engineering strategy for achieving consistent and predictable FM responses, as mentioned in ''structured output'' techniques.'
WHERE id = 'q_64_m_64_6_1';

-- Question ID: q_64_m_64_6_2
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Maintaining conversation state is crucial for multi-turn interactions, allowing the FM to understand the context of previous exchanges and respond coherently.'
WHERE id = 'q_64_m_64_6_2';

-- Question ID: q_64_m_64_6_3
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon Bedrock Guardrails are specifically designed to enforce safety policies and apply content filters to FM interactions, ensuring governance.'
WHERE id = 'q_64_m_64_6_3';

-- Question ID: q_64_m_64_6_4
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Iterative refinement and quality assurance often involve A/B testing, human evaluation, and continuous monitoring to assess and improve prompt effectiveness.'
WHERE id = 'q_64_m_64_6_4';

-- Question ID: q_64_m_64_2_1
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Enabling dynamic model/provider switching requires an abstraction layer or API gateway to decouple the application from specific FM implementations.'
WHERE id = 'q_64_m_64_2_1';

-- Question ID: q_64_m_64_2_2
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'LoRA (Low-Rank Adaptation) and other parameter-efficient fine-tuning (PEFT) methods are common for customizing FMs with specialized datasets efficiently, modifying only a small fraction of model parameters.'
WHERE id = 'q_64_m_64_2_2';

-- Question ID: q_64_m_64_2_3
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Ensuring resilience across regions and providers is a key strategy for mitigating single points of failure, often facilitated by dynamic model switching.'
WHERE id = 'q_64_m_64_2_3';

-- Question ID: q_64_m_64_2_4
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon SageMaker Model Registry is designed for managing the full lifecycle of models, including versioning, approval workflows, and automated deployment/rollback, which is crucial for customized FMs.'
WHERE id = 'q_64_m_64_2_4';

-- Question ID: q_64_m_64_1_5
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'The AWS Well-Architected Framework provides a set of best practices across multiple pillars for designing and operating reliable, secure, efficient, and cost-effective cloud systems, which is crucial for GenAI solutions.'
WHERE id = 'q_64_m_64_1_5';

-- Question ID: q_64_m_64_1_6
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Proof-of-concepts (POCs) are essential for validating technical viability, confirming design assumptions, and addressing potential challenges before committing significant resources to full-scale development.'
WHERE id = 'q_64_m_64_1_6';

-- Question ID: q_64_m_64_1_7
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'The Performance Efficiency pillar focuses on using computing resources efficiently to meet system requirements, maintain efficiency as demand changes, and achieve cost optimization, directly impacting scalability and cost.'
WHERE id = 'q_64_m_64_1_7';

-- Question ID: q_64_m_64_1_8
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Modularity and abstraction encourage the creation of independent, self-contained components that can be easily reused across different parts of a system or by various teams, improving efficiency and consistency.'
WHERE id = 'q_64_m_64_1_8';

-- Question ID: q_64_m_64_4_5
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon RDS for PostgreSQL with the pgvector extension allows for storing and querying vector embeddings directly within a relational database, supporting efficient similarity search and rich metadata filtering.'
WHERE id = 'q_64_m_64_4_5';

-- Question ID: q_64_m_64_4_6
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon OpenSearch Service with its Neural Search plugin and advanced indexing capabilities (including hierarchical indexing) is well-suited for complex vector search scenarios involving rich metadata.'
WHERE id = 'q_64_m_64_4_6';

-- Question ID: q_64_m_64_4_7
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Automated sync mechanisms typically involve real-time data streaming and indexing pipelines (e.g., using AWS Kinesis or Lambda) to continuously update the vector store as source data changes, ensuring freshness.'
WHERE id = 'q_64_m_64_4_7';

-- Question ID: q_66_m_66_3_5
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Automated compliance monitoring continuously assesses resources and configurations against defined policies, ensuring generative AI systems remain compliant without constant manual oversight.'
WHERE id = 'q_66_m_66_3_5';

-- Question ID: q_20_m_20_5_37
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Utilizing AWS Glue (Option A) is the best solution. AWS Glue is a fully managed, serverless ETL service that automatically scales to handle large datasets and complex transformations. It integrates with the AWS Glue Data Catalog for schema management and eliminates the need to provision or manage EC2 instances, directly addressing the requirement to minimize operational overhead. Provisioning EC2 instances with Apache Spark (Option B) or using Amazon EMR (Option C) both involve managing EC2 instances, which the team wants to avoid. AWS Lambda (Option D) has a 15-minute execution limit, making it unsuitable for large, complex ETL jobs.'
WHERE id = 'q_20_m_20_5_37';

-- Question ID: q_20_m_20_5_38
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing AWS Glue Data Catalog for metadata management and Amazon Athena for serverless SQL querying (Option B) is the ideal solution for this scenario. AWS Glue Data Catalog automatically discovers schemas and metadata from various data sources, storing it in a central repository. Amazon Athena then allows running standard SQL queries directly against data stored in Amazon S3, without provisioning or managing any servers. Amazon Redshift (Option A) is a data warehouse that requires provisioning and managing clusters, and while it''s good for analytics, it''s not a serverless data lake solution for S3. Amazon EMR (Option C) requires managing EC2 instances for the cluster. Amazon RDS for PostgreSQL (Option D) is a relational database and not suitable for a data lake architecture on S3 or for handling diverse, large-scale data sources in a serverless manner.'
WHERE id = 'q_20_m_20_5_38';

-- Question ID: q_63_m_63_1_51
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A (On-Demand Instances) provides the most flexibility, allowing you to pay by the second or hour with no long-term commitment, which is ideal for unpredictable workloads. Option B (Reserved Instances) and Option D (Savings Plans) require a 1- or 3-year commitment for significant discounts, making them unsuitable for unpredictable or short-lived workloads. Option C (Spot Instances) offers deep discounts but can be interrupted, which might not be suitable if the workload cannot tolerate interruptions, even if it''s unpredictable.'
WHERE id = 'q_63_m_63_1_51';

-- Question ID: q_63_m_63_1_52
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B (Reserved Instances) allows you to commit to a 1- or 3-year term for significant discounts compared to On-Demand pricing, making it ideal for stable, predictable workloads. Option A (On-Demand Instances) is the most expensive for steady-state workloads. Option C (Spot Instances) offers deep discounts but is for fault-tolerant, interruptible workloads, not typically for always-on applications. Option D (AWS Free Tier) is for new accounts to explore services and has usage limits, not for long-term production cost reduction.'
WHERE id = 'q_63_m_63_1_52';

-- Question ID: q_20_m_20_2_47
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon EC2 Auto Scaling with dynamic scaling policies (Option B) is the most appropriate solution. It automatically adjusts the number of EC2 instances based on metrics like CPU utilization, ensuring capacity matches demand. This provides consistent performance during spikes and minimizes costs during off-peak hours by terminating unused instances. Manually provisioning (Option A) is reactive and prone to human error, failing the automatic adjustment requirement. AWS Lambda (Option C) is a serverless compute service but would require a significant re-architecture of an existing EC2-based web application, which is not implied by the scenario and might not be suitable for all web application types. Configuring a fixed number of large instances (Option D) leads to over-provisioning and wasted costs during off-peak periods of over-provisioning instead of using Auto Scaling.'
WHERE id = 'q_20_m_20_2_47';

-- Question ID: q_63_m_63_1_53
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C (Spot Instances) offers up to a 90% discount compared to On-Demand pricing for workloads that can tolerate interruptions, making it highly cost-effective for fault-tolerant batch processing. Option A (On-Demand Instances) is for flexible, non-interruptible workloads but is more expensive. Option B (Reserved Instances) is for steady-state workloads with a commitment. Option D (Dedicated Hosts) provides physical EC2 servers for licensing or regulatory requirements, not primarily for cost savings on interruptible tasks.'
WHERE id = 'q_63_m_63_1_53';

-- Question ID: q_64_m_64_4_8
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon Bedrock Knowledge Bases provide a fully managed service that simplifies the entire RAG pipeline, including data ingestion, chunking, embedding, and retrieval, offering native connectors and streamlining integration.'
WHERE id = 'q_64_m_64_4_8';

-- Question ID: q_64_m_64_5_5
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Query expansion/decomposition helps a RAG system address complex queries more effectively by rephrasing or breaking them down into simpler components, which can lead to better retrieval results.'
WHERE id = 'q_64_m_64_5_5';

-- Question ID: q_64_m_64_5_6
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'A single, consistent retrieval interface abstracts the underlying data sources, providing a uniform way for the RAG system to fetch information, simplifying integration and maintenance of diverse retrieval mechanisms.'
WHERE id = 'q_64_m_64_5_6';

-- Question ID: q_64_m_64_5_7
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon Bedrock offers access to various foundation models, including Amazon Titan Embeddings, which are used to generate high-quality vector representations of text for similarity search.'
WHERE id = 'q_64_m_64_5_7';

-- Question ID: q_20_m_20_2_48
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Leveraging Amazon EC2 Spot Instances (Option C) is the most cost-effective solution for fault-tolerant, long-running batch jobs like scientific simulations. Spot Instances offer significant savings (up to 90% off On-Demand prices) with the trade-off of potential interruptions, which is acceptable for fault-tolerant workloads, directly addressing the anti-pattern [-003]. Running on On-Demand Instances (Option A) ensures no interruptions but is significantly more expensive. Reserved Instances (Option B) provide cost savings for predictable, long-term workloads but offer less flexibility and typically lower savings than Spot Instances for interruptible jobs. AWS Lambda (Option D) has a maximum execution duration of 15 minutes, making it unsuitable for jobs that run for several hours, representing the anti-pattern [-001].'
WHERE id = 'q_20_m_20_2_48';

-- Question ID: q_68_m_68_1_18
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'LLM-as-a-judge uses a powerful LLM to act as an evaluator, scoring or ranking outputs from other GenAI models.'
WHERE id = 'q_68_m_68_1_18';

-- Question ID: q_20_m_20_2_49
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Utilizing Amazon Elastic Container Service (Amazon ECS) with AWS Fargate launch type (Option C) provides a serverless experience for running containers. With Fargate, the development team does not need to provision, patch, or manage the underlying EC2 instances, aligning perfectly with their goal of operational simplicity and zero infrastructure management. Deploying on Amazon ECS with EC2 launch type (Option A) requires managing the underlying EC2 instances, which is what the team wants to avoid. AWS Batch (Option B) is for batch computing and typically runs on EC2 instances, not primarily for continuous microservices, and still involves managing compute environments. Provisioning a Kubernetes cluster on Amazon EKS (Option D) with manual worker node management also involves infrastructure management, which the team wants to avoid.'
WHERE id = 'q_20_m_20_2_49';

-- Question ID: q_20_m_20_2_50
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Migrating the long-running background tasks to run on AWS Fargate for Amazon ECS (Option D) is the most appropriate solution. AWS Lambda has a hard 15-minute execution limit, making it unsuitable for tasks that exceed this duration, representing the anti-pattern [-001]. AWS Fargate allows running containers without managing servers, and containers can run for much longer durations, making it ideal for long-running background tasks. Increasing Lambda memory (Option A) might speed up execution but will not overcome the 15-minute hard limit. Refactoring to EC2 instances (Option B) is a valid option but introduces server management overhead, which Fargate avoids. Breaking tasks into smaller Lambda functions (Option C) can work for some workloads but adds complexity and might not be feasible for inherently long, atomic operations.'
WHERE id = 'q_20_m_20_2_50';

-- Question ID: q_20_m_20_2_51
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Utilizing AWS Batch (Option C) is the most suitable solution. AWS Batch is a fully managed service that enables customers to run batch computing workloads on AWS. It automatically provisions and scales compute resources (EC2 instances, Spot Instances, or Fargate) based on the volume of jobs submitted, eliminating the need for manual server management. Running on Amazon EC2 with Auto Scaling (Option A) still requires managing the EC2 instances and scaling policies. AWS Lambda (Option B) has a 15-minute execution limit, making it unsuitable for jobs that run for several hours, representing the anti-pattern [-001]. Deploying an Amazon EMR cluster (Option D) is for big data processing frameworks like Hadoop and Spark, which is more complex than needed for general batch jobs and still requires some cluster management, even if EMR is managed.'
WHERE id = 'q_20_m_20_2_51';

-- Question ID: q_20_m_20_2_52
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing Amazon EC2 Auto Scaling with a target tracking scaling policy based on Application Load Balancer request count per target (Option B) is the most effective solution. This allows the system to automatically adjust the number of EC2 instances to maintain a target utilization level, ensuring the website can handle unpredictable traffic spikes elastically and without manual intervention. Manually scaling up (Option A) is reactive and not automatic. Provisioning a fixed number of large instances (Option C) leads to over-provisioning and wasted costs during off-peak periods, representing the anti-pattern [-002]. Migrating the entire website to AWS Lambda (Option D) would require a significant re-architecture and might not be suitable for all website types, especially if it''s a traditional server-based application.'
WHERE id = 'q_20_m_20_2_52';

-- Question ID: q_20_m_20_4_45
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon CloudFront (Option B) is designed to deliver both static and dynamic content with low latency by caching at edge locations and optimizing connections to origin servers. It can cache static assets with long TTLs and improve dynamic content delivery through persistent connections, TLS termination, and TCP optimizations at the edge, directly addressing the anti-pattern [-002] by using CloudFront for dynamic content. Deploying multiple application stacks (Option A) would reduce latency for dynamic content but is a more complex and costly solution than leveraging CloudFront''s capabilities for both content types. AWS Global Accelerator (Option C) improves routing for TCP/UDP traffic but does not cache content, making CloudFront a more comprehensive solution for content delivery. Amazon S3 Glacier Deep Archive (Option D) is for archival storage with retrieval times of hours, completely unsuitable for a video streaming platform.'
WHERE id = 'q_20_m_20_4_45';

-- Question ID: q_20_m_20_4_46
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing AWS Direct Connect (Option B) provides a dedicated private network connection between the on-premises data center and AWS. This ensures consistent, low-latency, and high-throughput performance, which is critical for mission-critical applications and superior to VPN connections over the public internet, directly addressing the anti-pattern [-001]. Continuing to use AWS Site-to-Site VPN (Option A) still relies on the public internet, which inherently has variable latency and bandwidth, failing to meet the consistent performance requirement. Amazon VPC peering (Option C) is used to connect two VPCs within AWS, not an on-premises network. Configuring an Internet Gateway (Option D) is for allowing internet access to resources in a VPC and does not provide a private, dedicated connection to an on-premises network.'
WHERE id = 'q_20_m_20_4_46';

-- Question ID: q_20_m_20_4_47
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing AWS Transit Gateway (Option B) is the most scalable and manageable solution for a hub-and-spoke network topology with a growing number of VPCs. Transit Gateway acts as a central hub, simplifying inter-VPC connectivity and eliminating the need for O(n^2) peering connections, directly addressing the anti-pattern [-003]. Continuing to use VPC peering (Option A) becomes unmanageable and non-transitive with many VPCs, even with automation. Creating an EC2 instance as a routing hub (Option C) introduces a single point of failure and requires manual routing configuration and management. Establishing separate AWS Direct Connect connections (Option D) is for connecting on-premises networks to AWS, not for inter-VPC connectivity within AWS, and would be extremely costly and complex.'
WHERE id = 'q_20_m_20_4_47';

-- Question ID: q_20_m_20_4_48
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Configuring Amazon CloudFront (Option B) is a highly effective way to reduce latency for global users by caching static content at edge locations and optimizing dynamic content delivery. CloudFront terminates TLS at the edge and uses optimized connections to the origin, improving performance for both content types. While deploying in multiple Regions with Route 53 (Option A) would also reduce latency for dynamic content, CloudFront specifically addresses content delivery network capabilities for both static and dynamic content. AWS Global Accelerator (Option C) routes traffic to the nearest edge location but does not cache content, making CloudFront a more comprehensive solution for content delivery. Implementing ALBs within a single Region (Option D) improves availability and load distribution within that Region but does not address latency for users geographically distant from that Region.'
WHERE id = 'q_20_m_20_4_48';

-- Question ID: q_20_m_20_1_39
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon Elastic File System (Amazon EFS) (Option C) provides a scalable, shared file system that supports POSIX semantics, allowing multiple EC2 instances to concurrently access and modify data. It automatically scales storage capacity and performance, making it ideal for the described workload. Storing data in Amazon S3 (Option A) is object storage and does not provide POSIX file system semantics or file locking, making it unsuitable for frequently modified data requiring such features, representing the anti-pattern [-002]. Attaching an EBS volume to one instance and sharing via NFS (Option B) creates a single point of failure and requires manual management, which is less scalable and highly available than EFS. Amazon FSx for Windows File Server (Option D) is designed for Windows-based applications and would not integrate seamlessly with Linux-based EC2 instances.'
WHERE id = 'q_20_m_20_1_39';

-- Question ID: q_20_m_20_1_40
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Attaching an Amazon EBS Provisioned IOPS SSD (io2) volume (Option C) provides block-level storage with extremely low latency and high, consistent IOPS, directly attached to a single EC2 instance. This is ideal for latency-sensitive single-instance workloads, as EFS (Option B) would introduce network overhead for shared file access, representing the anti-pattern [-003]. Amazon S3 (Option A) is object storage, not block storage, and is not suitable for this use case. AWS Storage Gateway File Gateway (Option D) is for hybrid cloud storage and would also introduce network latency, making it unsuitable for extremely low-latency requirements.'
WHERE id = 'q_20_m_20_1_40';

-- Question ID: q_20_m_20_1_41
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon S3 (Option C) is the ideal service for storing user-generated content like photos and videos. It offers extremely high durability and availability, scales automatically to petabytes of data, and provides robust security features, making it perfect for frequently accessed objects. Amazon EBS (Option A) provides block storage for single EC2 instances and is not suitable for a highly scalable, globally accessible object store. Amazon EFS (Option B) provides shared file system access for multiple EC2 instances but is not designed for global object storage. Amazon FSx for Lustre (Option D) is a high-performance file system for HPC workloads, which is overkill and not suitable for general user-generated content storage.'
WHERE id = 'q_20_m_20_1_41';

-- Question ID: q_20_m_20_1_42
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Replacing the Amazon EBS gp2 volume with an Amazon EBS General Purpose SSD (gp3) volume (Option C) is the correct solution. gp3 volumes provide a consistent baseline performance of 3,000 IOPS and 125 MiB/s throughput, which can be provisioned independently of storage size, without relying on burst credits. This directly addresses the anti-pattern [-001] of using gp2 when throughput demands exceed burst credits. Increasing the size of the gp2 volume (Option A) would increase burst credits and baseline performance, but gp3 offers a better cost-performance ratio and guaranteed baseline without burst credit dependency. Migrating to Amazon S3 (Option B) changes the storage type from block to object, requiring significant application refactoring. Provisioning an Amazon EBS Throughput Optimized HDD (st1) volume (Option D) is designed for throughput-intensive, frequently accessed workloads like log processing, but it is HDD-based and not suitable for the high IOPS and low-latency requirements of an application experiencing performance degradation on SSD.'
WHERE id = 'q_20_m_20_1_42';

-- Question ID: q_66_m_66_2_1
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'VPC Endpoints allow private connections from your VPC to supported AWS services, enhancing data security by keeping traffic off the public internet.'
WHERE id = 'q_66_m_66_2_1';

-- Question ID: q_20_m_20_1_43
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing an S3 Lifecycle policy to transition objects to S3 Standard-IA after 30 days, and then to S3 Glacier Flexible Retrieval after 120 days (Option B) is the most cost-effective solution that meets the access requirements. S3 Standard-IA is for infrequently accessed data with millisecond retrieval. S3 Glacier Flexible Retrieval offers lower costs for archival data with retrieval options typically ranging from minutes to hours (standard retrieval is 3-5 hours), meeting the 5-12 hour requirement. Storing all data in S3 Standard (Option A) would be more expensive for infrequently accessed and archival data. S3 Intelligent-Tiering (Option C) is a valid option but incurs per-object monitoring fees, which might be less cost-effective than a well-defined lifecycle policy for predictable access patterns. Transitioning to S3 One Zone-IA (Option D) risks data loss in an Availability Zone failure, which is generally not suitable for critical video files, and S3 Glacier Deep Archive has a minimum standard retrieval time of 12 hours, which might not reliably meet the ''within 5-12 hours'' requirement.'
WHERE id = 'q_20_m_20_1_43';

-- Question ID: q_20_m_20_3_36
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Configuring Amazon Aurora Read Replicas (Option C) is the most effective solution for offloading read traffic and improving read throughput without impacting the primary database''s write performance. Aurora Read Replicas are designed for this exact purpose, allowing applications to distribute read queries across multiple instances. Increasing the primary instance size (Option A) might provide some relief but does not scale reads horizontally as effectively as read replicas and can be more costly. Implementing Amazon ElastiCache (Option B) is a valid caching strategy for repeated queries but requires application code changes to integrate caching logic, which the scenario aims to minimize. Migrating to Amazon DynamoDB (Option D) would require a complete re-architecture of the application and database schema, as DynamoDB is a NoSQL database, making it unsuitable for minimizing code changes and complex relational data, representing the anti-pattern [-002].'
WHERE id = 'q_20_m_20_3_36';

-- Question ID: q_20_m_20_3_37
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon RDS Proxy (Option B) is specifically designed to pool and share database connections, making it ideal for managing connections from AWS Lambda functions to Amazon RDS databases. This prevents connection exhaustion and improves application resilience and performance, directly addressing the anti-pattern [-004] of ignoring RDS Proxy for Lambda-to-RDS connections. Increasing maximum connections (Option A) might temporarily alleviate the issue but does not solve the underlying problem of connection storms from Lambda and can consume more database resources. Refactoring Lambda functions (Option C) to use long-lived connections is not a standard or efficient pattern for serverless functions, which are stateless and short-lived. Migrating to Amazon DynamoDB (Option D) would require a complete re-architecture of the application and database, which is a much larger undertaking than solving the connection management issue.'
WHERE id = 'q_20_m_20_3_37';

-- Question ID: q_20_m_20_3_38
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing Amazon ElastiCache for Memcached (Option B) is an effective solution for caching the results of frequently run, repetitive queries. This reduces the load on the Amazon RDS database and improves report generation times by serving cached data, directly addressing the anti-pattern [-003]. While increasing provisioned IOPS (Option A) might offer some performance improvement, it doesn''t address the inefficiency of re-running identical queries. Creating Amazon RDS Read Replicas (Option C) helps distribute read load but doesn''t prevent the database from processing the same query multiple times if the results are not cached. Migrating to Amazon Redshift (Option D) is a data warehousing solution for large-scale analytics, which is a much larger undertaking than simply caching repetitive queries and might not be suitable for real-time reporting from an operational database.'
WHERE id = 'q_20_m_20_3_38';

-- Question ID: q_20_m_20_3_39
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Provisioning an Amazon RDS for PostgreSQL database with Multi-AZ deployment and configuring read replicas (Option C) provides high availability with automatic failover and the ability to scale read operations. RDS manages the underlying infrastructure, minimizing administrative overhead. Deploying a self-managed MySQL database on EC2 (Option A) requires significant administrative effort for high availability and failover, contradicting the minimal overhead requirement. Amazon DynamoDB (Option B) is a NoSQL database and would require significant application refactoring for a relational workload, representing the anti-pattern [-002]. Amazon Redshift (Option D) is a data warehousing service, not an operational relational database for an enterprise application.'
WHERE id = 'q_20_m_20_3_39';

-- Question ID: q_20_m_20_3_40
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Configuring Amazon Aurora Read Replicas (Option A) is the most effective solution for scaling read capacity for Amazon Aurora MySQL. Aurora Read Replicas share the same underlying storage volume as the primary instance, allowing for rapid provisioning and up to 15 read replicas, which can handle millions of read requests per second without impacting the primary''s write performance. Migrating to Amazon DynamoDB Global Tables (Option B) would require a complete re-architecture of the application and database schema, as DynamoDB is a NoSQL database, which is not suitable for a relational database with existing complex queries, representing the anti-pattern [-002]. Increasing the primary instance size (Option C) only scales vertically and does not provide the horizontal read scaling needed for millions of requests per second. Implementing Amazon ElastiCache (Option D) is a good caching strategy but requires application code changes and is complementary to, not a replacement for, read replicas for general read scaling.'
WHERE id = 'q_20_m_20_3_40';

-- Question ID: q_20_m_20_5_40
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS Glue (Option C) is a serverless data integration service that is ideal for ETL (Extract, Transform, Load) operations. It can automatically discover schema, catalog data in the AWS Glue Data Catalog, and run serverless Spark-based ETL jobs, minimizing operational overhead and being cost-effective. Amazon Kinesis Data Streams (Option A) is designed for real-time, time-ordered streaming data, which is not the primary requirement for non-time-ordered log files processed in batches, representing the anti-pattern [-001]. Provisioning EC2 instances for Apache Spark (Option B) requires significant operational overhead for infrastructure management, patching, and scaling, which contradicts the serverless and minimal overhead requirements, representing the anti-pattern [-003]. Using Amazon Athena (Option D) for direct querying without transformation might not meet the requirement for processing and transforming data before loading into a data lake for analytical purposes.'
WHERE id = 'q_20_m_20_5_40';

-- Question ID: q_20_m_20_5_41
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Utilizing AWS Snowball Edge Storage Optimized devices (Option C) is the most appropriate solution for transferring petabytes of historical archival data. Snowball devices are physical appliances that AWS ships to the customer, allowing for offline data transfer that is significantly faster and more cost-effective than transferring large datasets over the network, directly addressing the anti-pattern [-002]. AWS DataSync (Option A) is suitable for online transfers but would be impractical for petabytes over typical internet connections. Shipping tape drives (Option B) is not an AWS-supported service for data ingestion. AWS Direct Connect (Option D) provides dedicated network connectivity but would still take a very long time and be costly for petabytes of data, making Snowball a better choice for a one-time bulk transfer of this magnitude.'
WHERE id = 'q_20_m_20_5_41';

-- Question ID: q_20_m_20_5_42
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Lake Formation (Option B) is specifically designed to build, secure, and manage data lakes on AWS. It provides a centralized console to define security, governance, and auditing policies for data stored in Amazon S3 and integrated with various analytics services, allowing fine-grained access control for different personas. Storing data in Amazon S3 with bucket policies (Option A) provides basic security but lacks the centralized governance, fine-grained access control, and integration with other analytics services that Lake Formation offers. Ingesting all data into Amazon Redshift (Option C) is for data warehousing and analytics, not for building a diverse data lake with raw and semi-structured data. Amazon DynamoDB Global Tables (Option D) is a NoSQL database service for high-performance applications, not a data lake solution for diverse data types and governance.'
WHERE id = 'q_20_m_20_5_42';

-- Question ID: q_20_m_20_5_43
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Utilizing AWS Snowball Edge Storage Optimized devices (Option C) is the most efficient and secure method for transferring petabytes of data from on-premises to AWS when internet bandwidth is limited. Snowball devices are physical appliances that enable offline data transfer, which is significantly faster and more cost-effective for large datasets than network transfers, directly addressing the anti-pattern [-002]. AWS DataSync (Option A) and AWS Direct Connect (Option B) are suitable for online transfers, but they would still be impractical or too slow for petabytes of data with limited bandwidth. Compressing and using multi-part uploads (Option D) helps optimize online transfers but does not overcome the fundamental limitation of insufficient internet bandwidth for petabyte-scale data within a reasonable timeframe.'
WHERE id = 'q_20_m_20_5_43';

-- Question ID: q_20_m_20_5_44
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Utilizing Amazon Kinesis Data Streams (Option C) is the most appropriate service for ingesting and processing high-throughput, real-time, time-ordered streaming data. Kinesis Data Streams is designed for continuous data ingestion and allows for immediate processing by downstream consumers. Amazon SQS (Option A) is a message queuing service suitable for decoupled components and batch processing, not optimized for real-time, time-ordered streaming, representing the anti-pattern [-001]. Storing data in Amazon S3 (Option B) and processing with AWS Glue is suitable for batch processing of large datasets, not real-time streaming. Ingesting directly into an Amazon RDS database (Option D) would likely overwhelm the database with high-throughput streaming data and is not designed for this scale of ingestion.'
WHERE id = 'q_20_m_20_5_44';

-- Question ID: q_21_m_21_2_26
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A is the most cost-effective solution for fault-tolerant, interruptible workloads. Amazon EC2 Spot Instances allow the company to bid on unused EC2 capacity, offering significant discounts compared to On-Demand prices. Integrating them with an Auto Scaling group and an Amazon SQS queue ensures automatic scaling and resilience to interruptions, as new instances can pick up tasks from the queue. Option B (Reserved Instances) is unsuitable for variable or interruptible workloads and would result in paying for unused capacity, representing anti-pattern-001. Option C (AWS Lambda) might be suitable for smaller, short-duration tasks, but large video transcoding can exceed Lambda''s execution limits (15 minutes) and memory constraints, making it less ideal for this specific heavy batch processing. Option D (AWS Fargate with a scheduled task) provides serverless containers but a scheduled task wouldn''t dynamically scale based on queue depth, and while Fargate can be cost-effective, Spot Instances are generally cheaper for interruptible batch jobs.'
WHERE id = 'q_21_m_21_2_26';

-- Question ID: q_21_m_21_2_27
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is the most suitable choice. AWS Lambda is a serverless compute service that automatically scales and charges only for the compute time consumed, making it highly cost-effective for unpredictable, intermittent workloads. Triggering it directly from Amazon S3 object creation events provides an event-driven architecture with minimal operational overhead. Option A (Amazon EC2 with Auto Scaling) would incur costs even during idle periods if instances are running, and requires managing EC2 instances. Option C (AWS Fargate) is serverless containers but still incurs costs for running tasks, even if scaled down, and might be overkill for simple image resizing that fits within Lambda''s limits. Option D (Reserved Instances) is designed for steady-state, predictable workloads and would be highly inefficient for variable usage, aligning with anti-pattern-001.'
WHERE id = 'q_21_m_21_2_27';

-- Question ID: q_21_m_21_2_28
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Option D, utilizing Amazon EC2 Graviton (ARM-based) instances, is the most effective choice for optimizing price/performance for compatible Linux-based workloads. Graviton instances provide up to 40% better price/performance over comparable x86 instances (anti-pattern-004) and are well-suited for containerized applications with minimal or no code changes. Option A (x86-based instances) are widely compatible but generally offer a lower price/performance ratio compared to Graviton for compatible workloads. Option B (Spot Instances) are cost-effective but primarily for fault-tolerant, interruptible workloads, and don''t specifically address the price/performance aspect for a general-purpose application. Option C (AWS Fargate) is a serverless container option that reduces operational overhead but might not offer the same level of price/performance optimization as Graviton EC2 instances for a consistently running application where the team wants to manage the underlying compute architecture.'
WHERE id = 'q_21_m_21_2_28';

-- Question ID: q_21_m_21_2_29
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A is the most cost-effective solution for development environments used only during business hours. By stopping instances when not in use, the company avoids paying for compute capacity during idle periods (evenings, weekends), directly addressing anti-pattern-002. AWS Lambda and Amazon EventBridge can automate this process with minimal operational overhead. Option B (Reserved Instances) would still incur costs 24/7, making it inefficient for environments that are idle for most of the time. Option C (Spot Instances) are suitable for fault-tolerant workloads but are not ideal for development environments that require continuous availability during working hours and might be interrupted. Option D (Downsizing to t3.nano) would reduce costs compared to larger instances but still results in paying for 24/7 compute, which is unnecessary for idle periods.'
WHERE id = 'q_21_m_21_2_29';

-- Question ID: q_21_m_21_3_26
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B, utilizing Amazon Aurora Serverless v2, is the most cost-effective solution for highly variable and unpredictable database workloads. Aurora Serverless v2 scales compute capacity in fine-grained increments, scaling down to minimal ACUs (Aurora Capacity Units) during idle periods and eliminating the need to over-provision capacity, directly addressing anti-pattern-003. This ''pay-per-use'' model is ideal for intermittent applications. Option A (provisioned Aurora) would require manual scaling and would incur costs for provisioned capacity even during idle times. Option C (RDS on EC2) introduces significant operational overhead for database management and scaling. Option D (Multi-AZ Aurora) focuses on high availability and would incur costs for a standby instance 24/7, which is not the primary concern for cost optimization of variable usage in this scenario.'
WHERE id = 'q_21_m_21_3_26';

-- Question ID: q_21_m_21_3_27
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C, using Amazon DynamoDB in On-Demand capacity mode, is the most suitable and cost-effective solution for unpredictable traffic patterns. On-Demand mode automatically scales read and write capacity to accommodate sudden traffic spikes and charges only for the requests made, eliminating the need for capacity planning and preventing over-provisioning or throttling (anti-pattern-002). This aligns perfectly with the requirement for a fully managed, seamlessly scaling NoSQL database that optimizes costs for variable usage. Option A (RDS for MySQL) and Option B (Amazon Aurora with provisioned capacity) are relational databases and would require more active management for scaling, and provisioned capacity is less cost-effective for unpredictable workloads. Option D (Amazon ElastiCache) is a caching service, not a primary persistent database, and would not meet the requirement for storing all player data.'
WHERE id = 'q_21_m_21_3_27';

-- Question ID: q_21_m_21_3_28
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Option D, creating Amazon RDS Read Replicas, is the most effective solution for offloading read-heavy workloads and improving performance while optimizing costs. Read Replicas allow you to scale out your database''s read capacity by creating one or more copies of your primary database, which can then serve read traffic. This reduces the load on the primary instance and can be more cost-effective than vertically scaling the primary. Option A (Multi-AZ deployment) is for high availability and disaster recovery, not for scaling read performance. Option B (increasing instance size) is vertical scaling, which has limits and can be more expensive than horizontal scaling with read replicas. Option C (migrating to DynamoDB) would be a significant architectural change and is not the most direct or cost-effective solution for scaling reads on an existing relational database.'
WHERE id = 'q_21_m_21_3_28';

-- Question ID: q_21_m_21_3_29
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A, implementing Amazon ElastiCache for Redis, is the most effective solution. Caching frequently accessed, infrequently changing data in an in-memory store like ElastiCache significantly reduces the number of queries hitting the primary Amazon RDS database. This decreases database load, improves application response times, and directly contributes to cost optimization by potentially allowing for smaller database instances or reducing I/O operations. Option B (DynamoDB migration) is a database migration, not a caching strategy, and might be overkill for simply reducing read load. Option C (increasing provisioned IOPS) would improve performance but also increase costs and doesn''t address the root cause of excessive queries. Option D (Amazon RDS Proxy) helps manage database connections and connection pooling, which can improve efficiency but doesn''t reduce the actual query load on the database itself.'
WHERE id = 'q_21_m_21_3_29';

-- Question ID: q_21_m_21_4_26
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C, creating an Amazon S3 Gateway VPC Endpoint, is the most cost-effective and secure solution. Gateway VPC endpoints for Amazon S3 are free of charge, keep traffic within the AWS network, and do not incur NAT Gateway processing charges (anti-pattern-001). This meets the requirement to access S3 privately and cost-effectively from private subnets. Option A (NAT Gateway) would allow access but incurs hourly charges and data processing charges, which the company wants to avoid. Option B (VPC Peering to a dedicated S3 VPC) is not a standard or necessary pattern for S3 access and S3 is not deployed in a customer VPC. Option D (AWS Transit Gateway) is used for connecting multiple VPCs and on-premises networks, not for direct private access to Amazon S3 within a single VPC.'
WHERE id = 'q_21_m_21_4_26';

-- Question ID: q_21_m_21_4_27
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Option D, establishing a VPC Peering connection, is the most appropriate and cost-effective solution for connecting two VPCs within the same AWS Region. VPC peering allows private IP address communication between instances in different VPCs as if they were in the same network, without using the public internet. It''s simpler and generally more cost-effective for a direct, one-to-one VPC connection compared to other options. Option A (Site-to-Site VPN) is typically used for connecting VPCs to on-premises networks, not directly between VPCs in the same region, and incurs VPN connection costs. Option B (AWS Direct Connect) is for dedicated private connections from on-premises to AWS, which is not applicable here. Option C (AWS Transit Gateway) is designed for connecting a large number of VPCs and on-premises networks in a hub-and-spoke model, which would be overkill and more expensive for just two VPCs, though it is a valid option for more complex scenarios.'
WHERE id = 'q_21_m_21_4_27';

-- Question ID: q_21_m_21_4_28
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A, enabling Amazon S3 Transfer Acceleration, is the correct solution. S3 Transfer Acceleration utilizes Amazon CloudFront''s globally distributed edge locations to route uploads over the optimized AWS backbone network, significantly improving transfer speeds for clients geographically distant from the S3 bucket (anti-pattern-003). Option B (CloudFront for caching uploads) is not its primary use case for uploads; CloudFront is primarily for content delivery (downloads). Option C (Cross-Region Replication) is for data redundancy and disaster recovery, not for accelerating initial uploads. Option D (custom EC2 application) would involve significant operational overhead and development effort, and might not match the global optimization of Transfer Acceleration.'
WHERE id = 'q_21_m_21_4_28';

-- Question ID: q_21_m_21_1_26
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B, selecting gp3 volumes, is the most cost-effective choice. gp3 volumes provide a baseline of 3,000 IOPS and 125 MiB/s throughput at no extra cost, which perfectly meets the application''s requirements. They offer a 20% lower cost per GB than gp2 volumes and allow independent provisioning of IOPS and throughput, making them highly cost-efficient for general-purpose workloads. Option A (io2 Block Express) is designed for the highest performance, mission-critical applications requiring up to 256,000 IOPS and is significantly more expensive than gp3, representing anti-pattern-002. Option C (gp2 volumes) are older generation and more expensive than gp3 for the same performance. Option D (st1 volumes) are throughput-optimized HDD volumes, unsuitable for boot volumes or workloads requiring balanced IOPS and throughput.'
WHERE id = 'q_21_m_21_1_26';

-- Question ID: q_21_m_21_1_27
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C, Amazon S3 Glacier Instant Retrieval, is the most cost-effective solution for archival data that is rarely accessed but requires retrieval within minutes. This storage class offers the lowest cost storage for immediate access archives, with retrieval times in milliseconds, making it ideal for the specified requirement. Option A (S3 Standard) is too expensive for rarely accessed data. Option B (S3 Standard-IA) is for data accessed less frequently but still more often than ''once a year or less'', and is more expensive than Glacier Instant Retrieval for deep archives. Option D (S3 Glacier Deep Archive) offers the absolute lowest storage cost but has retrieval times measured in hours, which does not meet the ''within minutes'' requirement.'
WHERE id = 'q_21_m_21_1_27';

-- Question ID: q_21_m_21_2_30
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A is the most cost-effective solution for fault-tolerant, flexible workloads that can tolerate interruptions. Amazon EC2 Spot Instances allow customers to bid on unused EC2 capacity, offering significant discounts (up to 90% off On-Demand prices). Since the video transcoding jobs are fault-tolerant, they can be stopped and restarted without major issues, making Spot Instances an ideal fit for cost optimization. Option B is incorrect because Reserved Instances are best suited for steady-state, predictable workloads over a long term, and using them for variable or unpredictable workloads (like fault-tolerant processing that can be interrupted) is an anti-pattern ([-001]). Option C, AWS Savings Plans, offers flexibility across instance types and Regions but still assumes a consistent compute spend commitment, which might not be fully utilized if workloads are frequently interrupted or scaled down dramatically. While more flexible than RIs, Spot Instances offer deeper discounts for interruptible workloads. Option D, AWS Lambda, is designed for event-driven, short-duration functions (up to 15 minutes per invocation). Large-scale video transcoding typically involves longer-running processes and significant memory/CPU, making Lambda less suitable or requiring complex orchestration, which increases operational overhead and might exceed Lambda''s practical limits for this type of workload.'
WHERE id = 'q_21_m_21_2_30';

-- Question ID: q_21_m_21_2_31
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B, implementing AWS Savings Plans, is the most appropriate and cost-effective solution. Savings Plans offer significant discounts (up to 72%) in exchange for a commitment to a consistent amount of compute usage (measured in USD/hour) for a 1-year or 3-year term. They provide flexibility across Amazon EC2 instance families, sizes, operating systems, and even AWS Regions, making them ideal for workloads with consistent usage but evolving instance requirements. Option A, purchasing Amazon EC2 Reserved Instances, offers similar discounts but locks the customer into specific instance types, operating systems, and tenancy, which lacks the flexibility the firm desires. Option C, utilizing Amazon EC2 Spot Instances, is not suitable for critical reporting applications that cannot tolerate interruptions, even if they are fault-tolerant. Spot Instances are best for flexible, non-critical, or batch workloads. Option D, while right-sizing is a good practice, relying solely on it without a purchasing option like Savings Plans will not achieve the same level of cost reduction for consistent baseline usage and does not address the long-term commitment aspect.'
WHERE id = 'q_21_m_21_2_31';

-- Question ID: q_21_m_21_2_32
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C, using AWS Lambda and Amazon EventBridge, is the most cost-effective and operationally efficient solution. An EventBridge scheduled rule can trigger an AWS Lambda function to stop instances at the end of the workday and start them at the beginning, eliminating idle costs. This approach is serverless, requires no dedicated infrastructure for the scheduler, and has minimal operational overhead. Option A, manually stopping and starting instances, is prone to human error and high operational overhead, failing the ''LEAST operational overhead'' constraint. Option B, implementing a custom script on an Amazon EC2 instance, introduces additional cost for the scheduler instance itself and requires management of that instance, which is more operational overhead than a serverless solution. Option D, purchasing Amazon EC2 Reserved Instances, is an anti-pattern ([-002]) for idle development environments. While it reduces the hourly rate, it still commits to paying for 24/7 capacity, which is not cost-optimized for instances used only part-time.'
WHERE id = 'q_21_m_21_2_32';

-- Question ID: q_21_m_21_3_30
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B, utilizing Amazon Aurora Serverless v2, is the most cost-effective solution for highly unpredictable and intermittent relational database workloads. Aurora Serverless v2 scales capacity in fine-grained increments and can scale down to minimal Aurora Capacity Units (ACUs) during idle periods, ensuring that the startup pays only for the database resources consumed and avoids paying for unused provisioned capacity. This directly addresses the anti-pattern ([-003]) of not using Aurora Serverless v2 for intermittent database workloads. Option A, provisioning a standard Amazon RDS MySQL instance with Multi-AZ, would incur costs for provisioned capacity 24/7, even during idle periods, and Multi-AZ doubles the cost for high availability, which might be overkill for a startup''s initial phase or non-critical development. Option C, deploying a self-managed MySQL database on an Amazon EC2 instance, would involve significant operational overhead for patching, backups, and scaling, and would still incur costs for the EC2 instance even when idle. Option D, configuring Amazon DynamoDB with provisioned capacity, is incorrect because DynamoDB is a NoSQL database, and the scenario specifies a relational database. Furthermore, provisioned capacity for DynamoDB is suboptimal for unpredictable traffic patterns, as it risks over-provisioning or throttling, which is an anti-pattern ([-002]).'
WHERE id = 'q_21_m_21_3_30';

-- Question ID: q_21_m_21_3_31
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B, utilizing Amazon DynamoDB in on-demand capacity mode, is the most appropriate and cost-effective solution for highly variable and unpredictable NoSQL workloads. On-demand mode automatically scales read and write capacity based on actual usage, and customers pay per request, eliminating the need for capacity planning and avoiding costs for over-provisioned capacity. This directly addresses the anti-pattern ([-002]) of using provisioned capacity for DynamoDB with unpredictable traffic. Option A, configuring Amazon DynamoDB with provisioned capacity, would require upfront capacity planning and risks over-provisioning (leading to unnecessary costs) or under-provisioning (leading to throttling and performance issues) for unpredictable workloads. Option C, deploying an Amazon RDS PostgreSQL instance, is a relational database solution, which is not suitable for a NoSQL requirement. Option D, setting up an Amazon ElastiCache for Redis cluster, is a caching solution, not a primary database. While caching can reduce database load, it does not replace the primary database and would add complexity without solving the core database scalability and cost challenge for unpredictable traffic.'
WHERE id = 'q_21_m_21_3_31';

-- Question ID: q_21_m_21_3_32
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C, converting the Amazon RDS Multi-AZ deployments for development and testing to Single-AZ deployments, is the most cost-effective solution. Amazon RDS Multi-AZ doubles the cost by maintaining a synchronous standby replica for high availability. For non-critical development and testing databases that do not require high availability or immediate failover, a Single-AZ deployment is sufficient and significantly cheaper. This directly addresses the anti-pattern ([-001]) of running RDS Multi-AZ for non-critical development databases. Option A, migrating to Amazon DynamoDB, might be a valid solution for some use cases but introduces a different database type and potential migration effort, which is not the most direct or cost-effective optimization for an existing relational database in a non-critical environment. Option B, keeping Multi-AZ deployments, fails the cost optimization constraint for non-critical environments. Option D, implementing Amazon ElastiCache for Redis, is a caching solution that reduces database load but does not address the underlying cost of the Multi-AZ deployment for the primary database itself.'
WHERE id = 'q_21_m_21_3_32';

-- Question ID: q_21_m_21_3_33
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A, creating Amazon RDS Read Replicas and directing read traffic to them, is the most effective and cost-optimized solution for offloading read-heavy queries. Read Replicas allow you to scale out your database''s read capacity independently of the primary instance, reducing the load on the primary and potentially allowing it to run on a smaller, less expensive instance type. This improves performance and reduces costs. Option B, migrating to Amazon DynamoDB, is a NoSQL solution and would require significant application changes for a relational database, which is not the most direct or cost-effective approach for this scenario. Option C, upgrading the primary Amazon RDS instance, is vertical scaling and would increase costs significantly without addressing the fundamental issue of separating read and write workloads, and it still has scaling limits. Option D, implementing Amazon ElastiCache for Memcached, is a caching solution that can reduce database load, but it requires application-level changes to implement caching logic and might not be suitable for all types of read queries or data freshness requirements. Read Replicas provide a direct, integrated solution for scaling read capacity.'
WHERE id = 'q_21_m_21_3_33';

-- Question ID: q_21_m_21_3_34
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A, implementing an Amazon ElastiCache for Redis cluster, is the most effective solution for caching frequently accessed, static reference data. Caching this data in ElastiCache significantly reduces the load on the Amazon RDS database, improves query response times, and can lead to cost savings by allowing the RDS instance to potentially run on a smaller, less expensive instance type. Redis offers high performance and availability. Option B, upgrading the Amazon RDS instance, is a vertical scaling approach that increases costs and does not address the root cause of repetitive queries for static data. Option C, creating an Amazon RDS Read Replica, would offload read traffic but still involves querying a database instance, which is less efficient for static, frequently accessed data compared to an in-memory cache. Option D, migrating static reference data to an Amazon S3 bucket, is a valid approach for static content but would require changes to the application to retrieve data from S3 instead of the database, and might introduce higher latency compared to an in-memory cache for frequent lookups.'
WHERE id = 'q_21_m_21_3_34';

-- Question ID: q_21_m_21_4_31
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A, configuring a VPC endpoint for Amazon S3 and a VPC endpoint for Amazon DynamoDB, is the most cost-effective and secure solution. Gateway VPC endpoints for Amazon S3 and Amazon DynamoDB are free and allow instances in private subnets to access these services directly over the AWS network, without requiring a NAT Gateway or an internet gateway. This eliminates NAT Gateway data processing charges for traffic to these services. This directly addresses the anti-pattern ([-001]) of using NAT Gateway for traffic that could go through VPC endpoints. Option B, routing traffic through AWS Direct Connect, is for hybrid cloud connectivity to on-premises networks, not for optimizing intra-AWS service communication. Option C, implementing a VPN connection, is typically used for secure connections between a VPC and an on-premises network or another VPC, and would still incur data transfer costs and potentially VPN connection charges. Option D, moving instances to a public subnet, would expose them to the public internet, compromising security and not necessarily reducing data transfer costs for internal AWS service access.'
WHERE id = 'q_21_m_21_4_31';

-- Question ID: q_21_m_21_4_32
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B, replacing the NAT instance with a NAT Gateway, is the most appropriate solution. A NAT Gateway is a fully managed AWS service that provides high availability, higher bandwidth, and requires no administrative effort for patching or scaling, unlike a self-managed NAT instance. While NAT Gateway has an hourly charge and data processing fees, it is generally more cost-effective and operationally simpler than managing a NAT instance, especially considering the operational overhead and potential single point of failure of a NAT instance. Option A, continuing with a NAT instance, retains the operational burden and single point of failure, and scaling it up increases costs without addressing the management overhead. Option C, moving instances to a public subnet, would expose the application instances directly to the internet, which is a security risk and generally not recommended for application servers. Option D, implementing AWS PrivateLink, is used for private connectivity to specific AWS services or services hosted by other AWS customers, not for general outbound internet access to arbitrary third-party APIs.'
WHERE id = 'q_21_m_21_4_32';

-- Question ID: q_21_m_21_4_33
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A, establishing VPC peering connections between the VPCs in different Regions, is the most cost-effective and direct solution for private inter-Region traffic. VPC peering allows private IP address communication between VPCs, leveraging the AWS global backbone network, which offers better reliability, lower latency, and is often more cost-effective than routing traffic through the public internet. This directly addresses the anti-pattern ([-002]) of routing inter-Region traffic through the public internet. Option B, continuing to use the public internet, fails to address the cost, performance, and security concerns, and S3 Transfer Acceleration is specific to S3 uploads/downloads, not general inter-Region VPC traffic. Option C, implementing AWS Direct Connect, is for connecting on-premises networks to AWS, not for inter-Region VPC communication within AWS. Option D, deploying a VPN connection over the public internet, provides encryption but still uses the public internet, which can suffer from inconsistent performance and higher latency compared to AWS''s private backbone, and it incurs VPN connection costs.'
WHERE id = 'q_21_m_21_4_33';

-- Question ID: q_21_m_21_4_34
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A, enabling S3 Transfer Acceleration on the Amazon S3 bucket, is the most appropriate and cost-effective solution. S3 Transfer Acceleration uses Amazon CloudFront''s globally distributed edge locations to route uploads over the optimized AWS backbone network, significantly improving transfer speeds for clients located far from the S3 bucket''s Region. This directly addresses the anti-pattern ([-003]) of not using S3 Transfer Acceleration when uploading from distant locations. Option B, creating S3 buckets in multiple Regions, would require complex data synchronization and management across buckets, increasing operational overhead and potentially costs. Option C, using Amazon CloudFront, is primarily for accelerating content delivery (downloads) to users, not for accelerating uploads to S3. Option D, implementing AWS Direct Connect, is for establishing a dedicated network connection between an on-premises data center and AWS, which is not practical or cost-effective for individual client locations and does not address general internet-based upload performance.'
WHERE id = 'q_21_m_21_4_34';

-- Question ID: q_21_m_21_1_29
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B, configuring an S3 Lifecycle policy, is the most cost-effective solution for data with known and predictable access patterns over time. The policy can automatically transition objects to Amazon S3 Standard-Infrequent Access (S3 Standard-IA) after 30 days (for infrequent access) and then to Amazon S3 Glacier Deep Archive after 1 year (for long-term archival with the lowest storage cost). This directly addresses the anti-pattern ([-001]) of keeping all S3 data in Standard tier without lifecycle policies. Option A, keeping all data in Amazon S3 Standard, is not cost-optimized as it pays for the highest-cost tier for infrequently accessed and archived data. Option C, enabling Amazon S3 Intelligent-Tiering, is ideal for data with unknown or changing access patterns, but for clearly defined patterns, a lifecycle policy offers more precise control and potentially greater cost savings by directly moving to the most appropriate tier. Option D, manually moving data, is operationally inefficient, prone to error, and not scalable for petabytes of data.'
WHERE id = 'q_21_m_21_1_29';

-- Question ID: q_21_m_21_1_30
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B, utilizing an Amazon EBS General Purpose SSD (gp3) volume and provisioning additional IOPS and throughput, is the most cost-effective solution. gp3 volumes provide a baseline of 3,000 IOPS and 125 MiB/s throughput at no additional cost. You can provision additional IOPS (up to 16,000) and throughput (up to 1,000 MiB/s) independently for a small extra charge. For 5,000 IOPS and 200 MiB/s, gp3 can easily meet these requirements at a lower cost than io2. This directly addresses the anti-pattern ([-002]) of using Provisioned IOPS (io2) EBS when gp3 meets the IOPS requirement. Option A, provisioning an Amazon EBS Provisioned IOPS SSD (io2) volume, would meet the requirements but is significantly more expensive than gp3 for the specified performance levels. Option C, using an Amazon EBS General Purpose SSD (gp2) volume, relies on burst performance and might not consistently deliver 5,000 IOPS, making it unsuitable for a production database with consistent performance requirements. Option D, selecting an Amazon EBS Throughput Optimized HDD (st1) volume, is designed for large sequential workloads (like big data or log processing) and is not suitable for transactional databases requiring high random IOPS.'
WHERE id = 'q_21_m_21_1_30';

-- Question ID: q_21_m_21_1_31
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C, archiving the video content directly into Amazon S3 Glacier Deep Archive, is the most cost-effective solution for data that is rarely accessed (once every few years) and can tolerate retrieval times of several hours to a day. Amazon S3 Glacier Deep Archive offers the lowest storage cost in the cloud, specifically designed for long-term archival. Option A, storing in Amazon S3 Standard, is significantly more expensive and not suitable for rarely accessed archives. Option B, utilizing Amazon S3 Intelligent-Tiering, is designed for unpredictable access patterns and would eventually move data to archive tiers, but directly placing it in S3 Glacier Deep Archive is more cost-effective for data known to be rarely accessed. Option D, keeping content on Amazon EFS, is a file system service for shared access, which is generally much more expensive than S3 Glacier for archival purposes and not designed for this use case.'
WHERE id = 'q_21_m_21_1_31';

-- Question ID: q_21_m_21_2_33
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A is the most cost-effective solution for this scenario. Amazon EC2 Spot Instances offer significant discounts compared to On-Demand pricing, making them ideal for fault-tolerant, flexible workloads that can tolerate interruptions. Since the application can resume from checkpoints, it is well-suited for Spot Instances. Option B (Reserved Instances) is not suitable for variable or unpredictable workloads (-001) as it requires a steady-state commitment. Option C (On-Demand Instances) would be more expensive than Spot Instances for this type of workload. Option D (AWS Lambda) is generally for shorter, event-driven tasks and might not be suitable for ''several hours daily'' continuous processing without complex orchestration, and could become more expensive than Spot for long-running batch jobs.'
WHERE id = 'q_21_m_21_2_33';

-- Question ID: q_21_m_21_2_34
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is the most cost-effective and operationally efficient solution. By using AWS Lambda and Amazon EventBridge, the instances can be automatically stopped when not in use (outside business hours) and started when needed, eliminating idle costs (-002) with minimal manual intervention. Option A (Reserved Instances) would still incur costs for 24/7 usage, which is not optimal for environments used only during business hours. Option C (Manual stop/start) is prone to human error and adds operational overhead. Option D (Downsizing) reduces costs but still incurs 24/7 charges for idle periods.'
WHERE id = 'q_21_m_21_2_34';

-- Question ID: q_21_m_21_2_35
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C is the most cost-effective and scalable solution. Using an Auto Scaling group with multiple smaller Amazon EC2 instances allows the application to scale horizontally, adding or removing instances based on actual demand. This avoids over-provisioning during off-peak times, which is a common anti-pattern (-003). Option A (Upgrading to a larger instance) exacerbates the over-provisioning issue. Option B (Reserved Instance for a large instance) locks in the cost for an often underutilized resource. Option D (AWS Fargate with a single large container) still suffers from the single point of failure and potential over-provisioning if not configured to scale horizontally.'
WHERE id = 'q_21_m_21_2_35';

-- Question ID: q_21_m_21_2_36
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Option D is the most effective way to achieve the best price/performance ratio for compatible Linux-based workloads. AWS Graviton instances (ARM-based) offer up to 40% better price/performance over comparable x86 instances (-004) for many workloads, including containerized microservices. Option A (Savings Plans for x86) provides discounts but doesn''t address the underlying price/performance advantage of Graviton. Option B (AWS Fargate) is a serverless option, but Graviton instances specifically target the price/performance aspect of the underlying compute. Option C (Right-sizing x86 instances) is a good practice but doesn''t leverage the architectural benefits of Graviton.'
WHERE id = 'q_21_m_21_2_36';

-- Question ID: q_21_m_21_2_37
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A is the most cost-effective solution for a stable, predictable, and continuous 24/7 workload over a multi-year period. Amazon EC2 Reserved Instances offer substantial discounts compared to On-Demand pricing, with the largest discounts typically available for 3-year commitments and All Upfront payment. Option B (Spot Instances) is not suitable for critical, continuous workloads that cannot tolerate interruptions. Option C (On-Demand Instances) is the most expensive option for a predictable 24/7 workload. Option D (Auto Scaling with On-Demand) is designed for variable workloads, not for a steady-state 24/7 requirement, and would be more expensive than Reserved Instances for this use case.'
WHERE id = 'q_21_m_21_2_37';

-- Question ID: q_21_m_21_2_38
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A is the most cost-effective solution for this scenario. Amazon EC2 Spot Instances offer significant discounts compared to On-Demand pricing, making them ideal for fault-tolerant, flexible workloads that can tolerate interruptions. Since the application can resume from checkpoints, it is well-suited for Spot Instances. Option B (Reserved Instances) is not suitable for variable or unpredictable workloads (-001) as it requires a steady-state commitment. Option C (On-Demand Instances) would be more expensive than Spot Instances for this type of workload. Option D (AWS Lambda) is generally for shorter, event-driven tasks and might not be suitable for ''several hours daily'' continuous processing without complex orchestration, and could become more expensive than Spot for long-running batch jobs.'
WHERE id = 'q_21_m_21_2_38';

-- Question ID: q_21_m_21_3_35
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is the most cost-effective and scalable solution for highly variable and unpredictable workloads on Amazon DynamoDB. On-Demand capacity mode automatically scales capacity up and down based on actual traffic, and you only pay for the read and write requests your application performs, eliminating the need for capacity planning and avoiding over-provisioning (-002). Option A (Provisioned Capacity) risks over-provisioning during low traffic or throttling during unexpected spikes. Option C (Global Tables) is for multi-Region replication, not primarily for cost optimization of a single table''s variable traffic. Option D (Amazon RDS) is a relational database and not typically chosen for the extreme scalability and unpredictable traffic patterns of a gaming leaderboard, especially when DynamoDB is already in use.'
WHERE id = 'q_21_m_21_3_35';

-- Question ID: q_21_m_21_3_36
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C is the most cost-effective solution for intermittent relational database workloads. Amazon Aurora Serverless v2 scales capacity almost instantly and in fine-grained increments, scaling down to a minimal amount of Aurora Capacity Units (ACUs) during idle periods, thus avoiding paying for unused provisioned capacity (-003). Option A (RDS Multi-AZ) doubles the cost by maintaining a synchronous standby, which is unnecessary for a non-critical, intermittent development database (-001). Option B (EC2 with MySQL) requires significant operational overhead for database management. Option D (RDS Single-AZ with scheduled stop/start) is a viable option but Aurora Serverless v2 offers more seamless scaling and less management overhead for intermittent workloads.'
WHERE id = 'q_21_m_21_3_36';

-- Question ID: q_21_m_21_3_37
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is the most cost-effective solution for reducing read load on Amazon DynamoDB for frequently accessed, relatively static data. Amazon ElastiCache (e.g., Redis or Memcached) can store copies of data, serving read requests from the cache instead of DynamoDB, which significantly reduces DynamoDB read capacity unit consumption and improves application response times. Option A (Increasing provisioned capacity) would directly increase costs without addressing the efficiency of data access. Option C (Migrating to Amazon RDS) is a different database type and would require re-architecture. Option D (DynamoDB Global Tables) is for multi-Region replication and high availability, not primarily for reducing read costs for a single-Region, read-heavy workload.'
WHERE id = 'q_21_m_21_3_37';

-- Question ID: q_21_m_21_4_35
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C is the most cost-effective and secure solution. Gateway VPC Endpoints for Amazon S3 and Amazon DynamoDB allow instances in private subnets to access these services without requiring a NAT Gateway or an Internet Gateway. This keeps traffic within the AWS network and eliminates NAT Gateway data processing charges (-001), as Gateway Endpoints are free. Option A (AWS Transit Gateway) is for connecting multiple VPCs or on-premises networks, not for direct service access within a single VPC. Option B (NAT instance) would still incur data processing charges and requires more management than a NAT Gateway. Option D (S3 Transfer Acceleration) is for optimizing uploads from distant locations, not for internal VPC access.'
WHERE id = 'q_21_m_21_4_35';

-- Question ID: q_21_m_21_4_36
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Option D is the most cost-effective and scalable solution for connecting multiple VPCs across different AWS Regions. AWS Transit Gateway allows you to centralize routing and establish private, low-latency connections between VPCs in different Regions, avoiding the public internet (-002) and reducing data transfer costs compared to public egress. Option A (Internet Gateway) is the current problematic approach. Option B (AWS Direct Connect) is for connecting on-premises networks to AWS, not for inter-Region VPC-to-VPC communication. Option C (AWS PrivateLink) is for exposing a service privately to consumers in other VPCs, not for general VPC-to-VPC routing.'
WHERE id = 'q_21_m_21_4_36';

-- Question ID: q_21_m_21_4_37
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A is the most effective solution for improving upload performance and reliability for geographically distant users. S3 Transfer Acceleration uses Amazon CloudFront''s globally distributed edge locations to route uploads over the optimized AWS backbone network, significantly reducing latency and improving speeds (-003). Option B (Cross-Region Replication) is for copying data between S3 buckets for redundancy or local access, not for improving initial upload performance. Option C (AWS Direct Connect) is for private connectivity from on-premises to AWS, not for individual contributors globally. Option D (S3 Intelligent-Tiering) is for optimizing storage costs based on access patterns, not for upload performance.'
WHERE id = 'q_21_m_21_4_37';

-- Question ID: q_21_m_21_4_38
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is a more cost-effective solution for low-volume, non-critical outbound internet traffic when compared to a NAT Gateway, especially if the team is willing to manage the instance. While a NAT Gateway offers higher availability and less operational overhead, a NAT instance can be cheaper for minimal usage. Option A (Additional NAT Gateway) would increase costs. Option C (Gateway VPC Endpoints) are only for specific AWS services like S3 and DynamoDB, not for general internet access. Option D (AWS Direct Connect) is for connecting on-premises networks to AWS, not for outbound internet access from VPC instances.'
WHERE id = 'q_21_m_21_4_38';

-- Question ID: q_21_m_21_4_39
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C is the most secure, scalable, and cost-effective solution for this scenario. AWS PrivateLink allows the SaaS provider to expose their service privately to multiple customers. Customers can create interface VPC endpoints in their own VPCs, making the service appear as if it''s hosted directly within their network, without traversing the public internet or requiring complex VPC peering relationships. Option A (Internet Gateway) exposes the service to the public internet, which is not secure or private. Option B (VPC peering) becomes unmanageable and complex for a large number of customers due to CIDR block overlap concerns and the need for individual peering connections. Option D (AWS Direct Connect) is for connecting on-premises networks to AWS, not for VPC-to-VPC service access.'
WHERE id = 'q_21_m_21_4_39';

-- Question ID: q_21_m_21_1_32
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Option D is the most cost-effective solution for this scenario. An S3 Lifecycle policy allows for automated transitions of objects between different storage classes based on their age and access patterns. Transitioning to S3 Standard-IA after 30 days and then to S3 Glacier Deep Archive (or another Glacier tier like S3 Glacier Flexible Retrieval) for long-term, infrequent access significantly reduces storage costs compared to keeping data in S3 Standard (-001). Option A (S3 Standard) is expensive for infrequently accessed data. Option B (S3 Intelligent-Tiering) is ideal for unpredictable access patterns but less optimal for a fixed, known lifecycle. Option C (S3 Glacier Instant Retrieval from upload) would incur retrieval costs if accessed frequently in the first 30 days and is not the most cost-effective for the entire 7-year period.'
WHERE id = 'q_21_m_21_1_32';

-- Question ID: q_21_m_21_1_33
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Option A is the most effective solution for unpredictable access patterns. Amazon S3 Intelligent-Tiering automatically moves objects between two access tiers (frequent and infrequent) based on changing access patterns, with no retrieval fees and minimal performance impact. This eliminates the need for manual lifecycle management and ensures cost optimization for unknown or changing access patterns (-003). Option B (S3 Lifecycle to S3 Standard-IA) is suitable for known, predictable access patterns, but not for unpredictable ones. Option C (S3 Standard) is more expensive for data that becomes infrequently accessed. Option D (S3 Glacier Instant Retrieval) is designed for data accessed rarely, not for unpredictable patterns that might involve frequent access.'
WHERE id = 'q_21_m_21_1_33';

-- Question ID: q_21_m_21_1_34
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is the most cost-effective solution that meets the specified performance requirements. `gp3` volumes offer a baseline of 3,000 IOPS and 125 MiB/s throughput at no additional cost and can be provisioned up to 16,000 IOPS and 1,000 MiB/s throughput independently of storage size. Provisioning `gp3` to 3,500 IOPS and 130 MiB/s will be significantly more cost-effective than `io2`. Option A (`io2`) is significantly more expensive and should only be used when requirements exceed `gp3` limits (-002), which is not the case here. Option C (`st1`) and Option D (`sc1`) are HDD-based and do not meet the high IOPS and low-latency requirements of a critical database application.'
WHERE id = 'q_21_m_21_1_34';

-- Question ID: q_21_m_21_1_35
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C is the most cost-effective solution for rarely accessed data that needs quick retrieval. Amazon S3 Glacier Instant Retrieval offers low-cost archival storage with retrieval times in milliseconds, which is ideal for data accessed once or twice a year. Storing infrequently accessed data on Amazon EBS (-004) is expensive because EBS charges per provisioned GB regardless of usage. Option A (EBS `sc1`) is still EBS and not as cost-effective as S3 Glacier for archival. Option B (Amazon EFS) is a file system for shared access, not optimized for cold archival. Option D (Amazon S3 Standard) is more expensive than Glacier Instant Retrieval for rarely accessed data.'
WHERE id = 'q_21_m_21_1_35';

-- Question ID: q_21_m_21_2_39
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is correct. Using an AWS Lambda function triggered by an Amazon EventBridge schedule to stop and start EC2 instances automatically is the most cost-effective and operationally efficient solution. It eliminates manual effort and ensures instances are only running when needed, directly addressing anti-pattern-002 (Running idle development environments 24/7). Option A (manual stop/start) is labor-intensive and prone to human error. Option C (Reserved Instances) would still incur costs for 24/7 capacity, even when instances are idle, which is not cost-optimized for intermittent usage. Option D (AWS Auto Scaling groups) is designed for scaling based on demand, not for scheduled start/stop of non-production environments that are idle for extended periods.'
WHERE id = 'q_21_m_21_2_39';

-- Question ID: q_21_m_21_2_40
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is correct. Using multiple smaller EC2 instances within an Auto Scaling group, scaling based on demand, is the most effective solution for highly variable and unpredictable traffic. This approach allows the application to scale out quickly during spikes and scale in during low periods, optimizing costs and maintaining availability. Option A (single large EC2 instance) creates a single point of failure and cannot scale horizontally, which is an anti-pattern (-003). Option C (Reserved Instances for maximum capacity) would lead to significant over-provisioning and wasted costs during low traffic periods, relating to anti-pattern-001. Option D (AWS Fargate with a fixed number of tasks) would not scale dynamically with demand, leading to either over-provisioning or performance issues during spikes.'
WHERE id = 'q_21_m_21_2_40';

-- Question ID: q_21_m_21_3_38
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is correct. DynamoDB On-Demand capacity mode is ideal for workloads with unpredictable traffic patterns, such as an e-commerce product catalog with promotional spikes. It automatically scales to meet demand and charges only for the read and write requests consumed, eliminating the need for capacity planning and preventing throttling or over-provisioning, which is a common issue with provisioned capacity for unpredictable workloads (anti-pattern-002). Option A (Provisioned capacity with Auto Scaling) still requires setting initial capacity and can react slower to sudden spikes compared to On-Demand. Option C (Provisioned capacity with a high baseline) would lead to significant over-provisioning and wasted costs during low activity periods. Option D (Aurora Serverless v2) is for relational databases, not NoSQL DynamoDB.'
WHERE id = 'q_21_m_21_3_38';

-- Question ID: q_21_m_21_3_40
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is correct. Provisioning the Amazon RDS instance as a Single-AZ deployment with automated backups enabled is the most cost-effective solution for a non-critical staging environment. Multi-AZ (Option A) doubles the cost by maintaining a synchronous standby, which is an anti-pattern (-001) for non-critical development databases. Option C (Aurora Serverless v2) can be cost-effective for intermittent workloads but might be overkill and potentially more expensive for a simple, non-critical staging database compared to a small, single-AZ RDS instance. Option D (large, memory-optimized instance) would lead to significant over-provisioning and unnecessary costs for a staging environment.'
WHERE id = 'q_21_m_21_3_40';

-- Question ID: q_21_m_21_3_41
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is correct. Deploying an Amazon ElastiCache cluster (e.g., Redis or Memcached) is the most effective and cost-optimized solution for caching frequently accessed, relatively static data like user session information. This significantly reduces the load on the primary database and improves application responsiveness. Option A (RDS Read Replicas) offloads read queries but doesn''t provide the in-memory caching benefits of ElastiCache for frequently accessed data. Option C (upgrading the primary instance) is a vertical scaling approach that is often more expensive and less efficient for read-heavy workloads than implementing a caching layer. Option D (migrating to DynamoDB) would involve significant application changes and is not primarily a caching solution for an existing relational database.'
WHERE id = 'q_21_m_21_3_41';

-- Question ID: q_21_m_21_4_40
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C is correct. A Gateway VPC Endpoint for Amazon S3 is the most cost-effective and secure way to allow EC2 instances in a private subnet to access Amazon S3 without traversing the public internet. Gateway endpoints are free and keep traffic within the AWS network, directly addressing anti-pattern-001 (Using NAT Gateway for traffic that could go through VPC endpoints). Option A (NAT Gateway) would incur hourly charges and data processing charges, making it less cost-effective. Option B (Interface VPC Endpoint) is also a valid way to access S3 privately, but it incurs hourly charges and endpoint-specific data processing charges, making the Gateway endpoint more cost-effective for S3. Option D (VPN connection) is for connecting to on-premises networks and is not designed for direct AWS service access.'
WHERE id = 'q_21_m_21_4_40';

-- Question ID: q_21_m_21_4_41
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C is correct. Deploying an AWS Transit Gateway and attaching all VPCs across the desired Regions is the most scalable and cost-effective solution for connecting multiple VPCs across different AWS Regions. It simplifies network management and provides a hub-and-spoke model for inter-Region connectivity over the AWS global backbone. Option A (individual VPC Peering connections) becomes complex and difficult to manage as the number of VPCs grows (N*(N-1)/2 connections). Option B (routing through the public internet) is less secure, higher latency, and generally more expensive due to egress charges, directly addressing anti-pattern-002. Option D (NAT Gateway) is for outbound internet access from private subnets within a single VPC and not for inter-Region VPC communication.'
WHERE id = 'q_21_m_21_4_41';

-- Question ID: q_66_m_66_2_2
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'IAM policies define permissions for users and roles, enabling fine-grained control over access to AWS resources and enforcing the principle of least privilege for sensitive data.'
WHERE id = 'q_66_m_66_2_2';

-- Question ID: q_21_m_21_4_43
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is correct. Enabling Amazon S3 Transfer Acceleration on the S3 bucket significantly improves upload performance for geographically distant clients. It routes uploads through CloudFront edge locations, leveraging the optimized AWS global network backbone, which directly addresses anti-pattern-003. Option A (Cross-Region Replication) is for data redundancy and disaster recovery, not for accelerating uploads from clients. Option C (Amazon CloudFront) is primarily for content delivery (downloads) to end-users, not for accelerating uploads to S3. Option D (AWS Direct Connect) is for establishing private network connections from on-premises data centers to AWS, not for accelerating uploads from individual internet-connected clients.'
WHERE id = 'q_21_m_21_4_43';

-- Question ID: q_21_m_21_1_37
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is correct. Applying an S3 Lifecycle policy to transition objects from S3 Standard to S3 Standard-IA, then to S3 Glacier Deep Archive, directly addresses the requirement for a known, tiered access pattern over time. This is the most cost-effective approach for data with predictable access changes. Option A (S3 Intelligent-Tiering) is ideal for unpredictable or changing access patterns (anti-pattern-003), but for known patterns, explicit lifecycle policies can be more cost-effective. Option C (keeping all data in S3 Standard and manual moves) is an anti-pattern (-001) as it''s not cost-optimized and requires manual effort. Option D (S3 One Zone-IA) is cheaper but offers lower durability and availability, and it doesn''t address the multi-stage lifecycle requirement.'
WHERE id = 'q_21_m_21_1_37';

-- Question ID: q_66_m_66_4_9
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Bedrock Guardrails enforce policies on model inputs and outputs, ensuring policy-compliant outputs and responsible AI usage.'
WHERE id = 'q_66_m_66_4_9';

-- Question ID: q_21_m_21_1_38
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is correct. Amazon S3 Intelligent-Tiering is specifically designed for data with unknown or changing access patterns. It automatically moves objects between frequent access, infrequent access, and archive instant access tiers, optimizing storage costs without performance impact or retrieval fees. This directly addresses anti-pattern-003. Option A (S3 Standard) is more expensive for data that becomes infrequently accessed. Option C (S3 Standard-IA) is suitable for known infrequent access, but not for unpredictable changes. Option D (S3 Glacier Instant Retrieval) is for rarely accessed data with a higher retrieval cost compared to Intelligent-Tiering''s infrequent access tiers, and it''s not designed for automatically adapting to frequent access.'
WHERE id = 'q_21_m_21_1_38';

-- Question ID: q_21_m_21_1_39
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C is correct. Amazon S3 Glacier Deep Archive is specifically designed for long-term data archival (7-10 years or more) at the lowest storage cost, with retrieval times typically within hours. This perfectly matches the requirement for 10-year retention with tolerance for multi-hour retrieval. Option A (S3 Standard) is significantly more expensive for long-term archival, relating to anti-pattern-001. Option B (S3 Glacier Instant Retrieval) offers millisecond retrieval but is more expensive than Deep Archive. Option D (S3 Standard-IA) is for infrequently accessed data that needs rapid access, but it''s not as cost-effective as Glacier Deep Archive for very long-term, rarely accessed data.'
WHERE id = 'q_21_m_21_1_39';

-- Question ID: q_21_m_21_1_40
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B is correct. Amazon EBS General Purpose SSD (gp3) with default settings provides a baseline of 3,000 IOPS and 125 MiB/s throughput at no additional cost. This easily meets the application''s requirements of 2,500 IOPS and 100 MiB/s, making it the most cost-effective choice. Option A (Provisioned IOPS SSD io2) is significantly more expensive and is only necessary when requirements exceed gp3 limits (up to 16,000 IOPS), representing anti-pattern-002. Option C (Throughput Optimized HDD st1) is designed for large, sequential workloads and is not optimized for the IOPS requirements of this application. Option D (Cold HDD sc1) is for very infrequently accessed data and would not meet the performance requirements for frequently read/written temporary files.'
WHERE id = 'q_21_m_21_1_40';

-- Question ID: q_19_m_19_1_46
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon SQS provides a fully managed message queuing service that enables you to decouple and scale microservices, distributed systems, and serverless applications. It''s ideal for asynchronous communication.'
WHERE id = 'q_19_m_19_1_46';

-- Question ID: q_19_m_19_1_47
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon SNS is a highly available, durable, secure, fully managed publish/subscribe messaging service that enables you to decouple microservices, distributed systems, and serverless applications.'
WHERE id = 'q_19_m_19_1_47';

-- Question ID: q_19_m_19_1_48
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'To make an application horizontally scalable, it must be stateless. Session data should be stored externally (e.g., in Amazon ElastiCache or Amazon DynamoDB) so any instance can handle any user request.'
WHERE id = 'q_19_m_19_1_48';

-- Question ID: q_19_m_19_1_49
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Amazon Elastic Container Service (ECS) is a fully managed container orchestration service that helps you deploy, manage, and scale containerized applications. It''s ideal for migrating monolithic applications to a container-based architecture.'
WHERE id = 'q_19_m_19_1_49';

-- Question ID: q_19_m_19_1_50
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon API Gateway allows developers to create, publish, maintain, monitor, and secure APIs at any scale. It acts as a ''front door'' for applications to access data, business logic, or functionality from your backend services, including microservices.'
WHERE id = 'q_19_m_19_1_50';

-- Question ID: q_18_m_18_1_36
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Assigning an IAM role to the AWS Lambda function is the recommended and most secure approach. This provides temporary credentials automatically to the function, eliminating the need to manage long-term access keys and adhering to the principle of least privilege. Option A (embedding access keys) is an anti-pattern (-002) as it risks exposure and makes key rotation difficult. Option C (manual STS AssumeRole calls) adds unnecessary complexity and operational overhead to the Lambda function code, which is typically managed by the service itself. Option D (resource-based policy on S3) would grant overly broad access to any Lambda function, violating the principle of least privilege, and is not the primary mechanism for granting service-to-service permissions from an invoking service.'
WHERE id = 'q_18_m_18_1_36';

-- Question ID: q_18_m_18_1_37
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'AWS IAM Identity Center (successor to AWS SSO) is designed for centralized access management to multiple AWS accounts and business applications, and it supports integration with existing Microsoft Active Directory for simplified user management and a single sign-on experience. This minimizes administrative overhead. Option B (individual IAM users) is highly unscalable and creates significant management burden. Option C (Amazon Cognito User Pool) is primarily for customer-facing applications, not for internal employee access to AWS accounts, and would require additional integration for authorization (-004). Option D (custom identity broker) introduces significant operational overhead for development, maintenance, and security, which contradicts the goal of minimizing administrative overhead.'
WHERE id = 'q_18_m_18_1_37';

-- Question ID: q_18_m_18_1_38
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Configuring a Service Control Policy (SCP) at the Organizational Unit (OU) level is the most efficient way to centrally enforce Region restrictions across multiple accounts in AWS Organizations. SCPs are preventive controls that apply to all IAM users and roles within the affected accounts, minimizing administrative effort. Option A (individual IAM policies) is highly manual and error-prone across many accounts. Option C (AWS Config rules) provides detection but not prevention, allowing non-compliant actions to occur before reporting. Option D (custom Lambda function) introduces significant operational overhead for development and maintenance, and also acts reactively rather than preventively.'
WHERE id = 'q_18_m_18_1_38';

-- Question ID: q_18_m_18_1_39
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Network Access Control Lists (NACLs) are stateless and operate at the subnet level, allowing explicit deny rules for inbound and outbound traffic. This perfectly meets the requirement for a stateless filtering mechanism at the subnet level and the ability to explicitly deny traffic. Option A (security groups for deny rules) is an anti-pattern (-003) because security groups are stateful and only support allow rules, not explicit deny rules. Option C (AWS WAF) is designed for web application firewalls and cannot be directly applied to an Amazon RDS instance for network-level filtering. Option D (route table blackholing) would prevent all traffic from those IPs from reaching the subnet, but NACLs provide more granular control for specific ports and protocols, and are the intended service for subnet-level deny rules.'
WHERE id = 'q_18_m_18_1_39';

-- Question ID: q_18_m_18_1_40
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon Cognito User Pools handle user authentication (sign-up, sign-in, and token issuance), while Amazon Cognito Identity Pools handle authorization by exchanging those tokens for temporary AWS credentials, allowing users to access AWS services. This combination is ideal for mobile and web applications. Option B (AWS IAM Identity Center) is for workforce identities accessing AWS accounts, not for customer-facing applications. Option C (IAM roles with direct access keys) is an anti-pattern (-002) as it involves long-term credentials and is not suitable for direct application access. Option D (IAM users for authentication) is not scalable for customer-facing applications and is not the intended use for IAM users (-004).'
WHERE id = 'q_18_m_18_1_40';

-- Question ID: q_64_m_64_5_8
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Reranking models evaluate the initially retrieved set of documents to re-order them based on a more nuanced understanding of the query and document content, significantly improving the relevance of the final retrieved set.'
WHERE id = 'q_64_m_64_5_8';

-- Question ID: q_18_m_18_1_41
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Creating Gateway VPC Endpoints for Amazon S3 and Amazon DynamoDB allows instances in private subnets to access these services without traversing the public internet, a NAT Gateway, or a VPN. Gateway endpoints are free and are configured as route table entries, requiring no additional infrastructure to manage, thus offering the least operational overhead. Option A (NAT Gateway) would work but adds cost and still routes traffic through the AWS public network edge, not entirely private. Option C (Site-to-Site VPN) adds unnecessary complexity and latency. Option D (Internet Gateway with Elastic IPs) would expose the instances to the internet, violating the security policy for private access.'
WHERE id = 'q_18_m_18_1_41';

-- Question ID: q_18_m_18_1_42
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Attaching an IAM policy that explicitly denies actions unless MFA is present in the request context (e.g., using the `aws:MultiFactorAuthPresent` condition key) is the most effective way to enforce MFA for all IAM users. This policy prevents users from performing actions if they haven''t authenticated with MFA. Option A (advising users) relies on manual compliance and is not an enforcement mechanism. Option C (AWS Config rule) provides detection and reporting but does not prevent non-MFA authenticated actions. Option D (custom Lambda function) is a reactive solution that adds operational overhead and does not prevent the initial non-MFA authenticated action.'
WHERE id = 'q_18_m_18_1_42';

-- Question ID: q_18_m_18_2_36
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS Certificate Manager (ACM) provides free, publicly trusted SSL/TLS certificates that can be easily provisioned and associated with AWS services like Application Load Balancers. ACM automatically renews these certificates, eliminating manual intervention and meeting the requirements for trusted, auto-renewing, and free certificates. Option A (self-signed certificates) is an anti-pattern (-004) as they cause browser warnings and are not trusted by default. Option B (third-party certificates uploaded to IAM) involves purchasing and manual renewal, which contradicts the ''free'' and ''automatic renewal'' requirements. Option D (Secrets Manager for self-signed certificates) is incorrect as Secrets Manager is for credentials, not public certificates, and self-signed certificates are not suitable for public-facing endpoints.'
WHERE id = 'q_18_m_18_2_36';

-- Question ID: q_18_m_18_2_37
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Utilizing Network Access Control Lists (NACLs) at the subnet level and Security Groups at the instance level provides a robust defense-in-depth strategy. NACLs offer stateless filtering for all traffic entering or leaving a subnet, while Security Groups provide stateful filtering for individual instances. Option A (only Security Groups) lacks the subnet-level stateless filtering for defense-in-depth (-003). Option B (AWS WAF) is for web application protection, not general network traffic filtering at the subnet or instance level. Option D (AWS Shield Advanced) is for DDoS protection, not granular port/protocol control or subnet-level filtering.'
WHERE id = 'q_18_m_18_2_37';

-- Question ID: q_18_m_18_2_38
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Systems Manager Session Manager provides secure, auditable shell access to EC2 instances without requiring inbound ports (like SSH port 22) to be open in security groups, thus eliminating the vulnerability of opening port 22 to 0.0.0.0/0 (-001). It also minimizes operational overhead by not requiring bastion hosts or VPNs for simple shell access. Option A (bastion host) is a valid solution but adds operational overhead compared to Session Manager. Option C (Site-to-Site VPN) is also a valid solution but is more complex and adds overhead for simple shell access. Option D (AWS WAF) is for web application protection and cannot secure SSH access to EC2 instances.'
WHERE id = 'q_18_m_18_2_38';

-- Question ID: q_18_m_18_2_39
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS Secrets Manager is specifically designed for securely storing, retrieving, and automatically rotating database credentials, API keys, and other secrets. It integrates with AWS services like Amazon RDS for automatic rotation and provides fine-grained access control and auditing through AWS CloudTrail. Option A (plain text in S3) is highly insecure. Option B (environment variables) is an anti-pattern (-002) as these are visible and not designed for secure, rotatable secret management. Option D (KMS + DynamoDB) is a custom solution that would require significant development and operational overhead to implement rotation and access control, whereas Secrets Manager provides this as a managed service.'
WHERE id = 'q_18_m_18_2_39';

-- Question ID: q_66_m_66_2_3
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon Comprehend can detect PII in text, while Amazon Macie uses machine learning to discover, classify, and protect sensitive data, including PII, across AWS.'
WHERE id = 'q_66_m_66_2_3';

-- Question ID: q_18_m_18_2_40
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'AWS Shield Standard provides automatic protection against common network and transport layer (Layer 3 and 4) DDoS attacks for all AWS customers at no additional cost. AWS WAF protects web applications from common web exploits (Layer 7) that could affect application availability or compromise security. This combination provides robust protection against the described threats with minimal configuration. Option B (GuardDuty and Inspector) are for threat detection and vulnerability assessment, not active DDoS or web exploit prevention. Option C (NACLs and Security Groups) are fundamental network controls but are not designed to dynamically mitigate sophisticated DDoS attacks. Option D (AWS Shield Advanced and Macie) is a more comprehensive and costly solution, with Macie being for data discovery, not DDoS protection, exceeding the ''minimal configuration'' and ''basic protection'' requirement for web exploits.'
WHERE id = 'q_18_m_18_2_40';

-- Question ID: q_18_m_18_2_41
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Direct Connect establishes a dedicated, private network connection from your on-premises data center to AWS, bypassing the public internet. This provides consistent network performance and dedicated bandwidth, which is critical for sensitive data and production environments. Option A (Site-to-Site VPN) uses the public internet, which does not guarantee consistent performance or dedicated bandwidth. Option C (Internet Gateway with EC2 tunnel) is an insecure and unscalable custom solution. Option D (VPC Peering) connects two VPCs within AWS, not an on-premises data center to a VPC.'
WHERE id = 'q_18_m_18_2_41';

-- Question ID: q_18_m_18_2_42
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing Network Access Control Lists (NACLs) at the subnet level allows for explicit deny rules and stateless filtering, which is crucial for PCI compliance and defense-in-depth. Security Groups provide stateful firewall rules at the instance level, controlling inbound and outbound traffic. This combination offers robust, layered network security. Option A (only Security Groups) is an anti-pattern (-003) as security groups are stateful and do not support explicit deny rules at the subnet level. Option C (AWS WAF) is for web application protection, not general network traffic filtering at the subnet level. Option D (AWS Shield Advanced) is for DDoS protection and does not provide granular network access control.'
WHERE id = 'q_18_m_18_2_42';

-- Question ID: q_18_m_18_2_43
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS Systems Manager Session Manager provides secure, auditable, and browser-based shell access to EC2 instances without requiring inbound ports (like SSH port 22) to be open in security groups. This directly addresses the anti-pattern (-001) of opening port 22 to 0.0.0.0/0 and is operationally efficient as it eliminates the need for managing SSH keys or bastion hosts. Option A (opening port 22 to 0.0.0.0/0) is a critical security anti-pattern. Option B (bastion host) is a valid, more secure alternative to direct internet SSH, but Session Manager is generally more operationally efficient. Option D (custom VPN solution) adds significant operational overhead for setup and maintenance compared to Session Manager.'
WHERE id = 'q_18_m_18_2_43';

-- Question ID: q_18_m_18_3_36
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Server-Side Encryption with AWS KMS customer managed keys (CMKs) allows the company to fully control the encryption keys, manage key policies, enable automatic key rotation, and audit all key usage through AWS CloudTrail, meeting all compliance requirements. This is a managed service, minimizing operational burden compared to manual key management. Option A (SSE-S3) uses AWS-managed keys, which do not provide the customer with full control or auditability (-001). Option B (Client-Side Encryption) places the full burden of key management, rotation, and auditing on the application, increasing operational complexity significantly. Option D (SSE-C) requires the customer to provide and manage keys with every request, which is operationally intensive and does not offer built-in rotation or centralized auditing.'
WHERE id = 'q_18_m_18_3_36';

-- Question ID: q_18_m_18_3_37
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Enabling S3 Versioning on the bucket and then applying S3 Object Lock in WORM (Write Once Read Many) mode with a retention period of seven years will prevent objects from being accidentally or maliciously deleted or overwritten. S3 Object Lock requires versioning to be enabled (-002). Option A (Lifecycle policies) is for cost optimization and data archival, not for WORM compliance or preventing deletion. Option C (bucket policy) can be circumvented by users with sufficient permissions to modify the policy itself. Option D (Cross-Region Replication) is for disaster recovery and redundancy, not for WORM compliance or preventing object modification within the source bucket.'
WHERE id = 'q_18_m_18_3_37';

-- Question ID: q_18_m_18_3_38
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS CloudHSM provides dedicated, single-tenant hardware security modules (HSMs) that are FIPS 140-2 Level 3 validated, giving the customer exclusive control over their encryption keys. This is the only AWS service that meets the specific requirement for FIPS 140-2 Level 3 validation and exclusive customer control over the HSM. Option A (SSE-S3) uses AWS-managed keys and does not offer customer control over the HSM. Option B (AWS KMS CMKs) uses FIPS 140-2 Level 2 validated HSMs and is a multi-tenant service, not providing exclusive control (-004). Option D (third-party client-side encryption) introduces significant operational overhead and may not meet the ''FIPS 140-2 Level 3'' and ''exclusive control'' requirements as easily as CloudHSM.'
WHERE id = 'q_18_m_18_3_38';

-- Question ID: q_18_m_18_3_39
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Enabling S3 Versioning and applying S3 Object Lock with a Compliance retention mode for five years ensures that objects cannot be overwritten or deleted by any user, including the root user, during the specified period. This satisfies the immutability requirement for regulatory compliance. Option A (Lifecycle policies) is for cost management and transitions, not immutability. Option B (Governance retention mode) allows some privileged users to bypass the lock, which does not meet the strict immutability requirement. Option D (bucket policies) can be modified or removed by users with sufficient permissions, making it less robust than Object Lock for immutability.'
WHERE id = 'q_18_m_18_3_39';

-- Question ID: q_64_m_64_3_5
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Multimodal data processing pipelines are designed to ingest, process, and integrate different data types (text, image, audio, video) into a unified format suitable for consumption by AI models, which is essential for advanced GenAI applications.'
WHERE id = 'q_64_m_64_3_5';

-- Question ID: q_18_m_18_3_40
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Enabling SSL/TLS encryption for the Amazon RDS database instance and configuring the application to use TLS connections is the standard and most straightforward way to encrypt data in transit between EC2 and RDS. RDS supports TLS natively, and this approach requires minimal configuration. Option A (custom VPN tunnel) is overly complex and introduces unnecessary operational overhead and potential latency within the same VPC. Option C (AWS PrivateLink) is for connecting to services across VPCs or accounts, not for encrypting traffic between EC2 and RDS within the same VPC. Option D (ALB in front of RDS) is not a typical or efficient pattern for database connections and would add unnecessary complexity and latency.'
WHERE id = 'q_18_m_18_3_40';

-- Question ID: q_19_m_19_1_63
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Sending messages to an Amazon SQS queue and processing them with an Auto Scaling group of Amazon EC2 instances (Option B) provides a highly reliable and scalable solution. Amazon SQS acts as a buffer, decoupling the ingestion of orders from their processing, preventing message loss during spikes. The Auto Scaling group can dynamically adjust processing capacity based on queue depth, and long polling reduces empty receives and costs. Option A (Synchronous Lambda invocation) can hit concurrency limits and has a 15-minute timeout, making it less suitable for long-running, spiky workloads, and tightly couples the API to the processing. Option C (ALB with CPU-based scaling) reacts slower to sudden spikes and may drop requests during scale-out, and synchronous processing is an anti-pattern for resilience. Option D (Amazon Kinesis Data Streams) is suitable for high-throughput streaming but requires shard capacity planning and management, which increases operational overhead compared to SQS for this specific message queuing scenario.'
WHERE id = 'q_19_m_19_1_63';

-- Question ID: q_18_m_18_3_41
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Configuring S3 Lifecycle policies to transition objects to a lower-cost storage class like S3 Glacier after an initial period (e.g., 30 days) and then expire them after 10 years (total retention) automates both cost optimization and the permanent deletion requirement. This ensures compliance with the data retention policy. Option A (manual deletion) is inefficient and prone to human error. Option B (Versioning and Object Lock) ensures immutability but does not automatically delete objects after the retention period; it only prevents premature deletion. Option D (Cross-Region Replication) is for disaster recovery and redundancy, not for automated data retention and deletion.'
WHERE id = 'q_18_m_18_3_41';

-- Question ID: q_18_m_18_3_42
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'S3 Intelligent-Tiering is the most cost-effective solution for data with changing or unknown access patterns. It automatically moves objects between two access tiers (frequently accessed and infrequently accessed) and an optional archive access tier, optimizing storage costs without performance impact or operational overhead. This meets the requirement for real-time analytics for 30 days and then cost-effective archiving. Option A (S3 Standard-IA for 7 years) would be more expensive for the first 30 days of frequent access. Option B (S3 Glacier Deep Archive from ingestion) would make real-time analytics impossible due to retrieval times and costs. Option D (manual lifecycle policies) requires predicting access patterns and more complex configuration than Intelligent-Tiering, which automates this process.'
WHERE id = 'q_18_m_18_3_42';

-- Question ID: q_18_m_18_3_43
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS CloudHSM provides dedicated hardware security modules (HSMs) that are FIPS 140-2 Level 3 validated, giving the customer exclusive control over their encryption keys, including the ability to import, generate, and perform cryptographic operations directly within the HSM. This meets the stringent compliance and control requirements. Option A (AWS KMS CMKs) uses FIPS 140-2 Level 2 validated HSMs and is a multi-tenant service, not providing the exclusive control over the HSM (-004). Option B (AWS Secrets Manager) is for storing and rotating secrets, not for managing cryptographic keys within an HSM. Option D (Amazon DynamoDB) is a database service and not designed for secure, FIPS-validated key management.'
WHERE id = 'q_18_m_18_3_43';

-- Question ID: q_18_m_18_3_44
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Server-Side Encryption with AWS KMS customer managed keys (CMKs) allows the company to use their own keys, manage key policies, and critically, all API calls made to the CMK are logged in AWS CloudTrail, providing a comprehensive audit trail of key usage. This directly addresses the requirement for an audit trail. Option A (SSE-S3) uses AWS-managed keys, which do not provide customer control or an audit trail of key usage (-001). Option B (Client-Side Encryption) requires the customer to implement and manage the audit trail, increasing operational overhead. Option D (SSE-C) uses customer-provided keys but does not provide an automatic audit trail of key usage through AWS CloudTrail for the key itself.'
WHERE id = 'q_18_m_18_3_44';

-- Question ID: q_19_m_19_1_72
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Publishing events to Amazon SNS topics that fan out to Amazon SQS queues, with AWS Lambda functions consuming messages (Option D), is an excellent pattern for loosely coupled, event-driven microservices. Amazon SNS provides a publish/subscribe mechanism, and Amazon SQS queues act as buffers, ensuring messages are not lost and services can process them at their own pace. AWS Lambda functions can then process these messages asynchronously. Option A (direct HTTP calls via API Gateway) creates tight coupling and can lead to cascading failures. Option B (AWS Step Functions with synchronous Lambda calls) is for orchestrating workflows but implies synchronous steps by default, which is not ideal for loosely coupled asynchronous communication unless designed specifically for asynchronous callbacks. Option C (ALB distributing requests directly) is a load balancing solution for synchronous HTTP traffic and does not provide the asynchronous decoupling required.'
WHERE id = 'q_19_m_19_1_72';

-- Question ID: q_18_m_18_1_43
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Attaching an IAM role to an Amazon EC2 instance is the most secure and operationally efficient way to provide AWS credentials to applications running on that instance. The instance automatically receives temporary, rotating credentials, eliminating the need to manage long-term access keys in the application code or configuration. Option A involves managing long-term access keys, which is less secure and higher operational overhead than roles. Option C directly violates the anti-pattern [-002] by embedding long-term access keys in application code, which is highly insecure. Option D, while more secure than hardcoding, still requires custom application logic for retrieval and rotation, increasing operational overhead compared to using IAM roles.'
WHERE id = 'q_18_m_18_1_43';

-- Question ID: q_18_m_18_1_44
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'AWS IAM Identity Center (successor to AWS SSO) is designed for centralized access management across multiple AWS accounts and can easily integrate with existing on-premises Active Directory, providing a single sign-on experience. This approach significantly minimizes administrative effort for identity synchronization and access management. Option B is highly manual and does not scale for a large enterprise, increasing administrative overhead. Option C involves deploying multiple Active Directory instances, which is complex and costly. Option D requires significant development and maintenance effort, increasing operational overhead compared to a managed service like IAM Identity Center.'
WHERE id = 'q_18_m_18_1_44';

-- Question ID: q_18_m_18_1_45
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'The principle of least privilege dictates granting only the permissions absolutely necessary. For reading S3 objects, `s3:GetObject` is sufficient. For writing CloudWatch Logs, `logs:CreateLogStream` (if the stream doesn''t exist) and `logs:PutLogEvents` are needed. Option A grants overly broad `s3:*` and `logs:*` permissions, violating least privilege. Option B is almost correct but misses `logs:CreateLogStream`, which might be needed if the log stream doesn''t pre-exist. Option D uses AWS managed policies which typically grant more permissions than required for a specific application, thus violating the principle of least privilege.'
WHERE id = 'q_18_m_18_1_45';

-- Question ID: q_18_m_18_1_46
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon Cognito User Pools handle user authentication (sign-up, sign-in, token issuance), while Amazon Cognito Identity Pools (federated identities) are used to exchange these tokens for temporary, limited-privilege AWS credentials, enabling access to AWS services like Amazon S3. This correctly addresses both authentication and authorization. Option B represents the anti-pattern [-004] by confusing User Pools with Identity Pools; User Pools do not directly grant AWS resource access. Option C is highly insecure and unscalable, as it involves managing long-term credentials for individual users. Option D is incorrect because AWS IAM Identity Center is primarily for workforce identities accessing AWS accounts, not for external application users.'
WHERE id = 'q_18_m_18_1_46';

-- Question ID: q_18_m_18_1_47
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Creating an IAM role in Account B with the necessary permissions and a trust policy that allows users or roles from Account A to assume it is the standard and most secure way to enable cross-account access. This approach leverages temporary credentials and adheres to the principle of least privilege. Option A creates long-term credentials in Account B for each user, increasing management overhead and security risk. Option C is a severe security anti-pattern, as sharing root credentials grants unrestricted access and is highly insecure. Option D is incorrect; a VPN connection is for network connectivity, not for identity and access management between AWS accounts.'
WHERE id = 'q_18_m_18_1_47';

-- Question ID: q_18_m_18_2_44
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Opening port 22 to `0.0.0.0/0` is an anti-pattern [-001] as it exposes instances to brute-force attacks. AWS Systems Manager Session Manager provides secure, auditable shell access to EC2 instances without opening inbound ports, managing SSH keys, or requiring a bastion host, thus minimizing exposure and operational overhead. Option A is a valid secure pattern but involves managing an additional EC2 instance (bastion host). Option B is also secure but requires setting up and maintaining a VPN connection, which adds complexity. Option D is incorrect because NACLs are stateless and would block all port 22 traffic, preventing legitimate SSH access, and keeping the security group rule open still presents a vulnerability.'
WHERE id = 'q_18_m_18_2_44';

-- Question ID: q_18_m_18_2_45
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Storing database credentials in environment variables is an anti-pattern [-002] as they are visible and difficult to manage. AWS Secrets Manager is the recommended service for securely storing, retrieving, and automatically rotating database credentials, integrating directly with Amazon RDS. This minimizes manual intervention and enhances security. Option B still requires manual rotation and management of the encrypted file. Option C requires manual rotation, increasing operational overhead. Option D is highly insecure as it embeds long-term access keys in code and grants direct database access, violating best practices.'
WHERE id = 'q_18_m_18_2_45';

-- Question ID: q_18_m_18_2_46
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Security groups are stateful and allow-only, meaning they do not support explicit deny rules. Network ACLs (NACLs) are stateless and operate at the subnet level, providing an additional layer of defense-in-depth with explicit allow and deny rules, as highlighted by anti-pattern [-003]. Configuring a NACL to deny outbound traffic to `0.0.0.0/0` ensures no traffic leaves the subnet for the internet. Option A is incorrect because security groups do not support deny rules. Option C is a good practice but does not provide an explicit deny rule at the network level if routing changes or a NAT gateway is introduced. Option D is for web application protection and operates at the application layer, not the network layer for outbound database traffic.'
WHERE id = 'q_18_m_18_2_46';

-- Question ID: q_18_m_18_2_47
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS Certificate Manager (ACM) provides free, auto-renewing public TLS certificates that can be directly associated with services like Application Load Balancers, significantly reducing operational overhead and cost. Option A represents the anti-pattern [-004] as self-signed certificates cause browser warnings and erode user trust. Option B is a valid approach but incurs cost for the third-party certificate and still requires manual import if not using ACM for issuance. Option D involves significant manual effort for creation, renewal, and upload, increasing operational overhead and risk of expiration.'
WHERE id = 'q_18_m_18_2_47';

-- Question ID: q_18_m_18_2_48
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS Shield Advanced provides enhanced DDoS protection for applications, while AWS WAF (Web Application Firewall) specifically protects web applications from common web exploits like SQL injection and XSS by allowing the creation of custom rules. This combination offers comprehensive protection against the specified threats. Option A and B are fundamental network security controls but do not protect against application-layer exploits or sophisticated DDoS attacks. Option D is for threat detection within the AWS environment, not for direct protection against external web exploits or DDoS attacks.'
WHERE id = 'q_18_m_18_2_48';

-- Question ID: q_18_m_18_2_49
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon GuardDuty is a threat detection service that continuously monitors for malicious activity and unauthorized behavior to protect AWS accounts and workloads. It uses machine learning, anomaly detection, and integrated threat intelligence to identify potential threats without requiring manual rule setup. Option A provides logs but requires manual analysis, which is not proactive or efficient. Option C is for compliance auditing, not real-time threat detection. Option D focuses on sensitive data discovery and protection in S3, not general threat detection across the AWS environment.'
WHERE id = 'q_18_m_18_2_49';

-- Question ID: q_18_m_18_3_45
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'S3 Object Lock provides WORM (Write Once Read Many) protection for objects, making them immutable for a specified retention period. It requires S3 Versioning to be enabled on the bucket, as highlighted by anti-pattern [-002]. This solution directly meets the immutability and retention requirements with minimal operational overhead. Option B is for cost optimization and archival, but S3 Glacier Deep Archive itself does not inherently provide WORM immutability without Object Lock. Option C requires significant custom development and maintenance. Option D provides disaster recovery but does not inherently guarantee immutability in the source or destination bucket without Object Lock.'
WHERE id = 'q_18_m_18_3_45';

-- Question ID: q_19_m_19_1_73
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Storing session data in a distributed, external store like Amazon ElastiCache for Redis or Amazon DynamoDB (Option A) is the best practice for managing user sessions in a horizontally scalable web application. This decouples session state from individual EC2 instances, making the application stateless and resilient to instance failures or scaling events. Option B (sticky sessions on ALB) can help but hinders true horizontal scalability and resilience, as it creates dependencies on specific instances and can lead to uneven load distribution or session loss if an instance fails. Option C (local file system replication) is complex to implement, inefficient, and prone to consistency issues. Option D (increasing instance size) is vertical scaling, which has limits and does not solve the fundamental problem of session persistence across multiple instances.'
WHERE id = 'q_19_m_19_1_73';

-- Question ID: q_18_m_18_3_46
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS CloudHSM provides dedicated hardware security modules (HSMs) that are FIPS 140-2 Level 3 validated, giving customers exclusive control over their encryption keys within a single-tenant environment. This directly meets the strict compliance requirement. Option A (AWS KMS) is a managed service that is FIPS 140-2 Level 2 validated and does not offer the same level of exclusive, single-tenant hardware control as CloudHSM, representing anti-pattern [-004]. Option C is for credential management, not primary cryptographic key management. Option D describes an S3 encryption method, not the underlying key management service itself.'
WHERE id = 'q_18_m_18_3_46';

-- Question ID: q_64_m_64_3_6
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Glue Data Quality allows developers to define, monitor, and manage data quality rules directly within AWS Glue ETL jobs, ensuring that data meets specified standards before being used by FMs.'
WHERE id = 'q_64_m_64_3_6';

-- Question ID: q_18_m_18_3_47
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'S3 Lifecycle policies are designed to automatically transition objects between different S3 storage classes based on predefined rules, optimizing storage costs and meeting retention requirements. Transitioning from S3 Standard to S3 Glacier after 30 days and then to S3 Glacier Deep Archive after 5 years aligns perfectly with the access patterns and retention needs. Option B requires manual intervention, which is inefficient and prone to errors. Option C is for immutability, not for cost-optimized tiering based on access patterns. Option D requires custom development and maintenance, increasing operational overhead compared to a native S3 feature.'
WHERE id = 'q_18_m_18_3_47';

-- Question ID: q_18_m_18_3_48
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'AWS Certificate Manager (ACM) provides free, publicly trusted TLS certificates that are automatically renewed by AWS. Associating an ACM certificate with an Application Load Balancer ensures encrypted traffic in transit with the least operational overhead. Option A is highly insecure as self-signed certificates are not trusted by browsers. Option B involves manual certificate management and renewal, increasing operational overhead and risk of expiration. Option C is incorrect; AWS KMS is for managing encryption keys, not for issuing or managing public TLS certificates for web applications.'
WHERE id = 'q_18_m_18_3_48';

-- Question ID: q_18_m_18_1_48
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Attaching an IAM role to an Amazon EC2 instance is the most secure and operationally efficient way to grant AWS permissions to applications running on that instance. The instance automatically receives temporary credentials, eliminating the need to embed long-term access keys in code or manage their rotation. This aligns with the principle of least privilege and best practices. Storing keys in Parameter Store (Option B) is more secure than embedding them, but still requires the application to retrieve and manage them, adding more operational overhead than an IAM role. Configuring a public S3 bucket policy (Option C) is a major security vulnerability and grants far too broad access. Generating temporary credentials with STS for each request (Option D) is overly complex and introduces significant operational overhead for the application development team, as the application would need to manage the credential lifecycle itself.'
WHERE id = 'q_18_m_18_1_48';

-- Question ID: q_18_m_18_1_49
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS IAM Identity Center (successor to AWS SSO) is designed to centralize access management for multiple AWS accounts and cloud applications. It allows integration with existing corporate directories (like Active Directory) or its own identity store, providing a single sign-on experience and simplifying permission management across all linked accounts. Creating a custom identity broker (Option A) would be a complex and high-overhead development effort. Configuring cross-account IAM roles (Option C) is part of a multi-account strategy but does not centralize user authentication or simplify the user experience for hundreds of employees. SCPs (Option D) are used to set maximum permissions for accounts within an organization, not for managing individual user authentication or granting access.'
WHERE id = 'q_18_m_18_1_49';

-- Question ID: q_18_m_18_1_50
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'The AWS account root user has unrestricted access to all resources in the account and cannot be scoped down, making its use for daily operations a severe security anti-pattern [-001]. The best practice is to secure the root user credentials, enable MFA, and use it only for a very limited set of tasks that explicitly require root user permissions (e.g., changing account settings, closing the account). For daily administrative tasks, an IAM user or role with appropriate, least-privilege permissions should be used (Option B is a step in the right direction but still grants full admin access, which should be a role for specific tasks). Continuing to use the root user (Option A) or only enabling MFA (Option C) without restricting its use for daily operations still violates the principle of least privilege and poses a significant security risk.'
WHERE id = 'q_18_m_18_1_50';

-- Question ID: q_18_m_18_1_51
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Network Access Control Lists (NACLs) are stateless, optional security layers that operate at the subnet level. They support both allow and deny rules, making them ideal for explicitly blocking traffic from specific IP ranges at the subnet boundary. Security groups (Option A) are stateful and only support allow rules; they cannot explicitly deny traffic, representing anti-pattern [-003]. AWS WAF (Option B) operates at the application layer and protects web applications, not raw network traffic at the subnet level. Creating a custom routing table entry (Option D) could blackhole traffic but is a more drastic and less granular approach than a NACL for specific IP ranges and is not the primary tool for this type of network filtering.'
WHERE id = 'q_18_m_18_1_51';

-- Question ID: q_18_m_18_1_52
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon Cognito User Pools handle user authentication (sign-up, sign-in, and managing user profiles), while Amazon Cognito Identity Pools provide temporary, limited-privilege AWS credentials to authenticated users, allowing them to access AWS services like Amazon S3 directly. This combination is ideal for mobile and web applications. Using AWS IAM Identity Center (Option A) is for enterprise workforce access to AWS accounts, not typically for customer-facing applications. Creating individual IAM users (Option C) is not scalable, violates security best practices, and is an anti-pattern for customer-facing applications. Allowing anonymous uploads via an S3 bucket policy (Option D) is a major security risk, as anyone could upload files without authentication, and it does not provide user-specific access control.'
WHERE id = 'q_18_m_18_1_52';

-- Question ID: q_14_m_14_2_13
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Ground Truth is specifically designed for labeling data to create ground truth datasets for supervised machine learning.'
WHERE id = 'q_14_m_14_2_13';

-- Question ID: q_14_m_14_2_14
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS DataBrew and SageMaker Data Wrangler are services that offer visual interfaces for data cleaning and transformation.'
WHERE id = 'q_14_m_14_2_14';

-- Question ID: q_14_m_14_2_15
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Lambda and Spark are explicitly mentioned for transforming streaming data, enabling real-time processing within ML pipelines.'
WHERE id = 'q_14_m_14_2_15';

-- Question ID: q_14_m_14_3_21
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon SageMaker Clarify is explicitly mentioned for detecting bias in ML datasets.'
WHERE id = 'q_14_m_14_3_21';

-- Question ID: q_18_m_18_2_50
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Systems Manager Session Manager provides secure and auditable shell access to Amazon EC2 instances without opening inbound ports, managing SSH keys, or using bastion hosts. It operates over an encrypted tunnel and integrates with IAM for granular permissions, making it the most secure and operationally efficient solution. A bastion host (Option A) is a valid approach but introduces additional infrastructure to manage. A VPN connection (Option C) adds complexity and cost for network setup and client management. Opening port 22 to 0.0.0.0/0 (Option D) is a significant security anti-pattern [-001] as it exposes instances to the entire internet, making them vulnerable to brute-force attacks, even with strong SSH keys.'
WHERE id = 'q_18_m_18_2_50';

-- Question ID: q_18_m_18_2_51
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'AWS Secrets Manager is specifically designed for securely storing, managing, and automatically rotating secrets like database credentials. It integrates directly with Amazon RDS to automate credential rotation, significantly enhancing security and reducing operational overhead. Storing credentials in Parameter Store SecureString (Option B) is more secure than environment variables but does not offer automatic rotation for database credentials, requiring manual intervention. Embedding credentials in configuration files (Option C) is a security anti-pattern [-002] and is highly insecure. Creating an IAM role for RDS access (Option D) is not directly supported for database user authentication in the same way it is for AWS service API calls; RDS typically uses database-native authentication or IAM database authentication, but an IAM role alone doesn''t manage the database user''s password.'
WHERE id = 'q_18_m_18_2_51';

-- Question ID: q_18_m_18_2_52
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Network Access Control Lists (NACLs) operate at the subnet level and are stateless, allowing explicit allow and deny rules. This makes them suitable for blocking traffic from specific malicious IP ranges before it even reaches the instances within the subnet, providing defense-in-depth. Security groups (Option A) are stateful and only support allow rules; they cannot explicitly deny traffic, representing anti-pattern [-003]. AWS WAF (Option B) operates at the application layer (Layer 7) and protects resources like Application Load Balancers, not directly at the subnet level for all traffic. AWS Shield Advanced (Option D) provides DDoS protection at the network and transport layers but is not designed for granular, explicit IP-based deny rules at the subnet level.'
WHERE id = 'q_18_m_18_2_52';

-- Question ID: q_18_m_18_2_53
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'AWS Certificate Manager (ACM) provides free, publicly trusted TLS certificates that can be easily provisioned and deployed with services like Application Load Balancers. ACM also handles automatic certificate renewal, significantly reducing operational overhead and cost. Purchasing a third-party certificate (Option B) incurs cost and requires manual management and renewal. Generating a self-signed certificate (Option C) is a security anti-pattern [-004] for public-facing endpoints, as it will cause browser warnings and erode user trust. Disabling TLS on the Load Balancer (Option D) means traffic is unencrypted, which is a major security vulnerability for a public-facing application.'
WHERE id = 'q_18_m_18_2_53';

-- Question ID: q_18_m_18_2_54
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Gateway VPC endpoints provide private connectivity from a VPC to Amazon S3 and Amazon DynamoDB without requiring an internet gateway, NAT gateway, or VPN connection. They are configured as route table entries and ensure that traffic remains within the AWS network, meeting the security policy and minimizing complexity. A NAT gateway (Option B) allows instances in a private subnet to initiate outbound connections to the internet, but traffic still traverses the public internet edge, violating the policy. A VPN connection (Option C) is for connecting to on-premises networks, not for private access to AWS services within the same region. Assigning Elastic IP addresses (Option D) would require the instances to be in a public subnet and expose them to the internet, which violates the private subnet requirement.'
WHERE id = 'q_18_m_18_2_54';

-- Question ID: q_63_m_63_1_54
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B (AWS Free Tier) provides free usage of many AWS services up to specific limits for new accounts, allowing users to experiment and learn without cost. Option A (AWS Budgets) is for setting cost and usage alerts. Option C (AWS Cost Explorer) is for visualizing and analyzing spending patterns. Option D (AWS Organizations) is for managing multiple AWS accounts and consolidated billing.'
WHERE id = 'q_63_m_63_1_54';

-- Question ID: q_18_m_18_2_55
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon GuardDuty is a managed threat detection service that continuously monitors for malicious activity and unauthorized behavior to protect AWS accounts and workloads. It uses machine learning, anomaly detection, and integrated threat intelligence to identify potential threats, such as compromised EC2 instances, crypto-currency mining, or unusual API calls, without requiring agents. Amazon Inspector (Option A) focuses on vulnerability management for EC2 instances and container images, not general threat detection. Amazon Macie (Option B) specializes in sensitive data discovery and protection in S3. AWS Config (Option D) is for configuration compliance and auditing, not real-time threat detection.'
WHERE id = 'q_18_m_18_2_55';

-- Question ID: q_18_m_18_3_49
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'SSE-KMS with a customer managed key (CMK) provides the required control over the encryption key, including key policies, automatic annual rotation, and detailed audit logs via AWS CloudTrail for all key usage. This directly addresses the compliance need for customer control and auditability. SSE-S3 (Option A) uses AWS-managed keys, which does not provide the customer with the necessary control or audit capabilities, representing anti-pattern [-001]. SSE-C (Option C) requires the customer to manage and provide keys with every S3 request, which is operationally complex and doesn''t offer built-in rotation or auditing via KMS. Client-side encryption (Option D) is a valid approach but introduces significant operational overhead for key management, encryption/decryption logic within the application, and custom auditing, making it less desirable than managed KMS.'
WHERE id = 'q_18_m_18_3_49';

-- Question ID: q_18_m_18_3_50
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Amazon S3 Object Lock requires S3 Versioning to be enabled on the bucket. Versioning must be enabled either when the bucket is created or before Object Lock is configured. This ensures that every object modification or deletion attempt creates a new version, preserving the original object''s immutability. Failing to enable versioning before applying Object Lock is an anti-pattern [-002]. S3 Transfer Acceleration (Option A) is for faster data transfer, not a prerequisite for Object Lock. Lifecycle policies (Option B) can be used with Object Lock but are not a prerequisite for enabling it. An S3 bucket policy (Option C) can restrict deletion, but Object Lock provides stronger, WORM (Write Once Read Many) compliance-level immutability and still requires versioning.'
WHERE id = 'q_18_m_18_3_50';

-- Question ID: q_18_m_18_3_51
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'AWS CloudHSM provides dedicated, FIPS 140-2 Level 3 validated hardware security modules (HSMs) within the AWS cloud. It gives customers exclusive control over their cryptographic keys and direct management of the HSMs, which is a critical requirement for high-compliance environments. AWS KMS (Option A) is a managed service that uses FIPS 140-2 Level 2 validated hardware and does not provide dedicated, single-tenant HSMs or direct management, representing anti-pattern [-004] if the requirement is FIPS 140-2 Level 3 and direct control. Client-side encryption with a custom system (Option B) introduces significant operational overhead and would require the agency to manage compliance for their custom solution. AWS Secrets Manager (Option C) is for storing secrets, not for providing FIPS 140-2 Level 3 compliant HSMs for cryptographic operations.'
WHERE id = 'q_18_m_18_3_51';

-- Question ID: q_18_m_18_3_52
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Creating separate AWS KMS CMKs for each application or service is a best practice that limits the blast radius of a key compromise. If one key is compromised, only the data encrypted by that specific key is at risk, not all data across the entire account or organization. This directly addresses anti-pattern [-003]. While robust key rotation (Option A) is important, it doesn''t reduce the blast radius of a single key. Migrating to SSE-S3 (Option C) would remove customer control over keys and auditability, which is often not suitable for enterprise compliance needs. Using AWS CloudHSM (Option D) provides higher FIPS compliance but doesn''t inherently solve the blast radius issue if a single key is still used across all services; the recommendation is about key segmentation, not the underlying hardware.'
WHERE id = 'q_18_m_18_3_52';

-- Question ID: q_18_m_18_3_53
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon S3 Cross-Region Replication (CRR) is the most efficient and automated way to replicate objects between S3 buckets in different AWS Regions for disaster recovery and business continuity. Once configured, new objects uploaded to the source bucket are automatically replicated to the destination bucket with minimal latency and no operational overhead. An S3 Lifecycle policy (Option B) is for transitioning storage classes or expiring objects, not for immediate cross-region replication. Manually copying objects (Option C) is error-prone and not scalable. A custom AWS Lambda function (Option D) would introduce operational overhead for development and maintenance, whereas CRR is a fully managed S3 feature.'
WHERE id = 'q_18_m_18_3_53';

-- Question ID: q_19_m_19_2_51
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Creating an Amazon RDS for PostgreSQL read replica in the same AWS Region (Option A) is the correct approach to offload read traffic from the primary instance and improve read performance. Read replicas are designed to serve read queries, allowing the primary instance to focus on write operations. This is a standard and effective scaling strategy for read-heavy workloads with minimal operational overhead once configured. Option B is incorrect because the standby instance in an Amazon RDS Multi-AZ deployment is for high availability and disaster recovery only; it does not serve read traffic. This option represents the anti-pattern [-001] Assuming Multi-AZ RDS standby serves read traffic. Option C, upgrading the instance type, provides vertical scaling but has a performance ceiling and does not horizontally scale read capacity as effectively as read replicas. Option D, while effective for reducing database load, introduces a new service (Amazon ElastiCache) and thus more operational overhead than simply adding an RDS read replica for this specific requirement.'
WHERE id = 'q_19_m_19_2_51';

-- Question ID: q_19_m_19_2_52
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'To ensure automatic failover with Amazon Route 53, a health check must be associated with the primary application''s endpoint (Option A). The failover routing policy relies on health checks to determine the availability of an endpoint. Without an active health check, Route 53 assumes the primary endpoint is healthy and will not initiate a failover, even if the application instances are stopped. This scenario directly addresses the anti-pattern [-004] Confusing Route 53 failover routing with health checks. Option B involves manual intervention or custom code, which is not ideal for automatic failover. Option C, changing to weighted routing, is not designed for automatic failover based on health. Option D, deploying a second ALB and using multi-value answer routing, is for returning multiple healthy endpoints, not for automatic failover to a static site.'
WHERE id = 'q_19_m_19_2_52';

-- Question ID: q_19_m_19_2_53
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Deploying all resources in a single AZ is a single point of failure and violates the principle of designing for multi-AZ from the start (Option A). Retrofitting high availability into a single-AZ deployment later is significantly more complex and risky than designing for it from the beginning. This scenario directly relates to the anti-pattern [-003] Deploying all resources in a single AZ with the plan to move later. Option B, migrating to AWS Lambda, while providing multi-AZ capabilities, is a complete architectural shift and not the direct solution to address the single-AZ deployment of the current EC2-based application. Option C, introducing SQS, addresses loose coupling, which is a different architectural concern. Option D, using Spot Instances, focuses on cost optimization but does not inherently provide high availability for critical workloads.'
WHERE id = 'q_19_m_19_2_53';

-- Question ID: q_19_m_19_2_54
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'A pilot light strategy (Option D) is the most cost-effective option that meets the specified RTO (30 minutes) and RPO (5 minutes). An Amazon RDS cross-Region read replica provides near real-time data replication, satisfying the RPO. Pre-configured but stopped Amazon EC2 instances can be quickly started and scaled up, allowing the application to be fully operational within the 30-minute RTO. Option A, multi-site active/active, is the most expensive as it involves running a full, active stack in two regions. Option B, warm standby, is more expensive than pilot light because it requires running a scaled-down version of the application continuously. Option C, backup and restore, typically has a much longer RTO and RPO, making it unsuitable for the 30-minute RTO and 5-minute RPO requirements, as restoring a full environment from backups can take hours. This question tests understanding of DR strategies and their associated RTO/RPO and cost implications, using the anti-pattern [-002] Using pilot light when RTO requires sub-minute failover as a distractor for those who might misinterpret pilot light''s RTO capabilities.'
WHERE id = 'q_19_m_19_2_54';

-- Question ID: q_19_m_19_2_55
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon S3 Glacier Deep Archive (Option A) is specifically designed for long-term archiving of data that is accessed rarely, making it the most cost-effective and durable solution for petabytes of archival video footage with retrieval times of several hours. It offers the lowest cost storage in Amazon S3. Option B, Amazon S3 Standard, is suitable for frequently accessed data and would be significantly more expensive for archival purposes. Option C, Amazon EBS gp3, is block storage for EC2 instances, not suitable for petabyte-scale archival object storage. Option D, Amazon EFS, is a file system for shared access, also not designed for extremely low-cost, long-term archival of rarely accessed data.'
WHERE id = 'q_19_m_19_2_55';

-- Question ID: q_19_m_19_2_56
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'To achieve high availability and resilience against an Availability Zone (AZ) outage, the correct approach is to deploy Amazon EC2 instances across multiple Availability Zones within the same AWS Region and configure an Auto Scaling group (Option A). The Application Load Balancer will automatically distribute traffic to healthy instances in the available AZs, and the Auto Scaling group will ensure the desired capacity is maintained. Option B, deploying all instances in a single AZ, creates a single point of failure and would lead to downtime during an AZ outage. This relates to the anti-pattern [-003] Deploying all resources in a single AZ with the plan to move later. Option C, using Reserved Instances, is a cost optimization strategy and does not provide high availability against AZ failures. Option D, a warm standby in a different AWS Region, is a disaster recovery strategy for regional outages, not for ensuring continuous availability during an AZ outage within the primary region.'
WHERE id = 'q_19_m_19_2_56';

-- Question ID: q_19_m_19_2_57
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'To automatically detect and replace unhealthy instances, the Auto Scaling group should be configured with both an Amazon EC2 health check and an Application Load Balancer (ALB) health check (Option A). The EC2 health check monitors the instance status, while the ALB health check monitors the application''s responsiveness. If either health check fails, the Auto Scaling group will mark the instance as unhealthy and terminate it, then launch a new, healthy instance to replace it, ensuring self-healing. Option B, a custom script, is less robust and more complex than leveraging AWS''s built-in health checks. Option C, a CloudWatch alarm for CPU utilization, is for scaling based on performance metrics, not for detecting application unresponsiveness. Option D, manual termination, defeats the purpose of an automated self-healing architecture.'
WHERE id = 'q_19_m_19_2_57';

-- Question ID: q_19_m_19_1_56
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'To reduce unnecessary API calls and optimize costs when polling an Amazon SQS queue, the correct approach is to change the queue configuration to use long polling with a `WaitTimeSeconds` value greater than 0 (Option A). Long polling allows the SQS queue to wait for messages to become available before returning a response, significantly reducing the number of empty responses and associated API call costs. This directly addresses the anti-pattern [-001] Polling SQS with short polling causing empty responses and increased cost. Option B, increasing EC2 instances, would likely increase costs further due to more instances polling. Option C, migrating to Kinesis Data Streams, is a different service with different cost models and operational overhead, and not the most direct solution for SQS polling cost optimization. Option D, implementing a custom backoff, is a client-side solution that is more complex and less effective than simply enabling SQS long polling.'
WHERE id = 'q_19_m_19_1_56';

-- Question ID: q_19_m_19_1_57
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'For distributing UDP traffic, an Amazon Network Load Balancer (NLB) is the appropriate choice (Option A). NLB operates at the connection level (Layer 4) and supports TCP, UDP, and TLS protocols, making it ideal for real-time gaming applications that use UDP. Option B, an Application Load Balancer (ALB), only supports HTTP and HTTPS traffic and cannot handle UDP. This option represents the anti-pattern [-002] Using ALB for non-HTTP protocols like gaming or IoT. Option C, Amazon Route 53 weighted routing, distributes DNS queries, not direct network traffic, and doesn''t provide load balancing at the connection level. Option D, AWS Global Accelerator, improves global performance and routing but still requires a load balancer like NLB at the regional endpoint to distribute the actual UDP traffic to the instances.'
WHERE id = 'q_19_m_19_1_57';

-- Question ID: q_19_m_19_1_58
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'To decouple microservices and improve resilience, introducing an Amazon SQS queue (Option A) is the most effective solution. The ''Order Submission'' service can send messages to the SQS queue, and the ''Inventory Management'' and ''Payment Processing'' services can asynchronously consume these messages. This decouples the services, allowing them to operate independently and absorb failures without impacting the upstream service. This directly addresses the anti-pattern [-003] Tightly coupling microservices with synchronous REST calls. Option B, implementing a retry mechanism, only mitigates temporary failures and doesn''t fundamentally decouple the services or prevent cascading failures during sustained outages. Option C, deploying a dedicated EC2 proxy, adds a new point of failure and operational overhead. Option D, migrating to AWS Fargate, provides operational benefits for containers but doesn''t inherently solve synchronous coupling between services.'
WHERE id = 'q_19_m_19_1_58';

-- Question ID: q_19_m_19_1_59
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'To ensure user sessions are persistent and available across all instances in a dynamically scaling environment, storing session data in an external, shared session store like Amazon DynamoDB (Option A) is the most robust solution. This makes the EC2 instances stateless, allowing them to be replaced or scaled without losing user data. Option B, enabling sticky sessions on the Application Load Balancer, can help but is not a true solution for stateless applications. Sticky sessions rely on cookies and can still lead to session loss if the sticky instance becomes unhealthy or is terminated, and it can also hinder even load distribution. This option represents the anti-pattern [-004] Running stateful sessions on EC2 instances behind a load balancer without sticky sessions or external session store, where sticky sessions are a partial, less robust solution. Option C, using a fixed number of instances, prevents scaling and defeats the purpose of an Auto Scaling group. Option D, increasing instance size, is vertical scaling and does not solve the fundamental problem of stateful sessions across multiple instances.'
WHERE id = 'q_19_m_19_1_59';

-- Question ID: q_19_m_19_1_60
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'The most cost-effective, serverless, and operationally efficient solution for processing image files with variable workloads is to use Amazon S3 for storage, trigger an AWS Lambda function for processing, and store metadata in Amazon DynamoDB (Option A). Amazon S3 can directly trigger Lambda functions upon object creation, providing an event-driven architecture that scales automatically and only charges for compute time consumed. DynamoDB provides a scalable, serverless NoSQL database for metadata. Option B, EC2 instances with SQS, requires managing servers and an Auto Scaling group, increasing operational overhead. Option C, Amazon ECS with AWS Fargate, is a serverless container solution but might have higher operational overhead than pure Lambda for this specific event-driven task. Option D, Kinesis Data Streams with EC2 consumers, is designed for streaming data and would be overkill and more complex for individual image file processing.'
WHERE id = 'q_19_m_19_1_60';

-- Question ID: q_63_m_63_1_56
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B (Storage consumed and data transfer out) are the primary factors determining Amazon S3 costs. You pay for the amount of data stored and for data transferred out of S3 to the internet or other AWS Regions. Option A includes EC2 instances, which are not directly related to S3 pricing. Option C relates to AWS Lambda pricing. Option D relates to database and data analytics services, not S3.'
WHERE id = 'q_63_m_63_1_56';

-- Question ID: q_19_m_19_1_61
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Implementing Amazon ElastiCache for Redis (Option A) as a caching layer is the most effective way to reduce database load and significantly improve read latency for frequently accessed articles. ElastiCache provides sub-millisecond response times by storing data in-memory, offloading the majority of read requests from the database. Option B, migrating to Amazon Aurora with read replicas, improves database read scalability but still involves database access, which is slower than in-memory caching. Option C, upgrading the RDS instance, provides vertical scaling but has a performance ceiling and does not address the fundamental issue of high read load on the database as efficiently as a dedicated caching layer. Option D, Amazon CloudFront, is for caching static content at edge locations, which helps with overall page load times but does not directly cache dynamic article data from the database.'
WHERE id = 'q_19_m_19_1_61';

-- Question ID: q_19_m_19_1_62
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'To deploy containerized microservices with the LEAST operational overhead for managing underlying compute infrastructure, using Amazon ECS with AWS Fargate launch type (Option A) is the ideal solution. Fargate is a serverless compute engine for containers, eliminating the need to provision, manage, or scale EC2 instances. Developers only need to define their container images and resource requirements. Option B, manually deploying on EC2, involves significant operational overhead for server management. Option C, setting up an Amazon EKS cluster, while powerful, still requires managing the EKS worker nodes (even if using managed node groups, there''s more overhead than Fargate) and the Kubernetes control plane. Option D, using AWS Lambda to run container images, is a valid serverless option but is typically more suited for event-driven functions rather than long-running microservices, and might introduce different architectural constraints.'
WHERE id = 'q_19_m_19_1_62';

-- Question ID: q_19_m_19_1_64
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'A Network Load Balancer (NLB) (Option D) is designed for extreme performance and static IP addresses, making it ideal for handling high-throughput, low-latency UDP traffic. NLBs operate at the connection level (Layer 4) and are highly efficient for non-HTTP/HTTPS protocols. Option A (Amazon CloudFront) is a Content Delivery Network (CDN) for caching static content, not for real-time game traffic. Option B (Application Load Balancer) only supports HTTP/HTTPS trafficand is not suitable for UDP. Option C (Amazon API Gateway) is designed for RESTful APIs over HTTP/HTTPS and would introduce unnecessary overhead and latency for real-time UDP gaming traffic.'
WHERE id = 'q_19_m_19_1_64';

-- Question ID: q_19_m_19_1_65
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing Amazon ElastiCache for Redis (Option B) as a caching layer is the most effective way to reduce database load and improve read performance for frequently accessed data. ElastiCache provides sub-millisecond response times, allowing the application to retrieve cached product information without querying the database, especially during traffic spikes. Option A (Upgrading RDS instance) provides vertical scaling but has limits and does not address the fundamental issue of repeated queries hitting the database. Option C (Multi-AZ deployment) is for high availability and failover, not for read scaling, as the standby instance does not serve read traffic. Option D (Migrating to Amazon DynamoDB) would provide excellent read scalability but requires significant application re-architecture and data migration, which is not a minimal change.'
WHERE id = 'q_19_m_19_1_65';

-- Question ID: q_19_m_19_1_66
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Configuring Amazon SQS consumers to use long polling (Option A) by setting a `WaitTimeSeconds` value greater than zero is the correct solution. Long polling allows Amazon SQS to wait for messages to arrive before sending a response, significantly reducing the number of empty responses and associated costs. Option B (Increasing instance count) would exacerbate the problem by increasing the number of empty polls and costs. Option C (Cron job on a single instance) reduces scalability and introduces a single point of failure. Option D (Switching to Amazon Kinesis Data Streams) is a different service with a different pricing model and operational characteristics, not a direct solution for optimizing SQS polling efficiency.'
WHERE id = 'q_19_m_19_1_66';

-- Question ID: q_19_m_19_1_67
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Implementing an external session store using Amazon ElastiCache for Redis (Option C) is the most effective way to manage user sessions for a horizontally scalable, stateless microservices architecture. ElastiCache provides a fast, in-memory data store for session data, allowing any EC2 instance to retrieve session information, thus enabling true statelessness and resilience. Option A (Sticky sessions) can work but limits horizontal scaling and resilience, as it creates affinity to specific instances. Option B (Storing sessions in Amazon S3) would introduce high latency for session lookups, making it unsuitable for real-time user sessions. Option D (Shared Amazon EFS) is a file system, not optimized for high-performance session management, and can introduce latency and complexity for this use case.'
WHERE id = 'q_19_m_19_1_67';

-- Question ID: q_19_m_19_1_68
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Configuring an Amazon S3 event notification to publish messages to an Amazon SNS topic (Option A) is the most efficient and scalable way to distribute a single event to multiple independent subscribers (fanout pattern). Each downstream service can subscribe to the SNS topic, receiving the event without direct coupling. Option B (AWS Step Functions) is for orchestrating complex workflows with state management, which is overkill for simple event fanout. Option C (Directly invoking three Lambda functions) creates tight coupling between S3 and the Lambda functions, making it harder to add or remove subscribers without modifying the S3 configuration. Option D (Amazon EventBridge to SQS queues) is a valid pattern but SNS is simpler and more direct for fanout to multiple subscribers without needing separate SQS queues for each, reducing complexity.'
WHERE id = 'q_19_m_19_1_68';

-- Question ID: q_19_m_19_1_69
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Utilizing AWS Fargate with Amazon ECS (Option B) provides the least operational overhead for running containerized applications. Fargate is a serverless compute engine for containers, meaning you don''t need to provision, scale, or manage Amazon EC2 instances. You only pay for the compute resources consumed by your containers. Option A (EC2 instances with ECS) requires managing EC2 instances, including patching, scaling, and maintenance, increasing operational overhead. Option C (Amazon EKS cluster) also requires managing the Kubernetes control plane (though AWS manages it, you still manage nodes) or using Fargate for EKS, which is a specific configuration of Fargate. Option D (AWS Lambda with container images) is suitable for event-driven, short-duration functions, but batch processing jobs often have longer run times and different resource profiles that are better suited for Fargate.'
WHERE id = 'q_19_m_19_1_69';

-- Question ID: q_19_m_19_2_58
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Creating Amazon RDS read replicas (Option A) is the most cost-effective way to scale read operations horizontally. Read replicas allow you to offload read traffic from the primary database instance, improving performance during peak read loads. Option B (Multi-AZ deployment) is for high availability and disaster recovery; the standby instance does NOT serve read traffic, which is a common misconception. Option C (Upgrading instance type) provides vertical scaling but has a performance ceiling and is generally more expensive than read replicas for scaling reads. Option D (Amazon Aurora with Auto Scaling read replicas) is a highly scalable solution but typically involves higher costs and more significant migration effort than simply adding RDS read replicas for an existing RDS PostgreSQL database.'
WHERE id = 'q_19_m_19_2_58';

-- Question ID: q_19_m_19_2_59
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Deploying Amazon EC2 instances across multiple Availability Zones using an Auto Scaling group and configuring Amazon RDS for MySQL with Multi-AZ deployment (Option B) ensures high availability from day one. This architecture protects against failures within a single Availability Zone, as resources are distributed and can automatically failover. Option A (Deploying all resources in a single AZ) creates a single point of failure and is an anti-pattern, as retrofitting HA is complex. Option C (ALB in a single AZ) still leaves the entire deployment vulnerable to an AZ outage. Option D (Route 53 with simple routing to a single EC2 instance) provides no high availability or fault tolerance.'
WHERE id = 'q_19_m_19_2_59';

-- Question ID: q_19_m_19_2_60
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'A warm standby solution (Option D) best meets the RTO of 5 minutes and RPO of 1 minute while balancing cost. A warm standby keeps a scaled-down version of the application running in the secondary Region, allowing for quick scaling up and promotion of the Amazon RDS cross-Region read replica to primary, satisfying the RTO. Amazon S3 cross-Region replication ensures the RPO. Option A (Backup and restore) cannot meet the RTO/RPO requirements due to the time involved in restoring data and launching resources. Option B (Pilot light) typically has an RTO of 10+ minutes, which is too long for a 5-minute RTO. Option C (Multi-site active/active) is the most expensive and exceeds the required RTO/RPO, making it less cost-effective for these specific requirements.'
WHERE id = 'q_19_m_19_2_60';

-- Question ID: q_19_m_19_2_61
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Configuring health checks on both the Auto Scaling group and the Application Load Balancer (Option C) is essential for automatic detection and replacement of unhealthy instances. The ALB health checks determine if an instance can serve traffic, while Auto Scaling group health checks (EC2 or custom) determine if an instance is running and responsive, ensuring that unhealthy instances are terminated and new ones are launched automatically. Option A (Sticky sessions) is for session persistence, not health detection or self-healing. Option B (Manual termination based on CloudWatch) requires manual intervention and is not an automated self-healing mechanism. Option D (AWS Config rules with Lambda) can be used for compliance and remediation but is not the primary mechanism for automatic instance replacement within an Auto Scaling group.'
WHERE id = 'q_19_m_19_2_61';

-- Question ID: q_19_m_19_2_62
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Configuring Amazon RDS Multi-AZ deployment (Option A) is the correct approach for high availability with automatic failover. In a Multi-AZ deployment, Amazon RDS automatically provisions and maintains a synchronous standby replica in a different Availability Zone. In case of an outage, Amazon RDS automatically fails over to the standby replica, minimizing downtime and data loss. Option B (read replica) is for read scaling, not automatic failover for the primary instance, and the standby in a Multi-AZ deployment does not serve read traffic. Option C (backup and restore) has a much higher RTO and RPO than required for critical applications. Option D (single AZ deployment) introduces a single point of failure for the database, which directly contradicts the high availability requirement.'
WHERE id = 'q_19_m_19_2_62';

-- Question ID: q_19_m_19_2_63
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'To achieve automatic failover, Amazon Route 53 failover routing policy must be combined with Amazon Route 53 health checks (Option A). The health checks monitor the availability of the primary site''s endpoints. If the health checks fail, Route 53 automatically routes traffic to the secondary (failover) endpoint. Option B (simple routing with manual update) requires manual intervention, which fails the requirement for automatic failover. Option C (weighted routing with manual change) also requires manual intervention. Option D (latency-based routing) directs traffic based on latency, not endpoint health, and does not inherently provide failover capability if an endpoint becomes unhealthy.'
WHERE id = 'q_19_m_19_2_63';

-- Question ID: q_19_m_19_2_64
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Redesigning the architecture to deploy resources across multiple Availability Zones (Option D) is the most critical step for achieving high availability from day one. A single Availability Zone deployment is a single point of failure, meaning an outage in that AZ would bring down the entire application. Multi-AZ deployment ensures that if one AZ becomes unavailable, the application can continue to operate using resources in another AZ. Option A (CloudFront) improves performance and resilience for static content but does not address the core application or database availability. Option B (Auto Scaling) helps replace unhealthy instances within an AZ but cannot recover from an entire AZ outage. Option C (Route 53 health checks) are essential for detecting failures but do not, by themselves, provide the underlying multi-AZ infrastructure for recovery.'
WHERE id = 'q_19_m_19_2_64';

-- Question ID: q_19_m_19_2_65
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'A multi-site active/active architecture (Option C) is required to meet an RTO and RPO of near zero. With this strategy, the full application stack is deployed and actively serving traffic in both Regions. Amazon Route 53 with weighted routing and health checks can seamlessly direct users to the healthy Region, providing immediate failover and continuous operation. Amazon Aurora Global Database already provides near real-time replication for the data layer. Option A (pilot light) and Option B (warm standby) are designed for higher RTOs (minutes to hours) and RPOs, making them unsuitable for near-zero requirements. Option D (backup and restore) has the highest RTO and RPO and is entirely inadequate for mission-critical applications with near-zero requirements.'
WHERE id = 'q_19_m_19_2_65';

-- Question ID: q_19_m_19_2_66
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Amazon EC2 Auto Scaling with dynamic scaling policies (Option A) is the correct service to automatically adjust EC2 capacity based on demand and replace unhealthy instances. Auto Scaling groups ensure that a specified number of healthy instances are always running, scaling out during peak loads and scaling in during off-peak times, thus optimizing costs and maintaining performance. Option B (AWS CloudFormation) is for provisioning infrastructure, not for dynamic scaling or self-healing. Option C (Amazon CloudWatch) is used for monitoring and creating alarms, which can *trigger* Auto Scaling policies, but it doesn''t perform the scaling itself. Option D (AWS Systems Manager) provides operational insights and automation for managing EC2 instances but is not designed for automatic capacity scaling.'
WHERE id = 'q_19_m_19_2_66';

-- Question ID: q_19_m_19_1_70
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing Amazon ElastiCache for Redis (Option B) as a caching layer is the most effective solution for reducing database read load and improving responsiveness for frequently accessed data. ElastiCache provides sub-millisecond latency, allowing the application to retrieve cached data much faster than querying the database. This significantly offloads the Amazon RDS instance during traffic spikes. Option A (upgrading instance type) provides a vertical scaling improvement but has a performance ceiling and does not fundamentally change the read pattern. Option C (Multi-AZ deployment) is for high availability and automatic failover; the standby instance does not serve read traffic. Option D (read replicas) improves read capacity but still involves database queries, which are slower than in-memory caching and might not alleviate the load sufficiently for ''frequently accessed'' data.'
WHERE id = 'q_19_m_19_1_70';

-- Question ID: q_19_m_19_1_71
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'A Network Load Balancer (NLB) (Option C) is specifically designed for high-performance TCP/UDP traffic, making it the most appropriate choice for distributing game client connections using custom TCP protocols. NLB can handle millions of requests per second with ultra-low latency. Option A (Application Load Balancer) only supports HTTP/HTTPS traffic and is not suitable for custom TCP protocols. Option B (Amazon CloudFront) is a Content Delivery Network (CDN) primarily for caching web content and accelerating HTTP/HTTPS traffic, not for direct TCP load balancing. Option D (Amazon API Gateway) is for building, deploying, and managing RESTful APIs and WebSocket APIs, primarily for HTTP/HTTPS-based microservices, not raw TCP game server traffic.'
WHERE id = 'q_19_m_19_1_71';

-- Question ID: q_19_m_19_1_74
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Enabling long polling by setting the WaitTimeSeconds parameter (Option D) for the Amazon SQS queue is the correct solution. Long polling allows the SQS queue to wait for messages to arrive before sending a response, reducing the number of empty responses and the associated API call costs. This is a direct counter to the anti-pattern of short polling causing increased cost. Option A (increasing visibility timeout) prevents messages from being processed multiple times but does not reduce empty receives. Option B (configuring a DLQ) is for handling failed messages, not for optimizing polling efficiency. Option C (reducing maximum message size) affects message content, not polling behavior or cost efficiency.'
WHERE id = 'q_19_m_19_1_74';

-- Question ID: q_66_m_66_2_4
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Data masking and anonymization transform sensitive data into non-sensitive but realistic data, preserving privacy while allowing data utility for development and testing.'
WHERE id = 'q_66_m_66_2_4';

-- Question ID: q_19_m_19_1_75
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'Using Amazon API Gateway with AWS Lambda and Amazon DynamoDB (Option A) provides a fully serverless architecture with the least operational overhead. Amazon API Gateway handles API management, AWS Lambda executes the backend logic without server provisioning, and Amazon DynamoDB offers a fully managed NoSQL database. All these services scale automatically and operate on a pay-per-use model, aligning with the company''s goals. Option B (EC2, ALB, RDS) involves managing servers and databases, leading to higher operational overhead. Option C (AWS Fargate with Aurora) is also a managed container solution, but it still involves more configuration and management than a pure Lambda-based serverless approach, and Aurora is a relational database with more operational considerations than DynamoDB for simple API backends. Option D (AWS AppSync with OpenSearch) is a GraphQL solution, which might be an overkill for a simple RESTful API requirement, and OpenSearch is typically for search and analytics, not primary transactional data storage.'
WHERE id = 'q_19_m_19_1_75';

-- Question ID: q_19_m_19_1_76
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Implementing Amazon CloudFront as a Content Delivery Network (CDN) (Option B) is the most effective solution for improving global website performance and reducing load on the Amazon S3 origin. CloudFront caches static content at edge locations closer to users worldwide, significantly reducing latency and improving load times. It also offloads requests from the S3 bucket. Option A (ALB in front of S3) is not a standard or efficient way to serve static content from S3; S3 itself is an object storage service that can serve content directly. Option C (Route 53 latency-based routing) would direct users to the closest S3 bucket if content were replicated across regions, but it doesn''t cache content at edge locations or reduce origin load in the same way CloudFront does. Option D (migrating to EBS/EC2) would introduce significant operational overhead and cost for static content that S3 and CloudFront are designed to handle efficiently.'
WHERE id = 'q_19_m_19_1_76';

-- Question ID: q_19_m_19_2_67
-- Correct Answer: A
UPDATE public.question
SET
    explanation = 'An Application Load Balancer (ALB) with health checks, combined with an Amazon EC2 Auto Scaling group, provides a fully automated and resilient self-healing architecture. The ALB detects unhealthy instances via health checks and stops sending traffic to them, while the Auto Scaling group automatically terminates and replaces them, maintaining desired capacity. Option B uses Route 53 health checks, but these are primarily for DNS failover and do not automatically replace instances, requiring manual intervention. Option C uses CloudWatch alarms and Lambda, which is a custom solution with higher operational overhead and complexity compared to native Auto Scaling. Option D is a custom, self-managed solution that introduces a single point of failure (the dedicated EC2 instance) and significantly higher operational overhead.'
WHERE id = 'q_19_m_19_2_67';

-- Question ID: q_19_m_19_2_68
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'A pilot light strategy is the most cost-effective for an RTO of several hours and an RPO of up to one day. It involves maintaining core services (like RDS read replicas and S3 replication) in the DR Region, with compute resources (EC2 instances) pre-configured but stopped, only to be launched during a disaster. This minimizes ongoing costs. Option A (warm standby) is more expensive as it requires running scaled-down compute resources continuously. Option B (multi-site active/active) is the most expensive as it requires running a full, active stack in two regions. Option D (backup and restore) might not reliably meet an RTO of ''several hours'' for a full application stack, as restoration times can be unpredictable and manual effort is high.'
WHERE id = 'q_19_m_19_2_68';

-- Question ID: q_19_m_19_2_69
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Configuring Amazon RDS Multi-AZ deployment provides high availability with automatic failover to a standby instance in a different Availability Zone. Adding Amazon RDS read replicas is the correct approach to scale read performance by distributing read queries across multiple instances, offloading the primary. Option A (upgrading instance type) is a vertical scaling approach that has a performance ceiling and is generally less cost-effective than read replicas for read scaling. Option C (DynamoDB migration) is a significant re-architecture and not cost-effective for an existing relational database. Option D (Multi-AZ only) is incorrect because the Multi-AZ standby replica is for failover only and does not serve read traffic, which is a common misconception (anti-pattern:-001).'
WHERE id = 'q_19_m_19_2_69';

-- Question ID: q_19_m_19_2_70
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Deploying all resources in a single Availability Zone creates a single point of failure. If that AZ experiences an outage (e.g., power loss, network issues), the entire application becomes unavailable. Retrofitting high availability into an existing single-AZ architecture is significantly more complex, time-consuming, and risky than designing for multi-AZ from the outset (anti-pattern:-003). Option A (higher latency) is not the primary risk; latency depends more on user proximity to the Region. Option C (prevents Auto Scaling) is false; Auto Scaling can operate within a single AZ, though it doesn''t provide AZ-level resilience. Option D (more expensive) is generally false; a single AZ deployment is initially cheaper, but the cost of downtime and retrofitting can be much higher.'
WHERE id = 'q_19_m_19_2_70';

-- Question ID: q_19_m_19_2_71
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon Route 53 failover routing policies require associated Route 53 health checks to monitor the health of the primary endpoint. Without these health checks, Route 53 has no mechanism to detect that the primary Region is unhealthy and will not automatically trigger the failover to the secondary Region (anti-pattern:-004). Option A (Application Load Balancer) is important for distributing traffic within a Region and performing instance-level health checks, but Route 53 needs its own health checks for DNS-level failover. Option C (AWS Global Accelerator) can improve performance and routing but doesn''t replace the need for Route 53 health checks for failover. Option D (Amazon SQS queue) is for message decoupling, not for DNS failover.'
WHERE id = 'q_19_m_19_2_71';

-- Question ID: q_19_m_19_1_77
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon ECS with the AWS Fargate launch type is designed to minimize operational overhead by abstracting away the underlying infrastructure. With Fargate, you only need to define your container specifications, and AWS manages the EC2 instances, patching, scaling, and cluster networking. Option A (ECS with EC2 launch type) requires managing the EC2 instances. Option C (Amazon EKS) involves managing the Kubernetes control plane (unless using EKS Fargate, which is still more complex than ECS Fargate for simple container deployment) and worker nodes. Option D (manual deployment on EC2) has the highest operational overhead as it requires full manual management of all aspects of the container environment.'
WHERE id = 'q_19_m_19_1_77';

-- Question ID: q_19_m_19_1_78
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'An Amazon EC2 Auto Scaling group with dynamic scaling policies (e.g., target tracking for CPU utilization or ALB request count) behind an Application Load Balancer is the most cost-effective and responsive solution. It automatically adjusts compute capacity to match demand, scaling out during spikes and scaling in during low periods, optimizing costs. Option A (manual scaling) is labor-intensive and slow to react to sudden spikes. Option C (vertical scaling with larger instances) is not cost-effective for unpredictable spikes as you pay for unused capacity during low traffic. Option D (single AZ vertical scaling) introduces a single point of failure and does not provide horizontal scalability or resilience.'
WHERE id = 'q_19_m_19_1_78';

-- Question ID: q_19_m_19_1_79
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon API Gateway is specifically designed for creating, publishing, maintaining, monitoring, and securing REST, HTTP, and WebSocket APIs at any scale. It seamlessly integrates with AWS Lambda, provides built-in features like authentication, throttling, and API key management, and scales automatically without server management. Option A (ALB with EC2) introduces server management overhead and requires implementing API management features manually. Option C (direct Lambda invocation) bypasses API management features, posing security and scalability challenges for public-facing APIs. Option D (CloudFront) is a Content Delivery Network (CDN) primarily for caching and distribution, not for full API management and backend integration.'
WHERE id = 'q_19_m_19_1_79';

-- Question ID: q_64_m_64_3_7
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Foundation models have specific input formats, token limits, and prompt structures that raw data must adhere to for proper processing. Formatting inputs according to these requirements is crucial.'
WHERE id = 'q_64_m_64_3_7';

-- Question ID: q_19_m_19_1_80
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Configuring the Amazon SQS consumer application to use long polling by setting `WaitTimeSeconds` to a value greater than 0 is the correct solution. Long polling allows the `ReceiveMessage` API call to wait for messages to arrive in the queue, reducing the number of empty responses and thus decreasing API call costs and improving efficiency (anti-pattern:-001). Option A (increasing polling frequency) would exacerbate the problem by increasing empty responses and costs. Option C (decreasing `VisibilityTimeout`) affects how long a message is invisible after being read, not the efficiency of polling. Option D (migrating to SNS) is a different messaging pattern (pub/sub) and does not address the issue of inefficient polling for a queue-based consumer.'
WHERE id = 'q_19_m_19_1_80';

-- Question ID: q_63_m_63_1_57
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C (Number of requests and compute duration) are the primary factors for AWS Lambda pricing. You are charged based on the number of times your function is invoked (requests) and the duration (in milliseconds) it takes for your code to execute. Option A relates to Amazon EC2 pricing. Option B relates to storage services like Amazon S3. Option D is not a standard pricing model for Lambda.'
WHERE id = 'q_63_m_63_1_57';

-- Question ID: q_63_m_63_1_58
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B (Data transfer out) is a significant factor influencing Amazon EC2 costs. While inbound data transfer is generally free, data transferred out from an EC2 instance to the internet or other AWS Regions is charged. Options A and C are unrelated services. Option D is a separate account-level cost, not directly tied to a single EC2 instance''s operational cost.'
WHERE id = 'q_63_m_63_1_58';

-- Question ID: q_69_m_69_2_2
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'IaC enforces standardization and allows for automated comparison of actual state against desired state, identifying drift and ensuring consistent security policies.'
WHERE id = 'q_69_m_69_2_2';

-- Question ID: q_46_m_46_1_6
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Amazon S3 is ideal for data lakes due to its high durability, scalability, and cost-effectiveness for object storage, making it perfect for raw ML datasets.'
WHERE id = 'q_46_m_46_1_6';

-- Question ID: q_46_m_46_1_7
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon EFS provides a scalable, shared, POSIX-compliant file system, ideal for scenarios requiring shared access and low-latency file operations across multiple compute instances.'
WHERE id = 'q_46_m_46_1_7';

-- Question ID: q_64_m_64_3_8
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Lambda is ideal for serverless, event-driven data processing, allowing developers to easily integrate with other AWS AI services (like Bedrock or Comprehend) for text enhancement without managing underlying servers.'
WHERE id = 'q_64_m_64_3_8';

-- Question ID: q_64_m_64_6_5
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Chain-of-thought prompting encourages the model to generate a series of explicit intermediate reasoning steps before arriving at the final answer, which often leads to more accurate and logical outputs for complex tasks.'
WHERE id = 'q_64_m_64_6_5';

-- Question ID: q_63_m_63_1_59
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C (Reserved Instances) are ideal for applications with steady-state, predictable usage running 24/7 for a long duration, offering significant cost savings over a 1- or 3-year commitment. Option A (On-Demand Instances) is more expensive for continuous workloads. Option B (Spot Instances) are interruptible and not suitable for a continuously running web application. Option D (AWS Free Tier) is for experimentation and has limited usage, not for production workloads.'
WHERE id = 'q_63_m_63_1_59';

-- Question ID: q_64_m_64_6_6
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon Bedrock Guardrails allow developers to implement safety policies, deny specific topics, and filter undesirable content in FM interactions, ensuring responsible AI usage and adherence to content guidelines.'
WHERE id = 'q_64_m_64_6_6';

-- Question ID: q_64_m_64_6_7
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon Bedrock Prompt Management provides capabilities to store, version, test, and deploy prompts, streamlining prompt engineering workflows and enabling collaborative prompt development and governance.'
WHERE id = 'q_64_m_64_6_7';

-- Question ID: q_64_m_64_6_8
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Maintaining conversation state involves storing and recalling previous turns of a dialogue to provide coherent and contextually relevant responses throughout an interaction, making the conversation feel natural and continuous.'
WHERE id = 'q_64_m_64_6_8';

-- Question ID: q_64_m_64_2_5
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Dynamic model/provider switching allows applications to adapt and choose the optimal model or provider at runtime, enhancing resilience, cost-efficiency, and flexibility in GenAI deployments.'
WHERE id = 'q_64_m_64_2_5';

-- Question ID: q_64_m_64_2_6
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'LoRA (Low-Rank Adaptation) is a parameter-efficient fine-tuning method that significantly reduces the number of trainable parameters needed for adaptation, making customization more resource-efficient and faster for specific tasks.'
WHERE id = 'q_64_m_64_2_6';

-- Question ID: q_66_m_66_2_5
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Data retention policies define how long data should be stored and when it should be deleted, ensuring compliance with legal and regulatory requirements for sensitive AI data.'
WHERE id = 'q_66_m_66_2_5';

-- Question ID: q_64_m_64_2_7
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon SageMaker Model Registry provides comprehensive capabilities for cataloging, versioning, approving, and deploying models, fully supporting MLOps practices including automated deployment and rollback for FMs.'
WHERE id = 'q_64_m_64_2_7';

-- Question ID: q_63_m_63_1_60
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C (Spot Instances) are the most cost-effective choice for fault-tolerant, interruptible workloads like batch data processing, offering substantial discounts compared to On-Demand pricing. Option A (On-Demand Instances) would be more expensive. Option B (Reserved Instances) are for continuous, predictable workloads, not interruptible ones. Option D (Dedicated Hosts) are for specific licensing needs and are generally more expensive.'
WHERE id = 'q_63_m_63_1_60';

-- Question ID: q_63_m_63_1_61
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Option B (AWS Free Tier) allows new AWS customers to use certain services up to a specific limit for free, either for 12 months, as an always-free offer, or as short-term trials. This is ideal for experimentation and learning without significant cost. Option A (AWS Reserved Instances) and Option D (AWS Savings Plans) offer significant discounts for committing to a consistent usage over a 1- or 3-year term, which is not suitable for initial experimentation. Option C (AWS Spot Instances) offers deep discounts for fault-tolerant, interruptible workloads, but it''s not primarily designed for free exploration.'
WHERE id = 'q_63_m_63_1_61';

-- Question ID: q_64_m_64_2_8
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Implementing a multi-region, multi-provider strategy with failover mechanisms significantly enhances resilience by providing redundancy and mechanisms to switch models or providers in case of outages or performance issues.'
WHERE id = 'q_64_m_64_2_8';

-- Question ID: q_65_m_65_3_1
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS IAM (Identity and Access Management) is the service used to manage access to AWS resources, crucial for implementing least-privilege for GenAI components.'
WHERE id = 'q_65_m_65_3_1';

-- Question ID: q_65_m_65_3_2
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Amazon EventBridge provides a serverless event bus that makes it easier to connect applications together using data from your own applications, SaaS applications, and AWS services.'
WHERE id = 'q_65_m_65_3_2';

-- Question ID: q_65_m_65_3_3
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Compliant CI/CD pipelines for GenAI should include security scanning through static and dynamic analysis to identify vulnerabilities early and maintain security posture.'
WHERE id = 'q_65_m_65_3_3';

-- Question ID: q_8_m_8_1_71
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Option C (Governance) in Responsible AI refers to the framework of policies, procedures, and oversight mechanisms established to ensure that AI systems are developed and used ethically, legally, and responsibly. This includes defining roles, responsibilities, and accountability. Options A, B, and D are distinct dimensions of responsible AI.'
WHERE id = 'q_8_m_8_1_71';

-- Question ID: q_65_m_65_3_4
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'API Gateway acts as a fully managed service for creating, publishing, maintaining, monitoring, and securing APIs, making it ideal for GenAI service integration.'
WHERE id = 'q_65_m_65_3_4';

-- Question ID: q_65_m_65_1_1
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Memory is crucial for autonomous agents to retain and recall information from previous interactions, enabling persistent context and more coherent conversations.'
WHERE id = 'q_65_m_65_1_1';

-- Question ID: q_65_m_65_1_2
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Step Functions allows building resilient workflows for serverless applications, making it ideal for orchestrating multi-step agentic processes and secure tool execution.'
WHERE id = 'q_65_m_65_1_2';

-- Question ID: q_63_m_63_1_62
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Option D (Spot Instances) are the most cost-effective for fault-tolerant, flexible workloads like batch processing, offering up to a 90% discount compared to On-Demand prices. They can be interrupted by AWS with a two-minute notification. Option A (On-Demand Instances) are suitable for unpredictable workloads but are more expensive. Option B (Reserved Instances) are for steady-state, predictable workloads with a commitment. Option C (Dedicated Hosts) provide physical EC2 servers for license compliance and are generally the most expensive option.'
WHERE id = 'q_63_m_63_1_62';

-- Question ID: q_65_m_65_1_3
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Tool calling enables autonomous agents to invoke external functions, APIs, or databases to perform actions that extend their inherent knowledge and reasoning capabilities.'
WHERE id = 'q_65_m_65_1_3';

-- Question ID: q_65_m_65_1_4
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Human-in-the-loop mechanisms allow for human review and intervention in agentic workflows, especially for critical decisions or complex scenarios that require human judgment.'
WHERE id = 'q_65_m_65_1_4';

-- Question ID: q_14_m_14_1_2
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'SageMaker Feature Store is used to store, share, and manage curated features for machine learning models.'
WHERE id = 'q_14_m_14_1_2';

-- Question ID: q_65_m_65_5_1
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'AWS Amplify provides a complete framework for building and deploying full-stack web and mobile applications, including easy integration with AI/ML services.'
WHERE id = 'q_65_m_65_5_1';

-- Question ID: q_65_m_65_5_2
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'CloudWatch is used for collecting logs and metrics, while X-Ray provides end-to-end tracing, both essential for observing and analyzing prompt/response flows in GenAI applications.'
WHERE id = 'q_65_m_65_5_2';

-- Question ID: q_65_m_65_5_3
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Prompt Flows are specifically designed to help developers manage, test, and orchestrate complex prompt interactions with LLMs efficiently, improving prompt engineering workflows.'
WHERE id = 'q_65_m_65_5_3';

-- Question ID: q_65_m_65_5_4
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Webhook handlers are HTTP callbacks that allow applications to receive automated, real-time notifications or data from other services when specific events occur, enabling event-driven updates.'
WHERE id = 'q_65_m_65_5_4';

-- Question ID: q_67_m_67_2_8
-- Correct Answer: B
UPDATE public.question
SET
    explanation = 'Parallel processing allows multiple requests or parts of a request to be handled simultaneously, increasing throughput.'
WHERE id = 'q_67_m_67_2_8';

-- Question ID: q_65_m_65_4_1
-- Correct Answer: D
UPDATE public.question
SET
    explanation = 'Exponential backoff is a standard strategy to gracefully handle temporary errors by retrying failed requests with progressively longer waits, preventing overwhelming the service.'
WHERE id = 'q_65_m_65_4_1';

-- Question ID: q_67_m_67_2_9
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Response streaming allows users to see parts of the output as it''s generated, improving perceived latency.'
WHERE id = 'q_67_m_67_2_9';

-- Question ID: q_65_m_65_4_2
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Streaming API clients allow partial responses to be sent as they become available, improving user experience by reducing perceived latency for real-time, interactive generative tasks.'
WHERE id = 'q_65_m_65_4_2';

-- Question ID: q_68_m_68_1_8
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'A/B testing allows comparing different model versions in a live environment with real user traffic to assess performance and user preference.'
WHERE id = 'q_68_m_68_1_8';

-- Question ID: q_65_m_65_4_3
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'Intelligent model routing allows an application to dynamically select the most appropriate FM endpoint based on various criteria like latency, cost, or specific model capabilities.'
WHERE id = 'q_65_m_65_4_3';

-- Question ID: q_65_m_65_4_4
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'AWS X-Ray provides end-to-end tracing of requests as they travel through various services, essential for debugging, performance analysis, and optimizing FM API integrations.'
WHERE id = 'q_65_m_65_4_4';

-- Question ID: q_65_m_65_2_1
-- Correct Answer: C
UPDATE public.question
SET
    explanation = 'On-demand invocation is cost-effective for low-traffic or sporadic use cases as you only pay for actual inference time, without provisioning dedicated resources that might sit idle.'
WHERE id = 'q_65_m_65_2_1';

