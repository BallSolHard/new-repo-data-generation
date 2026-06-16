import type { ExamGuide } from '@/lib/types/exam-guide';

export const mlsC01: ExamGuide = {
  certificationCode: 'MLS-C01',
  certificationName: 'AWS Certified Machine Learning - Specialty (MLS-C01)',
  provider: 'aws',
  version: 'MLS-C01',
  effectiveDate: '2019-03-26',
  status: 'current',
  tier: 'specialty' as const,
  examFormat: {
    totalQuestions: 65,
    scoredQuestions: 50,
    unscoredQuestions: 15,
    duration: 180,
    passingScore: 750,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    // ─── Domain 1: Data Engineering (20%) ───
    {
      id: 'domain-1',
      name: 'Data Engineering',
      weightPercent: 20,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Create data repositories for machine learning',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'S3 data lake architecture for ML datasets with proper organization and partitioning' },
            { id: 'ks-1.1.2', text: 'SageMaker Feature Store for feature management and reuse across training and inference' },
            { id: 'ks-1.1.3', text: 'Storage selection for different ML data types: structured (RDS), semi-structured (DynamoDB), unstructured (S3)' },
            { id: 'ks-1.1.4', text: 'Data versioning and lineage tracking for reproducible ML experiments' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Recomputing features at inference time using separate code from training',
              whyWrong: 'Different feature computation logic between training and inference causes training-serving skew, where the model receives different feature distributions than it was trained on. SageMaker Feature Store provides a single source of truth for features.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Identify and implement a data ingestion solution',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'Batch data ingestion with AWS Glue, DMS, and S3' },
            { id: 'ks-1.2.2', text: 'Streaming data ingestion with Kinesis Data Streams and Kinesis Data Firehose' },
            { id: 'ks-1.2.3', text: 'Data format considerations: columnar (Parquet, ORC) vs. row-based (CSV, JSON)' },
            { id: 'ks-1.2.4', text: 'SageMaker input data channels and modes for training efficiency' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Not validating data schema and quality before training',
              whyWrong: 'Training on corrupted, schema-inconsistent, or stale data silently degrades model quality. Always validate schema, completeness, and distribution before feeding data to training jobs.',
            },
          ],
        },
        {
          id: 'task-1.3',
          text: 'Identify and implement a data transformation solution',
          knowledgeStatements: [
            { id: 'ks-1.3.1', text: 'AWS Glue for ETL transformations for ML data preparation at scale' },
            { id: 'ks-1.3.2', text: 'SageMaker Data Wrangler for visual data preparation and transformation' },
            { id: 'ks-1.3.3', text: 'SageMaker Processing Jobs for custom data preprocessing scripts' },
            { id: 'ks-1.3.4', text: 'Amazon EMR for large-scale distributed data transformation with Spark' },
            { id: 'ks-1.3.5', text: 'Feature engineering at scale: normalization, encoding, embeddings, text vectorization' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.3-001',
              misconception: 'Applying feature normalization statistics derived from the full dataset (including test set)',
              whyWrong: 'Including test set statistics in training transforms causes data leakage. Compute normalization parameters only from training data and apply them consistently to validation and test sets.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker Data Wrangler', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Feature Store', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Processing', category: 'Machine Learning' },
        { name: 'AWS Glue', category: 'Analytics' },
        { name: 'Amazon EMR', category: 'Analytics' },
        { name: 'Amazon Kinesis Data Streams', category: 'Analytics' },
        { name: 'Amazon Kinesis Data Firehose', category: 'Analytics' },
        { name: 'Amazon S3', category: 'Storage' },
        { name: 'Amazon Athena', category: 'Analytics' },
        { name: 'Amazon Redshift', category: 'Database' },
      ],
    },

    // ─── Domain 2: Exploratory Data Analysis (24%) ───
    {
      id: 'domain-2',
      name: 'Exploratory Data Analysis',
      weightPercent: 24,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Sanitize and prepare data for modeling',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'Handling missing values: imputation (mean, median, mode, KNN), deletion, indicator features' },
            { id: 'ks-2.1.2', text: 'Outlier detection and treatment: IQR, z-score, isolation forest' },
            { id: 'ks-2.1.3', text: 'Class imbalance handling: SMOTE, oversampling, undersampling, class weights, ensemble methods' },
            { id: 'ks-2.1.4', text: 'Data encoding: one-hot encoding, label encoding, ordinal encoding, target encoding' },
            { id: 'ks-2.1.5', text: 'Text preprocessing: tokenization, stemming, lemmatization, stop word removal, TF-IDF' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Using mean imputation for all missing values regardless of distribution',
              whyWrong: 'Mean imputation distorts the distribution and reduces variance. For skewed distributions, use median; for categorical values, use mode; for time-series, use forward/backward fill; consider model-based imputation for complex patterns.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Perform feature engineering',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'Feature selection: wrapper methods (RFE), filter methods (correlation, mutual information), embedded methods (Lasso)' },
            { id: 'ks-2.2.2', text: 'Dimensionality reduction: PCA, t-SNE, UMAP' },
            { id: 'ks-2.2.3', text: 'Feature interactions and polynomial features' },
            { id: 'ks-2.2.4', text: 'Time-series features: lag features, rolling statistics, seasonality decomposition' },
            { id: 'ks-2.2.5', text: 'Embedding representations for categorical and text features' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Using PCA for dimensionality reduction without considering feature interpretability requirements',
              whyWrong: 'PCA principal components are linear combinations of original features and are not interpretable. For compliance or explainability requirements, use feature selection methods that retain original features instead.',
            },
          ],
        },
        {
          id: 'task-2.3',
          text: 'Analyze and visualize data for machine learning',
          knowledgeStatements: [
            { id: 'ks-2.3.1', text: 'Distribution analysis: histograms, box plots, QQ plots' },
            { id: 'ks-2.3.2', text: 'Correlation analysis: Pearson, Spearman, heatmaps' },
            { id: 'ks-2.3.3', text: 'SageMaker Studio notebooks for EDA and visualization' },
            { id: 'ks-2.3.4', text: 'Amazon QuickSight for business-level data visualization' },
            { id: 'ks-2.3.5', text: 'SageMaker Clarify for pre-training bias analysis and feature importance' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.3-001',
              misconception: 'Skipping exploratory data analysis and jumping directly to model training',
              whyWrong: 'EDA reveals data quality issues, distribution characteristics, class imbalance, feature correlations, and suitable algorithms. Skipping EDA leads to poor model choices and unexpected training failures.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker Studio', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Clarify', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Data Wrangler', category: 'Machine Learning' },
        { name: 'Amazon QuickSight', category: 'Business Intelligence' },
        { name: 'Amazon Athena', category: 'Analytics' },
      ],
    },

    // ─── Domain 3: Modeling (36%) ───
    {
      id: 'domain-3',
      name: 'Modeling',
      weightPercent: 36,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Frame business problems as machine learning problems',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'Problem types: supervised (classification, regression), unsupervised (clustering, anomaly detection), reinforcement learning' },
            { id: 'ks-3.1.2', text: 'Algorithm selection based on data characteristics, problem type, interpretability, and scale' },
            { id: 'ks-3.1.3', text: 'Success criteria: business KPIs vs. ML metrics alignment' },
            { id: 'ks-3.1.4', text: 'Online vs. batch prediction requirements' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Optimizing ML metrics (e.g., AUC) without aligning them to business outcomes',
              whyWrong: 'A model with high AUC may still not deliver business value if it optimizes the wrong objective. Define the business metric (e.g., revenue impact, churn reduction) first, then select ML metrics that proxy for it.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Select the appropriate model(s) for an ML problem',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'SageMaker built-in algorithms: XGBoost, Linear Learner, k-NN, k-means, PCA, DeepAR, BlazingText, Object2Vec' },
            { id: 'ks-3.2.2', text: 'Deep learning frameworks: TensorFlow, PyTorch, MXNet in SageMaker' },
            { id: 'ks-3.2.3', text: 'Algorithm tradeoffs: training time, inference latency, interpretability, accuracy' },
            { id: 'ks-3.2.4', text: 'SageMaker Autopilot for automated algorithm selection and hyperparameter tuning' },
            { id: 'ks-3.2.5', text: 'Ensemble methods: bagging, boosting, stacking' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Defaulting to complex neural networks for tabular data problems',
              whyWrong: 'For tabular data, gradient boosting methods (XGBoost, LightGBM) consistently outperform deep learning with less data and tuning effort. Deep learning excels in unstructured data (images, text, audio). Match complexity to the data type.',
            },
          ],
        },
        {
          id: 'task-3.3',
          text: 'Train ML models',
          knowledgeStatements: [
            { id: 'ks-3.3.1', text: 'SageMaker Training Jobs: managed infrastructure, spot training, distributed training' },
            { id: 'ks-3.3.2', text: 'Hyperparameter optimization with SageMaker Automatic Model Tuning (Bayesian, random, grid search)' },
            { id: 'ks-3.3.3', text: 'Regularization techniques: L1/L2 penalty, dropout, early stopping, data augmentation' },
            { id: 'ks-3.3.4', text: 'Transfer learning for computer vision and NLP' },
            { id: 'ks-3.3.5', text: 'SageMaker Debugger for training anomaly detection (vanishing gradients, overfit tensors)' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.3-001',
              misconception: 'Running hyperparameter tuning with random search instead of Bayesian optimization',
              whyWrong: 'Random search treats hyperparameter trials independently, wasting budget on poor regions. Bayesian optimization uses prior trial results to focus on promising hyperparameter combinations, finding optima with fewer trials.',
            },
          ],
        },
        {
          id: 'task-3.4',
          text: 'Perform hyperparameter optimization',
          knowledgeStatements: [
            { id: 'ks-3.4.1', text: 'Hyperparameter types: model hyperparameters (architecture) vs. training hyperparameters (learning rate, batch size)' },
            { id: 'ks-3.4.2', text: 'SageMaker Automatic Model Tuning: objective metrics, parameter ranges, max jobs, parallelism' },
            { id: 'ks-3.4.3', text: 'Warm starting HPO jobs from previous runs' },
            { id: 'ks-3.4.4', text: 'Early stopping in HPO to terminate underperforming trials' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.4-001',
              misconception: 'Tuning hyperparameters without understanding which ones have the most impact',
              whyWrong: 'Not all hyperparameters affect model performance equally. Learning rate, batch size, and regularization strength typically have the highest impact. Focus HPO budget on high-impact hyperparameters identified through sensitivity analysis.',
            },
          ],
        },
        {
          id: 'task-3.5',
          text: 'Evaluate ML models',
          knowledgeStatements: [
            { id: 'ks-3.5.1', text: 'Metric selection by problem type: classification (AUC, F1, precision, recall), regression (RMSE, MAE, MAPE), ranking (NDCG)' },
            { id: 'ks-3.5.2', text: 'Cross-validation strategies for reliable evaluation' },
            { id: 'ks-3.5.3', text: 'Confusion matrix analysis and threshold selection' },
            { id: 'ks-3.5.4', text: 'SageMaker Clarify for post-training bias analysis and SHAP-based feature attribution' },
            { id: 'ks-3.5.5', text: 'A/B testing and shadow mode for online model evaluation' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.5-001',
              misconception: 'Using the same dataset for validation during training and for final model selection',
              whyWrong: 'Repeatedly using the same validation set during model selection causes the final selected model to overfit to that validation set. Hold out a final test set never seen during any phase of development for unbiased final evaluation.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker Training', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Automatic Model Tuning', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Autopilot', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Debugger', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Clarify', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Experiments', category: 'Machine Learning' },
        { name: 'Amazon SageMaker JumpStart', category: 'Machine Learning' },
        { name: 'AWS Trainium', category: 'Machine Learning' },
        { name: 'Amazon EC2 GPU instances', category: 'Compute' },
      ],
    },

    // ─── Domain 4: Machine Learning Implementation and Operations (20%) ───
    {
      id: 'domain-4',
      name: 'Machine Learning Implementation and Operations',
      weightPercent: 20,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Build ML solutions for performance, availability, scalability, resiliency, and fault tolerance',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'SageMaker endpoint auto-scaling and multi-model endpoints' },
            { id: 'ks-4.1.2', text: 'SageMaker Batch Transform for offline inference at scale' },
            { id: 'ks-4.1.3', text: 'SageMaker Async Inference for large payload and long-latency inference' },
            { id: 'ks-4.1.4', text: 'Model optimization: SageMaker Neo compilation, quantization, pruning' },
            { id: 'ks-4.1.5', text: 'AWS Inferentia for cost-efficient, high-throughput inference' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Deploying individual models on separate endpoints instead of multi-model endpoints for many similar models',
              whyWrong: 'Hosting hundreds of individual model endpoints is cost-prohibitive. SageMaker Multi-Model Endpoints host multiple models on shared compute, loading and unloading dynamically, reducing per-model inference cost significantly.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Recommend and implement the appropriate ML services and features for a given problem',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'AWS AI services for common ML use cases: Rekognition (vision), Comprehend (NLP), Polly (TTS), Transcribe (STT), Lex (chatbots), Kendra (enterprise search)' },
            { id: 'ks-4.2.2', text: 'When to use pre-built AI services vs. custom SageMaker models' },
            { id: 'ks-4.2.3', text: 'Amazon Personalize for real-time personalization and recommendations' },
            { id: 'ks-4.2.4', text: 'Amazon Forecast for time-series forecasting' },
            { id: 'ks-4.2.5', text: 'Amazon Fraud Detector for fraud detection use cases' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Building a custom NLP model when Amazon Comprehend satisfies the requirement',
              whyWrong: 'Custom model development requires data collection, training, evaluation, and deployment time. Amazon Comprehend provides entity extraction, sentiment analysis, and classification out-of-the-box, potentially eliminating months of custom ML work.',
            },
          ],
        },
        {
          id: 'task-4.3',
          text: 'Apply basic AWS security practices to machine learning solutions',
          knowledgeStatements: [
            { id: 'ks-4.3.1', text: 'SageMaker IAM execution roles and resource policies' },
            { id: 'ks-4.3.2', text: 'VPC isolation for training and inference workloads' },
            { id: 'ks-4.3.3', text: 'Encryption of training data, model artifacts, and inference I/O' },
            { id: 'ks-4.3.4', text: 'SageMaker Studio access controls and multi-user domain configuration' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.3-001',
              misconception: 'Granting SageMaker execution roles access to all S3 buckets',
              whyWrong: 'Broad S3 access from training jobs risks data exfiltration. Scope execution role permissions to only the specific S3 prefixes needed for training data and model artifacts, following least privilege.',
            },
          ],
        },
        {
          id: 'task-4.4',
          text: 'Deploy and operationalize machine learning solutions',
          knowledgeStatements: [
            { id: 'ks-4.4.1', text: 'SageMaker Pipelines for automated, reproducible ML workflows' },
            { id: 'ks-4.4.2', text: 'SageMaker Model Registry for model versioning and approval gates' },
            { id: 'ks-4.4.3', text: 'SageMaker Model Monitor for data drift, model quality, and bias drift detection' },
            { id: 'ks-4.4.4', text: 'CI/CD for ML: CodePipeline with SageMaker Pipelines integration' },
            { id: 'ks-4.4.5', text: 'A/B testing with SageMaker endpoint production variants' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.4-001',
              misconception: 'Not monitoring model quality after deployment, only monitoring infrastructure health',
              whyWrong: 'Models degrade as real-world data evolves (concept drift). Infrastructure metrics (CPU, latency) remain healthy even as prediction quality declines. SageMaker Model Monitor tracks model quality metrics and triggers retraining alerts.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker Inference', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Pipelines', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Model Registry', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Model Monitor', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Neo', category: 'Machine Learning' },
        { name: 'Amazon SageMaker Multi-Model Endpoints', category: 'Machine Learning' },
        { name: 'Amazon Rekognition', category: 'Machine Learning' },
        { name: 'Amazon Comprehend', category: 'Machine Learning' },
        { name: 'Amazon Personalize', category: 'Machine Learning' },
        { name: 'Amazon Forecast', category: 'Machine Learning' },
        { name: 'Amazon Lex', category: 'Machine Learning' },
        { name: 'Amazon Transcribe', category: 'Machine Learning' },
        { name: 'Amazon Polly', category: 'Machine Learning' },
        { name: 'Amazon Fraud Detector', category: 'Machine Learning' },
        { name: 'Amazon Kendra', category: 'Machine Learning' },
        { name: 'AWS Inferentia', category: 'Machine Learning' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Foundational cloud concepts (covered in CLF-C02)',
    'Advanced generative AI application building (see Generative AI specialty)',
    'Basic Python or ML library usage syntax',
    'Infrastructure design beyond ML-relevant services',
  ],
};
