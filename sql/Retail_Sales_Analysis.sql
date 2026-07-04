SELECT Order_Date, Ship_Date
FROM superstore_sales_cleaned
LIMIT 5;
ALTER TABLE superstore_sales_cleaned
MODIFY COLUMN Order_Date DATE,
MODIFY COLUMN Ship_Date DATE;
DESCRIBE superstore_sales_cleaned;
/*
=========================================================
RETAIL SALES ANALYSIS
Author: Dinesh Dhiman

Objective:
Analyze retail sales, customer behaviour, product
performance, and sales trends using MySQL.
=========================================================
*/

USE retail_sales;


-- =====================================================
-- SECTION 1: DATA EXPLORATION
-- =====================================================


-- Q1. View sample records

SELECT *
FROM superstore_sales_cleaned
LIMIT 10;

SELECT COUNT(*) AS Total_Records
FROM superstore_sales_cleaned;

-- Q3. Count unique orders and customers

SELECT 
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM superstore_sales_cleaned;

-- Q4. Find the date range of the dataset

SELECT
    MIN(Order_Date) AS First_Order_Date,
    MAX(Order_Date) AS Last_Order_Date
FROM superstore_sales_cleaned;


-- =====================================================
-- SECTION 2: SALES PERFORMANCE ANALYSIS
-- =====================================================

-- Q5. Calculate total sales

SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned;



-- Q6. Sales performance by region

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY Region
ORDER BY Total_Sales DESC;


-- Q7. Sales performance by category

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY Category
ORDER BY Total_Sales DESC;


-- Q8. Sales performance by sub-category

SELECT
    Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;


-- Q9. Top 10 states by sales

SELECT
    State,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 10;

-- =====================================================
-- SECTION 3: SALES TREND ANALYSIS
-- =====================================================

-- Q10. Yearly sales trend

SELECT
    Order_Year,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY Order_Year
ORDER BY Order_Year;


-- Q11. Monthly sales trend

SELECT
    Order_Month,
    Month_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY Order_Month, Month_Name
ORDER BY Order_Month;

-- Q12. Quarterly sales performance

SELECT
    Quarter,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY Quarter
ORDER BY Quarter;

-- Q13. Year-over-year sales growth

WITH Yearly_Sales AS (
    SELECT
        Order_Year,
        SUM(Sales) AS Total_Sales
    FROM superstore_sales_cleaned
    GROUP BY Order_Year
)
SELECT
    Order_Year,
    ROUND(Total_Sales, 2) AS Total_Sales,
    ROUND(
        LAG(Total_Sales) OVER (ORDER BY Order_Year),
        2
    ) AS Previous_Year_Sales,
    ROUND(
        (
            Total_Sales - LAG(Total_Sales) OVER (ORDER BY Order_Year)
        ) / LAG(Total_Sales) OVER (ORDER BY Order_Year) * 100,
        2
    ) AS YoY_Growth_Percentage
FROM Yearly_Sales
ORDER BY Order_Year;


-- =====================================================
-- SECTION 4: CUSTOMER ANALYSIS
-- =====================================================

-- Q14. Sales by customer segment

SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY Segment
ORDER BY Total_Sales DESC;



-- Q15. Top 10 customers by sales

SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;


-- Q16. Customers with the highest number of orders

SELECT
    Customer_ID,
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM superstore_sales_cleaned
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Orders DESC
LIMIT 10;

-- Q17. Average sales per order

SELECT
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM superstore_sales_cleaned;



-- =====================================================
-- SECTION 5: PRODUCT PERFORMANCE ANALYSIS
-- =====================================================

-- Q18. Top 10 products by sales

SELECT
    Product_ID,
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY Product_ID, Product_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-- Q19. Lowest performing 10 products by sales

SELECT
    Product_ID,
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore_sales_cleaned
GROUP BY Product_ID, Product_Name
ORDER BY Total_Sales ASC
LIMIT 10;




-- Q20. Rank products within each category

SELECT
    Category,
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    DENSE_RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(Sales) DESC
    ) AS Product_Rank
FROM superstore_sales_cleaned
GROUP BY Category, Product_Name
ORDER BY Category, Product_Rank;


-- =====================================================
-- SECTION 6: SHIPPING ANALYSIS
-- =====================================================

-- Q21. Average shipping duration

SELECT
    ROUND(AVG(Shipping_Days), 2) AS Average_Shipping_Days
FROM superstore_sales_cleaned;



-- Q22. Average shipping duration by ship mode

SELECT
    Ship_Mode,
    ROUND(AVG(Shipping_Days), 2) AS Average_Shipping_Days
FROM superstore_sales_cleaned
GROUP BY Ship_Mode
ORDER BY Average_Shipping_Days;




-- Q23. Sales contribution percentage by region

SELECT
    Region,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(
        SUM(Sales) /
        (SELECT SUM(Sales) FROM superstore_sales_cleaned) * 100,
        2
    ) AS Sales_Contribution_Percentage
FROM superstore_sales_cleaned
GROUP BY Region
ORDER BY Total_Sales DESC;