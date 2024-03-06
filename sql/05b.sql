/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

select f2.title
from film f1
join film_actor fa1 on f1.film_id = fa1.film_id and f1.title = 'AMERICAN CIRCUS'
join film_actor fa2 on fa1.actor_id = fa2.actor_id
join film f2 on f2.film_id = fa2.film_id
group by f2.film_id, f2.title
having count(distinct fa2.actor_id) >= 2
order by f2.title;
