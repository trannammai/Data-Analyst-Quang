--Q1
select * from film;

--Q2
select first_name as Prenom ,last_name as NomdeFamille from actor;

--Q3
select distinct rating from film;

--Q4
select email from customer where last_name = 'Thomas' and first_name = 'Nancy';

--Q5
select description from film where title = 'Outlaw Hanky';

--Q6
select phone from address where address = '259 Ipoh Drive';

--Q7
select title,length from film where length>=30 and length<=50;
select title,length from film where length between 30 and 50;

--Q8
select customer_id from payment order by payment_date limit 10;

--Q9
select title,length from film order by length limit 10;

--Q10
select * from film where length <=50;

--Q11
select * from payment where amount > 5;

--Q12
select * from actor where last_name ilike 'p%';
select * from actor where last_name like 'P%';

--Q13
select distinct district from address;
select * from address;

--Q14
select * from film where rating = 'R' and replacement_cost between 5 and 15;
select * from film where rating = 'R' and replacement_cost >= 5 and replacement_cost <=15;

--Q15
select * from film where title like '%Truman%';


--Q16
select round(avg(length),2) from film where rating = 'R';

--Q17
select count(payment_id) from payment where amount <7;

--Q18
select staff_id, count(payment) as nb_payment, sum(amount) as sum_payment from payment 
group by staff_id;

--Q19
select rating,round(avg(replacement_cost),2) from film group by rating ;
select rating,round(avg(rental_rate),2) from film group by rating ;

--Q20
select customer_id, sum(amount) from payment 
group by customer_id
order by sum(amount) desc
limit 5;

--Q21
select customer_id,count(distinct payment_id) from payment 
group by customer_id
having count(distinct payment_id) >=40;

--Q22
select customer_id, sum(amount) from payment where staff_id = 2
group by customer_id
having sum(amount) > 100;
