SELECT emp_no, first_name, last_name
FROM employees

SELECT title, from_date, to_date
FROM titles

DROP TABLE retirement_titles_1;

SELECT emp.*, t.title, t.from_date, t.to_date
INTO retirement_titles_1
FROM employees as emp
JOIN titles AS t
ON emp.emp_no = t.emp_no
WHERE emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp.emp_no ASC;

DROP TABLE retirement_titles;

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title, from_date, to_date
INTO retirement_titles
FROM retirement_titles_1;

SELECT * FROM retirement_titles;

DROP TABLE unique_title;

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, to_date, title
INTO unique_title
FROM retirement_titles_1
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_title;

DROP TABLE retiring_titles;

SELECT COUNT(title) AS count, title
INTO retiring_titles
FROM unique_title
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles

DROP TABLE mentorship_eligibility;

SELECT DISTINCT ON (emp.emp_no) emp.emp_no, emp.first_name, emp.last_name, emp.birth_date, dp.from_date, dp.to_date, t.title
INTO mentorship_eligibility
FROM employees as emp
JOIN titles AS t
ON emp.emp_no = t.emp_no
JOIN dept_emp AS dp
ON t.emp_no = dp.emp_no
WHERE (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (dp.to_date = '9999-01-01')
ORDER BY emp.emp_no ASC;