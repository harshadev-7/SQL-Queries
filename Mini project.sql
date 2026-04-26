CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

insert into customers
values(1,'Harsha','harsha07@gmail.com','Nellore'),
(2,'Rahul','Rahul01@gmail.com','Hyderabad'),
(3,'Arul Sundar', 'arulsundar@gmail.com','Tirupati'),
(4,'Hemanth','Hemanthchow@gmail.com','Venkatagiri'),
(5,'Monish','monish01@gmailcom','chitoor'),
(6,'sai','hemanthsai@gamilcom','Tirupati'),
(7,'vignesh','vigneshreddy02@gmail.com','Delhi'),
(8,'Anjali','anjali@gmail.com','Mumbai'),
(9, 'Ravi', 'ravi@gmail.com', 'Delhi'),
(10, 'Pooja', 'pooja@gmail.com', 'Kolkata'),
(11, 'Amit', 'amit@gmail.com', 'Jaipur'),
(12, 'Divya', 'divya@gmail.com', 'Chandigarh'),
(13, 'Nikhil', 'nikhil@gmail.com', 'Noida'),
(14, 'Suresh', 'suresh@gmail.com', 'Lucknow'),
(15, 'Kavya', 'kavya@gmail.com', 'Vizag'),
(16, 'Vikas', 'vikas@gmail.com', 'Indore'),
(17, 'Neha', 'neha@gmail.com', 'Bhopal'),
(18, 'Rohit', 'rohit@gmail.com', 'Nagpur'),
(19, 'Anil', 'anil@gmail.com', 'Surat'),
(20, 'Lakshmi', 'lakshmi@gmail.com', 'Coimbatore');

INSERT INTO books VALUES
(101, 'SQL Basics', 'John Doe', 500, 10),
(102, 'Advanced SQL', 'Jane Smith', 800, 5),
(103, 'Database Design', 'Mike Ross', 600, 7),
(104, 'MySQL Guide', 'Paul Adam', 550, 8),
(105, 'SQL for Beginners', 'Chris Martin', 400, 15),
(106, 'Database Systems', 'Andrew Tanenbaum', 900, 6),
(107, 'Oracle SQL', 'Kevin Brown', 750, 9),
(108, 'PL/SQL Programming', 'Steven Feuerstein', 850, 4),
(109, 'Data Modeling', 'Clive Finkelstein', 650, 10),
(110, 'NoSQL Basics', 'Eric Evans', 500, 12),
(111, 'MongoDB Guide', 'Kristina Chodorow', 700, 7),
(112, 'PostgreSQL Deep Dive', 'Bruce Momjian', 950, 5),
(113, 'SQL Performance Tuning', 'Guy Harrison', 1000, 3);

INSERT INTO orders VALUES
(201, 1, '2026-03-20'),
(202, 2, '2026-03-21'),
(203, 3, '2026-03-22'),
(204, 4, '2026-03-22'),
(205, 5, '2026-03-23'),
(206, 6, '2026-03-23'),
(207, 7, '2026-03-24'),
(208, 8, '2026-03-24'),
(209, 9, '2026-03-25'),
(210, 10, '2026-03-25'),
(211, 11, '2026-03-26'),
(212, 12, '2026-03-26'),
(213, 13, '2026-03-27'),
(214, 14, '2026-03-27'),
(215, 15, '2026-03-28'),
(216, 16, '2026-03-28'),
(217, 17, '2026-03-29'),
(218, 18, '2026-03-29'),
(219, 19, '2026-03-30'),
(220, 20, '2026-03-30');


INSERT INTO order_details VALUES
(1, 201, 101, 2),
(2, 201, 102, 1),
(3, 202, 103, 3),
(4, 203, 104, 1),
(5, 204, 105, 2),
(6, 205, 106, 1),
(7, 206, 107, 3),
(8, 207, 108, 1),
(9, 208, 109, 2),
(10, 209, 110, 1),
(11, 210, 111, 2),
(12, 211, 112, 1),
(13, 212, 113, 1),
(14, 213, 101, 2),
(15, 214, 102, 1),
(16, 215, 103, 3),
(17, 216, 104, 2),
(18, 217, 105, 1),
(19, 218, 106, 2),
(20, 219, 107, 1),
(21, 220, 108, 2);

-- select all customers
SELECT * from customers;

-- get all orders with customers names and book titles
select C.name, O.order_id,B.title,Od.quantity from Customers C
join orders O on C.Customer_id = O.Customer_id 
join order_details Od on O.order_id = Od.order_id
join Books B on B.Book_id = Od.Book_id;

