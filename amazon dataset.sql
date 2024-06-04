SELECT * FROM amazon.amazon;

SHOW COLUMNS FROM amazon.amazon;

#Add a new column named timeofday to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
SET SQL_SAFE_UPDATES = 0;UPDATE amazon.amazon SET timeofday = 
CASE WHEN HOUR(time) < 12 THEN 'Morning'WHEN HOUR(time) >= 12 AND HOUR(time) < 18 THEN 'Afternoon'
ELSE 'Evening'END;SET SQL_SAFE_UPDATES = 1;

# Add a new column named dayname that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
SET SQL_SAFE_UPDATES = 0;UPDATE amazon.amazon
SET dayname = DAYNAME(date);SET SQL_SAFE_UPDATES = 1;

#Add a new column named monthname that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.
SET SQL_SAFE_UPDATES = 0;UPDATE amazon.amazon
SET monthname = MONTHNAME(date);SET SQL_SAFE_UPDATES = 1;

SELECT monthname,SUM(total) AS total_sales FROM amazon.amazon
GROUP BY monthname ORDER BY total_sales DESC LIMIT 0, 5000;








SELECT * FROM amazon.amazon;
SELECT COUNT(DISTINCT city) AS distinct_city_count FROM amazon.amazon;
SELECT branch, city FROM amazon.amazon GROUP BY branch, city;
SELECT COUNT(DISTINCT `product line`) AS distinct_product_line_count FROM amazon.amazon;
SELECT *FROM amazon.amazon LIMIT 1;
SHOW COLUMNS FROM amazon.amazon;
SELECT `Product line`, SUM(total) AS total_sales FROM amazon.amazon GROUP BY `Product line` ORDER BY total_sales DESC LIMIT 1;
SELECT EXTRACT(YEAR_MONTH FROM date) AS Date,SUM(total) AS monthly_revenue
FROM amazon.amazon GROUP BY EXTRACT(YEAR_MONTH FROM date) ORDER BY Date;

SELECT EXTRACT(YEAR_MONTH FROM date) AS Date, SUM(cogs) AS monthly_cogs FROM amazon.amazon
GROUP BY EXTRACT(YEAR_MONTH FROM date) ORDER BY monthly_cogs DESC LIMIT 1;

SELECT `Product line`,SUM(total) AS total_revenue FROM amazon.amazon
GROUP BY `Product line` ORDER BY total_revenue DESC LIMIT 1;

SELECT city,SUM(total) AS total_revenue FROM amazon.amazon 
GROUP BY city ORDER BY total_revenue DESC LIMIT 1;

SELECT `Product line`,SUM(`Tax 5%`) AS total_vat FROM amazon.amazon
GROUP BY `Product line`ORDER BY total_vat DESC LIMIT 1;

SELECT *,CASE WHEN total > avg_sales THEN 'Good'ELSE 'Bad'END AS sales_indicator
FROM (SELECT *,AVG(total) OVER (PARTITION BY `Product line`) AS avg_sales FROM amazon.amazon) AS subquery;

SELECT branch,SUM(quantity) AS total_quantity_sold,
(SELECT AVG(total_quantity_sold) FROM (SELECT SUM(quantity) 
AS total_quantity_sold FROM amazon.amazon GROUP BY branch) AS subquery) AS avg_quantity_sold
FROM amazon.amazon
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(total_quantity_sold) 
FROM (SELECT SUM(quantity) AS total_quantity_sold 
FROM amazon.amazon GROUP BY branch) AS subquery);

SELECT gender,`Product line`,COUNT(*) AS frequency FROM amazon.amazon
GROUP BY gender, `Product line`ORDER BY gender, frequency DESC;

SELECT `Product line`,AVG(rating) AS average_rating
FROM amazon.amazon GROUP BY `Product line`;

SELECT DAYNAME(date) AS weekday,TIME_FORMAT(time, '%H:%i') AS time_of_day, COUNT(*) AS sales_occurrences FROM amazon.amazon
GROUP BY DAYNAME(date), TIME_FORMAT(time, '%H:%i'), date, time ORDER BY WEEKDAY(date), TIME_FORMAT(time, '%H:%i');

SELECT `Customer type`,SUM(total) AS total_revenue FROM amazon.amazon 
GROUP BY `Customer type`ORDER BY total_revenue DESC LIMIT 1;

SELECT City,SUM(`Tax 5%`) / SUM(total) * 100 AS vat_percentage FROM amazon.amazon
GROUP BY City ORDER BY vat_percentage DESC LIMIT 1;

SELECT `Customer type`,SUM(`Tax 5%`) AS total_vat_payments FROM amazon.amazon
GROUP BY `Customer type`ORDER BY total_vat_payments DESC LIMIT 1;

SELECT COUNT(DISTINCT `Customer type`) AS distinct_customer_types
FROM amazon.amazon;

SELECT COUNT(DISTINCT Payment) AS distinct_payment_methods
FROM amazon.amazon;

#21
SELECT `Customer type`,COUNT(*) AS frequency FROM amazon.amazon
GROUP BY `Customer type`ORDER BY frequency DESC LIMIT 1;

#22
SELECT `Customer type`,COUNT(*) AS purchase_frequency FROM amazon.amazon 
GROUP BY `Customer type`ORDER BY purchase_frequency DESC LIMIT 1;

#23
SELECT Gender,COUNT(*) AS gender_count FROM amazon.amazon
GROUP BY Gender ORDER BY gender_count DESC LIMIT 1;
#24
SELECT Branch,Gender,COUNT(*) AS gender_count
FROM amazon.amazon GROUP BY Branch, Gender ORDER BY Branch, Gender;
#25
SELECT TIME_FORMAT(time, '%H:%i') AS time_of_day,COUNT(*) AS rating_count FROM amazon.amazon
WHERE rating IS NOT NULL GROUP BY TIME_FORMAT(time, '%H:%i') ORDER BY rating_count DESC LIMIT 1;
#26
SELECT Branch,TIME_FORMAT(time, '%H:%i') AS time_of_day,AVG(rating) AS average_rating FROM amazon.amazon
WHERE rating IS NOT NULL GROUP BY Branch, TIME_FORMAT(time, '%H:%i') ORDER BY Branch, average_rating DESC;
#27
SELECT DAYNAME(date) AS day_of_week,AVG(rating) AS average_rating FROM amazon.amazon
WHERE rating IS NOT NULL GROUP BY DAYOFWEEK(date), DAYNAME(date) ORDER BY average_rating DESC LIMIT 1;

#28
SELECT Branch,DAYNAME(date) AS day_of_week,AVG(rating) AS average_rating FROM amazon.amazon
WHERE rating IS NOT NULL GROUP BY Branch, DAYOFWEEK(date), DAYNAME(date) ORDER BY Branch, average_rating DESC;


