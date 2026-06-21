WITH revenue_totals AS (

    SELECT
        SUM(payment_value) AS total_revenue
    FROM analytics.fact_orders

),

top_state AS (

    SELECT
        customer_state,
        revenue
    FROM analytics.mart_geography
    ORDER BY revenue DESC
    LIMIT 1

),

top_category AS (

    SELECT
        product_category_name,
        revenue,
        orders
    FROM analytics.mart_product_category
    ORDER BY revenue DESC
    LIMIT 1

),

repeat_rate AS (

    SELECT
        ROUND(
            100.0 *
            COUNT(*) FILTER (WHERE orders > 1)
            / COUNT(*),
            2
        ) AS repeat_customer_pct
    FROM (
        SELECT
            customer_unique_id,
            COUNT(*) AS orders
        FROM analytics.fact_orders
        GROUP BY customer_unique_id
    ) x

),

delivery_rate AS (

    SELECT
        ROUND(
            100.0 *
            SUM(
                CASE
                    WHEN order_status = 'delivered'
                    THEN 1
                    ELSE 0
                END
            )
            / COUNT(*),
            2
        ) AS delivery_success_rate
    FROM analytics.fact_orders

)

SELECT

    ts.customer_state AS top_state,

    ts.revenue AS top_state_revenue,

    ROUND(
        100.0 * ts.revenue / rt.total_revenue,
        2
    ) AS top_state_revenue_pct,

    tc.product_category_name AS top_category,

    tc.revenue AS top_category_revenue,

    tc.orders AS top_category_orders,

    ROUND(
        100.0 * tc.revenue / rt.total_revenue,
        2
    ) AS top_category_revenue_pct,

    rr.repeat_customer_pct,

    dr.delivery_success_rate

FROM top_state ts
CROSS JOIN top_category tc
CROSS JOIN revenue_totals rt
CROSS JOIN repeat_rate rr
CROSS JOIN delivery_rate dr;