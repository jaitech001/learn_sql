-- Table employee
select * from employee order by salary desc;

-- 3rd Highest Salary using TOP
select top 1 * from (select top 3 * from employee order by salary desc) as emp order by salary asc

-- without TOP using RANK
select * from (select *, DENSE_RANK() over(order by salary desc) as rank from employee) as emp where rank = 3


-- Table OrderDetails
select top 3 * from OrderDetails order by Quantity desc;

select top 1 * from (select top 3 * from OrderDetails order by Quantity desc) as od order by Quantity asc;

select *, DENSE_RANK() over(order by Quantity desc) as rank from OrderDetails;

select * from (select *, DENSE_RANK() over(order by Quantity desc) as rank from OrderDetails) as emp where rank = 3;