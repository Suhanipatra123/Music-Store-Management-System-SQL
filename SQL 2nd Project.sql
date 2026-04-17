-- =========================================
-- Project Title: Music Store Management System using SQL
-- =========================================

-- DATABASE
CREATE DATABASE music_store;
USE music_store;

-- Tables
-- 1. Genre and MediaType 
CREATE TABLE Genre ( 
genre_id INT PRIMARY KEY, 
name VARCHAR(120) 
); 
CREATE TABLE MediaType ( 
media_type_id INT PRIMARY KEY, 
name VARCHAR(120) 
); 

-- 2. Employee 
CREATE TABLE Employee ( 
employee_id INT PRIMARY KEY, 
last_name VARCHAR(120), 
first_name VARCHAR(120), 
title VARCHAR(120), 
 
 reports_to INT, 
  levels VARCHAR(255), 
 birthdate DATE, 
 hire_date DATE, 
 address VARCHAR(255), 
 city VARCHAR(100), 
 state VARCHAR(100), 
 country VARCHAR(100), 
 postal_code VARCHAR(20), 
 phone VARCHAR(50), 
 fax VARCHAR(50), 
 email VARCHAR(100) 
); 

-- 3. Customer 
CREATE TABLE Customer ( 
 customer_id INT PRIMARY KEY, 
 first_name VARCHAR(120), 
 last_name VARCHAR(120), 
 company VARCHAR(120), 
 address VARCHAR(255), 
 city VARCHAR(100), 
 state VARCHAR(100), 
 country VARCHAR(100), 
 postal_code VARCHAR(20), 
 phone VARCHAR(50), 
 fax VARCHAR(50), 
 email VARCHAR(100), 
 support_rep_id INT, 
 FOREIGN KEY (support_rep_id) REFERENCES Employee(employee_id)
 );
 
 -- 4. Artist 
CREATE TABLE Artist ( 
 artist_id INT PRIMARY KEY, 
 name VARCHAR(120) 
);

-- 5. Album 
CREATE TABLE Album ( 
 album_id INT PRIMARY KEY, 
 title VARCHAR(160), 
 artist_id INT, 
 FOREIGN KEY (artist_id) REFERENCES Artist(artist_id) 
); 

-- 6. Track 
CREATE TABLE Track ( 
 track_id INT PRIMARY KEY, 
 name VARCHAR(200), 
 album_id INT, 
 media_type_id INT, 
 genre_id INT, 
 
 composer VARCHAR(220), 
 milliseconds INT, 
 bytes INT, 
 unit_price DECIMAL(10,2), 
 FOREIGN KEY (album_id) REFERENCES Album(album_id), 
 FOREIGN KEY (media_type_id) REFERENCES MediaType(media_type_id), 
 FOREIGN KEY (genre_id) REFERENCES Genre(genre_id) 
);

-- 7. Invoice 
CREATE TABLE Invoice ( 
 invoice_id INT PRIMARY KEY, 
 customer_id INT, 
 invoice_date DATE, 
 billing_address VARCHAR(255), 
 billing_city VARCHAR(100), 
 billing_state VARCHAR(100), 
 billing_country VARCHAR(100), 
 billing_postal_code VARCHAR(20), 
 total DECIMAL(10,2), 
 FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) 
);

-- 8. InvoiceLine 
CREATE TABLE InvoiceLine ( 
 invoice_line_id INT PRIMARY KEY, 
 invoice_id INT, 
 track_id INT, 
 unit_price DECIMAL(10,2), 
 quantity INT, 
 FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id), 
 FOREIGN KEY (track_id) REFERENCES Track(track_id) 
);

-- 9. Playlist 
CREATE TABLE Playlist ( 
  playlist_id INT PRIMARY KEY, 
 name VARCHAR(255) 
); 

-- 10. PlaylistTrack 
CREATE TABLE PlaylistTrack ( 
 playlist_id INT, 
 track_id INT, 
 PRIMARY KEY (playlist_id, track_id), 
 FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id), 
 FOREIGN KEY (track_id) REFERENCES Track(track_id) 
); 

-- Indexes (Performance Boost)
-- Customer & Invoice
CREATE INDEX idx_invoice_customer ON Invoice(customer_id);
CREATE INDEX idx_invoice_date ON Invoice(invoice_date);

-- InvoiceLine
CREATE INDEX idx_invoiceline_invoice ON InvoiceLine(invoice_id);
CREATE INDEX idx_invoiceline_track ON InvoiceLine(track_id);

