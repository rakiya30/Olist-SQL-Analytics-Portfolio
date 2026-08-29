/*
====================================================
08 - VIEWS
====================================================

Project:
Olist E-Commerce SQL Analytics Portfolio

Objective:
Create reusable SQL views for common business
analysis.

Skills Demonstrated:
- CREATE VIEW
- INNER JOIN
- COUNT
- GROUP BY
- ORDER BY
- Reusable queries

====================================================
*/


/*
----------------------------------------------------
1. Total orders by customer state
----------------------------------------------------
*/

CREATE VIEW dbo.vw_Orders_By_State
AS
SELECT c.customer_state,
       COUNT(o.order_id) AS Total_Orders
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state;


/*
Test View
*/

SELECT *
FROM dbo.vw_Orders_By_State
ORDER BY Total_Orders DESC;


/*
----------------------------------------------------
2. Total customers by state
----------------------------------------------------
*/

CREATE VIEW dbo.vw_Customers_By_State
AS
SELECT customer_state,
       COUNT(customer_id) AS Total_Customers
FROM dbo.customers
GROUP BY customer_state;


/*
Test View
*/

SELECT *
FROM dbo.vw_Customers_By_State
ORDER BY Total_Customers DESC;


/*
----------------------------------------------------
3. Total orders by customer
----------------------------------------------------
*/

CREATE VIEW dbo.vw_Customer_Order_Count
AS
SELECT c.customer_id,
       c.customer_city,
       c.customer_state,
       COUNT(o.order_id) AS Total_Orders
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.customer_city,
         c.customer_state;


/*
Test View
*/

SELECT *
FROM dbo.vw_Customer_Order_Count
ORDER BY Total_Orders DESC;