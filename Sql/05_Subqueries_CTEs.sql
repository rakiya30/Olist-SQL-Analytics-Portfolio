/*
====================================================
05 - SUBQUERIES & CTEs
====================================================

Skills Demonstrated:
- Subqueries
- CTEs
- AVG
- COUNT
- GROUP BY
- HAVING
- Filtering CTE results

====================================================
*/


/*
----------------------------------------------------
1. Customers with more orders than the average
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders
FROM dbo.orders
GROUP BY customer_id
HAVING COUNT(order_id) >
(
    SELECT AVG(Total_Orders * 1.0)
    FROM
    (
        SELECT customer_id,
               COUNT(order_id) AS Total_Orders
        FROM dbo.orders
        GROUP BY customer_id
    ) AS Customer_Orders
);


/*
----------------------------------------------------
2. Customers with fewer orders than the average
----------------------------------------------------
*/

SELECT customer_id,
       COUNT(order_id) AS Total_Orders
FROM dbo.orders
GROUP BY customer_id
HAVING COUNT(order_id) <
(
    SELECT AVG(Total_Orders * 1.0)
    FROM
    (
        SELECT customer_id,
               COUNT(order_id) AS Total_Orders
        FROM dbo.orders
        GROUP BY customer_id
    ) AS Customer_Orders
);


/*
----------------------------------------------------
3. Total orders by customer state using a CTE
----------------------------------------------------
*/

WITH State_Orders AS
(
    SELECT c.customer_state,
           COUNT(o.order_id) AS Total_Orders
    FROM dbo.customers AS c
    INNER JOIN dbo.orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_state
)
SELECT *
FROM State_Orders;


/*
----------------------------------------------------
4. States with more than 10,000 orders
----------------------------------------------------
*/

WITH State_Orders AS
(
    SELECT c.customer_state,
           COUNT(o.order_id) AS Total_Orders
    FROM dbo.customers AS c
    INNER JOIN dbo.orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_state
)
SELECT *
FROM State_Orders
WHERE Total_Orders > 10000;