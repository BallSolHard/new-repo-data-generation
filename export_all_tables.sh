#!/bin/bash

# Your Supabase credentials
PROJECT_URL="https://prpnsouhnycwsqkxocks.supabase.co"
SERVICE_ROLE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBycG5zb3Vobnljd3Nxa3hvY2tzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0NjU3OTkwNCwiZXhwIjoyMDYyMTU1OTA0fQ.IvxOo7I_71lNkkY8umXrM2EIW-CGmEX2WpusGpKmDzs"

# Timestamp for backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="supabase_backup_$TIMESTAMP"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Supabase Database Export via REST API                    ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
cd "$BACKUP_DIR"
echo ""

# List of tables to export (from the OpenAPI schema)
TABLES=(
    "user_xp"
    "user_topic_assessment"
    "lab_attempts"
    "mock_tests"
    "question_categories"
    "certifications"
    "assessment_answers"
    "quiz_unlocks"
    "lab_templates"
    "profiles"
    "daily_lesson"
    "mock_test_answers"
    "uploaded_content"
    "topics"
    "feature_alerts"
    "topic_feedback"
    "cloud_provider"
    "quiz_question"
    "module_skills"
    "skill_lab_validation"
    "question"
    "admin_metrics_snapshots"
    "quiz"
    "skills"
    "flashcards"
    "user_streaks"
    "flashcard_sets"
    "cancellation_feedback"
    "notes"
    "assessment_questions"
    "league_history"
    "flashcard_space_repetition"
    "modules"
    "user_progress"
    "assessments"
    "xp_transactions"
    "skillset"
    "mock_test_questions"
    "bug_reports"
    "conversion_metrix"
)

echo "Exporting ${#TABLES[@]} tables..."
echo ""

EXPORTED=0
FAILED=0

for TABLE in "${TABLES[@]}"; do
    echo -n "Exporting $TABLE... "
    
    RESPONSE=$(curl -s -w "\n%{http_code}" \
        -X GET "$PROJECT_URL/rest/v1/$TABLE?select=*" \
        -H "apikey: $SERVICE_ROLE_KEY" \
        -H "Authorization: Bearer $SERVICE_ROLE_KEY")
    
    # Extract HTTP code
    HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
    # Extract body
    BODY=$(echo "$RESPONSE" | sed '$d')
    
    if [ "$HTTP_CODE" = "200" ]; then
        echo "$BODY" > "${TABLE}.json"
        LINES=$(jq 'if type == "array" then length else 1 end' "${TABLE}.json" 2>/dev/null || echo "?")
        echo "✓ ($LINES records)"
        ((EXPORTED++))
    else
        echo "✗ (HTTP $HTTP_CODE)"
        echo "$BODY" > "${TABLE}_error.txt"
        ((FAILED++))
    fi
done

echo ""
echo "════════════════════════════════════════════════════════════"
echo "Export Summary:"
echo "  Successfully exported: $EXPORTED tables"
echo "  Failed: $FAILED tables"
echo "  Location: $(pwd)"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "Backup files created in: $BACKUP_DIR/"
echo ""
echo "To create a single SQL file from these backups, you can:"
echo "  1. Use: supabase db pull (if linked properly)"
echo "  2. Import each JSON file into your database"
echo "  3. Or download the full backup from Supabase dashboard"

