TRUNCATE TABLE staging.order_items;

\copy staging.order_items FROM 'data/raw/olist_order_items_dataset.csv' WITH (FORMAT csv, HEADER true);
