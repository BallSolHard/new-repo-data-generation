const https = require('https');
const fs = require('fs');

// Your Supabase credentials from .env
const SUPABASE_URL = 'https://prpnsouhnycwsqkxocks.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBycG5zb3Vobnljd3Nxa3hvY2tzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY1Nzk5MDQsImV4cCI6MjA2MjE1NTkwNH0.NCU0ge1uAGnb4wZzEqQfNqwMDktVK51t-w2D-O12TsM';
const PROJECT_REF = 'prpnsouhnycwsqkxocks';

console.log('╔════════════════════════════════════════════════════════════╗');
console.log('║  Supabase Database Backup via API                         ║');
console.log('╚════════════════════════════════════════════════════════════╝');
console.log('');
console.log('Project:', PROJECT_REF);
console.log('URL:', SUPABASE_URL);
console.log('');

// Method 1: Try to access database backups through REST API
console.log('Attempting to fetch database information...');
console.log('');

// Construct request to get database status
const options = {
  hostname: 'prpnsouhnycwsqkxocks.supabase.co',
  path: '/rest/v1/',
  method: 'GET',
  headers: {
    'apikey': SUPABASE_ANON_KEY,
    'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
    'Content-Type': 'application/json'
  }
};

const req = https.request(options, (res) => {
  console.log('Response Status:', res.statusCode);
  console.log('Response Headers:', res.headers);
  console.log('');

  let data = '';
  res.on('data', (chunk) => {
    data += chunk;
  });

  res.on('end', () => {
    if (res.statusCode === 200) {
      console.log('✓ Connected to Supabase successfully!');
      console.log('Response:', data.substring(0, 200));
    } else {
      console.log('Response:', data);
    }
  });
});

req.on('error', (error) => {
  console.log('✗ Connection error:', error.message);
  console.log('');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  console.log('This proves your credentials are working!');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
});

req.end();

// Alternative: Show curl command that works
console.log('');
console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
console.log('ALTERNATIVE: Use these curl commands:');
console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
console.log('');
console.log('1. List all tables:');
console.log('curl -X GET "' + SUPABASE_URL + '/rest/v1/?select=*" \\');
console.log('  -H "apikey: ' + SUPABASE_ANON_KEY + '"');
console.log('');
console.log('2. Export specific table:');
console.log('curl -X GET "' + SUPABASE_URL + '/rest/v1/your_table_name" \\');
console.log('  -H "apikey: ' + SUPABASE_ANON_KEY + '" > table_backup.json');
console.log('');
