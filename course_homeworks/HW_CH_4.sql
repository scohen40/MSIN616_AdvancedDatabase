--Chapter 4 Homework
--Sarah Cohen

/*
AP Database
*/
USE AP
GO

--1. Write a SELECT statement that returns four columns:
-- a. VendorName from the Vendors table,
-- b. InvoiceNumber from the Invoices table,
-- c. InvoiceDate from the Invoices table,
-- d. BalanceInvoiceTotal minus the sum of PaymentTotal and CreditTotal
-- The result should have one row for each invoice with a non-zero balance. Sort the result by VendorName in ascending order.
SELECT VendorName, 
	InvoiceNumber, 
	InvoiceDate,
	InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Invoices
JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
WHERE InvoiceTotal - (PaymentTotal + CreditTotal) != 0
ORDER BY VendorName ASC

--2. Write a SELECT statement that returns three columns:
-- a. VendorName from the Vendors table,
-- b. DefaultAccountNo from the Vendors table,
-- c. AccountDescription from GLAccounts table
--The result should have one row for each vendor, with the account number and account description for the vendor’s default account number. 
--Sort the result set by AccountDescription, then by VendorName
SELECT v.VendorName, v.DefaultAccountNo, g.AccountDescription
FROM Vendors v
JOIN GLAccounts g ON v.DefaultAccountNo = g.AccountNo
ORDER BY g.AccountDescription, v.VendorName

--3. Write a SELECT statement that returns five columns from three tables, all using column aliases:
-- a. Vendor VendorName column
-- b. Date InvoiceDate column
-- c. Number InvoiceNumber column
-- d. # InvoiceSequence column
-- e. LineItem InvoiceLineItemAmount column
--Assign the following correlation names to the tables:
--i. ven Vendors table
--ii. inv Invoice table
--iii. ili InvoiceLineItems table
--Sort the result set by Vendor, Date, Number, and #
SELECT ven.VendorName AS [Vendor],
	inv.InvoiceDate AS [Date],
	inv.InvoiceNumber AS [Number],
	ili.InvoiceSequence AS [#],
	ili.InvoiceLineItemAmount AS [LineItem]
FROM Vendors ven
JOIN Invoices inv ON ven.VendorID = inv.VendorID
JOIN InvoiceLineItems ili ON inv.InvoiceID = ili.InvoiceID
ORDER BY [Vendor], [Date], [Number], [#]

--4. Write a SELECT statement that returns two columns from the GLAccounts table: AccountNo and AccountDescription. 
--The result set should have one row for each account number that has never been used. 
--Sort the result set by AccountNo. [Hint: use an outer join to the InvoiceLineItems table]
SELECT g.AccountNo, g.AccountDescription
FROM GLAccounts g
LEFT OUTER JOIN InvoiceLineItems i ON g.AccountNo = i.AccountNo 
WHERE i.AccountNo IS NULL
ORDER BY g.AccountNo

--5. Use the UNION operator to generate a result set consisting of two columns from the Vendors table: 
--VendorName and VendorState. 
--If the vendor is in California, the VendorState should be “CA”; otherwise, the VendorState value should be “Outside CA”. 
--Sort the result set by VendorName
SELECT VendorName, 'CA' AS VendorState 
FROM Vendors
WHERE VendorState = 'CA'
UNION
SELECT VendorName, 'Outside CA' AS VendorState
FROM Vendors
WHERE VendorState != 'CA'
ORDER BY VendorName

/*
Finance Database
*/
USE Finance
GO

select * from TS_DailyData

--6. Write a SELECT statement that returns three columns: 
--Date, closing price for IBM Ticker, and closing price for GLD ticker.
SELECT [Date]
--7. Repeat the previous exercise, this time return the data only for the days on which GLD closed higher than IBM Library Database
--8. Write a SELECT statement that returns the titles, ISBN numbers, and locations of all the books.
--9. Write a SELECT statement that returns the titles of all books, their categories, genres, fields, subfields, and types. Arrange the columns in the order that makes most sense to you. A possible return set might begin:
--10. Modify the query above to display ‘N/A’ or ‘---’ instead of NULL
