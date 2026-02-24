import { NextRequest, NextResponse } from 'next/server';
import { getCurrentGuide, getGuideByVersion, getGuideVersions } from '@/data/exam-guides';

/** GET /api/exam-guides/[slug]?version=X — get a specific exam guide */
export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ slug: string }> }
) {
  const { slug } = await params;
  const version = request.nextUrl.searchParams.get('version');

  const guide = version
    ? getGuideByVersion(slug, version)
    : getCurrentGuide(slug);

  if (!guide) {
    return NextResponse.json(
      { error: `No exam guide found for: ${slug}${version ? ` version ${version}` : ''}` },
      { status: 404 }
    );
  }

  const versions = getGuideVersions(slug);

  return NextResponse.json({
    guide,
    availableVersions: versions.map(v => ({
      version: v.version,
      status: v.status,
      effectiveDate: v.effectiveDate,
    })),
  });
}
