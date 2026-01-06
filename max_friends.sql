/*
Write a solution to find the people who have the most friends and the most friends number.
Input: 
RequestAccepted table:
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
Output: 
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+
*/


# Write your MySQL query statement below
WITH all_ids AS (
    SELECT requester_id AS id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
    FROM RequestAccepted
),
friend_counts AS (
    SELECT id, COUNT(*) AS num
    FROM all_ids
    GROUP BY id
)
SELECT id, num
FROM friend_counts
ORDER BY num DESC
LIMIT 1;