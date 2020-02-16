-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

--Create Department table
CREATE TABLE Departments (
    dept_no varchar(50)   NOT NULL,
    dept_name varchar(255)   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);
--Create Department Employee table
CREATE TABLE Dept_Emp (
    emp_no int   NOT NULL,
    dept_no varchar(50)   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

--Create Department Manager table
CREATE TABLE Dept_Manager (
    emp_no int   NOT NULL,
    dept_no varchar(50)   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

--Create Employee table
CREATE TABLE Employees (
    emp_no int   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar(50)   NOT NULL,
    last_name varchar(50)   NOT NULL,
    gender varchar(1)   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

--Create Salaries table
CREATE TABLE Salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

--Create Title table
CREATE TABLE Titles (
    emp_no int   NOT NULL,
    title varchar(50)   NOT NULL,
    from_date Date   NOT NULL,
    to_date Date   NOT NULL
);

--Adding foreign key constraints to Department Employee table
ALTER TABLE Dept_Emp ADD CONSTRAINT fk_Dept_Emp_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_Emp ADD CONSTRAINT fk_Dept_Emp_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

--Adding foreign key constraints to Department Manager table
ALTER TABLE Dept_Manager ADD CONSTRAINT fk_Dept_Manager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_Manager ADD CONSTRAINT fk_Dept_Manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

--Adding foreign key constraints to Salaries table
ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Titles ADD CONSTRAINT fk_Titles_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

