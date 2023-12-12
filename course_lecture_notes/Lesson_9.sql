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

review:
page 22 - look at this sheet and try applying the normal forms
understand data types
understand fully qualified table names
keys
relationships between tables
ddl
dml
crud
update, alter, drop
create table
altering table
select statements
sql coding normas page 41 !! must use on the final, if can't understand, can't give credit
comments, don't be afraid to use
chapter 3 you should know COLD
TOP WITH TIES
WHERE with LIKEs
When can you use an alias
offset and fetch might not have a question
1 schools of thought - try and pull data as cleanly as possible on the final, she'd rather finish the test
JOINs - you better know ALL the different types of joins
SET operators are important 
Aggregating and Summarizing
page 118 - know FLAWlessless
page 119 review
group by
count(*) with group by
rollup
cube 
grouping sets
over and partition by - doesn't think she asked about this but will confirm later, can prop skip
can prob skip moving averages
chapter 9 - just know the functions but don't memorize 
number functions are simple
date - don't spent so much time memorizing
MUST know CASE statements
IIF
CHOOSE - know it exists
IS NULL
COALESCE
ORDERING AND RANKING

KNOW SUBQUERIES
would recommend using CTE's but can also use subqueries
all, any, exists, doens't think she asked about it

Chapter 10 - know super well and tie back to the library spreadsheet

Dependency Diagrams - doesn't think she asked us to draw but asked what it is
what an ERD is, absolutely know ERDs

Review Active Directories a little bit, what Azure is, what AD is and what Authorization is
understand the different types of backups
what recovery is
how to create a db
key constraints
altering dbs

read through ap db creation script

chapter 12 - easier way but don't have to demostrate

views absolutely know

from Chapter 14 and on, know only the concepts, no code
understand variable scope
transactions - what it is, diff between physical and logical
ACID properties
differences between Triggers, Transactions, and Stored Procedures



*/