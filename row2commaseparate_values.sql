-- Find Passengers That Can Fit in Each Lift
-- https://www.youtube.com/watch?v=8e-e1xYsgG0

/*
🧩 Problem Statement:
The relationship between the LIFT and LIFT_PASSENGERS tables is such that multiple passengers can attempt to enter the same lift — but the total weight of the passengers in a lift cannot exceed the lift’s capacity.

👉 Goal:
Write an SQL query that produces a comma-separated list of passengers who can be accommodated in each lift without exceeding its capacity.
The passengers should be listed in increasing order of their weight.

Table Create and Insert statements:

Create Table Lift_Passengers(
Passenger_Name Varchar(20),
Weight_Kg int,
Lift_Id int)

Insert into Lift_Passengers Values('Mark',85,1)
Insert into Lift_Passengers Values('Antony',73,1)
Insert into Lift_Passengers Values('David',95,1)
Insert into Lift_Passengers Values('Mary',80,1)
Insert into Lift_Passengers Values('John',83,2)
Insert into Lift_Passengers Values('Robert',77,2)
Insert into Lift_Passengers Values('Maria',73,2)
Insert into Lift_Passengers Values('Susan',85,2)

Create Table Lift( Id int,
Capacity_Kg Bigint)

Insert into Lift Values(1,300)
Insert into Lift Values(2,350)
*/

SELECT * FROM Lift_Passengers;
SELECT * FROM Lift;

with cte as(SELECT lp.*, l.capacity_kg,
              SUM(lp.weight_kg) OVER (PARTITION BY lp.lift_id ORDER BY lp.weight_kg ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_total
       FROM Lift_Passengers lp
       JOIN Lift l
       ON lp.lift_id = l.id)
SELECT lift_id,
       STRING_AGG(passenger_name, ', ' ORDER BY weight_kg) AS passengers
FROM cte
WHERE running_total <= capacity_kg
GROUP BY lift_id
ORDER BY lift_id;
