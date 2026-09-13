# MySQL / Sakila Project — Tasks

# Stage 0 — Database Setup and Exploration


# 0.1 Import the Sakila database structure.
SELECT DATABASE();


# 0.2 Import the data.


# 0.3 Check which database you are currently working with.
SHOW TABLES;

SELECT COUNT(*) FROM information_schema.tables
WHERE table_schema = 'sakila';

USE information_schema;
SHOW TABLES;

SELECT table_name FROM information_schema.tables
WHERE table_schema = 'information_schema';

SELECT COUNT(*) FROM information_schema.tables
WHERE table_schema = 'information_schema';

SELECT * FROM information_schema.columns;

DESCRIBE tables;
SHOW COLUMNS FROM tables;

SHOW CREATE TABLE tables;

SHOW CREATE TABLE aaa.aaa;


# 0.4 Check which tables are available in the Sakila database.

SELECT table_name FROM information_schema.tables
WHERE table_schema = 'sakila';

DESC actor;
DESC address;

# tabela 'adress' nie ma foregin key
SHOW CREATE TABLE address;

DESC film;
SHOW CREATE TABLE film;

SELECT CONCAT('SHOW CREATE TABLE `', TABLE_NAME, '`;')
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'sakila'
  AND TABLE_TYPE = 'BASE TABLE';


SHOW CREATE TABLE `actor`;
SHOW CREATE TABLE `address`;
SHOW CREATE TABLE `category`;
SHOW CREATE TABLE `city`;
SHOW CREATE TABLE `country`;
SHOW CREATE TABLE `customer`;
SHOW CREATE TABLE `film`;
SHOW CREATE TABLE `film_actor`;
SHOW CREATE TABLE `film_category`;
SHOW CREATE TABLE `film_text`;
SHOW CREATE TABLE `inventory`;
SHOW CREATE TABLE `language`;
SHOW CREATE TABLE `payment`;
SHOW CREATE TABLE `rental`;
SHOW CREATE TABLE `staff`;
SHOW CREATE TABLE `store`;


# 0.5 Check the structure of the "address" and "city" tables and determine how they are related.
# CONSTRAINT `fk_address_city`
	# FOREIGN KEY (`city_id`)
	# REFERENCES `city` (`city_id`)
    # ON DELETE RESTRICT
    # ON UPDATE CASCADE


# answer 0.6
# DDL: w MySQL Workbench można wygenerować skrypt DDL przez:
# Server → Data Export → wybranie schematu i tabel → Export to Self-Contained File.
# Otrzymujemy w ten sposób definicje tabel (CREATE TABLE),
# czyli informacje o ich strukturze, kolumnach, typach danych, kluczach, ograniczeniach i właściwościach.



# 0.6 Generate the DDL script for the Sakila tables and analyze its contents.
USE sakila_restore;
SELECT COUNT(*) FROM address;

USE sakila;

# 0.7 Create a backup of the Sakila database and restore the database from the backup.