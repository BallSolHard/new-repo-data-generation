#!/usr/bin/env node
/**
 * Convert JSON question data to PostgreSQL INSERT statements
 * Usage:
 *   node json_to_sql_insert.js input.json output.sql
 *   node json_to_sql_insert.js < input.json > output.sql
 *   cat input.json | node json_to_sql_insert.js
 */

const fs = require('fs');
const path = require('path');

function escapeSqlString(value) {
  if (value === null || value === undefined) {
    return 'NULL';
  }
  if (typeof value === 'boolean') {
    return value ? 'true' : 'false';
  }
  if (typeof value === 'number') {
    return String(value);
  }
  // Escape single quotes by doubling them
  const escaped = String(value).replace(/'/g, "''");
  return `'${escaped}'`;
}

function convertOptionsToJsonb(options) {
  if (!options || !Array.isArray(options)) {
    return 'NULL';
  }
  const jsonStr = JSON.stringify(options);
  const escaped = jsonStr.replace(/'/g, "''");
  return `'${escaped}'::jsonb`;
}

function convertArrayToPostgres(arr) {
  if (!arr || !Array.isArray(arr) || arr.length === 0) {
    return "'{}' ::integer[]";
  }
  // Handle array of integers
  if (arr.every(x => typeof x === 'number')) {
    return `'{${arr.join(',')}}'::integer[]`;
  }
  // Handle array of text
  const escaped = arr
    .map(item => String(item).replace(/'/g, "''"))
    .map(item => `"${item}"`)
    .join(',');
  return `'{${escaped}}'::text[]`;
}

function questionsToInsertStatements(questions, tableName = 'public.question_bank') {
  if (!questions || !Array.isArray(questions)) {
    return '';
  }

  const statements = [];
  const timestamp = new Date().toISOString();

  // Start transaction
  statements.push('BEGIN;');
  statements.push('');
  statements.push('-- Generated SQL INSERT statements from JSON');
  statements.push(`-- Generated at: ${timestamp}`);
  statements.push(`-- Total questions: ${questions.length}`);
  statements.push('');

  // Column mapping
  const columnMapping = {
    id: 'id',
    text: 'text',
    type: 'type',
    options: 'options',
    correct_answer: 'correct_answer',
    explanation: 'explanation',
    difficulty: 'difficulty',
    module_id: 'module_id',
    quiz_id: 'quiz_id',
    index: 'index',
    created_at: 'created_at',
    modified_at: 'modified_at',
    is_deprecated: 'is_deprecated',
  };

  // Generate INSERT statements
  questions.forEach((q, idx) => {
    const columns = [];
    const values = [];

    Object.entries(columnMapping).forEach(([jsonKey, dbCol]) => {
      if (jsonKey in q) {
        columns.push(dbCol);
        const value = q[jsonKey];

        // Handle special column types
        if (jsonKey === 'options') {
          values.push(convertOptionsToJsonb(value));
        } else if (jsonKey === 'correct_answer') {
          values.push(convertArrayToPostgres(value));
        } else if (['created_at', 'modified_at'].includes(jsonKey)) {
          // Convert to PostgreSQL timestamp format
          if (value) {
            values.push(`'${value}'::timestamp`);
          } else {
            values.push('NOW()');
          }
        } else if (jsonKey === 'is_deprecated') {
          values.push(value ? 'true' : 'false');
        } else {
          values.push(escapeSqlString(value));
        }
      }
    });

    // Build INSERT statement
    const columnsStr = columns.join(',\n  ');
    const valuesStr = values.join(',\n  ');

    const insertStmt = `INSERT INTO ${tableName} (
  ${columnsStr}
) VALUES (
  ${valuesStr}
) ON CONFLICT (id) DO NOTHING;`;

    statements.push(insertStmt);
    if (idx < questions.length - 1) {
      statements.push('');
    }
  });

  statements.push('');
  statements.push('-- Verification Query');
  statements.push(`SELECT COUNT(*) as inserted_count FROM ${tableName};`);
  statements.push('');
  statements.push('COMMIT;');

  return statements.join('\n');
}

async function main() {
  const args = process.argv.slice(2);
  let inputFile = null;
  let outputFile = null;
  let tableName = 'public.question_bank';

  // Parse arguments
  for (let i = 0; i < args.length; i++) {
    if (args[i] === '-o' || args[i] === '--output') {
      outputFile = args[++i];
    } else if (args[i] === '-t' || args[i] === '--table') {
      tableName = args[++i];
    } else if (!inputFile) {
      inputFile = args[i];
    }
  }

  try {
    let inputData;

    // Read input
    if (inputFile) {
      inputData = fs.readFileSync(inputFile, 'utf-8');
    } else {
      // Read from stdin
      inputData = fs.readFileSync(0, 'utf-8');
    }

    // Parse JSON
    const questions = JSON.parse(inputData);
    const questionsArray = Array.isArray(questions) ? questions : [questions];

    // Convert to SQL
    const sql = questionsToInsertStatements(questionsArray, tableName);

    // Write output
    if (outputFile) {
      fs.writeFileSync(outputFile, sql, 'utf-8');
      console.error(`✅ Successfully converted ${questionsArray.length} questions to SQL INSERT statements`);
      console.error(`📁 Output written to: ${outputFile}`);
    } else {
      console.log(sql);
      console.error(`✅ Successfully converted ${questionsArray.length} questions to SQL INSERT statements`);
    }
  } catch (error) {
    if (error.code === 'ENOENT') {
      console.error(`❌ File not found: ${error.path}`);
    } else if (error instanceof SyntaxError) {
      console.error(`❌ Invalid JSON: ${error.message}`);
    } else {
      console.error(`❌ Error: ${error.message}`);
    }
    process.exit(1);
  }
}

main();
