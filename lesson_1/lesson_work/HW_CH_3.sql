-- Chapter 3 Homework
-- Sarah Cohen

/* AP Database */
--1. Write a SELECT statement that returns from the Vendors table: VendorContactFName,VendorContactLName, and VendorName. 
--Sort the result set by the last name, then by the first name.
select VendorContactFName, VendorContactLName, VendorName from Vendors
order by VendorContactLName
select VendorContactFName, VendorContactLName, VendorName from Vendors
order by VendorContactFName
--2. Write a SELECT statement that returns four columns from the Invoices table:
-- a. Number: Column alias for InvoiceNumber column
-- b. Total: Column alias for the InvoiceTotal column
-- c. Credits: Sum of the PaymentTotal and CreditTotal columns
-- d. Balance: InvoiceTotal minus the sum of paymentTotal and CreditTotal


--3. Write a SELECT statement that returns one column from the Vendors table named Full Name.
--Create this column from the VendorContactFName and VendorContactLName columns. 
--Format is as follows: last name, comma, first name (e.g., “Pence, Michael”). Sort the result by last name, then first name.

/* Finance Database */

--4. Indicate that the queries below should be run against the Finance database.

--5. Select all columns from the TS_DailyData table.

--6. Write a SELECT statement that returns two columns:
--a. Date and IntraDayChange defined as the difference between [Close] and [Open] for Ticker = ‘DJI’ where this difference is larger than $500.00.
--b. Make sure to format your output nicely and present the result set in the descending order of the Intra-day change.

--7. Repeat #6, this time return all records where the absolute value of IntradayChange was greater than $500.00

--8. Write a SELECT statement that returns two columns:
-- a. Date and IntraDayRange defined as the difference between [High] and [Low] for Ticker = ‘DJI’ where this difference is larger than $500.00.
-- b. Make sure to format your output nicely and present the result set in the descending order of the Intra-day range.

--9. Combine queries #5 and #7:
-- a. Write a SELECT statement that returns Three columns: Date, IntraDayChange , and IntraDayRange for Ticker = ‘DJI’
-- b. where IntraDayRange is larger than $500.00.
-- c. Make sure to format your output nicely and present the result set in the descending order of the Intra-day range.
