/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
from actor a
join film_actor fa on a.actor_id = fa.actor_id
-- make table with all actors that that are in show with RB
left join (
    select a2.actor_id
    from actor a1
    join film_actor fa1 on a1.actor_id = fa1.actor_id
    join film_actor fa2 on fa1.film_id = fa2.film_id
    join actor a2 on fa2.actor_id = a2.actor_id
    where a1.first_name = 'RUSSELL' and a1.last_name = 'BACALL'
) as t on fa.actor_id = t.actor_id
WHERE t.actor_id IS NULL
order by "Actor Name";
