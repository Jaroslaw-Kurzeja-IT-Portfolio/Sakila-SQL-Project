SELECT DATABASE();

# answer 0.3
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

# answer 0.4

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

# answer 0.6
# DDL: w MySQL Workbench można wygenerować skrypt DDL przez:
# Server → Data Export → wybranie schematu i tabel → Export to Self-Contained File.
# Otrzymujemy w ten sposób definicje tabel (CREATE TABLE),
# czyli informacje o ich strukturze, kolumnach, typach danych, kluczach, ograniczeniach i właściwościach.

# answer 0.5 
# CONSTRAINT `fk_address_city`
	# FOREIGN KEY (`city_id`)
	# REFERENCES `city` (`city_id`)
    # ON DELETE RESTRICT
    # ON UPDATE CASCADE

# answer 0.7
USE sakila_restore;
SELECT COUNT(*) FROM address;

USE sakila;

# answer 1.1
SELECT * FROM actor;
SELECT first_name, last_name FROM actor;
SELECT CONCAT(first_name, ' ', last_name) AS actors FROM actor;
SELECT COUNT(actor_id) AS `how many actors` FROM actor;

# answer 1.2
SELECT CONCAT(first_name, ' ', last_name) AS actors FROM actor
	WHERE last_name = 'WAHLBERG';
SELECT COUNT(actor_id) AS `how many WAHLBERG` FROM actor
	WHERE last_name = 'WAHLBERG';

#  answer 1.3
SELECT DISTINCT last_name AS `different last names of actors` FROM actor;
SELECT
	COUNT(DISTINCT last_name) AS `how many different last names of actors`,
    COUNT(actor_id) AS `how many actors`
FROM actor;

# answer 1.4
SELECT * FROM film;
DESC film;
SELECT `title` FROM film
	WHERE `length` >= 90 AND `length` <= 120 ;
SELECT `title` FROM film
	WHERE `length` BETWEEN 90 AND 120 ;

# answer 1.4 z gwiazdką    
SELECT
	(SELECT COUNT(`title`) FROM film WHERE `length` >= 90 AND `length` <= 120) AS `films 90-120 mins`,
    COUNT(`film_id`) AS `amount of all films`
FROM film;

# answer 1.4 z gwiazdką
CREATE VIEW film_length_90_120 AS
SELECT
	COUNT(film_id) AS `films 90-120`
FROM film
WHERE `length` BETWEEN 90 AND 120;

SELECT
	MAX(`film_length_90_120`.`films 90-120`) AS `films 90-120`,
	COUNT(film.film_id) AS `amount of all films`
FROM film_length_90_120, film;

# amswer 1.5
SELECT * FROM film;
SELECT title FROM film
	WHERE title LIKE 'A%'
    ORDER BY title DESC;
SELECT COUNT(title) FROM film
	WHERE title LIKE 'A%';

# answer 1.6
SELECT * FROM film;
SELECT
	ROW_NUMBER() OVER(ORDER BY length DESC, title ASC) AS position,
    title,
    CONCAT(length, ' mins') AS `length of film`
    FROM film
ORDER BY length DESC
LIMIT 0, 10;

# answer 1.6 z gwiazdką
SELECT
	CONCAT(MAX(length), ' mins') AS `the longest film`,
    CONCAT(MIN(length), ' mins') AS `the shortest film`,
	CONCAT(ROUND(AVG(length), 0), ' mins') AS `avrerage duration of all films`
FROM film;

# answer 1.7
SELECT title, replacement_cost FROM film
	WHERE replacement_cost > 25
	ORDER BY replacement_cost DESC;

# answer 1.7 z gwiazdką 
SELECT
	COUNT(replacement_cost)
    AS `how many film have replacment cost above 25$`
FROM film
WHERE replacement_cost > 25;

# answer 1.8
SELECT * FROM  customer;
SELECT 
	CONCAT(last_name, ', ', first_name) AS `customers with last name S-Z`
    FROM customer
WHERE last_name REGEXP '^[S-Z]'
ORDER BY last_name, first_name;

SELECT 
	CONCAT(last_name, ', ', first_name) AS `customers with last name S-Z`
    FROM customer
WHERE LEFT(last_name, 1) BETWEEN 'S' AND 'Z'
ORDER BY last_name, first_name;