import { NextResponse } from 'next/server';
import { getAllGuides } from '@/data/exam-guides';

/** GET /api/exam-guides — list all registered exam guides with versions */
export async function GET() {
  const guides = getAllGuides();

  const response = guides.map(({ slug, current, versions }) => ({
    slug,
    current: {
      certificationCode: current.certificationCode,
      certificationName: current.certificationName,
      provider: current.provider,
      version: current.version,
      status: current.status,
      effectiveDate: current.effectiveDate,
      retirementDate: current.retirementDate,
      domainCount: current.domains.length,
      domains: current.domains.map(d => ({
        id: d.id,
        name: d.name,
        weightPercent: d.weightPercent,
        taskCount: d.tasks.length,
        serviceCount: d.inScopeServices.length,
      })),
      examFormat: current.examFormat,
    },
    versionCount: versions.length,
    versions: versions.map(v => ({
      version: v.version,
      status: v.status,
      effectiveDate: v.effectiveDate,
      retirementDate: v.retirementDate,
    })),
  }));

  return NextResponse.json({ guides: response });
}
