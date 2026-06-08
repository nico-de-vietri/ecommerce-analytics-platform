TRUNCATE TABLE staging.products;

\copy staging.products FROM 'data/raw/olist_products_dataset.csv' WITH (FORMAT csv, HEADER true);
