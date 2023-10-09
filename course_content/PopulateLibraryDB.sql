---------------------------> begin file

USE LibraryF20
GO
------------------------
-- empty out all data --
------------------------
DECLARE @Howmany AS INT

SELECT @Howmany = COUNT(*) FROM LBR_JNC_AuthorBook
IF @Howmany > 0 
	DELETE FROM LBR_JNC_AuthorBook;

SELECT @Howmany = COUNT(*) FROM LBR_Book
IF @Howmany > 0 
	DELETE FROM LBR_Book;

SELECT @Howmany = COUNT(*) FROM LBR_BookClassification
IF @Howmany > 0 
	DELETE FROM LBR_BookClassification;

SELECT @Howmany = COUNT(*) FROM LBR_Author
IF @Howmany > 0 
	DELETE FROM LBR_Author;

SELECT @Howmany = COUNT(*) FROM LBR_Location
	DELETE FROM LBR_Location;

SELECT @Howmany = COUNT(*) FROM LBR_Publisher
IF @Howmany > 0 
	DELETE FROM LBR_Publisher;  

SELECT @Howmany = COUNT(*) FROM LBR_BkCategory
IF @Howmany > 0 
	DELETE FROM LBR_BkCategory;

SELECT @Howmany = COUNT(*) FROM LBR_BkField
IF @Howmany > 0 
	DELETE FROM LBR_BkField;

SELECT @Howmany = COUNT(*) FROM LBR_BkGenre
IF @Howmany > 0 
	DELETE FROM LBR_BkGenre;

SELECT @Howmany = COUNT(*) FROM LBR_BkSubfield
IF @Howmany > 0 
	DELETE FROM LBR_BkSubfield;

SELECT @Howmany = COUNT(*) FROM LBR_BkType
IF @Howmany > 0 
	DELETE FROM LBR_BkType;
