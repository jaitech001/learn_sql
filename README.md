# learn_sql
Basic to Advanced SQL queries.


## CTE:
A Common Table Expression (CTE) in SQL is a named temporary result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. It is a temporary virtual table that exists only for the duration of a single query's execution, primarily used to break down complex queries into smaller, more readable, and manageable parts.

Key Features and Uses 
 - Readability and Modularity: CTEs break down complex, multi-step queries into smaller, logical, and named blocks, making the code easier to read, understand, and debug compared to deeply nested subqueries.
 - Reusability: A single CTE can be referenced multiple times within the same query statement, which avoids redundant code and promotes efficiency.
 - Recursive Queries: This is a primary advantage, as CTEs are the standard way to perform recursive operations in SQL, such as traversing hierarchical data structures (e.g., organizational charts, family trees, or parts explosions).
 - Alternative to Views and Temporary Tables: They can be used as a substitute for a view when the result set is only needed for a single, non-reusable query, without the overhead of storing a view definition in the database metadata.

Key Differences from Other SQL Constructs 
| Feature | CTEs | Subqueries | Temporary Tables  |
| --- | --- | --- | --- |
| Scope | Single SQL statement | Typically single use within a clause | Entire session or batch  |
| Storage | Not physically stored (virtual table) | Not physically stored (inline) | Physically stored in  |
| Recursion | Supported | Not supported | Not supported  |
| Indexing | Cannot be indexed directly | Cannot be indexed | Can be indexed  |
| Readability | High, due to modular structure | Can become complex and hard to read when nested | Depends on implementation  |


## SQL window functions
SQL window functions perform calculations across a set of table rows that are related to the current row, without merging those rows into a single output like a standard aggregate function would. This enables calculations such as running totals, moving averages, and rankings while retaining individual row details in the result set.
 
Key Components 
The core of a window function is the  clause, which defines the "window" of rows the function operates on. The syntax is as follows: 
```sql
function_name (column_name) OVER (
    [PARTITION BY partition_column, ...]
    [ORDER BY order_column [ASC | DESC], ...]
    [window_frame_clause]
)
```

- The specific window function to use (e.g., , , ). 
- The mandatory keyword that specifies the function is a window function. 
- (Optional) Divides the rows into groups (partitions) where the window function is applied independently within each partition. It works conceptually like  but does not collapse the rows. 
- Specifies the logical order of rows within each partition, which is necessary for most window functions and critical for ranking and running calculations. 
- (Optional, e.g., ) Further defines the precise subset of rows within a partition (the "frame") to be included in the calculation for the current row. 

Types of Window Functions 
SQL supports several categories of window functions: 

- Aggregate Functions (as Window Functions): Standard aggregates (, , , , ) can be used as window functions to produce cumulative or moving aggregates for each row. 

	• Example:  calculates a running total. 

- Ranking Functions: These assign a rank or number to each row within a partition. 

    - Assigns a unique sequential integer to each row, starting from 1. 
    - Assigns a rank with gaps in the sequence for tied values. 
    - Assigns a rank without gaps for tied values. 
    - Divides the result set into a specified number () of groups and assigns a bucket number to each row. 

- Value/Offset Functions: These functions access data from rows relative to the current row. 

    - Accesses a row that follows the current row. 
    - Accesses a row that precedes the current row. 
    - Returns the value of the first row in the window frame. 
    - Returns the value of the last row in the window frame.

Example Use Case 
To calculate the running total of sales for each product category: 
```sql
SELECT
    product,
    category,
    spend,
    SUM(spend) OVER (
        PARTITION BY category
        ORDER BY transaction_date
    ) AS running_total
FROM
    product_spend
ORDER BY
    category, transaction_date; --
```
This query partitions the data by , orders rows within each category by , and calculates the cumulative sum of  for each row, resetting the sum for every new category.
