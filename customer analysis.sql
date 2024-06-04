SELECT * FROM amazon.amazon;
#Customer Segmentation:
#Identify distinct customer segments based on customer type and gender.
SELECT `Customer type`, Gender, COUNT(*) AS Total_Customers
FROM amazon.amazon 
GROUP BY `Customer type`, Gender;
#Purchase Trends:
#Determine the average purchase value and total number of purchases for each customer segment.
SELECT `Customer type`, 
       AVG(total) AS Avg_Purchase_Value,
       COUNT(*) AS Total_Purchases
FROM amazon.amazon 
GROUP BY `Customer type`;


#Retention and Loyalty:
SELECT `Customer type`, 
       COUNT(DISTINCT DATE_FORMAT(date, '%Y-%m')) AS Months_Active
FROM amazon.amazon 
GROUP BY `Customer type`;

#Segment-Specific Strategies:
SELECT `Customer type`, 
       AVG(total) AS Avg_Transaction_Value,
       COUNT(DISTINCT `Invoice ID`) AS Total_Customers,
       SUM(total) / COUNT(DISTINCT `Invoice ID`) AS CLV
FROM amazon.amazon 
GROUP BY `Customer type`;


