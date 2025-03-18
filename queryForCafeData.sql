use eda_practice;

select * from dirty_cafe_sales;

-- 1.Remove Duplicates
-- 2.Standardize the Data
-- 3.Null values or blank values
-- 4.Remove any Columns

create table dirty_cafe_sales_staging
like dirty_cafe_sales;

select * from dirty_cafe_sales_staging;

insert dirty_cafe_sales_staging
select * from dirty_cafe_sales;

-- renaming column name to remove space between name
alter table dirty_cafe_sales_staging
change `Transaction ID` Transaction_ID text;

alter table dirty_cafe_sales_staging
change `Price Per Unit` Price_per_unit double;


-- 1. remove duplicates
select *, 
row_number() over(
partition by Transaction_ID, Item, Quantity, Price_per_unit, `Total Spent`, `Payment Method`, Location, `Transaction Date`) as row_num
from dirty_cafe_sales_staging;

with duplicate_cte as
(
select *, 
row_number() over(
partition by Transaction_ID, Item, Quantity, Price_per_unit, `Total Spent`, `Payment Method`, Location, `Transaction Date`) as row_num
from dirty_cafe_sales_staging
)
select *
from duplicate_cte
where row_num > 1;