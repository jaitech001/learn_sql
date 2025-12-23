-- Highest Transaction in last 30 days

select customer_id,
Max(amount) as highest_transaction
from transactions
where transactions_date >= DATEADD(DAY, -30, getdate())
group by customer_id;