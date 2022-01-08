-- Q23
select first_name,last_name,district  from customer inner join address 
on customer.address_id = address.address_id
where district = 'California'; 

-- Q24
select distinct city,district from city inner join address 
on city.city_id = address.city_id
where district in ('Alberta','Hamilton');

-- Q25
select count(distinct film_id) from film inner join language 
on language.language_id = film.language_id
where name = 'English';

-- Q26
select count(distinct film.film_id)
from film left join inventory
on film.film_id = inventory.film_id
where inventory_id is not null;

select count(distinct title) from film INNER JOIN inventory 
ON inventory.film_id = film.film_id;

-- Q27
select first_name,last_name,title
from actor inner join film_actor
on actor.actor_id = film_actor.actor_id
inner join film 
on film_actor.film_id = film.film_id
where title = 'Human Graffiti';

-- Q28
select city from city inner join address 
on city.city_id = address.city_id
inner join customer
on customer.address_id = address.address_id
where first_name = 'Patricia' and last_name = 'Johnson';

-- Q29
select distinct name from actor inner join film_actor
on actor.actor_id = film_actor.actor_id
inner join film_category 
on film_actor.film_id = film_category.film_id
inner join category 
on film_category.category_id = category.category_id 
where first_name='Milla' and last_name = 'Peck';

-- Q30



-- Q31
select count(distinct film_id) from inventory inner join rental
on inventory.inventory_id = rental.inventory_id
inner join customer
on customer.customer_id = rental.customer_id
inner join address
on customer.address_id = address.address_id
where district in ('Batman','Bihar');
