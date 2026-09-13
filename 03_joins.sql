# answer 3.1
SHOW FULL TABLES;
SELECT * FROM film;
SELECT * FROM language;

# current avaible languages:
SELECT
	name AS `langueges`
FROM language
GROUP BY name;

# how many languages:
SELECT
	COUNT(language_id)
FROM language
GROUP BY name;

# ile filmów w każdym z jęzków
SELECT
	language.name AS `language`,
	COUNT(film.film_id) AS `how many languages`
FROM film
RIGHT JOIN language
ON film.language_id = language.language_id
GROUP BY language.name;

# rozwiązanie zadania
SELECT
	film.title AS `film title`,
    language.name AS `language`
FROM film
JOIN language
ON film.language_id = language.language_id;


# answer 3.2
SHOW FULL TABLES;
SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;

SELECT
	film.title,
	GROUP_CONCAT(category.name SEPARATOR ', ') AS `categories`
FROM film
JOIN film_category
	ON film.film_id = film_category.film_id
JOIN category
	ON film_category.category_id = category.category_id
GROUP BY film.film_id
ORDER BY film.title;


# answer 3.3
SHOW FULL TABLES;
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT
	film.title,
	GROUP_CONCAT(CONCAT(actor.first_name, ' ', actor.last_name) SEPARATOR ', ') AS `actors`
FROM film
JOIN film_actor
	ON film.film_id = film_actor.film_id
JOIN actor
	ON film_actor.actor_id = actor.actor_id
GROUP BY film.film_id
ORDER BY film.title;

# answer 3.4
SHOW FULL TABLES;
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT
	film.title AS `film with NICK WAHLBERG`
	# COUNT(film.title) AS `film with NICK WAHLBERG`
FROM film
JOIN film_actor
	ON film.film_id = film_actor.film_id
JOIN actor
	ON film_actor.actor_id = actor.actor_id
# WHERE CONCAT(actor.first_name, ' ', actor.last_name) = 'NICK WAHLBERG';
WHERE
	actor.first_name = 'NICK' AND
	actor.last_name = 'WAHLBERG';


# answer 3.5 
SHOW FULL TABLES;
SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;

SELECT
	CONCAT(customer.first_name, ' ', customer.last_name) AS `customer`,
    address.address,
    city.city,
    country.country
FROM customer
JOIN address
	ON  customer.address_id = address.address_id
JOIN city
	ON address.city_id = city.city_id
JOIN country
	ON city.country_id = country.country_id;

# answer 3.6
SHOW FULL TABLES;
SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;

SELECT
	CONCAT(customer.first_name, ' ', customer.last_name) AS `customer`,
    address.address,
    city.city,
    country.country
FROM customer
JOIN address
	ON  customer.address_id = address.address_id
JOIN city
	ON address.city_id = city.city_id
JOIN country
	ON city.country_id = country.country_id
WHERE country.country = 'Canada';

# answer 3.7
SHOW FULL TABLES;
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film;

SELECT
	CONCAT(actor.first_name, ' ', actor.last_name) AS `actor`,
	COUNT(film.title) AS `films`
    # GROUP_CONCAT(film.title SEPARATOR ', ') AS `films`
FROM actor
JOIN film_actor
	ON actor.actor_id = film_actor.actor_id
JOIN film
	ON film_actor.film_id = film.film_id
GROUP BY actor.actor_id
ORDER BY actor.actor_id;


# answer 3.8
SHOW FULL TABLES;
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film;

SELECT
	CONCAT(actor.first_name, ' ', actor.last_name) AS `actor`,
	COUNT(film.title) AS `films`
    # GROUP_CONCAT(film.title SEPARATOR ', ') AS `films`
FROM actor
JOIN film_actor
	ON actor.actor_id = film_actor.actor_id
JOIN film
	ON film_actor.film_id = film.film_id
GROUP BY actor.actor_id
ORDER BY COUNT(film.title) DESC
LIMIT 0, 10;











