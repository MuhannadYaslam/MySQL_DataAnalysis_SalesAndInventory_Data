select * from rental;
/*----------------------------------------------------*/
select customer_id, rental_id
from rental;
/*-----------------------------------------------------------*/
-- 1. I'm going to send an email letting our customers know there has been a managment change. Could you pull a list of the required data for me to let them know? 
select first_name, last_name, email
from customer;
/*-----------------------------------------------------------------------*/
select distinct rating 
from film;
/*-------------------------------------------------------------------------------*/
-- 2. My understanding is that we rent for durations of 3, 5, or 7 days. Could you pull the records of our films and see if there are any other rental durations?
select distinct rental_duration
from film;
/*------------------------------------------------------------------------------*/
select
	customer_id,
    rental_id,
    amount,
    payment_date
from payment
where amount = 0.99;
/*--------------------------------------------------------------------------------*/
select
	customer_id,
    rental_id,
    amount,
    payment_date
from payment
where payment_date > '2006-01-01';
/*-----------------------------------------------------------------------------------*/
-- I'd like to look at payment records for our long-term customers to learn about their purchase patterns. Could you pull all payments from mour first 100 customers?
select 
	customer_id,
    rental_id,
    amount,
    payment_date
from payment
where customer_id < 101;
/*----------------------------------------------------------------------------------------*/
select 
	customer_id,
    rental_id,
    amount,
    payment_date
from payment
where amount = 0.99 and payment_date > '2006-01-01';
/*------------------------------------------------------------------------------------------*/
-- The payment data you gave me on our first 100 customers was great! Now I'd love to see just payments over $5 for those same, since january 1, 2006.
select
	customer_id,
    rental_id,
    amount,
    payment_date
from payment
where customer_id < 101 and amount > 5 and payment_date > '2006-01-01';
/*------------------------------------------------------------------------*/
select
	customer_id,
    rental_id,
    amount,
    payment_date
from payment
where customer_id = 5 or customer_id = 11 or customer_id = 29;
/*-----------------------------------------------------------------------------*/
-- the data you shared previosly on cusotmers 42, 53, 60, and 75 was good to see. Now, could you please write a query a query to pull all payments from those specific customers, along with payments over $5, from any customer?
select
	customer_id,
    rental_id,
    amount,
    payment_date
from payment
where amount > 5 
	or customer_id = 42 
	or customer_id = 53 
    or customer_id = 60 
    or customer_id = 75;
/*-------------------------------------------------------------------------------------*/
select
	customer_id,
    rental_id,
    amount,
    payment_date
from payment
where amount > 5 or customer_id IN (42,53,60,75);
/*-----------------------------------------------------------------------------------------*/
select
	title,
    description
from film 
where description LIKE '%Dentist%';
/*--------------------------------------------------------------------------------------------*/
-- we need to understand the special features in our films. Could you pull a list of films which include a Behind the Scenes special feature?
select
	title,
    special_features
from film
where special_features LIKE '%Behind The Scenes%';
/*----------------------------------------------------------------------------------------------------*/
select 
	rating,
    count(film_id)
from film
group by rating;
/*-----------------------------------------------------------------------------------------------------*/
-- I need to get a quick overview of how long our movies tend to be rented out for. Could you please pull a count of titles sliced by rental duration?
select
	rental_duration,
    count(film_id) as films_with_this_rental_duration
from film
group by rental_duration;
/*--------------------------------------------------------------------------------------------------------------*/
select 
	rating,
    rental_duration,
    count(film_id) as count_of_films
from film
group by rating, rental_duration
order by 1,2;
/*---------------------------------------------------------------------------------------------------------------------*/
select
	rating,
    count(film_id) as count_of_films,
    min(length) as shortest_film,
    max(length) as longest_film,
    avg(length) as average_length_of_film,
    sum(length) as total_minutes,
    avg(rental_duration) as average_rental_duration
from film
group by rating;
/*------------------------------------------------------------------------------------*/
-- I'm wondering if we charge more for rental when the replacment cost is higher. Can you help me pull a count of films, along with the average, min, and max rental rate, grouped by replacment cost?
select 
	replacement_cost,
    count(film_id) as number_of_films,
    min(rental_rate) as cheapest_rental,
    max(rental_rate) as most_expensive_rental,
    avg(rental_rate) as average_rental
from film
group by 1
order by 1;
/*--------------------------------------------------------------------------------------*/
select
	customer_id,
    count(*) as total_rental
from rental
group by 1
having count(*)>=30;
/*----------------------------------------------------------------------------------------------*/
-- I'd like to talk to customers that have not rented much from us to understand if there is something we could do better. could you pull a list of customer_ids with less than 15 rentals all-time?
select
	customer_id,
    count(*) as total_rentals