-- Track
CREATE INDEX idx_track_album ON Track(album_id);
CREATE INDEX idx_track_genre ON Track(genre_id);
CREATE INDEX idx_track_media ON Track(media_type_id);

-- Album & Artist
CREATE INDEX idx_album_artist ON Album(artist_id);

-- Customer Support
CREATE INDEX idx_customer_support ON Customer(support_rep_id);

-- =====================================================
-- LOAD DATA:Data was succesfully loaded using My SQL Terminal.This code is provided only for reference purposes.
-- =====================================================

-- GENRE TABLE
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/genre.csv"
INTO TABLE Genre
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@genre_id, @name)
SET genre_id = @genre_id, name = @name;

-- MEDIATYPE TABLE

LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/media_type.csv"
INTO TABLE MediaType
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@media_type_id, @name)
SET media_type_id = @media_type_id, name = @name;

-- EMPLOYEE

LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/employee.csv"
INTO TABLE Employee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@employee_id, @last_name, @first_name, @title, @reports_to, @levels, @birthdate, @hire_date, @address, @city, @state, @country, @postal_code, @phone, @fax, @email)
SET employee_id=@employee_id, last_name=@last_name, first_name=@first_name,
title=@title, reports_to=@reports_to, levels=@levels,
birthdate=@birthdate, hire_date=@hire_date, address=@address,
city=@city, state=@state, country=@country,
postal_code=@postal_code, phone=@phone, fax=@fax, email=@email;

-- CUSTOMER TABLE

LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/customer.csv"
INTO TABLE Customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@customer_id, @first_name, @last_name, @company, @address, @city, @state, @country, @postal_code, @phone, @fax, @email, @support_rep_id)
SET customer_id=@customer_id, first_name=@first_name, last_name=@last_name,
company=@company, address=@address, city=@city,
state=@state, country=@country, postal_code=@postal_code,
phone=@phone, fax=@fax, email=@email, support_rep_id=@support_rep_id;

-- ARTIST TABLE

LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/artist.csv"
INTO TABLE Artist
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@artist_id, @name)
SET artist_id = @artist_id, name = @name;

-- ALBUM TABLE

LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/album.csv"
INTO TABLE Album
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@album_id, @title, @artist_id)
SET album_id = @album_id, title = @title, artist_id = @artist_id;

-- TRACK TABLE

LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/track.csv"
INTO TABLE Track
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@track_id, @name, @album_id, @media_type_id, @genre_id, @composer, @milliseconds, @bytes, @unit_price)
SET track_id=@track_id, name=@name, album_id=@album_id,
media_type_id=@media_type_id, genre_id=@genre_id,
composer=@composer, milliseconds=@milliseconds,
bytes=@bytes, unit_price=@unit_price;

-- INVOICE TABLE

LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/invoice.csv"
INTO TABLE Invoice
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@invoice_id, @customer_id, @invoice_date, @billing_address, @billing_city, @billing_state, @billing_country, @billing_postal_code, @total)
SET invoice_id=@invoice_id, customer_id=@customer_id,
invoice_date=@invoice_date, billing_address=@billing_address,
billing_city=@billing_city, billing_state=@billing_state,
billing_country=@billing_country, billing_postal_code=@billing_postal_code,
total=@total;

-- INVOICELINE TABLE

LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/invoice_line.csv"
INTO TABLE InvoiceLine
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@invoice_line_id, @invoice_id, @track_id, @unit_price, @quantity)
SET invoice_line_id=@invoice_line_id, invoice_id=@invoice_id,
track_id=@track_id, unit_price=@unit_price, quantity=@quantity;

-- PLAYLIST TABLE
LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/playlist.csv"
INTO TABLE Playlist
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@playlist_id, @name)
SET playlist_id = @playlist_id, name = @name;

-- PLAYLISTTRACK TABLE

LOAD DATA LOCAL INFILE "C:/Users/SUHANI PATRA/Downloads/playlist_track.csv"
INTO TABLE PlaylistTrack
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@playlist_id, @track_id)
SET playlist_id = @playlist_id, track_id = @track_id;

-- =============================================================
-- DATA IMPORT USING LOAD DATA LOCAL INFILE
-- =============================================================

-- ================================
-- VERIFY DATA LOADING IN ALL TABLES
-- ================================

SELECT COUNT(*) AS Genre_Count FROM Genre;
SELECT COUNT(*) AS MediaType_Count FROM MediaType;
SELECT COUNT(*) AS PlaylistTrack_Count FROM PlaylistTrack;

