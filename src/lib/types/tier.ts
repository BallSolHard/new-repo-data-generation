// Tier-aware generation types — cognitive complexity decoupled from subject matter

export type CertTier = 'foundational' | 'associate' | 'professional' | 'specialty';
export type GenMode = 'drill' | 'simulation';

export interface TierProfile {
  tier: CertTier;
  stemLength: string;              // "1-2 sentences", "5-8 sentences"
  stemWordRange: [number, number]; // [15, 40], [100, 200]
  cognitiveLevel: string;
  serviceInteraction: string;
  constraintProfile: string;
  scenarioComplexity: string;      // full paragraph for prompt injection
  distractorStrategy: string;      // full paragraph for prompt injection
}

export interface ModeProfile {
  mode: GenMode;
  focus: string;
  ksScope: 'single' | 'cross';
  questionBehavior: string;        // full paragraph for prompt injection
}

export interface AntiPattern {
  id: string;                      // "ap-1.1-001"
  misconception: string;           // what people get wrong
  whyWrong: string;                // why it's wrong
  relatedServices?: string[];
}
