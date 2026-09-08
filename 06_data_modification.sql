# Stage 6 — Modifying Existing Data

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

# 6.3 Update the test customer's data.

# 6.4 Verify the changes made to the customer data.

# 6.5 Delete the test customer and verify the result.

# 6.6 Make several changes within one transaction and roll them back using ROLLBACK.

# 6.7 Repeat the operation and commit the changes using COMMIT.

# 6.8 Attempt an operation that violates a FOREIGN KEY constraint and analyze the error.

# 6.9 Attempt to violate a UNIQUE constraint and analyze the error.

# 6.10 Based on the test results, correct the query or data so that the operation completes successfully.