-- find customers who placed order
select name from customers where customer_id in (select customer_id from orders);

-- find books with price higher than average
select title,price from books where price >(select avg(price) from books);

-- index to improve search on book title
create index idx_bookId_title
on books(book_id,title);
show indexes  from books;
select book_id, title from books where book_id = 101 and title = 'SQL Basics';
drop index idx_bookId_title on books;

-- get total orders of a customers
delimiter $$
create procedure get_orders(in customer_id int)
begin
select o.order_id,b.title,od.quantity from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
join books b on b.book_id = od.book_id;
end $$
delimiter ;

call get_orders(1);
drop procedure get_orders;

-- transcations 
set autocommit =0;
set SQL_SAFE_UPDATES = 0;
start transaction;
update books
set stock = stock + 1 where book_id = 101;
update books
set stock = stock + 2 where book_id = 103;
commit;

rollback;
commit;

select book_id , stock from books;


-- total sales per book
select b.title , sum(od.quantity) as total_orders from books b
join order_details od on b.book_id = od.book_id group by b.title;

-- total money spent by each customers
select c.name , sum(b.price * od.quantity) as total_spent from customers c
join orders r on c.customer_id = r.customer_id
join order_details od on od.order_id = r.order_id
join books b on b.book_id = od.book_id group by c.name;

-- top selling book
select b.title, sum(b.price * od.quantity) as total_spent from books b
join order_details od on b.book_id = od.book_id
 group by b.title
 /* having sum(od.quantity) is not null*/
 order by total_spent desc
 limit 1;

-- total no.of  orders placed by each customer
select customer_id , count(order_id)as total_orders from orders group by customer_id ;

-- find customers who placed more than 1 order
select customer_id , count(order_id) as order_t from orders
group by customer_id
having count(order_id)>1;

-- find total quantity sold for each
select book_id , sum(quantity) from order_details
group by book_id; 

-- find books where total sold quantity is greater than 3
select book_id , sum(quantity) as total_sold from order_details
group by book_id 
having sum(quantity) > 3 ;

-- find total renvenue generated by each book and show only with revenue > 1500
select b.title, sum(b.price * od.quantity) as total_spent from books b
join order_details od on b.book_id = od.book_id
group by b.title
having total_spent > 1500;

-- display all orders with name,title,quantity
select c.name,b.title,sum(od.quantity) as quantity from customers c
join orders r on c.customer_id = r.customer_id
join order_details od on r.order_id = od.order_id
join books b on b.book_id = od.book_id
group by c.name,b.title;

-- customers who never placed an order
select c.customer_id ,c.name, r.order_id from customers c
left join orders r on c.customer_id = r.customer_id
where r.order_id is null;

-- books that were never ordered
select b.title , od.order_id from books b
left join order_details od on b.book_id = od.book_id
where od.order_id is null;

-- customer name , total books purchased
select c.name , sum(od.quantity) as total_purchased from customers c
join orders r on c.customer_id = r.customer_id
join order_details od on r.order_id = od.order_id
group by c.name;

-- order id , customer name , total amount per
select r.order_id,c.name,sum(b.price*od.quantity) as total from orders r
join order_details od on r.order_id = od.order_id
join books b on b.book_id = od.book_id
join customers c on c.customer_id = r.customer_id
group by r.order_id,c.name;

-- create stored procedure to get all orders of a given customer
delimiter $$
create procedure get_all_orders(in cust_id int)
begin
select r.order_id,r.customer_id,b.title,od.quantity from orders r
join order_details od on r.order_id = od.order_id
join books b on b.book_id = od.book_id
where r.customer_id = cust_id;
end $$
delimiter ;

drop procedure get_all_orders;
call get_all_orders(1);

-- total sales 
delimiter $$ 
create procedure get_total_price(out total decimal(10,2))
begin
select sum(b.price*od.quantity) into total from books b
join order_details od on b.book_id = od.book_id;
end $$
delimiter ;

call get_total_price(@result);
select @result;

-- insert a new customer
delimiter $$
create procedure insert_newcust(
in cut_id int,
in name varchar(20),
e_id varchar(20),
cities varchar(20) )
begin
insert into customers(customer_id,name,email,city)
values(cut_id, name,e_id,cities);
end $$
delimiter ;
call insert_newcust(21,'steve','steve_r07@gmail.com','New York');
select*from customers;