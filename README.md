# Music-Store_MySQL-fetching-data-


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
 
 /* Write a query to return the email, first name, last name and genre of all rock music listeners .
 return your list ordered alphabetically by email starting with 'A'
 */
select  distinct email,first_name, last_name
from customer as c
join invoice as i on i.customer_id=c.customer_id
join invoice_line as il on i.invoice_id=il.invoice_id
where track_id in (
select track_id 
from track as t
join genre as g on g.genre_id=t.genre_id
where g.name like 'Rock')
order by email;
 
 /* Invite the artist who have written the most rock music in our dataset/.
 Write a query that returns the artist name and total track count of the top 10 rock band */
 
 select a.artist_id, a.name, count(al.artist_id) as no_of_songs
 from track as t 
 join album2 as al on al.album_id = t.album_id
 join artist as a on a.artist_id = al.artist_id
 join genre as g on g.genre_id = t.genre_id
 where g.name like 'Rock'
 group by a.artist_id
 order by no_of_songs desc
 limit 10;
 
 /* Return all the track names that have a song length longer than the average song length.
 Return the name and millisecond for eack track.
 Order by song length with the longest songs listed first
 */
 select name , milliseconds
 from track
 where milliseconds >
 (select avg(milliseconds) as avg_track_length
from track )
order by milliseconds desc;

/* Find how much amount spent by each customer on artist?
Write a query to return customer name, artist name and total spent. 
*/
WITH best_selling_artist AS (
	SELECT a.artist_id AS artist_id, a.name AS artist_name, SUM(il.unit_price*il.quantity) AS total_sales
	FROM invoice_line as il
	JOIN track as t ON t.track_id = il.track_id
	JOIN album2 as abl ON abl.album_id = t.album_id
	JOIN artist as a ON a.artist_id = abl.artist_id
	GROUP BY a.artist_id
	ORDER BY total_sales DESC
	LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer as c ON c.customer_id = i.customer_id
JOIN invoice_line as il ON il.invoice_id = i.invoice_id
JOIN track as t ON t.track_id = il.track_id
JOIN album as alb ON alb.album_id = t.album_id
JOIN best_selling_artist as bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;


/* We want to find out most popular music genre for each country.
We determine the most popular genre as the genre with the highest amount of purchase.
Write a query that returns each country along with to genre.
For countries where the maximum number of purchases is shared return all genres
*/

WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1;

/* Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1;

 
 
 
 
 
