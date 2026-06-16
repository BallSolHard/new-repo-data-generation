import type { ExamGuide } from '@/lib/types/exam-guide';

export const terraformAssociate: ExamGuide = {
  certificationCode: 'TA-003',
  certificationName: 'HashiCorp Certified: Terraform Associate (003)',
  provider: 'hashicorp',
  version: 'TA-003',
  effectiveDate: '2023-04-14',
  status: 'current',
  tier: 'associate' as const,
  examFormat: {
    totalQuestions: 57,
    scoredQuestions: 57,
    unscoredQuestions: 0,
    duration: 60,
    passingScore: 700,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    // ─── Domain 1: IaC Concepts (6%) ───
    {
      id: 'domain-1',
      name: 'Understand Infrastructure as Code (IaC) Concepts',
      weightPercent: 6,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Explain what IaC is and its benefits',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'IaC benefits: consistency, repeatability, version control, peer review, documentation as code' },
            { id: 'ks-1.1.2', text: 'Declarative vs. imperative approaches to infrastructure provisioning' },
            { id: 'ks-1.1.3', text: 'Idempotency: applying the same configuration multiple times yields the same result' },
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Thinking Terraform is an imperative tool because you write code',
              whyWrong: 'Terraform is declarative: you define the desired end state and Terraform determines the actions required to achieve it. You do not specify the sequence of API calls; Terraform\'s execution plan handles that.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Terraform CLI', category: 'IaC Tool' },
        { name: 'Terraform Language (HCL)', category: 'Configuration Language' },
      ],
    },

    // ─── Domain 2: Terraform Purpose (8%) ───
    {
      id: 'domain-2',
      name: 'Understand Terraform\'s Purpose',
      weightPercent: 8,
      tasks: [
        {
          id: 'task-2.1',
          text: 'Explain multi-cloud and provider-agnostic benefits of Terraform',
          knowledgeStatements: [
            { id: 'ks-2.1.1', text: 'Terraform provider ecosystem: AWS, Azure, GCP, Kubernetes, SaaS providers' },
            { id: 'ks-2.1.2', text: 'Terraform vs. cloud-native tools (CloudFormation, ARM): portability and consistency' },
            { id: 'ks-2.1.3', text: 'Terraform Registry: public providers and modules' },
          ],
          antiPatterns: [
            {
              id: 'ap-2.1-001',
              misconception: 'Using Terraform to replace configuration management tools like Ansible or Chef',
              whyWrong: 'Terraform provisions infrastructure (VMs, networks, databases) but is not designed for ongoing configuration management inside servers. Use Terraform for infrastructure provisioning and a dedicated configuration management tool for OS-level and application configuration.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Terraform Registry', category: 'Registry' },
        { name: 'Terraform Providers', category: 'Plugins' },
      ],
    },

    // ─── Domain 3: Terraform Basics (32%) ───
    {
      id: 'domain-3',
      name: 'Understand Terraform Basics',
      weightPercent: 32,
      tasks: [
        {
          id: 'task-3.1',
          text: 'Install and version Terraform providers',
          knowledgeStatements: [
            { id: 'ks-3.1.1', text: 'required_providers block: source, version constraints (~>, >=, =, !=)' },
            { id: 'ks-3.1.2', text: 'terraform init: provider installation, .terraform directory, .terraform.lock.hcl' },
            { id: 'ks-3.1.3', text: 'Provider version locking and the dependency lock file' },
          ],
          antiPatterns: [
            {
              id: 'ap-3.1-001',
              misconception: 'Committing the .terraform directory to version control',
              whyWrong: 'The .terraform directory contains provider binaries that are platform-specific and large. Commit .terraform.lock.hcl to lock provider versions, but exclude .terraform/ via .gitignore. Team members and CI/CD run terraform init to download providers.',
            },
          ],
        },
        {
          id: 'task-3.2',
          text: 'Describe plug-in based architecture and Terraform core vs. providers',
          knowledgeStatements: [
            { id: 'ks-3.2.1', text: 'Terraform Core: planning, graph building, RPC calls to provider plugins' },
            { id: 'ks-3.2.2', text: 'Provider plugins: CRUD operations against APIs, resource schemas' },
            { id: 'ks-3.2.3', text: 'Data sources vs. resources: read-only vs. managed lifecycle' },
          ],
          antiPatterns: [],
        },
        {
          id: 'task-3.3',
          text: 'Explain how Terraform finds and fetches providers',
          knowledgeStatements: [
            { id: 'ks-3.3.1', text: 'Provider source addresses: registry.terraform.io/<namespace>/<type>' },
            { id: 'ks-3.3.2', text: 'Implicit vs. explicit provider configuration with provider blocks' },
            { id: 'ks-3.3.3', text: 'Provider aliases for managing multiple instances of the same provider' },
          ],
          antiPatterns: [],
        },
      ],
      inScopeServices: [
        { name: 'Terraform CLI (init, plan, apply, destroy)', category: 'IaC Tool' },
        { name: 'Terraform Providers (AWS, Azure, GCP)', category: 'Plugins' },
        { name: 'Terraform Registry', category: 'Registry' },
      ],
    },

    // ─── Domain 4: Terraform Outside of Core Workflow (16%) ───
    {
      id: 'domain-4',
      name: 'Use Terraform Outside of Core Workflow',
      weightPercent: 16,
      tasks: [
        {
          id: 'task-4.1',
          text: 'Describe when to use terraform import, taint, state, and replace',
          knowledgeStatements: [
            { id: 'ks-4.1.1', text: 'terraform import: bring existing resources under Terraform management' },
            { id: 'ks-4.1.2', text: 'terraform state: list, show, mv, rm commands for state manipulation' },
            { id: 'ks-4.1.3', text: '-replace flag (formerly taint): force replacement of a specific resource' },
            { id: 'ks-4.1.4', text: 'terraform refresh: reconcile state with real-world infrastructure' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.1-001',
              misconception: 'Manually editing terraform.tfstate files to fix state issues',
              whyWrong: 'Manual state file edits can corrupt state, cause plan errors, or lead to resource duplication/deletion. Use the terraform state subcommands (mv, rm) or terraform import to safely make state modifications.',
            },
          ],
        },
        {
          id: 'task-4.2',
          text: 'Use terraform workspaces for environment management',
          knowledgeStatements: [
            { id: 'ks-4.2.1', text: 'Terraform workspaces: separate state per workspace within same configuration' },
            { id: 'ks-4.2.2', text: 'terraform.workspace variable for environment-specific values' },
            { id: 'ks-4.2.3', text: 'Workspace limitations: not recommended for complex environment isolation (use separate roots instead)' },
          ],
          antiPatterns: [
            {
              id: 'ap-4.2-001',
              misconception: 'Using workspaces as the primary isolation mechanism between production and development',
              whyWrong: 'Workspaces share the same code and provider configuration, which can lead to accidental cross-environment changes. For production/non-production separation, use separate Terraform root modules with separate state backends and separate access credentials.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Terraform CLI (import, state, workspace)', category: 'IaC Tool' },
        { name: 'Terraform State File', category: 'State Management' },
      ],
    },

    // ─── Domain 5: Terraform Modules (16%) ───
    {
      id: 'domain-5',
      name: 'Interact with Terraform Modules',
      weightPercent: 16,
      tasks: [
        {
          id: 'task-5.1',
          text: 'Contrast module source options and their use cases',
          knowledgeStatements: [
            { id: 'ks-5.1.1', text: 'Module sources: local paths, Terraform Registry, GitHub, S3, GCS, Bitbucket' },
            { id: 'ks-5.1.2', text: 'Module versioning: version argument, version constraints' },
            { id: 'ks-5.1.3', text: 'Module inputs (variables), outputs, and the module call block' },
            { id: 'ks-5.1.4', text: 'Root module vs. child module vs. published module concepts' },
          ],
          antiPatterns: [
            {
              id: 'ap-5.1-001',
              misconception: 'Not pinning module versions from the public Terraform Registry',
              whyWrong: 'Without a version constraint, terraform init downloads the latest module version, which may introduce breaking changes or regressions. Always pin module versions in production with a specific version or patch-level constraint.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Terraform Registry (Modules)', category: 'Registry' },
        { name: 'Terraform Module Blocks', category: 'HCL Construct' },
      ],
    },

    // ─── Domain 6: Core Workflow (22%) ───
    {
      id: 'domain-6',
      name: 'Navigate Terraform Workflow',
      weightPercent: 22,
      tasks: [
        {
          id: 'task-6.1',
          text: 'Describe Terraform workflow: Write → Plan → Apply',
          knowledgeStatements: [
            { id: 'ks-6.1.1', text: 'terraform plan: dry-run, execution plan, exit codes' },
            { id: 'ks-6.1.2', text: 'terraform apply: apply changes, auto-approve flag' },
            { id: 'ks-6.1.3', text: 'terraform destroy: remove all managed resources' },
            { id: 'ks-6.1.4', text: 'terraform validate: syntax and configuration validation' },
            { id: 'ks-6.1.5', text: 'terraform fmt: canonical formatting' },
          ],
          antiPatterns: [
            {
              id: 'ap-6.1-001',
              misconception: 'Using terraform apply -auto-approve in production pipelines without plan review',
              whyWrong: 'Auto-approve bypasses the plan review step that guards against unintended resource replacements or deletions. In production, always generate a saved plan file, review it, and apply only the saved plan. Use -auto-approve only in controlled CI/CD environments with plan gate approval.',
            },
          ],
        },
        {
          id: 'task-6.2',
          text: 'Initialize, plan, and apply Terraform configurations',
          knowledgeStatements: [
            { id: 'ks-6.2.1', text: 'terraform.tfvars and *.auto.tfvars for variable value files' },
            { id: 'ks-6.2.2', text: 'Variable precedence order: default < tfvars < env vars (TF_VAR_*) < CLI -var' },
            { id: 'ks-6.2.3', text: 'Sensitive variable handling: sensitive = true, avoiding state exposure' },
            { id: 'ks-6.2.4', text: 'Backend configuration: remote state storage in S3, Azure Blob, GCS, Terraform Cloud' },
          ],
          antiPatterns: [
            {
              id: 'ap-6.2-001',
              misconception: 'Storing Terraform state locally in a team environment',
              whyWrong: 'Local state cannot be shared, is not locked against concurrent access, and has no history or backup. Use a remote backend (S3 + DynamoDB for locking, Terraform Cloud, or similar) to enable team collaboration and prevent state corruption.',
            },
          ],
        },
      ],
      inScopeServices: [
        { name: 'Terraform CLI (plan, apply, destroy, validate, fmt)', category: 'IaC Tool' },
        { name: 'Terraform Remote Backends (S3, GCS, Terraform Cloud)', category: 'State Management' },
        { name: 'Terraform Cloud (Basic)', category: 'Managed Service' },
      ],
    },
  ],

  outOfScopeTopics: [
    'Advanced Terraform Cloud/Enterprise features (Sentinel, audit logs, SSO)',
    'Terraform provider development (writing custom providers)',
    'Cloud-specific services beyond basic Terraform usage',
    'Terraform CDK (cloud development kit for Terraform)',
  ],
};
