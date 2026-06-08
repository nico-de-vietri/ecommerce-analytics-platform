TRUNCATE TABLE staging.customers;

\copy staging.customers  FROM 'data/raw/olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true);
