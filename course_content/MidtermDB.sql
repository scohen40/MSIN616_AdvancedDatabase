
IF NOT EXISTS(select * from sys.databases where name = 'MidtermS21')
	CREATE Database MidtermS21
GO
---------------------------------------------------
USE MidtermS21
GO
--------------------------------------------------

 /*** First remove all the tables if they exist ***/

 	IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'JNC_BookWriter')
	   DROP TABLE [dbo].[JNC_BookWriter]
	GO

    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'Sales')
	   DROP TABLE [dbo].[Sales]
	GO

	IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'Inventory')
	   DROP TABLE [dbo].[Inventory]
	GO

    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'Book')
	   DROP TABLE [dbo].[Book]
	GO

   IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'Location')
	   DROP TABLE [dbo].[Location]
	GO

    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'Publisher')
	   DROP TABLE [dbo].[Publisher]
	GO

  
    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'Writer')
	   DROP TABLE [dbo].[Writer]
	GO




 /*** Now, recreate all tables  ***/
--1
/****** Object:  Table [dbo].[Publisher]  ******/

CREATE TABLE [dbo].[Publisher]
(
	[Publisher_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name]         [varchar](50)       NOT NULL,
	[City]         [varchar](30)           NULL,
    CONSTRAINT [PK_Publisher] PRIMARY KEY CLUSTERED   
	( 
	    [Publisher_ID] ASC 
	) ON [PRIMARY],
    CONSTRAINT [IX_Publisher] UNIQUE NONCLUSTERED 
	( 
	    [Name] ASC 
	) ON [PRIMARY]
) ON [PRIMARY]

GO
--------------------------------------------------

--2
/****** Object:  Table [dbo].[Writer]  ******/

CREATE TABLE [dbo].[Writer]
(
	[Writer_ID]      [int] IDENTITY(1,1) NOT NULL,
	[FirstName]      [varchar](30)       NOT NULL,
	[LastName]       [varchar](30)       NOT NULL,
	[MiddleInitials] [varchar](10)           NULL,
    CONSTRAINT [PK_Writer_ID] PRIMARY KEY CLUSTERED 
	(	
	    [Writer_ID] ASC 
	) ON [PRIMARY],
    CONSTRAINT [IX_LIT_Writer] UNIQUE NONCLUSTERED  
	(	
	    [FirstName] ASC, 
		[MiddleInitials] ASC, 
		[LastName] ASC 
	) ON [PRIMARY]
) ON [PRIMARY]

GO
--------------------------------------------------

--3
/****** Object:  Table [dbo].[Book] ******/
 
CREATE TABLE [dbo].[Book]
(
	[Book_ID]      [int] IDENTITY(1,1) NOT NULL,
	[Title]        [varchar](100)      NOT NULL,
	[ISBN]         [varchar](20)       NOT NULL,
	[Year]         [int]                   NULL,
	[Publisher_ID] [int]                   NULL,
    CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED   
	(	
	     [Book_ID] ASC 
	)  ON [PRIMARY],
    CONSTRAINT [IX_LIT_Book] UNIQUE NONCLUSTERED 
	(	
	    [ISBN] ASC 
	) ON [PRIMARY],
    CONSTRAINT [FK_Book_Publisher] FOREIGN KEY
	(
	    [Publisher_ID]
	) REFERENCES [dbo].[Publisher] ([Publisher_ID])
) ON [PRIMARY]

GO
--------------------------------------------------


--4
/****** Object:  Table [dbo].[Location]  ******/
 
CREATE TABLE [dbo].[Location]
(
	[Location_ID] [int] IDENTITY(1,1) NOT NULL,
	[City]      [varchar](30)         NOT NULL,
	[State]     [varchar](30)         NOT NULL,
	[Warehouse] [int]                 NOT NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
	( 
	    [Location_ID] ASC 
	) ON [PRIMARY],
    CONSTRAINT [IX_Location] UNIQUE NONCLUSTERED 
	( 
	    [City] ASC, 
		[State] ASC, 
		[Warehouse] ASC
    )  ON [PRIMARY]
) ON [PRIMARY]

GO
--------------------------------------------------


--5
/****** Object:  Table [dbo].[Inventory] ******/
CREATE TABLE [dbo].[Inventory]
(
	[Inventory_ID]   [int] IDENTITY(1,1) NOT NULL,
	[Item_ID]        [int]               NOT NULL,
	[Location_ID]    [int]               NOT NULL,
	[WholesalePrice] [money]             NOT NULL,
	[RetailPrice]    [money]             NOT NULL,
	[Quantity]       [int]                   NULL,
    CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
	( 	
	    [Inventory_ID] ASC 
	) ON [PRIMARY],
    CONSTRAINT [IX_Inventory] UNIQUE NONCLUSTERED 
	( 
	    [Item_ID] ASC, 
	    [Location_ID] ASC 
	) ON [PRIMARY],
    CONSTRAINT [FK_Inventory_Book] FOREIGN KEY
	(
	    [Item_ID]
	) REFERENCES [dbo].[Book] ([Book_ID]),
    CONSTRAINT [FK_Inventory_Location] FOREIGN KEY
	(
	    [Location_ID]
	) REFERENCES [dbo].[Location] ([Location_ID])
) ON [PRIMARY]

