/*
====================================================
06 - CASE STATEMENTS
====================================================

Project:
Olist E-Commerce SQL Analytics Portfolio

Objective:
Use CASE statements to categorise customers and
orders based on business rules.

Skills Demonstrated:
- CASE
- WHEN
- THEN
- ELSE
- END
- COUNT
- BETWEEN
- GROUP BY

====================================================
*/


/*
----------------------------------------------------
1. Categorise customers by number of orders
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders,
       CASE
           WHEN COUNT(order_id) > 5 THEN 'High'
           WHEN COUNT(order_id) BETWEEN 2 AND 5 THEN 'Medium'
           ELSE 'Low'
       END AS Customer_Category
FROM dbo.orders
GROUP BY customer_id;


/*
----------------------------------------------------
2. Categorise orders by order status
----------------------------------------------------
*/

SELECT order_id,
       order_status,
       CASE
           WHEN order_status = 'delivered' THEN 'Completed'
           WHEN order_status = 'canceled' THEN 'Cancelled'
           WHEN order_status = 'shipped' THEN 'In Transit'
           ELSE 'Other'
       END AS Order_Category
FROM dbo.orders;


/*
----------------------------------------------------
3. Categorise customers by order frequency
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders,
       CASE
           WHEN COUNT(order_id) = 1 THEN 'New Customer'
           WHEN COUNT(order_id) BETWEEN 2 AND 3 THEN 'Returning Customer'
           WHEN COUNT(order_id) > 3 THEN 'Loyal Customer'
           ELSE 'Other'
       END AS Customer_Type
FROM dbo.orders
GROUP BY customer_id;