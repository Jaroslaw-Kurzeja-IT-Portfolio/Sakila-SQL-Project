# Stage 9 — VIEW and Database Objects

# 9.1 Find an existing VIEW in the Sakila database and analyze what it does.
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = 'sakila';

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS;

SELECT *
FROM INFORMATION_SCHEMA.VIEWS;


SHOW CREATE VIEW customer_list;
SHOW CREATE VIEW film_list;
SHOW CREATE VIEW nicer_but_slower_film_list;
SHOW CREATE VIEW staff_list;
SHOW CREATE VIEW sales_by_store;
SHOW CREATE VIEW sales_by_film_category;
SHOW CREATE VIEW actor_info;
SHOW CREATE VIEW film_length_90_120;
SHOW CREATE VIEW rentals_per_customer;
SHOW CREATE VIEW total_payment_amount_processed_by_staff;
SHOW CREATE VIEW rentals_per_film;
SHOW CREATE VIEW films_never_rented;
SHOW CREATE VIEW payment_amount_categories;

SELECT * FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = 'sakila';

# Purpose of a VIEW:
# VIEW is a form of ABSTRACTION that stores a reusable SQL query
# and provides a simplified way to access frequently used or complex data.
# It presents selected data from one or more tables in a predefined, convenient format,
# reducing repeated code and making queries easier to read and maintain.

# Cel VIEW:
# VIEW jest formą ABSTRAKCJI, która przechowuje wielokrotnego użytku zapytanie SQL
# i zapewnia uproszczony dostęp do często używanych lub złożonych danych.
# Prezentuje wybrane dane z jednej lub wielu tabel w ustalonym, wygodnym formacie,
# ograniczając powtarzanie kodu oraz ułatwiając jego czytanie i utrzymanie.


# 9.2 Create a VIEW showing each customer’s country and their total payments.
SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM payment;


CREATE VIEW customer_country AS
SELECT
    customer.customer_id AS `customer_id`,
    CONCAT(customer.first_name, ' ', customer.last_name) AS `customer name`,
    country.country AS `country`
FROM customer
JOIN address
    ON customer.address_id = address.address_id
JOIN city
    ON address.city_id = city.city_id
JOIN country
    ON city.country_id = country.country_id
ORDER BY customer.customer_id;


RENAME TABLE view_customer_country
TO customer_country;

RENAME TABLE customer_country
TO VIEW_customer_country;

DROP VIEW view_customer_country;

DROP VIEW customer_country;


SELECT
    customer_country.customer_id,
    customer_country.`customer name`,
    customer_country.`country`,
    SUM(payment.amount)
FROM customer_country
JOIN payment
    ON customer_country.customer_id = payment.customer_id
GROUP BY payment.customer_id
ORDER BY customer_country.customer_id;


# 9.3 Verify that the VIEW returns correct results.

# Case 1: Customer with the lowest customer_id
SELECT
    customer_country.customer_id,
    customer_country.`customer name`,
    customer_country.`country`,
    SUM(payment.amount)
FROM customer_country
JOIN payment
    ON customer_country.customer_id = payment.customer_id
WHERE customer_country.customer_id = 1
GROUP BY payment.customer_id
ORDER BY customer_country.customer_id;

SELECT
    MAX(customer_country.customer_id)
FROM customer_country;

# Case 2: Customer with the highest customer_id
SELECT
    customer_country.customer_id,
    customer_country.`customer name`,
    customer_country.`country`,
    SUM(payment.amount)
FROM customer_country
JOIN payment
    ON customer_country.customer_id = payment.customer_id
WHERE customer_country.customer_id =
      (SELECT
        MAX(customer_country.customer_id)
      FROM customer_country)
GROUP BY payment.customer_id
ORDER BY customer_country.customer_id;


# Case 3: Customers with the highest payments
CREATE VIEW customer_payment AS
SELECT
    customer.customer_id AS `customer_id`,
    SUM(payment.amount) AS `payments`
FROM customer
JOIN payment
    ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;


SELECT
    customer_country.customer_id,
    customer_country.`customer name`,
    customer_country.`country`,
    customer_payment.payments
FROM customer_country
JOIN customer_payment
    ON customer_country.customer_id = customer_payment.customer_id
WHERE customer_payment.payments =
      (SELECT
          MAX(customer_payment.payments)
       FROM customer_payment)
GROUP BY customer_payment.customer_id
ORDER BY customer_country.customer_id;

# Case 4: Customers with the lowest payments
SELECT
    customer_country.customer_id,
    customer_country.`customer name`,
    customer_country.`country`,
    customer_payment.payments
FROM customer_country
JOIN customer_payment
    ON customer_country.customer_id = customer_payment.customer_id
    WHERE customer_payment.payments =
      (SELECT
          MIN(customer_payment.payments)
       FROM customer_payment)
GROUP BY customer_payment.customer_id
ORDER BY customer_country.customer_id;


# 9.4 Modify the VIEW to include additional useful customer information.
CREATE OR REPLACE VIEW customer_country AS
SELECT
    customer.customer_id AS `customer_id`,
    CONCAT(customer.first_name, ' ', customer.last_name) AS `customer name`,
    CONCAT(country.country, ' (', city.city, ')') AS `country`
FROM customer
JOIN address
    ON customer.address_id = address.address_id
JOIN city
    ON address.city_id = city.city_id
JOIN country
    ON city.country_id = country.country_id
ORDER BY customer.customer_id;

SELECT
    customer_country.customer_id,
    customer_country.`customer name`,
    customer_country.`country`,
    SUM(payment.amount)
FROM customer_country
JOIN payment
    ON customer_country.customer_id = payment.customer_id
GROUP BY payment.customer_id
ORDER BY customer_country.customer_id;


# 9.5 Analyze an existing trigger, stored procedure, and function in the Sakila database.






