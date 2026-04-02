// Mock Test Naming Utilities
// Generates consistent, readable IDs and titles for mock tests

/**
 * Generate a mock test ID following the naming convention:
 * mock_[CERT_CODE]_[INDEX]_[TIMESTAMP]
 * 
 * @param certificationCode - Short code like "DVA", "DVOPS", "TA", "SAA"
 * @param index - Sequential number (will be padded to 3 digits)
 * @param timestamp - Optional Unix timestamp (defaults to current time)
 * @returns Formatted mock test ID
 * 
 * @example
 * generateMockTestId('DVA', 1) // 'mock_DVA_001_1711858200000'
 * generateMockTestId('DVOPS', 2) // 'mock_DVOPS_002_1711858200000'
 */
export function generateMockTestId(
  certificationCode: string,
  index: number,
  timestamp?: number
): string {
  const code = certificationCode.toUpperCase();
  const paddedIndex = String(index).padStart(3, '0'); // Format as 001, 002, etc.
  const ts = timestamp || Date.now();

  return `mock_${code}_${paddedIndex}_${ts}`;
}

/**
 * Generate a human-readable title for a mock test
 * 
 * @param certificationName - Full name like "AWS Certified Developer Associate"
 * @param index - Sequential number
 * @returns Formatted title
 * 
 * @example
 * generateMockTestTitle('AWS Certified Developer Associate', 1) 
 * // 'Mock Test 1 - AWS Certified Developer Associate'
 */
export function generateMockTestTitle(
  certificationName: string,
  index: number
): string {
  return `Mock Test ${index} - ${certificationName}`;
}

/**
 * Extract certification code from certification name
 * Maps full names to short codes
 * 
 * @param certificationName - Full certification name
 * @returns Short code (e.g., "DVA", "DVOPS", "TA")
 */
export function extractCertificationCode(
  certificationName: string
): string {
  const codeMap: Record<string, string> = {
    // AWS Certifications
    'AWS Certified Developer - Associate': 'DVA',
    'AWS Certified DevOps Engineer - Professional': 'DVOPS',
    'AWS Certified Solutions Architect - Associate': 'SAA',
    'AWS Certified Solutions Architect - Professional': 'SAP',
    'AWS Certified Cloud Practitioner': 'CCP',
    'AWS Certified SysOps Administrator - Associate': 'SOA',
    'AWS Certified Database Specialty': 'DBS',
    'AWS Certified Data Analytics Specialty': 'DAS',
    'AWS Certified Advanced Networking Specialty': 'ANS',
    'AWS Certified Security Specialty': 'SCS',
    'AWS Certified Machine Learning - Specialty': 'MLS',

    // HashiCorp Certifications
    'HashiCorp Certified: Terraform Associate': 'TA',
    'HashiCorp Certified: Consul Associate': 'CA',
    'HashiCorp Certified: Vault Associate': 'VA',
    'HashiCorp Certified: Nomad Associate': 'NA',
    'HashiCorp Certified: Packer Associate': 'PA',
  };

  // Try exact match first
  if (codeMap[certificationName]) {
    return codeMap[certificationName];
  }

  // Try partial match
  for (const [name, code] of Object.entries(codeMap)) {
    if (
      certificationName.includes(name) ||
      name.includes(certificationName)
    ) {
      return code;
    }
  }

  // Fallback: use first letters of each word (max 6 chars)
  return certificationName
    .split(/\s+/)
    .map((word) => word[0])
    .join('')
    .toUpperCase()
    .slice(0, 6);
}

/**
 * Get the next available index for a certification
 * Parses existing mock test IDs to find the highest index
 * 
 * @param certificationCode - Code like "DVA"
 * @param existingMockTests - Array of existing mock test IDs
 * @returns Next index to use
 * 
 * @example
 * getNextMockTestIndex('DVA', ['mock_DVA_001_123', 'mock_DVA_002_456'])
 * // Returns 3
 */
export function getNextMockTestIndex(
  certificationCode: string,
  existingMockTests: string[]
): number {
  const code = certificationCode.toUpperCase();
  const pattern = new RegExp(`^mock_${code}_(\\d+)_`);

  const matchingIndices = existingMockTests
    .filter((id) => pattern.test(id))
    .map((id) => {
      const match = id.match(pattern);
      return match ? parseInt(match[1], 10) : 0;
    });

  return matchingIndices.length > 0
    ? Math.max(...matchingIndices) + 1
    : 1;
}

/**
 * Parse a mock test ID to extract components
 * 
 * @param mockTestId - ID like "mock_DVA_001_1711858200000"
 * @returns Object with code, index, and timestamp
 * 
 * @example
 * parseMockTestId('mock_DVA_001_1711858200000')
 * // { code: 'DVA', index: 1, timestamp: 1711858200000 }
 */
export function parseMockTestId(
  mockTestId: string
): { code: string; index: number; timestamp: number } | null {
  const match = mockTestId.match(/^mock_([A-Z]+)_(\d+)_(\d+)$/);
  if (!match) return null;

  return {
    code: match[1],
    index: parseInt(match[2], 10),
    timestamp: parseInt(match[3], 10),
  };
}

/**
 * Validate a mock test ID format
 * 
 * @param mockTestId - ID to validate
 * @returns true if valid format, false otherwise
 * 
 * @example
 * isValidMockTestId('mock_DVA_001_1711858200000') // true
 * isValidMockTestId('invalid_id') // false
 */
export function isValidMockTestId(mockTestId: string): boolean {
  return /^mock_[A-Z]+_\d{3}_\d+$/.test(mockTestId);
}

/**
 * Get human-readable description of a mock test from its ID
 * 
 * @param mockTestId - ID like "mock_DVA_001_1711858200000"
 * @param certCodeToName - Map of cert codes to names (optional)
 * @returns Description like "Mock Test 1 - DVA" or "Mock Test 1 - AWS Developer Associate"
 */
export function getMockTestDescription(
  mockTestId: string,
  certCodeToName?: Record<string, string>
): string | null {
  const parsed = parseMockTestId(mockTestId);
  if (!parsed) return null;

  const name = certCodeToName?.[parsed.code] || parsed.code;
  return `Mock Test ${parsed.index} - ${name}`;
}

// Default certification code to name mapping
export const DEFAULT_CERT_CODE_MAP: Record<string, string> = {
  DVA: 'AWS Developer Associate',
  DVOPS: 'AWS DevOps Professional',
  SAA: 'AWS Solutions Architect Associate',
  SAP: 'AWS Solutions Architect Professional',
  CCP: 'AWS Cloud Practitioner',
  SOA: 'AWS SysOps Administrator',
  DBS: 'AWS Database Specialty',
  DAS: 'AWS Data Analytics Specialty',
  ANS: 'AWS Advanced Networking Specialty',
  SCS: 'AWS Security Specialty',
  MLS: 'AWS Machine Learning Specialty',
  TA: 'Terraform Associate',
  CA: 'Consul Associate',
  VA: 'Vault Associate',
  NA: 'Nomad Associate',
  PA: 'Packer Associate',
};
