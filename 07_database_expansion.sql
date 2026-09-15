# Stage 7 — Database Expansion

# 7.1 The company wants to store additional information about employees. Add a new column to the staff table and populate it for existing employees.
SHOW FULL TABLES;
DESC staff;
SELECT * FROM staff;

ALTER TABLE staff
DROP COLUMN knows_sql;

#
ALTER TABLE staff
ADD COLUMN knows_sql
BOOLEAN;

ALTER TABLE staff
ADD COLUMN knows_sql
TINYINT(1) UNSIGNED;

ALTER TABLE staff
ADD COLUMN knows_sql
BOOLEAN NOT NULL;

ALTER TABLE staff
ADD COLUMN knows_sql
BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE staff
ADD COLUMN knows_sql
BOOLEAN NOT NULL DEFAULT TRUE;

ALTER TABLE staff
ADD COLUMN knows_sql
BOOLEAN NOT NULL DEFAULT 10;

#
ALTER TABLE staff
DROP COLUMN knows_sql;

SELECT * FROM staff;

#
ALTER TABLE staff
MODIFY COLUMN knows_sql
BOOLEAN NOT NULL DEFAULT 0;

ALTER TABLE staff
MODIFY COLUMN knows_sql
BOOLEAN NOT NULL DEFAULT 1;

# Updating Column Values
UPDATE staff
SET staff.knows_sql = TRUE
WHERE staff_id = 1;

UPDATE staff
SET staff.knows_sql = FALSE
WHERE staff_id = 2;

# BOOLEAN / TINYINT(1): -128  127
# TINYINT(1) UNSIGNED: 0  255
UPDATE staff
SET staff.knows_sql = 128
WHERE staff_id = 2;

SELECT * FROM staff;

# Other Column - Additional Exercise
ALTER TABLE staff
ADD COLUMN knows BOOLEAN;

ALTER TABLE staff
RENAME COLUMN knows TO knows_pyhton;

ALTER TABLE staff
DROP COLUMN knows_pyhton;


# 7.2 The company wants to divide employees into departments. Design and create a department table.
SHOW FULL TABLES;

CREATE TABLE department
    (department_id  INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE);

INSERT INTO department
    (name)
VALUES
    ('Management'),
    ('Customer Service'),
    ('IT');

SELECT * FROM department
ORDER BY department_id;

DROP TABLE department;

# 7.3 Assign employees to departments using a FOREIGN KEY.
SELECT * FROM staff;

ALTER TABLE staff
ADD COLUMN department_id INT;

ALTER TABLE staff
ADD CONSTRAINT fk_staff_department
    FOREIGN KEY (department_id)
    REFERENCES department(department_id);

#
ALTER TABLE staff
DROP CONSTRAINT fk_staff_department;

ALTER TABLE staff
DROP COLUMN department_id;

#
ALTER TABLE staff
ADD COLUMN department_id INT,
ADD CONSTRAINT fk_staff_department
    FOREIGN KEY (department_id)
    REFERENCES department(department_id);


# 7.4 Verify that every employee is correctly assigned to an existing department.
SELECT * FROM staff;

UPDATE staff
SET department_id = 2
WHERE staff_id = 1;

UPDATE staff
SET department_id = 2
WHERE staff_id = 2;

SELECT
    staff_id,
    department.name
FROM staff
JOIN department
    ON staff.department_id = department.department_id;


# 7.5 Add several new employees and assign them to departments.
SELECT * FROM staff;
DESC staff;

INSERT INTO staff
    (first_name, last_name, address_id, email, store_id, username, department_id)
VALUES ('Britney', 'Spears', 607, 'britney.spears@example.com', 1, 'bspears', 2),
       ('Michael', 'Jackson', 608, 'michael.jackson@example.com', 1, 'mjackson', 3),
       ('Michael', 'Jordan', 609, 'michael.jordan@example.com', 1, 'mjordan', 1),
       ('Luke', 'Skywalker', 610, 'luke.skywalker@example.com', 1, 'lskywalker', 2),
       ('Julius', 'Caesar', 611, 'jcaesar', 1, 'jcaesar', 3);

SELECT * FROM address
ORDER BY address_id DESC
LIMIT 5;

INSERT INTO address (address, district, city_id, phone, location)
VALUES ('1 Baby One More Time', 'California', 1, '555-0101', POINT(34.0522, -118.2437)),
       ('1 Smooth Criminal', 'California', 1, '555-0102', POINT(34.0522, -118.2437)),
       ('23 Basketball Avenue', 'Illinois', 2, '555-0103', POINT(41.8781, -87.6298)),
       ('1 May the Force Be With You', 'California', 1, '555-0104', POINT(34.0522, -118.2437)),
       ('1 Veni, Vidi, Vici', 'Lazio', 3, '555-0105', POINT(41.9028, 12.4964));

SELECT
    staff.staff_id,
    CONCAT(staff.first_name, ' ', staff.last_name),
    department.name
FROM staff
JOIN department
    ON staff.department_id = department.department_id
ORDER BY staff.staff_id;

# 7.6 The company changes its requirements: every employee must have an assigned department. Modify the structure so that the database enforces this rule.
ALTER TABLE staff
MODIFY COLUMN department_id
INT NOT NULL;

DESC staff;


# 7.7 Try to assign an employee to a non-existent department and check whether the database blocks the operation.
INSERT INTO staff
    (first_name, last_name, address_id, email, store_id, username, department_id)
VALUES
    ('R2-T2', 'C-3PO', 607, 'farfaraway@example.com', 1, 'robots', 777);


# 7.8 The company is closing one department. Protect employee data from loss or incorrect assignment and make the change according to the defined rule.

#1. Reassign all employees from Management to Customer Service.
SELECT
    staff_id
FROM staff
WHERE staff.department_id = 1;

UPDATE staff
SET staff.department_id  = 2
WHERE staff_id = 6;

#2. Verify that no employees are still assigned to Management.
SELECT
    staff_id
FROM staff
WHERE staff.department_id = 1;

#3. Delete the Management department.
SELECT * FROM department
ORDER BY department_id;

UPDATE department
SET name = NULL
WHERE name = 'Management';

DELETE FROM department
WHERE name = 'Management';

INSERT INTO department
    (department_id, name)
VALUES
    (1, 'Management');

SELECT * FROM department
ORDER BY department_id;


# 7.9 Add a CHECK constraint to a selected table that represents a real business rule, and test it with both a valid and an invalid value.
SELECT * FROM rental;
SELECT * FROM payment;

# Payment amount cannot be negative.
# Payment amount must be greater than or equal to zero.

# payment_id = 1 amount = 2.99

UPDATE payment
SET amount = - 2.99
WHERE payment_id = 1;

UPDATE payment
SET amount = 0.01
WHERE payment_id = 1;

UPDATE payment
SET amount = 0
WHERE payment_id = 1;

UPDATE payment
SET amount = 2.99
WHERE payment_id = 1;

ALTER TABLE payment
ADD CONSTRAINT chk_payment_amount
CHECK (amount >= 0);

SELECT * FROM payment;

# 7.10 Add a DEFAULT where a missing value should have a defined meaning, then test its behavior during INSERT.
SELECT * FROM film;
DESC film;

ALTER TABLE film
MODIFY COLUMN description
VARCHAR(1000) DEFAULT 'no description';

INSERT INTO film (title, language_id)
VALUES ('Star Wars Test', 1);

SELECT title, description
FROM film
WHERE title = 'Star Wars Test';

