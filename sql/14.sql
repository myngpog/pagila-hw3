/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

SELECT c.name, r.title, r."total rentals" AS "total rentals"
-- FROM category c
LEFT JOIN LATERAL (
    SELECT t.title, t.film_id, t.count as "total rentals"
    -- get top rental count of film
    FROM (
        SELECT f.title, f.film_id, COUNT(r.rental_id)
        FROM film f
        LEFT JOIN inventory i USING (film_id)
        LEFT JOIN rental r USING (inventory_id)
        GROUP BY f.title, f.film_id
        ) as t
    -- join with film table to get top 5
    JOIN film_category fc USING (film_id)
    WHERE fc.category_id = c.category_id
    ORDER BY "total rentals" DESC, title desc
    LIMIT 5
) AS r ON true
ORDER BY c.name, r."total rentals" DESC, r.title;
