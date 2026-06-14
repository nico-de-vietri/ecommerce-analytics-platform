SELECT

(
    SELECT customer_state
    FROM analytics.mart_geography
    ORDER BY revenue DESC
    LIMIT 1
) AS top_state,

(
    SELECT revenue
    FROM analytics.mart_geography
    ORDER BY revenue DESC
    LIMIT 1
) AS top_state_revenue,

(
    SELECT product_category_name
    FROM analytics.mart_product_category
    ORDER BY revenue DESC
    LIMIT 1
) AS top_category,

(
    SELECT revenue
    FROM analytics.mart_product_category
    ORDER BY revenue DESC
    LIMIT 1
) AS top_category_revenue,

(
    SELECT orders
    FROM analytics.mart_product_category
    ORDER BY revenue DESC
    LIMIT 1
) AS top_category_orders,

(
    SELECT ROUND(
        100.0 *
        COUNT(*) FILTER (WHERE orders > 1)
        / COUNT(*),
        2
    )
    FROM (
        SELECT
            customer_unique_id,
            COUNT(*) AS orders
        FROM analytics.fact_orders
        GROUP BY customer_unique_id
    ) t
) AS repeat_customer_pct;