/*
Understand how SQL Server works - there's a server, there are clients, and how sql connects them.
Don't have to know the types (web based etc.)

Databases 
understand about datatypes and that diff data is diff types. 
must know primary keys

Did a little bit about relationships between tables

Know DDL, DML, and CRUD!
Understand how to write an update and delete statement but we obviously focused on select statements more (DML and read)
SQL Coding Norms - super important! 

If you're not sure how to write a query, put SOMETHING down that you know is right and you will get partial credit. 
You just have to try. 

Look at the Chapter Summaries. 

Oder By

Not being asked about different buttons on SSMS

Chapter 3 is a big one
Select, between, where, prob won't be asked 'ways to select columns'
prob will be asked 'list the 5 arithmetic operators
alias
convert
getdate
datediff

order of cause execution - know this 
only time you can use an alias after assigning is in order by (and limit offset which you rarely use)

not concerned about offset and fetch

Chapter 4 - MUST know the different REAL joins
inner, left, right, outer, self
cross not so much
minus aren't real joins but might use to exclude

inner join multiple tables

NO Explicit Syntax

SET operators - have to have the same number of columns and same data type, sandwhich as opposed to a puzzle (join)
They would use the col titles from the first table selected

UNION, 
EXCEPT - if they're an employee don't include them in a list 
INTERSECT - opposite of EXCEPT

*/
--to get all 
SELECT CustomerFirst, CustomerLast
FROM Customers
UNION
SELECT FirstName, LastName
FROM Employees
--to get the person in both lists
SELECT CustomerFirst, CustomerLast
FROM Customers
INTERSECT
SELECT FirstName, LastName
FROM Employees
--to get all customers who aren't in Employees
SELECT CustomerFirst, CustomerLast
FROM Customers
EXCEPT
SELECT FirstName, LastName
FROM Employees

/*
Full Qualified table names and when to use them - only used when sharing data between databases, servers, etc.
Know the order of the levels.

Chapter 5 - Summarizing and Aggregates
GROUPING SETS - similar to rollup and cube, only includes summary rows for specified groups
*/

SELECT VendorState, 
	VendorState, 
	VendorCity
FROM Vendors v
WHERE VendorState IN ('IA', 'NJ')
--GROUP BY VendorState, VendorCity WITH ROLLUP --3 summary rows
--GROUP BY VendorState, VendorCity WITH CUBE --7 summary rows
GROUP BY GROUPING SETS(VendorState, VendorCity) --all summary rows

/*
Chapter 9
Focus on getdate, sysdate, day, month, year, datepart, eomonth, dateadd, datediff, datefromparts
know all numeric ones
know all string ones

CASE - very important
COALesc and ISNULL
IIF

CHOOSE isn't common

RANKS - know all (has OVER - based on a particular column)
NTILE you put an n for any number and it splits it into that many groups
*/
SELECT InvoiceTotal,
	NTILE(2) OVER(ORDER BY InvoiceTotal DESC) AS Tile2
FROM Invoices

