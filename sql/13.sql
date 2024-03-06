/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

SELECT a.actor_id, a.first_name, a.last_name, t.film_id, t.title, t.rank, t.revenue
FROM actor a
LEFT JOIN LATERAL (
    SELECT f.title, f.film_id, COALESCE(SUM(p.amount), 0.00) as revenue, RANK () OVER (ORDER BY COALESCE(SUM(p.amount), 0.00) DESC, f.title) AS rank
    FROM film f
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment p ON r.rental_id = p.rental_id
    JOIN film_actor fa ON f.film_id = fa.film_id
    WHERE fa.actor_id = a.actor_id
    GROUP BY f.title, f.film_id
    ORDER BY revenue DESC
    LIMIT 3
) as t ON true
ORDER BY
    a.actor_id, t.rank;
