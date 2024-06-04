SELECT * FROM amazon.amazon;
#Sales Trends Over Time:
SELECT DATE_FORMAT(date, '%Y-%m') AS Month, SUM(total) AS Total_Sales
FROM amazon.amazon
GROUP BY Month
ORDER BY Month;

#Top-Selling Products:
SELECT `Product line`, SUM(quantity) AS Total_Quantity, SUM(total) AS Total_Revenue
FROM amazon.amazon
GROUP BY `Product line`
ORDER BY Total_Revenue DESC;

#Seasonal Trends:

SELECT MONTH(date) AS Month, SUM(total) AS Total_Sales
FROM amazon.amazon
GROUP BY Month
ORDER BY Month;

#Customer Segmentation:
SELECT Gender, SUM(total) AS Total_Sales
FROM amazon.amazon
GROUP BY Gender;

#Effectiveness of Sales Strategies:
#This would depend on specific strategies implemented, but you could analyze the impact of promotions or marketing campaigns by comparing sales before and after implementation.

#Sales Channels:
SELECT Branch, SUM(total) AS Total_Sales
FROM amazon.amazon
GROUP BY Branch;

#Product Mix Analysis:
SELECT `Product line`, SUM(quantity) AS Total_Quantity, SUM(total) AS Total_Revenue
FROM amazon.amazon
GROUP BY `Product line`
ORDER BY Total_Revenue DESC;

#Forecasting
SELECT DATE_FORMAT(date, '%Y-%m') AS Month, SUM(total) AS Total_Sales
FROM amazon.amazon
WHERE date >= CURDATE() - INTERVAL 6 MONTH
GROUP BY Month
ORDER BY Month;
