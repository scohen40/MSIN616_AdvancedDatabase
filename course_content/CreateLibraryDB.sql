------------------------------------------>start of file
 

if not exists(select * from sys.databases where name = 'LibraryF20')
    create database [LibraryF20]
GO

USE [LibraryF20]
 /*** First remove all the tables if they exist ***/

 	IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_JNC_AuthorBook')
	   DROP TABLE [dbo].[LBR_JNC_AuthorBook]
	GO

	IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_Author')
	   DROP TABLE [dbo].[LBR_Author]
	GO

    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_Book')
	   DROP TABLE [dbo].[LBR_Book]
	GO

   IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_Location')
	   DROP TABLE [dbo].[LBR_Location]
	GO

    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_Publisher')
	   DROP TABLE [dbo].[LBR_Publisher]
	GO

    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_BookClassification')
	   DROP TABLE [dbo].[LBR_BookClassification]
	GO

    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_BkCategory')
	   DROP TABLE [dbo].LBR_BkCategory
	GO

    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_BkGenre')
	   DROP TABLE [dbo].LBR_BkGenre
	GO

    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_BkType')
	   DROP TABLE [dbo].LBR_BkType
	GO

	IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_BkField')
	   DROP TABLE [dbo].LBR_BkField
	GO

    IF EXISTS(SELECT * FROM sys.tables WHERE type = 'U' AND name = 'LBR_BkSubfield')
	   DROP TABLE [dbo].LBR_BkSubfield
	GO

	IF EXISTS(SELECT * FROM sys.all_objects WHERE type = 'FN' AND  name = 'fnEncodeBookClassification')
	   DROP FUNCTION [dbo].[fnEncodeBookClassification]
	GO




USE [LibraryF20];
GO



	CREATE FUNCTION [dbo].[fnEncodeBookClassification]
	(@categ as int,
	 @genre as int,
	 @type_ as int,
	 @field as int,
	 @subfi as int)
	RETURNS int

	AS 
		BEGIN
			if  @categ is null 
				set @categ = 0
			if  @genre is null
				set @genre = 0
			if  @type_ is null
				set @type_ = 0
			if  @field is null
				set @field = 0
			if  @subfi is null
				set @subfi = 0
	
			RETURN 10000*@categ + 1000*@genre + 100*@type_ + 10*@field + @subfi
		END;

GO






 /*** Now, recreate all tables  ***/

	/* https://docs.microsoft.com/en-us/sql/t-sql/statements/set-quoted-identifier-transact-sql?view=sql-server-2017 */
	SET QUOTED_IDENTIFIER ON
	GO

	/* https://docs.microsoft.com/en-us/sql/t-sql/statements/set-ansi-padding-transact-sql?view=sql-server-2017 */
	SET ANSI_PADDING ON
	GO

/****** Object:  Table [dbo].[LBR_Author] ******/

	CREATE TABLE [dbo].[LBR_Author]
	(
		[Author_ID]			[int]		  IDENTITY(1,1) NOT NULL,
		[LastName]			[varchar](50) NOT NULL,
		[FirstName]			[varchar](50) NULL,
		[MiddleInitials]	[varchar](10) NULL,
		[Suffix]			[varchar](10) NULL,
		[Title]				[varchar](10) NULL,
		CONSTRAINT [PK_LBR_Author] PRIMARY KEY CLUSTERED ( [Author_ID] ASC ),
		CONSTRAINT [UK_LBR_Author] UNIQUE ([LastName],[FirstName],[MiddleInitials],[Suffix],[Title])  
    ) 
	GO
------------------------------------------------------------------------------


/****** Object:  Table [dbo].[LBR_Location] ******/

	CREATE TABLE [dbo].[LBR_Location]
	(
		[Location_ID]	[int]			IDENTITY(1,1) NOT NULL,
		[Location]		[varchar](50)	NOT NULL,
		[Sublocation]	[varchar](50)	NULL,
		CONSTRAINT [PK_LBR_Location] PRIMARY KEY CLUSTERED ( [Location_ID] ASC )
	)  
	GO
------------------------------------------------------------------------------


/****** Object:  Table [dbo].[LBR_Publisher] ******/

	CREATE TABLE [dbo].[LBR_Publisher]
	(
		[Publisher_ID]	[int]			IDENTITY(1,1) NOT NULL,
		[Name]			[varchar](100)	NOT NULL,
		[Headquorters]	[varchar](50)	NULL,
		CONSTRAINT [PK_LBR_Publisher] PRIMARY KEY CLUSTERED ( [Publisher_ID] ASC ) 
	)
	GO
------------------------------------------------------------------------------


/****** Object:  Table [dbo].[LBR_BkCategory] : Fictin, Nonfiction ******/

	CREATE TABLE [dbo].[LBR_BkCategory]
	(
		[Category_ID]	[int]			IDENTITY(1,1) NOT NULL,
		[Category]		[varchar](20)	NOT NULL,
		[Description]	[varchar](50)	NULL,
		CONSTRAINT [PK_LBR_Category] PRIMARY KEY CLUSTERED ( [Category_ID] ASC ) 
	)
	GO
------------------------------------------------------------------------------


