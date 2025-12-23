CREATE TABLE employee_test AS
select e.emp_id, e.emp_name, e.hire_date, d.dept_name, e.salary
from employee e
INNER JOIN department d on d.dept_id = e.dept_id;


-- Find Max salary by department
select *, 
max(salary) over(partition by dept_name) as max_salary
from employee_test;

-- ROW number, RANK, DENSE_RANK
select *, 
ROW_NUMBER() over() as row_num_1,
ROW_NUMBER() over(partition by dept_name) as row_num_2,
RANK() over(partition by dept_name order by salary) as ranking, --This skips the value if there are duplicates
DENSE_RANK() over(partition by dept_name order by salary) as denseranking
from employee_test;


-- Fetch the salary of an employee is higher, lower or equal to the previous or next employee from the same departemnt
select *,
lag(salary) over (partition by dept_name order by emp_id) as prev_emp_salary,
lag(salary,2,0) over (partition by dept_name order by emp_id) as prev_2_emp_salary,
lead(salary) over (partition by dept_name order by emp_id) as next_emp_salary
from employee_test;

select emp_name, dept_name, salary,
lag(salary) over (partition by dept_name order by emp_id) as prev_emp_salary,
case
    when salary > lag(salary) over (partition by dept_name order by emp_id) then "Higher"
    when salary < lag(salary) over (partition by dept_name order by emp_id) then "Lower"
    when salary = lag(salary) over (partition by dept_name order by emp_id) then "Same"
    end salary_range
from employee_test;