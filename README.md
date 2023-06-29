# Music-Store_MySQL-fetching-data-

/*Who is the senior most employee?*/

select * from employee

order by levels desc

limit 1;
![image](https://github.com/DebopriyoSarkar97/Music-Store_MySQL-fetching-data-/assets/107385671/48afff2a-736c-4030-980f-5fed22ce94e3)


/* Which countries have the most invoices? 
*/
select count(1) as most_billings, billing_country 
from invoice
group by  billing_country 
order by most_billings desc;
![Screenshot (184)](https://github.com/DebopriyoSarkar97/Music-Store_MySQL-fetching-data-/assets/107385671/96fc175f-a9c8-4670-b950-2d1fbbab8f94)


/* What are top 3 values of invoice total ?
*/
select * from invoice 
order by total desc
limit 3;

![Screenshot (185)](https://github.com/DebopriyoSarkar97/Music-Store_MySQL-fetching-data-/assets/107385671/37fe10b9-777d-4a10-9275-16e992f11e1d)
