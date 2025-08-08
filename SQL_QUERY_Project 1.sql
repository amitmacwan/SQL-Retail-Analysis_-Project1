###SQL Retail Sales Analysis###

#Create table

create table retail_sales 
(transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(10),
age int,	
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

select*from retail_sales limit 10;
select count(*)from retail_sales ;

#Data Cleaning

#find out null values

select*from retail_sales 
where 
transactions_id is null 
or 
sale_date is null 
or 
sale_time is null 
or 
customer_id is null
or 
gender is null
or 
age is null
or 
category is null
or 
quantiy is null
or 
price_per_unit is null
or 
cogs is null
or 
total_sale is null;

#Delete null data

Delete from retail_sales 
where 
transactions_id is null 
or 
sale_date is null 
or 
sale_time is null 
or 
customer_id is null
or 
gender is null
or 
category is null
or 
quantiy is null
or 
price_per_unit is null
or 
cogs is null
or 
total_sale is null;

#Data Exploration

#How many unique Customers are there in the data?

Select distinct(customer_id) as customers from retail_sales;

#How many items Categories we have in the data?

Select distinct(category) as products from retail_sales;

Q.1 write a SQL query to retrieve all columns for sales made on 2022-11-05

select*from retail_sales where sale_date = '2022-11-05';

Q.2 write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity is more than 3 in the month of Nov-2022

#checking how many quantity sold in clothing
Select category, Sum(quantiy) from retail_sales where category = 'Clothing'  group by category;

Select*from retail_sales
where category = 'Clothing'
and
To_char(sale_date,'YYYY-MM') = '2022-11'
and 
quantiy >= 3;

Q.3 Write a SQL query to calculate the total sales (total_sale) for each category

Select category,Sum(total_sale) as total_sales from retail_sales group by Category

# for total orders 
Select category,Sum(total_sale) as total_sales, Count(*) as Total_orders from retail_sales group by Category;

Q.4 Write a SQL query  to find the average age of customers who purchased items from the 'Beauty' category

Select Round(avg(age), 0) as avg_age from retail_sales where category = 'Beauty'

Q.5 Write a SQL Query to find all transactions where the total_sale is greater than 1000

Select*from retail_sales where total_sale > 1000;

Q.6 Write a SQL query to find the total number of transactions made by each gender in each category.

Select category,gender, count(*) as total_trans from retail_sales group by category, gender order by 1;

Q.7 Write a SQL query to calculate the average sale for each month.find out best selling month in each year
# Note for extraction we can write year(sale_date) in MySQL
# as CTE needs to be created because where function cannot be applied when a new column is created

Select*from
(
select extract(year from sale_date)as year, 
extract(month from sale_date) as month,
avg (total_sale)as avg_sales,
Rank()over(partition by extract(year from sale_date) order by avg (total_sale)desc) as Rank
from retail_sales group by 1,2 
) as A1
Where Rank = 1

order by 1,3 desc;

Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

Select customer_id, 
sum(total_sale) as total_sales 
from retail_sales 
group by customer_id 
order by 2 desc limit 5

Q.9 Write a SQL query to find the number of unique customers who purchased items from each category

Select category, count(distinct customer_id) as unique_customers
from retail_sales
group by Category

Q.10 Write a SQL query to create each shift and number of orders (Example morning <=12, Afternoon Between 12 to 17, Evening >17)

With hourly_sale
As
(Select *,
Case
    When extract(Hour from sale_time) <12 then 'Morning'
	When extract(Hour from Sale_time) Between 12 and 17 then 'Afternoon'
	else 'Evening'
	End as Shift
From Retail_sales
)
Select shift, count(transactions_id) as orders from hourly_sale group by shift

Q.11 Write a SQL query to find out profit margin for each category

Select category, 
SUM(price_per_unit - cogs) / SUM(price_per_unit) * 100 as Profit_margin
from retail_sales group by category 

###End of Project###