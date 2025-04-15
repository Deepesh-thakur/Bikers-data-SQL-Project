create database aditya


--drop database
drop database bikestores
--drop schema
drop schema sales

drop schema Production
--drop tables
drop table if exists sales.orders_items
drop table if exists sales.orders
drop table if exists sales.customersbb
drop table if exists sales.stores
drop table if exists sales.staff
drop table if exists production.products
drop table if exists production.stocks
drop table if exists production.brands
drop table if exists production.categories


--1 Create database
create database Bikestores
--2
use Bikestores

--3 create schemas
--production
create schema Production 
go
--Sales
create schema Sales
go

--4 create table
create table production.categories(
	Category_id int identity (1,1) Primary Key,
	Category_name varchar(255) not null)

select * from production.categories

--insert data

insert into production.categories(category_name)
values
	('Children Bicycles'),
	('Comfort Bicycles'),
	('Cruisers Bicycles'),
	('Cyclocross Bicycles'),
	('Electric Bikes'),
	('Mountain Bikes'),
	('Road Bikes')

--5 create brands table
create table production.brands(
	Brand_id int identity (1,1) primary key,
	Brand_name Varchar (255) not null)

select * from production.Brands

--insert data

insert into production.Brands(Brand_name)
values
	('Electra'),
	('Haro'),
	('Heller'),
	('Pure Cycles'),
	('Ritchey'),
	('Strider'),
	('Sun Bicycles'),
	('Surly'),
	('Trek')

--6 create products table
create table production.Products(
	Product_id int identity (1,1) primary key,
	Product_name Varchar (255) not null,
	brand_id int not null,
	category_id int not null,
	model_year smallint not null,
	list_price Decimal (10,2) not null,
	foreign key (category_id) references production.categories (category_id) on delete cascade on update cascade,
	foreign key (Brand_id) references production.Brands (Brand_id) on delete cascade on update cascade)


select * from production.Products

--insert data

bulk insert production.Products
from 'E:\adi\sql\Products.csv'
with(
fieldterminator = ',',
rowterminator = '\n',
firstrow =2)

--7 create table customers
create table Sales.Customers(
	Customer_id int identity (1,1) primary key,
	First_Name Varchar (50) not null,
	Last_Name Varchar (50) not null,
	Phone varchar(25),
	Email varchar(255),
	Street varchar(255),
	City varchar(255),
	State varchar(10),
	Zip_code varchar(5))


select * from Sales.customers

--insert data

bulk insert Sales.customers
from 'E:\adi\sql\Customers.csv'
with(
fieldterminator = ',',
rowterminator = '\n',
firstrow =2)

--8 create stores table
create table Sales.Stores(
	Store_id int identity (1,1) primary key,
	Store_name Varchar (255) not null,
	Phone varchar(25),
	Email varchar(255),
	Street varchar(255),
	City varchar(255),
	State varchar(10),
	Zip_code varchar(5))

drop table sales.stores
select * from Sales.Stores

--insert data

insert into sales.stores(store_name,Phone,Email,Street,City,State,Zip_code)
Values('Bhopal Rockers Bikes','(831) 476-4321','bhopalrockers@bikes.shop','3700 VIP Drive','Bhopal','MP',95060),
	('Gopal Bikes','(516) 379-8888','gopal@bikes.shop','4200 Old Shopping Mall','Mumbai','MH',11432),
	('ROwlett Bikes','(972) 530-5555','rowlett@bikes.shop','8000 Fairway Avenue','Gujrat','GU',75088)

	
--9 create stocks table
create table production.Stocks(
	Store_id int,
	Product_id int,
	Quantity int,
	primary key (store_id,product_id),


	foreign key (store_id) references sales.stores (store_id) on delete cascade on update cascade,
	foreign key (product_id) references production.Products (Product_id) on delete cascade on update cascade)


select * from production.Stocks

--insert data

