/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN LATERAL (
    SELECT rental_id, rental_date, r.inventory_id, COUNT(cat.category_id) AS category_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    WHERE cat.name = 'Action'
    AND r.customer_id = c.customer_id
    group by rental_id, rental_date
    ORDER BY rental_date DESC
    LIMIT 5
) AS r ON TRUE
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(category_count) >= 4
ORDER BY c.customer_id;
