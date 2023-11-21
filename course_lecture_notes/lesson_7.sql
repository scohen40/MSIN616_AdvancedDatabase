--Lesson 7
--11/20/2023

--missed a few topics in this chapter

--SELECT INTO

--UPDATE
--always use a where clause with your update
--always run a select clause with your where clause first before changing things!

--DELETE ROW
--use a where clause and be incredibly careful 
--(in mySQL they require a where clause when deleting anything and there are also different safe stuff to deal with)
--before deleting run a select with a where clause!

--skipping merge

/* Chapter 2 */
-- --
--DCL = Data Control Language: GRANT, REVOKE

--AD = Active Directory/ADUC(Active Directory Users and Computers)
--keeps track of all users and computers in a domain
--assigns privleges and access controls
--the job of the person managing this would be the SysAdmin/Systems Administrator

--Azure AD - keeps track of all users and computers in an online way. Contoso = the dummy org they use to keep track of the active directory
-- user it to sync your computers to the Contoso Azure Active Directory to have all accounts have access to stuff online.

-- to get database access - you need access to SSMS and access to the database itself
-- on the computer you're on now is SQL Server AND SSMS. In the real world when you connect to an actual SQL Server, it won't be your computer name. Your server name is going to look like a website or IP Address.
-- Up until now we've been using Windows Authentication (whatever credential you used to log into on your computer your using) give me access to so your Active Directory is on your own computer
--SQL Server Athentication credentials ONLY used for SQL Server Access - credentials created under the Security Logins folder in SSMS 
--	under logins SA = SysAdmin
--	if you go into a specific database in SSMS, every db has a specific Security folder and you have to give whatever user you create access to each table in the db.
--	if there's many people in the org, you wouldn't want everyone to have access to everything, so you manage access to private information tables

--BACKUPS
-- --
--we are being told one way, but need to use a different one for the project
--will have to back-up to a .sql file (not in the following way)
--Full Backup = when data is copied in entirety every time
--Incremental Backup = when data is copied in its entirety initially and then consequently each change is backed up seperately
--Differential Backup = one backup that encompases all changes per period of time(like maybe per day)
--look at comparison chart in slides on page 269

--Disaster Recovery 
-- make the point between last backup and recovery time the shortest amount possible

--On-Prem vs. Cloud comparisons page 272
