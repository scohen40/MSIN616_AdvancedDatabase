--Chapter 5 Homework
--Sarah Cohen

/* AP Database */
USE AP
GO

--1. Write a SELECT statement that returns two columns from the Invoice table:
-- VendorID and PaymentSum, where PaymentSum is the sum of the PaymentTotal column. 
--Group the result set by VendorID.
SELECT VendorID, 
	SUM(PaymentTotal) AS PaymentSum
FROM Invoices
GROUP BY VendorID

--2. Repeat exercise 1 (above) but this time return VendorName instead of VendorID.
--3. Write a SELECT statement to return three columns: VendorName, InvoiceCount, and
--InvoiceSum. InvoiceCount is the count of the number of invoices, and InvoiceSum is the sum of
--the InvoiceTotal column. Group the results by vendor. Sort the result set so the vendor with
--the highest number of invoices appears first.
--4. Modify the SELECT statement in 3 above so that they result set is sorted by the InvoiceSum in
--descending order and is limited to the Vendors with InvoiceSum greater than $500.00
--Product Orders Database
--5. Write a SELECT statement that returns these columns:
--a. The count of the number of orders in the Orders table
--b. The sum of the TaxAmount column in the Orders table
--6. Write a SELECT statement that returns one row for each category that has products. The
--statement should return these columns:
--a. The CategoryName column from the Categories table
--b. The number of products in each category
--c. The list price of the most expensive product in each category
--Sort the result set so the category with the most products appears first.
--7. Write a SELECT statement that returns one row for each customer that has orders. The
--statement should return these columns:
--a. The EmailAddress column from the Customers table
--b. The total price of the items the customer has ordered (Hint: multiply the item price in
--the OrderItems table by the quantity in the OrderItems table)
--c. The total discount applied to the items the customer has ordered (Hint: multiply the
--discount amount column in the OrderItems table by the quantity in the OrderItems
--table)
--Sort the result set in descending sequence by the price total for each customer.
--8. Write a SELECT statement that returns one row for each customer that has orders. The
--statement should return these columns:
--a. The EmailAddress column from the Customers table
--b. A count of the number of orders for each customer
--c. The total amount for the orders for each customer (Hint: First, subtract the discount
--amount from the price. Then, multiply by the quantity.)
--Return only those rows where the customer has more than 1 order.
--Sort the result set in descending sequence by the sum of the line item amounts.
--9. Modify the solution to exercise 4 so it only counts and totals line items that have an ItemPrice
--value that’s greater than 400.
--10. Write a SELECT statement that answers this question: What is the total amount ordered for each
--product? Return these columns:
--a. The product name from the Products table
--b. The total amount for each product in the OrderItems table (Hint: You can calculate the
--total by subtracting the discount amount from the item price and then multiplying it by
--the quantity)
--Use the ROLLUP operator to include a row that gives the grand total.
--11. Write a SELECT statement that answers this question: Which customers have ordered more than
--one type of product? Return these columns:
--a. The email address from the Customers table
--b. The count of distinct products from the customer’s orders
--Library Database
--12. Write a SELECT statement that returns names of all Publishers with number of nonfiction books
--for each publisher.
--13. Write a SELECT statement that returns titles of all Computer Science books
--14. Write a SELECT statement that returns all authors with the number of books they wrote or co-
--authored ordered by the number of books. Make sure not to miss the author(s) who did not
--write any books in our library. A sample output appears at right (CHECK DOCUMENT FOR PICTURE)
--15. Write a SELECT statement that returns three fields: The average, minimal, and maximal length
--of a book title: (CHECK DOCUMENT FOR PICTURE)