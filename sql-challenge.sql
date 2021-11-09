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
	
select * from salaries;