
#!/bin/bash

set -e

RUN_ID=$(date +%Y%m%d_%H%M%S)



DB="ecommerce"
USER="postgres"
HOST="localhost"
PORT="5433"

echo "================================="
echo " Ecommerce ELT Pipeline"
echo "================================="
echo "Pipeline Run ID: $RUN_ID"

echo ""
echo "[1/4] Creating schemas..."
for file in sql/01_setup/*.sql
do
    echo "Running $file"
    psql -h $HOST -p $PORT -U $USER -d $DB -f "$file"
done


echo ""
echo "[2/4] Creating staging tables..."
for file in sql/02_staging/*.sql
do
    echo "Running $file"
    psql -h $HOST -p $PORT -U $USER -d $DB -f "$file"
done

echo ""
echo "[3/4] Loading data..."
for file in sql/03_load/*.sql
do
    echo "Running $file"
    psql -h $HOST -p $PORT -U $USER -d $DB -f "$file"
done





echo ""
echo "[3/4] Checkinging data..."
for file in sql/04_quality_check/*.sql
do
    echo "Running $file"
    psql -v ON_ERROR_STOP=1 -v run_id="$RUN_ID" -h $HOST -p $PORT -U $USER -d $DB -f "$file"
done


echo ""
echo "Pipeline completed successfully."
