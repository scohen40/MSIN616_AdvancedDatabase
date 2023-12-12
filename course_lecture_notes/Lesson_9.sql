/*


How to store a T-SQL Statement:
1. Script
2. Stored Procedure

Example -
*/
--Creating
USE AP;
GO

CREATE PROC spInvoiceReport
AS 

SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices i
JOIN Vendors v ON i.VendorID = v.VendorID
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
ORDER BY VendorName;

--Running
EXEC spInvoiceReport;

--Stored Procedure that copies a table:
USE AP;

DROP PROC IF EXISTS spCopyInvoices;

GO

CREATE PROC spCopyInvoices
AS 
DROP TABLE IF EXISTS InvoiceCopy;
	SELECT * INTO InvoiceCopy
	FROM Invoices;

EXEC spCopyInvoices

/*

Declaring Parameters - 
@DateVar date  - input parameter that accepts a date value
@VendorVar varchar(40) = NULL - optional input, parameter that accepts a character value
@InvTotal money OUTPUT - output parameter that returns a monetary value

3. User-defined function
4. Trigger - stored procedure that runs automatically when various events happens.
*/




/*



Transactions are the same thing as ?

For parts 8 and 9 of the project you need to create a trigger and a stored  procedure - due before class next week.

FINAL - on all the chapters:
Part 1 = Queries
for each question there will be two queries on anything and you can choose which one you want to write. pick 1.
Part 2 = Short Answers
general knowledge of sql, like normal forms, acid, etc.
Part 3 = Database Design
will be given a spreadsheet and asked to design a well designed, unmessed data, database

Need to know the Normal Forms COLD. If you study 1 thing it should be that.

ANYTHING AFTER CHAPTER 13 THE CODE IS NOT BEING TESTED ON IN THE FINAL, KNOW CONCEPTS LIKE ACID AFTER THAT




*/