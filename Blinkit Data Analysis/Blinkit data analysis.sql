SELECT * from blinkit_data
SELECT COUNT(*) FROM blinkit_data

--cleaning data

UPDATE blinkit_data
SET Item_Fat_Content=
CASE
WHEN Item_Fat_Content IN('LF','low fat') THEN 'Low Fat'
WHEN Item_Fat_Content='reg' THEN 'Regular'
ELSE Item_Fat_Content
END;
SELECT DISTINCT(Item_Fat_Content) FROM blinkit_data
--find total sales,using cast and decimal we found total sales in million

SELECT CAST(SUM(sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_In_Millions
FROM blinkit_data

SELECT CAST(AVG(Sales) AS DECIMAL(10,1)) AS AVG_SALES FROM blinkit_data

SELECT COUNT(*) AS NO_OF_ITEMS FROM blinkit_data

--find total sales for low fat items
SELECT CAST(SUM(sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_In_Millions
FROM blinkit_data
Where Item_Fat_Content='Low Fat'

--find average rating
SELECT CAST(AVG(Rating)AS DECIMAL(10,2))AS AVG_RATING From blinkit_data

--total sales,avg sales,avg rating by fat content
SELECT Item_Fat_Content,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS AVG_SALES,
COUNT(*) AS NO_OF_ITEMS,
 CAST(AVG(Rating)AS DECIMAL(10,2))AS AVG_RATING


FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY TOTAL_SALES DESC

--for particular year
SELECT Item_Fat_Content,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS AVG_SALES,
COUNT(*) AS NO_OF_ITEMS,
CAST(AVG(Rating)AS DECIMAL(10,2))AS AVG_RATING
FROM blinkit_data
WHERE Outlet_Establishment_Year='2022'
GROUP BY Item_Fat_Content
ORDER BY TOTAL_SALES DESC

SELECT Item_Type,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS AVG_SALES,
COUNT(*) AS NO_OF_ITEMS,
CAST(AVG(Rating)AS DECIMAL(10,2))AS AVG_RATING
FROM blinkit_data
GROUP BY Item_Type
ORDER BY TOTAL_SALES DESC
--for top 5 items

SELECT TOP 5 Item_Type,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS AVG_SALES,
COUNT(*) AS NO_OF_ITEMS,
CAST(AVG(Rating)AS DECIMAL(10,2))AS AVG_RATING
FROM blinkit_data
GROUP BY Item_Type
ORDER BY TOTAL_SALES DESC

--bottom 5 sellings
SELECT TOP 5 Item_Type,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS AVG_SALES,
COUNT(*) AS NO_OF_ITEMS,
CAST(AVG(Rating)AS DECIMAL(10,2))AS AVG_RATING
FROM blinkit_data
GROUP BY Item_Type
ORDER BY TOTAL_SALES 

SELECT Outlet_Location_Type, Item_Fat_Content,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS AVG_SALES,
COUNT(*) AS NO_OF_ITEMS,
CAST(AVG(Rating)AS DECIMAL(10,2))AS AVG_RATING
FROM blinkit_data
GROUP BY Outlet_Location_Type,Item_Fat_Content
ORDER BY TOTAL_SALES DESC



SELECT Outlet_Location_Type,
ISNULL([Low Fat],0) AS Low_Fat,
ISNULL([Regular],0) AS Regular
FROM
(SELECT Outlet_Location_Type, Item_Fat_Content,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES
FROM blinkit_data
GROUP BY Outlet_Location_Type,Item_Fat_Content)AS SourceTable
PIVOT
(
SUM(Total_Sales)
FOR Item_Fat_Content IN ([Low Fat],[Regular])
)AS PivotTable
ORDER BY Outlet_Location_Type

--total sales by outlet estabilishment
SELECT Outlet_Establishment_Year,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS AVG_SALES,
COUNT(*) AS NO_OF_ITEMS,
 CAST(AVG(Rating)AS DECIMAL(10,2))AS AVG_RATING
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY TOTAL_SALES 

--Percentage of sales by outlet size
SELECT Outlet_size,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES,
CAST((SUM(Sales) * 100.0 /SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY TOTAL_SALES DESC;

--SAles by outlet Location
SELECT Outlet_Location_Type,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS AVG_SALES,
CAST((SUM(Sales) * 100.0 /SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
COUNT(*) AS NO_OF_ITEMS,
CAST(AVG(Rating)AS DECIMAL(10,2))AS AVG_RATING
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY TOTAL_SALES DESC

--all metrics by outlet type

SELECT Outlet_Type,
CAST(SUM(sales) AS DECIMAL(10,2)) AS TOTAL_SALES,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS AVG_SALES,
CAST((SUM(Sales) * 100.0 /SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
COUNT(*) AS NO_OF_ITEMS,
CAST(AVG(Rating)AS DECIMAL(10,2))AS AVG_RATING
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY TOTAL_SALES DESC


