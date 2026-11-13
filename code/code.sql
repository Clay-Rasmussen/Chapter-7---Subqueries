/*
Chapter 7: Subqueries
Name: Clay Rasmussen 
Date: 
GitHub URL: https://github.com/Clay-Rasmussen/Chapter-7---Subqueries
*/

/*
Clay Rasmussen
Query 1: WHERE subquery returning one value
Write a query that uses a subquery in the WHERE clause to count the number of payments that are greater than the
average.
*/
SELECT COUNT(*) AS payments_above_avg
FROM payment
WHERE amount > (
	SELECT AVG(amount)
    FROM payment
);    

/*
Clay Rasmussen
Query 2: WHERE clause using IN operator subquery returning a list
2.A Write a query that uses a subquery in the WHERE clause using the IN operator to displays all payments for
customers associated with store id 2. Order by customer id and payment date
*/
-- A
SELECT payment_id, customer_id, staff_id, rental_id, amount
FROM payment
WHERE customer_id IN (
    SELECT customer_id
    FROM customer
    WHERE store_id = 2
)
ORDER BY customer_id, payment_date;

-- B   Rewrite the query to use a INNER JOIN (default join type) instead of a subquery

SELECT p.payment_id, p.customer_id, p.staff_id, p.rental_id, p.amount
FROM payment p 
JOIN customer c 
	ON p.customer_id = c.customer_id
WHERE c.store_id = 2
ORDER BY p.customer_id, p.payment_date;
