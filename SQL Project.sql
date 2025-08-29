CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,       -- Unique ID auto increment
    title VARCHAR(255) NOT NULL,      -- Book Title
    author VARCHAR(150) NOT NULL,     -- Author Name
    genre VARCHAR(100),               -- Genre / Category
    published_year INT,               -- Year of Publishing
    price NUMERIC(10,2),              -- Price with decimal e.g. 499.99
    stock INT                         -- Number of copies available
);


select *
from books;

CREATE TABLE customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE,
    Phone VARCHAR(20),
    City VARCHAR(100),
    Country VARCHAR(100)
);

select *
from customers;

CREATE TABLE orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Book_ID INT NOT NULL,
    Order_Date DATE NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    Total_Amount NUMERIC(10,2) CHECK (Total_Amount >= 0),
    FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID),
    FOREIGN KEY (Book_ID) REFERENCES books(Book_ID)
);


select *
from orders;

select *
from customers;

select *
from books;

--///////////////// Basic Question  /////////////////////

-- Ye query "books" table se wohi rows nikalti hai jahan genre 'Fiction' ho.
-- Matlab: sirf Fiction category ki books ka data show karegi.

select *
from books
where genre='Fiction';

-- Ye query "books" table se sirf un books ka data nikalti hai
-- jo 1995 ke baad publish hui hain.

select *
from books
where published_year>1995;

-- Ye query "customers" table se un customers ka data nikalti hai  
-- jo Denmark country ke andar rehte hain.  

select *
from customers
where country='Denmark';

-- Ye query "orders" table se un orders ka data nikalti hai  
-- jo 1 November 2023 se 30 November 2023 ke darmiyan kiye gaye hain.  

select *
from orders
where order_date between '2023-11-01' and '2023-11-30';

-- Ye query "books" table me sabhi books ka stock jor kar total nikalti hai.  
-- Result ek column "total_stock" ke naam se show hoga.  

select sum(stock) as total_stock
from books;

-- Ye query "books" table se data nikalti hai.  
-- Phir price ke hisaab se sasti se mehngi (ASC = ascending) order me lagati hai.  
-- Aur sirf pehli 50 books show karti hai.  

select *
from books
order by price ASC limit 50;

-- Ye query "orders" table se un records ko nikalti hai
-- jahan quantity 5 se zyada hai.

select *
from orders
where  quantity>5;

-- Ye query "orders" table se un records ko nikalti hai  
-- jahan total_amount 100 se zyada hai.  

select *
from orders
where  total_amount>100;

-- Ye query "books" table se sirf unique genres nikalti hai.  
-- Matlab: agar koi genre bar-bar repeat ho raha hai to usay sirf ek dafa show karegi. 

select distinct genre
from books;

-- Ye query "books" table se sirf stock column nikalti hai  
-- Aur stock ko chhoti se badi value (ascending order) me arrange karti hai.  

select stock 
from books
order by stock;

-- Ye query "orders" table me sabhi orders ke total_amount ko jor kar  
-- ek total nikalti hai aur uska naam "revnue" rakhti hai.  

select sum(total_amount) as revnue
from orders;

-- /////////////////  Advance Question  //////////////////////


-- Retrive all no of book sold each genre

-- Ye query "orders" table (o) aur "books" table (b) ko join karti hai  
-- dono tables ko book_id ke zariye connect kar ke.  
-- Phir har genre ke hisaab se total kitni books bikin (sum of quantity) ka record banati hai.  
-- Result me har genre ke sath uska total_book_sold show hoga.  

select b.genre, sum(o.Quantity) as total_book_sold
from orders o join books b on o.book_id=b.book_id
group by b.genre;

--  Find Average price of book in 'fantasy' genre?

select avg(price) as average_price
from books
where genre='Fantasy';

-- list costumer place at least 2 orders?

select customer_id, count(order_id) as order_count
from orders
group by customer_id
having count(order_id)>=2;

-- list costumer place at least 2 orders with name ?

select o.customer_id,c.name, count(o.order_id) as order_count
from orders o join customers c on o.customer_id=c.customer_id
group by o.customer_id, c.name
having count(o.order_id)>=2;

-- Find most frequantly book order with book name ?
-- Ye query "orders" table se har book_id ke liye count karti hai  
-- ke us book par kitne orders aaye (order_id ki ginti).  

select o.book_id,b.title, count(order_id) as order_book
from orders o join books b on o.book_id=b.book_id
group by o.book_id,b.title
order by order_book desc;

-- Show 3 most expensive books of 'fantasy' gerne ?

select *
from books
where genre='Fantasy'
order by price desc limit 3;

-- Retrive total quantity of books sold by eash auther ?

select b.author, sum(o.quantity) as quantity_sold
from orders o join books b on o.book_id=b.book_id
group by b.author;


-- List the city where customers spent more then 30$ ?

select distinct c.city, total_amount
from orders o join customers c on o.customer_id=c.customer_id
where o.total_amount>30;


-- find customer who spent more then most on  orders ?

select c.customer_id,c.name, sum(total_amount) as total_spent
from orders o join customers c on o.customer_id=c.customer_id
group by c.customer_id,c.name
order by total_spent desc;

-- calculate the remaing total and sold stock  ?


select 
    b.book_id,  b.title,b.stock as total_stock, coalesce(sum(o.quantity), 0) as sold_stock,       
    b.stock - coalesce(sum(o.quantity), 0) as remaining_stock 
from books b left join orders o on b.book_id = o.book_id
group by b.book_id, b.title, b.stock;






