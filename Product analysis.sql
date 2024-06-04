#Product analysis

SELECT * FROM amazon.amazon;
SELECT DISTINCT `Product line`
FROM amazon.amazon;
SELECT `Product line`, SUM(quantity) AS total_sold, SUM(total) AS total_revenue
FROM amazon.amazon
GROUP BY `Product line`
ORDER BY total_revenue DESC;
SELECT `Product line`, SUM(`gross income`) AS total_profit
FROM amazon.amazon
GROUP BY `Product line`
ORDER BY total_profit DESC;
