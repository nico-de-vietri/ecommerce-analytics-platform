
#!/bin/bash

set -e

DB="ecommerce"
USER="postgres"
HOST="localhost"
PORT="5433"

echo "================================="
echo " Ecommerce ELT Pipeline"
echo "================================="

echo ""
echo "[1/3] Creating schemas..."
psql -h $HOST -p $PORT -U $USER -d $DB \
    -f sql/01_setup/create_schemas.sql

echo ""
echo "[2/3] Creating staging tables..."
for file in sql/02_staging/*.sql
do
    echo "Running $file"
    psql -h $HOST -p $PORT -U $USER -d $DB -f "$file"
done

echo ""
echo "[3/3] Loading data..."
for file in sql/03_load/*.sql
do
    echo "Running $file"
    psql -h $HOST -p $PORT -U $USER -d $DB -f "$file"
done

echo ""
echo "[3/3] Checkinging data..."
for file in sql/04_quality_check/*.sql
do
    echo "Running $file"
    psql -h $HOST -p $PORT -U $USER -d $DB -f "$file"
done


echo ""
echo "Pipeline completed successfully."
