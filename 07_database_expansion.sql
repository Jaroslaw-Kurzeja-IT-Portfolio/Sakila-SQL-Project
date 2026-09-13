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

# 7.3 Assign employees to departments using a FOREIGN KEY.

# 7.4 Verify that every employee is correctly assigned to an existing department.

# 7.5 Add several new employees and assign them to departments.

# 7.6 The company changes its requirements: every employee must have an assigned department. Modify the structure so that the database enforces this rule.

# 7.7 Try to assign an employee to a non-existent department and check whether the database blocks the operation.

# 7.8 The company is closing one department. Protect employee data from loss or incorrect assignment and make the change according to the defined rule.

# 7.9 Add a CHECK constraint to a selected table that represents a real business rule, and test it with both a valid and an invalid value.

# 7.10 Add a DEFAULT where a missing value should have a defined meaning, then test its behavior during INSERT.
