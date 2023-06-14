-- 1. please send over the managers names at each store, with the full address of each property "the address of the store".
select
	staff.first_name as manager_first_name,
	staff.last_name as manager_last_name,
    address.address,
    address.district,
    city.city,
    country.country
from store
	left join staff 
		on store.manager_staff_id = staff.staff_id
	left join address 
		on store.address_id = address.address_id
	left join city 
		on address.city_id = city.city_id
	left join country 
		on city.country_id = country.country_id;
/*------------------------------------------------------------*/
-- 2. please pull a list of each inventory item in the stock, including the store_id number, the inventory_id, the name of the film, the film's rating, its rental rate and replacement cost.
select
	inventory.store_id,
    inventory.inventory_id,
    film.title,
    film.rating,
    film.rental_rate,
    film.replacement_cost
from inventory
	left join film
		on inventory.film_id = film.film_id;
/*--------------------------------------------------------*/
-- 3. provide a summary level overview of the inventory. we would like to know  how many inventory items you have with each rating at each store.
select 
	inventory.store_id,
    film.rating,
    count(inventory.inventory_id) as inventory_items
from inventory
	left join film
		on inventory.film_id = film.film_id
group by 1,2;
/*-------------------------------------------------------------------*/
-- 4. We would like to see  the number of films, as well as the average of replacement cost, and total replacement cost, sliced by store and film category.
select
	store_id,
	category.name as category,
	count(inventory.inventory_id) as films,
	avg(film.replacement_cost) as avg_replacement_cost,
	sum(film.replacement_cost) as total_replacement_cost
from inventory
	left join film
		on inventory.film_id = film.film_id
	left join film_category
		on film.film_id = film_category.film_id
	left join category
		on category.category_id = film_category.category_id
group by 1,2;
/*------------------------------------------------------------------------------------------------------------------------*/
-- 5. Provide a list of all customers names, which store they go to, whether they are active, and their full addresses(street address, city, and country).
 select
	customer.first_name,
	customer.last_name,
	customer.store_id,
	customer.active,
    address.address,
    city.city,
    country.country
from customer
	left join address
		on customer.address_id = address.address_id
	left join city
		on address.city_id = city.city_id
	left join country 
		on city.country_id = country.country_id;
/*--------------------------------------------------------------*/
-- 6. Pull together a list of customer names, their total lifetime rentals, and the sum of all payments, ordered by total life time value, with the most valuable customers at the top of the list.
 select
	customer.first_name,
    customer.last_name,
    count(rental.rental_id) as total_rentals,
    sum(payment.amount) as total_payment_amount
from customer
	left join rental 
		on customer.customer_id = rental.customer_id
	left join payment 
		on rental.rental_id = payment.rental_id
group by 1,2
order by 4 desc;
/*-----------------------------------------------------------*/
-- 7. Provide a list of advisor and investor names in one table, note whether they are investor or an advisor, and include which company they work for. 
select
    'investor' as type,
    first_name,
    last_name,
    company_name
from investor

union

select
	'advisor' as type,
    first_name,
    last_name,
    null
from advisor;
/*--------------------------------------------------------------------------------------*/
-- 8. 
select
	case
		when actor_award.awards = 'Emmmy, Oscar, Tony' then '3 awards'
        when actor_award.awards in ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') then '2 awards'
        else '1 award'
	end as number_of_awards,
    avg(case when actor_award.actor_id is null then 0 else 1 end) as pct_w_one_film
from actor_award
group by 1;
	
    
    
    

    