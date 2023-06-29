
/*Who is the senior most employee?*/
select * from employee
order by levels desc
limit 1;

/* Which countries have the most invoices? 
*/
select count(1) as most_billings, billing_country 
from invoice
group by  billing_country 
order by most_billings desc;

/* What are top 3 values of invoice total ?
*/
select * from invoice 
order by total desc
limit 3;

/* Which city has the best customers? 
 We would like to throw a promotional music festival in the city we made the most money ?
 Write a qury that returns one city that has highest sum of invoice total.alter
 Return both the city name and sum of all the invoice total 
 */
 select billing_city, sum(total) as city_rev from invoice
 group by billing_city
 order by city_rev desc
 limit 1;
 
 /* Who is the best customer? 
 The customer who has spent the most money will be declared the best customer.
 Write a query that returns the person who has spent the most money ?
 */
 select * from customer;
 select * from invoice;
 
 select c.customer_id, c.first_name, c.last_name, sum(i.total) as total
 from customer as c
 join invoice as i on c.customer_id=i.customer_id
 group by c.customer_id
 order by total desc
 limit 1;
 
 
 
 
 
 
 
 