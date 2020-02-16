-- Setting date style 
SET datestyle TO "ISO, MDY"; 
-- Importing Employees data
COPY employees FROM 'C:\Data\employees.csv' 
WITH (format csv, header); 
-- Importing Department data
COPY departments FROM 'C:\Data\departments.csv' 
WITH (format csv, header); 
-- Importing Department and Employee data
COPY dept_emp FROM 'C:\Data\dept_emp.csv' 
WITH (format csv, header); 
-- Importing Department and Manager data
COPY dept_manager FROM 'C:\Data\dept_manager.csv' 
WITH (format csv, header); 
-- Importing Department and Employee data
COPY dept_emp FROM 'C:\Data\dept_emp.csv' 
WITH (format csv, header); 
-- Importing Salaries data
COPY salaries FROM 'C:\Data\salaries.csv' 
WITH (format csv, header); 
-- Importing Titles data
COPY titles FROM 'C:\Data\titles.csv' 
WITH (format csv, header); 

--details of each employee: employee number, last name, first name, gender, and salary
SELECT     emp.emp_no "Employee Number",
           last_name "Last Name", 
           first_name "First Name", 
           gender "Gender", 
           salary "Salary" 
FROM       employees emp 
INNER JOIN salaries sal 
ON         emp.emp_no=sal.emp_no ;

-- All the details of employee which were hired in 1986 
select   * 
FROM     employees 
WHERE    date_part('year', hire_date)=1986 
ORDER BY hire_date;

/*List the manager of each department with the following information: 
department number, department name, the manager's employee number, last name, first name, and start and end employment dates.*/
SELECT     dept.dept_no "Department Number",
           dept.dept_name "Department Name", 
           deptmng.emp_no "Employee Number", 
           emp.last_name "Last Name", 
           emp.first_name "First Name", 
           Deptemp.from_date "Start Date", 
           Deptemp.to_date "End Date" 
FROM       departments dept 
INNER JOIN dept_manager deptmng 
ON         dept.dept_no=deptmng.dept_no 
INNER JOIN dept_emp AS Deptemp 
ON         deptmng.emp_no=Deptemp.emp_no 
AND        deptmng.dept_no=Deptemp.dept_no 
INNER JOIN employees emp 
ON         Deptemp.emp_no=emp.emp_no; 

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT     emp.emp_no "Employee Number",
           last_name "Last Name", 
           first_name "First Name", 
           dept.dept_name "Depatment Name" 
FROM       employees emp 
INNER JOIN dept_emp deptemp 
ON         emp.emp_no=deptemp.emp_no 
INNER JOIN departments dept 
ON         deptemp.dept_no=dept.dept_no; 

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * 
FROM   employees 
WHERE  Lower(first_name)=Lower('Hercules') 
AND    Lower(last_name) LIKE Lower('B%'); 

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT     emp.emp_no,
           emp.first_name, 
           emp.last_name,
		   dept_detail.dept_name
FROM       employees emp 
INNER JOIN 
           ( 
                      SELECT     emp_no, 
                                 dept_name 
                      FROM       dept_emp DeptEmp 
                      INNER JOIN departments Dept 
                      ON         DeptEmp.dept_no=Dept.dept_no 
                      WHERE      Lower(dept_name)=Lower('Sales')) dept_detail 
ON         emp.emp_no=dept_detail.emp_no; 

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT     emp.emp_no,
           emp.first_name, 
           emp.last_name,
		   dept_detail.dept_name
FROM       employees emp 
INNER JOIN 
           ( 
                      SELECT     emp_no, 
                                 dept_name 
                      FROM       dept_emp DeptEmp 
                      INNER JOIN departments Dept 
                      ON         DeptEmp.dept_no=Dept.dept_no 
                      WHERE      Lower(dept_name) IN (Lower('Sales'), 
                                                      Lower('Development'))) dept_detail 
ON         emp.emp_no=dept_detail.emp_no; 

-- descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT   last_name,
         Count(*) "total times used" 
FROM     employees 
GROUP BY last_name 
ORDER BY Count(*) DESC;