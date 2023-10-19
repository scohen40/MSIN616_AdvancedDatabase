--Chapter 9 Homework
--Sarah Cohen

/* AP Database */
USE AP
GO

--1.	Write a SELECT statement that returns two columns based on the Vendors table.
-- a.	The first column, Contact, is the vendor contact name in this format: first name followed by last initial (for example, “John S.”) 
-- b.	The second column, Phone, is the VendorPhone column without the area code. 
--Only return rows for those vendors in the 559 area code. Sort the result set by first name, then last name.

--ASSUMING NO NAME FIELDS ARE NULL, AND WE DON'T WANT TO INCLUDE THE NULL PHONE NUMBERS
SELECT VendorContactFName + ' ' + LEFT(VendorContactLName, 1) + '.' AS VendorContactName,
	RIGHT(VendorPhone, 8) AS VendorPhone
FROM Vendors
WHERE LEFT(VendorPhone, 4) != '(559' 
ORDER BY VendorContactFName, VendorContactLName

--2.	Write a SELECT statement that returns the InvoiceNumber and balance due 
--for every invoice with a non-zero balance and an InvoiceDueDate that’s less than 30 days from today.
SELECT InvoiceNumber, 
	(InvoiceTotal - PaymentTotal - CreditTotal) AS BalanceDue,
	DATEDIFF(DAY, GETDATE(), InvoiceDueDate) AS DaysUntilDue -- none of the due dates are actually within 30 days of today
FROM Invoices
WHERE (InvoiceTotal - PaymentTotal - CreditTotal != 0) AND (DATEDIFF(DAY, InvoiceDueDate, GETDATE()) < 30)

--3.	Modify the search expression for InvoiceDueDate from the solution for 2b.
--Rather than 30 days from today, return invoices due before the last day of the current month. 
SELECT InvoiceNumber, 
	(InvoiceTotal - PaymentTotal - CreditTotal) AS BalanceDue,
	(DATEADD(DAY, -1, DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE())+1,1))) AS EndOfCurrentMonth, --added for better data view
	InvoiceDueDate --added for better data view
FROM Invoices
WHERE (InvoiceTotal - PaymentTotal - CreditTotal != 0) AND (InvoiceDueDate < (DATEADD(DAY, -1, DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE())+1,1))) )

--4.	Write a summary query WITH CUBE that returns LineItemSum (which is the sum of InvoiceLineItemAmount) 
--grouped by Account (an alias for AccountDescription) and State (an alias for VendorState). 
--Use the CASE and GROUPING function to substitute the literal value “*ALL*” for the summary rows with null values.
SELECT 
	CASE
		WHEN GROUPING(gla.AccountDescription) = 1 THEN '*ALL*' 
		ELSE gla.AccountDescription 
	END AS Account,
	CASE
		WHEN GROUPING(v.VendorState) = 1 THEN '*ALL*'
		ELSE v.VendorState 
	END AS [State],
	SUM(InvoiceLineItemAmount) AS LineItemSum
FROM InvoiceLineItems ili
	LEFT JOIN GLAccounts gla ON (ili.AccountNo = gla.AccountNo)
	JOIN Invoices i ON (ili.InvoiceID = i.InvoiceID)
	JOIN Vendors v ON (i.VendorID = v.VendorID)
GROUP BY CUBE(gla.AccountDescription, v.VendorState)
ORDER BY Account DESC, [State] DESC 

--5.	Add a column to the query described in 2d that uses the RANK() function to return a column named BalanceRank that ranks the balance due in descending order.

--ASSUMING THE QUESTION IS ASKING FOR A MODIFICATION OF QUESTION 3
SELECT 
	RANK() OVER (ORDER BY (InvoiceTotal - PaymentTotal - CreditTotal)) AS BalanceRank,
	InvoiceNumber, 
	(InvoiceTotal - PaymentTotal - CreditTotal) AS BalanceDue
FROM Invoices
WHERE (InvoiceTotal - PaymentTotal - CreditTotal != 0) AND (InvoiceDueDate < (DATEADD(DAY, -1, DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE())+1,1))) )

/* My Guitar Shop Database */
USE MyGuitarShop
GO

--6.	Write a SELECT statement that returns these columns from the Products table:
-- a.	The ListPrice column
-- b.	The DiscountPercent column
-- c.	A column named DiscountAmount that uses the previous two columns to calculate the discount amount and uses the ROUND function to round the result to 2 decimal places
--(Note: Even though the result will be rounded, you may still have more than two zeroes after the decimal place as the data type does not change with ROUND.)
SELECT * FROM Products
SELECT ListPrice, 
	DiscountPercent,
	ROUND(ListPrice - (ListPrice * (DiscountPercent * .01)), 2) AS DiscountAmount
FROM Products

--7.	Write a SELECT statement that returns these columns from the Orders table:
-- a.	The OrderDate column
-- b.	A column that returns only the four-digit year that’s stored in the OrderDate column
-- c.	A column that returns only the day of the month that’s stored in the OrderDate column
-- d.	A column that returns the result from adding thirty days to the OrderDate column

--8.	Write a SELECT statement that returns these columns from the Orders table:
-- a.	The CardNumber column
-- b.	The length of the CardNumber column
-- c.	The last four digits of the CardNumber column
--When you get that working right, add the column that follows to the result set. This is more difficult because the column requires you to nest functions within functions.
--A column that displays the last four digits of the CardNumber column in this format: XXXX-XXXX-XXXX-1234. 
--In other words, use Xs for the first 12 digits of the card number and actual numbers for the last four digits of the number.

--9.	Write a SELECT statement that returns these columns from the Orders table:
-- a.	The OrderID column
-- b.	The OrderDate column
-- c.	A column named ApproxShipDate that’s calculated by adding 2 days to the OrderDate column
-- d.	The ShipDate column
-- e.	A column named DaysToShip that shows the number of days between the order date and the ship date
--When you get that working right, add a WHERE clause that retrieves just the orders placed in January 2023.
