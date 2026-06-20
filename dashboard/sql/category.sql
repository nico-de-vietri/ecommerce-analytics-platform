/*SELECT *
FROM analytics.mart_product_category
ORDER BY revenue DESC
LIMIT 10*/
SELECT
    LEFT(product_category_name, 20) AS product_category_name,
    revenue
FROM analytics.mart_product_category
ORDER BY revenue DESC
LIMIT 10;