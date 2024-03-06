/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

select cn.country, sum(p.amount) as total_payments
from customer c
join payment p on c.customer_id = p.customer_id
join address a on c.address_id = a.address_id
join city ct on a.city_id = ct.city_id
join country cn on ct.country_id = cn.country_id
group by cn.country
order by total_payments desc, cn.country;
