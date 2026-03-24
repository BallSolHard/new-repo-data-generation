import type { ExamGuide } from '@/lib/types/exam-guide';

export const mlaC01: ExamGuide = {
  certificationCode: 'MLA-C01',
  certificationName: 'AWS Certified Machine Learning Engineer - Associate (MLA-C01)',
  provider: 'aws',
  version: 'MLA-C01',
  effectiveDate: '2024-10-15',
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
    // ─── Domain 1: Data Preparation for Machine Learning (28%) ───
    {
      id: 'domain-1',
      name: 'Data Preparation for Machine Learning',
      weightPercent: 28,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Ingest and store data for ML',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'Data ingestion patterns: batch vs. streaming (Kinesis, Kafka, AWS Glue)' },
            { id: 'ks-1.1.2', text: 'Storage options for ML data: S3, Redshift, RDS, DynamoDB, EFS' },
            { id: 'ks-1.1.3', text: 'Data lake architecture with S3 and AWS Glue Data Catalog' },
            { id: 'ks-1.1.4', text: 'Data formats for ML: CSV, JSON, Parquet, ORC, TFRecord, RecordIO' },
            { id: 'ks-1.1.5', text: 'SageMaker data channels and input modes: File mode, Pipe mode, FastFile mode' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Using File mode for large-scale SageMaker training jobs',
              whyWrong: 'File mode downloads entire datasets from S3 before training begins, adding significant startup latency for large datasets. Use Pipe mode or FastFile mode to stream data directly during training.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Storing all ML data in row-based formats like CSV',
              whyWrong: 'Columnar formats (Parquet, ORC) provide compression and predicate pushdown, significantly reducing query costs in Athena and Redshift Spectrum. Use columnar formats for analytical ML workloads.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Transform data and perform feature engineering',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'Feature engineering techniques: normalization, standardization, encoding categorical variables, binning, log transforms' },
            { id: 'ks-1.2.2', text: 'Handling missing data: imputation strategies, dropping strategies' },
            { id: 'ks-1.2.3', text: 'Feature selection and dimensionality reduction: PCA, correlation analysis' },
            { id: 'ks-1.2.4', text: 'AWS Glue for ETL and SageMaker Data Wrangler for feature engineering' },
            { id: 'ks-1.2.5', text: 'SageMaker Feature Store for storing, sharing, and reusing ML features' },
            { id: 'ks-1.2.6', text: 'Handling class imbalance: SMOTE, oversampling, undersampling, class weights' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Applying normalization after the train-test split on the entire dataset',
              whyWrong: 'Fitting scalers on the full dataset (including test data) causes data leakage — test statistics influence the training transform. Always fit scalers only on training data, then transform test data using training statistics.',
            },
            {
              id: 'ap-1.2-002',
              misconception: 'Re-engineering features at inference time differently than during training',
              whyWrong: 'Training-serving skew occurs when feature transforms differ between training and production. Use SageMaker Feature Store or SageMaker Pipelines to ensure consistent feature computation across both.',
            },
          ],
        },
        {
          id: 'task-1.3',
          text: 'Ensure data integrity and prepare data for modeling',
          knowledgeStatements: [
            { id: 'ks-1.3.1', text: 'Data quality checks: completeness, consistency, accuracy, uniqueness' },
            { id: 'ks-1.3.2', text: 'Data splitting strategies: random split, stratified split, time-series split' },
            { id: 'ks-1.3.3', text: 'Data versioning and lineage with SageMaker ML Lineage Tracking' },
            { id: 'ks-1.3.4', text: 'SageMaker Clarify for detecting bias in training data' },
            { id: 'ks-1.3.5', text: 'Labeling data with Amazon SageMaker Ground Truth' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.3-001',
              misconception: 'Using random splits for time-series data',
              whyWrong: 'Random splits for time-series data cause future data to leak into training, making model evaluation unrealistically optimistic. Use time-based splits where training data precedes validation and test data chronologically.',
            },
            {
              id: 'ap-1.3-002',
              misconception: 'Not detecting and measuring bias in training datasets before model training',
              whyWrong: 'Biased training data produces biased models. SageMaker Clarify should be used pre-training to measure class imbalance and feature correlation with sensitive attributes before investing in model training.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker Data Wrangler', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Feature Store', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Ground Truth', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Clarify', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Processing', category: 'Machine Learning' },
        { name: 'AWS Glue', category: 'Analytics' },
        { name: 'AWS Glue DataBrew', category: 'Analytics' },
        { name: 'Amazon Kinesis Data Streams', category: 'Analytics' },
        { name: 'Amazon Kinesis Data Firehose', category: 'Analytics' },
        { name: 'Amazon S3', category: 'Storage' },
        { name: 'AWS Lake Formation', category: 'Analytics' },
        { name: 'Amazon Athena', category: 'Analytics' },
        { name: 'Amazon Redshift', category: 'Database' },
      ],
    },

    // ─── Domain 2: ML Model Development (26%) ───
    {
      id: 'domain-2',
      name: 'ML Model Development',
      weightPercent: 26,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Choose the appropriate model for a given ML problem',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'Built-in SageMaker algorithms: XGBoost, Linear Learner, BlazingText, DeepAR, k-NN, k-means, PCA, Object Detection, Image Classification' },
            { id: 'ks-2.1.2', text: 'Framework selection: TensorFlow, PyTorch, scikit-learn, Hugging Face' },
            { id: 'ks-2.1.3', text: 'Algorithm selection based on problem type and data characteristics' },
            { id: 'ks-2.1.4', text: 'Transfer learning and pre-trained model reuse' },
            { id: 'ks-2.1.5', text: 'SageMaker JumpStart for pre-built solutions and models' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Building custom algorithms when SageMaker built-in algorithms satisfy requirements',
              whyWrong: 'SageMaker built-in algorithms are optimized for distributed training and scale on AWS infrastructure. Custom implementations require additional development, testing, and maintenance without necessarily improving performance.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Train and refine ML models',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'SageMaker Training Jobs: instance selection, spot training, distributed training' },
            { id: 'ks-2.2.2', text: 'Hyperparameter tuning with SageMaker Automatic Model Tuning (HPO)' },
            { id: 'ks-2.2.3', text: 'Distributed training strategies: data parallelism, model parallelism' },
            { id: 'ks-2.2.4', text: 'Experiment tracking with SageMaker Experiments' },
            { id: 'ks-2.2.5', text: 'Regularization techniques: L1, L2, dropout, early stopping' },
            { id: 'ks-2.2.6', text: 'Cross-validation strategies for model evaluation' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Running HPO with too wide a search space and few trials',
              whyWrong: 'Broad hyperparameter ranges with insufficient trials produce sparse coverage and miss optimal configurations. Use Bayesian optimization in SageMaker HPO and narrow ranges based on domain knowledge to converge faster.',
            },
            {
              id: 'ap-2.2-002',
              misconception: 'Not using Spot Instances for long-running training jobs',
              whyWrong: 'SageMaker Managed Spot Training uses EC2 Spot Instances and can reduce training costs by up to 90%. With checkpointing enabled, interrupted jobs resume from the last checkpoint, minimizing lost work.',
            },
          ],
        },
        {
          id: 'task-2.3',
          text: 'Analyze model performance and address issues',
          knowledgeStatements: [
            { id: 'ks-2.3.1', text: 'Model evaluation metrics by problem type: accuracy, AUC-ROC, precision/recall, RMSE, MAE, MAPE' },
            { id: 'ks-2.3.2', text: 'Bias-variance tradeoff: diagnosing overfitting and underfitting' },
            { id: 'ks-2.3.3', text: 'Confusion matrix interpretation and threshold tuning' },
            { id: 'ks-2.3.4', text: 'SageMaker Debugger for training job analysis and anomaly detection' },
            { id: 'ks-2.3.5', text: 'SageMaker Clarify for post-training bias analysis and feature attribution' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.3-001',
              misconception: 'Responding to overfitting only by collecting more data without trying regularization',
              whyWrong: 'While more data helps, regularization (L1/L2, dropout), early stopping, and cross-validation are faster and cheaper first responses to overfitting. Collect more data if regularization techniques are insufficient.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker Training', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Automatic Model Tuning', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Experiments', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Debugger', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Clarify', category: 'Machine Learning' },
        { name: 'Amazon SageMaker JumpStart', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Managed Spot Training', category: 'Machine Learning' },
        { name: 'AWS Trainium', category: 'Machine Learning' },
        { name: 'Amazon EC2 GPU instances (p3, p4, g5)', category: 'Compute' },
      ],
    },

    // ─── Domain 3: Deployment and Orchestration of ML Workflows (22%) ───
    {
      id: 'domain-3',
      name: 'Deployment and Orchestration of ML Workflows',
      weightPercent: 22,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Select deployment infrastructure based on existing architecture and requirements',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'SageMaker real-time inference, serverless inference, asynchronous inference, batch transform' },
            { id: 'ks-3.1.2', text: 'Endpoint instance types and auto-scaling for inference' },
            { id: 'ks-3.1.3', text: 'Model optimization: quantization, pruning, SageMaker Neo compilation' },
            { id: 'ks-3.1.4', text: 'Multi-model endpoints and inference pipelines' },
            { id: 'ks-3.1.5', text: 'AWS Inferentia for cost-optimized inference' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Using real-time inference for large batch scoring jobs',
              whyWrong: 'Real-time inference endpoints require persistent instances and are costly for non-interactive batch workloads. SageMaker Batch Transform spins up ephemeral compute, processes data, and terminates — significantly cheaper.',
            },
            {
              id: 'ap-3.1-002',
              misconception: 'Not configuring endpoint auto-scaling for variable inference traffic',
              whyWrong: 'Fixed-capacity endpoints over-provision during low traffic and under-provision during spikes. Application Auto Scaling for SageMaker endpoints ensures cost-efficiency and availability across traffic patterns.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Create and script infrastructure based on existing architecture',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'SageMaker Pipelines for ML workflow orchestration' },
            { id: 'ks-3.2.2', text: 'Infrastructure as code for ML: CloudFormation, CDK for SageMaker resources' },
            { id: 'ks-3.2.3', text: 'Model registry with SageMaker Model Registry for versioning and governance' },
            { id: 'ks-3.2.4', text: 'CI/CD for ML (MLOps): CodePipeline, CodeBuild integration with SageMaker' },
            { id: 'ks-3.2.5', text: 'Containerizing ML models with Docker and Amazon ECR' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Manually deploying models without a model registry or approval workflow',
              whyWrong: 'Without a model registry, there is no versioning, lineage, or governance. Manual deployments skip quality gates and make rollback difficult. SageMaker Model Registry provides approval workflows and version control.',
            },
          ],
        },
        {
          id: 'task-3.3',
          text: 'Use automated orchestration tools to set up continuous training and deployment pipelines',
          knowledgeStatements: [
            { id: 'ks-3.3.1', text: 'SageMaker Pipelines: steps, conditions, parameters, and execution' },
            { id: 'ks-3.3.2', text: 'Trigger strategies for automated retraining: schedule, data drift, performance degradation' },
            { id: 'ks-3.3.3', text: 'Blue/green deployments and canary releases for ML endpoints' },
            { id: 'ks-3.3.4', text: 'Amazon EventBridge for event-driven ML pipeline triggers' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.3-001',
              misconception: 'Deploying a new model version directly to 100% traffic without canary testing',
              whyWrong: 'Sudden full rollouts risk production outages if the new model regresses. Use canary deployments (e.g., 5-10% traffic to new model) to validate performance before promoting to full production.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker Inference', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Batch Transform', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Serverless Inference', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Async Inference', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Pipelines', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Model Registry', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Neo', category: 'Machine Learning' },
        { name: 'Amazon ECR', category: 'Containers' },
        { name: 'AWS CodePipeline', category: 'Developer Tools' },
        { name: 'AWS CodeBuild', category: 'Developer Tools' },
        { name: 'Amazon EventBridge', category: 'Application Integration' },
        { name: 'AWS Inferentia', category: 'Machine Learning' },
      ],
    },

    // ─── Domain 4: ML Solution Monitoring, Maintenance, and Security (24%) ───
    {
      id: 'domain-4',
      name: 'ML Solution Monitoring, Maintenance, and Security',
      weightPercent: 24,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Monitor ML solutions',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'SageMaker Model Monitor: data quality, model quality, bias drift, feature attribution drift monitors' },
            { id: 'ks-4.1.2', text: 'Amazon CloudWatch metrics for SageMaker endpoints: latency, throughput, errors' },
            { id: 'ks-4.1.3', text: 'Detecting and responding to model drift (concept drift, data drift)' },
            { id: 'ks-4.1.4', text: 'SageMaker Model Monitor integration with CloudWatch alarms for automated alerts' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Only monitoring infrastructure metrics (CPU, memory) and not ML-specific metrics',
              whyWrong: 'An endpoint can be healthy infrastructure-wise while model accuracy degrades due to data drift. ML-specific monitoring (SageMaker Model Monitor) is required to catch model quality degradation.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Maintain ML solutions',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'Retraining strategies: scheduled retraining, triggered retraining on drift detection' },
            { id: 'ks-4.2.2', text: 'Model rollback and version management' },
            { id: 'ks-4.2.3', text: 'Data and model lineage tracking with SageMaker ML Lineage Tracking' },
            { id: 'ks-4.2.4', text: 'Cost optimization for ML in production: right-sizing, spot instances, auto-scaling' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Only retraining models on a fixed schedule without monitoring for drift triggers',
              whyWrong: 'Data distributions can shift unpredictably. Scheduled-only retraining may miss rapid drift. Combine scheduled retraining with drift-triggered retraining using SageMaker Model Monitor alarms for responsive maintenance.',
            },
          ],
        },
        {
          id: 'task-4.3',
          text: 'Secure ML solutions',
          knowledgeStatements: [
            { id: 'ks-4.3.1', text: 'IAM roles and policies for SageMaker: execution roles, resource-based policies' },
            { id: 'ks-4.3.2', text: 'Network isolation for training and inference: VPC configurations, no public internet' },
            { id: 'ks-4.3.3', text: 'Encryption of data at rest and in transit for ML workloads' },
            { id: 'ks-4.3.4', text: 'SageMaker Studio access controls and multi-user isolation' },
            { id: 'ks-4.3.5', text: 'Secrets management for ML credentials using Secrets Manager' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.3-001',
              misconception: 'Running SageMaker training jobs with direct internet access in regulated environments',
              whyWrong: 'Training jobs with unrestricted internet access can exfiltrate data or download malicious packages. Configure training jobs to run in a VPC with no direct internet access and use VPC endpoints for AWS service access.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker Model Monitor', category: 'Machine Learning' },
        { name: 'Amazon SageMaker ML Lineage Tracking', category: 'Machine Learning' },
        { name: 'Amazon CloudWatch', category: 'Management & Governance' },
        { name: 'Amazon CloudWatch Alarms', category: 'Management & Governance' },
        { name: 'AWS CloudTrail', category: 'Management & Governance' },
        { name: 'AWS IAM', category: 'Security, Identity, & Compliance' },
        { name: 'AWS KMS', category: 'Security, Identity, & Compliance' },
        { name: 'AWS Secrets Manager', category: 'Security, Identity, & Compliance' },
        { name: 'Amazon VPC', category: 'Networking & Content Delivery' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Foundational AI/ML theory (covered in AIF-C01)',
    'Advanced research-level ML architectures',
    'Detailed generative AI application building (covered in Generative AI specialty)',
    'Data warehouse administration',
    'Networking beyond VPC configurations for SageMaker',
  ],
};
