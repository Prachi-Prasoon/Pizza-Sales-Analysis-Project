SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;


SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza_sales;


SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;


SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;


SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /  
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
AS Avg_Pizzas_per_order 
FROM pizza_sales; 


SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS 
total_orders  
FROM pizza_sales 
GROUP BY DATENAME(DW, order_date);


SELECT DATENAME(MONTH, order_date) as Month_Name, COUNT(DISTINCT order_id) 
as Total_Orders 
from pizza_sales 
GROUP BY DATENAME(MONTH, order_date);


SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as 
total_revenue, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS 
DECIMAL(10,2)) AS PCT 
FROM pizza_sales 
GROUP BY pizza_category; 


SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as 
total_revenue, 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS 
DECIMAL(10,2)) AS PCT 
FROM pizza_sales 
GROUP BY pizza_size 
ORDER BY pizza_size; 


SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold 
FROM pizza_sales 
WHERE MONTH(order_date) = 2 
GROUP BY pizza_category 
ORDER BY Total_Quantity_Sold DESC;


SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY Total_Revenue DESC; 


SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY Total_Revenue ASC; 


SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY Total_Pizza_Sold DESC;

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY Total_Pizza_Sold ASC;


SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY Total_Orders DESC;


SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY Total_Orders ASC;


WITH OrderSizes AS ( 
    SELECT order_id, SUM(quantity) AS total_pizzas 
    FROM pizza_sales 
    GROUP BY order_id 
) 
SELECT  
    CASE  
        WHEN total_pizzas BETWEEN 1 AND 2 THEN 'Small' 
        WHEN total_pizzas BETWEEN 3 AND 5 THEN 'Medium' 
        ELSE 'Large' 
    END AS order_size_segment, 
    COUNT(order_id) AS order_count 
FROM OrderSizes 
GROUP BY  
    CASE  
        WHEN total_pizzas BETWEEN 1 AND 2 THEN 'Small' 
        WHEN total_pizzas BETWEEN 3 AND 5 THEN 'Medium' 
        ELSE 'Large' 
    END; 


SELECT  
pizza_size,  
pizza_category,  
SUM(quantity) AS total_quantity 
FROM pizza_sales 
GROUP BY pizza_size, pizza_category 
ORDER BY pizza_size, pizza_category; 


SELECT  
DATEPART(HOUR, order_time) AS Order_Hour, 
COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales 
GROUP BY DATEPART(HOUR, order_time) 
ORDER BY Order_Hour; 


WITH OrderDayType AS ( 
SELECT  
order_id, 
pizza_category, 
CASE  
WHEN DATENAME(WEEKDAY, order_date) IN ('Saturday', 'Sunday') 
THEN 'Weekend' 
ELSE 'Weekday' 
END AS day_type 
    FROM pizza_sales 
    GROUP BY order_id, pizza_category, order_date 
) 
SELECT  
    day_type, 
    pizza_category, 
    COUNT(DISTINCT order_id) AS total_orders 
FROM OrderDayType 
GROUP BY day_type, pizza_category 
ORDER BY day_type, pizza_category; 