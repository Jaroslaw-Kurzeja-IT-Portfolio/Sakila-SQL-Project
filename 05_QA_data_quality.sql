# Stage 5 — QA and Problem Detection

# 5.1 Check whether there are any customers without an address.
SHOW FULL TABLES;
SELECT * FROM customer;
SELECT * FROM address;

SELECT customer_id FROM customer
WHERE address_id IS NULL;

SELECT
    customer.customer_id
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
WHERE address.address_id IS NULL;


# 5.2 Check whether there are duplicate customer email addresses.
SHOW FULL TABLES;
SELECT * FROM customer;

SELECT
    COUNT(email) AS `number of all emails`
FROM customer;

SELECT
    COUNT(DISTINCT email) `number of all email without copies`
FROM customer;

SELECT
    email,
    COUNT(customer_id) AS `email count`
FROM customer
GROUP BY email
HAVING `email count` > 1;

# 5.3 Check whether there are rentals assigned to non-existent customers.
SHOW FULL TABLES;
SELECT * FROM customer;
SELECT * FROM rental;

SELECT
    COUNT(rental.rental_id)
FROM customer
RIGHT JOIN rental
    ON customer.customer_id = rental.customer_id
WHERE customer.customer_id IS NULL;


# 5.4 Check whether there are payments without a corresponding customer.
SHOW FULL TABLES;
SELECT * FROM payment;
SELECT * FROM customer;

SELECT
    COUNT(payment.payment_id)
FROM payment
LEFT JOIN customer
    ON payment.customer_id = customer.customer_id
WHERE customer.customer_id IS NULL;


# 5.5 Check for NULL values in the customer table, specifically in first_name, last_name and email.
SHOW FULL TABLES;
SELECT * FROM customer;

SELECT
    first_name,
    last_name,
    email
FROM customer
WHERE
    first_name IS NULL OR
    last_name IS NULL OR
    email IS NULL;


# 5.6 Check whether there are rentals with a return_date earlier than the rental_date.
SHOW FULL TABLES;
SELECT * FROM rental;

SELECT
    COUNT(rental_id) AS `return_date before rental_date`
FROM rental
WHERE
    rental_date > return_date;


# 5.7 Check whether there are payments with a value of 0 or a negative value.
SHOW FULL TABLES;
SELECT * FROM payment;

SELECT
    payment_id
FROM payment
WHERE amount <= 0;

# another solution
#CREATE OR REPLACE VIEW payment_amount_categories AS
SELECT
    payment_id,
    amount,
    CASE
        WHEN amount < 0 THEN 'NEGATIVE'
        WHEN amount = 0 THEN 'ZERO'
        ELSE 'POSITIVE'
    END AS amount_category
FROM payment;

SELECT
    amount_category,
    COUNT(payment_id) AS number_of_payments
FROM payment_amount_categories
GROUP BY amount_category;


# 5.8 Check the consistency of the film → inventory → rental relationship.
SHOW FULL TABLES;
SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;

# czy w tabeli inventory istnieje rekord, który nie ma powiązania z film_id w tabeli film?
SELECT
    film.film_id,
    inventory.film_id
FROM inventory
LEFT JOIN film
    ON inventory.film_id = film.film_id
WHERE
    film.film_id IS NULL;

# czy w tabeli rental istnieje taki rekord, który nie ma powiązania do inventory_id w tabeli inventory?
SELECT
    inventory.inventory_id,
    rental.inventory_id
FROM rental
    LEFT JOIN inventory
    ON rental.inventory_id = inventory.inventory_id
WHERE
    inventory.inventory_id IS NULL;










