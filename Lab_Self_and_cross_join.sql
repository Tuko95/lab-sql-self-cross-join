use sakila;



-- 1. Get all pairs of actors that worked together.

select * from actor;
select * from film_actor;
#select * from film;

select * from film_actor d1
join film_actor d2
on d1.film_id = d2.film_id
group by d1.actor_id
having d1.actor_id != d2.actor_id
order by d1.film_id asc;



-- 2. Get all pairs of customers that have rented the same film more than 3 times.  ###ERROR

select * from customer; -- customer_id, first_name♥, last_name♥  1
select * from rental; -- rental_id, customer_id, inventory_id  2
select * from inventory; -- inventory_id, film_id ♥  3  
select * from film; -- film_id  4 

select * from (select customer_id, first_name, last_name from customer
) sub1
cross join (select distinct film_id from film
group by film_id
) sub2;


select f.film_id, c.first_name, c.last_name, count(f.film_id) from customer c
left join rental r
using (customer_id)
left join inventory i 
using (inventory_id)
left join film f
using (film_id)  
group by c.first_name
having count(f.film_id) >= 3
order by f.film_id;



-- 3. Get all possible pairs of actors and films.
select * from actor;
select * from film_actor;

-- OTHER WAY NO DO IT
#select distinct a.actor_id, a.first_name, a.last_name, f.film_id from film_actor f
#join actor a
#order by actor_id asc;

-- AN EFFICIENT WAY TO DO IT 
select * from (select distinct first_name, last_name from actor
) sub1 
cross join (select distinct film_id from film_actor
) sub2;
