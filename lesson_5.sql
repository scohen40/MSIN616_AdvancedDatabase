/*
10/16/2023
SQL Query Analyzer
It's a newer feature to do more research into an error by looking at the execition plan.

Subquery- standalone query that is included as a 'steppingstone' in a larger query.
Some people confuse joins and subqueries. they are used together but not the same thing. 
Subqueries are used by joins. Think of it as another temporary table that you're creating to make your life easier and analytics better.
4 places you can put it where, from/join, having, select
Look at our question and come up with steps to get that to happen.
Example 1- Find all invoices with totals above the Invoice Total average. 
1. find the average
2. find the invoices above it
*/
--find the average
SELECT AVG(InvoiceTotal) AS avg_inv_tot
FROM Invoices
--find the invoices with InvoiceTotal's above it
select *
from Invoices i
where InvoiceTotal > (
	select avg(InvoiceTotal) as avg_inv_total --can't be referenced from outside because subqueries aren't joins. if you put the subquery in a join you would be able to reference it in the select.
	from Invoices
	)--avg
order by InvoiceTotal desc

--Example 2: Get a list of vendors with no invoices, 2 ways
--way 1
select v.VendorID
from Vendors v
left join Invoices i on v.VendorID = i.VendorID
where i.VendorID is null
--way 2
select *
from Vendors
where VendorID not in (select distinct VendorID from Invoices)

--Example 3: find all invoices for vendors in CA - 2 ways
-- find vendors in CA and then find their invoices 
--way 1:
select i.*
from Vendors v
join Invoices i on i.VendorID = v.VendorID
where VendorState = 'CA'
--way 2:
select *
from Invoices
where VendorID in (
	select VendorID 
	from Vendors
	where VendorState = 'CA')

--Example 4: Get the most recent invoice date and average invoice total for the vendors with the top 5 averages
--break it down-
--top five average invoice total
--most recent invoice date
--average invoice total

select v.VendorID, 
	max(i.InvoiceDate) as max_inv_date,
	temp_table.avg_inv_total,
	avg(InvoiceTotal) --same answer whether it's from the temp table or this table
from Vendors v
join Invoices i On v.VendorID = i.VendorID
join (select top 5 VendorID,
	avg(InvoiceTotal) as avg_inv_total
	from Invoices i
	group by VendorID
	order by avg(InvoiceTotal) desc) as temp_table on temp_table.VendorID = v.VendorID
group by v.VendorID, avg_inv_total

--Example 5: Get each vendor's most recent invoice date - 2 ways
--most recent inv date by vendor

--way 1
select VendorName, 
	max(i.InvoiceDate) as max_inv_date
from Vendors v
join Invoices i on v.VendorID = i.InvoiceID
group by v.VendorName

--way 2 - correlated subquery = the result of the subquery is going to change based on the row of our results
-- it correlates to each row, the answer is different for each row. every vendor name is different in every row.
--every query has to be able to run by itself. with corrolated subqueries you have to use your imagination a little bit.
select v.VendorName,
	(select max(InvoiceDate)
	 from Invoices i
	 where v.VendorID = i.VendorID) as max_inv_date--now i want the max invoice date
from Vendors v


/*
10/23/2023
One thing to always remember about subqueries is breaking down the steps.

Mostly they are in JOINs.
Problem is you can have subq's with a million joins in them and they get very complex and confusing.
So instead we can use a CTE.

CTE

*/
--QUESTION: Get the top Vendor in each state based on the sum of all their Invoice totals

--steps:
--get vendors in states
--get the sum of all invoices
--get the top vendors by state

--How to get vendors in states, and throw in what their invoice totals are
--make this into a cte

SELECT  VendorName, 
		VendorState,
		SUM(i.InvoiceTotal) AS Sum_Inv_Total
	FROM Vendors v
	JOIN Invoices i ON v.VendorID = i.VendorID 
	GROUP BY v.VendorName, v.VendorState;

WITH sum_i_total_table AS (
	SELECT  VendorName, 
			VendorState,
			SUM(i.InvoiceTotal) AS Sum_Inv_Total
	FROM Vendors v
	JOIN Invoices i ON v.VendorID = i.VendorID 
	GROUP BY v.VendorName, 
			v.VendorState
), top_in_state AS ( 
	SELECT VendorState,
			MAX(Sum_Inv_Total) AS Max_Inv_Total
	FROM sum_i_total_table
	GROUP BY VendorState
)
SELECT * 
FROM sum_i_total_table sitt
JOIN top_in_state t ON sitt.VendorState = t.VendorState
	AND sitt.sum_inv_total = t.max_inv_total;



--RECURSIVE CTEs 
--recursion is when you need the answer to answer the question


--ALL fxn
--Get a list of Vendors and their Invoices where the Invoice Total is greater than ALL of the InvoiceTotals for VendorID 34

--get all the vendors and their invoices with a join
--get the invoice totals > vendor34's totals

SELECT v.VendorID, 
	v.VendorName,
	i.InvoiceNumber,
	i.InvoiceTotal
FROM Vendors v
JOIN Invoices i on v.VendorID = i.VendorID
WHERE i.InvoiceTotal > ALL (
	SELECT InvoiceTotal
	FROM Invoices
	WHERE VendorID = 34
	)

--ANY fxn - greater than any one of them
SELECT v.VendorID, 
	v.VendorName,
	i.InvoiceNumber,
	i.InvoiceTotal
FROM Vendors v
JOIN Invoices i on v.VendorID = i.VendorID
WHERE i.InvoiceTotal > ANY (
	SELECT InvoiceTotal
	FROM Invoices
	WHERE VendorID = 34
	)

--Exist or Not Exist

--QUESTION: Get vendors with no invoices
SELECT * 
FROM Vendors v
WHERE NOT EXISTS(
	SELECT *
	FROM Invoices i
	WHERE i.VendorID = v.VendorID --correlated subquery because doing it inside
)






