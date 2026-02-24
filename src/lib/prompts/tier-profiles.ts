// Tier & Mode profile data — static lookup maps consumed by v2 prompt builders

import type { CertTier, GenMode, TierProfile, ModeProfile } from '@/lib/types/tier';

export const TIER_PROFILES: Record<CertTier, TierProfile> = {
  foundational: {
    tier: 'foundational',
    stemLength: '1-2 sentences',
    stemWordRange: [15, 40],
    cognitiveLevel: 'recognition and definition',
    serviceInteraction: 'single service per question',
    constraintProfile: 'no constraints — direct concept identification',
    scenarioComplexity:
      'Questions should be straightforward, testing whether the candidate can recognize what a service does or identify its primary purpose. No multi-step reasoning required. Present a simple use case or definition and ask which AWS service or concept applies. The candidate should be able to answer from foundational knowledge without analyzing tradeoffs.',
    distractorStrategy:
      'Distractors should be real AWS services or concepts from different categories than the correct answer. They should be plausible to someone who confuses service categories (e.g., offering a compute service when the answer is a storage service) but clearly incorrect to anyone with foundational knowledge. Avoid same-category distractors — the distinction should be conceptual, not nuanced.',
  },
  associate: {
    tier: 'associate',
    stemLength: '3-4 sentences',
    stemWordRange: [60, 120],
    cognitiveLevel: 'application and analysis',
    serviceInteraction: '2-3 services interacting in a scenario',
    constraintProfile: 'one business constraint (e.g., "LEAST operational overhead", "MOST cost-effective")',
    scenarioComplexity:
      'Questions should present a practical business scenario with a clear requirement and one primary constraint. The candidate must understand how 2-3 services work together and choose the combination that satisfies the constraint. Include enough context to make the scenario realistic (team size, data volume, access pattern) but do not add conflicting constraints or multi-account complexity.',
    distractorStrategy:
      'Distractors should be services or approaches from the same category as the correct answer that fail the stated constraint. For example, if the constraint is "LEAST operational overhead," wrong answers should be valid architectures that require more operational effort. Each distractor should represent a common associate-level misconception — choosing a service that works but is suboptimal for the specific requirement.',
  },
  professional: {
    tier: 'professional',
    stemLength: '5-8 sentences',
    stemWordRange: [100, 200],
    cognitiveLevel: 'evaluation and synthesis',
    serviceInteraction: 'multi-account, multi-region, 4+ services',
    constraintProfile: 'conflicting constraints requiring tradeoff analysis (e.g., cost vs. performance vs. compliance)',
    scenarioComplexity:
      'Questions should present complex enterprise scenarios involving multi-account or multi-region architectures. Include conflicting business constraints that require the candidate to evaluate tradeoffs — for example, a compliance requirement that conflicts with a cost-optimization goal. The scenario should involve organizational complexity (multiple teams, existing infrastructure, migration timelines) and require synthesizing knowledge across multiple AWS service domains.',
    distractorStrategy:
      'Distractors should be multi-step approaches that are architecturally valid but fail one of the conflicting constraints. Each wrong answer should be a detailed paragraph describing a plausible architecture that a professional might consider. The distinction between correct and incorrect should require evaluating which approach best balances all stated constraints — not just knowing what a service does.',
  },
  specialty: {
    tier: 'specialty',
    stemLength: '2-4 sentences',
    stemWordRange: [40, 100],
    cognitiveLevel: 'deep technical recall and precision',
    serviceInteraction: 'single service, deep API/config level',
    constraintProfile: 'specific technical constraint (API parameter, config syntax, protocol detail)',
    scenarioComplexity:
      'Questions should test deep technical knowledge of specific AWS services at the API parameter, configuration syntax, or protocol level. The stem is shorter than professional-level but requires highly specialized knowledge. Present a specific technical problem that requires knowing exact configuration details, API behaviors, or architectural nuances of a specialty domain (e.g., networking, security, database, machine learning).',
    distractorStrategy:
      'Distractors should be syntactically similar configurations or API parameters that differ in subtle but critical ways. For example, a wrong answer might use a parameter that exists but applies to a different context, or a configuration value that is close to correct but causes different behavior. The goal is to test whether the candidate has hands-on experience with the service, not just conceptual understanding.',
  },
};

export const MODE_PROFILES: Record<GenMode, ModeProfile> = {
  drill: {
    mode: 'drill',
    focus: 'Single-concept mastery',
    ksScope: 'single',
    questionBehavior:
      'Generate a question that isolates ONE knowledge statement. The question should test understanding of a single concept without requiring cross-domain knowledge. The candidate should be able to answer using only their knowledge of the targeted concept. Do not combine multiple knowledge statements or require reasoning across different service areas. This is practice mode — the goal is to reinforce individual concepts.',
  },
  simulation: {
    mode: 'simulation',
    focus: 'Exam-realistic multi-constraint scenarios',
    ksScope: 'cross',
    questionBehavior:
      'Generate a question that combines 2-3 knowledge statements into a realistic exam scenario. The question should simulate the pacing and complexity of the actual certification exam. Include business context, specific metrics or constraints, and require the candidate to synthesize knowledge across multiple areas to identify the best answer. This is exam preparation mode — the goal is to build test-taking stamina and cross-domain reasoning.',
  },
};

/** Get tier profile with fallback to associate */
export function getTierProfile(tier: CertTier): TierProfile {
  return TIER_PROFILES[tier] || TIER_PROFILES.associate;
}

/** Get mode profile with fallback to simulation */
export function getModeProfile(mode: GenMode): ModeProfile {
  return MODE_PROFILES[mode] || MODE_PROFILES.simulation;
}
