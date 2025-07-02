create database supermarket_insights;
use supermarket_insights;

-- ------------------------------------------------------
-- PROJECT: Supermarket Data Analysis using SQL
-- DATABASE: supermarket_insights
-- ------------------------------------------------------

--  Table Description:

-- - InvoiceID : Computer-generated invoice number
-- - Branch    : Branch of the supermarket (A, B, C)
-- - City      : City where the branch is located
-- - Customer_type : Member (with card) or Normal
-- - Gender    : Customer's gender
-- - Product_line : Product category (6 groups)
-- - Unit_price: Price per unit ($)
-- - Quantity  : Number of units purchased
-- - Tax_5     : 5% tax on purchase
-- - Total     : Final price (including tax)
-- - Date      : Purchase date (Jan–Mar 2019)
-- - Time      : Purchase time (10 AM – 9 PM)
-- - Payment   : Mode of payment (Cash, Ewallet, Credit card)
-- - COGS      : Cost of Goods Sold
-- - Gross_margin_percentage : Margin in %
-- - Gross_income : Profit earned
-- - Rating    : Customer satisfaction (1–10)

-- ------------------------------------------------------
-- 1. Display the first 5 rows from the dataset
-- ------------------------------------------------------
SELECT * FROM supermarket
LIMIT 5;

-- ------------------------------------------------------
-- 2. Display the last 5 rows from the dataset
-- ------------------------------------------------------
SELECT * 
FROM supermarket
ORDER BY `Invoice ID` DESC
LIMIT 5;

-- ------------------------------------------------------
-- 3. Display random 5 rows
-- ------------------------------------------------------
SELECT * 
FROM supermarket
ORDER BY RAND()
LIMIT 5;

-- ------------------------------------------------------
-- 4. Summary stats for Gross Income
-- ------------------------------------------------------
SELECT 
    COUNT(`gross income`) AS total_count,
    MIN(`gross income`) AS min_income,
    MAX(`gross income`) AS max_income,
    AVG(`gross income`) AS avg_income,
    STD(`gross income`) AS std_dev
FROM supermarket;

-- ------------------------------------------------------
-- 5. Find number of missing values (example: branch)
-- ------------------------------------------------------
SELECT COUNT(*) AS missing_branch
FROM supermarket
WHERE branch IS NULL;

-- Note: The dataset is already cleaned

-- ------------------------------------------------------
-- 6. Count customers per city
-- ------------------------------------------------------
SELECT city, COUNT(*) AS total_customers
FROM supermarket
GROUP BY city;

-- ------------------------------------------------------
-- 7. Most frequently used payment method
-- ------------------------------------------------------
SELECT payment, COUNT(*) AS usage_count
FROM supermarket
GROUP BY payment
ORDER BY usage_count DESC;

-- ------------------------------------------------------
-- 8. COGS vs Rating (for correlation analysis)
-- ------------------------------------------------------
SELECT rating, cogs
FROM supermarket;

-- ------------------------------------------------------
-- 9. Most profitable branch (by gross income)
-- ------------------------------------------------------
SELECT 
    city,
    branch,
    ROUND(SUM(`gross income`), 2) AS total_gross_income
FROM supermarket
GROUP BY branch, city
ORDER BY total_gross_income DESC;

-- ------------------------------------------------------
-- 10. Most used payment method by city
-- ------------------------------------------------------
SELECT 
    city,
    SUM(CASE WHEN payment = 'cash' THEN 1 ELSE 0 END) AS cash,
    SUM(CASE WHEN payment = 'Ewallet' THEN 1 ELSE 0 END) AS ewallet,
    SUM(CASE WHEN payment = 'credit card' THEN 1 ELSE 0 END) AS credit_card
FROM supermarket
GROUP BY city;

-- ------------------------------------------------------
-- 11. Product line with highest quantity sold
-- ------------------------------------------------------
SELECT 
    `Product line`, 
    SUM(quantity) AS total_quantity
FROM supermarket
GROUP BY `Product line`
ORDER BY total_quantity DESC;

-- ------------------------------------------------------
-- 12. Daily sales by day of the week
-- ------------------------------------------------------

-- Convert text dates to actual date format (run once)
UPDATE supermarket 
SET date = STR_TO_DATE(date, '%m/%d/%Y');

SELECT 
    DAYNAME(date) AS day_name,
    DAYOFWEEK(date) AS day_num,
    ROUND(SUM(total), 2) AS daily_sales
FROM supermarket
GROUP BY day_name, day_num
ORDER BY day_num;

-- ------------------------------------------------------
-- 13. Month with the highest sales
-- ------------------------------------------------------
SELECT 
    MONTHNAME(date) AS month_name,
    MONTH(date) AS month_num,
    SUM(total) AS monthly_total
FROM supermarket
GROUP BY month_name, month_num
ORDER BY monthly_total DESC;

-- ------------------------------------------------------
-- 14. Time of the day with highest sales
-- ------------------------------------------------------
SELECT 
    HOUR(time) AS hour,
    ROUND(SUM(total), 2) AS hourly_total
FROM supermarket
GROUP BY hour
ORDER BY hourly_total DESC;

-- ------------------------------------------------------
-- 15. Gender-wise average spending
-- ------------------------------------------------------
SELECT 
    gender,
    AVG(`gross income`) AS avg_spending
FROM supermarket
GROUP BY gender;

-- -------------------------------------------------------


