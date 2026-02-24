import { NextRequest, NextResponse } from 'next/server';
import { runGenerationPipeline } from '@/lib/pipeline';
import { toBankQuestions, storeQuestions } from '@/lib/engine/question-bank';
import { getCurrentGuide, resolveGuideFromCertName } from '@/data/exam-guides';
import type { QuestionType } from '@/lib/types/exam-guide';
import type { Difficulty } from '@/lib/types/reference-question';
import type { PipelineParams, ModuleInput } from '@/lib/types/generation';
import type { BankQuestion } from '@/lib/types/question-bank';
import type { CertTier, GenMode } from '@/lib/types/tier';

interface TopicModuleGroup {
  topicId: string;
  topicName: string;
  topicDescription?: string;
  modules: ModuleInput[];
  questionAllocation: number;
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const {
      certification_id,
      certification_code,
      certification_name,
      title,
      duration,
      total_questions = 65,
      passing_score = 720,
      questionType = 'mcq',
      questionTypes,
      complexityLevel = 'intermediate',
      enableValidation = true,
      storeInBank = false,
      certTier,
      genMode,
      // Map of topicId → { topicName, topicDescription, modules[] }
      topicModuleMap,
    } = body;

    if (!certification_id || !certification_name) {
      return NextResponse.json(
        { error: 'Missing required: certification_id, certification_name' },
        { status: 400 }
      );
    }

    if (!topicModuleMap || Object.keys(topicModuleMap).length === 0) {
      return NextResponse.json(
        { error: 'No topicModuleMap provided. Expected: { topicId: { topicName, modules[] } }' },
        { status: 400 }
      );
    }

    // Resolve exam guide for weighted distribution
    const examGuide = getCurrentGuide(certification_code || '') || resolveGuideFromCertName(certification_name);

    // Auto-resolve certTier from exam guide if not explicitly provided
    const resolvedCertTier = (certTier || examGuide?.tier) as CertTier | undefined;
    const resolvedGenMode = genMode as GenMode | undefined;

    // Distribute questions across topics based on exam guide domain weights
    const topicGroups = distributeQuestions(topicModuleMap, total_questions, examGuide);

    // Generate mock test ID
    const mockTestId = `mock_${certification_id}_${Date.now()}`;
    const allSqlParts: string[] = [];
    let totalGenerated = 0;
    let totalValidated = 0;
    let totalRejected = 0;
    let version = 'unknown';
    const allBankQuestions: BankQuestion[] = [];

    // Run pipeline for each topic group
    for (const group of topicGroups) {
      if (group.modules.length === 0 || group.questionAllocation === 0) continue;

      const questionsPerModule = Math.max(1, Math.ceil(group.questionAllocation / group.modules.length));

      const pipelineParams: PipelineParams = {
        certificationCode: certification_code || '',
        certificationName: certification_name,
        certificationId: certification_id,
        topicId: group.topicId,
        topicName: group.topicName,
        topicDescription: group.topicDescription,
        quizId: mockTestId,
        modules: group.modules,
        questionType: questionType as QuestionType,
        questionTypes: questionTypes || [questionType],
        complexityLevel: complexityLevel as Difficulty,
        questionsPerModule,
        enableValidation,
        certTier: resolvedCertTier,
        genMode: resolvedGenMode,
      };

      const result = await runGenerationPipeline(pipelineParams);
      version = result.examGuideVersion;
      totalGenerated += result.questionCount;
      totalValidated += result.validatedCount;
      totalRejected += result.rejectedCount;

      // Collect for question bank storage
      if (storeInBank && result.questions.length > 0) {
        const bankBatch = toBankQuestions(result.questions, {
          certificationCode: certification_code || certification_name,
          examGuideVersion: result.examGuideVersion,
          domainId: result.domainContext?.id || group.topicId,
          domainContext: result.domainContext,
          defaultDifficulty: complexityLevel as Difficulty,
          certTier: resolvedCertTier,
          genMode: resolvedGenMode,
        });
        allBankQuestions.push(...bankBatch);
      }

      // Extract the body of the SQL (between BEGIN and COMMIT)
      const sqlBody = result.sqlScript
        .replace(/^[\s\S]*?BEGIN;\s*/m, '')
        .replace(/\s*COMMIT;\s*$/m, '');
      allSqlParts.push(sqlBody);
    }

