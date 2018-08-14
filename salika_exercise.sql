USE sakila;

#Display the first and last names of all actors from the table actor.
SELECT first_name, last_name 
FROM actor;

#Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name
SELECT CONCAT(first_name, " ", last_name) AS Actor_Name
FROM actor;

#Find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe."
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

#Find all actors whose last name contain the letters GEN:
SELECT last_name
FROM actor
WHERE last_name Like "%GEN%";

#Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;

#Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China
SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

ALTER TABLE actor
ADD COLUMN description BLOB(15) AFTER last_name;

ALTER TABLE actor
DROP COLUMN description;

# List the last names of actors, as well as how many actors have that last name
SELECT last_name, COUNT(last_name)  
FROM actor
GROUP BY last_name;

#List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(last_name)  
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

#The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
UPDATE actor
SET first_name = "HARPO"
WHERE actor_id = 172;

UPDATE actor
SET first_name = "GROUCHO"
WHERE actor_id = 172;

#You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

#Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON address.address_id=staff.address_id;

#Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT SUM(amount), first_name, last_name
FROM payment
JOIN staff ON payment.staff_id=staff.staff_id
GROUP BY payment.staff_id;

#List each film and the number of actors who are listed for that film.
SELECT film.title, film_actor.film_id, COUNT(film_actor.actor_id)
FROM film_actor
INNER JOIN film ON film_actor.film_id = film.film_id
GROUP BY film.film_id;

#How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT film.title, COUNT(inventory.inventory_id)
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
WHERE title = "Hunchback Impossible"
GROUP BY title;

#Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT customer.first_name, customer.last_name, SUM(payment.amount)
FROM customer
JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY customer.last_name;

#The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT title 
FROM film
WHERE (title LIKE "Q%" OR title LIKE "K%");

#Use subqueries to display all actors who appear in the film Alone Trip
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
FROM film_actor
WHERE film_id IN (SELECT 
film_id 
FROM film 
WHERE title = "Alone Trip"));

#You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON address.address_id = customer.address_id JOIN city ON address.city_id = city.city_id JOIN country ON city.country_id = country.country_id
WHERE country.country = "Canada";

#Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT film.title, category.name
FROM film
JOIN film_category ON film_category.film_id = film.film_id JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Family";

#Display the most frequently rented movies in descending order
SELECT film.title, COUNT(rental.rental_id)
FROM film
JOIN inventory ON inventory.film_id= film.film_id  JOIN  rental ON inventory.film_id = rental.inventory_id
GROUP BY film.title
ORDER BY COUNT(rental.rental_id) DESC;

#Write a query to display how much business, in dollars, each store brought in		  
SELECT store.store_id, concat('$',format(SUM(payment.amount),2))
FROM store
JOIN customer ON customer.store_id = store.store_id JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;

#Write a query to display for each store its store ID, city, and country		 
SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON address.address_id = store.address_id JOIN city ON address.city_id = city.city_id JOIN country ON city.country_id = country.country_id;

#List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT category.name, concat('$',format(SUM(payment.amount),2))
FROM category
JOIN film_category ON film_category.category_id = category.category_id JOIN inventory ON film_category.film_id = inventory.film_id JOIN rental ON rental.inventory_id = inventory.inventory_id JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY category.name
ORDER BY concat('$',format(SUM(payment.amount),2)) DESC
LIMIT 5;

#Create view to the top 5 genres by revenue
CREATE VIEW genre_revenue_5 AS 
SELECT category.name, concat('$',format(SUM(payment.amount),2))
FROM category
JOIN film_category ON film_category.category_id = category.category_id JOIN inventory ON film_category.film_id = inventory.film_id JOIN rental ON rental.inventory_id = inventory.inventory_id JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY category.name
ORDER BY concat('$',format(SUM(payment.amount),2)) DESC
LIMIT 5;

#Show view
SELECT * 
FROM genre_revenue_5;

#Delete view
DROP VIEW genre_revenue_5;




				
