GO
--------------------------------------------------


--6
/****** Object:  Table [dbo].[Sales] ******/
CREATE TABLE [dbo].[Sales]
(
	[Sales_ID]       [int] IDENTITY(1,1) NOT NULL,
	[Item_ID]        [int]               NOT NULL,
	[Location_ID]    [int]               NOT NULL,
	[SalesDate]      [date] DEFAULT     getdate(),
	[Quantity]       [int]               NOT NULL,
	[Price]          [money]             NOT NULL,
    CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED 
	( 	
	    [Sales_ID] ASC 
	) ON [PRIMARY],
    CONSTRAINT [FK_Sales_Book] FOREIGN KEY
	(
	    [Item_ID]
	) REFERENCES [dbo].[Book] ([Book_ID]),
    CONSTRAINT [FK_Sales_Location] FOREIGN KEY
	(
	    [Location_ID]
	) REFERENCES [dbo].[Location] ([Location_ID])
) ON [PRIMARY]

GO

--7
/****** Object:  Table [dbo].[JNC_BookWriter] *****/

CREATE TABLE [dbo].[JNC_BookWriter]
(
	[Book_ID]   [int] NOT NULL,
	[Writer_ID] [int] NOT NULL,
    CONSTRAINT [IX_JNC_BookWriter] UNIQUE NONCLUSTERED 
	(
	    [Book_ID] ASC,
	    [Writer_ID] ASC
    )  ON [PRIMARY],
	CONSTRAINT [FK_JNC_BookWriter_Book] FOREIGN KEY
	(
	    [Book_ID]
	) REFERENCES [dbo].[Book] ([Book_ID]),
	CONSTRAINT [FK_JNC_BookWriter_Writer_ID] FOREIGN KEY
	(
	     [Writer_ID]
	) REFERENCES [dbo].[Writer] ([Writer_ID])
) ON [PRIMARY]

GO


--------------------------------------------------------------
--
--     Populate tables Part 1
--
--------------------------------------------------------------


-- empty out all data
DECLARE @Howmany AS INT
SELECT @Howmany = COUNT(*) FROM JNC_BookWriter
IF @Howmany > 0 
	DELETE FROM JNC_BookWriter;

SELECT @Howmany = COUNT(*) FROM Sales
IF @Howmany > 0 
	DELETE FROM Sales;

SELECT @Howmany = COUNT(*) FROM Inventory
IF @Howmany > 0 
	DELETE FROM Inventory;

SELECT @Howmany = COUNT(*) FROM Book
IF @Howmany > 0 
	DELETE FROM Book;

SELECT @Howmany = COUNT(*) FROM Writer
	DELETE FROM Writer;

SELECT @Howmany = COUNT(*) FROM Publisher
IF @Howmany > 0 
	DELETE FROM Publisher;  

SELECT @Howmany = COUNT(*) FROM Location
IF @Howmany > 0 
	DELETE FROM Location;



----------------------------------

--Publisher
INSERT  INTO Publisher (Name, City) Values('Apricot','Amsterdam' )
INSERT  INTO Publisher (Name, City) Values('Books4U','Boston' )
INSERT  INTO Publisher (Name, City) Values('Literary','London' )
INSERT  INTO Publisher (Name, City) Values('Springer','San Francisco' )

--Writer
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Abigail','A', 'Adams')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Brigitte',NULL,'Bardot')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Claudia','C', 'Cardinale')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Chevy',NULL,'Chase')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Doris','D.', 'Day')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Barbara',NULL,'Bush')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Jane',NULL,'Jane')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Jane','J.', 'Jane')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Kelly',NULL,'Kelly')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Kitty',NULL,'Kat')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Lois','L.', 'Lane')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Peppermint',NULL,'Patty')
INSERT  INTO Writer (FirstName, MiddleInitials, LastName) Values('Simone',NULL,'Signoret')


