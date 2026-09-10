# Stage 6 — Modifying Existing Data

# test 666
# 6.1 Add a test customer to Sakila.
SHOW FULL TABLES;
SELECT * FROM customer;
DESC customer;
SELECT * FROM address;
DESC address;
SELECT * FROM city;
DESC city;
SELECT * FROM country;
DESC country;

SELECT
    country_id,
    country
FROM country
WHERE country = 'Germany';

SELECT
    city, city_id, country_id
FROM city
WHERE city = 'Erlangen';

DELETE FROM city
WHERE city_id = 601;

INSERT INTO city
    (city, country_id)
VALUES ('Erlangen', 38);

SELECT * FROM address;
DESC address;

SELECT *
FROM address
WHERE address = '1 Bahnhofsplatz';

INSERT INTO address
    (address,
    district,
    city_id,
    phone,
    location)
VALUES (
'1 Bahnhofsplatz',
'Bavaria',
160,
805583457,
POINT(49.59611, 11.00194)
    );

UPDATE address
SET district = 'Bayern'
WHERE address_id = 606;

INSERT INTO customer
    (store_id,
    first_name,
    last_name,
    address_id)
VALUES (
1,
'Adidas',
'Puma',
606
    );

SELECT *
FROM customer
WHERE address_id = 606;

ALTER TABLE customer
MODIFY create_date DATETIME NOT NULL
DEFAULT CURRENT_TIMESTAMP;


# 6.2 Verify that the customer has been saved correctly.
SELECT *
FROM customer
WHERE address_id = 606;


# 6.3 Update the test customer's data.
UPDATE address
SET district = 'Bavaria'
WHERE address_id = 606;

UPDATE customer
SET first_name = 'Puma',
    last_name = 'Adidas'
WHERE customer_id = 600;


# 6.4 Verify the changes made to the customer data.
SELECT * FROM address
WHERE address_id = 606;

SELECT *
FROM customer
ORDER BY customer_id DESC
LIMIT 0, 1;
# customer_id = 600

# 6.5 Delete the test customer and verify the result.
DELETE FROM customer
WHERE customer_id = 600;

SELECT *
FROM customer
ORDER BY customer_id DESC
LIMIT 0, 1;


# 6.6 Make several changes within one transaction and roll them back using ROLLBACK.
SHOW FULL TABLES;
SELECT * FROM customer;

# Mary, Patricia, Linda

START TRANSACTION;

UPDATE customer
SET first_name = 'TEST'
WHERE customer_id = 1;

UPDATE customer
SET first_name = 'TEST'
WHERE customer_id = 2;

UPDATE customer
SET first_name = 'TEST'
WHERE customer_id = 3;

ROLLBACK;

# Additional Test: TRANSACTION, SAVEPOINT, ROLLBACK behavior:

# A. Transaction Rollback

# B. Transaction, SAVEPOINT and ROLLBACK TO

# C. Transaction, SAVEPOINT and RELEASE SAVEPOINT

# D. Transaction ×2 and Implicit COMMIT

CREATE TABLE transaction_test
    (id INT PRIMARY KEY,
    name VARCHAR(50));

INSERT INTO transaction_test (id, name)
VALUES
    (1, 'Adam'),
    (2, 'Beata'),
    (3, 'Celina');

SELECT * FROM transaction_test;

# START
START TRANSACTION;

UPDATE transaction_test
SET name = 'TEST'
WHERE id = 1;

SAVEPOINT punkt1;

UPDATE transaction_test
SET name = 'TEST'
WHERE id = 2;

SAVEPOINT punkt2;

UPDATE transaction_test
SET name = 'TEST'
WHERE id = 3;

RELEASE SAVEPOINT punkt1;

ROLLBACK TO punkt1;
ROLLBACK TO punkt2;

SELECT * FROM transaction_test;

ROLLBACK;
# END

DROP TABLE transaction_test;

# 6.7 Repeat the operation and commit the changes using COMMIT.
CREATE TABLE transaction_test
    (id INT PRIMARY KEY,
    name VARCHAR(50));

INSERT INTO transaction_test (id, name)
VALUES
    (1, 'Adam'),
    (2, 'Beata'),
    (3, 'Celina');

SELECT * FROM transaction_test;

# START
START TRANSACTION;

UPDATE transaction_test
SET name = 'TEST'
WHERE id = 1;

SAVEPOINT punkt1;

UPDATE transaction_test
SET name = 'TEST'
WHERE id = 2;

ROLLBACK TO punkt1;

UPDATE transaction_test
SET name = 'TEST'
WHERE id = 3;

SELECT * FROM transaction_test;

COMMIT;
# END

SELECT * FROM transaction_test;

ROLLBACK TO punkt1;


DROP TABLE transaction_test;

# 6.8 Attempt an operation that violates a FOREIGN KEY constraint and analyze the error.
SHOW FULL TABLES;
SELECT * FROM customer;
SELECT * FROM rental;

# A. INSERT - Child with Non-Existent Parent
INSERT INTO rental
    (customer_id, inventory_id, staff_id, rental_date, return_date, last_update)
VALUES
    (999, 1, 1, NOW(), NULL, NOW());

# constraint: `fk_rental_customer`

SELECT MAX(rental_id)
FROM rental;

# B. UPDATE - Change to Non-Existent Parent
UPDATE rental
SET customer_id = 999
WHERE rental_id = 1;

# constraint: `fk_rental_customer`

SELECT MAX(customer_id)
FROM customer;


# C. DELETE - Parent with Existing Children
DELETE FROM customer
WHERE customer_id = 1;

# constraint: `fk_payment_customer`


# 6.9 Attempt to violate a UNIQUE constraint and analyze the error.

# INSERT - Duplicate Unique Value
INSERT INTO rental
    (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES
    ('2005-05-24 22:53:30', 367, 130, '2005-05-26 22:04:30', 1);

SELECT
    rental_date, inventory_id, customer_id, return_date, staff_id
FROM rental
WHERE inventory_id = 367 AND customer_id = 130;

SHOW TRIGGERS LIKE 'rental';

# UNIQUE constraint: (rental_date, inventory_id, customer_id)
# INSERT did not raise a duplicate error because a BEFORE INSERT trigger
# automatically sets rental_date to the current timestamp.


# UPDATE - Duplicate Unique Value
UPDATE rental
SET rental_date = '2005-05-24 22:53:30'
WHERE rental_id = 16051;


# 6.10 Based on the test results, correct the query or data so that the operation completes successfully.

# Before
INSERT INTO rental
    (customer_id, inventory_id, staff_id, rental_date, return_date, last_update)
VALUES
    (999, 1, 1, NOW(), NULL, NOW());

# After - look at the  customer_id
INSERT INTO rental
    (customer_id, inventory_id, staff_id, rental_date, return_date, last_update)
VALUES
    (1, 1, 1, NOW(), NULL, NOW());

SELECT *
FROM rental
ORDER BY rental_id DESC
LIMIT 3;