    // Store all questions in bank
    let bankResult: { stored: number; duplicates: number } | undefined;
    if (storeInBank && allBankQuestions.length > 0) {
      bankResult = await storeQuestions(allBankQuestions);
    }

    // Assemble the full mock test SQL
    const header = [
      `-- ═══════════════════════════════════════════════════════`,
      `-- Mock Exam: ${title || certification_name}`,
      `-- ═══════════════════════════════════════════════════════`,
      `-- Mock Test ID: ${mockTestId}`,
      `-- Exam Guide: ${version}`,
      `-- Total Questions: ${totalGenerated}`,
      `-- Duration: ${duration || examGuide?.examFormat.duration || 130} minutes`,
      `-- Passing Score: ${passing_score}`,
      `-- Generated: ${new Date().toISOString()}`,
      `-- Validated: ${totalValidated}, Rejected: ${totalRejected}`,
      `-- ═══════════════════════════════════════════════════════`,
      ``,
      `BEGIN;`,
      ``,
    ].join('\n');

    const footer = `\nCOMMIT;\n`;
    const fullSql = header + allSqlParts.join('\n') + footer;

    return NextResponse.json({
      success: true,
      sqlScript: fullSql,
      mockTestId,
      questionCount: totalGenerated,
      validatedCount: totalValidated,
      rejectedCount: totalRejected,
      examGuideVersion: version,
      distribution: topicGroups.map(g => ({
        topicName: g.topicName,
        allocated: g.questionAllocation,
        modules: g.modules.length,
      })),
      ...(bankResult && { questionBank: bankResult }),
    });
  } catch (error) {
    console.error('Error generating mock exam:', error);
    const message = error instanceof Error ? error.message : 'Failed to generate mock exam';
    return NextResponse.json(
      { error: message },
      { status: 500 }
    );
  }
}

/**
 * Distribute total questions across topics proportional to exam guide domain weights.
 * Falls back to equal distribution if no exam guide is available.
 */
function distributeQuestions(
  topicModuleMap: Record<string, { topicName: string; topicDescription?: string; modules: ModuleInput[] }>,
  totalQuestions: number,
  examGuide?: import('@/lib/types/exam-guide').ExamGuide
): TopicModuleGroup[] {
  const topics = Object.entries(topicModuleMap);

  if (!examGuide) {
    // Equal distribution fallback
    const perTopic = Math.ceil(totalQuestions / topics.length);
    return topics.map(([topicId, data]) => ({
      topicId,
      topicName: data.topicName,
      topicDescription: data.topicDescription,
      modules: data.modules,
      questionAllocation: perTopic,
    }));
  }

  // Weighted distribution based on exam guide domains
  const groups: TopicModuleGroup[] = [];
  let allocated = 0;

  for (const [topicId, data] of topics) {
    // Try to match topic to a domain for weighting
    const normalizedTopic = data.topicName.toLowerCase();
    const matchedDomain = examGuide.domains.find(d => {
      const domainLower = d.name.toLowerCase();
      const topicWords = normalizedTopic.split(/\s+/).filter(w => w.length > 3);
      return topicWords.some(w => domainLower.includes(w));
    });

    const weight = matchedDomain ? matchedDomain.weightPercent / 100 : 1 / topics.length;
    const allocation = Math.round(totalQuestions * weight);

    groups.push({
      topicId,
      topicName: data.topicName,
      topicDescription: data.topicDescription,
      modules: data.modules,
      questionAllocation: allocation,
    });
    allocated += allocation;
  }

  // Adjust for rounding — add/remove from largest group
  const diff = totalQuestions - allocated;
  if (diff !== 0 && groups.length > 0) {
    groups.sort((a, b) => b.questionAllocation - a.questionAllocation);
    groups[0].questionAllocation += diff;
  }

  return groups;
}