bulk insert Production.Stocks
from 'E:\adi\sql\Stocks.csv'
with(
fieldterminator = ',',
rowterminator = '\n',
firstrow =2)

--10 create stores staff
create table Sales.Staff(
	Staff_id int identity (1,1) primary key,
	First_Name Varchar (50) not null,
	Last_Name Varchar (50) not null,
	Email varchar(255) not null unique,
	Phone varchar(25),
	Active tinyint not null,
	Store_id int not null,
	Manager_id int,
	foreign key (store_id) references sales.stores (store_id) on delete cascade on update cascade,
	foreign key (manager_id) references sales.staff (staff_id) on delete no action on update no action)

select * from Sales.Staff

--insert data

insert into sales.staff(first_name,last_name,email,phone,active,store_id,manager_id)
Values
	('Abhishek','Patil','abhishek.patil@bikes.shop','(831) 555-5554',1,1,NULL),
	('Palak','Tiwari','palak.tiwari@bikes.shop','(831) 555-5555',1,1,1),
	('Ganesh','Sharma','ganesh.sharma@bikes.shop','(831) 555-5556',1,1,2),
	('Vivek','Patel','vivek.patel@bikes.shop','(831) 555-5557',1,1,2),
	('Jannette','David','jannette.david@bikes.shop','(516) 379-4444',1,2,1),
	('Mahesh','Gupta','mahesh.gupta@bikes.shop','(516) 379-4445',1,2,5),
	('Vinita','Daniel','vinita.daniel@bikes.shop','(516) 379-4446',1,2,5),
	('Kapil','Vargas','kapil.vargas@bikes.shop','(972) 530-5555',1,3,1),
	('Layle','Terrell','layle.terrell@bikes.shop','(972) 530-5556',1,3,7),
	('Bhagat','Pal','bhagat.pal@bikes.shop','(972) 530-5557',1,3,7)



--11 create table orders

create table sales.Orders(
	Order_id int identity (1,1) primary key,
	Customer_id int,
	Order_Status tinyint not null,
	-- Order Status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	Order_Date DATE not null,
	Required_Date DATE not null,
	Shipped_Date DATE,
	Store_id int not null,
	Staff_id int not null,
	foreign key (customer_id) references sales.customers (customer_id) on delete cascade on update cascade,
	foreign key (store_id) references sales.stores (store_id) on delete cascade on update cascade,
	foreign key (staff_id) references sales.staff (staff_id) on delete no action on update no action)


select * from sales.Orders

--insert data

bulk insert sales.Orders
from 'E:\adi\sql\orders.csv'
with(
fieldterminator = ',',
rowterminator = '\n',
firstrow =2)

--12 create table order_items

create table sales.Order_items(
	Order_id int,
	item_id int,
	Product_id int not null,
	Quantity int not null,
	list_price Decimal (10,2) not null,
	discount Decimal (4,2) not null default 0,
	primary key (order_id,item_id),
	foreign key (order_id) references sales.orders (order_id) on delete cascade on update cascade,
	foreign key (product_id) references production.products (product_id) on delete cascade on update cascade)


select * from sales.Order_items

--insert data

bulk insert sales.Order_items
from 'E:\adi\sql\orders_items.csv'
with(
fieldterminator = ',',
rowterminator = '\n',
firstrow =2)

select * from production.categories
select * from production.Brands
select * from production.Products
select * from Sales.customers
select * from Sales.Stores
select * from production.Stocks
select * from Sales.Staff
select * from sales.Orders
select * from sales.Order_items

--Q.1 Give the list of products name,category name and list price

Select * from 
	production.products p
	inner join production.categories c
	On c.category_id = p.category_id
	order by product_name desc

--with required field selection

Select Product_name,Category_name,list_price from 
	production.products p
	inner join production.categories c
	On c.category_id = p.category_id
	order by product_name desc

-- With brand name

