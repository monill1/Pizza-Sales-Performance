USE [Pizza DB]
SELECT * FROM pizza_sales

-- 1. Total revenue genrated

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

-- 2. Average Order Value

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value FROM pizza_sales 

-- 3. Total Pizzas Sold

SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales

-- 4. Total Orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales

-- 5. Average Pizzas per order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_pizzas_per_order 
FROM pizza_sales



-- Chart Requirement

-- 1. Daily Trend for Total Orders:

SELECT DATENAME(DW, order_date) as Order_Day, COUNT(DISTINCT order_id) Total_Orders FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- 2. Monthly Trends for total orders

SELECT DATENAME(MM, order_date) as Order_Month, COUNT(DISTINCT order_id) Total_Orders, 
(SUM(total_price) / COUNT(DISTINCT order_id)) * COUNT(DISTINCT order_id) AS Revenue_per_Month FROM pizza_sales
GROUP BY DATENAME(MM, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC

SELECT DATENAME(Y, order_date) as Order_Day, COUNT(DISTINCT order_id) Total_Orders FROM pizza_sales
GROUP BY DATENAME(Y, order_date)
ORDER BY COUNT(DISTINCT order_id) 

-- 3. Percentage of Sales by Pizza Category:

SELECT pizza_category, SUM(Total_Price) * 100 / (SELECT SUM(Total_Price) FROM pizza_sales) AS PCT_CatWise
FROM pizza_sales
GROUP BY pizza_category

SELECT pizza_category, SUM(Total_Price) AS Total_Sales, 
SUM(Total_Price) * 100 / (SELECT SUM(Total_Price) FROM pizza_sales) AS PCT_CatWise
FROM pizza_sales
GROUP BY pizza_category

SELECT pizza_category, SUM(Total_Price) AS Total_Sales, 
SUM(Total_Price) * 100 / (SELECT SUM(Total_Price) FROM pizza_sales) AS PCT_CatWise
FROM pizza_sales
WHERE MONTH(order_date) = 7
GROUP BY pizza_category

-- 4. Percentage of Sales by pizza size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT_Sizewise
FROM pizza_sales
GROUP BY pizza_size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT_Sizewise
FROM pizza_sales
WHERE MONTH(order_date) = 8
GROUP BY pizza_size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 8) AS DECIMAL(10,2)) AS PCT_Sizewise
FROM pizza_sales
WHERE MONTH(order_date) = 8
GROUP BY pizza_size
ORDER BY PCT_Sizewise DESC

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER,order_date) = 1) AS DECIMAL(10,2)) AS PCT_Sizewise
FROM pizza_sales
WHERE DATEPART(QUARTER,order_date) = 1
GROUP BY pizza_size
ORDER BY PCT_Sizewise DESC


-- 5. Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- 6. Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders

SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC


-- By Quantity top 5

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity DESC

-- By Quantity bottom 5

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity ASC

-- By Orders top 5

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Order FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Order DESC

-- By Orders Bottom 5

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Order FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Order ASC