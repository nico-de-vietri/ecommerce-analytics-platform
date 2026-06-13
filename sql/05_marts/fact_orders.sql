DROP TABLE IF EXISTS analytics.fact_orders;

CREATE TABLE analytics.fact_orders AS

WITH items AS (
    SELECT
        order_id,
        COUNT(*) AS items_count,
        SUM(price) AS items_revenue,
        SUM(freight_value) AS freight_cost
    FROM staging.order_items
    GROUP BY order_id
),

payments AS (
    SELECT
        order_id,
        SUM(payment_value) AS payment_value
    FROM staging.payments
    GROUP BY order_id
)

SELECT
    o.order_id,

    -- customer identifiers
    o.customer_id,
    c.customer_unique_id,

    -- order attributes
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_customer_date,

    -- metrics
    COALESCE(p.payment_value, 0) AS payment_value,
    COALESCE(i.items_count, 0) AS items_count,
    COALESCE(i.items_revenue, 0) AS items_revenue,
    COALESCE(i.freight_cost, 0) AS freight_cost

FROM staging.orders o

LEFT JOIN staging.customers c
    ON o.customer_id = c.customer_id

LEFT JOIN items i
    ON o.order_id = i.order_id

LEFT JOIN payments p
    ON o.order_id = p.order_id;