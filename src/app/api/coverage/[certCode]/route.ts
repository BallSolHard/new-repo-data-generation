import { NextRequest, NextResponse } from 'next/server';
import {
  analyzeCoverage,
  getKnowledgeStatementCoverage,
  getServiceCoverage,
} from '@/lib/engine/coverage-analyzer';

/**
 * GET /api/coverage/:certCode
 *
 * Returns full certification coverage report.
 *
 * Query params:
 *   detail=ks       — return per-knowledge-statement breakdown
 *   detail=services — return per-service breakdown
 *   (default)       — return summary report with gaps
 */
export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ certCode: string }> }
) {
  try {
    const { certCode } = await params;
    const detail = request.nextUrl.searchParams.get('detail');

    if (detail === 'ks') {
      const ksCoverage = await getKnowledgeStatementCoverage(certCode);
      const covered = ksCoverage.filter(ks => ks.isCovered).length;
      return NextResponse.json({
        certificationCode: certCode,
        total: ksCoverage.length,
        covered,
        uncovered: ksCoverage.length - covered,
        knowledgeStatements: ksCoverage,
      });
    }

    if (detail === 'services') {
      const serviceCoverage = await getServiceCoverage(certCode);
      const covered = serviceCoverage.filter(s => s.isCovered).length;
      return NextResponse.json({
        certificationCode: certCode,
        total: serviceCoverage.length,
        covered,
        uncovered: serviceCoverage.length - covered,
        services: serviceCoverage,
      });
    }

    // Default: full coverage report
    const report = await analyzeCoverage(certCode);
    return NextResponse.json(report);
  } catch (error) {
    console.error('[coverage] error:', error);
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'Internal server error' },
      { status: 500 }
    );
  }
}
