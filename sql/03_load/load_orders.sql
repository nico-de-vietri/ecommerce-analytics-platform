TRUNCATE TABLE staging.orders;

\copy staging.orders FROM 'data/raw/olist_orders_dataset.csv' WITH (FORMAT csv, HEADER true);
