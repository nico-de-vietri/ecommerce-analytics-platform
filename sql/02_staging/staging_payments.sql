DROP TABLE IF EXISTS staging.payments;

CREATE TABLE IF NOT EXISTS staging.payments (
    order_id TEXT,
    payment_sequential INTEGER,
    payment_type TEXT,
    payment_installments INTEGER,
    payment_value NUMERIC
);
