/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */


select distinct a.first_name, a.last_name
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film_category fc on fa.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Children'
and a.actor_id not in (
    select fa.actor_id
    from film_category fc
    join film_actor fa on fa.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
    where c.name = 'Horror'
)
order by a.last_name;
