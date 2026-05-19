-- Project 2: Revenue by Product Category and Customer State
-- Tables used: olist_orders, olist_order_items, olist_products, olist_customers
-- Business question: Which product categories drive the most revenue per region?

CREATE OR REPLACE TABLE ecommerce.olist_revenue_by_category AS

WITH base AS (
  SELECT
    o.order_id,
    oi.price,
    p.product_category_name,
    c.customer_state
  FROM ecommerce.olist_orders o
  LEFT JOIN ecommerce.olist_order_items oi ON o.order_id = oi.order_id
  LEFT JOIN ecommerce.olist_products p ON oi.product_id = p.product_id
  LEFT JOIN ecommerce.olist_customers c ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
    AND p.product_category_name IS NOT NULL
)

SELECT
  product_category_name,
  customer_state,
  COUNT(DISTINCT order_id) AS total_orders,
  ROUND(SUM(price), 2) AS total_revenue,
  ROUND(AVG(price), 2) AS avg_order_value
FROM base
GROUP BY product_category_name, customer_state
ORDER BY total_revenue DESC;
