/* CREATE DATABASE */

USE MASTER 
GO
IF (EXISTS (SELECT NAME 
FROM master.dbo.sysdatabases
WHERE ( NAME = N'PublicLibrary')))

BEGIN
DROP DATABASE PublicLibrary
END

CREATE DATABASE PublicLibrary
GO

USE PublicLibrary
GO

/*CREATE TABLES*/

--Author table ---
CREATE TABLE AUTHOR(
    Author_ID INT NOT NULL IDENTITY(1,1),
	Author_FName VARCHAR(15) NOT NULL,
	Author_LName VARCHAR(15) NOT NULL,
	Author_Phone CHAR(10),
	[Address] VARCHAR(45),
	City VARCHAR(12),
	[State] CHAR(2),
	Zip CHAR(5)
	CONSTRAINT [PK_AUTHOR] PRIMARY KEY (Author_ID)
)
GO

--Publisher Table--
CREATE TABLE PUBLISHERS(
	Publisher_ID INT NOT NULL IDENTITY(200,1),
	Publisher_Name VARCHAR(40) NOT NULL,
	[Address] VARCHAR(45),
	Phone CHAR(10),
	City VARCHAR(20),
	[State] CHAR(2),
	CONSTRAINT[PK_PUBLISHERS] PRIMARY KEY (Publisher_ID)
)
GO

--Section Table--
CREATE TABLE SECTION(
	Section_ID INT NOT NULL IDENTITY(300,1),
	Section_Name VARCHAR(25) NOT NULL,
	Section_Charge DECIMAL(5,2) NOT NULL,
	CONSTRAINT [PK_SECTION] PRIMARY KEY (Section_ID),
	CONSTRAINT [CHK_CHARGE] CHECK (Section_Charge > 0),
	CONSTRAINT [UIX_SECTION_NAME] UNIQUE (Section_Name)
)
GO

--Book Table--
CREATE TABLE BOOK(
    Book_ID INT NOT NULL IDENTITY (1000,1),
	Publisher_ID INT NOT NULL,
	Section_ID INT NOT NULL,
	Title VARCHAR(45) NOT NULL,
	Price DECIMAL(5,2) NOT NULL,
	Published_Date DATE NOT NULL,
	ISBN CHAR(13) NOT NULL
	CONSTRAINT [PK_BOOK] PRIMARY KEY (Book_ID),
	CONSTRAINT [UIX_BOOK] UNIQUE (ISBN),
	CONSTRAINT [CHK_PRICE] CHECK (Price > 0)
)
GO

--Author Books--
CREATE TABLE AUTHOR_HAS_BOOKS(
    Author_ID INT NOT NULL,
	Book_ID INT NOT NULL
	CONSTRAINT [PK_AUTHOR_HAS_BOOKS] PRIMARY KEY (Author_ID,Book_ID)
)
GO

--Category Table---
CREATE TABLE CATEGORY(
    Category_ID INT NOT NULL IDENTITY(400,1),
	Category_Type VARCHAR(15)NOT NULL
	CONSTRAINT [PK_CATEGORY] PRIMARY KEY (Category_ID),
	CONSTRAINT [UIX_CATEGORY] UNIQUE (Category_Type)
)
GO

--Book_has_Category table--
CREATE TABLE BOOK_HAS_CATEGORY(
    Category_ID INT NOT NULL,
	Book_ID INT NOT NULL
	CONSTRAINT [PK_CATEGBOOKS] PRIMARY KEY (Category_ID,Book_ID)
)
GO

--Book_Copy Table
CREATE TABLE BOOK_COPY(
    Copy_ID INT NOT NULL IDENTITY(3000,1),
    Book_ID INT NOT NULL,
	Condition VARCHAR(15), 
	Copy_Status VARCHAR(20) NOT NULL
	CONSTRAINT [DFLT_Copy_Status] DEFAULT ('AVAILABLE')
	CONSTRAINT [PK_BOOKCOPY] PRIMARY KEY (Copy_ID),
	CONSTRAINT [CHK_COPY_STATUS] 
	CHECK (Copy_Status IN ('AVAILABLE','CHECKED OUT','LOST','UNAVAILABLE'))
)
GO

