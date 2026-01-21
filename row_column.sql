/*
In SQL, converting rows to columns is known as pivoting, and columns to rows is known as unpivoting. 
The specific syntax depends on the database system (e.g., SQL Server, Oracle, PostgreSQL, MySQL)
*/

--using PIVOT (SQL Server)
SELECT Product, [Q1], [Q2]
FROM Sales
PIVOT (
    SUM(Amount) -- The aggregate function
    FOR Quarter IN ([Q1], [Q2]) -- The column whose values become column headers
) AS PivotTable;

-- using CASE (MySQL, standard SQL)
SELECT
    Product,
    SUM(CASE WHEN Quarter = 'Q1' THEN Amount ELSE 0 END) AS Q1,
    SUM(CASE WHEN Quarter = 'Q2' THEN Amount ELSE 0 END) AS Q2
FROM
    Sales
GROUP BY
    Product;

-- using UNPIVOT (SQL Server)
SELECT Product, Quarter, Amount
FROM PivotTable
UNPIVOT (
    Amount FOR Quarter IN ([Q1], [Q2]) -- Specify the new value column and source columns
) AS UnpivotTable;


-- using UNION ALL (Standard SQL)
SELECT Product, 'Q1' AS Quarter, Q1 AS Amount FROM PivotTable
UNION ALL
SELECT Product, 'Q2' AS Quarter, Q2 AS Amount FROM PivotTable;
