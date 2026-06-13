SELECT
    product_category_name,
    revenue
FROM analytics.mart_product_category
WHERE product_category_name IS NOT NULL
ORDER BY revenue DESC
LIMIT 10;