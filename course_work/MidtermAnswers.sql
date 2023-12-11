--MIDTERM ANSWERS
--10/30/2023
--Sarah Cohen

USE MidtermS21
GO

/* Group 1: 5 questions x 4 points each = 20 points*/

--1.1. [21] titles of all the books in the Inventory which were published by Apricot.
SELECT b.Title 
FROM Inventory i
JOIN Book b ON i.Item_ID = b.Book_ID
JOIN Publisher p ON b.Publisher_ID = p.Publisher_ID
WHERE p.Name = 'Apricot'

--1.2. [21] three columns: FirstName, M. initial, and LastName of all writers who actually wrote a book.
SELECT w.FirstName, w.MiddleInitials, w.LastName
FROM Writer w
JOIN JNC_BookWriter jnc ON (w.Writer_ID = jnc.Writer_ID)
GROUP BY w.FirstName, w.MiddleInitials, w.LastName

--1.3. [21] three columns representing: 
--Book Title, 
--Writer 
--and Publisher 
--of all the books with titles beginning with the letters D – H.
SELECT b.Title AS [BookTitle], 
	(w.FirstName + ' ' + ISNULL((w.MiddleInitials + ' '), '') + w.LastName) AS [Writer],
	p.[Name] AS [Publisher]
FROM Book b 
JOIN Publisher p ON (b.Publisher_ID = p.Publisher_ID)
JOIN JNC_BookWriter jnc ON (b.Book_ID = jnc.Book_ID)
JOIN Writer w ON (jnc.Writer_ID = w.Writer_ID)
WHERE LEFT(b.Title, 1) IN ('D', 'E', 'F', 'G', 'H')

--1.4. [22] titles of all the books with retail prices higher than $25.00 and less than $44.00
SELECT b.Title
FROM Book b
JOIN Inventory i ON (b.Book_ID = i.Item_ID)
WHERE i.RetailPrice BETWEEN 25.00 AND 44.00

--1.5. [22] titles and published year of the top 10 oldest books
SELECT TOP 10 [Year], Title 	
FROM Book
ORDER BY [Year] 


/* Group 2: 5 questions x 8 points each = 40 points */

--2.1. [21] titles of all the books with quantities greater than 12 copies in the inventory.
SELECT b.Title
FROM Inventory i 
JOIN Book b ON (i.Item_ID = b.Book_ID)
WHERE i.Quantity > 12

--2.2. [21] three columns (one row) representing: 
--total sales proceeds, 
--maximal price paid for any book, 
--and minimal price for which a book was sold
SELECT SUM(Quantity * Price) AS TotalSales,
	MAX(Price) AS MaxPrice,
	MIN(Price) AS MinPrice
FROM Sales

--2.3. [21] titles, retail prices, and publishers of all books written in the 21st century that had no sales.
SELECT b.Title, 
	i.RetailPrice,
	p.[Name] AS Publisher
FROM Book b 
JOIN Inventory i ON (b.Book_ID = i.Item_ID)
JOIN Publisher p ON (b.Publisher_ID = p.Publisher_ID)
LEFT JOIN Sales s ON (i.Item_ID = s.Item_ID)
WHERE b.[Year] > 1999 
	AND s.Sales_ID IS NULL

--2.4. [22] titles, author last name, and quantity of books in inventory (use 0 if there are none) 
--and use UNION to first select any books where a title contains “Python” and then where the title starts with a “C”
SELECT DISTINCT b.Title,
	w.LastName,
	ISNULL(SUM(i.Quantity), 0) AS QtyBooks
FROM Inventory i
RIGHT JOIN Book b ON (i.Item_ID = b.Book_ID)
JOIN JNC_BookWriter jnc ON (b.Book_ID = jnc.Book_ID)
JOIN Writer w ON (jnc.Writer_ID = w.Writer_ID)
GROUP BY b.Title, w.LastName
HAVING b.Title LIKE '%Python%'
UNION
SELECT b.Title,
	w.LastName,
	ISNULL(SUM(i.Quantity), 0) AS QtyBooks
FROM Inventory i
RIGHT JOIN Book b ON (i.Item_ID = b.Book_ID)
JOIN JNC_BookWriter jnc ON (b.Book_ID = jnc.Book_ID)
JOIN Writer w ON (jnc.Writer_ID = w.Writer_ID)
GROUP BY b.Title, w.LastName
HAVING LEFT(b.Title, 1) = 'C' 

