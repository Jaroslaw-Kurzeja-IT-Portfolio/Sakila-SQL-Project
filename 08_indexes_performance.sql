# Stage 8 — Indexes and Performance

# 8.1 Check which indexes currently exist on the customer.last_name column. Then prepare a query that searches for customers with the last name SMITH.
SELECT * FROM customer;

SHOW INDEX FROM customer;
SHOW INDEXES FROM customer;
SHOW INDEX FROM film;
SHOW INDEX FROM address;
SHOW INDEX FROM staff;

SELECT *
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'sakila';

# Existing index found in the Sakila DDL:

# create index idx_fk_address_id
#    on sakila.customer (address_id);

# create index idx_fk_store_id
#    on sakila.customer (store_id);

# create index idx_last_name
#    on sakila.customer (last_name);

SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) `customer`
FROM customer
WHERE last_name = 'SMITH';


# 8.2 Run EXPLAIN for the prepared query and check whether MySQL uses an index on last_name.
EXPLAIN
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) `customer`
FROM customer
WHERE last_name = 'SMITH';

EXPLAIN
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) `customer`
FROM customer
WHERE first_name = 'MARY';


# 8.3 If there is no suitable index on last_name, create one.
CREATE INDEX idx_fk_first_name
    ON sakila.customer (first_name);

EXPLAIN
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) `customer`
FROM customer
WHERE first_name = 'MARY';

DROP INDEX idx_fk_first_name
    on sakila.customer;


# 8.4 Run EXPLAIN again for the same query and compare the result with the previous execution plan.

    # 8.3 Create an index on first_name
# See the CREATE INDEX statement above (8.3 created an index on first_name)

# Before creating the index: key = NULL
# After creating the index: key = idx_fk_first_name
# After dropping the index: key = NULL


# 8.5 Remove the index you created and verify that it has been removed.
DROP INDEX idx_fk_first_name
    on sakila.customer;

EXPLAIN
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) `customer`
FROM customer
WHERE first_name = 'MARY';


# 8.6 Explain in your own words why an index can speed up searching and what costs an index can have for the database.

# Benefit:
# An index can speed up searching because it allows the database
# to find the required data without checking all records one by one.
# It is especially useful for large tables.

# Cost:
# An index requires additional disk space and can slow down
# INSERT, UPDATE and DELETE operations because the index
# also has to be updated.
