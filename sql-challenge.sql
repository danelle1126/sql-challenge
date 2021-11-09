CREATE TABLE titles (
	title_id VarChar primary key,
	title VarChar
	);

CREATE TABLE employees (
	emp_no int primary key,
	emp_title_id VarChar,
	foreign key (emp_title_id) references titles (title_id),
	birth_date	date,
	first_name	VarChar,
	last_name	VarChar,
	sex	VarChar,
	hire_date date
	);

CREATE TABLE departments (
	dept_no VarChar primary key,
	dept_name VarChar
	);

CREATE TABLE dept_manager (
	dept_no VarChar,
	foreign key (dept_no) references departments (dept_no),
	emp_no int,
	foreign key (emp_no) references employees (emp_no),
	primary key (dept_no, emp_no)
	);
	
CREATE TABLE dept_emp (
	emp_no int,
	foreign key (emp_no) references employees (emp_no),
	dept_no VarChar,
	foreign key (dept_no) references departments (dept_no),	
	primary key (emp_no, dept_no)
	);
	
CREATE TABLE salaries (
	emp_no int primary key,
	salary int,
	foreign key (emp_no) references employees (emp_no)
	);

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, last_name, first_name, sex, salary
FROM employees 
LEFT Join salaries on employees.emp_no = salaries.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date;

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, dept_name, dept_manager.emp_no, last_name, first_name
FROM dept_manager
LEFT JOIN departments ON dept_manager.dept_no = departments.dept_no
LEFT JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, count(last_name)
FROM employees
GROUP BY last_name
ORDER BY count(last_name) DESC;