Select Product_name,Category_name,Brand_name,list_price from 
	production.products p
	inner join production.categories c
	On c.category_id = p.category_id
	inner join production.brands b
	On b.brand_id = p.brand_id
	order by product_name desc

--Q.2 GIve the list of products 
--step 1
Select product_name,Order_id
	from production.products p
	left join sales.order_items o
	on o.product_id=p.product_id
	order by order_id

Select product_name,Order_id
	from production.products p
	left join sales.order_items o
	on o.product_id=p.product_id
	where order_id is null
	order by order_id


--Q.3 Give the product name along with order details like order id,item id and the order date.

Select product_name,i.Order_id,Item_id,Order_date
	from production.products p
	left join sales.order_items i
	on i.product_id=p.product_id
	left join sales.orders o
	on i.order_id=o.order_id
	order by order_id

--where order id 100
Select product_name,i.Order_id,Item_id,Order_date
	from production.products p
	left join sales.order_items i
	on i.product_id=p.product_id
	left join sales.orders o
	on i.order_id=o.order_id
	where i.order_id=100
	order by order_id

--if you change order then give different result
Select product_name,i.Order_id,Item_id,Order_date
	from sales.orders o
	left join sales.order_items i
	on i.order_id=o.order_id
	left join production.products p
	on i.product_id=p.product_id
	order by order_id

Select product_name,i.Order_id,Item_id,Order_date
	from production.products p
	left join sales.order_items i
	on i.product_id=p.product_id
	left join sales.orders o
	on i.order_id=o.order_id
	and i.order_id=100
	order by order_id

--Q.4 

--cross join
select product_id,product_name,store_id, 0 as quantity
	from production.products
	cross join sales.stores
	order by Product_name,store_id

--self join
select 
	e.first_name+' '+e.last_name employee,
	m.first_name+' '+m.last_name manager
from 
	sales.staff e
	inner join sales.staff m
	on m.staff_id = e.manager_id

--
select 
	e.first_name+' '+e.last_name employee,
	m.first_name+' '+m.last_name manager
from 
	sales.staff e
	left join sales.staff m
	on m.staff_id = e.manager_id

select c1.city,
	c1.first_name+' '+c1.last_name customer_1,
	c2.first_name+' '+c2.last_name customer_2
from 
	sales.customers c1
	inner join sales.customers c2
	on c1.customer_id <> c2.customer_id
	and c1.city=c2.city
order by city,customer_1,Customer_2


--VIEW

CREATE VIEW sales.product_info
AS
SELECT
	Product_name,Brand_name,list_price
FROM
	production.products p
	inner join production.brands b
	On b.brand_id = p.brand_id
	--order by product_name desc

select *from sales.product_info
where list_price>=1000

--create view with agrregation function()

CREATE VIEW sales.daily_sales
AS
SELECT
	year (order_date) AS y,
	month (order_date) as m,
	day (order_date) as d,
	p.product_id,
	p.product_name,
	quantity * i.list_price as Sales
FROM
	sales.orders as o
	inner join sales.order_items AS i
	ON o.order_id = i.order_id
	inner join production.products as p
	on p.product_id= i.product_id

select * from sales.daily_sales

select product_name,Sales from sales.daily_sales
	where product_id  between 8 and 10 
	and sales >1500


--stored procedure

drop procedure uspEmployeeManager
drop procedure uspFindProducts


CREATE PROCEDURE uspEmployeeManager 
AS
select 
	e.first_name+' '+e.last_name employee,
	m.first_name+' '+m.last_name manager
FROM 
	sales.staff e
	left join sales.staff m
	on m.staff_id = e.manager_id
	order by manager;
GO;

CREATE PROCEDURE uspEmployeeManager 
AS
BEGIN
select 
	e.first_name+' '+e.last_name employee,
	m.first_name+' '+m.last_name manager
FROM 
	sales.staff e
	left join sales.staff m
	on m.staff_id = e.manager_id
	order by manager;
