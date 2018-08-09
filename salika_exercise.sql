USE sakila;

SELECT first_name, last_name 
FROM actor;

SELECT CONCAT(first_name, " ", last_name) AS Actor_Name
FROM actor;

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

SELECT last_name
FROM actor
WHERE last_name Like "%GEN%";

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;

SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

ALTER TABLE actor
ADD COLUMN description BLOB(15) AFTER last_name;

ALTER TABLE actor
DROP COLUMN description;

SELECT last_name, COUNT(last_name)  
FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(last_name)  
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

UPDATE actor
SET first_name = "HARPO"
WHERE actor_id = 172;

UPDATE actor
SET first_name = "GROUCHO"
WHERE actor_id = 172;

SHOW CREATE TABLE address;

SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON address.address_id=staff.address_id;

SELECT SUM(amount), first_name, last_name
FROM payment
JOIN staff ON payment.staff_id=staff.staff_id
GROUP BY payment.staff_id;

SELECT film.title, film_actor.film_id, COUNT(film_actor.actor_id)
FROM film_actor
INNER JOIN film ON film_actor.film_id = film.film_id
GROUP BY film.film_id;

SELECT film.title, COUNT(inventory.inventory_id)
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
WHERE title = "Hunchback Impossible"
GROUP BY title;

SELECT customer.first_name, customer.last_name, SUM(payment.amount)
FROM customer
JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY customer.last_name;

SELECT title 
FROM film
WHERE (title LIKE "Q%" OR title LIKE "K%");

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
FROM film_actor
WHERE film_id IN (SELECT 
film_id 
FROM film 
WHERE title = "Alone Trip"));

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON address.address_id = customer.address_id JOIN city ON address.city_id = city.city_id JOIN country ON city.country_id = country.country_id
WHERE country.country = "Canada";

SELECT film.title, category.name
FROM film
JOIN film_category ON film_category.film_id = film.film_id JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Family";

SELECT film.title, COUNT(rental.rental_id)
FROM film
JOIN inventory ON inventory.film_id= film.film_id  JOIN  rental ON inventory.film_id = rental.inventory_id
GROUP BY film.title
ORDER BY COUNT(rental.rental_id) DESC;

SELECT store.store_id, concat('$',format(SUM(payment.amount),2))
FROM store
JOIN customer ON customer.store_id = store.store_id JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;

SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON address.address_id = store.address_id JOIN city ON address.city_id = city.city_id JOIN country ON city.country_id = country.country_id;

SELECT category.name, concat('$',format(SUM(payment.amount),2))
FROM category
JOIN film_category ON film_category.category_id = category.category_id JOIN inventory ON film_category.film_id = inventory.film_id JOIN rental ON rental.inventory_id = inventory.inventory_id JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY category.name
ORDER BY concat('$',format(SUM(payment.amount),2)) DESC
LIMIT 5;

CREATE VIEW genre_revenue_5 AS 
SELECT category.name, concat('$',format(SUM(payment.amount),2))
FROM category
JOIN film_category ON film_category.category_id = category.category_id JOIN inventory ON film_category.film_id = inventory.film_id JOIN rental ON rental.inventory_id = inventory.inventory_id JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY category.name
ORDER BY concat('$',format(SUM(payment.amount),2)) DESC
LIMIT 5;

SELECT * 
FROM genre_revenue_5;

DROP VIEW genre_revenue_5;




				
























