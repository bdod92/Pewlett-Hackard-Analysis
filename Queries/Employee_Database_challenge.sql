DROP TABLE retirement_titles;
SELECT  em.emp_no,
        em.first_name,
        em.last_name,
		ti.title,
        ti.from_date,
        ti.to_date
INTO retirement_titles
FROM employees AS em
	INNER JOIN titles AS ti
		ON (em.emp_no = ti.emp_no)
	WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	ORDER BY em.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.title DESC;

-- Retrieve the employees who are about to retire
DROP TABLE retiring_titles;
SELECT COUNT(title) AS count, title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- create table that aggregates mentorship ability based on age and
-- if they are currently employed. Ordered by employee number

SELECT DISTINCT ON (em.emp_no) 
	em.emp_no, 
	em.first_name, 
	em.last_name, 
	em.birth_date,
	de.from_date,
	de.to_date,
	titles.title
INTO mentorship_eligibility
FROM employees AS em
INNER JOIN dept_emp AS de
	ON (em.emp_no = de.emp_no)
INNER JOIN titles
	ON (em.emp_no = titles.emp_no)
WHERE (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY em.emp_no ASC;