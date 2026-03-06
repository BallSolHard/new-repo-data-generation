import type { ExamGuide } from '@/lib/types/exam-guide';

export const deaC01: ExamGuide = {
  certificationCode: 'DEA-C01',
  certificationName: 'AWS Certified Data Engineer - Associate',
  provider: 'aws',
  version: 'DEA-C01',
  effectiveDate: '2024-02-27',
  status: 'current',
  tier: 'associate' as const,
  examFormat: {
    totalQuestions: 85,
    scoredQuestions: 65,
    unscoredQuestions: 20,
    duration: 170,
    passingScore: 720,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    // ─── Domain 1: Data Ingestion and Transformation (34%) ───
    {
      id: 'domain-1',
      name: 'Data Ingestion and Transformation',
      weightPercent: 34,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Perform data ingestion',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'Batch ingestion patterns: AWS Glue, AWS DMS, AWS Snowball, S3 Transfer Acceleration' },
            { id: 'ks-1.1.2', text: 'Streaming ingestion: Amazon Kinesis Data Streams, Kinesis Data Firehose, Amazon MSK (Managed Streaming for Apache Kafka)' },
            { id: 'ks-1.1.3', text: 'Change data capture (CDC) with AWS DMS and Kinesis' },
            { id: 'ks-1.1.4', text: 'AWS DataSync for large-scale data migration from on-premises to AWS' },
            { id: 'ks-1.1.5', text: 'API-based ingestion patterns with API Gateway, Lambda, and Kinesis' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Using batch ingestion for real-time analytics requirements',
              whyWrong: 'Batch ingestion introduces latency proportional to batch size and frequency. For real-time dashboards or time-sensitive anomaly detection, use Kinesis Data Streams or MSK to achieve sub-second ingestion latency.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Ingesting data directly into Redshift from streaming sources without staging in S3',
              whyWrong: 'Direct streaming inserts into Redshift are inefficient and costly. Stage data in S3 via Kinesis Firehose and use COPY commands or automated Redshift Streaming Ingestion for efficient, bulk-optimized loading.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Transform and process data',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'AWS Glue: Glue ETL jobs (PySpark, Python Shell), Glue Studio, Glue DataBrew' },
            { id: 'ks-1.2.2', text: 'Glue Data Catalog: databases, tables, crawlers, schema discovery' },
            { id: 'ks-1.2.3', text: 'Amazon EMR for large-scale distributed data processing (Spark, Hive, Presto)' },
            { id: 'ks-1.2.4', text: 'Kinesis Data Analytics (Amazon Managed Service for Apache Flink) for streaming transforms' },
            { id: 'ks-1.2.5', text: 'AWS Lambda for lightweight serverless data transforms' },
            { id: 'ks-1.2.6', text: 'Data transformation patterns: aggregation, filtering, joining, deduplication, schema evolution' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Using AWS Lambda for heavy, long-running ETL transforms over large datasets',
              whyWrong: 'Lambda has a 15-minute timeout and limited memory. Distributed ETL frameworks like Glue (Spark) and EMR are designed for large-scale data processing with automatic partitioning and parallel execution.',
            },
            {
              id: 'ap-1.2-002',
              misconception: 'Not partitioning data in S3 after transformation',
              whyWrong: 'Unpartitioned data requires full table scans in Athena and Redshift Spectrum, inflating query costs. Partitioning by common filter columns (date, region, status) enables partition pruning and reduces query cost dramatically.',
            },
          ],
        },
        {
          id: 'task-1.3',
          text: 'Orchestrate data pipelines',
          knowledgeStatements: [
            { id: 'ks-1.3.1', text: 'Amazon MWAA (Managed Workflows for Apache Airflow) for complex pipeline orchestration' },
            { id: 'ks-1.3.2', text: 'AWS Step Functions for serverless workflow orchestration' },
            { id: 'ks-1.3.3', text: 'AWS Glue Workflows for ETL job dependency management' },
            { id: 'ks-1.3.4', text: 'Amazon EventBridge for schedule-based and event-driven pipeline triggers' },
            { id: 'ks-1.3.5', text: 'AWS Data Pipeline for legacy workloads (deprecated in favor of Glue/MWAA)' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.3-001',
              misconception: 'Building custom cron-based orchestration instead of using managed workflow services',
              whyWrong: 'Custom schedulers require infrastructure management, failure handling, retry logic, and monitoring. MWAA and Step Functions provide built-in retry policies, dependency management, monitoring, and visual workflow tracking.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Kinesis Data Streams', category: 'Analytics' },
        { name: 'Amazon Kinesis Data Firehose', category: 'Analytics' },
        { name: 'Amazon Managed Streaming for Apache Kafka (MSK)', category: 'Analytics' },
        { name: 'Amazon Managed Service for Apache Flink', category: 'Analytics' },
        { name: 'AWS Glue', category: 'Analytics' },
        { name: 'AWS Glue DataBrew', category: 'Analytics' },
        { name: 'AWS Glue Data Catalog', category: 'Analytics' },
        { name: 'Amazon EMR', category: 'Analytics' },
        { name: 'AWS DMS', category: 'Migration & Transfer' },
        { name: 'AWS DataSync', category: 'Migration & Transfer' },
        { name: 'AWS Step Functions', category: 'Application Integration' },
        { name: 'Amazon MWAA', category: 'Application Integration' },
        { name: 'Amazon EventBridge', category: 'Application Integration' },
        { name: 'Amazon S3', category: 'Storage' },
        { name: 'AWS Lambda', category: 'Compute' },
      ],
    },

    // ─── Domain 2: Data Store Management (26%) ───
    {
      id: 'domain-2',
      name: 'Data Store Management',
      weightPercent: 26,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Choose a data store',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'Data lake on S3 with AWS Lake Formation for governance' },
            { id: 'ks-2.1.2', text: 'Amazon Redshift for OLAP and large-scale analytical queries' },
            { id: 'ks-2.1.3', text: 'Amazon RDS and Aurora for transactional (OLTP) workloads' },
            { id: 'ks-2.1.4', text: 'Amazon DynamoDB for key-value and document workloads' },
            { id: 'ks-2.1.5', text: 'Amazon OpenSearch Service for full-text search and log analytics' },
            { id: 'ks-2.1.6', text: 'Apache Iceberg, Hudi, and Delta Lake for lakehouse architectures' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Using Amazon Redshift for transactional OLTP workloads',
              whyWrong: 'Redshift is a columnar OLAP warehouse optimized for analytical queries over large datasets. Frequent small transactions (INSERT/UPDATE/DELETE) create inefficiency. Use RDS or DynamoDB for transactional workloads.',
            },
            {
              id: 'ap-2.1-002',
              misconception: 'Storing all data in a single database without evaluating polyglot persistence',
              whyWrong: 'Different data characteristics require different storage engines. Relational data belongs in RDS, time-series in Timestream, search data in OpenSearch, key-value in DynamoDB. Polyglot persistence optimizes cost and performance.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Understand data cataloging systems',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'AWS Glue Data Catalog as a centralized metadata repository' },
            { id: 'ks-2.2.2', text: 'AWS Lake Formation for data lake governance, access control, and data sharing' },
            { id: 'ks-2.2.3', text: 'Amazon DataZone for data mesh and data portal use cases' },
            { id: 'ks-2.2.4', text: 'Schema registry with Amazon Glue Schema Registry for Kinesis and MSK' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Not maintaining a data catalog for a data lake, allowing a "data swamp"',
              whyWrong: 'Without a catalog (Glue Data Catalog, Lake Formation), data lakes become undiscoverable swamps where analysts cannot find or trust data. A catalog with schemas, lineage, and access controls is essential for usability.',
            },
          ],
        },
        {
          id: 'task-2.3',
          text: 'Manage the lifecycle of data',
          knowledgeStatements: [
            { id: 'ks-2.3.1', text: 'S3 lifecycle policies for transitioning between storage classes' },
            { id: 'ks-2.3.2', text: 'S3 storage classes: Standard, Intelligent-Tiering, Standard-IA, Glacier, Glacier Deep Archive' },
            { id: 'ks-2.3.3', text: 'Redshift VACUUM and ANALYZE for data maintenance' },
            { id: 'ks-2.3.4', text: 'Data retention policies and regulatory compliance requirements' },
            { id: 'ks-2.3.5', text: 'S3 Object Lock for WORM compliance' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.3-001',
              misconception: 'Storing all S3 objects in Standard storage class indefinitely',
              whyWrong: 'S3 Standard is the most expensive tier, appropriate for frequently accessed data. Infrequently accessed data should be tiered to Standard-IA, and archival data to Glacier/Deep Archive to reduce storage costs by up to 95%.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon S3', category: 'Storage' },
        { name: 'Amazon Redshift', category: 'Database' },
        { name: 'Amazon Redshift Spectrum', category: 'Database' },
        { name: 'Amazon RDS', category: 'Database' },
        { name: 'Amazon DynamoDB', category: 'Database' },
        { name: 'Amazon OpenSearch Service', category: 'Analytics' },
        { name: 'Amazon Timestream', category: 'Database' },
        { name: 'AWS Glue Data Catalog', category: 'Analytics' },
        { name: 'AWS Lake Formation', category: 'Analytics' },
        { name: 'Amazon DataZone', category: 'Analytics' },
        { name: 'Amazon Neptune', category: 'Database' },
        { name: 'Amazon MemoryDB', category: 'Database' },
      ],
    },

    // ─── Domain 3: Data Operations and Support (22%) ───
    {
      id: 'domain-3',
      name: 'Data Operations and Support',
      weightPercent: 22,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Automate data processing by using AWS services',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'S3 event notifications for triggering Lambda or SQS/SNS on data arrival' },
            { id: 'ks-3.1.2', text: 'Glue triggers for scheduled and on-demand ETL execution' },
            { id: 'ks-3.1.3', text: 'AWS Batch for large-scale batch compute workloads' },
            { id: 'ks-3.1.4', text: 'Event-driven data pipeline patterns' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Polling S3 for new files instead of using event-driven triggers',
              whyWrong: 'S3 polling requires running infrastructure and introduces latency. S3 event notifications trigger processing immediately when objects are created, providing lower latency with no polling infrastructure.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Analyze data by using AWS services',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'Amazon Athena for serverless SQL queries on S3 data' },
            { id: 'ks-3.2.2', text: 'Amazon QuickSight for BI visualization and dashboards' },
            { id: 'ks-3.2.3', text: 'Redshift query optimization: distribution keys, sort keys, WLM' },
            { id: 'ks-3.2.4', text: 'EMR Studio and notebooks for interactive data exploration' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Querying uncompressed, non-columnar S3 data with Athena',
              whyWrong: 'Athena charges per byte scanned. Uncompressed CSV data maximizes scan cost. Converting to compressed Parquet with appropriate partitioning can reduce Athena query costs by 85-97%.',
            },
          ],
        },
        {
          id: 'task-3.3',
          text: 'Maintain and monitor data pipelines',
          knowledgeStatements: [
            { id: 'ks-3.3.1', text: 'CloudWatch metrics and alarms for Glue, EMR, and Kinesis' },
            { id: 'ks-3.3.2', text: 'AWS Glue job bookmarks for incremental processing' },
            { id: 'ks-3.3.3', text: 'Data quality monitoring: AWS Glue Data Quality' },
            { id: 'ks-3.3.4', text: 'Pipeline alerting and on-call notification patterns' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.3-001',
              misconception: 'Not enabling Glue job bookmarks for incremental ETL processing',
              whyWrong: 'Without job bookmarks, Glue reprocesses the entire dataset on every run, wasting compute and time. Job bookmarks track previously processed files, enabling efficient incremental processing of only new data.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon Athena', category: 'Analytics' },
        { name: 'Amazon QuickSight', category: 'Business Intelligence' },
        { name: 'Amazon CloudWatch', category: 'Management & Governance' },
        { name: 'AWS Glue Data Quality', category: 'Analytics' },
        { name: 'AWS Batch', category: 'Compute' },
        { name: 'Amazon EMR Studio', category: 'Analytics' },
        { name: 'Amazon Redshift', category: 'Database' },
      ],
    },

    // ─── Domain 4: Data Security and Governance (18%) ───
    {
      id: 'domain-4',
      name: 'Data Security and Governance',
      weightPercent: 18,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Apply authentication mechanisms',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'IAM roles for data services (Glue execution roles, EMR instance profiles, Redshift IAM authentication)' },
            { id: 'ks-4.1.2', text: 'Lake Formation permissions model: table permissions, column-level security' },
            { id: 'ks-4.1.3', text: 'Resource-based policies for cross-account data access' },
            { id: 'ks-4.1.4', text: 'Redshift data sharing and AWS Data Exchange for secure data sharing' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Using S3 bucket policies alone for data lake access control',
              whyWrong: 'S3 bucket policies grant broad bucket-level access. Lake Formation provides table-level and column-level access control integrated with the Glue Data Catalog, enabling fine-grained data governance for Athena, Redshift Spectrum, and EMR.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Apply data encryption and masking',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'S3 server-side encryption (SSE-S3, SSE-KMS, SSE-C) and client-side encryption' },
            { id: 'ks-4.2.2', text: 'Redshift and RDS encryption at rest with KMS' },
            { id: 'ks-4.2.3', text: 'Dynamic data masking in Lake Formation and Redshift' },
            { id: 'ks-4.2.4', text: 'Tokenization and PII handling for compliant data pipelines' },
            { id: 'ks-4.2.5', text: 'Amazon Macie for PII discovery in S3 data lakes' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Storing PII or sensitive data unmasked in data warehouse tables accessible to all analysts',
              whyWrong: 'Broad access to PII violates data minimization principles and regulatory requirements. Use dynamic data masking in Redshift/Lake Formation to show masked values to unauthorized users while preserving data for authorized roles.',
            },
          ],
        },
        {
          id: 'task-4.3',
          text: 'Ensure data integrity and privacy',
          knowledgeStatements: [
            { id: 'ks-4.3.1', text: 'Data lineage tracking and audit logging for compliance' },
            { id: 'ks-4.3.2', text: 'GDPR right-to-erasure handling in data lakes (S3 Object Lock, Iceberg row deletes)' },
            { id: 'ks-4.3.3', text: 'AWS Audit Manager for compliance evidence collection' },
            { id: 'ks-4.3.4', text: 'CloudTrail data events for S3 and DynamoDB access auditing' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.3-001',
              misconception: 'Not designing data deletion workflows before ingesting customer PII',
              whyWrong: 'Regulations like GDPR mandate the ability to delete individual users\' data on request. Without deletion workflows, compliance requires expensive manual data scanning. Design for deletion at the data model and pipeline level from the start.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'AWS Lake Formation', category: 'Analytics' },
        { name: 'AWS IAM', category: 'Security, Identity, & Compliance' },
        { name: 'AWS KMS', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon Macie', category: 'Security, Identity, & Compliance' },
        { name: 'AWS CloudTrail', category: 'Management & Governance' },
        { name: 'AWS Audit Manager', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon S3', category: 'Storage' },
        { name: 'Amazon Redshift (data masking)', category: 'Database' },
        { name: 'Amazon DataZone', category: 'Analytics' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Application development beyond data pipeline code (covered in DVA-C02)',
    'ML model training and deployment (covered in MLA-C01)',
    'Infrastructure operations management (covered in SOA-C03)',
    'Advanced networking configuration',
    'Business intelligence report design',
  ],
};
