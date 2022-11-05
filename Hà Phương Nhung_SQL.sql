---Exercise 1----
SELECT department_id 
FROM employees 
WHERE last_name = 'Zlotkey'

SELECT last_name, hire_date 
FROM  employees
WHERE department_id IN (SELECT department_id 
						FROM employees 
						WHERE last_name = 'Zlotkey')
AND last_name <> 'Zlotkey'


----Exercise 2----
SELECT employee_id, last_name, salary 
FROM  employees 
WHERE salary > (SELECT avg(salary) 
				FROM employees)  
ORDER BY salary ASC;


----Exercise 3----
SELECT employee_id, last_name 
FROM employees
WHERE department_id IN (SELECT department_id 
						FROM employees 
						WHERE last_name like '%u%')


---Exercise 4----
---CACH 1--- 
SELECT last_name, department_id, job_id 
FROM employees
WHERE department_id in (SELECT department_id 
						FROM departments 
						WHERE location_id = 1700)

--CACH 2---
SELECT e.last_name, e.department_id, e.job_id 
FROM employees e 
INNER JOIN departments d on e.department_id = d.department_id 
WHERE d.location_id = 1700


---Exercise 5---
---CACH 1---
SELECT last_name, salary 
FROM   employees 
WHERE  manager_id in (SELECT employee_id 
					 FROM employees 
					 WHERE last_name = 'King')

----CACH 2----
SELECT e.last_name, e.salary 
FROM   employees e JOIN employees manager ON e.manager_id = manager.employee_id 
WHERE  manager.last_name = 'King'
 

 ---Exercise 6----
SELECT department_id, last_name, job_id 
FROM   employees
WHERE  department_id IN (SELECT department_id 
						 FROM departments 
						 WHERE department_name = 'Executive')

----Exercise 7----
SELECT employee_id, last_name, salary 
FROM   employees 
WHERE  salary > (SELECT AVG(salary) 
				 FROM employees)  
AND    department_id IN (SELECT department_id 
						 FROM employees 
						 WHERE last_name like '%u%')

----Exercise 8---
SELECT ROUND(MAX(salary),0) "Maximum",
	   ROUND(MIN(salary),0) "Minimum",
       ROUND(SUM(salary),0) "Sum",
       ROUND(AVG(salary),0) "Average"
FROM employees;

----Exercise 9----
---CACH 1---
SELECT UPPER(LEFT(last_name,1))+LOWER(SUBSTRING(last_name,2,LEN(last_name))) "Last_name",
       LEN(last_name) "Length"
FROM employees
WHERE  last_name LIKE 'J%'
	OR last_name LIKE 'M%'
	OR last_name LIKE 'A%'
ORDER BY last_name;

--- CACH 2---
SELECT UPPER(LEFT(last_name,1))+LOWER(SUBSTRING(last_name,2,LEN(last_name))) AS Last_name, 
	   LEN(last_name) AS Length 
FROM employees
WHERE last_name IN (SELECT last_name 
					FROM employees
					WHERE last_name lIKE 'J%' OR last_name LIKE 'A%' OR last_name LIKE 'M%')


----Exercise 10-----
SELECT employee_id, last_name, salary, 
	   ROUND(salary * 1.155, 0) "New Salary" 
FROM   employees;


---Exercise 11----
---Cach 1---
SELECT last_name, department_id, CONVERT(varchar, null)
FROM employees  
UNION ALL
SELECT CONVERT(varchar, null), department_id, department_name 
FROM departments; 

---Cach 2---
SELECT e.last_name, d.department_id, d.department_name 
FROM employees e 
	 FULL JOIN departments d ON d.department_id = e.department_id

----Exercise 12---
---Truong hop 1---
SELECT e.employee_id
FROM   employees e JOIN employees m    ON  e.manager_id = m.employee_id 
	               JOIN departments d  ON  e.department_id = d.department_id
	               JOIN locations l    ON  d.location_id = l.location_id
WHERE e.hire_date >  m.hire_date AND l.city = 'Toronto';
   
----Truong hop 2----
SELECT e.employee_id
FROM employees e JOIN employees m ON e.manager_id = m.employee_id 
WHERE e.hire_date > m.hire_date
UNION
SELECT e.employee_id
FROM employees e JOIN departments d ON e.department_id = d.department_id 
				 JOIN locations l   ON d.location_id = l.location_id
WHERE l.city = 'Toronto'

