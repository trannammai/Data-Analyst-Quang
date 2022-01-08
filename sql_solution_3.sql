--Quel est la somme encaissée (amount) par mois ? (table payment)
select extract(month from payment_date), sum(amount) as sum_amount
from payment group by extract(month from payment_date);
--
select to_char(payment_date,'Month'), sum(amount) as sum_amount
from payment group by to_char(payment_date,'Month');
--Quels sont les 3 mois durant lesquels nous avons encaissé la plus grosse somme ?
select to_char(payment_date,'Month'), sum(amount) as sum_amount
from payment group by to_char(payment_date,'Month')
order by sum(amount) desc limit 3;
--Quels sont les différents mois ou le film “Human Graffiti” a été loué ?
select distinct to_char(rental_date,'Month') from rental inner join inventory
on rental.inventory_id = inventory.inventory_id
inner join film on film.film_id = inventory.film_id
where title = 'Human Graffiti';

select distinct to_char(rental_date,'Month') from rental
where inventory_id in 
(select inventory_id from film inner join inventory on film.film_id = inventory.film_id
 where title = 'Human Graffiti');
 
--Combien de fois il a été loué pour chacun de ces mois ?
select to_char(rental_date,'Month'),count(rental_id) 
from rental inner join inventory
on rental.inventory_id = inventory.inventory_id
inner join film on film.film_id = inventory.film_id
where title = 'Human Graffiti'
group by to_char(rental_date,'Month');

--Quels sont les 5 clients avec le nom de famille le plus long ? 
select last_name, first_name, char_length(last_name) from customer
order by char_length(last_name) desc limit 5;

--Combien d’acteurs ont joué dans un film NC-17 et un coût de remplacement supérieur à 25 ?
select count(actor_id) from actor 
where actor_id in 
(select actor_id from film inner join film_actor on film.film_id = film_actor.film_id
where rating = 'NC-17' and replacement_cost > 25);

--Combien de films font partie de la même catégorie que le film “Human Graffiti” ?
select count(title) from film inner join film_category  on film.film_id = film_category.film_id 
where category_id in (
	select category_id from film inner join film_category on film.film_id = film_category.film_id 
	where title = 'Human Graffiti'
)

-- Combien de films font partie de la même longueur (length) que le film “Human Graffiti” ?
select f1.title,f1.length from film as f1 inner join film as f2
on f1.length = f2.length and f2.title = 'Human Graffiti';
--
select f1.title,f1.length from film as f1,film as f2
where f1.length = f2.length and f2.title = 'Human Graffiti';

--Combien de client distinct ont leur nom de famille identique à un prénom d’un autre client ?
select count(distinct c1.customer_id)--c1.customer_id, c1.first_name, c1.last_name, c2.customer_id, c2.first_name, c2.last_name 
from customer as c1 inner join customer as c2
on c1.last_name = c2.first_name;
