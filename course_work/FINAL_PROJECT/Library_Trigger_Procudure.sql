/*
Sarah Cohen and Abhilasha Hirawat
This file contains the Library's Trigger and Stored Procedure.
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



/* STORED PROCEDURE: Check if a Library_Card is active. */
DROP PROC IF EXISTS SP_CHECK_CARD_ACTIVE;
GO
CREATE PROC SP_CHECK_CARD_ACTIVE
	@CardID INT
AS 
BEGIN
	--get the card details for the card from the Library_Card table and check if the card is not expired
	IF (SELECT Expiration_Date FROM LIBRARY_CARD WHERE Card_ID = @CardID) > GETDATE()	
		--if is not expired print it and its expiration date
		SELECT Card_ID, Expiration_Date
		FROM LIBRARY_CARD
		WHERE Card_ID = @CardID
	ELSE 
		PRINT 'CARD ' + CAST(@CardID AS VARCHAR) + ' IS EXPIRED'
END
GO
--TEST SP_CHECK_CARD_ACTIVE
EXEC SP_CHECK_CARD_ACTIVE @CardID = 100
INSERT INTO LIBRARY_CARD (First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES ('Rhode', 'Dahl', '711 Dreary Lane', 'Placeberg', 'NA', '54321', '9876543210', '1900-02-12', '2021-01-10', 1, '2022-01-10', '2021-01-10', 0.00);
EXEC SP_CHECK_CARD_ACTIVE @CardID = 111