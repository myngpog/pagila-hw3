/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */

select *
from (
    select c.customer_id, first_name || ' ' || last_name as name, sum(amount) as total_payment, ntile(100) over (order by sum(amount)) as percentile
    from customer c
    join payment p on c.customer_id = p.customer_id
    group by c.customer_id
) as t
where percentile >= 90
order by name;
