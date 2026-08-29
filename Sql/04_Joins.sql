/*
====================================================
04 - JOINS
====================================================

Project:
Olist E-Commerce SQL Analytics Portfolio

Objective:
Combine customer, order and geographic data to answer
business questions across multiple tables.

Tables Used:
- dbo.customers
- dbo.orders
- dbo.geo_location

Skills Demonstrated:
- INNER JOIN
- LEFT JOIN
- ON
- Table aliases
- COUNT
- COUNT(DISTINCT)
- GROUP BY
- HAVING
- ORDER BY
- TOP
- IS NULL

====================================================
*/


/*
----------------------------------------------------
1. Customers who have placed an order
----------------------------------------------------
*/

SELECT c.customer_id,
       c.customer_city,
       c.customer_state,
       o.order_id
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id;


/*
----------------------------------------------------
2. Customer ID, order ID and purchase timestamp
----------------------------------------------------
*/

SELECT c.customer_id,
       o.order_id,
       o.order_purchase_timestamp
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id;


/*
----------------------------------------------------
3. Total orders placed by each customer
----------------------------------------------------
*/

SELECT c.customer_id,
       COUNT(o.order_id) AS Total_Orders
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id;


/*
----------------------------------------------------
4. Customer city and total orders
----------------------------------------------------
*/

SELECT c.customer_id,
       c.customer_city,
       COUNT(o.order_id) AS Total_Orders
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.customer_city;


/*
----------------------------------------------------
5. Total orders by customer state
----------------------------------------------------
*/

SELECT c.customer_state,
       COUNT(o.order_id) AS Total_Orders
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state;


/*
----------------------------------------------------
6. Customer states with the most orders
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
7. All customers including those with no orders
----------------------------------------------------
*/

SELECT c.customer_id,
       c.customer_city,
       c.customer_state,
       o.order_id
FROM dbo.customers AS c
LEFT JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id;


/*
----------------------------------------------------
8. Customers who have never placed an order
----------------------------------------------------
*/

SELECT c.customer_id,
       c.customer_city,
       c.customer_state,
       o.order_id
FROM dbo.customers AS c
LEFT JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


/*
----------------------------------------------------
9. Customers who have placed an order
----------------------------------------------------
*/

SELECT c.customer_id,
       o.order_id,
       o.order_status
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id;


/*
----------------------------------------------------
10. Customers with at least one order by state
----------------------------------------------------
*/

SELECT c.customer_state,
       COUNT(DISTINCT o.customer_id) AS Total_Customers
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state;


/*
----------------------------------------------------
11. States with more than 1,000 customers
     who have placed an order
----------------------------------------------------
*/

SELECT c.customer_state,
       COUNT(DISTINCT o.customer_id) AS Total_Customers
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
HAVING COUNT(DISTINCT o.customer_id) > 1000;


/*
----------------------------------------------------
12. Customer geographic location
----------------------------------------------------
*/

SELECT c.customer_id,
       c.customer_city,
       c.customer_state,
       og.geolocation_lat,
       og.geolocation_lng
FROM dbo.customers AS c
INNER JOIN dbo.geo_location AS og
    ON c.customer_zip_code_prefix =
       og.geolocation_zip_code_prefix;


/*
----------------------------------------------------
13. Average geographic latitude by state
----------------------------------------------------
*/

SELECT c.customer_state,
       AVG(og.geolocation_lat) AS Avg_Geo_Lat
FROM dbo.customers AS c
INNER JOIN dbo.geo_location AS og
    ON c.customer_zip_code_prefix =
       og.geolocation_zip_code_prefix
GROUP BY c.customer_state;


/*
----------------------------------------------------
14. Average geographic longitude by state
----------------------------------------------------
*/

SELECT c.customer_state,
       AVG(og.geolocation_lng) AS Avg_Geo_Lng
FROM dbo.customers AS c
INNER JOIN dbo.geo_location AS og
    ON c.customer_zip_code_prefix =
       og.geolocation_zip_code_prefix
GROUP BY c.customer_state;


/*
----------------------------------------------------
15. Customers with matching geographic locations
----------------------------------------------------
*/

SELECT c.customer_state,
       COUNT(c.customer_id) AS Total_Customers
FROM dbo.customers AS c
INNER JOIN dbo.geo_location AS og
    ON c.customer_zip_code_prefix =
       og.geolocation_zip_code_prefix
GROUP BY c.customer_state;


/*
----------------------------------------------------
16. Top 5 states by customers with matching
    geographic locations
----------------------------------------------------
*/

SELECT TOP 5 c.customer_state,
       COUNT(c.customer_id) AS Total_Customers
FROM dbo.customers AS c
INNER JOIN dbo.geo_location AS og
    ON c.customer_zip_code_prefix =
       og.geolocation_zip_code_prefix
GROUP BY c.customer_state
ORDER BY Total_Customers DESC;