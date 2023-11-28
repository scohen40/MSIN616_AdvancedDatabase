--Lesson 8
--11/27/2023

/* Chapter 11 DDL */

--not doing truncate

--creating a database
CREATE DATABASE database_name;

--creating a table
--you want your db to be as in depth, clear, and concise as possible, data types well defined
--primary key constraint
--identity
--foreign key constraint
--check constraints
--use intelligent constraints, don't leave it out but don't put more than needed

--delete statements
DROP DATABASE db_name(,db_name2..);
--when you drop, it's permanent

--alter statements - changing things
--most of the time when you're working on a db, you're not working from scratch
--altering cols individually is really altering the table, not the col
--altering the FK and PK constraints is also altering the table
ALTER TABLE
--add a new col
ALTER TABLE Vendors
ADD LastTranDate DATE NULL;
--drop a col
ALTER TABLE Vendors
DROP COLUMN LastTranDate;
--change the data type of a col
ALTER TABLE InvoiceLineItems
ALTER COLUMN --etc. (check the slides)
--add a check constraint for new rows only - WITH NOCHECK or WITH CHECK
--add a DK constraint for new and existing rows - WITH NOCHECK or WITH CHECK

--we skipped/are skipping:
--indexes - a small, fast, and optimized way for lookups. it's very useful for connecting the relational tables and searching large tables
--collation - you can auto-sort data in a table by defined rules
--sequences - you can get a col to keep auto-incrementing by a particular MIN/MAX values

--now looking at the AP Database create script
--notice the order that statements will now be created for AP Database Script
GO -- to keep processing it, running multiple statements in quick succession
--use the master, drop if already exists, create the database
--  you need to create your db to be flexible enough to work
--define each table, write constraints
--insert records, one at a time, for all of our tables.

--put foreign key constraints at the en, AFTER INSERTING ALL THE DATA. why? because we haven't yet inserted all of the data into the tables.
--if i'm using invoiceLineItems as InvoiceID but I haven't added any Invoices, you can't use it.

/* Chapter 12 */
-- when we submit the create scripts it should be a .sql that she can run
--look at slides for instructions on how to use the GUI to create a DB

--Between chapters 11 and 12, should be able to create a db, add PKs, FKs, and constraints.


/* Chapter 13 */
--View
-- a select statement that is stored as an object in the db
-- used for commonly requested reports or dataset
CREATE VIEW VendorsMin AS 
	SELECT VendorName, VendorState, VendorPhone
	FROM Vendors;
-- and then
SELECT *
FROM VendorsMin
--different from CTE/temp table which you have to run again and again and expose your code to whomever is running it
--let's say you don't want people to know what the data is, just use it.
--with a view the person can use the data without really knowing what the data actually is by creating a more permanent temp table.
--why use a view?
--1. Design Independence - if you add suddenly 90 col to Vendors table, it will be annoying to find the phone number now
--2. Data Security - restricts access to a dataset by making a view available instead of a whole bunch of tables
--3. Flexibility - Can be CRUDed the same way a regular table would be - CREATE, UPDATE, INSERT, DELETE, etc.
--4. Simplified queries - hides the complexity of the underlying query
--5. Updatability - with restrictions, you can update the underlying data, views CAN update regularly and you can also insert data into my view to (in certain cases) update my table.

-- Updatable vs. Non-Updatable (read-only) Views
--
--if you make a view in your database and I don't have it in mine, then when I try to run my code, it won't run (matters for homework submissions)

--if I change my table > my view changes
--if I change data within my view > it will update my table 
--EXCEPT when using aggregates - non updatable (can't update the underlying table)
--WHY? if i say 'the average life expectency is 100 years old' you can't add a person to the aggregate

--when would you want updateable views? When you have a form on your website that needs limited access to add people
--Updateable (can be CRUDed) as long as:
--1. Cannot include DISTINCT or TOP
--2. Cannot include any AGGREGATE functions
--3. Cannot include any calculated values
--4. Cannot include a GROUP BY or HAVING clause
--5. Cannot use UNION
--updateable if it is simple --has columns, joins and maybe a WHERE clause.

--How to modify a view? (check slide)


--submit all view creation queries seperately from the creation and insertion scripts