END

EXEC uspEmployeeManager;

CREATE PROCEDURE uspFindProducts
AS
BEGIN
select 
	Product_name,list_price
FROM 
	production.products
	order by list_price
END

EXEC uspFindProducts

select 
	Product_name,list_price
FROM 
	production.products
	Where list_price >=100
	
	order by list_price

ALTER PROCEDURE uspFindProducts(@min_list_price as decimal)
AS
BEGIN
select 
	Product_name,list_price
FROM 
	production.products
	Where list_price >=@min_list_price
	order by list_price
END
--with parameter
EXEC uspFindProducts 100


--with multi parameter
ALTER PROCEDURE uspFindProducts(@min_list_price as decimal,@max_list_price as decimal)
AS
BEGIN
select 
	Product_name,list_price
FROM 
	production.products
	Where list_price >=@min_list_price
	and list_price >=@max_list_price
	order by list_price
END

--
EXEC uspFindProducts 100,400

ALTER PROCEDURE uspFindProducts(@min_list_price as decimal,@max_list_price as decimal, @name as Varchar(max))
AS
BEGIN
select 
	Product_name,list_price
FROM 
	production.products
	Where list_price >=@min_list_price
	and list_price >=@max_list_price
	and product_name like '%' + @name + '%'
	order by list_price
END

--
EXEC uspFindProducts 100,400,Trek

EXEC uspFindProducts
	@max_list_price = 1000,
	@min_list_price= 900,
	@name = 'Trek'

--INDEXES

create index ix_customers_city
on sales.customers(city)

--drop index
drop index ix_customers_city on sales.customers
drop index multi_index_data on sales.customers
drop index if exists ix_customers_first_name on sales.customers


--show index from ix_customers_city
--verification

EXEC sys.sp_helpindex @objname = N'sales.customers'

--create index statement to create index for one column
create index ix_customers_first_name
on sales.customers(first_name)

--create index on multiple fields
create index multi_index_data
on sales.customers(first_name,last_name)

--Unique index
create unique index unique_id --ERROR
on sales.customers(city)

create unique index unique_customer_id
on sales.customers(customer_id)

EXEC sys.sp_helpindex @objname = N'sales.customers'

--non clusterd Index

create  nonclustered index NON_CLU_ID
on sales.customers(customer_id ASC)

select * from Sales.customers

--clusterd Index
create clustered index Mul_cust_ix
on sales.customers(first_name,city ASC)

select * from Sales.customers

drop index PK__Customer__8CB382B1A3E1229D on sales.customers



--Variables

declare @model_year smallint
set @model_year= 2019
select product_name,model_year,List_price from production.products
where Model_year = @model_year
order by product_name


declare @product_count int
set @Product_count = (
	select
		count(*)
	from 
		production.products)
Print 'The number of products is ' + Cast (@product_count as Varchar(MAX))


--transaction
select * from customers

--begin transaction
BEGIN TRANSACTION
Update Customers
Set age = 25 where Name ='Narendra'

--
rollback


--begin transaction
BEGIN TRANSACTION
Update Customers
Set age = 25 where Name ='Narendra'

--
commit
rollback

begin try
	begin transaction
	update customers set salary = 15000 where age>25
	update customers set salary = 10000 where age<25
	commit
print 'Transaction commited'
end try
begin catch
	rollback
print 'catch block is hit - transaction rollbacked'

	declare @error_message varchar(MAX)
	set @error_message = ERROR_MESSAGE()
	select @error_message as error_messages
end catch

select * from customers


save transaction save1
begin transaction
go
insert into customers
values(8,'Shivam',42,'gwalior',17000)
save transaction save2


begin transaction
go
insert into customers
values(9,'Akihl',42,'Sagar',19000)
save transaction save3

--delete from customers where id in (8)

rollback transaction save1

rollback transaction save2

rollback transaction save3