/*
====================================================
10 - FINAL ANALYSIS
====================================================

Project:
Olist E-Commerce SQL Analytics Portfolio

Objective:
Bring together SQL skills to produce key business
insights from the Olist customer and order data.

Key Areas:
- Customer distribution
- Order performance
- Customer engagement
- Order status
- Geographic analysis

====================================================
*/


/*
----------------------------------------------------
1. Total Customers
----------------------------------------------------
*/

SELECT COUNT(DISTINCT customer_id) AS Total_Customers
FROM dbo.customers;


/*
----------------------------------------------------
2. Total Orders
----------------------------------------------------
*/

SELECT COUNT(order_id) AS Total_Orders
FROM dbo.orders;


/*
----------------------------------------------------
3. Orders by Customer State
----------------------------------------------------
*/

SELECT c.customer_state,
       COUNT(o.order_id) AS Total_Orders
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY Total_Orders DESC;


/*
----------------------------------------------------
4. Top 10 Customer Cities
----------------------------------------------------
*/

SELECT TOP 10 customer_city,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_city
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
5. Order Status Breakdown
----------------------------------------------------
*/

SELECT order_status,
       COUNT(order_id) AS Total_Orders
FROM dbo.orders
GROUP BY order_status
ORDER BY Total_Orders DESC;


/*
----------------------------------------------------
6. Delivered Order Percentage
----------------------------------------------------
*/

SELECT
    COUNT(CASE
              WHEN order_status = 'delivered'
              THEN 1
          END) * 100.0 / COUNT(*) AS Delivered_Percentage
FROM dbo.orders;


/*
----------------------------------------------------
7. Top 10 Customers by Number of Orders
----------------------------------------------------
*/

SELECT TOP 10 customer_id,
       COUNT(order_id) AS Total_Orders
FROM dbo.orders
GROUP BY customer_id
ORDER BY Total_Orders DESC;


/*
----------------------------------------------------
8. Customers Who Have Never Ordered
----------------------------------------------------
*/

SELECT COUNT(*) AS Customers_With_No_Orders
FROM dbo.customers AS c
LEFT JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


/*
----------------------------------------------------
9. Customers by State
----------------------------------------------------
*/

SELECT customer_state,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_state
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
10. Customer Order Categories
----------------------------------------------------
*/

SELECT
    Customer_Type,
    COUNT(*) AS Number_of_Customers
FROM
(
    SELECT customer_id,
           CASE
               WHEN COUNT(order_id) = 1
                   THEN 'New Customer'
               WHEN COUNT(order_id) BETWEEN 2 AND 3
                   THEN 'Returning Customer'
               WHEN COUNT(order_id) > 3
                   THEN 'Loyal Customer'
               ELSE 'Other'
           END AS Customer_Type
    FROM dbo.orders
    GROUP BY customer_id
) AS Customer_Categories
GROUP BY Customer_Type
ORDER BY Number_of_Customers DESC;


/*
----------------------------------------------------
11. Customer Ranking
----------------------------------------------------
*/

SELECT TOP 20
       customer_id,
       COUNT(order_id) AS Total_Orders,
       DENSE_RANK() OVER (
           ORDER BY COUNT(order_id) DESC
       ) AS Customer_Rank
FROM dbo.orders
GROUP BY customer_id
ORDER BY Customer_Rank;


/*
----------------------------------------------------
12. Average Geographic Location by State
----------------------------------------------------
*/

SELECT c.customer_state,
       AVG(og.geolocation_lat) AS Avg_Geo_Lat,
       AVG(og.geolocation_lng) AS Avg_Geo_Lng
FROM dbo.customers AS c
INNER JOIN dbo.geo_location AS og
    ON c.customer_zip_code_prefix =
       og.geolocation_zip_code_prefix
GROUP BY c.customer_state
ORDER BY c.customer_state;