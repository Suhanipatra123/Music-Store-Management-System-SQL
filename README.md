# 🎵 Music Store Data Analysis using SQL

## 📌 Project Overview

This project focuses on analyzing a digital music store database using SQL. It involves designing a relational database, importing large datasets, and performing advanced SQL queries to extract meaningful business insights such as customer behavior, revenue trends, and music preferences.

---

## 🎯 Objective

* Analyze customer purchasing behavior
* Identify top customers, genres, and revenue sources
* Extract business insights using SQL queries
* Strengthen real-world data analysis skills

---

## 🛠️ Tools & Technologies

* **MySQL**
* **SQL**
* **CSV Dataset**

---

## 🧠 Key Concepts Used

* Joins (INNER, LEFT)
* Aggregate Functions (SUM, AVG, COUNT)
* GROUP BY & HAVING
* Subqueries
* Window Functions (RANK, PARTITION BY)
* CASE Statements
* Views & Indexes

---

## 🗂️ Database Schema

The project uses a relational database with multiple interconnected tables:

* Customer
* Invoice
* InvoiceLine
* Track
* Album
* Artist
* Genre
* Employee
* Playlist

Relationships are maintained using **Primary Keys and Foreign Keys**.

---

## 📥 Data Import

Data was imported using:

```sql
LOAD DATA LOCAL INFILE
```

Large datasets like `Track` and `InvoiceLine` were handled carefully to ensure proper data loading.

---

## 📊 Sample SQL Queries

### 🔹 1. Best Customer (Highest Spending)

```sql
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 1;
```

---

### 🔹 2. Top 3 Invoice Totals

```sql
SELECT total
FROM Invoice
ORDER BY total DESC
LIMIT 3;
```

---

### 🔹 3. Most Popular Genre per Country

```sql
SELECT country, genre
FROM (
    SELECT c.country, g.name AS genre,
    RANK() OVER (PARTITION BY c.country ORDER BY COUNT(*) DESC) AS rnk
    FROM Customer c
    JOIN Invoice i ON c.customer_id = i.customer_id
    JOIN InvoiceLine il ON i.invoice_id = il.invoice_id
    JOIN Track t ON il.track_id = t.track_id
    JOIN Genre g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name
) ranked
WHERE rnk = 1;
```

---

### 🔹 4. Tracks Longer than Average

```sql
SELECT name, milliseconds
FROM Track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM Track);
```

---

### 🔹 5. Revenue by Each Artist

```sql
SELECT ar.name, SUM(il.unit_price * il.quantity) AS revenue
FROM Artist ar
JOIN Album al ON ar.artist_id = al.artist_id
JOIN Track t ON al.album_id = t.album_id
JOIN InvoiceLine il ON t.track_id = il.track_id
GROUP BY ar.artist_id
ORDER BY revenue DESC;
```

---

## 📈 Key Insights

* Identified **top customers** based on spending
* Discovered **most popular genres across countries**
* Found **high-revenue cities and artists**
* Analyzed **customer purchase behavior and trends**

---

## 📊 Conclusion

This project demonstrates how SQL can be used to transform raw data into actionable insights. It highlights the importance of data-driven decision-making and showcases strong SQL skills in handling real-world datasets.

---

## 🚀 How to Run the Project

1. Create the database and tables
2. Import CSV files using `LOAD DATA LOCAL INFILE`
3. Execute SQL queries
4. Analyze the results

---

## 📌 Author

**Suhani Patra**

---