--Library_Card Table--
CREATE TABLE LIBRARY_CARD(
    Card_ID INT NOT NULL IDENTITY(100,1),
	First_Name VARCHAR(15) NOT NULL,
	Last_Name VARCHAR(20) NOT NULL,
	[Address] VARCHAR(45) NOT NULL,
	City VARCHAR(15) NOT NULL,
	[State] VARCHAR(2) NOT NULL,
	Zip VARCHAR(5) NOT NULL,
	Phone CHAR(10) NOT NULL,
	Birthdate DATE NOT NULL,
	Card_Issue_Date DATE NOT NULL
	CONSTRAINT [DFLT_Card_Issued_Date] DEFAULT (GETDATE()),
	Is_Expired BIT NOT NULL
	CONSTRAINT [DFLT_IS_EXPIRED] DEFAULT (0),
	Expiration_Date DATE NOT NULL
	CONSTRAINT [DFLT_Expiration_Date] DEFAULT (DATEADD(YEAR, 1, GETDATE())),
	Last_Renewal_Date DATE NOT NULL
	CONSTRAINT [DFLT_Last_Renewal_Date] DEFAULT (GETDATE()),
	Balance_Due DECIMAL(6,2) NOT NULL
	CONSTRAINT [DFLT_BALANCE_DUE] DEFAULT (0),
	CONSTRAINT [PK_LIBRARY_CARD] PRIMARY KEY (Card_ID),
	CONSTRAINT [CHK_IS_EXPIRED] 
	CHECK ((Is_Expired = 0 AND Expiration_Date >= GETDATE()) OR (Is_Expired = 1 AND Expiration_Date < GETDATE())), 
	CONSTRAINT [CHK_BIRTHDATE] CHECK (Birthdate <= GETDATE()),
	CONSTRAINT [CHK_EXPIRATION_DATE] CHECK (Expiration_Date >= Last_Renewal_Date),
	CONSTRAINT [CHK_LAST_RENEWAL_DATE] CHECK (Last_Renewal_Date >= Card_Issue_Date),
	CONSTRAINT [CHK_BALANCE_DUE] CHECK (Balance_Due >= 0)
)
GO

--Book Borrowed Table
CREATE TABLE BOOK_BORROWED(
	Borrowed_ID INT NOT NULL IDENTITY(1,1),
	Card_ID INT NOT NULL,
	Copy_ID INT NOT NULL,
	Borrowed_Date DATE NOT NULL
	CONSTRAINT [DFLT_Borrowed_Date] DEFAULT (GETDATE()),
	Due_Date DATE NOT NULL
	CONSTRAINT [DFLT_DUE_DATE] DEFAULT (DATEADD(WEEK, 2,GETDATE())),
	Returned_Date DATE NULL,
	Borrowed_Status VARCHAR(45) NOT NULL
	CONSTRAINT [DFLT_BORROWED_STATUS] DEFAULT ('CHECKED OUT'),
	CONSTRAINT [PK_BOOKBORROWED] PRIMARY KEY (Borrowed_ID),
	CONSTRAINT [CHK_DUE_DATE] CHECK (Due_Date >= Borrowed_Date),
	CONSTRAINT [CHK_RETURNED_DATE] CHECK (Returned_Date >= Borrowed_Date OR Returned_Date = NULL),
	CONSTRAINT [CHK_BORROWED_STATUS] 
	CHECK (Borrowed_Status IN ('RETURNED','CHECKED OUT','OVERDUE','LOST')),
	CONSTRAINT [CHK_RETURNED_STATUS] 
	CHECK ( (Borrowed_Status = 'RETURNED' AND Returned_Date != NULL) OR (Borrowed_Status != 'RETURNED' AND Returned_Date = NULL) ),
	CONSTRAINT [CHK_OVERDUE_STATUS] 
	CHECK ( (Borrowed_Status = 'OVERDUE' AND Due_Date < GETDATE()) OR Borrowed_Status != 'OVERDUE')
)
GO


/* INSERT DATA */

