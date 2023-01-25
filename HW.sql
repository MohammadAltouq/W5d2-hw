-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name
FROM customer
INNER JOIN address
on customer.address_id = address.address_id
WHERE address.district = 'Texas';

SELECT first_name, last_name
FROM customer
WHERE address_id IN(SELECT address_id FROM address WHERE district ='Texas');

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT customer.first_name, customer.last_name, amount
FROM payment
INNER JOIN customer
on payment.customer_id = customer.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment GROUP BY customer_id 
	HAVING sum(amount) > 175);

-- 4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name
FROM customer
WHERE address_id IN (
	SELECT address_id FROM address WHERE city_id IN (
		SELECT city_id FROM city WHERE country_id IN (
			SELECT country_id FROM country WHERE country ='Nepal' )));
			
-- 5. Which staff member had the most transactions?
SELECT first_name, last_name
FROM staff
WHERE staff_id IN (
SELECT staff_id FROM payment 
GROUP BY staff_id   
ORDER BY count(staff_id) DESC LIMIT 1);

SELECT staff.first_name, staff.last_name, payment.staff_id, count(payment.staff_id)
FROM payment
LEFT JOIN staff
ON payment.staff_id = staff.staff_id
GROUP BY payment.staff_id, staff.first_name, staff.last_name ;

-- 6. How many movies of each rating are there? 


SELECT rating, count(title)
FROM film
GROUP BY rating
ORDER BY count(title) DESC;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id FROM payment WHERE amount > 6.99
	group BY customer_id HAVING COUNT(customer_id) = 1);
	
-- 8.How many free rentals did our stores give away
SELECT COUNT(amount)
FROM payment 
WHERE amount = 0.00;