GO
------------------------
-- populate LBR_Author
------------------------
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Frederick','P.',		'Brooks',		'Jr.',NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Tom',      NULL,		'DeMarco',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Timothy',  NULL,		'Lister',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Jon',      NULL,		'Bentley',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Donald',   'E.',		'Knuth',		NULL,'Dr.')
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Sikha',    NULL,		'Bagui',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Richar',   NULL,		'Earp',			NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Philip',   'J.',		'Pratt',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Kevin',    NULL,		'Thompson',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Deanna',   NULL,		'Dicken',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Ryan',     'K.',		'Stephens',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Ronald',   'R.',		'Plew',			NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Bryan',    NULL,		'Morgan',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Jeff',     NULL,		'Perkins',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Dejan',	  NULL,		'Sunderic',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Ken',	  NULL,		'Getz',			NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Mike',	  NULL,		'Gilbert',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Ken',	  NULL,		'Pugh',			NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Kent',	  NULL,		'Beck',			NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('james',	  NULL,		'Snell',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Doug',	  NULL,		'Tidwell',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Pavel',	  NULL,		'Kulchenko',	NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Ethan',	  NULL,		'Cerami',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Eric',	  NULL,		'Newcomer',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Wei-Meng', NULL,		'Lee',			NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Joli',	  NULL,		'Ballew',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('David',	  NULL,		'Pogue',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Bill',	  NULL,		'Karwin',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('John',	  NULL,		'Viescas',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Michael',  'J.',		'Hernandez',	NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Brian',	  NULL,		'Kernighan',	NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('P.J.',	  NULL,		'Plauger',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Rob',	  NULL,		'Pike',			NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Dennis',   'M.',		'Ritchie',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Edsger',   'W.',		'Dijkstra',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Mario',	  NULL,		'Livio',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Michael',  NULL,		'Trayn',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Friedrich',NULL,		'Durenmatt',	NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Roger',	  NULL,		'Penrose',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Douglas',  'R.',		'Hofstadter',	NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Daniel',   'C.',		'Dennett',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Stan',	  NULL,		'Kelly-Bootle',	NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Eric',	  's.',		'Raymond',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Andrew',	  NULL,		'Davison',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Martin',	  NULL,		'Gardner',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Milton',	  NULL,		'Friedman',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Rose',	  NULL,		'Friedman',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Thomas',	  NULL,		'Sowell',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Friedrich','A.',		'Hayek',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Ludwig',	  NULL,		'von Mises',	NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Hanry',	  NULL,		'Hazlitt',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Richard',  NULL,		'Adams',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Ernest',	  NULL,		'Hemingway',	NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Leo',	  NULL,		'Tolstoy',		NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Herman',	  NULL,		'Wouk',			NULL,NULL)
INSERT  INTO LBR_Author  (FirstName, MiddleInitials, LastName, Suffix, Title) Values ('Charles',  'A. R.',	'Hoare',		NULL,'Sir')


------------------------
-- populate LBR_Bk* tables
------------------------
INSERT INTO LBR_BkCategory	(Category)	Values ('Fiction'),('NonFiction')
INSERT INTO LBR_BkGenre		(Genre)		Values ('Polemics'),('Satire'),('Drama'),('Allegory')
INSERT INTO LBR_BkType		(Type)		Values ('Textbook'),('Reference'),('Play'),('Novel'),('Collection of Essays')
INSERT INTO LBR_BkField		(Field)		Values ('Computer Science'),('Historical Fiction'),('Cognition'),('Mathematics'),('Economics'),('Political Science')
INSERT INTO LBR_BkSubField  (SubField)  Values ('Software Engineering'),('Programming'),('SQL'),('VBA'),('Web Development'),('Recreational'),('Microsoft Windows'),('Humor')


------------------------
-- populate LBR_BookClassification
------------------------
INSERT INTO LBR_BookClassification (Category_ID,Genre_ID,Type_ID,Field_ID,SubField_ID) VALUES
(1,2,NULL,1,1),
(1,3,3,2,NULL),
(1,3,3,NULL,NULL),
(1,4,4,NULL,NULL),
(1,NULL,4,2,NULL),
(2,1,NULL,1,1),
(2,NULL,1,1,2),
(2,NULL,1,1,3),
(2,NULL,2,1,4),
(2,NULL,2,1,7),
(2,NULL,5,1,2),
(2,NULL,5,1,NULL),
(2,NULL,5,3,NULL),
(2,NULL,5,6,NULL),
(2,NULL,NULL,1,1),
(2,NULL,NULL,1,2),
(2,NULL,NULL,1,5),
(2,NULL,NULL,1,6),
(2,NULL,NULL,1,8),
(2,NULL,NULL,1,NULL),
(2,NULL,NULL,4,6),
(2,NULL,NULL,5,NULL),
(2,NULL,NULL,6,NULL),
(2,NULL,NULL,NULL,NULL) 



------------------------
-- populate LBR_Publisher
------------------------
INSERT INTO LBR_Publisher (Name) Values 
('Addison Wesley'),
('Anchor Books'),
('Apress'),
('Avon'),
('Basic Books'),
('Cambridge University Press'),
('CSLI'),
('Currency'),
('Dorset House'),
('Grove Press'),
('Harcourt Brace and Company'),
('Jones and Bartlett'),
('Liberty Fund Inc'),
('Little, Borwn and Company'),
('Ludwig von Mises Institute'),
('McGraw-Hill'),
('MIT Press'),
('O''Reilly'),
('Oxford Univeristy press'),
('Paraglyph Press'),
('Penguin Books'),
('Premier Press'),
('Prentice Hall'),
('SAMS Publishing'),
('Scribner'),
('Simon and Schuster'),
('Springer'),
('Sybex'),
('The pragmatic Bookshelf'),
('Thomson Course Technology'),
('University of Chicago Press'),
('Vintage'),
('W H Freeman & Co'),
('William Morrow & Co') 
GO


------------------------
-- populate LBR_Location
------------------------
INSERT INTO LBR_Location(Location) VALUES('RecRoom'),('Office E'), ('Office W')
GO


------------------------
-- populate LBR_Book
------------------------
INSERT INTO LBR_BOOK
(Title,																			ISBN,				Edition,		Year,Rating,Classification_ID,Publisher_ID,Location_ID) 
Values
('The Mythical Man-Month', 														'0-201-83595-9',	 'Aniversary',	1995, 5,		6,1,1),
('The Mythical Man-Month', 														'0-201-00650-2',	 '1',			1982, 5,		6,1,1),
('Peopleware: Productive Projects and Teams', 									'0-932633-43-9',	 '2',			1999, 5,		6,9,1),
('Peopleware: Productive Projects and Teams', 									'0-936233-05-6',	 '1', 			1987, 5,		6,9,1),
('Programming Pearls', 															'0-201-10331-1',	 'Reprinted',	1989, 5,		16,1,1),
('More Programing Pearls', 														'0-201-11889-0',	 '1', 			1988, 5,		16,1,1),
('Selected Papers on Computer Science', 										'1-881526-91-7',	 '1', 			1996, 5,		16,6,1),
('Literate Programming', 														'0-9370-7380-6',	 '1', 			1992, 5,		16,7,1),
('Deadline', 																	'0-932633-39-0',	 '1', 			1997, 5,		1,9,1),
('Essential SQL on SQL Server 2008',											'978-0-7637-8138-5', '1', 			2011, NULL,		8,12,2),
('A Guide to SQL',																'0-619-21674-3',	 '7', 			2005, NULL,		8,30,2),
('Learn SQL in a Wekend',														'1-931841-62-4',	 '1', 			2002, 3,		8,22,2),
('Teach Yourself SQL in 21 Days',												'0-672-31110-0',	 '2', 			1997, NULL,		8,24,2),
('Microsoft SQL Server 2005 Stored Procedures Programming in T-SQL and .NET',	'0-07-226228-1',	 '1', 			2006, 4,		8,16,2),
('VBA Developer''s Handbook', 													'0-7821-1951-4',	 '1', 			1995, 4,		9,28,2),
('Lean-Agile Acceptance Test-Driven Development', 								'978-0-321-71408-4', '1', 			2011, NULL,		15,1,2),
('Test Driven Development', 													'978-0-321-14653-3', '1', 			2003, NULL,		15,1,2),
('Programming web Services with SOAP', 											'0-596-00095-2',	 '1', 			2002, NULL,		17,18,2),
('Web Services Essentials', 													'0-596-00224-6',	 '1', 			2002, NULL,		17,18,2),
('Understanding Web Services XML,WSDL, SOAP, and UDDI',							'978-0-201-75081-2', '1', 			2002, NULL,		17,1,2),
('Programming Sudoku', 															'1-59059-662-5',	 '1', 			2006, NULL,		18,3,2),
('Windows XP Professional.  The Ultimate User''s Guide',						'1-932111-83-2',	 '2', 			2003, NULL,		10,20,2),
('Windows 7 The Missing Manual', 												'978-0-596-80637-2', '1', 			2010, NULL,		10,18,2),
('Windows 8.1 The Missing Manual', 												'978-1-449-37162-3', '1', 			2013, NULL,		10,18,2),
('SQL Antipatterns', 															'978-1-93435-655-5', NULL, 			2010, 5,		8,29,2),
('SQL Queries for mere Mortals', 												'978-0-321-99247-5', '3', 			2014, NULL,		8,1,2),
('The Elements of Programming Style', 											'0-07-034207-5',	 '2', 			1978, 5,		16,16,2),
('The Practice of Prgramming', 													'0-201-61586-X',	 NULL, 			1999, 5,		16,1,2),
('The C Programming Language', 													'0-13-110362-8',	 '2', 			1988, 4,		7,23,2),
('The Standard C Library', 														'0-13-131509-9',	 NULL, 			1992, 5,		7,23,2),
('Selected Writings on Computing', 												'978-0387906522',	 NULL, 			1982, NULL,		12,27,1),
('Programming on Purpose', 														'978-0137213740',	 NULL, 			1993, 5,		11,23,1),
('Programming on Purpose II', 													'978-0133289132',	 NULL, 			1993, 5,		11,23,1),
('Programming on Purpose III', 													'978-0133281057',	 NULL, 			1994, 5,		11,23,1),
('Is God a Mathematician?', 													'978-0743294058',	 NULL, 			2009, 4,		24,26,1),
('Copenhagen', 																	'978-0385720793',	 NULL, 			1998, 5,		2,2,1),
('The Physicists', 																'0-39-417246-9',	 NULL, 			1964, 5,		3,10,1),
('The Emperor''s New Mind', 													'978-0840145342',	 NULL, 			1989, NULL,		20,21,1),
('Shadows of the Mind', 														'978-0195106466',	 NULL, 			1994, NULL,		20,19,1),
('Godel, Escher, Bach: An Eternal Golden Braid', 								'978-0465026562',	 'Anniversary', 1999, 5,		20,5,1),
('The Mind''s I: Fantasies And Reflections On Self & Soul',						'978-0465030910',	 NULL, 			2001, NULL,		13,5,1),
('The Computer Contradictionary', 												'978-0262611121',	 NULL, 			1995, 5,		19,17,1),
('The New hacker''s Dictionary', 												'978-0262680790',	 '2', 			1993, 5,		19,17,1),
('Humour the Computer', 														'978-0262540759',	 NULL, 			1995, 5,		19,17,1),
('Aha! Insight', 																'978-0716710172',	 '1', 			1978, 5,		21,33,1),
('Aha! Gotcha', 																'978-0716713616',	 '1', 			1982, 5,		21,33,1),
('Free to Choose', 																'978-0156334600',	 NULL, 			1979, 5,		22,11,1),
('Compassion vs. Guilt', 														'978-0688071141',	 '1', 			1987, 4,		14,34,1),
('Discrimination and Disparities', 												'978-1541645608',	 '1', 			2018, NULL,		22,5,1),
('The Road to Serfdom', 														'978-0226320557',	 '1', 			2007, 5,		23,31,1),
('The Anti-Capitalistic Mentality', 											'978-1610161336',	 NULL, 			2016, 5,		22,15,1),
('Economic Policy: Thoughts for Today and Tomorrow',							'978-0865977365',	 'New Edition', 2010, 5,		22,13,1),
('Economics in One Lesson', 													'978-0517548233',	 NULL, 			1988, 5,		22,8,1),
('Watership Down', 																'0-901720-31-3',	 NULL, 			1975, 5,		4,4,NULL),
('A Farawell to Arms', 															'978-1476764528',	 'Reprint ',	2014, 5,		5,25,1),
('For Whom the bell Tolls', 													'978-0684803357',	 NULL, 			1995, 5,		5,25,1),
('War and Peace', 																'978-1400079988',	 'Reprinted',   2008, 5,		5,32,NULL),
('The Winds of War',															'0-00-221941-7 ',	 '1', 			1971, 5,		5,14,1),
('War and Remebrance', 															'978-0316954990',	 NULL,			1972, 5,		5,14,1) 
GO


------------------------
-- populate LBR_JNC_AuthorBook
------------------------
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Brooks'And boo.ISBN = '0-201-83595-9'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Brooks'And boo.ISBN = '0-201-00650-2'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'DeMarco'And boo.ISBN = '0-932633-43-9'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Lister'And boo.ISBN = '0-932633-43-9'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'DeMarco'And boo.ISBN = '0-936233-05-6'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Lister'And boo.ISBN = '0-936233-05-6'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Bentley'And boo.ISBN = '0-201-10331-1'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Bentley'And boo.ISBN = '0-201-11889-0'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Knuth'And boo.ISBN = '1-881526-91-7'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Knuth'And boo.ISBN = '0-9370-7380-6'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'DeMarco'And boo.ISBN = '0-932633-39-0'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Bagui'And boo.ISBN = '978-0-7637-8138-5'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Earp'And boo.ISBN = '978-0-7637-8138-5'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Pratt'And boo.ISBN = '0-619-21674-3'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Thompson'And boo.ISBN = '1-931841-62-4'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Dicken'And boo.ISBN = '1-931841-62-4'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Stephens'And boo.ISBN = '0-672-31110-0'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Plew'And boo.ISBN = '0-672-31110-0'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Morgan'And boo.ISBN = '0-672-31110-0'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Perkins'And boo.ISBN = '0-672-31110-0'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Sunderic'And boo.ISBN = '0-07-226228-1'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Getz'And boo.ISBN = '0-7821-1951-4'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Gilbert'And boo.ISBN = '0-7821-1951-4'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Pugh'And boo.ISBN = '978-0-321-71408-4'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Beck 'And boo.ISBN = '978-0-321-14653-3'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Snell'And boo.ISBN = '0-596-00095-2'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Tidwell'And boo.ISBN = '0-596-00095-2'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Kulchenko'And boo.ISBN = '0-596-00095-2'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Cerami'And boo.ISBN = '0-596-00224-6'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Newcomer'And boo.ISBN = '978-0-201-75081-2'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Lee'And boo.ISBN = '1-59059-662-5'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Ballew'And boo.ISBN = '1-932111-83-2'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Pogue'And boo.ISBN = '978-0-596-80637-2'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Pogue'And boo.ISBN = '978-1-449-37162-3'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Karwin'And boo.ISBN = '978-1-93435-655-5'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Viescas'And boo.ISBN = '978-0-321-99247-5'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Hernandez'And boo.ISBN = '978-0-321-99247-5'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Kernighan'And boo.ISBN = '0-07-034207-5'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Plager'And boo.ISBN = '0-07-034207-5'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Kernighan'And boo.ISBN = '0-201-61586-X'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Pike'And boo.ISBN = '0-201-61586-X'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Kernighan'And boo.ISBN = '0-13-110362-8'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Ritchie'And boo.ISBN = '0-13-110362-8'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Plauger'And boo.ISBN = '0-13-131509-9'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Dijkstra'And boo.ISBN = '978-0387906522'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Plauger'And boo.ISBN = '978-0137213740'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Plauger'And boo.ISBN = '978-0133289132'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Plauger'And boo.ISBN = '978-0133281057'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Livio'And boo.ISBN = '978-0743294058'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Trayn'And boo.ISBN = '978-0385720793'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Durenmatt'And boo.ISBN = '0-39-417246-9'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Penrose'And boo.ISBN = '978-0840145342'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Penrose'And boo.ISBN = '978-0195106466'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Hofstadter'And boo.ISBN = '978-0465026562'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Hofstadter'And boo.ISBN = '978-0465030910'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Dennett'And boo.ISBN = '978-0465030910'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Kelly-Bootle'And boo.ISBN = '978-0262611121'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Raymond'And boo.ISBN = '978-0262680790'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Davison'And boo.ISBN = '978-0262540759'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Gardner'And boo.ISBN = '978-0716710172'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Gardner'And boo.ISBN = '978-0716713616'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Friedman'And boo.ISBN = '978-0156334600' And aut.Firstname = 'Milton'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Friedman'And boo.ISBN = '978-0156334600' And aut.Firstname = 'Rose'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Sowell'And boo.ISBN = '978-0688071141'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Sowell'And boo.ISBN = '978-1541645608'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Hayek'And boo.ISBN = '978-0226320557'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'von Mises'And boo.ISBN = '978-1610161336'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'von Mises'And boo.ISBN = '978-0865977365'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Hazlitt'And boo.ISBN = '978-0517548233'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Adams'And boo.ISBN = '0-901720-31-3'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Hemingway'And boo.ISBN = '978-1476764528'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Hemingway'And boo.ISBN = '978-0684803357'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Tolstoy'And boo.ISBN = '978-1400079988'
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Wouk'And boo.ISBN = '0-00-221941-7 '
INSERT INTO  LBR_JNC_AuthorBook (Author_ID, Book_ID) SELECT aut.Author_ID, boo.Book_ID FROM LBR_Author aut, LBR_Book boo WHERE aut.LastName = 'Wouk'And boo.ISBN = '978-0316954990'
