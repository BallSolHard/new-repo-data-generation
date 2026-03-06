import type { ExamGuide } from '@/lib/types/exam-guide';

export const terraformProfessional: ExamGuide = {
  certificationCode: 'TAOP-003',
  certificationName: 'HashiCorp Certified: Terraform Authoring and Operations Professional',
  provider: 'hashicorp',
  version: 'TAOP-003',
  effectiveDate: '2024-01-30',
  status: 'current',
  tier: 'professional' as const,
  examFormat: {
    totalQuestions: 60,
    scoredQuestions: 60,
    unscoredQuestions: 0,
    duration: 90,
    passingScore: 750,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    // ─── Domain 1: Advanced Configuration Authoring (27%) ───
    {
      id: 'domain-1',
      name: 'Advanced Configuration Authoring',
      weightPercent: 27,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Author complex Terraform configurations using advanced HCL features',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'Dynamic blocks for repeatable nested configurations (security_group rules, S3 lifecycle)' },
            { id: 'ks-1.1.2', text: 'Meta-arguments: count, for_each, depends_on, lifecycle (create_before_destroy, prevent_destroy, ignore_changes)' },
            { id: 'ks-1.1.3', text: 'Complex expressions: for expressions, conditional expressions, splat operator' },
            { id: 'ks-1.1.4', text: 'Local values (locals): complex computed values and code DRY principles' },
            { id: 'ks-1.1.5', text: 'Type system: primitive types, complex types (list, map, set, object, tuple), any' },
            { id: 'ks-1.1.6', text: 'Built-in functions: string, numeric, collection, encoding, filesystem, date/time functions' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Using count instead of for_each for resource creation from a map or set',
              whyWrong: 'count assigns integer indices (resource.aws_instance[0]) which shift when items are added or removed from the middle, causing unintended resource replacements. for_each uses stable string keys so resources are only created/destroyed when their specific key is added/removed.',
            },
            {
              id: 'ap-1.1-002',
              misconception: 'Overusing dynamic blocks for simple repeated blocks',
              whyWrong: 'Dynamic blocks reduce readability when used for simple or small-count nested blocks. Static blocks are clearer and easier to review. Reserve dynamic blocks for cases where the number of nested blocks is truly data-driven and variable.',
            },
          ],
        },
        {
          id: 'task-1.2',
          text: 'Write and use complex variable types and output values',
          knowledgeStatements: [
            { id: 'ks-1.2.1', text: 'Complex variable validation: custom condition blocks with error messages' },
            { id: 'ks-1.2.2', text: 'Object and tuple type constraints for structured variable inputs' },
            { id: 'ks-1.2.3', text: 'Sensitive outputs and the sensitive function for secret propagation' },
            { id: 'ks-1.2.4', text: 'Output value dependencies and use in parent module compositions' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.2-001',
              misconception: 'Using type = any for all input variables to avoid type constraint complexity',
              whyWrong: 'type = any defers type validation to runtime and produces cryptic error messages. Explicit type constraints provide early validation, better IDE support, and clear documentation of expected input shape for module consumers.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Terraform HCL (Advanced Expressions)', category: 'Configuration Language' },
        { name: 'Terraform Built-in Functions', category: 'Configuration Language' },
        { name: 'Terraform Meta-Arguments', category: 'Configuration Language' },
      ],
    },

    // ─── Domain 2: Advanced Module Development (22%) ───
    {
      id: 'domain-2',
      name: 'Advanced Module Development',
      weightPercent: 22,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Design and build reusable, composable Terraform modules',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'Module structure best practices: main.tf, variables.tf, outputs.tf, versions.tf, README.md' },
            { id: 'ks-2.1.2', text: 'Module composition: nested modules, passing outputs as inputs across modules' },
            { id: 'ks-2.1.3', text: 'Module abstraction: hiding provider-specific details, exposing only necessary variables' },
            { id: 'ks-2.1.4', text: 'Terraform Registry module publishing: semantic versioning, README, input/output documentation' },
            { id: 'ks-2.1.5', text: 'Module testing: terraform test command, tftest.hcl files, mocking providers' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Creating overly broad modules that provision many unrelated resource types',
              whyWrong: 'Monolithic modules are harder to test, version, and reuse. A module should have a single, well-defined purpose (e.g., a VPC module, an ECS cluster module). Compose workload architectures from multiple focused modules rather than one large module.',
            },
          ],
        },
        {
          id: 'task-2.2',
          text: 'Test Terraform modules using the terraform test framework',
          knowledgeStatements: [
            { id: 'ks-2.2.1', text: 'terraform test command: test files, run blocks, assertions, mock providers' },
            { id: 'ks-2.2.2', text: 'Unit testing with mocked providers (no real infrastructure)' },
            { id: 'ks-2.2.3', text: 'Integration testing with real providers: apply-and-assert patterns' },
            { id: 'ks-2.2.4', text: 'Test cleanup: destroy strategy and module isolation in tests' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.2-001',
              misconception: 'Only performing integration tests that provision real infrastructure for all test cases',
              whyWrong: 'Integration tests that provision real infrastructure are slow and costly. Use unit tests with mock providers for logic validation (variable validation, output expressions) and reserve integration tests for verifying resource creation and critical behavior.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Terraform Module Registry', category: 'Registry' },
        { name: 'Terraform Test Framework', category: 'Testing' },
        { name: 'Terraform Mock Providers', category: 'Testing' },
      ],
    },

    // ─── Domain 3: State Management (21%) ───
    {
      id: 'domain-3',
      name: 'Operations: Maintain and Troubleshoot Terraform State',
      weightPercent: 21,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Design a state management strategy for large-scale infrastructure',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'State splitting: breaking large configurations into smaller workspaces with remote state data sources' },
            { id: 'ks-3.1.2', text: 'terraform_remote_state data source for cross-workspace output sharing' },
            { id: 'ks-3.1.3', text: 'State backend options: S3 + DynamoDB, GCS, Azure Blob, Terraform Cloud, Consul' },
            { id: 'ks-3.1.4', text: 'State locking and the importance of atomic apply operations' },
            { id: 'ks-3.1.5', text: 'Partial backend configuration for environment promotion' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Maintaining a single state file for an entire organization\'s infrastructure',
              whyWrong: 'A single large state file causes slow plan/apply times, increased blast radius for mistakes, and prevents parallel team work. Split state by team, application, environment, and layer (networking, compute, data) for scalability and isolation.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Perform safe state manipulation and recovery',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'terraform state mv for resource renaming and module refactoring without destroy/recreate' },
            { id: 'ks-3.2.2', text: 'terraform state rm to remove resources from state without destroying them' },
            { id: 'ks-3.2.3', text: 'Importing existing resources and reconciling with written configuration' },
            { id: 'ks-3.2.4', text: 'Recovering from failed applies: partial state, remediation steps' },
            { id: 'ks-3.2.5', text: 'State backup and the role of .terraform/terraform.tfstate.backup' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.2-001',
              misconception: 'Running terraform state commands without first taking a manual state backup',
              whyWrong: 'State commands modify state directly and mistakes (removing the wrong resource) can cause data loss or unintended infrastructure drift. Always run terraform state pull > backup.tfstate before any state manipulation, especially in production.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Terraform Remote Backends', category: 'State Management' },
        { name: 'Terraform State Commands', category: 'IaC Tool' },
        { name: 'terraform_remote_state Data Source', category: 'HCL Construct' },
        { name: 'Terraform Cloud Workspaces', category: 'Managed Service' },
      ],
    },

    // ─── Domain 4: Terraform Workflows in Team Environments (17%) ───
    {
      id: 'domain-4',
      name: 'Implement Terraform in Team and CI/CD Environments',
      weightPercent: 17,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Implement Terraform collaboration patterns using Terraform Cloud or CI/CD',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'Terraform Cloud: remote runs, VCS-driven workflows, plan-before-apply gates' },
            { id: 'ks-4.1.2', text: 'CI/CD pipeline patterns: speculative plans on PRs, apply on merge-to-main' },
            { id: 'ks-4.1.3', text: 'OIDC-based dynamic credentials: AWS, Azure, GCP provider short-lived token auth' },
            { id: 'ks-4.1.4', text: 'Terraform Cloud variable sets for managing credentials and shared configuration' },
            { id: 'ks-4.1.5', text: 'Run triggers and workspace dependencies in Terraform Cloud' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Storing long-lived cloud credentials as CI/CD environment variables for Terraform',
              whyWrong: 'Long-lived credentials are a security risk and require manual rotation. Use OIDC (Workload Identity Federation) to allow Terraform in CI/CD to assume short-lived cloud roles dynamically, eliminating static credentials entirely.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Apply policy as code with Sentinel or OPA for governance',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'Sentinel policy framework (Terraform Cloud/Enterprise): policy sets, enforcement levels (advisory, soft-mandatory, hard-mandatory)' },
            { id: 'ks-4.2.2', text: 'Open Policy Agent (OPA) with conftest for pre-plan policy evaluation' },
            { id: 'ks-4.2.3', text: 'Common policy examples: requiring tags, restricting instance types, enforcing encryption' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Setting all Sentinel policies to hard-mandatory without team approval workflows',
              whyWrong: 'Hard-mandatory policies block applies entirely without override capability. For governance policies that may have legitimate exceptions, use soft-mandatory (allows override with approval) to balance compliance with operational flexibility.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Terraform Cloud / HCP Terraform', category: 'Managed Service' },
        { name: 'Sentinel Policy as Code', category: 'Policy' },
        { name: 'GitHub Actions / GitLab CI (Terraform patterns)', category: 'CI/CD' },
        { name: 'OIDC Dynamic Credentials', category: 'Security' },
      ],
    },

    // ─── Domain 5: Troubleshooting and Debugging (13%) ───
    {
      id: 'domain-5',
      name: 'Troubleshoot Terraform Configurations and Operations',
      weightPercent: 13,
      tasks: [
        {
          id: 'task-5.1',
          text: 'Debug and resolve Terraform configuration and provider errors',
          knowledgeStatements: [
            { id: 'ks-5.1.1', text: 'TF_LOG and TF_LOG_PATH: debug, info, warn, error, trace log levels' },
            { id: 'ks-5.1.2', text: 'Interpreting provider errors: API rate limits, permission errors, dependency cycles' },
            { id: 'ks-5.1.3', text: 'Resource dependency issues: explicit depends_on for implicit dependencies' },
            { id: 'ks-5.1.4', text: 'State drift: causes, detection with terraform plan, remediation with import or state rm' },
            { id: 'ks-5.1.5', text: 'Error: cycle in graph: identifying and resolving resource dependency cycles' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.1-001',
              misconception: 'Adding depends_on to all resources by default to avoid dependency issues',
              whyWrong: 'Unnecessary depends_on relationships prevent Terraform from parallelizing resource creation, significantly slowing applies. Only add depends_on for hidden dependencies that Terraform cannot infer from resource references.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Terraform CLI (debug logging)', category: 'IaC Tool' },
        { name: 'Terraform Plan Output', category: 'IaC Tool' },
        { name: 'Terraform State (drift detection)', category: 'State Management' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Terraform Enterprise-only features (audit logging, SSO, clustering)',
    'Writing custom Terraform providers (go programming)',
    'Terraform CDK (CDKTF) — code-based Terraform',
    'Cloud-provider-specific architecture best practices',
  ],
};
