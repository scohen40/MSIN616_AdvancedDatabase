/*
Understand how SQL Server works - there's a server, there are clients, and how sql connects them.
Don't have to know the types (web based etc.)

Databases 
understand about datatypes and that diff data is diff types. 
must know primary keys

Did a little bit about relationships between tables

Know DDL, DML, and CRUD!

Data Definition Language: CREATE, ALTER, DROP, RENAME, TRUNCATE, COMMENT
CREATE DATABASE AP;

CREATE TABLE Invoices {
	InvoiceID INT NOT NULL IDENTITY PRIMARY KEY,
	VendorID INT NOT NULL REFERENCES Vendors(VendorID),
	InvoiceNumber VARCHAR(50) NOT NULL
};

ALTER TABLE Invoices
ADD BalanceDue MONEY NOT NULL;

ALTER TABLE Invoices
DELETE COLUMN BalanceDue;

CREATE INDEX IX_Invoices_VendorID
	ON Invoices (VendorID);


Data Manipulation Language: SELECT, INSERT, UPDATE, DELETE, MERGE, CALL, EXPLAIN PLAN, LOCK TABLE

INSERT INTO Invoices
(VendorID, InvoiceNumber, InvoiceDate, InvoiceTOtal, TermsID, InvoiceDueDate)
VALUES 
(12, '3289175', '4/18/2022', 165, 3, '5/18/2022');

UPDATE Invoices
SET CreditTotal = 35.89
WHERE InvoiceNumber = '367447';

UPDATE Invoices
SET InvoiceDueDate = DATEADD(DAY, 30, InvoiceDueDate)
WHERE TermsID = 4;

DELETE FROM Invoices
WHERE InvoiceNumber = '4-342-8069'

DELETE FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal = 0

CRUD: CREATE/INSERT <-> READ(SELECT) <-> UPDATE <-> DELETE

Understand how to write an update and delete statement but we obviously focused on select statements more (DML and read)
SQL Coding Norms - super important! 
- Start each new clause on a new line
- Break long clauses into multiple lines and indent continued lines
- Use all capital letters for each keyword
- Capitalize the first letter in each word in column and table names
- End each statement with a semicolon (;)
- Use comments (-- or /* */ to document code

If you're not sure how to write a query, put SOMETHING down that you know is right and you will get partial credit. 
You just have to try. 

Look at the Chapter Summaries. 

Oder By

Not being asked about different buttons on SSMS

Chapter 3 is a big one
Select, between, where, prob won't be asked 'ways to select columns'
prob will be asked 'list the 5 arithmetic operators:
1. multiplication
2. division
3. modulo (remainder)
4. addition
5. subtraction

alias - AS
convert: converting columns to a different data type for display - 'dated' + CONVERT(char(8), PaymentDate, 1)
getdate
datediff
left and right
distinct
top: must use order by 
- top 5 
- top 5 percent
- top 5 with ties (will return more than X number of rows if there's a tie)

<>, !=  - Not equal

order of cause execution - know this 
only time you can use an alias after assigning is in order by (and limit offset which you rarely use)

not concerned about offset and fetch

Default sequence for ascending sort: Nulls, Special Chars, Numbers, Letters
ASC, DESC

CREATING COMPOUNT CONDITIONS WITH LOGICAL OPERATORS in order by precedence:
NOT, AND, OR
WHERE operators:
IS NULL, BETWEEN, IN(item1, item2, item3), LIKE 
(
	% any string of zero or more characters, 
	- any single character, 
	[ ] a single character listed within the brackets, 
	[ - ] a single character within the given range, 
	[ ^ ] a single character not listed after the caret
)

Chapter 4 - MUST know the different REAL joins
--inner, 
FROM Vendors v
JOIN Invoices i ON v.VendorID = i.VendorID (AND ... can be here or in the WHERE)

--left, 

--right, 

--outer = FULL JOIN,


--self - can be inner, left, or any other kind
Pair vendors with all other vendors in their city:
SELECT DISTINCT v1. VendorName, 
				v1. VendorCity,
				v1.VendorState
FROM Vendors v1
JOIN Vendors v2 ON (v1.VendorCity = v2.VendorCity)
			AND (v1.VendorState = v2.VendorState)
			AND (v1.VendorID <> v2.VendorID)
ORDER BY v1.VendorState, v1.VendorCity



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

CAST AS INT


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

