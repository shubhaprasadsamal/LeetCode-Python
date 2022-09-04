--1549. The Most Recent Orders for Each Product
--
--Table: Customers
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| customer_id   | int     |
--| name          | varchar |
--+---------------+---------+
--customer_id is the primary key for this table.
--This table contains information about the customers.
--
--
--Table: Orders
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| order_id      | int     |
--| order_date    | date    |
--| customer_id   | int     |
--| product_id    | int     |
--+---------------+---------+
--order_id is the primary key for this table.
--This table contains information about the orders made by customer_id.
--There will be no product ordered by the same user more than once in one day.
--
--
--Table: Products
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| product_id    | int     |
--| product_name  | varchar |
--| price         | int     |
--+---------------+---------+
--product_id is the primary key for this table.
--This table contains information about the Products.
--
--
--Write an SQL query to find the most recent order(s) of each product.
--
--Return the result table sorted by product_name in ascending order and in case of a tie by the product_id in ascending order. If there still a tie, order them by the order_id in ascending order.
--
--The query result format is in the following example:
--
--Customers
--+-------------+-----------+
--| customer_id | name      |
--+-------------+-----------+
--| 1           | Winston   |
--| 2           | Jonathan  |
--| 3           | Annabelle |
--| 4           | Marwan    |
--| 5           | Khaled    |
--+-------------+-----------+
--
--Orders
--+----------+------------+-------------+------------+
--| order_id | order_date | customer_id | product_id |
--+----------+------------+-------------+------------+
--| 1        | 2020-07-31 | 1           | 1          |
--| 2        | 2020-07-30 | 2           | 2          |
--| 3        | 2020-08-29 | 3           | 3          |
--| 4        | 2020-07-29 | 4           | 1          |
--| 5        | 2020-06-10 | 1           | 2          |
--| 6        | 2020-08-01 | 2           | 1          |
--| 7        | 2020-08-01 | 3           | 1          |
--| 8        | 2020-08-03 | 1           | 2          |
--| 9        | 2020-08-07 | 2           | 3          |
--| 10       | 2020-07-15 | 1           | 2          |
--+----------+------------+-------------+------------+
--
--Products
--+------------+--------------+-------+
--| product_id | product_name | price |
--+------------+--------------+-------+
--| 1          | keyboard     | 120   |
--| 2          | mouse        | 80    |
--| 3          | screen       | 600   |
--| 4          | hard disk    | 450   |
--+------------+--------------+-------+
--
--Result table:
--+--------------+------------+----------+------------+
--| product_name | product_id | order_id | order_date |
--+--------------+------------+----------+------------+
--| keyboard     | 1          | 6        | 2020-08-01 |
--| keyboard     | 1          | 7        | 2020-08-01 |
--| mouse        | 2          | 8        | 2020-08-03 |
--| screen       | 3          | 3        | 2020-08-29 |
--+--------------+------------+----------+------------+
--keyboard's most recent order is in 2020-08-01, it was ordered two times this day.
--mouse's most recent order is in 2020-08-03, it was ordered only once this day.
--screen's most recent order is in 2020-08-29, it was ordered only once this day.
--The hard disk was never ordered and we don't include it in the result table.

Solution1:

with t1 as(
    SELECT p.product_name, p.product_id, max(o.order_date) as order_date
    FROM Orders o
    JOIN Products p
    USING(product_id)
    GROUP BY 1
)

SELECT t1.product_name, t1.product_id, o.order_id, t1.order_date
FROM Orders o
JOIN t1
ON o.order_date = t1.order_date AND t1.product_id = o.product_id
ORDER BY 1 ASC, 2 ASC, 3 ASC

Solution2:

with orders_with_rank as (
select
    product_name,
    product_id,
    order_id,
    order_date,
    rank() over(partition by product_id order by order_date desc) rnk
from
    orders
    join
    products
    using(product_id)
)
select
    product_name,
    product_id,
    order_id,
    order_date
from orders_with_rank
where
    rnk = 1
order by product_name, product_id, order_id

--1045. Customers Who Bought All Products     [Amazon]
--Table: Customer
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| customer_id | int     |
--| product_key | int     |
--+-------------+---------+
--product_key is a foreign key to Product table.
--
--
--Table: Product
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| product_key | int     |
--+-------------+---------+
--product_key is the primary key column for this table.
--
--
--Write an SQL query for a report that provides the customer ids from the Customer table that bought all the products in the Product table.
--
--Return the result table in any order.
--
--The query result format is in the following example:
--
--
--
--Customer table:
--+-------------+-------------+
--| customer_id | product_key |
--+-------------+-------------+
--| 1           | 5           |
--| 2           | 6           |
--| 3           | 5           |
--| 3           | 6           |
--| 1           | 6           |
--+-------------+-------------+
--
--Product table:
--+-------------+
--| product_key |
--+-------------+
--| 5           |
--| 6           |
--+-------------+
--
--Result table:
--+-------------+
--| customer_id |
--+-------------+
--| 1           |
--| 3           |
--+-------------+
--The customers who bought all the products (5 and 6) are customers with id 1 and 3.

