/*
Sarah Cohen and Abhilasha Hirawat
This file contains the Library's Trigger.
*/

/* TRIGGER: Update the return date of Book_Borrowed when the status is changed to 'RETURNED' */
USE PublicLibrary
GO

CREATE TRIGGER TRIG_BOOK_BORROWED_UPDATE
ON BOOK_BORROWED
AFTER UPDATE
AS 
BEGIN
	--Check for books that are returned and the return date isn't yet set
	IF EXISTS (SELECT * FROM inserted WHERE Returned_Date IS NULL AND Borrowed_Status = 'RETURNED')
	BEGIN
		UPDATE BOOK_BORROWED
		SET Returned_Date = GETDATE()
		FROM BOOK_BORROWED
		WHERE Returned_Date IS NULL AND Borrowed_Status = 'RETURNED'
	END

END
GO

--TEST TRIG_BOOK_BORROWED_UPDATE
SELECT * FROM BOOK_BORROWED
UPDATE BOOK_BORROWED
SET Borrowed_Status = 'RETURNED'
WHERE Borrowed_ID = 2 --EDIT THIS NUMBER FOR A BOOK STILL CHECKED OUT
SELECT * FROM BOOK_BORROWED