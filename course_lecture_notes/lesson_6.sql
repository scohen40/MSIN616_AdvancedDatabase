--Lesson 6

--Normal Forms
--1NF

--2NF
-- Table is in 1NF
-- All columns depend on the table's PK
-- Composite Key
-- No columns have 'partial dependence'

--3NF
-- Table is in 1NF and 2NF
-- All cols are not 'transitively dependent' where one field is dependent on a non-pk field

--4NF
-- does not crontain 2 or more independent multi-valued or multi-faceted _____


--Dependency Diagram
--much more academic persuit to remove violating dependencies

--line with no arrow shows composite keys
--when there's an arrow it means 'I know this data because of this data'

--Functional Dependencies - Atomic Data
--Partial Dependencies - Dependent on PART of the PK, You can know C2 just from knowing C1
--Transitive - Dependent on a NON PK
-- need to remove parial and transitive dependencies to acheive 2NF and 3NF
-- move partial and transitive dependencies to seperate tables

--for homeworks, take a screenshot of whatever question answer, put into a powerpoint on its own slide with the question it's answering. Then submit the powerpoint?
--1. dependency  - use arrows and squares in a powerpoint, export to pdf, and submit screenshots of the diagrams made
--2. entity diagram - website tools - also submit screenshots

