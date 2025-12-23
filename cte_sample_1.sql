-- To calculate the average salary by department and find employees earning more than that average.

WITH AvgSalaryByDept AS (
    SELECT 
        DepartmentID, 
        AVG(Salary) AS AvgSalary 
    FROM 
        Employees 
    GROUP BY 
        DepartmentID
)
SELECT 
    e.EmployeeID, 
    e.Name, 
    e.DepartmentID, 
    a.AvgSalary
FROM 
    Employees e
JOIN 
    AvgSalaryByDept a ON e.DepartmentID = a.DepartmentID
WHERE 
    e.Salary > a.AvgSalary;
