SELECT
    CASE
        WHEN orders = 1 THEN '1 Order'
        WHEN orders BETWEEN 2 AND 3 THEN '2-3 Orders'
        ELSE '4+ Orders'
    END AS segment,
    COUNT(*) customers
FROM (
    SELECT
        customer_unique_id,
        COUNT(*) orders
    FROM analytics.fact_orders
    GROUP BY customer_unique_id
) x
GROUP BY 1
ORDER BY 2 DESC;