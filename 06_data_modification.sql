# Stage 6 — Modifying Existing Data

# test
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




# 6.7 Repeat the operation and commit the changes using COMMIT.





# 6.8 Attempt an operation that violates a FOREIGN KEY constraint and analyze the error.




# 6.9 Attempt to violate a UNIQUE constraint and analyze the error.





# 6.10 Based on the test results, correct the query or data so that the operation completes successfully.





