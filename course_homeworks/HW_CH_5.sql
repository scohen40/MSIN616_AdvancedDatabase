--Chapter 5 Homework
--Sarah Cohen

/* AP Database */
USE AP
GO

--1. Write a SELECT statement that returns two columns from the Invoice table:
-- VendorID and PaymentSum, where PaymentSum is the sum of the PaymentTotal column. 
--Group the result set by VendorID.
SELECT VendorID, 
	SUM(PaymentTotal) AS PaymentSum
FROM Invoices
GROUP BY VendorID

--2. Repeat exercise 1 (above) but this time return VendorName instead of VendorID.
SELECT VendorName, SUM(PaymentTotal) AS PaymentSum
FROM Invoices JOIN Vendors ON (Invoices.VendorID = Vendors.VendorID)
GROUP BY VendorName

--3. Write a SELECT statement to return three columns: VendorName, InvoiceCount, and
--InvoiceSum. InvoiceCount is the count of the number of invoices, and InvoiceSum is the sum of
--the InvoiceTotal column. Group the results by vendor. Sort the result set so the vendor with
--the highest number of invoices appears first.
SELECT VendorName,
	COUNT(*) AS InvoiceCount, 
	SUM(InvoiceTotal) AS InvoiceSum
FROM Invoices JOIN Vendors ON (Invoices.VendorID = Vendors.VendorID)
GROUP BY VendorName
ORDER BY InvoiceCount DESC

--4. Modify the SELECT statement in 3 above so that they result set is sorted by the InvoiceSum in
--descending order and is limited to the Vendors with InvoiceSum greater than $500.00
SELECT VendorName,
	COUNT(*) AS InvoiceCount, 
	SUM(InvoiceTotal) AS InvoiceSum
FROM Invoices JOIN Vendors ON (Invoices.VendorID = Vendors.VendorID)
GROUP BY VendorName
HAVING SUM(InvoiceTotal) > 500
ORDER BY InvoiceSum DESC

/* Product Orders Database */
USE MyGuitarShop
GO

--5. Write a SELECT statement that returns these columns:
--a. The count of the number of orders in the Orders table
--b. The sum of the TaxAmount column in the Orders table
SELECT COUNT(*) AS CountOrders,
	SUM(TaxAmount) As SumTaxAmount
FROM Orders

--6. Write a SELECT statement that returns one row for each category that has products. The
--statement should return these columns:
--a. The CategoryName column from the Categories table
--b. The number of products in each category
--c. The list price of the most expensive product in each category
--Sort the result set so the category with the most products appears first.
SELECT Categories.CategoryName, 
	COUNT(Products.CategoryID) AS CountProduct,
	MAX(Products.ListPrice) AS MaxPrice
FROM Products JOIN Categories ON (Products.CategoryID = Categories.CategoryID)
GROUP BY Categories.CategoryName
ORDER BY MAX(Products.ListPrice) DESC 

--7. Write a SELECT statement that returns one row for each customer that has orders. The
--statement should return these columns:
--a. The EmailAddress column from the Customers table
--b. The total price of the items the customer has ordered (Hint: multiply the item price in
--the OrderItems table by the quantity in the OrderItems table)
--c. The total discount applied to the items the customer has ordered (Hint: multiply the
--discount amount column in the OrderItems table by the quantity in the OrderItems
--table)
--Sort the result set in descending sequence by the price total for each customer.
SELECT Customers.EmailAddress, 
	SUM(OrderItems.ItemPrice * OrderItems.Quantity) AS TotalPrice,
	SUM(OrderItems.DiscountAmount * OrderItems.Quantity) AS TotalDiscount
FROM Orders LEFT JOIN Customers ON (Orders.CustomerID = Customers.CustomerID)
	JOIN OrderItems ON (Orders.OrderID = OrderItems.OrderID)
GROUP BY Customers.EmailAddress
ORDER BY TotalPrice DESC

--8. Write a SELECT statement that returns one row for each customer that has orders. The
--statement should return these columns:
--a. The EmailAddress column from the Customers table
--b. A count of the number of orders for each customer
--c. The total amount for the orders for each customer (Hint: First, subtract the discount
--amount from the price. Then, multiply by the quantity.)
--Return only those rows where the customer has more than 1 order.
--Sort the result set in descending sequence by the sum of the line item amounts.
SELECT Customers.EmailAddress,
	COUNT(Orders.OrderID) AS CountOrders,
	SUM((OrderItems.ItemPrice - OrderItems.DiscountAmount) * OrderItems.Quantity) AS  TotalAmount
FROM Orders LEFT JOIN Customers ON (Orders.CustomerID = Customers.CustomerID)
	JOIN OrderItems ON (Orders.OrderID = OrderItems.OrderID)
GROUP BY Customers.EmailAddress
HAVING COUNT(Orders.OrderID) > 1
ORDER BY TotalAmount DESC

--9. Modify the solution to exercise 4 so it only counts and totals line items that have an ItemPrice value that’s greater than 400.

