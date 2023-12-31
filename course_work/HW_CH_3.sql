-- Chapter 3 Homework
-- Sarah Cohen

/* AP Database */
USE AP
GO

--1. Write a SELECT statement that returns from the Vendors table: VendorContactFName,VendorContactLName, and VendorName. 
--Sort the result set by the last name, 
SELECT VendorContactFName, VendorContactLName, VendorName 
FROM Vendors
ORDER BY VendorContactLName
--then by the first name.
SELECT VendorContactFName, VendorContactLName, VendorName 
FROM Vendors
ORDER BY VendorContactFName
--2. Write a SELECT statement that returns four columns from the Invoices table:
-- a. Number: Column alias for InvoiceNumber column
-- b. Total: Column alias for the InvoiceTotal column
-- c. Credits: Sum of the PaymentTotal and CreditTotal columns
-- d. Balance: InvoiceTotal minus the sum of paymentTotal and CreditTotal
SELECT InvoiceNumber AS [Number], 
InvoiceTotal AS [Total],
PaymentTotal + CreditTotal AS [Credits],
InvoiceTotal - (PaymentTotal + CreditTotal) AS [Balance] 
FROM Invoices

--3. Write a SELECT statement that returns one column from the Vendors table named Full Name.
--Create this column from the VendorContactFName and VendorContactLName columns. 
--Format is as follows: last name, comma, first name (e.g., �Pence, Michael�). 
--Sort the result by last name, 
SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
FROM Vendors
ORDER BY VendorContactLName
--then first name.
SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
FROM Vendors
ORDER BY VendorContactFName

/* Finance Database */

--4. Indicate that the queries below should be run against the Finance database.
USE Finance
GO

--5. Select all columns from the TS_DailyData table.
SELECT * FROM TS_DailyData

--6. Write a SELECT statement that returns two columns:
--a. Date and IntraDayChange defined as the difference between [Close] and [Open] for Ticker = �DJI� where this difference is larger than $500.00.
--b. Make sure to format your output nicely and present the result set in the descending order of the Intra-day change.
SELECT [Date],
	[IntraDayChange] = [Open] - [Close]
FROM TS_DailyData 
WHERE Ticker = 'DJI' 
	AND [Open] - [Close] > 500 
ORDER BY [IntraDayChange] DESC

--7. Repeat #6, this time return all records where the absolute value of IntradayChange was greater than $500.00
SELECT [Date],
	[IntraDayChange] = [Open] - [Close]
FROM TS_DailyData 
WHERE Ticker = 'DJI' 
	AND ABS([Open] - [Close]) > 500 
ORDER BY [IntraDayChange] DESC

--8. Write a SELECT statement that returns two columns:
-- a. Date and IntraDayRange defined as the difference between [High] and [Low] for Ticker = �DJI� where this difference is larger than $500.00.
-- b. Make sure to format your output nicely and present the result set in the descending order of the Intra-day range.
SELECT [Date],
	[IntraDayRange] = [High] - [Low]
FROM TS_DailyData
WHERE Ticker = 'DJI'
	AND [High] - [Low] > 500
ORDER BY [IntraDayRange] DESC

--9. Combine queries #5 and #7:
-- a. Write a SELECT statement that returns Three columns: Date, IntraDayChange , and IntraDayRange for Ticker = �DJI�
-- b. where IntraDayRange is larger than $500.00.
-- c. Make sure to format your output nicely and present the result set in the descending order of the Intra-day range.
SELECT [Date],
	[IntraDayChange] = [Open] - [Close],
	[IntraDayRange] = [High] - [Low]
FROM TS_DailyData 
WHERE Ticker = 'DJI' 
	AND [High] - [Low] > 500
ORDER BY [IntraDayRange] DESC