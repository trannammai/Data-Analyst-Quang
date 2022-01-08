--Q32
select extract(month from payment_date), sum(amount) as sum_amount
from payment group by extract(month from payment_date);
--
select to_char(payment_date,'Month'), sum(amount) as sum_amount
from payment group by to_char(payment_date,'Month');

--Q33
select to_char(payment_date,'Month'), sum(amount) as sum_amount
from payment group by to_char(payment_date,'Month')
order by sum(amount) desc limit 3;

--Q34
select distinct to_char(rental_date,'Month') from rental inner join inventory
on rental.inventory_id = inventory.inventory_id
inner join film on film.film_id = inventory.film_id
where title = 'Human Graffiti';

select distinct to_char(rental_date,'Month') from rental
where inventory_id in 
(select inventory_id from film inner join inventory on film.film_id = inventory.film_id
 where title = 'Human Graffiti');
 
--Q35
select to_char(rental_date,'Month'),count(rental_id) 
from rental inner join inventory
on rental.inventory_id = inventory.inventory_id
inner join film on film.film_id = inventory.film_id
where title = 'Human Graffiti'
group by to_char(rental_date,'Month');

--Q36 
select last_name, first_name, char_length(last_name) from customer
order by char_length(last_name) desc limit 5;

--Q37
select count(actor_id) from actor 
where actor_id in 
(select actor_id from film inner join film_actor on film.film_id = film_actor.film_id
where rating = 'NC-17' and replacement_cost > 25);

--Q38
select count(title) from film inner join film_category  on film.film_id = film_category.film_id 
where category_id in (
	select category_id from film inner join film_category on film.film_id = film_category.film_id 
	where title = 'Human Graffiti'
)

--Q39
select f1.title,f1.length from film as f1 inner join film as f2
on f1.length = f2.length and f2.title = 'Human Graffiti';
--
select f1.title,f1.length from film as f1,film as f2
where f1.length = f2.length and f2.title = 'Human Graffiti';

--Q40
select count(distinct c1.customer_id)--c1.customer_id, c1.first_name, c1.last_name, c2.customer_id, c2.first_name, c2.last_name 
from customer as c1 inner join customer as c2
on c1.last_name = c2.first_name;

--Q41
select to_char(rental_date,'Month'), count(film_id) from inventory join rental 
on inventory.inventory_id = rental.inventory_id
group by to_char(rental_date,'Month');

select to_char(rental_date,'Month'), count(rental_id) from rental 
group by to_char(rental_date,'Month');

--Q42
select to_char(rental_date,'Month'), count(rental_id) from rental 
group by to_char(rental_date,'Month')
order by count(rental_id) desc limit 3;

--Q43
select distinct to_char(rental_date,'Month') from rental join customer on rental.customer_id = customer.customer_id
where first_name = 'Jared' and last_name='Ely';

select distinct to_char(rental_date,'Month') from rental where customer_id in 
(select customer_id from customer where first_name = 'Jared' and last_name = 'Ely');

--Q44
select to_char(rental_date,'Month') as month, count(rental_id) from rental
inner join customer
on rental.customer_id=customer.customer_id
where first_name='Jennifer' and last_name='Davis'
group by month;

select to_char(rental_date,'Month'), count(rental_id) from rental where customer_id in 
(select customer_id from customer where first_name = 'Jennifer' and last_name = 'Davis')
group by to_char(rental_date,'Month');


--Q45 (2 ways)
----join
select distinct title from customer join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
where first_name = 'Jared' and last_name='Ely';

----subquery x1
select distinct title from film where film_id in
(select film_id from inventory i
join rental r 
on (i.inventory_id = r.inventory_id)
join customer c
on (r.customer_id = c.customer_id)
where c.first_name = 'Jared' and c.last_name = 'Ely');

----subquery x3
select distinct title from film where film_id in
	(select film_id from inventory 
	 where inventory_id in 
	 	(select inventory_id from rental 
		 where customer_id in
			(select customer_id from customer
			where first_name = 'Jared' and last_name = 'Ely')));

--Q46

select category.name, film.title, length(film.title)
from film
left join film_category on film_category.film_id = film.film_id
left join category on category.category_id = film_category.category_id
order by length(film.title) desc
limit 5;

select name, title from category 
inner join film_category 
on film_category.category_id = category.category_id 
inner join film 
on film_category.film_id = film.film_id
where title in (select title from film 
order by char_length(title) desc limit 5);

--Q47 (2 ways)
---join
select count(distinct(customer_id))
from customer
inner join address
on customer.address_id = address.address_id
inner join city
on address.city_id = city.city_id
inner join country
on city.country_id = country.country_id
where country = 'France';

---subquery
select count(distinct(customer_id)) from customer where address_id in 
	(select address_id from address
		where city_id in 
			(select city_id from city
			where country_id in 
				(select country_id from country
				where country='France'))
	);

--Q48
select count(customer_gauche.customer_id) 
from customer as customer_gauche inner join customer as customer_droit
on customer_gauche.first_name = customer_droit.first_name 
and customer_droit.last_name='Gordon' and customer_gauche.last_name != 'Gordon';


--Q49
select count(distinct e1.address_id)
from address as e1 inner join address as e2 on e1.district = e2.district
and e2.address = '1926 El Alto Avenue'and e1.address != '1926 El Alto Avenue';

select count(distinct a2.address) from address as a1, address as a2
where a1.address = '1926 El Alto Avenue' and a1.district = a2.district
and a2.address != '1926 El Alto Avenue';