from rental
group by 1
having count(*) < 15;
/*----------------------------------------------------------------------------------------------------------*/
select
	customer_id,
    rental_id,
    amount,
    payment_date
from payment
order by amount desc;
/*--------------------------------------------------------------------------------------------------------------*/
-- I'd like to see if our longest films also tend to be our most expensive rentals. Could you pull me a list of all film titles along with lengths and rental rates and put them in desc order?
select
	title,
    length,
    rental_rate
from film
order by length desc;
/*--------------------------------------------------------------------------------------------------------------*/
select distinct
	length,
    case
		when length < 60 then 'under 1 hr'
        when length between 60 and 90 then '1-1.5 hrs'
        when length > 90 then 'over 1.5 hrs'
        else 'ERROR'
	end as length_bucket
from film;
/*-------------------------------------------------------------------------------------------------------------------*/
select distinct
	title,
    case 
		when rental_duration <= 4 then 'rental_too_short'
        when rental_rate >= 3.99 then 'too_expensive'
        when rating in ('NC-17','R') then 'too_adult'
        when length not between 60 and 90 then 'too_short_or_too_long'
        when description like '%Shark%' then 'nope_has_sharks'
        end as recommendation
	from film;
/*---------------------------------------------------------------------------------------------------------------*/
    -- I'd like to know which store each customer goes to, and whether or not they are active. Could you pull a list of first first and last names of all customers, and label them as either 'store 1 active', 'store 1 inactive','store 2 active', or 'store 2 inactive'?
    select
		first_name,
        last_name,
        case
			when store_id = 1 and active = 1 then 'store 1 active'
            when store_id = 1 and active = 0 then 'store 1 inactive' 
            when store_id = 2 and active = 1 then 'store 2 active' 
            when store_id = 2 and active = 0 then 'store 2 inactive' 
		else 'error'
		end as store_and_status
        from customer;
/*------------------------------------------------------------------------------------------------------------------*/
    select
    film_id,
    count(case when store_id = 1 then inventory_id else null end) as store_1_copies,
	count(case when store_id = 2 then inventory_id else null end) as store_2_copies,
    count( inventory_id) as total_copies
    from inventory
    group by 1;
/*-----------------------------------------------------------------------------------------------------------------------------*/
-- Can you pull for me a list of each film we have in inventory? I would ike to see the film's title, description, and the store_id value associated with each item, and its inventory_id.
select distinct
	inventory.inventory_id,
    inventory.store_id,
    film.title,
    film.description
from film	
	inner join inventory
		on film.film_id = inventory.film_id;
/*--------------------------------------------------------------------------------------------------------------*/
select
	actor.first_name,
    actor.last_name,
    count(film_actor.film_id) as number_of_films
from actor	
	left join film_actor
		on actor.actor_id = film_actor.actor_id
group by
	1,2;
/*----------------------------------------------------------------------------------------------------------------------*/
-- One of our investors is intrested in the films we carry and how many actors are listed for each film title. can you pull a list of all titles, and figure out how many actors are asscociated with each title?
select
	film.title,
    count(film_actor.actor_id) as number_of_actors
from film	
	left join film_actor
		on film.film_id = film_actor.film_id
group by 1
order by 2 desc;
/*-----------------------------------------------------------------------------------*/
select
	film.film_id,
    film.title,
    film_category.category_id,
    category.name
from film
	inner join film_category
		on film.film_id = film_category.film_id
	inner join category
		on film_category.category_id = category.category_id
order by 1;
/*---------------------------------------------------------------------------------------------*/
-- Customers often ask which films their favorite actors appear in. It would be great to have a list of all actors, with each title they appear in?
select
	actor.first_name,
    actor.last_name,
    film.title
from actor
	inner join film_actor
		on actor.actor_id = film_actor.actor_id
	inner join film
		on film_actor.film_id = film.film_id
order by 1,2;
/*---------------------------------------------------------------------------------------------------*/
-- The manager from store 2 is working on expanding our film collection there. Could you pull a list of distinct titles and their descriptions, cuurently available in inventory at store 2?
select distinct	
	film.title,
    film.description
from film
	inner join inventory
		on film.film_id = inventory.film_id
        and inventory.store_id = 2;
/*------------------------------------------------------------------------------------------------------------*/
-- We will be hosting a meeting with all of our staff and advisors soon. Could you pull one list of all staff and and advisor names and include column noting whether they are a staff member or advisor?
select
	'advisor' as type,
	first_name,
    last_name
from  advisor

union

select
	'staff' as type,
    first_name,
    last_name
from staff;

    
            
        

    
