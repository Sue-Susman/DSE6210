DROP TABLE IF EXISTS school.student;
DROP TABLE IF EXISTS school.course;
DROP TABLE IF EXISTS school.section;
DROP TABLE IF EXISTS school.grade_report;
DROP TABLE IF EXISTS school.prerequisite;

DROP SCHEMA IF EXISTS school;

CREATE SCHEMA IF NOT EXISTS school;

CREATE TABLE school.student (
    Student_number INT PRIMARY KEY,
    Name VARCHAR(255),
    Class INT,
    Major VARCHAR(255)
);

-- Create the Course table
CREATE TABLE school.course (
    Course_number VARCHAR(255) PRIMARY KEY,
    Course_name VARCHAR(255),
    Credit_hours INT,
    Department VARCHAR(255)
);

-- Create the Section table
CREATE TABLE school.section (
    Section_identifier INT PRIMARY KEY,
    Course_number VARCHAR(255),
    Semester VARCHAR(255),
    Year INT,
    Instructor VARCHAR(255),
    FOREIGN KEY (Course_number) REFERENCES school.course(Course_number)
);

-- Create the Grade Report table
CREATE TABLE school.grade_report (
    Student_number INT,
    Section_identifier INT,
    Grade VARCHAR(255),
    FOREIGN KEY (Student_number) REFERENCES school.student(Student_number),
    FOREIGN KEY (Section_identifier) REFERENCES school.section(Section_identifier)
);

-- Create the Prerequisite table
CREATE TABLE school.prerequisite (
    Course_number VARCHAR(255),
    Prerequisite_number VARCHAR(255),
    FOREIGN KEY (Course_number) REFERENCES school.course(Course_number),
    FOREIGN KEY (Prerequisite_number) REFERENCES school.course(Course_number)
);

-- Insert data into the Student table
INSERT INTO school.student (Name, Student_number, Class, Major)
VALUES
    ('Smith', 17, 1, 'CS'),
    ('Brown', 8, 2, 'CS');
	
	-- Insert data into the Course table
INSERT INTO school.course (Course_name, Course_number, Credit_hours, Department)
VALUES
    ('Intro to Computer Science', 'CS1310', 4, 'CS'),
    ('Data Structures', 'CS3320', 4, 'CS'),
    ('Discrete Mathematics', 'MATH2410', 3, 'MATH'),
    ('Database', 'CS3380', 3, 'CS');

-- Insert data into the Section table
INSERT INTO school.section (Section_identifier, Course_number, Semester, Year, Instructor)
VALUES
    (85, 'MATH2410', 'Fall', 7, 'King'),
    (92, 'CS1310', 'Fall', 7, 'Anderson'),
    (102, 'CS3320', 'Spring', 8, 'Knuth'),
    (112, 'MATH2410', 'Fall', 8, 'Chang'),
    (119, 'CS1310', 'Fall', 8, 'Anderson'),
    (135, 'CS3380', 'Fall', 8, 'Stone');
	
-- Insert data into the Grade Report table
INSERT INTO school.grade_report (Student_number, Section_identifier, Grade)
VALUES
    (17, 112, 'B'),
    (17, 119, 'C'),
    (8, 85, 'A'),
    (8, 92, 'A'),
    (8, 102, 'B'),
    (8, 135, 'A');
	
-- Insert data into the Prerequisite table
INSERT INTO school.prerequisite (Course_number, Prerequisite_number)
VALUES
    ('CS3380', 'CS3320'),
    ('CS3380', 'MATH2410'),
    ('CS3320', 'CS1310');

--1) Retrieve the course names of all the courses that come under the department of ‘cs’ (computer science).
SELECT Course_name
FROM school.course
WHERE Department = 'CS';

--2) Retrieve the names of all courses along with the name of the instructor taught during the fall of 2008. 
SELECT Course.Course_name, Section.Instructor
FROM school.course
JOIN school.section ON Course.Course_number = Section.Course_number
WHERE Section.Semester = 'Fall' AND Section.Year = 8;

--3) For each section taught by Professor Anderson, retrieve the course number, semester, year, and number of students who took the section. 
SELECT Section.Course_number, Section.Semester, Section.Year, COUNT(Grade_Report.Student_number) AS Number_of_Students
FROM school.section
JOIN school.grade_report ON Section.Section_identifier = Grade_Report.Section_identifier
JOIN school.student ON Grade_Report.Student_number = Student.Student_number
WHERE Section.Instructor = 'Anderson'
GROUP BY Section.Course_number, Section.Semester, Section.Year;

--4) Retrieve the name and transcript of each junior student (Class = 1) majoring in mathematics (MATH). A transcript includes course name, course number, credit hours, semester, year, and grade for each course completed by the student.
SELECT Student.Name, Course.Course_name, Course.Course_number, Course.Credit_hours, Section.Semester, Section.Year, Grade_Report.Grade
FROM school.student
JOIN school.grade_report ON Student.Student_number = Grade_Report.Student_number
JOIN school.section ON Grade_Report.Section_identifier = Section.Section_identifier
JOIN school.course ON Section.Course_number = Course.Course_number
WHERE Student.Class = 1 AND Student.Major = 'MATH';

--1) Insert a new course, 'Financial Accounting', 'fac4390', 5, 'BUSINESS':
INSERT INTO school.course (Course_name, Course_number, Credit_hours, Department)
VALUES ('Financial Accounting', 'fac4390', 5, 'BUSINESS');
	
--2) Insert a new section, 145, 'fac4390', 'Fall', '17', 'Hanif':
INSERT INTO school.section (Section_identifier, Course_number, Semester, Year, Instructor)
VALUES (145, 'fac4390', 'Fall', 17, 'Hanif');

--3) Insert a new student, 'Robin', 34, 2, 'BUSINESS':
INSERT INTO school.student (Name, Student_number, Class, Major)
VALUES ('Robin', 34, 2, 'BUSINESS');
	
--4) Update the record for the student whose student number is 17 and change his class from 1 to 3:
UPDATE school.student
SET Class = 3
WHERE Student_number = 17;
