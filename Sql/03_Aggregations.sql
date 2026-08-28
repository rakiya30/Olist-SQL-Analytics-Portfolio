/*
====================================================
03 - AGGREGATIONS
====================================================

Project:
Olist E-Commerce SQL Analytics Portfolio

Objective:
Use aggregate functions to analyse customer numbers,
customer distribution and business patterns.

Table:
dbo.customers

Skills Demonstrated:
- COUNT
- COUNT(DISTINCT)
- MIN
- MAX
- AVG
- GROUP BY
- HAVING
- TOP
- ORDER BY

====================================================
*/


/*
----------------------------------------------------
1. Total number of customers
----------------------------------------------------
*/

SELECT COUNT(*) AS Total_Customers
FROM dbo.customers;


/*
----------------------------------------------------
2. Number of unique cities
----------------------------------------------------
*/

SELECT COUNT(DISTINCT customer_city) AS Unique_Cities
FROM dbo.customers;


/*
----------------------------------------------------
3. Number of unique states
----------------------------------------------------
*/

SELECT COUNT(DISTINCT customer_state) AS Unique_States
FROM dbo.customers;


/*
----------------------------------------------------
4. Number of customers in each state
----------------------------------------------------
*/

SELECT customer_state,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_state
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
5. State with the most customers
----------------------------------------------------
*/

SELECT TOP 1 customer_state,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_state
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
6. Number of customers in each city
----------------------------------------------------
*/

SELECT customer_city,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_city
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
7. Cities with more than 1,000 customers
----------------------------------------------------
*/

SELECT customer_city,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_city
HAVING COUNT(customer_id) > 1000
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
8. Average number of customers per city
----------------------------------------------------
*/

SELECT AVG(Total_Customers * 1.0) AS Average_Customers_Per_City
FROM (
    SELECT customer_city,
           COUNT(customer_id) AS Total_Customers
    FROM dbo.customers
    GROUP BY customer_city
) AS City_Customers;


/*
----------------------------------------------------
9. Earliest and latest customer ID
----------------------------------------------------
*/

SELECT MIN(customer_id) AS Earliest_Customer_ID,
       MAX(customer_id) AS Latest_Customer_ID
FROM dbo.customers;


/*
----------------------------------------------------
10. States with more than 1,000 customers
----------------------------------------------------
*/

SELECT customer_state,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_state
HAVING COUNT(customer_id) > 1000;


/*
----------------------------------------------------
11. Top 5 cities by number of customers
----------------------------------------------------
*/

SELECT TOP 5 customer_city,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_city
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
12. States ordered from fewest to most customers
----------------------------------------------------
*/

SELECT customer_state,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_state
ORDER BY Total_Customers ASC;


/*
----------------------------------------------------
13. Total customers and unique cities
----------------------------------------------------
*/

SELECT COUNT(customer_id) AS Total_Customers,
       COUNT(DISTINCT customer_city) AS Unique_Cities
FROM dbo.customers;


/*
----------------------------------------------------
14. State with the highest number of customers
----------------------------------------------------
*/

SELECT TOP 1 customer_state,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_state
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
15. Five states with the fewest customers
----------------------------------------------------
*/

SELECT TOP 5 customer_state,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_state
ORDER BY Total_Customers ASC;