/****** Object:  Table [dbo].[LBR_BkGenre] : ScienceFiction, Satire, Mystery, etc. ******/

	CREATE TABLE [dbo].[LBR_BkGenre]
	(
		[Genre_ID]		[int]			IDENTITY(1,1) NOT NULL,
		[Genre]			[varchar](20)	NOT NULL,
		[Description]	[varchar](50)	NULL,
		CONSTRAINT [PK_LBR_BkGenre] PRIMARY KEY CLUSTERED ( [Genre_ID] ASC ) 
	)
	GO
------------------------------------------------------------------------------


/****** Object:  Table [dbo].[LBR_BkType] Novel, Play, Poetry, etc. ******/

	CREATE TABLE [dbo].[LBR_BkType]
	(
		[Type_ID]		[int]			IDENTITY(1,1) NOT NULL,
		[Type]			[varchar](20)	NOT NULL,
		[Description]	[varchar](50)	NULL,
		CONSTRAINT [PK_LBR_BkType] PRIMARY KEY CLUSTERED ( [Type_ID] ASC ) 
	)
	GO
------------------------------------------------------------------------------


/****** Object:  Table [dbo].[LBR_BkField] ******/

	CREATE TABLE [dbo].[LBR_BkField]
	(
		[Field_ID]		[int]			IDENTITY(1,1) NOT NULL,
		[Field]			[varchar](20)	NOT NULL,
		[Description]	[varchar](50)	NULL,
		CONSTRAINT [PK_LBR_BkField] PRIMARY KEY CLUSTERED ( [Field_ID] ASC ) 
	)
	GO
------------------------------------------------------------------------------


/****** Object:  Table [dbo].[LBR_BkSubField] ******/

	CREATE TABLE [dbo].[LBR_BkSubField]
	(
		[Subfield_ID]	[int]			IDENTITY(1,1) NOT NULL,
		[Subfield]		[varchar](20)	NOT NULL,
		[Description]	[varchar](50)	NULL,
		CONSTRAINT [PK_LBR_BkSubFieldy] PRIMARY KEY CLUSTERED ( [Subfield_ID] ASC ) 
	)
	GO
------------------------------------------------------------------------------


/****** Object:  Table [dbo].[LBR_BookClassification] ******/

	CREATE TABLE [dbo].[LBR_BookClassification]
	(
		[Classification_ID]	[int]			IDENTITY(1,1) NOT NULL,
		[Category_ID]		[int] 	 NULL	FOREIGN KEY REFERENCES [LBR_BkCategory](Category_ID),
		[Genre_ID]			[int] 	 NULL	FOREIGN KEY REFERENCES [LBR_BkGenre](Genre_ID),
		[Type_ID]			[int] 	 NULL	FOREIGN KEY REFERENCES [LBR_BkType](Type_ID),
		[Field_ID]			[int] 	 NULL	FOREIGN KEY REFERENCES [LBR_BkField](Field_ID),
		[SubField_ID]		[int]    NULL	FOREIGN KEY REFERENCES [LBR_BkSubfield](Subfield_ID),
		[bkCode]  AS ([dbo].[fnEncodeBookClassification]([category_ID],[Genre_ID],[Type_ID],[Field_ID],[Subfield_ID])),
		CONSTRAINT [PK_LBR_BookClassification] PRIMARY KEY CLUSTERED ( [Classification_ID] ASC ) 
	)
	GO



------------------------------------------------------------------------------


/****** Object:  Table [dbo].[LBR_Book] ******/

	CREATE TABLE [dbo].[LBR_Book]
	(
		[Book_ID]			[int]			IDENTITY(1,1) NOT NULL,
		[Title]				[varchar](100)	NOT NULL,
		[ISBN]				[varchar](20)	NOT NULL,
		[Edition]			[varchar](20)	NULL,
		[Year]				[int]			NULL,
		[Rating]			[int]			NULL,
		[Notes]				[varchar](2000)	NULL,
		[Classification_ID]	[int]			NULL	FOREIGN KEY REFERENCES [LBR_BookClassification](Classification_ID),
		[Publisher_ID]		[int]			NULL	FOREIGN KEY REFERENCES [LBR_Publisher](Publisher_ID),
		[Location_ID]		[int]			NULL	FOREIGN KEY REFERENCES [LBR_Location](Location_ID),
		CONSTRAINT [PK_LBR_Book] PRIMARY KEY CLUSTERED ( [Book_ID] ASC ),
	    CONSTRAINT [UK_ISBN] UNIQUE(ISBN)  
	)
	GO
------------------------------------------------------------------------------


/****** Object:  Table [dbo].[LBR_JNC_AuthorBook] ******/
 
	CREATE TABLE [dbo].[LBR_JNC_AuthorBook]
	(
		[Author_ID]		[int] NOT NULL	FOREIGN KEY REFERENCES [LBR_Author](Author_ID),
		[Book_ID]		[int] NOT NULL	FOREIGN KEY REFERENCES [LBR_Book](Book_ID),
		--[AuthorBook_ID] [int] IDENTITY(1,1) NOT NULL,
		CONSTRAINT [PK_LBR_JNCT_AuthorBook] PRIMARY KEY CLUSTERED ( [Author_ID], [Book_ID]  ASC ),
	    CONSTRAINT [UK_AUthorID_BookID] UNIQUE(Author_ID, Book_ID)  
	)
	GO	
------------------------------------------> end of file