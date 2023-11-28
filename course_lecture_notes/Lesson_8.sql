--Lesson 7
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

