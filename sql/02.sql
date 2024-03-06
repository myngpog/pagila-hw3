/*
 * Compute the country with the most customers in it. 
 */

select cn.country
from customer c
join address a on c.address_id = a.address_id
join city ct on a.city_id = ct.city_id
join country cn on ct.country_id = cn.country_id
group by cn.country
order by count(*) desc
limit 1;

