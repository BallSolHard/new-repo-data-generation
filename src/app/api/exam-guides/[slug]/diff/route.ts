import { NextRequest, NextResponse } from 'next/server';
import { getGuideByVersion } from '@/data/exam-guides';
import { diffExamGuides } from '@/lib/versioning/diff';

/** GET /api/exam-guides/[slug]/diff?from=SAA-C03&to=SAA-C04 — diff two versions */
export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ slug: string }> }
) {
  const { slug } = await params;
  const fromVersion = request.nextUrl.searchParams.get('from');
  const toVersion = request.nextUrl.searchParams.get('to');

  if (!fromVersion || !toVersion) {
    return NextResponse.json(
      { error: 'Missing required query params: from, to' },
      { status: 400 }
    );
  }

  const fromGuide = getGuideByVersion(slug, fromVersion);
  const toGuide = getGuideByVersion(slug, toVersion);

  if (!fromGuide) {
    return NextResponse.json(
      { error: `Version not found: ${fromVersion}` },
      { status: 404 }
    );
  }
  if (!toGuide) {
    return NextResponse.json(
      { error: `Version not found: ${toVersion}` },
      { status: 404 }
    );
  }

  const diff = diffExamGuides(fromGuide, toGuide);

  return NextResponse.json({ diff });
}