--Book
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('123-45-2-349', 'Introduction to SQL', 1999,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('123456789', 'Introduction to APL', 1993,2)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('123321456', 'Introduction to Java', 1993,3)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('234567890', 'Advanced Networking', 1995,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('987654321', 'Hard Concepts Made Easy', 1997,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('8765432109', 'Easy Concepts Made Hard', 1999,2)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('765432109', 'So So Stories', 2001,3)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('654321987', 'A very good Book', 2003,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('999777555', 'Odd Title', 2005,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('102983475', 'Imagine', 2007,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('019283746', 'Let it Be', 2009,2)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('88877766', 'Maybe C', 2011,2)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('888777666555', 'C Now', 2013,3)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('565643432', 'Solutions in C', 2015,NULL)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('098980809', 'Can You C', 2017,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('7777666554', 'From C to Java', 2017,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('1-1-1-2-22', 'Python', 2017,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('222222222', 'Monty Python', 2017,2)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('232323233', 'Spam Python', 2017,3)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('333333333', 'Python Is No C', 2020,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('444444444', 'You Will See Python', 2019,1)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('454544444', 'Now U C It', 2019,4)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('454534444', 'A Smarter Way to Learn C', 2020,4)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('454524444', 'A Silly Way to Learn Java', 2017,4)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('454514444', 'This Book''s For You', 2016,4)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('454504444', 'C Sharper', 2015,4)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('454594444', 'C Sharpest', 2019,4)
INSERT INTO Book (ISBN, Title, Year, Publisher_ID) Values('454590444', 'From C to Shining C', 2019,4)


--Location
INSERT  INTO Location (City, State, Warehouse) Values('New York','New York', 1)
INSERT  INTO Location (City, State, Warehouse) Values('New York','New York', 2)
INSERT  INTO Location (City, State, Warehouse) Values('Los Angeles','California', 1)
INSERT  INTO Location (City, State, Warehouse) Values('Dallas','Texas', 3)


--------------------------------------------------------------
--
--     Populate tables Part 2
--
--------------------------------------------------------------

--Jnc
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (2,1)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (3,1)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (3,2)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (4,3)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (4,4)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (4,5)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (5,6)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (6,7)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (7,8)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (7,1)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (8,9)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (9,9)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (9,8)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (10,2)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (11,2)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (12,7)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (12,8)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (12,9)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (13,2)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (14,3)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (15,2)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (16,7)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (17,9)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (18,2)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (19,3)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (20,2)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (21,7)

Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (22,11)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (23,11)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (24,12)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (25,12)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (26,12)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (27,13)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (28,13)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (22,13)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (23,13)
Insert INTO JNC_BookWriter (Book_ID, Writer_ID) Values (24,13)




--Inventory
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(1, 1,15.5, 30.5,  10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(1, 2,16,   31,     5)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(2, 1,20.25,35.25, 10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(3, 1,20,   35,     1)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(4, 1,22,   37,     2)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(4, 2,22,   37,     3)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(5, 1,23,   40,     0)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(6, 2,33,   48,    10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(7, 3,30.95,45.95, 20)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(8, 3,30,   45,    10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(9, 4,10.99,25.99,  9)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(11,4,14,   34,     8)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(12,1,15,   45,     7)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(13,2,16,   41,     6)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(14,3,15,   35,    10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(15,4,17.5, 35,     9)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(16,1,22,   44,     8)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(18,1,22,   44,     8)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(20,1,22,   33,     8)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(20,2,22,   33,     8)

INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(21,2,22,   33,    10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(22,2,23,   33,    10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(23,2,24,   33,    10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(24,2,25,   33,    10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(25,2,22,   33,    10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(26,2,22,   33,    10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(27,2,22,   33,    10)
INSERT INTO Inventory (Item_ID, Location_ID, WholesalePrice, RetailPrice, Quantity) Values(28,2,22,   33,    10)





INSERT INto Sales (	[Item_ID], [Location_ID], [SalesDate], [Quantity],  [Price])           
	VALUES 
				  (1,		   1,			  '2020-10-10',	1,	        30.0),
				  (1,		   1,			  '2020-10-11',	1,	        30.0),
				  (1,		   1,			  '2020-10-12',	1,	        33.0),
				  (2,		   1,			  '2020-10-10',	3,	        30.0),
				  (2,		   1,			  '2020-10-10',	2,	        31.0),
				  (2,		   1,			  '2020-10-11',	1,	        33.0),
				  (4,		   2,			  '2020-10-10',	2,	        30.0),
				  (4,		   2,			  '2020-10-11',	2,	        31.0),
				  (4,		   2,			  '2020-10-12',	2,	        32.0),
				  (4,		   2,			  '2020-10-13',	2,	        33.0),
				  (9,		   4,			  '2020-10-10',	1,	        20.0),
				  (9,		   4,			  '2020-10-11',	2,	        30.0),
				  (9,		   4,			  '2020-10-12',	3,	        40.0),
				  (9,		   4,			  '2020-10-13',	4,	        50.0) 

			     ,(11,		   4,			  '2020-10-13',	4,	        50.0) 
			     ,(12,		   4,			  '2020-10-14',	4,	        50.0) 
			     ,(13,		   4,			  '2020-10-15',	4,	        50.0) 
			     ,(14,		   4,			  '2020-10-16',	4,	        50.0) 
			     ,(20,		   4,			  '2020-10-13',	1,	        30.0) 
			     ,(21,		   4,			  '2020-10-13',	1,	        30.0) 
			     ,(22,		   4,			  '2020-10-13',	1,	        30.0) 

--------------------------------------------------> end of file
