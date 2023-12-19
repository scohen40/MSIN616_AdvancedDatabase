--for part 1 the 6 questions that are worth 7.5 points each.
--for each of those question write only 1 of 2 select statements
--non of queries should return duplicate rows or nameless rows
--for the short answers, no paragraphs
--for 3rd part, design the database with the business rules



-- Question 1: Write an SQL query to select Titles of all books OR First names of all authors
--Option 1: Titles of all books
SELECT Title FROM LBR_Book

-- Question 2: 2. Write an SQL query to select
    --Titles of all books and their publishers arranged in the alphabetical order of publishers (so all the books of a given publisher would appear together)
    --OR
    --Titles of all books and their locations arranged in the alphabetical order of locations (so all the books in a given location would appear together)
--Option 1: Titles of all books and their publishers arranged in the alphabetical order of publishers (so all the books of a given publisher would appear together)
SELECT b.Title AS Book_Title, 
	p.[Name] AS Publisher_Name
FROM LBR_Book b
JOIN LBR_Publisher p ON b.Publisher_ID = p.Publisher_ID

-- Question 3: (really question 4) Write an SQL query to select
    --Titles of all Programming books published by Addison Wesley
    --OR
    --Titles of all Programming books located in the Rec room
--Option 2: Titles of all Programming books located in the Rec room
SELECT b.Title
FROM LBR_JNC_BookCategorization bc 
JOIN LBR_Book b ON bc.Book_ID = b.Book_ID
JOIN LBR_Categorization c ON bc.Categorization_ID = c.Categorization_ID
JOIN LBR_Location l ON b.Location_ID = l.Location_ID
WHERE c.Classification = 'Programming' AND l.Location = 'RecRoom'

-- Question 4: (really question 3) Write an SQL query to select
    --Titles of all books classified as Fiction
    --OR
    --Titles of all books written or co-authored by Brian Kernighan
--Option 1: --Titles of all books classified as Fiction
SELECT b.Title
FROM LBR_JNC_BookCategorization bc
JOIN LBR_Book b ON bc.Book_ID = b.Book_ID
JOIN LBR_Categorization c ON bc.Categorization_ID = c.Categorization_ID
WHERE c.[Classification] = 'Fiction'

-- Question 5: Write an SQL query to select
    --Number of books for each classification category.  List the classifications in decreasing order by the number of books
    --OR
    --Three columns: Book Title, ISBN, Number of co-authors 
		--for each book title which was written by more than one author. 
		--List the books in the alphabetical order by Title.
--Option 1: Number of books for each classification category.  List the classifications in decreasing order by the number of books
SELECT c.[Classification], COUNT(bc.Book_ID) AS NumOfBooks
FROM LBR_JNC_BookCategorization bc
JOIN LBR_Categorization c ON bc.Categorization_ID = c.Categorization_ID
GROUP BY c.[Classification]
ORDER BY COUNT(bc.Book_ID) DESC

-- Question 6: 6. Write an SQL query to select
    --For each author, displayed in the first column as for example Dennis M. Ritchie, title of every book he wrote in the field of Computer Science and its subfield classification. 
    --The first few rows returned by your query might look like:  q6a.PNG (see pdf)
    --OR
    --For each Publisher, the title of every fiction book with its type and genre.  Use blank instead of NULL.
    --The first few rows returned by your query might look like:  q6b.PNG (see pdf)
--Option 1: For each author, displayed in the first column as for example Dennis M. Ritchie, title of every book he wrote in the field of Computer Science and its subfield classification. 
--assumptions: a. you only want the authors who have books b. if there's no subfield, don't list it
SELECT a.FirstName + ' ' + a.LastName AS Author,
	b.Title,
	c.[Classification]
FROM LBR_JNC_AuthorBook ab
JOIN LBR_Author a ON ab.Author_ID = a.Author_ID
JOIN LBR_Book b ON ab.Book_ID = b.Book_ID
JOIN LBR_JNC_BookCategorization bc ON ab.Book_ID = bc.Book_ID
JOIN LBR_Categorization c ON bc.Categorization_ID = c.Categorization_ID
							AND c.Category = 'Subfield'
GROUP BY (a.FirstName + ' ' + a.LastName), b.Title, c.Classification
ORDER BY (a.FirstName + ' ' + a.LastName)