Solution 1:

select
    customer_id
from
    Customer
group by
    customer_id
having
    count(distinct product_key) = (select
                    count(*)
                from
                    Product );

Solution 2:

select
    x.customer_id "customer_id"
from
    (select
        customer_id,
        count(distinct product_key) cnt
    from
        Customer
    group by
        customer_id
    ) x,
    (select
        count(product_key) cnt
    from
        Product
    ) y
where
    x.cnt = y.cnt
;
--
--176. Second Highest Salary
--Table: Employee
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| id          | int  |
--| salary      | int  |
--+-------------+------+
--id is the primary key column for this table.
--Each row of this table contains information about the salary of an employee.
--
--
--Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Employee table:
--+----+--------+
--| id | salary |
--+----+--------+
--| 1  | 100    |
--| 2  | 200    |
--| 3  | 300    |
--+----+--------+
--Output:
--+---------------------+
--| SecondHighestSalary |
--+---------------------+
--| 200                 |
--+---------------------+
--Example 2:
--
--Input:
--Employee table:
--+----+--------+
--| id | salary |
--+----+--------+
--| 1  | 100    |
--+----+--------+
--Output:
--+---------------------+
--| SecondHighestSalary |
--+---------------------+
--| null                |
--+---------------------+

# Write your MySQL query statement below
select
    max(salary) as SecondHighestSalary
from
    Employee
where
    salary not in (select max(salary) from Employee);

--177. Nth Highest Salary
--Table: Employee
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| id          | int  |
--| salary      | int  |
--+-------------+------+
--id is the primary key column for this table.
--Each row of this table contains information about the salary of an employee.
--
--
--Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Employee table:
--+----+--------+
--| id | salary |
--+----+--------+
--| 1  | 100    |
--| 2  | 200    |
--| 3  | 300    |
--+----+--------+
--n = 2
--Output:
--+------------------------+
--| getNthHighestSalary(2) |
--+------------------------+
--| 200                    |
--+------------------------+
--Example 2:
--
--Input:
--Employee table:
--+----+--------+
--| id | salary |
--+----+--------+
--| 1  | 100    |
--+----+--------+
--n = 2
--Output:
--+------------------------+
--| getNthHighestSalary(2) |
--+------------------------+
--| null                   |
--+------------------------+

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      with cte as
      (
      select
        salary,
        dense_rank() over(order by salary desc) as rnk
      from
        Employee
          )
      select
        salary as getNthHighestSalary
      from
        cte
      where
        rnk = n
      limit 1

  );
END

--178. Rank Scores
--
--Table: Scores
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| id          | int     |
--| score       | decimal |
--+-------------+---------+
--id is the primary key for this table.
--Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
--
--
--Write an SQL query to rank the scores. The ranking should be calculated according to the following rules:
--
--The scores should be ranked from the highest to the lowest.
--If there is a tie between two scores, both should have the same ranking.
--After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
--Return the result table ordered by score in descending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Scores table:
--+----+-------+
--| id | score |
--+----+-------+
--| 1  | 3.50  |
--| 2  | 3.65  |
--| 3  | 4.00  |
--| 4  | 3.85  |
--| 5  | 4.00  |
--| 6  | 3.65  |
--+----+-------+
--Output:
--+-------+------+
--| score | rank |
--+-------+------+
--| 4.00  | 1    |
--| 4.00  | 1    |
--| 3.85  | 2    |
--| 3.65  | 3    |
--| 3.65  | 3    |
--| 3.50  | 4    |
--+-------+------+

# Write your MySQL query statement below

select
    score ,
    dense_rank() over(order by score desc) as 'rank'
from
    Scores ;

--180. Consecutive Numbers
--Medium
--
--1181
--
--207
--
--Add to List
--
--Share
--SQL Schema
--Table: Logs
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| id          | int     |
--| num         | varchar |
--+-------------+---------+
--id is the primary key for this table.
--id is an autoincrement column.
--
--
--Write an SQL query to find all numbers that appear at least three times consecutively.
--
--Return the result table in any order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Logs table:
--+----+-----+
--| id | num |
--+----+-----+
--| 1  | 1   |
--| 2  | 1   |
--| 3  | 1   |
--| 4  | 2   |
--| 5  | 1   |
--| 6  | 2   |
--| 7  | 2   |
--+----+-----+
--Output:
--+-----------------+
--| ConsecutiveNums |
--+-----------------+
--| 1               |
--+-----------------+
--Explanation: 1 is the only number that appears consecutively for at least three times.

# Write your MySQL query statement below
select
    distinct l1.num  as "ConsecutiveNums"
from
    Logs l1
    inner join Logs l2 on (l1.num = l2.num and l1.id = l2.id - 1)
    inner join Logs l3 on (l1.num = l3.num and l1.id = l3.id - 2)
;