SELECT * FROM Genre LIMIT 5;
SELECT * FROM MediaType LIMIT 5;
SELECT * FROM Employee;
SELECT * FROM Customer;
SELECT * FROM Artist;
SELECT * FROM Album;
SELECT * FROM Track LIMIT 5;
SELECT * FROM Invoice LIMIT 5;
SELECT * FROM InvoiceLine LIMIT 5;
SELECT * FROM Playlist;
SELECT * FROM PlaylistTrack;

-- ================================
-- Task Questions 
-- ================================

-- 1. Who is the senior most employee based on job title?  
-- Senior most employee based on job title
SELECT *
FROM Employee
ORDER BY levels DESC
LIMIT 1;

-- 2. Which countries have the most Invoices?
-- Countries with most invoices
SELECT billing_country, COUNT(*) AS total_invoices
FROM Invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;

-- 3. What are the top 3 values of total invoice? 
-- Top 3 invoice totals
SELECT total
FROM Invoice
ORDER BY total DESC
LIMIT 3;

-- 4. Which city has the best customers? - We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals 
--  City with highest total invoice amount
SELECT billing_city, SUM(total) AS total_revenue
FROM Invoice
GROUP BY billing_city
ORDER BY total_revenue DESC
LIMIT 1;

-- 5. Who is the best customer? - The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money
-- Best customer (highest spending)
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 1;

-- 6. Write a query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A 
--  Rock music listeners (email, name, genre)
SELECT DISTINCT c.email, c.first_name, c.last_name, g.name AS genre
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
JOIN Track t ON il.track_id = t.track_id
JOIN Genre g ON t.genre_id = g.genre_id
WHERE LOWER(g.name) = 'rock'
ORDER BY c.email;

SELECT DISTINCT name FROM Genre;
SELECT COUNT(*) FROM TRACK;
SELECT COUNT(*) FROM InvoiceLine;
SELECT COUNT(*) FROM Invoice;

-- 7. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands  
-- Top 10 artists with most rock tracks
SELECT ar.name AS artist_name, COUNT(t.track_id) AS total_tracks
FROM Artist ar
JOIN Album al ON ar.artist_id = al.artist_id
JOIN Track t ON al.album_id = t.album_id
JOIN Genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY ar.artist_id
ORDER BY total_tracks DESC
LIMIT 10;

-- 8. Return all the track names that have a song length longer than the average song length.- Return the Name and Milliseconds for each track. Order by the song length, with the longest songs listed first 
-- Tracks longer than average length
SELECT name, milliseconds
FROM Track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM Track)
ORDER BY milliseconds DESC;

-- 9. Find how much amount is spent by each customer on artists? Write a query to return customer name, artist name and total spent  
--  Amount spent by each customer on artists
SELECT c.first_name, c.last_name, ar.name AS artist_name,
SUM(il.unit_price * il.quantity) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
JOIN Track t ON il.track_id = t.track_id
JOIN Album al ON t.album_id = al.album_id
JOIN Artist ar ON al.artist_id = ar.artist_id
GROUP BY c.customer_id, ar.artist_id
ORDER BY total_spent DESC;

-- 10. We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared, return all Genres 
--  Most popular genre for each country
WITH genre_count AS (
    SELECT c.country, g.name AS genre, COUNT(*) AS purchases,
    RANK() OVER (PARTITION BY c.country ORDER BY COUNT(*) DESC) AS rnk
    FROM Customer c
    JOIN Invoice i ON c.customer_id = i.customer_id
    JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
    JOIN Track t ON il.track_id = t.track_id
    JOIN Genre g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name
)
SELECT country, genre, purchases
FROM genre_count
WHERE rnk = 1;

-- 11. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount
--  Top customer for each country
WITH customer_spending AS (
    SELECT c.country, c.customer_id, c.first_name, c.last_name,
    SUM(i.total) AS total_spent,
    RANK() OVER (PARTITION BY c.country ORDER BY SUM(i.total) DESC) AS rnk
    FROM Customer c
    JOIN Invoice i ON c.customer_id = i.customer_id
    GROUP BY c.country, c.customer_id
)
SELECT country, first_name, last_name, total_spent
FROM customer_spending
WHERE rnk = 1;

-- ================================
-- Some Additional Questions 
-- ================================

-- 1. Customers who spent more than average total spending (SUBQUERY)
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
HAVING total_spent > (
    SELECT AVG(total) FROM Invoice
);


