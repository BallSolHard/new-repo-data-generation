#!/bin/bash

# Direct PostgreSQL connection (non-pooler)
HOST="db.prpnsouhnycwsqkxocks.supabase.co"
PORT="5432"
USER="postgres"
DBNAME="postgres"
PASSWORD="njmgyw5td5bslKTS"

BACKUP_FILE="backup_$(date +%Y%m%d_%H%M%S).sql"

echo "Attempting connection to: $HOST"
echo "User: $USER"
echo "Database: $DBNAME"
echo ""

export PGPASSWORD="$PASSWORD"

# Try direct connection first
echo "Testing connection..."
psql -h "$HOST" -U "$USER" -d "$DBNAME" -c "SELECT VERSION();" 2>&1

if [ $? -eq 0 ]; then
    echo "✓ Connection successful! Starting dump..."
    pg_dump -h "$HOST" -U "$USER" -d "$DBNAME" > "$BACKUP_FILE"
    
    if [ $? -eq 0 ]; then
        SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
        echo "✓ Backup completed: $BACKUP_FILE ($SIZE)"
    else
        echo "✗ pg_dump failed"
    fi
else
    echo "✗ Connection failed"
fi

unset PGPASSWORD
