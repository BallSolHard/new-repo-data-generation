#!/bin/bash

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}PostgreSQL pg_dump Complete Guide${NC}"
echo "════════════════════════════════════════════════"
echo ""

# Your credentials
PASSWORD="njmgyw5td5bslKTS"
USER="postgres"
DBNAME="postgres"
PROJECT_REF="prpnsouhnycwsqkxocks"
BACKUP_FILE="backup_$(date +%Y%m%d_%H%M%S).sql"

# Method 1: Using environment variable (MOST RELIABLE)
echo -e "${YELLOW}METHOD 1: Using PGPASSWORD environment variable${NC}"
echo "Command:"
echo "export PGPASSWORD='$PASSWORD'"
echo "pg_dump -h db.$PROJECT_REF.supabase.co -U $USER -d $DBNAME > $BACKUP_FILE"
echo ""
echo "Full one-liner:"
echo -e "${GREEN}PGPASSWORD='$PASSWORD' pg_dump -h db.$PROJECT_REF.supabase.co -U $USER -d $DBNAME > $BACKUP_FILE${NC}"
echo ""
echo "════════════════════════════════════════════════"
echo ""

# Method 2: Using connection string
echo -e "${YELLOW}METHOD 2: Using PostgreSQL connection string${NC}"
DB_URL="postgresql://$USER:$PASSWORD@db.$PROJECT_REF.supabase.co:5432/$DBNAME"
echo "Connection string:"
echo "$DB_URL"
echo ""
echo "Command:"
echo -e "${GREEN}pg_dump '$DB_URL' > $BACKUP_FILE${NC}"
echo ""
echo "════════════════════════════════════════════════"
echo ""

# Method 3: Using .pgpass file (most secure for repeated use)
echo -e "${YELLOW}METHOD 3: Using .pgpass file (Secure method)${NC}"
echo "Create ~/.pgpass file with:"
echo "db.$PROJECT_REF.supabase.co:5432:$DBNAME:$USER:$PASSWORD"
echo ""
echo "Then run:"
echo -e "${GREEN}pg_dump -h db.$PROJECT_REF.supabase.co -U $USER -d $DBNAME > $BACKUP_FILE${NC}"
echo ""
echo "════════════════════════════════════════════════"
echo ""

# Now run Method 1 (most reliable)
echo -e "${YELLOW}EXECUTING METHOD 1 NOW...${NC}"
echo ""

export PGPASSWORD="$PASSWORD"

# Test connection first
echo "Testing connection..."
psql -h "db.$PROJECT_REF.supabase.co" -U "$USER" -d "$DBNAME" -c "SELECT version();" 2>&1

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Connection successful!${NC}"
    echo ""
    echo "Starting pg_dump..."
    echo "Output file: $BACKUP_FILE"
    echo ""
    
    # Run the actual dump
    pg_dump -h "db.$PROJECT_REF.supabase.co" -U "$USER" -d "$DBNAME" > "$BACKUP_FILE" 2>&1
    
    if [ $? -eq 0 ]; then
        SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
        LINES=$(wc -l < "$BACKUP_FILE")
        echo ""
        echo -e "${GREEN}✓ Backup completed successfully!${NC}"
        echo "File: $BACKUP_FILE"
        echo "Size: $SIZE"
        echo "Lines: $LINES"
    else
        echo -e "${RED}✗ pg_dump failed${NC}"
        echo "Check if password is correct"
    fi
else
    echo -e "${RED}✗ Connection failed${NC}"
    echo "Possible issues:"
    echo "  1. Password is incorrect"
    echo "  2. Network/firewall issue"
    echo "  3. Database is down"
    echo ""
    echo "Try testing with:"
    echo "PGPASSWORD='$PASSWORD' psql -h db.$PROJECT_REF.supabase.co -U $USER -d $DBNAME -c 'SELECT 1;'"
fi

unset PGPASSWORD
