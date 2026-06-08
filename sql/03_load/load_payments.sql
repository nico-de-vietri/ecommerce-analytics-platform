TRUNCATE TABLE staging.payments;

\copy staging.payments FROM 'data/raw/olist_order_payments_dataset.csv' WITH (FORMAT csv, HEADER true);
