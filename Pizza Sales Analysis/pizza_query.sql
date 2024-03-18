
-- Check the Table --

USE pizza_DB

SELECT *
FROM pizza_sales

--Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

--Average Order Value
SELECT SUM(total_price)/COUNT(DISTINCT(order_id)) as average_order_value
FROM pizza_sales

--Total Quantity Ordered
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales

--Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales

--Average Pizza per order
SELECT CAST(CAST(SUM(quantity) AS decimal(10,2)) / CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS DECIMAL (10,2)) AS Average_Quantity_per_Order
FROM pizza_sales



--Daily and Monthly Trend
--Daily Sales
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

--Monthly Sales
SELECT DATENAME(month, order_date) AS Month, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(month, order_date), MONTH(order_date)
ORDER BY MONTH(order_date)

--Percentage of Sales by Pizza Category
SELECT DISTINCT pizza_category as Pizza_Category, CAST((SUM(total_price) * 100/ (SELECT SUM(total_price) from pizza_sales)) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

--Percentage of Sales by Pizza Size
SELECT pizza_size as Pizza_Size, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size

--Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) AS Toal_Quantity_per_category
FROM pizza_sales
GROUP BY pizza_category

--Top 5 Pizza purchase
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--Bottom 5 Pizza by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

--Top 5 Pizza by Quantity Sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity_Sold DESC

--Bottom 5 Pizza by Quantity Sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity_Sold ASC