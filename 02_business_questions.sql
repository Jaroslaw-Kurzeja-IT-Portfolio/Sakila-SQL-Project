# Stage 2 — Business Questions


# 2.1 The company wants to know how many films are currently in the catalog.
SHOW TABLES;
SELECT COUNT(DISTINCT title) AS `Total number of films` FROM film;


# 2.2 Management wants to know the average film length.
SELECT
	CONCAT(MAX(length), ' mins') AS `the longest film`,
    CONCAT(MIN(length), ' mins') AS `the shortest film`,
	CONCAT(ROUND(AVG(length), 0), ' mins') AS `avrerage duration of all films`
FROM film;


# 2.3 Prepare information about the shortest and longest film.
 SELECT
	CONCAT(MAX(length), ' mins') AS `the longest film`,
    CONCAT(MIN(length), ' mins') AS `the shortest film`,
	CONCAT(ROUND(AVG(length), 0), ' mins') AS `avrerage duration of all films`
FROM film;


# 2.4 Prepare a breakdown of the number of films in each category.
SELECT * FROM film;
SELECT * FROM category;
SELECT 	COUNT(`name`) AS 'number of film category' FROM category;


# 2.5 Management wants to see only categories containing more than 60 films.
SELECT * FROM film_category;
SELECT
	category.name,
	COUNT(film_category.film_id) AS `how many films in category`
FROM film_category
JOIN category
	ON  film_category.category_id = category.category_id
GROUP BY category.category_id, category.name
HAVING `how many films in category` > 60
ORDER BY name ASC
# ORDER BY `how many films in category` DESC
;


# 2.6 Calculate the average film length for each category.
SELECT * FROM film_category;
SELECT * FROM category;
SELECT * FROM film;

SELECT
	category.name,
    CONCAT(ROUND(AVG(film.length), 0), ' mins')  AS `average length of category`
FROM category
JOIN film_category
	ON category.category_id = film_category.category_id
JOIN film
	ON film_category.film_id = film.film_id
GROUP BY category.name;


# 2.7 Determine which category has the highest average film length.
SELECT 
	MAX(`average length of category`) AS `category with the longest average of length`
FROM
(SELECT
	category.name,
    CONCAT(ROUND(AVG(film.length), 0), ' mins') AS `average length of category`
FROM category
JOIN film_category
	ON category.category_id = film_category.category_id
JOIN film
	ON film_category.film_id = film.film_id
GROUP BY category.name)
AS `average length of each category`;


# 2.8 Prepare a breakdown of active and inactive customers.
SHOW TABLES;
SHOW FULL TABLES;
SELECT * FROM customer;
SELECT * FROM customer_list;

# zwraca ilość aktywnych i nieaktywnych klientów:
SELECT
	COUNT(CONCAT(first_name, ' ', last_name)) AS `customer`
FROM customer
GROUP BY active;

# zwraca w dwóch kolumnach (aktywni i nieaktywni) klientów (imię i nazwisko klientów):
SELECT
    active.customer AS active_customer,
    inactive.customer AS inactive_customer
FROM
	(SELECT
		CONCAT(first_name, ' ', last_name) AS customer,
		ROW_NUMBER() OVER (ORDER BY customer_id) AS nr
	FROM customer
	WHERE active = 1) AS active                          
LEFT JOIN
    (SELECT
		CONCAT(first_name, ' ', last_name) AS customer,
        ROW_NUMBER() OVER (ORDER BY customer_id) AS nr
	FROM customer
	WHERE active = 0) AS inactive
ON active.nr = inactive.nr;

# zwraca dwie kolumny: imię nazwisko klienta oraz jego status (aktywny/ nieaktywny):
SELECT
	CONCAT(first_name, ' ', last_name) AS customer,
    CASE
		WHEN active = 1 THEN 'active'
        WHEN active = 0 THEN 'inactive'
	END AS status
FROM customer;

# zwraca dwie kolumny: imię i nazwisko klienta aktywnego oraz nieaktywnego. w jednym wierszu
, po przecinku.
SELECT
	(SELECT
	GROUP_CONCAT(CONCAT(first_name, ' ', last_name) SEPARATOR ', ')
	FROM customer
    WHERE active = 1) AS active_customers,
    
    (SELECT
	GROUP_CONCAT(CONCAT(first_name, ' ', last_name) SEPARATOR ', ')
    FROM customer
    WHERE active = 0) AS inactive_customers;

