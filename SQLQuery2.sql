
CREATE DATABASE UniversityDB;
GO


USE UniversityDB;
GO


CREATE TABLE Departments (
    DeptID INT PRIMARY KEY IDENTITY(1,1), -- 
    DeptName VARCHAR(100) NOT NULL,       
    Location VARCHAR(50)                  
);
GO


CREATE TABLE Students (
    StudentID INT PRIMARY KEY IDENTITY(1,1), 
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,               
    EnrollmentDate DATE DEFAULT GETDATE(),   
    DeptID INT FOREIGN KEY REFERENCES Departments(DeptID) 
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL              
);
GO


CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
    Semester VARCHAR(20) NOT NULL     
);
GO


USE UniversityDB;
GO

INSERT INTO Departments (DeptName, Location) VALUES 
('IT', 'Block A'),
('Business', 'Block B');
GO


INSERT INTO Students (FirstName, LastName, Email, DeptID) VALUES 
('Ailah', 'Khan', 'ailah@email.com', 1),
('Sana', 'Ahmed', 'sana@email.com', 1),
('Zain', 'Malik', 'zain@email.com', 2);
GO


INSERT INTO Courses (CourseName, Credits) VALUES 
('Database Systems', 4),
('Web Development', 3),
('Marketing 101', 3);
GO


INSERT INTO Enrollments (StudentID, CourseID, Semester) VALUES 
(1, 1, 'Fall 2026'), 
(1, 2, 'Fall 2026'), 
(2, 1, 'Fall 2026'), 
(3, 3, 'Fall 2026'); 
GO


SELECT 
    S.FirstName + ' ' + S.LastName AS StudentName,
    C.CourseName,
    E.Semester
FROM Enrollments E
JOIN Students S ON E.StudentID = S.StudentID
JOIN Courses C ON E.CourseID = C.CourseID;
--This code of block is used to JOIN the first and second name as a student name and list their respective Courses , StudentID 
--Semester to be displayed in a table.

--OPERATIONS ON SQL
SELECT * FROM Students

SELECT * FROM Students
where StudentID = 2

SELECT * FROM Students 
WHERE FirstName = 'Ali';


--Explanation: SELECT tells SQL what columns you want to see. Using an asterisk (*) means "show me all columns". 
--FROM tells SQL which specific table to look inside And WHERE tells the condition if needed.


UPDATE Students
SET Email = 'sana.new@email.com'
WHERE StudentID = 2;

--• Explanation: UPDATE names the table you want to change. 
--SET establishes the new value for the column. Crucial: The WHERE clause ensures you only update student ID 2. 
--Without WHERE, every single student in the database would have their email overwritten with 'sana.new@email.com'.

DELETE FROM Enrollments 
Where StudentID = 3

DELETE FROM Students
WHERE FirstName = 'Zain';

--First, delete Zain's active course enrollments 
-- (Zain has StudentID = 3) as ID is linked as foreign key in enrollments.
--When his enrollments are gone, you can safely delete him from the Students table! otherwise there should be written 
--ON DELETE CASCADE in table to delete a name without enrollments 


TRUNCATE TABLE Enrollments;
-- Empty the entire Enrollments table safely 
--• Explanation: TRUNCATE removes all rows from a table at once. It is much faster than DELETE because it doesn't scan the data row by row—it just drops everything.
-- ⚠️ Note for beginners: You cannot use a WHERE clause with TRUNCATE.
-- It is an all-or-nothing command. Also, because of your database relationships, 
--SQL will prevent you from truncating the Students table if other tables (like Enrollments) are still linked to it

-- LOGICAL OPERATORS IN SQL
SELECT * FROM Students 
WHERE FirstName = 'Ali' OR LastName = 'Ahmed';

