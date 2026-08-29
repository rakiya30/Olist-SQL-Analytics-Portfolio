/*
====================================================
07 - WINDOW FUNCTIONS
====================================================

Project:
Olist E-Commerce SQL Analytics Portfolio

Objective:
Use window functions to rank customers and calculate
running totals while keeping individual rows.

Skills Demonstrated:
- RANK()
- DENSE_RANK()
- SUM() OVER()
- ORDER BY
- COUNT()
- GROUP BY

====================================================
*/


/*
----------------------------------------------------
1. Rank customers by total orders
    Most orders = Rank 1
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders,
       RANK() OVER (
           ORDER BY COUNT(order_id) DESC
       ) AS Customer_Rank
FROM dbo.orders
GROUP BY customer_id;


/*
----------------------------------------------------
2. Rank customers by total orders
    Fewest orders = Rank 1
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders,
       RANK() OVER (
           ORDER BY COUNT(order_id) ASC
       ) AS Customer_Rank
FROM dbo.orders
GROUP BY customer_id;


/*
----------------------------------------------------
3. Running total of orders across customers
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders,
       SUM(COUNT(order_id)) OVER (
           ORDER BY customer_id
       ) AS Running_Total
FROM dbo.orders
GROUP BY customer_id
ORDER BY customer_id;


/*
----------------------------------------------------
4. Rank customers using DENSE_RANK
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders,
       DENSE_RANK() OVER (
           ORDER BY COUNT(order_id) DESC
       ) AS Customer_Rank
FROM dbo.orders
GROUP BY customer_id;