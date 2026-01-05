-- Find Duplicate Records from Table based on column
select name,count(*) as count
from students
group by name
having count > 1;

-- To delete duplicate rows in a database using SQL
-- Method 1: Using ROW_NUMBER() (Recommended for most modern SQL databases)
WITH CTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY name, email
            ORDER BY customer_id ASC -- Keeps the row with the lowest ID
        ) AS row_num
    FROM Customers
)
DELETE FROM CTE
WHERE row_num > 1;

-- Method 2: Using DELETE with JOIN or Subquery
DELETE FROM Customers
WHERE CustomerID NOT IN (
    SELECT MaxID
    FROM (
        SELECT MIN(CustomerID) AS MaxID -- Use MIN/MAX to decide which one to keep
        FROM Customers
        GROUP BY Name, Email
    ) AS temp_alias
);

-- Delete duplicate rows using self-join
DELETE c1
FROM customers c1
JOIN customers c2
ON c1.Name = c2.Name AND c1.ID > c2.ID;

-- Delete duplicate rows from the 'customers' table (aliased as c1)
DELETE c1
FROM customers c1
-- Find the maximum ID for each unique Name
JOIN (
    SELECT Name, MAX(ID) AS MaxID
    FROM customers
    GROUP BY Name
) c2
-- Match rows based on 'Name' and keep the row with the maximum ID
ON c1.Name = c2.Name 
AND c1.ID < c2.MaxID;

-- Delete rows from the 'customers' table where there are duplicates
DELETE FROM customers
WHERE ID IN (
    -- Subquery to find IDs of duplicate rows
    SELECT ID
    FROM customers
    GROUP BY ID
    HAVING COUNT(*) > 1
);