--• Explanation: SQL will look at every student. If a student is named 'Ali', they get listed. 
--If another student is named 'Ahmed' (even if their first name isn't Ali), they also get listed.
-- Find courses that match 'Database Systems' or 'Web Development'

SELECT * FROM Courses 
WHERE CourseName IN ('Database Systems', 'Web Development');

--Explanation: Instead of writing CourseName = 'Database Systems' OR CourseName = 'Web Development', you can cleanly group your choices inside parentheses (). 
--SQL checks if the column value matches any item in your list.


SELECT * FROM Students 
WHERE NOT DeptID = 1;

--• Explanation: This tells SQL: "Show me every student, but completely skip anyone whose DeptID is 1." 
--It is great for filtering out specific groups.
--• Pro-Tip: You can combine it with IN, like this: 
--WHERE CourseName NOT IN ('Marketing 101') to exclude a list of courses.

SELECT * FROM Students 
WHERE Email LIKE 'Ailah%';

--LIKE is used to find the record of a thing like Ailah or starts with Ailah or a specific term.
-- Find students whose email ends exactly with '@email.com'.
SELECT * FROM Students 
WHERE Email LIKE '%@email.com';

-- Find courses that have the word 'Data' anywhere in their name.
SELECT * FROM Courses 
WHERE CourseName LIKE '%Data%';

--AGGREGATE FUNCTIONS

SELECT COUNT(*) AS TotalStudents FROM Students;

SELECT COUNT(*) AS ITStudents FROM Students WHERE DeptID = 1;
-- Count how many students total are in the university.
-- Count how many students are enrolled in Department 1.
--Explanation: COUNT(*) counts every row that comes back. 
--We use AS TotalStudents to give the resulting answer column a clean, readable name.

SELECT SUM(Credits) AS [TotalCredits Offered] FROM Courses;
-- Find the total number of course credits offered by the university

ALTER TABLE Students
ADD PhoneNumber VARCHAR(15);
-- To add phone number it has to be INSERTED or UPDATED

ALTER TABLE Students
DROP COLUMN PhoneNumber;
--If we dont need this Column.
--The ALTER command is used when you want to modify 
--the structure of something that already exists in your database without deleting it and starting over

CREATE FUNCTION GetFullName (@First VARCHAR(50), @Last VARCHAR(50))
RETURNS VARCHAR(101)
AS
BEGIN
    RETURN @First + ' ' + @Last
END;
-- This Function glues the first and second name of a student which can be altered to have a dash (-) between the names.

ALTER FUNCTION GetFullName (@First VARCHAR(50), @Last VARCHAR(50))
RETURNS VARCHAR(101)
AS
BEGIN
    
    RETURN @First + '-' + @Last
END;
--Let's say you change your mind. Instead of just a space between 
--the names, you want to put a dash (-) between the First and Last name.

SELECT dbo.GetFullName(FirstName, LastName) FROM Students;
--To check the full name created and altered by these CREATE and ALTER function.
--GetFullName is a scalar function.

--SIMPLE FUNCTIONS IN SQL.
SELECT 
    StudentID,
    
    UPPER(FirstName) AS CapitalFirstName,
    
    -- 2. Convert the email to all lowercase letters
    LOWER(Email) AS LowercaseEmail,
    
    
    LEN(LastName) AS LastNameLength
FROM Students;
-- 1. Convert the first name to all UPPERCASE letters by using UPPER().
 -- 2. Convert the email to all lowercase letters by using LOWER().
 -- 3. Count exactly how many letters are in the Last Name by using LEN().

SELECT 
    FirstName,
    EnrollmentDate,
    
   GETDATE() AS TodaysDateAndTime,
    
    DATEDIFF(day, EnrollmentDate, GETDATE()) AS DaysSinceEnrollment
FROM Students;
-- 1. Show the exact current system date and time right now.
-- 2. Calculate exactly how many DAYS ago the student enrolled.
--• GETDATE() is universally used to timestamp when a transaction, log, or registration happens.
--• DATEDIFF(interval, start_date, end_date) is the industry standard for finding ages, 
--calculated dynamically every time you run the report so the data never goes out of date.

SELECT 
    FirstName,
    SUBSTRING(FirstName, 1, 3) AS ShortNameCode
FROM Students;
-- Create a quick ID card preview using just the first 3 letters of their name
--The SUBSTRING function lets you extract a small piece of a word. 
--It needs three inputs: SUBSTRING(TextColumn, StartPosition, Length).
-- Great for creating automated registration codes, scanning areas of a text string, or isolating domain names from emails.

--Direct Structural Comparison
--Table-Valued Function (TVF):                       
--To compute and return a virtual table	
--Only reading data (SELECT). Modifying tables is strictly banned
--Must be used inside a SELECT statement.
--Stored Procedure (SP):
--Anything (SELECT, INSERT, UPDATE, DELETE, TRUNCATE)
--To execute a script or workflow (CRUD operations)
--Must be executed independently using EXEC.