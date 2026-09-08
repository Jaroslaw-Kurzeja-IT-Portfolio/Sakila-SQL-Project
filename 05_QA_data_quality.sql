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

# 5.7 Check whether there are payments with a value of 0 or a negative value.

# 5.8 Check the consistency of the film → inventory → rental relationship.

# 5.9 Prepare an SQL test to verify that a new customer has been saved correctly.

# 5.10 Prepare SQL tests for customer data: valid data, missing required value, and UNIQUE constraint violation.