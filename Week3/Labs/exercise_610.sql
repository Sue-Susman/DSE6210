DROP TABLE IF EXISTS company.employee;
DROP TABLE IF EXISTS company.department;
DROP TABLE IF EXISTS company.dept_locations;
DROP TABLE IF EXISTS company.project;
DROP TABLE IF EXISTS company.works_on;
DROP TABLE IF EXISTS company.dependent;
DROP TABLE IF EXISTS libraries.publisher;

DROP SCHEMA IF EXISTS company;

CREATE SCHEMA IF NOT EXISTS company;

-- Create EMPLOYEE table in the company schema
CREATE TABLE company.EMPLOYEE (
    Fname VARCHAR(15),
    Minit CHAR,
    Lname VARCHAR(15),
    Ssn CHAR(9) PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR,
    Salary DECIMAL(10, 2),
    Super_ssn CHAR(9),
    Dno INT NOT NULL
);

-- Create DEPARTMENT table in the company schema
CREATE TABLE company.DEPARTMENT (
    Dname VARCHAR(15),
    Dnumber INT NOT NULL PRIMARY KEY,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE,
    FOREIGN KEY (Mgr_ssn) REFERENCES company.EMPLOYEE(Ssn)
);

-- Create DEPT_LOCATIONS table in the company schema
CREATE TABLE company.DEPT_LOCATIONS (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES company.DEPARTMENT(Dnumber)
);

-- Create PROJECT table in the company schema
CREATE TABLE company.PROJECT (
    Pname VARCHAR(15),
    Pnumber INT NOT NULL PRIMARY KEY,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    FOREIGN KEY (Dnum) REFERENCES company.DEPARTMENT(Dnumber)
);

-- Create WORKS_ON table in the company schema
CREATE TABLE company.WORKS_ON (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3, 1) NOT NULL,
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES company.EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES company.PROJECT(Pnumber)
);

-- Create DEPENDENT table in the company schema
CREATE TABLE company.DEPENDENT (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR,
    Bdate DATE,
    Relationship VARCHAR(8),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES company.EMPLOYEE(Ssn)
);

INSERT INTO company.employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
VALUES
    ('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5),
    ('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, '888665555', 5),
    ('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000, '987654321', 4),
    ('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire,TX', 'F', 43000, '888665555', 4),
    ('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble,TX', 'M', 38000, '333445555', 5),
    ('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5),
    ('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000, '987654321', 4),
    ('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);
	
	
INSERT INTO company.department (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
VALUES
    ('Research', 5, '333445555', '1988-05-22'),
    ('Administration', 4, '987654321', '1995-01-01'),
    ('Headquarters', 1, '888665555', '1981-06-19');
	
	
INSERT INTO company.dept_locations (Dnumber, Dlocation)
VALUES
    (1, 'Houston'),
    (4, 'Stafford'),
    (5, 'Bellaire'),
    (5, 'Sugarland'),
    (1, 'Houston');
	
INSERT INTO company.project (Pname, Pnumber, Plocation, Dnum)
VALUES
    ('ProductX', 1, 'Bellaire', 5),
    ('ProductY', 2, 'Sugarland', 5),
    ('ProductZ', 3, 'Houston', 5),
    ('Computerization', 10, 'Stafford', 4),
    ('Reorganization', 20, 'Houston', 1),
    ('Newbenefits', 30, 'Stafford', 4);
	
INSERT INTO company.works_on (Essn, Pno, Hours)
VALUES
    ('123456789', 1, 32.5),
    ('123456789', 2, 7.5),
    ('666884444', 3, 40.0),
    ('453453453', 1, 20.0),
    ('453453453', 2, 20.0),
    ('333445555', 2, 10.0),
    ('333445555', 3, 10.0),
    ('333445555', 10, 10.0),
    ('333445555', 20, 10.0),
    ('999887777', 30, 30.0),
    ('999887777', 10, 10.0),
    ('987987987', 10, 35.0),
    ('987987987', 30, 5.0),
    ('987654321', 30, 20.0),
    ('987654321', 20, 15.0),
    ('888665555', 20, 0);
	
INSERT INTO company.dependent (Essn, Dependent_name, Sex, Bdate, Relationship)
VALUES
    ('333445555', 'Alice', 'F', '1986-04-05', 'DAUGHTER'),
    ('333445555', 'Theodore', 'M', '1983-10-25', 'SON'),
    ('333445555', 'Joy', 'F', '1958-05-03', 'SPOUSE'),
    ('987654321', 'Abner', 'M', '1942-02-28', 'SPOUSE'),
    ('123456789', 'Michael', 'M', '1988-01-04', 'SON'),
    ('123456789', 'Alice', 'F', '1988-12-30', 'DAUGHTER'),
    ('123456789', 'Elizabeth', 'F', '1967-05-05', 'SPOUSE');
					   
--a) Retrieve the names of all employees in department 5 who earn more than 3000 and work on the ProductZ project:
SELECT E.Fname, E.Lname
FROM company.employee E
JOIN company.department D ON E.Dno = D.Dnumber
JOIN company.works_on W ON E.Ssn = W.Essn
JOIN company.project P ON W.Pno = P.Pnumber
WHERE D.Dnumber = 5
  AND E.Salary > 3000
  AND P.Pname = 'ProductZ';
  
--b) List the names of all employees who are from Houston, Texas, and work under manager 333445555:
SELECT E.Fname, E.Lname
FROM company.employee E
JOIN company.department D ON E.Dno = D.Dnumber
WHERE D.Mgr_ssn = '333445555'
  AND E.Address LIKE '%Houston%'
  AND E.Address LIKE '%TX%';

--c) Find the names of all employees who are working in the project Computerization.
SELECT E.Fname, E.Lname
FROM company.employee E
JOIN company.works_on W ON E.Ssn = W.Essn
JOIN company.project P ON W.Pno = P.Pnumber
WHERE P.Pname = 'Computerization';