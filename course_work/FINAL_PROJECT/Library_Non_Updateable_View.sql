USE PublicLibrary
GO
-- Create a view of card holders with amount due for more than $10
CREATE VIEW HIGHDUE_CARDS_VIEW AS
SELECT
    lc.Card_ID,
    lc.First_Name,
	lc.Last_Name,
    SUM(lc.Balance_Due) AS Total_Due_Amount
FROM
    LIBRARY_CARD lc
INNER JOIN
    BOOK_BORROWED bb ON lc.Card_ID = bb.Card_ID
INNER JOIN
	BOOK_COPY bc ON bc.Copy_ID = bb.Copy_ID
INNER JOIN
	BOOK b ON b.Book_ID = bc.Book_ID
INNER JOIN
    SECTION s ON s.Section_ID = b.Section_ID
GROUP BY
    lc.Card_ID,lc.First_Name,lc.Last_Name
HAVING
    SUM(lc.Balance_Due) > 10.00;