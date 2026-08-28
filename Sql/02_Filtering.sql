/*
====================================================
02 - FILTERING DATA
====================================================

Project:
Olist E-Commerce SQL Analytics Portfolio

Objective:
Demonstrate filtering techniques to answer business
questions using SQL Server.

Skills Demonstrated:
- WHERE
- AND
- OR
- IN
- NOT
- BETWEEN
- LIKE
- IS NULL
- ORDER BY
- TOP

Author:
Rakiya Omeiza

====================================================
*/

/*
====================================================
02 - FILTERING DATA
====================================================

Project:
Olist E-Commerce SQL Analytics Portfolio

Objective:
Use filtering techniques to answer business questions
about the customer base.

Table:
dbo.customers

Skills Demonstrated:
- WHERE
- AND
- OR
- IN
- NOT IN
- <>
- LIKE
- IS NULL
- IS NOT NULL
- TOP
- ORDER BY
- ASC
- DESC

====================================================
*/


/*
----------------------------------------------------
1. Customers from SP
----------------------------------------------------
*/

SELECT *
FROM dbo.customers
WHERE customer_state = 'SP';


/*
----------------------------------------------------
2. Customers from SP who live in Sao Paulo
----------------------------------------------------
*/

SELECT *
FROM dbo.customers
WHERE customer_state = 'SP'
  AND customer_city = 'Sao Paulo';


/*
----------------------------------------------------
3. Customers from SP or RJ, ordered by city
----------------------------------------------------
*/

SELECT *
FROM dbo.customers
WHERE customer_state IN ('SP', 'RJ')
ORDER BY customer_city ASC;


/*
----------------------------------------------------
4. Customers from SP excluding Sao Paulo
----------------------------------------------------
*/

SELECT *
FROM dbo.customers
WHERE customer_state = 'SP'
  AND customer_city <> 'Sao Paulo';


/*
----------------------------------------------------
5. Customer IDs starting with A
----------------------------------------------------
*/

SELECT *
FROM dbo.customers
WHERE customer_id LIKE 'A%';


/*
----------------------------------------------------
6. Customer IDs containing A
----------------------------------------------------
*/

SELECT *
FROM dbo.customers
WHERE customer_id LIKE '%A%';


/*
----------------------------------------------------
7. Customer IDs ending with A
----------------------------------------------------
*/

SELECT *
FROM dbo.customers
WHERE customer_id LIKE '%A';


/*
----------------------------------------------------
8. Customer IDs with exactly one character
   between A and B
----------------------------------------------------
*/

SELECT *
FROM dbo.customers
WHERE customer_id LIKE 'A_B';


/*
----------------------------------------------------
9. Customers whose ID is not in SP
----------------------------------------------------
*/

SELECT customer_id
FROM dbo.customers
WHERE customer_state NOT IN ('SP');


/*
----------------------------------------------------
10. Customers from SP or RJ excluding Sao Paulo
----------------------------------------------------
*/

SELECT *
FROM dbo.customers
WHERE customer_state IN ('SP', 'RJ')
  AND customer_city <> 'Sao Paulo';


/*
----------------------------------------------------
11. Customers not from SP or RJ
----------------------------------------------------
*/

SELECT customer_id
FROM dbo.customers
WHERE customer_state NOT IN ('SP', 'RJ');


/*
----------------------------------------------------
12. Customers with missing city information
----------------------------------------------------
*/

SELECT customer_id
FROM dbo.customers
WHERE customer_city IS NULL;


/*
----------------------------------------------------
13. Customers with a recorded city
----------------------------------------------------
*/

SELECT customer_id
FROM dbo.customers
WHERE customer_city IS NOT NULL;


/*
----------------------------------------------------
14. 10 customers with highest customer IDs
----------------------------------------------------
*/

SELECT TOP 10 *
FROM dbo.customers
ORDER BY customer_id DESC;


/*
----------------------------------------------------
15. 10 SP customers with highest customer IDs
----------------------------------------------------
*/

SELECT TOP 10 *
FROM dbo.customers
WHERE customer_state = 'SP'
ORDER BY customer_id DESC;