--AUTHOR TABLE
SET IDENTITY_INSERT AUTHOR ON;
INSERT INTO AUTHOR (Author_ID, Author_FName, Author_LName, Author_Phone, [Address], City, [State], Zip) VALUES (1, 'Christopher', 'Paolini', '1234567890', '1234 Elm Street', 'Springfield', 'IL', '62704');
INSERT INTO AUTHOR (Author_ID, Author_FName, Author_LName, Author_Phone, [Address], City, [State], Zip) VALUES (2, 'J.R.R.', 'Tolkien', '2345678901', '2345 Oak Street', 'Fairfield', 'CA', '94533');
INSERT INTO AUTHOR (Author_ID, Author_FName, Author_LName, Author_Phone, [Address], City, [State], Zip) VALUES (3, 'Stephen', 'King', '3456789012', '3456 Maple Ave', 'Madison', 'WI', '53703');
INSERT INTO AUTHOR (Author_ID, Author_FName, Author_LName, Author_Phone, [Address], City, [State], Zip) VALUES (4, 'Lois', 'Lowry', '4567890123', '4567 Pine Rd', 'Austin', 'TX', '73301');
INSERT INTO AUTHOR (Author_ID, Author_FName, Author_LName, Author_Phone, [Address], City, [State], Zip) VALUES (5, 'J.K.', 'Rowling', '5678901234', '5678 Birch Ln', 'Denver', 'CO', '80203');
INSERT INTO AUTHOR (Author_ID, Author_FName, Author_LName, Author_Phone, [Address], City, [State], Zip) VALUES (6, 'C.S.', 'Lewis', '6789012345', '6789 Cedar St', 'Raleigh', 'NC', '27601');
INSERT INTO AUTHOR (Author_ID, Author_FName, Author_LName, Author_Phone, [Address], City, [State], Zip) VALUES (7, 'James', 'Patterson', '7890123456', '7890 Spruce Blvd', 'Phoenix', 'AZ', '85001');
INSERT INTO AUTHOR (Author_ID, Author_FName, Author_LName, Author_Phone, [Address], City, [State], Zip) VALUES (8, 'Jane', 'Austen', '8901234567', '8901 Aspen Way', 'Orlando', 'FL', '32801');
INSERT INTO AUTHOR (Author_ID, Author_FName, Author_LName, Author_Phone, [Address], City, [State], Zip) VALUES (9, 'Noam', 'Chompsky', '9012345678', '9012 Fir Court', 'Seattle', 'WA', '98101');
INSERT INTO AUTHOR (Author_ID, Author_FName, Author_LName, Author_Phone, [Address], City, [State], Zip) VALUES (10, 'Brené', 'Brown', '0123456789', '1023 Elmwood Park', 'Chicago', 'IL', '60601');
SET IDENTITY_INSERT AUTHOR OFF;
--PUBLISHERS TABLE
SET IDENTITY_INSERT PUBLISHERS ON;
INSERT INTO PUBLISHERS (Publisher_ID, Publisher_Name, [Address], Phone, City, [State]) VALUES (200, 'De Gruyter Mouton', '1234 Book Lane', '1234567890', 'Booktown', 'BT');
INSERT INTO PUBLISHERS (Publisher_ID, Publisher_Name, [Address], Phone, City, [State]) VALUES (201, 'HarperCollins', '2345 Novel Ave', '2345678901', 'Storyville', 'SV');
INSERT INTO PUBLISHERS (Publisher_ID, Publisher_Name, [Address], Phone, City, [State]) VALUES (202, 'Doubleday', '3456 Fiction Rd', '3456789012', 'Tale City', 'TC');
INSERT INTO PUBLISHERS (Publisher_ID, Publisher_Name, [Address], Phone, City, [State]) VALUES (203, 'Houghton Mifflin', '4567 Manuscript Blvd', '4567890123', 'Narrative Town', 'NT');
INSERT INTO PUBLISHERS (Publisher_ID, Publisher_Name, [Address], Phone, City, [State]) VALUES (204, 'Scholastic', '5678 Harrison Street', '5678901234', 'Brooklyn', 'NY');
INSERT INTO PUBLISHERS (Publisher_ID, Publisher_Name, [Address], Phone, City, [State]) VALUES (205, '‎Grand Central Publishing', '5679 Boulevard Street', '6525894571', 'Princeton', 'NJ');
SET IDENTITY_INSERT PUBLISHERS OFF;
--SECTION TABLE
SET IDENTITY_INSERT SECTION ON;
INSERT INTO SECTION (Section_ID, Section_Name, Section_Charge) VALUES (300, 'Children', 00.10);
INSERT INTO SECTION (Section_ID, Section_Name, Section_Charge) VALUES (301, 'Young Adults', 00.30);
INSERT INTO SECTION (Section_ID, Section_Name, Section_Charge) VALUES (302, 'Adult', 0.30);
INSERT INTO SECTION (Section_ID, Section_Name, Section_Charge) VALUES (303, 'Reference', 01.00);
SET IDENTITY_INSERT SECTION OFF;
--BOOK TABLE
SET IDENTITY_INSERT BOOK ON;
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1000, 200, 301, 'Eragon', 19.99, '2003-08-26', '9781417675524');
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1001, 201, 301, 'The Hobbit', 15.99, '1937-09-21', '9780007525508');
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1002, 201, 300, 'The Chronicles of Narnia', 24.99, '1950-10-16', '9780001857131');
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1003, 202, 302, 'The Shining', 18.99, '1977-01-28', '9780385121675');
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1004, 203, 301, 'The Giver', 12.99, '1993-04-26', '9780007141425');
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1005, 204, 300, 'Harry Potter and the Philosopher’s Stone', 20.99, '1997-06-26', '9780545582889');
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1006, 205, 302, 'Along Came a Spider', 19.99, '1993-12-01', '9780316072915');
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1007, 202, 302, 'Pride and Prejudice', 14.99, '1813-01-28', '9780140430721');
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1008, 202, 303, 'Syntactic Structures', 29.99, '1957-02-15', '9783110997682');
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1009, 201, 303, 'Daring Greatly', 21.99, '2012-09-11', '9781592407330');
INSERT INTO BOOK (Book_ID, Publisher_ID, Section_ID, Title, Price, Published_Date, ISBN) VALUES (1010, 205, 301, 'Maximum Ride: The Angel Experiment', 21.99, '2005-04-11', '9780316067959');
SET IDENTITY_INSERT BOOK OFF;
--AUTHOR_HAS_BOOK TABLE
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (1, 1000);
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (2, 1001);
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (6, 1002);
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (3, 1003);
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (4, 1004);
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (5, 1005);
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (7, 1006);
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (8, 1007);
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (9, 1008);
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (10, 1009);
INSERT INTO AUTHOR_HAS_BOOKS (Author_ID, Book_ID) VALUES (7, 1010);
--CATEGORY TABLE
SET IDENTITY_INSERT CATEGORY ON;
INSERT INTO CATEGORY (Category_ID, Category_Type) VALUES (401, 'Science Fiction');
INSERT INTO CATEGORY (Category_ID, Category_Type) VALUES (402, 'Fiction');
INSERT INTO CATEGORY (Category_ID, Category_Type) VALUES (403, 'Psychology');
INSERT INTO CATEGORY (Category_ID, Category_Type) VALUES (404, 'Non-Fiction');
INSERT INTO CATEGORY (Category_ID, Category_Type) VALUES (405, 'Fantasy');
INSERT INTO CATEGORY (Category_ID, Category_Type) VALUES (406, 'Linguistics');
INSERT INTO CATEGORY (Category_ID, Category_Type) VALUES (407, 'Classic');
SET IDENTITY_INSERT CATEGORY OFF;
--BOOK_HAS_CATEGORY TABLE
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1000, 402);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1000, 405);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1001, 402);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1001, 405);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1002, 402);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1002, 405);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1003, 402);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1003, 401);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1004, 402);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1004, 405);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1005, 405);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1006, 402);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1007, 402);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1007, 407);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1008, 406);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1008, 404);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1009, 404);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1009, 403);
INSERT INTO BOOK_HAS_CATEGORY (Category_ID, Book_ID) VALUES (1010, 401);
--BOOK_COPY TABLE
SET IDENTITY_INSERT BOOK_COPY ON;
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3000, 1000, 'New', 'CHECKED OUT');
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3001, 1001, 'Good', 'CHECKED OUT');
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3002, 1002, 'New', 'CHECKED OUT');
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3003, 1003, 'Fair', 'CHECKED OUT');
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3004, 1004, 'New', 'CHECKED OUT');
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3005, 1005, 'Good', 'CHECKED OUT');
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3006, 1006, 'New', 'CHECKED OUT');
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3007, 1007, 'Fair', 'CHECKED OUT');
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3008, 1008, 'New', 'CHECKED OUT');
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3009, 1009, 'Good', 'CHECKED OUT');
INSERT INTO BOOK_COPY (Copy_ID, Book_ID, Condition, Copy_Status) VALUES (3010, 1010, 'New', 'AVAILABLE');
SET IDENTITY_INSERT BOOK_COPY OFF;
--LIBRARY_CARD TABLE
SET IDENTITY_INSERT LIBRARY_CARD ON;
INSERT INTO LIBRARY_CARD (Card_ID, First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES (100, 'John', 'Doe', '123 Elm St', 'Sometown', 'NY', '12345', '1234567890', '1990-01-01', '2023-01-01', 0, '2024-01-01', '2023-01-01', 0.00);
INSERT INTO LIBRARY_CARD (Card_ID, First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES (101, 'Jane', 'Smith', '456 Oak St', 'Sometown', 'NY', '12345', '2345678901', '1985-02-02', '2023-01-02', 0, '2024-01-02', '2023-01-02', 11.00);
INSERT INTO LIBRARY_CARD (Card_ID, First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES (102, 'Emily', 'Johnson', '789 Pine St', 'Sometown', 'NY', '12345', '3456789012', '1995-03-03', '2023-01-03', 0, '2024-01-03', '2023-01-03', 0.00);
INSERT INTO LIBRARY_CARD (Card_ID, First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES (103, 'Michael', 'Brown', '101 Maple Ave', 'Sometown', 'NY', '12345', '4567890123', '1980-04-04', '2023-01-04', 0, '2024-01-04', '2023-01-04', 5.00);
INSERT INTO LIBRARY_CARD (Card_ID, First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES (104, 'Sarah', 'Davis', '202 Birch Rd', 'Sometown', 'NY', '12345', '5678901234', '1992-05-05', '2023-01-05', 0, '2024-01-05', '2023-01-05', 0.00);
INSERT INTO LIBRARY_CARD (Card_ID, First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES (105, 'William', 'Miller', '303 Cedar Ln', 'Sometown', 'NY', '12345', '6789012345', '1988-06-06', '2023-01-06', 0, '2024-01-06', '2023-01-06', 13.00);
INSERT INTO LIBRARY_CARD (Card_ID, First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES (106, 'Jessica', 'Wilson', '404 Spruce St', 'Sometown', 'NY', '12345', '7890123456', '1993-07-07', '2023-01-07', 0, '2024-01-07', '2023-01-07', 10.00);
INSERT INTO LIBRARY_CARD (Card_ID, First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES (107, 'David', 'Moore', '505 Elm Dr', 'Sometown', 'NY', '12345', '8901234567', '1975-08-08', '2023-01-08', 0, '2024-01-08', '2023-01-08', 3.00);
INSERT INTO LIBRARY_CARD (Card_ID, First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES (108, 'Ashley', 'Taylor', '606 Oak Ct', 'Sometown', 'NY', '12345', '9012345678', '1994-09-09', '2023-01-09', 0, '2024-01-09', '2023-01-09', 0.00);
INSERT INTO LIBRARY_CARD (Card_ID, First_Name, Last_Name, [Address], City, [State], Zip, Phone, Birthdate, Card_Issue_Date, Is_Expired, Expiration_Date, Last_Renewal_Date, Balance_Due) VALUES (109, 'Robert', 'Anderson', '707 Pine Blvd', 'Sometown', 'NY', '12345', '0123456789', '1982-10-10', '2023-01-10', 0, '2024-01-10', '2023-01-10', 0.00);
SET IDENTITY_INSERT LIBRARY_CARD OFF;
--BOOK_BORROWED TABLE
SET IDENTITY_INSERT BOOK_BORROWED ON;
INSERT INTO BOOK_BORROWED (Borrowed_ID, Card_ID, Copy_ID, Borrowed_Date, Due_Date, Returned_Date, Borrowed_Status) VALUES (1, 100, 3000, '2023-12-04', '2023-12-18', NULL, 'CHECKED OUT');
INSERT INTO BOOK_BORROWED (Borrowed_ID, Card_ID, Copy_ID, Borrowed_Date, Due_Date, Returned_Date, Borrowed_Status) VALUES (2, 101, 3001, '2023-12-04', '2023-12-18', NULL, 'CHECKED OUT');
INSERT INTO BOOK_BORROWED (Borrowed_ID, Card_ID, Copy_ID, Borrowed_Date, Due_Date, Returned_Date, Borrowed_Status) VALUES (3, 102, 3002, '2023-12-04', '2023-12-18', NULL, 'CHECKED OUT');
INSERT INTO BOOK_BORROWED (Borrowed_ID, Card_ID, Copy_ID, Borrowed_Date, Due_Date, Returned_Date, Borrowed_Status) VALUES (4, 103, 3003, '2023-12-04', '2023-12-18', NULL, 'CHECKED OUT');
INSERT INTO BOOK_BORROWED (Borrowed_ID, Card_ID, Copy_ID, Borrowed_Date, Due_Date, Returned_Date, Borrowed_Status) VALUES (5, 104, 3004, '2023-12-04', '2023-12-18', NULL, 'CHECKED OUT');
INSERT INTO BOOK_BORROWED (Borrowed_ID, Card_ID, Copy_ID, Borrowed_Date, Due_Date, Returned_Date, Borrowed_Status) VALUES (6, 105, 3005, '2023-12-04', '2023-12-18', NULL, 'CHECKED OUT');
INSERT INTO BOOK_BORROWED (Borrowed_ID, Card_ID, Copy_ID, Borrowed_Date, Due_Date, Returned_Date, Borrowed_Status) VALUES (7, 106, 3006, '2023-12-04', '2023-12-18', NULL, 'CHECKED OUT');
INSERT INTO BOOK_BORROWED (Borrowed_ID, Card_ID, Copy_ID, Borrowed_Date, Due_Date, Returned_Date, Borrowed_Status) VALUES (8, 107, 3007, '2023-12-04', '2023-12-18', NULL, 'CHECKED OUT');
INSERT INTO BOOK_BORROWED (Borrowed_ID, Card_ID, Copy_ID, Borrowed_Date, Due_Date, Returned_Date, Borrowed_Status) VALUES (9, 108, 3008, '2023-12-04', '2023-12-18', NULL, 'CHECKED OUT');
INSERT INTO BOOK_BORROWED (Borrowed_ID, Card_ID, Copy_ID, Borrowed_Date, Due_Date, Returned_Date, Borrowed_Status) VALUES (10, 109, 3009, '2023-12-04', '2023-12-18', NULL, 'CHECKED OUT');
SET IDENTITY_INSERT BOOK_BORROWED OFF;


/* ADD FOREIGN KEY CONSTRAINTS */

ALTER TABLE BOOK WITH NOCHECK ADD CONSTRAINT FK_BOOK_PUBLISHER_ID FOREIGN KEY(Publisher_ID)
REFERENCES PUBLISHERS (Publisher_ID)
GO
ALTER TABLE BOOK WITH NOCHECK ADD CONSTRAINT FK_BOOK_SECTION_ID FOREIGN KEY(Section_ID)
REFERENCES SECTION (Section_ID)
GO
ALTER TABLE AUTHOR_HAS_BOOKS WITH NOCHECK ADD CONSTRAINT FK_AUTHOR_HAS_BOOKS1 FOREIGN KEY(Author_ID)
REFERENCES AUTHOR (Author_ID)
GO
ALTER TABLE AUTHOR_HAS_BOOKS WITH NOCHECK ADD CONSTRAINT FK_AUTHOR_HAS_BOOKS2 FOREIGN KEY(Book_ID)
REFERENCES BOOK (Book_ID)
GO
ALTER TABLE BOOK_HAS_CATEGORY WITH NOCHECK ADD CONSTRAINT FK_BOOK_HAS_CATEG1 FOREIGN KEY(Category_ID)
REFERENCES CATEGORY (Category_ID)
GO
ALTER TABLE BOOK_HAS_CATEGORY WITH NOCHECK ADD CONSTRAINT FK_BOOK_HAS_CATEG2 FOREIGN KEY(Book_ID)
REFERENCES BOOK (Book_ID)
GO
ALTER TABLE BOOK_COPY WITH NOCHECK ADD CONSTRAINT FK_BOOKCOPY_BOOK_ID FOREIGN KEY(Book_ID)
REFERENCES BOOK (Book_ID)
GO
ALTER TABLE BOOK_BORROWED WITH NOCHECK ADD CONSTRAINT FK_BORROWED_BOOK_ID FOREIGN KEY(Copy_ID)
REFERENCES BOOK_COPY (Copy_ID)
GO
ALTER TABLE BOOK_BORROWED WITH NOCHECK ADD CONSTRAINT FK_BORROWED_CARD_ID FOREIGN KEY(Card_ID)
REFERENCES LIBRARY_CARD (Card_ID)
GO