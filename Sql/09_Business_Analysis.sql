/*
====================================================
09 - BUSINESS ANALYSIS
====================================================

Project:
Olist E-Commerce SQL Analytics Portfolio

Objective:
Use SQL to answer realistic business questions
using customers, orders and geographic data.

====================================================
*/


/*
----------------------------------------------------
1. Which customer states have the highest number
   of orders?
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
2. What are the top 5 customer states by number
   of orders?
----------------------------------------------------
*/

SELECT TOP 5 c.customer_state,
       COUNT(o.order_id) AS Total_Orders
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY Total_Orders DESC;


/*
----------------------------------------------------
3. Which cities have the highest number of customers?
----------------------------------------------------
*/

SELECT TOP 10 customer_city,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_city
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
4. Which customer states have more than 1,000
   customers?
----------------------------------------------------
*/

SELECT c.customer_state,
       COUNT(c.customer_id) AS Total_Customers
FROM dbo.customers AS c
GROUP BY c.customer_state
HAVING COUNT(c.customer_id) > 1000
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
5. Which customers have never placed an order?
----------------------------------------------------
*/

SELECT c.customer_id,
       c.customer_city,
       c.customer_state
FROM dbo.customers AS c
LEFT JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


/*
----------------------------------------------------
6. How many customers have placed at least one order
   in each state?
----------------------------------------------------
*/

SELECT c.customer_state,
       COUNT(DISTINCT c.customer_id) AS Total_Customers
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
7. What is the average geographic latitude
   for each customer state?
----------------------------------------------------
*/

SELECT c.customer_state,
       AVG(og.geolocation_lat) AS Avg_Geo_Lat
FROM dbo.customers AS c
INNER JOIN dbo.geo_location AS og
    ON c.customer_zip_code_prefix =
       og.geolocation_zip_code_prefix
GROUP BY c.customer_state
ORDER BY Avg_Geo_Lat;


/*
----------------------------------------------------
8. What is the average geographic longitude
   for each customer state?
----------------------------------------------------
*/

SELECT c.customer_state,
       AVG(og.geolocation_lng) AS Avg_Geo_Lng
FROM dbo.customers AS c
INNER JOIN dbo.geo_location AS og
    ON c.customer_zip_code_prefix =
       og.geolocation_zip_code_prefix
GROUP BY c.customer_state
ORDER BY Avg_Geo_Lng;


/*
----------------------------------------------------
9. Which customers have placed more than 3 orders?
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders
FROM dbo.orders
GROUP BY customer_id
HAVING COUNT(order_id) > 3
ORDER BY Total_Orders DESC;


/*
----------------------------------------------------
10. What percentage of orders are delivered?
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
11. How many orders are there for each order status?
----------------------------------------------------
*/

SELECT order_status,
       COUNT(order_id) AS Total_Orders
FROM dbo.orders
GROUP BY order_status
ORDER BY Total_Orders DESC;


/*
----------------------------------------------------
12. What are the top 10 customers by number of orders?
----------------------------------------------------
*/

SELECT TOP 10 customer_id,
       COUNT(order_id) AS Total_Orders
FROM dbo.orders
GROUP BY customer_id
ORDER BY Total_Orders DESC;


/*
----------------------------------------------------
13. Rank customers based on their number of orders.
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders,
       DENSE_RANK() OVER (
           ORDER BY COUNT(order_id) DESC
       ) AS Customer_Rank
FROM dbo.orders
GROUP BY customer_id;


/*
----------------------------------------------------
14. Which states have more than 10,000 orders?
----------------------------------------------------
*/

SELECT c.customer_state,
       COUNT(o.order_id) AS Total_Orders
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
HAVING COUNT(o.order_id) > 10000
ORDER BY Total_Orders DESC;


/*
----------------------------------------------------
15. Categorise customers based on number of orders.
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders,
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
GROUP BY customer_id;