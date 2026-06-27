DROP TABLE IF EXISTS analytics.mart_product_category;

CREATE TABLE analytics.mart_product_category AS
SELECT
    p.product_category_name,

    COUNT(*) AS items_sold,

    COUNT(DISTINCT oi.order_id) AS orders,

    ROUND(SUM(oi.price)::numeric, 2) AS revenue,

    ROUND(AVG(oi.price)::numeric, 2) AS avg_item_price,

    ROUND(AVG(oi.freight_value)::numeric, 2) AS avg_freight,

    ROUND(
        (AVG(oi.freight_value) / NULLIF(AVG(oi.price), 0) * 100)::numeric,
        2
    ) AS freight_pct
FROM staging.order_items oi
JOIN staging.products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name;