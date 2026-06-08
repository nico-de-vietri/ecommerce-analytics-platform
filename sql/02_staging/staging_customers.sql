DROP TABLE IF EXISTS staging.customers;

CREATE TABLE IF NOT EXISTS staging.customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix INTEGER,
    customer_city TEXT,
    customer_state TEXT
);