--2.5. [21] sales records ordered by date displaying the following columns:
--date, book title, writer’s last name, publisher, number copies sold, price, city location of sale. 
--Notice that some sales records will be repeated – those with multiple writers per title of the book sold.
SELECT s.SalesDate, 
	b.Title,
	w.LastName,
	p.[Name],
	s.Quantity,
	s.Price,
	l.City
FROM Sales s
JOIN Book b ON (s.Item_ID = b.Book_ID)
JOIN [Location] l ON (s.Location_ID = l.Location_ID)
JOIN Publisher p ON (b.Publisher_ID = p.Publisher_ID)
JOIN JNC_BookWriter jnc ON (b.Book_ID = jnc.Book_ID)
JOIN Writer w ON (jnc.Writer_ID = w.Writer_ID)
ORDER BY s.SalesDate


/* Section 3: 5 questions x 12 points each = 60 points */

--3.1. [24] all the writers with the number of books they wrote which are tracked in our inventory 
--AND have a total of the books listed as the last row. 
--Display the results in the order of the most to least prolific writers (if this changes the location of the last row, it’s fine).
SELECT (w.FirstName + ' ' + w.LastName) AS WriterName,
	COUNT(*) AS NumBooksWritten
FROM Inventory i
JOIN JNC_BookWriter jnc ON (i.Item_ID = jnc.Book_ID)
JOIN Writer w ON (jnc.Writer_ID = w.Writer_ID)
GROUP BY (w.FirstName + ' ' + w.LastName) WITH ROLLUP
ORDER BY NumBooksWritten DESC

--3.2. [21] all writers (in one column display first name, MI, and last name) and
--total retail and wholesale value of all their books in the inventory. 
--If the given writer has no books in the inventory, the result should show 0 for both total retail and total wholesale.
SELECT (w.FirstName + ' ' + ISNULL(w.MiddleInitials + ' ', '') + w.LastName) AS WriterName,
	ISNULL(SUM(i.WholesalePrice * i.Quantity), 0) AS TotalWholeSaleValue,
	ISNULL(SUM(i.RetailPrice * i.Quantity), 0) AS TotalRetailValue
FROM Writer w
LEFT JOIN JNC_BookWriter jnc ON (w.Writer_ID = jnc.Writer_ID)
LEFT JOIN Inventory i ON (jnc.Book_ID = i.Item_ID)
GROUP BY (w.FirstName + ' ' + ISNULL(w.MiddleInitials + ' ', '') + w.LastName)

--3.3. [22] rank and dense rank of books with the lowest inventory, including books with no inventory. 
--Alias the columns with SHORT (up to 7 words) explanation of the difference between the two ranks.
SELECT RANK() OVER(ORDER BY Quantity) AS QuantityRank,
	DENSE_RANK() OVER(ORDER BY Quantity) AS DenseRank
FROM Inventory i 
RIGHT JOIN Book b ON (i.Item_ID = b.Book_ID)

--3.4. [22] all authors and the quartile of sales they fall into based on books sold.
SELECT (w.FirstName + ' ' + ISNULL(w.MiddleInitials + ' ', '') + w.LastName) AS WriterName,
	NTILE(4) OVER(ORDER BY SUM(s.Quantity * s.Price)) AS QuarterRank
FROM Sales s
JOIN JNC_BookWriter jnc ON (s.Item_ID = jnc.Book_ID)
JOIN Writer w ON (jnc.Writer_ID = w.Writer_ID)
GROUP BY (w.FirstName + ' ' + ISNULL(w.MiddleInitials + ' ', '') + w.LastName)

--3.5. [22] 6 columns for each location (below) and summary rows for each combination of State, City, and Warehouse possible:
--● State
--● City
--● Warehouse
--● Number of copies in the inventory
--● Minimal Wholesale Price
--● Maximal Retail Price
SELECT l.[State],
	l.[City],
	l.Warehouse,
	SUM(i.Quantity) AS NumInvCopies,
	MIN(i.WholesalePrice) AS MinWholesalePrice,
	MAX(i.RetailPrice) AS MaxRetailPrice
FROM Inventory i
JOIN [Location] l ON (i.Location_ID = l.Location_ID)
GROUP BY l.[State], l.[City], l.Warehouse WITH CUBE