-- Create Database
CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;
 

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


 


-- 1) Retrieve all books in the "Fiction" genre:
SELECT *FROM Books
where Genre="fiction";


-- 2) Find books published after the year 1950:
select * from Books
where Published_Year= 1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers
where city="Canada";

-- 4) Show orders placed in November 2023:
select* from orders
where Order_date>= "2022-09-01";

-- 5) Retrieve the total stock of books available:
select sum(Stock) from Books;

-- 6) Find the details of the most expensive book:
select max(Price) from Books;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from Books
where Stock>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select *from  Books
where Price>20;

-- 9) List all genres available in the Books table:
select count(Genre) from Books;
 

-- 10) Find the book with the lowest stock:

select min(Stock) from Books;
-- 11) Calculate the total revenue generated from all orders:
select sum(Total_amount) from Orders;
-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

select Genre , sum(Stock) as total_number
from Books
group by Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select Genre , avg(Stock)
from Books
where Genre="Fantasy";



-- 3) List customers who have placed at least 2 orders:
select *from Orders
where Quantity>=2;

-- 4) Find the most frequently ordered book:
SELECT Book_id, Title, COUNT(*) AS order_count
FROM Books
GROUP BY book_id, Title
ORDER BY order_count DESC
LIMIT 1;
-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT Title, Price
FROM Books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:
SELECT Author, SUM(Stock) AS total_quantity_sold
FROM Books
GROUP BY Author;

-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.City
FROM Customers c
JOIN Orders o
    ON c.Customer_id = o.Customer_id
GROUP BY c.Customer_id, c.City
HAVING SUM(o.total_amount) > 30;

-- 8) Find the customer who spent the most on orders:
SELECT c.Customer_id, c.City, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.City
ORDER BY total_spent DESC
LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT
    b.Book_id,
    b.Title,
    b.Stock - COALESCE(SUM(o.Stock), 0) AS stock_remaining
FROM Books
LEFT JOIN Orders
    ON b.Book_id = o.Book_id
GROUP BY b.Book_id, b.Title, b.Stock;






