/*
Sarah Cohen and Abhilasha Hirawat
This file contains the rough ideas and outlines for the Library's Trigger and Stored Procedure.
*/

/* TRIGGER: Update the return date of Book_Borrowed when the status is changed to 'RETURNED' */

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
		FROM BOOK_BORROWED bb
		INNER JOIN interted i ON bb.Borrowed_ID = i.Borrowed_ID
		WHERE i.Returned_Date IS NULL AND i.Borrowed_Status = 'RETURNED';
	END

END
GO


/* STORED PROCEDURE: Check if a Library_Card is active. */

CREATE PROCEDURE PROC_BOOK_BORROWED_INSERT
	@CardID INT
AS 
BEGIN
	--get the card details for the card from the Library_Card table
	--check if the card is active
	--print if is and expiration date

END
GO
