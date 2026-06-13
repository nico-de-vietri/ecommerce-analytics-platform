DROP TABLE IF EXISTS analytics.mart_customers;

CREATE TABLE analytics.mart_customers AS
SELECT
    c.customer_unique_id,

    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.payment_value) AS total_revenue,

    ROUND(AVG(o.payment_value), 2) AS avg_order_value,

    MIN(o.order_purchase_timestamp) AS first_order_date,
    MAX(o.order_purchase_timestamp) AS last_order_date

FROM analytics.fact_orders o
JOIN staging.customers c
    ON o.customer_id = c.customer_id

GROUP BY c.customer_unique_id;