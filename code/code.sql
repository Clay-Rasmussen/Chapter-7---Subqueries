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


/*
Clay Rasmussen
Query 3: WHERE clause using the ALL operator subquery returning a list
3.A Write a query that uses a subquery in the WHERE clause using the ALL operator to display all customer's payments
where the amount is greater than all of customer 1's payments. Order by customer id and payment date.
*/
-- A
SELECT payment_id, customer_id, payment_date, amount 
FROM payment
WHERE amount > ALL (
    SELECT amount
    FROM payment
    WHERE customer_id = 1
)
ORDER BY customer_id, payment_date;

-- B     Rewrite the query to use a subquery using the MAX aggerated function instead of ALL operator.
SELECT payment_id, customer_id, payment_date, amount
FROM payment
WHERE amount > (
    SELECT MAX(amount)
    FROM payment
    WHERE customer_id = 1
)
ORDER BY customer_id, payment_date;


/*
Clay Rasmussen
Query 4: WHERE correlated subquery running multiple times (once for each outer
row)
4.A Write a query that uses the AVG aggerated function to display each customer's average amount paid.
*/
-- A Write a query that uses the AVG aggerated function to display each customer's average amount paid.
SELECT customer_id, AVG(amount) AS average_amount_paid
FROM payment
GROUP BY customer_id
ORDER BY customer_id;

-- B Write a query that uses a correlated subquery in the WHERE clause to count all customer's payments greater than the customer's average payment.
SELECT p.customer_id, COUNT(*) AS payments_above_avg
FROM payment AS p
WHERE p.amount > (
	SELECT AVG(p2.amount)
    FROM payment AS p2
    WHERE p2.customer_id = p.customer_id
)
GROUP BY p.customer_id
ORDER BY p.customer_id;


/*
Clay Rasmussen
Query 5: WHERE subquery using EXISTS operator returning a Boolean value
NOTE: create a new customer so that there is at least one customer without a payment
*/
-- A Write a query that uses a subquery in the WHERE clause with the NOT EXISTS operator for customers who do not have any payments. Order by customer id.




-- B Rewrite the query to use a LEFT JOIN instead of a subquery



/*
Clay Rasmussen
Query 6: SELECT subquery returning a single value
*/
-- A Write a query that uses a correlated subquery in the SELECT clause displaying each customer's MAX payment date. Order by customer id DESC.




-- B Rewrite the query to use a LEFT JOIN instead of a subquery






/*
Clay Rasmussen
Query 7: FROM subquery returning a inline view (temporary table)
*/
-- A Write a query that display the top customer based on total amount paid. To do this, group the payment table by customer, sort descending by total amount paid and limit the query to only display the first record.


-- B Write a query that displays all the payments for the top customer by joining 7.A query to the payment table sorting by payment date.