--ASSUMING THIS IS ACTUALLY SUPPOSED TO MODIFY #4 SHOULD BE MODIFIED TO USE THE 'MY GUITAR SHOP' DATABASE, I USED PIECES FROM #8
SELECT * FROM Orders 
SELECT * FROM OrderItems
SELECT * FROM Customers
SELECT Customers.EmailAddress,
	COUNT(Orders.OrderID) AS CountOrders, 
	SUM((OrderItems.ItemPrice - OrderItems.DiscountAmount) * OrderItems.Quantity) AS  TotalAmount
FROM Orders LEFT JOIN Customers ON (Orders.CustomerID = Customers.CustomerID)
	JOIN OrderItems ON (Orders.OrderID = OrderItems.OrderID)
WHERE OrderItems.ItemPrice > 400
GROUP BY Customers.EmailAddress
HAVING SUM((OrderItems.ItemPrice - OrderItems.DiscountAmount) * OrderItems.Quantity) > 500
ORDER BY TotalAmount DESC

--ASSUMING YOU MEANT TO MODIFY THE SOLUTION TO EXERCISE 8
SELECT Customers.EmailAddress,
	COUNT(Orders.OrderID) AS CountOrders,
	SUM((OrderItems.ItemPrice - OrderItems.DiscountAmount) * OrderItems.Quantity) AS  TotalAmount
FROM Orders LEFT JOIN Customers ON (Orders.CustomerID = Customers.CustomerID)
	JOIN OrderItems ON (Orders.OrderID = OrderItems.OrderID)
WHERE OrderItems.ItemPrice > 400
GROUP BY Customers.EmailAddress
HAVING COUNT(Orders.OrderID) > 1
ORDER BY TotalAmount DESC

--10. Write a SELECT statement that answers this question: What is the total amount ordered for each
--product? Return these columns:
--a. The product name from the Products table
--b. The total amount for each product in the OrderItems table (Hint: You can calculate the
--total by subtracting the discount amount from the item price and then multiplying it by
--the quantity)
SELECT p.ProductName,
	SUM((oi.ItemPrice - oi.DiscountAmount) * oi.Quantity) AS TotalAmount
FROM OrderItems oi LEFT JOIN Products p ON (oi.ProductID = p.ProductID)
GROUP BY p.ProductName
ORDER BY TotalAmount DESC --added in even though not asked to

--Use the ROLLUP operator to include a row that gives the grand total.
--11. Write a SELECT statement that answers this question: Which customers have ordered more than
--one type of product? Return these columns:
--a. The email address from the Customers table
--b. The count of distinct products from the customer’s orders
SELECT c.EmailAddress,
	COUNT(ProductID) AS CountDistinctProducts
FROM Orders o LEFT JOIN Customers c ON (o.CustomerID = c.CustomerID)
	JOIN OrderItems oi ON (o.OrderID = oi.OrderID)
GROUP BY c.EmailAddress, oi.ProductID WITH ROLLUP
HAVING COUNT(oi.ProductID) >  1

/* Library Database */
USE LibraryF20
GO

--12. Write a SELECT statement that returns names of all Publishers with number of nonfiction books for each publisher.
SELECT p.[Name],
	COUNT(*) AS CountBooks
FROM LBR_Book b LEFT JOIN LBR_Publisher p ON (b.Publisher_ID = p.Publisher_ID)
	JOIN LBR_BookClassification class ON (b.Classification_ID = class.Classification_ID)
	JOIN LBR_BkCategory cat ON(class.Category_ID = cat.Category_ID)
WHERE cat.Category = 'NonFiction'
GROUP BY p.[Name]

--13. Write a SELECT statement that returns titles of all Computer Science books
SELECT b.Title 
FROM LBR_Book b JOIN LBR_BookClassification class ON (b.Classification_ID = class.Classification_ID)
	JOIN LBR_BkField f ON (class.Field_ID = f.Field_ID)
WHERE f.Field = 'Computer Science'

--14. Write a SELECT statement that returns all authors with the number of books they wrote or co-
--authored ordered by the number of books. Make sure not to miss the author(s) who did not
--write any books in our library. A sample output appears at right (CHECK DOCUMENT FOR PICTURE)
SELECT ISNULL(a.Title + ' ', '') 
	+ ISNULL(a.FirstName + ' ', '') 
	+ ISNULL(a.MiddleInitials + ' ', '') 
	+ ISNULL(a.LastName + ' ', '')
	+ ISNULL(a.Suffix + ' ', '') AS Author,
	COUNT(b.Book_ID) AS NumBooks
FROM LBR_JNC_AuthorBook b RIGHT JOIN LBR_Author a ON (b.Author_ID = a.Author_ID)
GROUP BY ISNULL(a.Title + ' ', '') 
	+ ISNULL(a.FirstName + ' ', '') 
	+ ISNULL(a.MiddleInitials + ' ', '') 
	+ ISNULL(a.LastName + ' ', '')
	+ ISNULL(a.Suffix + ' ', '')
ORDER BY NumBooks

--15. Write a SELECT statement that returns three fields: The average, minimal, and maximal length
--of a book title: (CHECK DOCUMENT FOR PICTURE)
SELECT AVG(LEN(Title)) AS 'Average length of a book title',
	MIN(LEN(Title)) AS 'Min length of a book title',
	MAX(LEN(Title)) AS 'Max length of a book title'
FROM LBR_Book