--184. Department Highest Salary
--Medium
--
--1314
--
--167
--
--Add to List
--
--Share
--SQL Schema
--Table: Employee
--
--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| id           | int     |
--| name         | varchar |
--| salary       | int     |
--| departmentId | int     |
--+--------------+---------+
--id is the primary key column for this table.
--departmentId is a foreign key of the ID from the Department table.
--Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
--
--
--Table: Department
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| id          | int     |
--| name        | varchar |
--+-------------+---------+
--id is the primary key column for this table.
--Each row of this table indicates the ID of a department and its name.
--
--
--Write an SQL query to find employees who have the highest salary in each of the departments.
--
--Return the result table in any order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Employee table:
--+----+-------+--------+--------------+
--| id | name  | salary | departmentId |
--+----+-------+--------+--------------+
--| 1  | Joe   | 70000  | 1            |
--| 2  | Jim   | 90000  | 1            |
--| 3  | Henry | 80000  | 2            |
--| 4  | Sam   | 60000  | 2            |
--| 5  | Max   | 90000  | 1            |
--+----+-------+--------+--------------+
--Department table:
--+----+-------+
--| id | name  |
--+----+-------+
--| 1  | IT    |
--| 2  | Sales |
--+----+-------+
--Output:
--+------------+----------+--------+
--| Department | Employee | Salary |
--+------------+----------+--------+
--| IT         | Jim      | 90000  |
--| Sales      | Henry    | 80000  |
--| IT         | Max      | 90000  |
--+------------+----------+--------+
--Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

# Write your MySQL query statement below
with cte as
(
select
    d.name as Department ,
    e.name as Employee ,
    salary as Salary ,
    dense_rank() over(partition by d.name order by salary desc) as rnk
from
   Employee e inner join  Department d
on
    e.departmentId = d.id
)
select
    Department ,
    Employee ,
    Salary
from
    cte
where
    rnk = 1;

--534. Game Play Analysis III
--Medium
--
--301
--
--14
--
--Add to List
--
--Share
--SQL Schema
--Table: Activity
--
--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| player_id    | int     |
--| device_id    | int     |
--| event_date   | date    |
--| games_played | int     |
--+--------------+---------+
--(player_id, event_date) is the primary key of this table.
--This table shows the activity of players of some games.
--Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
--
--
--Write an SQL query to report for each player and date, how many games played so far by the player. That is, the total number of games played by the player until that date. Check the example for clarity.
--
--Return the result table in any order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Activity table:
--+-----------+-----------+------------+--------------+
--| player_id | device_id | event_date | games_played |
--+-----------+-----------+------------+--------------+
--| 1         | 2         | 2016-03-01 | 5            |
--| 1         | 2         | 2016-05-02 | 6            |
--| 1         | 3         | 2017-06-25 | 1            |
--| 3         | 1         | 2016-03-02 | 0            |
--| 3         | 4         | 2018-07-03 | 5            |
--+-----------+-----------+------------+--------------+
--Output:
--+-----------+------------+---------------------+
--| player_id | event_date | games_played_so_far |
--+-----------+------------+---------------------+
--| 1         | 2016-03-01 | 5                   |
--| 1         | 2016-05-02 | 11                  |
--| 1         | 2017-06-25 | 12                  |
--| 3         | 2016-03-02 | 0                   |
--| 3         | 2018-07-03 | 5                   |
--+-----------+------------+---------------------+
--Explanation:
--For the player with id 1, 5 + 6 = 11 games played by 2016-05-02, and 5 + 6 + 1 = 12 games played by 2017-06-25.
--For the player with id 3, 0 + 5 = 5 games played by 2018-07-03.
--Note that for each player we only care about the days when the player logged in.

select
    player_id ,
    event_date ,
    sum(games_played) over (partition by player_id order by event_date) as games_played_so_far
from
    Activity ;

--550. Game Play Analysis IV
--Medium
--
--249
--
--72
--
--Add to List
--
--Share
--SQL Schema
--Table: Activity
--
--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| player_id    | int     |
--| device_id    | int     |
--| event_date   | date    |
--| games_played | int     |
--+--------------+---------+
--(player_id, event_date) is the primary key of this table.
--This table shows the activity of players of some games.
--Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
--
--
--Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Activity table:
--+-----------+-----------+------------+--------------+
--| player_id | device_id | event_date | games_played |
--+-----------+-----------+------------+--------------+
--| 1         | 2         | 2016-03-01 | 5            |
--| 1         | 2         | 2016-03-02 | 6            |
--| 2         | 3         | 2017-06-25 | 1            |
--| 3         | 1         | 2016-03-02 | 0            |
--| 3         | 4         | 2018-07-03 | 5            |
--+-----------+-----------+------------+--------------+
--Output:
--+-----------+
--| fraction  |
--+-----------+
--| 0.33      |
--+-----------+
--Explanation:
--Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

# Write your MySQL query statement below
with cte as
(
select
    player_id,
    event_date as cur_date ,
    min(event_date) over(partition by player_id ) as next_date

from
    Activity
)
select
    round(sum(case when (abs(next_date-cur_date) = 1) then 1 else 0 end)/count(distinct player_id),2) as fraction
from
    cte;

