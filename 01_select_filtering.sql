# Stage 1 — SELECT and Filtering


# 1.1 Display the first and last names of all actors.
SELECT * FROM actor;
SELECT first_name, last_name FROM actor;
SELECT CONCAT(first_name, ' ', last_name) AS actors FROM actor;
SELECT COUNT(actor_id) AS `how many actors` FROM actor;


# 1.2 Find all actors with the last name WAHLBERG.
SELECT CONCAT(first_name, ' ', last_name) AS actors FROM actor
	WHERE last_name = 'WAHLBERG';
SELECT COUNT(actor_id) AS `how many WAHLBERG` FROM actor
	WHERE last_name = 'WAHLBERG';


# 1.3 Display all distinct actor last names, without duplicates.
SELECT DISTINCT last_name AS `different last names of actors` FROM actor;
SELECT
	COUNT(DISTINCT last_name) AS `how many different last names of actors`,
    COUNT(actor_id) AS `how many actors`
FROM actor;


# 1.4 Find films with a running time between 90 and 120 minutes.
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


# 1.5 Find films whose title starts with the letter A.
SELECT * FROM film;
SELECT title FROM film
	WHERE title LIKE 'A%'
    ORDER BY title DESC;
SELECT COUNT(title) FROM film
	WHERE title LIKE 'A%';


# 1.6 Display the 10 longest films.
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


# 1.7 Find films with a replacement cost greater than 25.
SELECT title, replacement_cost FROM film
	WHERE replacement_cost > 25
	ORDER BY replacement_cost DESC;

# answer 1.7 z gwiazdką 
SELECT
	COUNT(replacement_cost)
    AS `how many film have replacment cost above 25$`
FROM film
WHERE replacement_cost > 25;


# 1.8 Find customers whose last names start with the letters S–Z.
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