#!/bin/bash

DB="ecommerce"
USER="postgres"
PORT="5433"

echo "Starting SQL pipeline..."

echo "Creating schemas..."
psql -h localhost -p $PORT -U $USER -d $DB -f sql/01_setup/create_schemas.sql

echo " Creating staging tables..."
psql -h localhost -p $PORT -U $USER -d $DB -f sql/02_staging/staging_orders.sql
psql -h localhost -p $PORT -U $USER -d $DB -f sql/02_staging/staging_customers.sql
psql -h localhost -p $PORT -U $USER -d $DB -f sql/02_staging/staging_order_items.sql
psql -h localhost -p $PORT -U $USER -d $DB -f sql/02_staging/staging_payments.sql
psql -h localhost -p $PORT -U $USER -d $DB -f sql/02_staging/staging_products.sql

echo "Pipeline finished!"
