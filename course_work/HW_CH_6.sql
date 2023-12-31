-- Chapter 6 Homework
-- Sarah Cohen

/* My Guitar Shop Database */
USE MyGuitarShop
GO

--1. Write a SELECT statement that returns the same result set as this SELECT statement, but don�t use a join. 
--Instead, use a subquery in a WHERE clause that uses the IN operator.

--THERE'S NO SELECT STATEMENT TO REWRITE SO HERE'S A MADE UP ONE
--SELECT statement that lists all of the distinct category names of products in the catalogue (Products table)
SELECT DISTINCT c.CategoryName 
FROM Categories c
JOIN Products p ON (c.CategoryID = p.CategoryID)
--SUBQUERY VERSION
SELECT CategoryName
From Categories
WHERE CategoryID IN (
	SELECT DISTINCT CategoryID
	FROM Products
)

--2. Write a SELECT statement that answers this question: 
--Which products have a list price that�s greater than the average list price for all products?
--a. Return the ProductName and ListPrice columns for each product.
--b. Sort the results by the ListPrice column in descending sequence.
SELECT ProductName, ListPrice
FROM Products
WHERE ListPrice > (
	SELECT AVG(ListPrice)
	FROM Products
)
ORDER BY ListPrice DESC

--3. Write a SELECT statement that returns the CategoryName column from the Categories table. 
--Return one row for each category that has never been assigned to any product in the Products table. 
--To do that, use a subquery introduced with NOT EXISTS.
SELECT CategoryName
FROM Categories
WHERE NOT EXISTS (
	SELECT *
	FROM Products
	WHERE Products.CategoryID = Categories.CategoryID
)

--4. Write a SELECT statement that returns three columns: EmailAddress, OrderID, and the order total for each order. 
--	To do this, you can group the result set by the EmailAddress and OrderID columns. 
--	Then, you can calculate the order total from the columns in the OrderItems table.
--Write a second SELECT statement that uses the first SELECT statement in its FROM clause. 
--	The main query should return two columns: the customer�s email address and the largest order for that customer. 
--	To do this, you can group the result set by the EmailAddress column.
SELECT EmailAddress, MAX(OrderTotal) AS LargestOrder
FROM ( SELECT o.OrderID, 
		(SELECT c.EmailAddress 
			FROM Customers c
			WHERE c.CustomerID = o.CustomerID) AS EmailAddress, 
		(SELECT SUM((oi.ItemPrice - oi.DiscountAmount) * oi.Quantity)
			FROM OrderItems oi
			WHERE oi.OrderID = o.OrderID) AS OrderTotal
	   FROM Orders o ) AS SummaryTable
GROUP BY EmailAddress
ORDER BY LargestOrder DESC

--5. Write a SELECT statement that returns the name and discount percent for each product that has a unique discount percent. 
--In other words, don�t include products that have the same discount percent as another product.
--Sort the results by the ProductName column.

--Steps:
--get all the count for all discount percents with a count of 1
--get the name and discount percents from the result of the first select statement
--order by ProductName
SELECT
	(SELECT p2.ProductName
	 FROM Products p2
	 WHERE p2.DiscountPercent = p1.DiscountPercent) AS ProductName,
	p1.DiscountPercent
FROM ( SELECT DiscountPercent, COUNT(DiscountPercent) AS PercentCount
	   FROM Products
       GROUP BY DiscountPercent 
	   HAVING COUNT(DiscountPercent) = 1 ) AS p1
ORDER BY ProductName

--6. Use a correlated subquery to return one row per customer with each customer�s oldest order (the one with the earliest date). 
--Each row should include these three columns: EmailAddress, OrderID, and OrderDate.
SELECT 
	( SELECT c.EmailAddress
	  FROM Customers c
	  WHERE c.CustomerID = o.CustomerID ) AS EmailAddress,
	o.OrderID,
	o.OrderDate
FROM Orders o
WHERE o.OrderDate in (
	SELECT MIN(OrderDate) AS EarliestDate 
	FROM Orders
	GROUP BY CustomerID
)