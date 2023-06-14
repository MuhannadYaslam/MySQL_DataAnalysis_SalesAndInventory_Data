-- we will need a list of all staff members, including their first and last names, email address, and the store identification number where they work
select
	first_name,
    last_name,
    email,
    store_id
from staff;
/*------------------------------------------------------------------*/
-- we will need separate counts of inventory items held at each of two store
select
	store_id,
    count(inventory_id) as inventory_items
from inventory
group by
	store_id;
/*------------------------------------------------------------------------*/
-- we will need a count of active customers for each stores seperatly
select
	store_id,
    count(customer_id) as active_customers
from customer
where active = 1
group by 1;
/*--------------------------------------------------------------*/
-- in order to assess the liabilty of a data breach,  we will need you to provide a count of all customers email addresses stored in the database
select
	count(email) as emails
from customer;
/*-----------------------------------------------------------------*/
-- please provide a count of unique film titles you have in inventory at each store and provide a count of unique categories of films you provide.
select
	store_id,
    count(distinct film_id) as unique_films
from inventory
group by 1;

select
	count(distinct name) as unique_categories 
from category;
/*------------------------------------------------------------*/
-- -- provide the replacement cost for the film that is least expensive to repalce, and the average of allm films
 select
	min(replacement_cost) as least_expensive,
    max(replacement_cost) as most_expensive,
    avg(replacement_cost) as average_expensive
from film;
/*---------------------------------------------------------------------------*/
-- please provide the average payment you process, as well as the maximum payment you have processed
 select
	avg(amount) as average_payment,
    max(amount) as max_payment
from payment;
/*---------------------------------------------------------------------------------------*/
-- please provide a list of all cusotmer identification values, with a count of rentals they have made all-time, with highest volume customers at the top of the list
select
	customer_id,
    count(rental_id) as number_of_rentals
from rental
group by 1
order by 2 desc;

    
