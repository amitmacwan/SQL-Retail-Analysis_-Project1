# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_Project1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project was performed using pgAdmin4 graphical interface connected to a Postgre server,with an aim of applying the SQL Skills on small retail dataset.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided retail_sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the structure of the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_Project1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table includes columns for transactions ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE SQL_Project1 ;

create table retail_sales 
(
transactions_id int primary key,
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
- **Distinct Count**: Determine the total number of Unique records in the dataset.
- **Category Count**: Determine the total number of Unique Categories present in the dataset.

```sql
select count(*)from retail_sales ;

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

Select distinct(customer_id) as customers from retail_sales;

Select distinct(category) as products from retail_sales;


```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select*from retail_sales where sale_date = '2022-11-05';
```

2. **write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity is more than 3 in the month of Nov-2022**:
```sql
Select*from retail_sales
where category = 'Clothing'
and
To_char(sale_date,'YYYY-MM') = '2022-11'
and 
quantiy >= 3;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
Select category,Sum(total_sale) as total_sales from retail_sales group by Category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category**:
```sql
Select Round(avg(age), 0) as avg_age from retail_sales where category = 'Beauty';
```

5. **Write a SQL Query to find all transactions where the total_sale is greater than 1000**:
```sql
Select*from retail_sales where total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions made by each gender in each category.**:
```sql
Select category,gender, count(*) as total_trans
from retail_sales group by category, gender order by 1;
```

7. **Write a SQL query to calculate the average sale for each month.find out best selling month in each year**:
```sql
Select*from
(
select extract(year from sale_date)as year, 
extract(month from sale_date) as month,
avg (total_sale)as avg_sales,
Rank()over(partition by extract(year from sale_date) order by avg (total_sale)desc) as Rank
from retail_sales group by 1,2 
) as A1
Where Rank = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
Select customer_id, 
sum(total_sale) as total_sales 
from retail_sales 
group by customer_id 
order by 2 desc limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category**:
```sql
Select category, count(distinct customer_id) as unique_customers
from retail_sales
group by Category;
```

10. **Write a SQL query to create each shift and number of orders (Example morning <=12, Afternoon Between 12 to 17, Evening >17)**:
```sql
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
Select shift, count(transactions_id) as orders from hourly_sale group by shift;
```
11. **Write a SQL query to find out profit margin for each category**:
```sql
Select category, 
SUM(price_per_unit - cogs) / SUM(price_per_unit) * 100 as Profit_margin
from retail_sales group by category;
```


## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Electronics,Clothing,Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating high value purchases across categories.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons for better sales and profit margin.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.
- **Profit Margin Insights**: Reports on Profit Margin gained per each category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, consumer behavior, and product performance.

## Author - Amit Macwan

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, please feel free to reach me out

- **LinkedIn**:(https://linkedin.com/in/amit-macwan-analyst)
