USE PublicLibrary
GO

--Create an updateable view for all checked out books, showing more information for who borrowed what book:
DROP VIEW IF EXISTS BORROWED_INFORMATION_VIEW;
GO

CREATE VIEW BORROWED_INFORMATION_VIEW AS
SELECT 
	bb.Copy_ID,
	b.Title,
	bb.Card_ID AS LibraryCardNumber,
	lc.First_Name AS BorrowerFName,
	lc.Last_Name AS BorrowerLName,
	lc.Phone AS BorrowerPhone,
	bb.Due_Date
FROM BOOK_BORROWED bb
LEFT JOIN BOOK_COPY bc ON bb.Copy_ID = bc.Copy_ID
LEFT JOIN BOOK b ON bc.Book_ID = b.Book_ID 
LEFT JOIN LIBRARY_CARD lc ON bb.Card_ID = lc.Card_ID 
WHERE Borrowed_Status = 'CHECKED OUT'
GO

SELECT * FROM BORROWED_INFORMATION_VIEW;