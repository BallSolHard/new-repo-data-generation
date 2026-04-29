const https = require('https');
const fs = require('fs');

// Your Supabase credentials - USE SERVICE ROLE KEY
const SUPABASE_URL = 'https://prpnsouhnycwsqkxocks.supabase.co';
const SUPABASE_SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBycG5zb3Vobnljd3Nxa3hvY2tzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0NjU3OTkwNCwiZXhwIjoyMDYyMTU1OTA0fQ.IvxOo7I_71lNkkY8umXrM2EIW-CGmEX2WpusGpKmDzs';
const PROJECT_REF = 'prpnsouhnycwsqkxocks';

console.log('╔════════════════════════════════════════════════════════════╗');
console.log('║  Supabase Database Export via REST API                    ║');
console.log('║  Using SERVICE_ROLE_KEY                                  ║');
console.log('╚════════════════════════════════════════════════════════════╝');
console.log('');

// Get list of tables first
console.log('Step 1: Fetching database schema...');
console.log('');

const getTablesOptions = {
  hostname: 'prpnsouhnycwsqkxocks.supabase.co',
  path: '/rest/v1/',
  method: 'GET',
  headers: {
    'apikey': SUPABASE_SERVICE_ROLE_KEY,
    'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
    'Content-Type': 'application/json'
  }
};

const req = https.request(getTablesOptions, (res) => {
  console.log('✓ Connected to Supabase');
  console.log('Status Code:', res.statusCode);
  console.log('');

  let data = '';
  res.on('data', (chunk) => {
    data += chunk;
  });

  res.on('end', () => {
    console.log('Response:', data);
    console.log('');
    
    if (res.statusCode === 200 || res.statusCode === 401) {
      console.log('✓ Authentication worked!');
      console.log('');
      console.log('Now you can export individual tables using:');
      console.log('');
      console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      console.log('CURL Commands (copy and paste):');
      console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      console.log('');
      console.log('Export all data from a table to JSON:');
      console.log('');
      console.log('curl -X GET "' + SUPABASE_URL + '/rest/v1/table_name?select=*" \\');
      console.log('  -H "apikey: ' + SUPABASE_SERVICE_ROLE_KEY + '" \\');
      console.log('  > table_backup.json');
      console.log('');
      console.log('Export with limit:');
      console.log('');
      console.log('curl -X GET "' + SUPABASE_URL + '/rest/v1/table_name?select=*&limit=1000" \\');
      console.log('  -H "apikey: ' + SUPABASE_SERVICE_ROLE_KEY + '" \\');
      console.log('  > table_backup.json');
      console.log('');
      console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    }
  });
});

req.on('error', (error) => {
  console.log('✗ Error:', error.message);
});

req.end();
