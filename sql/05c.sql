/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMP,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE f.film_id IN (
    SELECT fa2.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
    JOIN film f1 ON fa1.film_id = f1.film_id
    WHERE f1.title IN ('ACADEMY DINOSAUR', 'AGENT TRUMAN', 'AMERICAN CIRCUS')
    group by fa2.film_id
    HAVING COUNT(fa1.actor_id) >= 3
)
GROUP BY f.film_id, f.title
order by f.title;