-- 2. Second highest invoice total (SUBQUERY)
SELECT MAX(total) AS second_highest
FROM Invoice
WHERE total < (SELECT MAX(total) FROM Invoice);


-- 3. Total number of tracks per album
SELECT al.title, COUNT(t.track_id) AS total_tracks
FROM Album al
JOIN Track t ON al.album_id = t.album_id
GROUP BY al.album_id
ORDER BY total_tracks DESC;


-- 4. Revenue contribution % of each invoice (WINDOW FUNCTION)
SELECT invoice_id, total,
SUM(total) OVER() AS total_revenue,
(total / SUM(total) OVER()) * 100 AS percentage
FROM Invoice;


-- 5. Rank customers based on spending (WINDOW FUNCTION)
SELECT c.customer_id, c.first_name, c.last_name,
SUM(i.total) AS total_spent,
RANK() OVER (ORDER BY SUM(i.total) DESC) AS rank_position
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id;


-- 6. Top 2 customers from each country (PARTITION BY)
SELECT *
FROM (
    SELECT c.country, c.first_name, c.last_name,
    SUM(i.total) AS total_spent,
    RANK() OVER (PARTITION BY c.country ORDER BY SUM(i.total) DESC) AS rnk
    FROM Customer c
    JOIN Invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id
) ranked
WHERE rnk <= 2;


-- 7. Tracks that were never purchased (LEFT JOIN)
SELECT t.name
FROM Track t
LEFT JOIN InvoiceLine il ON t.track_id = il.track_id
WHERE il.track_id IS NULL;


-- 8. Customers who never made any purchase
SELECT c.customer_id, c.first_name, c.last_name
FROM Customer c
LEFT JOIN Invoice i ON c.customer_id = i.customer_id
WHERE i.customer_id IS NULL;


-- 9. Categorize tracks based on duration (CASE)
SELECT name, milliseconds,
CASE
    WHEN milliseconds < 200000 THEN 'Short'
    WHEN milliseconds BETWEEN 200000 AND 400000 THEN 'Medium'
    ELSE 'Long'
END AS duration_category
FROM Track;


-- 10. Combine customer & employee names (UNION)
SELECT first_name AS name FROM Customer
UNION
SELECT first_name FROM Employee;


-- 11. Customers and their support employee (SELF JOIN concept)
SELECT c.first_name AS customer_name, e.first_name AS support_rep
FROM Customer c
JOIN Employee e ON c.support_rep_id = e.employee_id;


-- 12. Total revenue generated by each artist
SELECT ar.name AS artist_name,
SUM(il.unit_price * il.quantity) AS revenue
FROM Artist ar
JOIN Album al ON ar.artist_id = al.artist_id
JOIN Track t ON al.album_id = t.album_id
JOIN InvoiceLine il ON t.track_id = il.track_id
GROUP BY ar.artist_id
ORDER BY revenue DESC;


-- 13. Create a view for high value customers (VIEW)
CREATE VIEW high_value_customers AS
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
HAVING total_spent > 100;


-- 14. Find customers whose spending is above their country average (WINDOW)
SELECT *
FROM (
    SELECT c.customer_id, c.first_name, c.last_name, c.country,
    SUM(i.total) AS total_spent,
    AVG(SUM(i.total)) OVER (PARTITION BY c.country) AS country_avg
    FROM Customer c
    JOIN Invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id
) t
WHERE total_spent > country_avg;

-- 15. Find duplicate invoice totals (GROUP BY + HAVING)
SELECT total, COUNT(*) AS count_duplicates
FROM Invoice
GROUP BY total
HAVING COUNT(*) > 1;

-- =============================================================
-- END OF SCRIPT
-- =============================================================

-- ##Concepts Covered
-- Used SQL concepts like Joins, Subqueries, Aggregations, and Window Functions to analyze relational data.
-- Implemented data filtering, grouping (GROUP BY), and ranking techniques to extract meaningful insights.
-- Applied Views, CASE statements, and indexing for better query organization and performance.
-- Worked with real-world structured data, ensuring proper relationships using primary and foreign keys.

-- ##Conclusion:
-- This project demonstrates how SQL can be used to derive business insights from raw transactional data.
-- Key insights such as top customers, popular genres, and revenue trends were identified effectively.
-- The analysis helps in understanding customer behavior and sales patterns for better decision-making.
-- Overall, the project strengthens practical knowledge of SQL in a real-world analytics scenario.


