-- Unpivot the data | Wide table to short table
-- Column to row conversion
-- Example data:
-- https://www.youtube.com/shorts/nNCqQFGhL7c


select product_id, quarter, year, sales
from SalesData
unpivot
(
  sales for quarter in (Q1, Q2, Q3, Q4)
) as unpvt
order by product_id, year, quarter;

-- Another example
select employee_id, attribute, value
from EmployeeAttributes
unpivot
(
  value for attribute in (Address, Phone, Email)
) as unpvt
order by employee_id, attribute;

-- Yet another example
select product_id, quarter, year, sales
from SalesData
cross apply (values 
  ('Q1', Q1),
  ('Q2', Q2),
  ('Q3', Q3),
  ('Q4', Q4)
) as unpvt(quarter, sales);

-- Cross apply example 2
select employee_id, attribute, value
from EmployeeAttributes
cross apply (values
  ('Address', Address),
  ('Phone', Phone),
  ('Email', Email)
) as unpvt(attribute, value);