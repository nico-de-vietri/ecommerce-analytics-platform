DROP TABLE IF EXISTS analytics.mart_geography;

CREATE TABLE analytics.mart_geography AS
SELECT
    c.customer_state,

    COUNT(DISTINCT o.order_id) AS orders,

    COUNT(DISTINCT c.customer_unique_id) AS customers,

    ROUND(SUM(o.payment_value)::numeric, 2) AS revenue,

    ROUND(
        AVG(o.payment_value)::numeric,
        2
    ) AS avg_order_value

FROM analytics.fact_orders o
JOIN staging.customers c
    ON o.customer_id = c.customer_id

GROUP BY c.customer_state;