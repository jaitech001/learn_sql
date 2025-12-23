-- Swap records Inversely based on Category
-- https://www.youtube.com/watch?v=jOrTXXleDcg

/*
To achieve this, we use:

✔ ROW_NUMBER() with ASC and DESC ordering
✔ Partitioning by Category
✔ Self-join logic
✔ A clean and efficient SQL approach used in real interviews
*/

/*
Table Create and Insert statements:

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Product VARCHAR(255),
    Category VARCHAR(100)
);

INSERT INTO Products (ProductID, Product, Category)
VALUES
    (1, 'Laptop', 'Electronics'),
    (2, 'Smartphone', 'Electronics'),
    (3, 'Tablet', 'Electronics'),
    (4, 'Headphones', 'Accessories'),
    (5, 'Smartwatch', 'Accessories'),
    (6, 'Keyboard', 'Accessories'),
    (7, 'Mouse', 'Accessories'),
    (8, 'Monitor', 'Accessories'),
    (9, 'Printer', 'Electronics');
*/

select B.prodictid, B.product, B.category
FROM
(
    SELECT 
        ProductID,
        Product,
        Category,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY ProductID ASC) AS AscendingOrder,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY ProductID DESC) AS DescendingOrder
    FROM Products
) A
JOIN
(
    SELECT 
        ProductID AS prodictid,
        Product AS product,
        Category AS category,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY ProductID ASC) AS AscendingOrder,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY ProductID DESC) AS DescendingOrder
    FROM Products
) B
ON A.AscendingOrder = B.DescendingOrder AND A.Category = B.Category
ORDER BY B.prodictid;