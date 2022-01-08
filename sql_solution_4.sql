--- Créez une table qui nous permettra de connaître le temps passé sur le site de location de dvd.
create table if not exists LOG_USER_SITE(
	account_id serial primary key,
	first_name VARCHAR(45) not null,
	last_name VARCHAR(45) not null,
	email VARCHAR(50) unique not null,
	signup_date TIMESTAMP not null,
	time_spent time not null
);

select * from LOG_USER_SITE;

--- Add 3 people to this table

insert into LOG_USER_SITE(first_name,last_name,email,signup_date,time_spent)
values 
	('Ali','Baba','alibaba@gmail.com','2020-02-20','01:02:06'),
	('Cen','Drillon','cendrillon@gmail.com','2020-02-10','00:02:54'),
	('Sim','Ba','simba@gmail.com','2020-01-10','03:05:41');

select * from LOG_USER_SITE;

--- Add these people also in the customer + address table
--- Note: the last update column does not need to be specified, it is automatically updated to the date of update

insert into address(address,district,city_id,postal_code,phone)
values
	('123 rue de la charette','Midi-Pyrenes',544,'34021','33612356754'),
	('5 rue de la gascognette','Midi-Pyrenes',544,'34021','33612356754'),
	('1 rue de la paix','Midi-Pyrenes',544,'34021','33612356754');

select * from address order by last_update desc limit 3;

INSERT INTO customer 
				(store_id,first_name, last_name, email, address_id, create_date)
		VALUES (1,'Ali','Baba','alibaba@gmail.com', 606, current_date),
				(1,'Cen','Drillon','cendrillon@gmail.com', 607, current_date),
				(1,'Sim','Ba','simba@gmail.com', 608, current_date);

select * from customer order by last_update desc limit 3;


--- In the movie table, create a “rental_type” column
ALTER TABLE film ADD rental_type VARCHAR(6);

--- which will be defined as:
UPDATE FILM SET rental_type =
	(case 
					when rental_duration < 3 then 'Court'
					when rental_duration between 3 and 5 then 'Moyen'
					when rental_duration > 5 then 'Long'
					else null
	end);
	
select * from film;
