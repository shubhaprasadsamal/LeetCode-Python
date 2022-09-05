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

--570. Managers with at Least 5 Direct Reports
--Medium
--
--256
--
--39
--
--Add to List
--
--Share
--SQL Schema
--Table: Employee
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| id          | int     |
--| name        | varchar |
--| department  | varchar |
--| managerId   | int     |
--+-------------+---------+
--id is the primary key column for this table.
--Each row of this table indicates the name of an employee, their department, and the id of their manager.
--If managerId is null, then the employee does not have a manager.
--No employee will be the manager of themself.
--
--
--Write an SQL query to report the managers with at least five direct reports.
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
--+-----+-------+------------+-----------+
--| id  | name  | department | managerId |
--+-----+-------+------------+-----------+
--| 101 | John  | A          | None      |
--| 102 | Dan   | A          | 101       |
--| 103 | James | A          | 101       |
--| 104 | Amy   | A          | 101       |
--| 105 | Anne  | A          | 101       |
--| 106 | Ron   | B          | 101       |
--+-----+-------+------------+-----------+
--Output:
--+------+
--| name |
--+------+
--| John |
--+------+

select
    e2.name as name
from
    Employee  e1 join Employee  e2
on
    e1.managerId = e2.id
group by
    1
having
    count(1)>=5

--570. Managers with at Least 5 Direct Reports
--Medium
--
--256
--
--39
--
--Add to List
--
--Share
--SQL Schema
--Table: Employee
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| id          | int     |
--| name        | varchar |
--| department  | varchar |
--| managerId   | int     |
--+-------------+---------+
--id is the primary key column for this table.
--Each row of this table indicates the name of an employee, their department, and the id of their manager.
--If managerId is null, then the employee does not have a manager.
--No employee will be the manager of themself.
--
--
--Write an SQL query to report the managers with at least five direct reports.
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
--+-----+-------+------------+-----------+
--| id  | name  | department | managerId |
--+-----+-------+------------+-----------+
--| 101 | John  | A          | None      |
--| 102 | Dan   | A          | 101       |
--| 103 | James | A          | 101       |
--| 104 | Amy   | A          | 101       |
--| 105 | Anne  | A          | 101       |
--| 106 | Ron   | B          | 101       |
--+-----+-------+------------+-----------+
--Output:
--+------+
--| name |
--+------+
--| John |
--+------+

# Write your MySQL query statement below
with cte as
(
select
   managerId
from
    Employee
group by
    1
having
    count(distinct id) >= 5
)
select
    name
from
    Employee
where
    id in (select * from cte)


--574. Winning Candidate
--Medium
--
--138
--
--390
--
--Add to List
--
--Share
--SQL Schema
--Table: Candidate
--
--+-------------+----------+
--| Column Name | Type     |
--+-------------+----------+
--| id          | int      |
--| name        | varchar  |
--+-------------+----------+
--id is the primary key column for this table.
--Each row of this table contains information about the id and the name of a candidate.
--
--
--Table: Vote
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| id          | int  |
--| candidateId | int  |
--+-------------+------+
--id is an auto-increment primary key.
--candidateId is a foreign key to id from the Candidate table.
--Each row of this table determines the candidate who got the ith vote in the elections.
--
--
--Write an SQL query to report the name of the winning candidate (i.e., the candidate who got the largest number of votes).
--
--The test cases are generated so that exactly one candidate wins the elections.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Candidate table:
--+----+------+
--| id | name |
--+----+------+
--| 1  | A    |
--| 2  | B    |
--| 3  | C    |
--| 4  | D    |
--| 5  | E    |
--+----+------+
--Vote table:
--+----+-------------+
--| id | candidateId |
--+----+-------------+
--| 1  | 2           |
--| 2  | 4           |
--| 3  | 3           |
--| 4  | 2           |
--| 5  | 5           |
--+----+-------------+
--Output:
--+------+
--| name |
--+------+
--| B    |
--+------+
--Explanation:
--Candidate B has 2 votes. Candidates C, D, and E have 1 vote each.
--The winner is candidate B.

# Write your MySQL query statement below

with cte as
(
select
    candidateId ,
    rank() over(order by count(id) desc) as rnk
from
    Vote
group by
    candidateId
)
select
    name
from
    cte c1 join Candidate c2
on
    c1.candidateId = c2.id
and
    c1.rnk = 1

--578. Get Highest Answer Rate Question
--Medium
--
--91
--
--848
--
--Add to List
--
--Share
--SQL Schema
--Table: SurveyLog
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| id          | int  |
--| action      | ENUM |
--| question_id | int  |
--| answer_id   | int  |
--| q_num       | int  |
--| timestamp   | int  |
--+-------------+------+
--There is no primary key for this table. It may contain duplicates.
--action is an ENUM of the type: "show", "answer", or "skip".
--Each row of this table indicates the user with ID = id has taken an action with the question question_id at time timestamp.
--If the action taken by the user is "answer", answer_id will contain the id of that answer, otherwise, it will be null.
--q_num is the numeral order of the question in the current session.
--
--
--The answer rate for a question is the number of times a user answered the question by the number of times a user showed the question.
--
--Write an SQL query to report the question that has the highest answer rate. If multiple questions have the same maximum answer rate, report the question with the smallest question_id.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--SurveyLog table:
--+----+--------+-------------+-----------+-------+-----------+
--| id | action | question_id | answer_id | q_num | timestamp |
--+----+--------+-------------+-----------+-------+-----------+
--| 5  | show   | 285         | null      | 1     | 123       |
--| 5  | answer | 285         | 124124    | 1     | 124       |
--| 5  | show   | 369         | null      | 2     | 125       |
--| 5  | skip   | 369         | null      | 2     | 126       |
--+----+--------+-------------+-----------+-------+-----------+
--Output:
--+------------+
--| survey_log |
--+------------+
--| 285        |
--+------------+
--Explanation:
--Question 285 was showed 1 time and answered 1 time. The answer rate of question 285 is 1.0
--Question 369 was showed 1 time and was not answered. The answer rate of question 369 is 0.0
--Question 285 has the highest answer rate.

# Write your MySQL query statement below
with cte as
(
select
  question_id,
  round(ifnull((sum(if(action = 'answer',1,0))/sum(if(action = 'show',1,0))),0.0),2) as rate
from
    SurveyLog
group by
    1
)
select
    question_id as survey_log
from
    cte
order by
    rate desc, question_id
limit 1
    ;

--580. Count Student Number in Departments
--Medium
--
--205
--
--33
--
--Add to List
--
--Share
--SQL Schema
--Table: Student
--
--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| student_id   | int     |
--| student_name | varchar |
--| gender       | varchar |
--| dept_id      | int     |
--+--------------+---------+
--student_id is the primary key column for this table.
--dept_id is a foreign key to dept_id in the Department tables.
--Each row of this table indicates the name of a student, their gender, and the id of their department.
--
--
--Table: Department
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| dept_id     | int     |
--| dept_name   | varchar |
--+-------------+---------+
--dept_id is the primary key column for this table.
--Each row of this table contains the id and the name of a department.
--
--
--Write an SQL query to report the respective department name and number of students majoring in each department for all departments in the Department table (even ones with no current students).
--
--Return the result table ordered by student_number in descending order. In case of a tie, order them by dept_name alphabetically.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Student table:
--+------------+--------------+--------+---------+
--| student_id | student_name | gender | dept_id |
--+------------+--------------+--------+---------+
--| 1          | Jack         | M      | 1       |
--| 2          | Jane         | F      | 1       |
--| 3          | Mark         | M      | 2       |
--+------------+--------------+--------+---------+
--Department table:
--+---------+-------------+
--| dept_id | dept_name   |
--+---------+-------------+
--| 1       | Engineering |
--| 2       | Science     |
--| 3       | Law         |
--+---------+-------------+
--Output:
--+-------------+----------------+
--| dept_name   | student_number |
--+-------------+----------------+
--| Engineering | 2              |
--| Science     | 1              |
--| Law         | 0              |
--+-------------+----------------+

select
    dept_name,
    ifnull(count(student_id),0) as student_number
from
    Department d left join Student s
on
    d.dept_id = s.dept_id
group by
    1
order by
    2 desc,1

--585. Investments in 2016
--Medium
--
--204
--
--223
--
--Add to List
--
--Share
--SQL Schema
--Table: Insurance
--
--+-------------+-------+
--| Column Name | Type  |
--+-------------+-------+
--| pid         | int   |
--| tiv_2015    | float |
--| tiv_2016    | float |
--| lat         | float |
--| lon         | float |
--+-------------+-------+
--pid is the primary key column for this table.
--Each row of this table contains information about one policy where:
--pid is the policyholder's policy ID.
--tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
--lat is the latitude of the policy holder's city.
--lon is the longitude of the policy holder's city.
--
--
--Write an SQL query to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:
--
--have the same tiv_2015 value as one or more other policyholders, and
--are not located in the same city like any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
--Round tiv_2016 to two decimal places.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Insurance table:
--+-----+----------+----------+-----+-----+
--| pid | tiv_2015 | tiv_2016 | lat | lon |
--+-----+----------+----------+-----+-----+
--| 1   | 10       | 5        | 10  | 10  |
--| 2   | 20       | 20       | 20  | 20  |
--| 3   | 10       | 30       | 20  | 20  |
--| 4   | 10       | 40       | 40  | 40  |
--+-----+----------+----------+-----+-----+
--Output:
--+----------+
--| tiv_2016 |
--+----------+
--| 45.00    |
--+----------+
--Explanation:
--The first record in the table, like the last record, meets both of the two criteria.
--The tiv_2015 value 10 is the same as the third and fourth records, and its location is unique.
--
--The second record does not meet any of the two criteria. Its tiv_2015 is not like any other policyholders and its location is the same as the third record, which makes the third record fail, too.
--So, the result is the sum of tiv_2016 of the first and last record, which is 45.

# Write your MySQL query statement below

select
    round(sum(tiv_2016), 2) as "tiv_2016"
from
    Insurance i1
where
    tiv_2015 in (select
                    tiv_2015
                from
                    Insurance
                group by
                    tiv_2015
                having
                    count(*) > 1
                )
    and (lat, lon) in (select
                                lat, lon
                             from
                                Insurance
                             group by
                                lat, lon
                             having
                                count(*) = 1
                             )

--602. Friend Requests II: Who Has the Most Friends
--Medium
--
--260
--
--75
--
--Add to List
--
--Share
--SQL Schema
--Table: RequestAccepted
--
--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| requester_id   | int     |
--| accepter_id    | int     |
--| accept_date    | date    |
--+----------------+---------+
--(requester_id, accepter_id) is the primary key for this table.
--This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
--
--
--Write an SQL query to find the people who have the most friends and the most friends number.
--
--The test cases are generated so that only one person has the most friends.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--RequestAccepted table:
--+--------------+-------------+-------------+
--| requester_id | accepter_id | accept_date |
--+--------------+-------------+-------------+
--| 1            | 2           | 2016/06/03  |
--| 1            | 3           | 2016/06/08  |
--| 2            | 3           | 2016/06/08  |
--| 3            | 4           | 2016/06/09  |
--+--------------+-------------+-------------+
--Output:
--+----+-----+
--| id | num |
--+----+-----+
--| 3  | 3   |
--+----+-----+
--Explanation:
--The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.

# Write your MySQL query statement below

with cte as
(
select
    requester_id as person,
    accepter_id  as friend
from
    RequestAccepted
UNION ALL
select
    accepter_id as person,
    requester_id  as friend
from
    RequestAccepted
)
select
    person as id,
    count(distinct friend) as num
from
    cte
group by
    1
order by
    count(distinct friend) desc
limit 1;

--608. Tree Node
--Medium
--
--664
--
--42
--
--Add to List
--
--Share
--SQL Schema
--Table: Tree
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| id          | int  |
--| p_id        | int  |
--+-------------+------+
--id is the primary key column for this table.
--Each row of this table contains information about the id of a node and the id of its parent node in a tree.
--The given structure is always a valid tree.
--
--
--Each node in the tree can be one of three types:
--
--"Leaf": if the node is a leaf node.
--"Root": if the node is the root of the tree.
--"Inner": If the node is neither a leaf node nor a root node.
--Write an SQL query to report the type of each node in the tree.
--
--Return the result table ordered by id in ascending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--
--Input:
--Tree table:
--+----+------+
--| id | p_id |
--+----+------+
--| 1  | null |
--| 2  | 1    |
--| 3  | 1    |
--| 4  | 2    |
--| 5  | 2    |
--+----+------+
--Output:
--+----+-------+
--| id | type  |
--+----+-------+
--| 1  | Root  |
--| 2  | Inner |
--| 3  | Leaf  |
--| 4  | Leaf  |
--| 5  | Leaf  |
--+----+-------+
--Explanation:
--Node 1 is the root node because its parent node is null and it has child nodes 2 and 3.
--Node 2 is an inner node because it has parent node 1 and child node 4 and 5.
--Nodes 3, 4, and 5 are leaf nodes because they have parent nodes and they do not have child nodes.
--Example 2:
--
--
--Input:
--Tree table:
--+----+------+
--| id | p_id |
--+----+------+
--| 1  | null |
--+----+------+
--Output:
--+----+-------+
--| id | type  |
--+----+-------+
--| 1  | Root  |
--+----+-------+
--Explanation: If there is only one node on the tree, you only need to output its root attributes.

# Write your MySQL query statement below

SELECT id,
    case when p_id is null then "Root"
            when id in (select p_id from Tree) then "Inner"
            else
                "Leaf" end as type
FROM tree

--612. Shortest Distance in a Plane
--Medium
--
--180
--
--64
--
--Add to List
--
--Share
--SQL Schema
--Table: Point2D
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| x           | int  |
--| y           | int  |
--+-------------+------+
--(x, y) is the primary key column for this table.
--Each row of this table indicates the position of a point on the X-Y plane.
--
--
--The distance between two points p1(x1, y1) and p2(x2, y2) is sqrt((x2 - x1)2 + (y2 - y1)2).
--
--Write an SQL query to report the shortest distance between any two points from the Point2D table. Round the distance to two decimal points.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Point2D table:
--+----+----+
--| x  | y  |
--+----+----+
--| -1 | -1 |
--| 0  | 0  |
--| -1 | -2 |
--+----+----+
--Output:
--+----------+
--| shortest |
--+----------+
--| 1.00     |
--+----------+
--Explanation: The shortest distance is 1.00 from point (-1, -1) to (-1, 2).

# Write your MySQL query statement below
with cte as
(
select
    p1.x as x1,
    p1.y as y1,
    p2.x as x2,
    p2.y as y2

from
    Point2D p1 join Point2D p2
on
    p1.x != p2.x
OR
    p1.y != p2.y
)
select
    round(min(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))),2) as shortest
from
    cte;

--614. Second Degree Follower
--Medium
--
--127
--
--710
--
--Add to List
--
--Share
--SQL Schema
--Table: Follow
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| followee    | varchar |
--| follower    | varchar |
--+-------------+---------+
--(followee, follower) is the primary key column for this table.
--Each row of this table indicates that the user follower follows the user followee on a social network.
--There will not be a user following themself.
--
--
--A second-degree follower is a user who:
--
--follows at least one user, and
--is followed by at least one user.
--Write an SQL query to report the second-degree users and the number of their followers.
--
--Return the result table ordered by follower in alphabetical order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Follow table:
--+----------+----------+
--| followee | follower |
--+----------+----------+
--| Alice    | Bob      |
--| Bob      | Cena     |
--| Bob      | Donald   |
--| Donald   | Edward   |
--+----------+----------+
--Output:
--+----------+-----+
--| follower | num |
--+----------+-----+
--| Bob      | 2   |
--| Donald   | 1   |
--+----------+-----+
--Explanation:
--User Bob has 2 followers. Bob is a second-degree follower because he follows Alice, so we include him in the result table.
--User Donald has 1 follower. Donald is a second-degree follower because he follows Bob, so we include him in the result table.
--User Alice has 1 follower. Alice is not a second-degree follower because she does not follow anyone, so we don not include her in the result table.

# Write your MySQL query statement below

select
    f1.follower,
    count(distinct f2.follower) as num
from
    Follow f1 join Follow f2
on
    f1.follower = f2.followee
group by
    1
order by
    1;

--626. Exchange Seats
--Medium
--
--779
--
--386
--
--Add to List
--
--Share
--SQL Schema
--Table: Seat
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| id          | int     |
--| student     | varchar |
--+-------------+---------+
--id is the primary key column for this table.
--Each row of this table indicates the name and the ID of a student.
--id is a continuous increment.
--
--
--Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.
--
--Return the result table ordered by id in ascending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Seat table:
--+----+---------+
--| id | student |
--+----+---------+
--| 1  | Abbot   |
--| 2  | Doris   |
--| 3  | Emerson |
--| 4  | Green   |
--| 5  | Jeames  |
--+----+---------+
--Output:
--+----+---------+
--| id | student |
--+----+---------+
--| 1  | Doris   |
--| 2  | Abbot   |
--| 3  | Green   |
--| 4  | Emerson |
--| 5  | Jeames  |
--+----+---------+
--Explanation:
--Note that if the number of students is odd, there is no need to change the last one's seat.

# Write your MySQL query statement below
with cte as
(
select
    id,
    student,
    lead(id,1) over(order by id) as next,
    lag(id,1) over(order by id) as prev
from
    Seat
)
select
    case when id%2 != 0 and next is null then id
        when id%2 != 0 and next is not null then next
        when id%2 =0 then prev end as id,
        student
from
    cte
order by
1;

--1045. Customers Who Bought All Products
--Medium
--
--210
--
--38
--
--Add to List
--
--Share
--SQL Schema
--Table: Customer
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| customer_id | int     |
--| product_key | int     |
--+-------------+---------+
--There is no primary key for this table. It may contain duplicates.
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
--Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.
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
--Product table:
--+-------------+
--| product_key |
--+-------------+
--| 5           |
--| 6           |
--+-------------+
--Output:
--+-------------+
--| customer_id |
--+-------------+
--| 1           |
--| 3           |
--+-------------+
--Explanation:
--The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.

select
    customer_id
from
    Customer
group by
    customer_id
having
    count(distinct product_key) = (select count(*) from Product )

--1070. Product Sales Analysis III
--Medium
--
--77
--
--308
--
--Add to List
--
--Share
--SQL Schema
--Table: Sales
--
--+-------------+-------+
--| Column Name | Type  |
--+-------------+-------+
--| sale_id     | int   |
--| product_id  | int   |
--| year        | int   |
--| quantity    | int   |
--| price       | int   |
--+-------------+-------+
--(sale_id, year) is the primary key of this table.
--product_id is a foreign key to Product table.
--Each row of this table shows a sale on the product product_id in a certain year.
--Note that the price is per unit.
--
--
--Table: Product
--
--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| product_id   | int     |
--| product_name | varchar |
--+--------------+---------+
--product_id is the primary key of this table.
--Each row of this table indicates the product name of each product.
--
--
--Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.
--
--Return the resulting table in any order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Sales table:
--+---------+------------+------+----------+-------+
--| sale_id | product_id | year | quantity | price |
--+---------+------------+------+----------+-------+
--| 1       | 100        | 2008 | 10       | 5000  |
--| 2       | 100        | 2009 | 12       | 5000  |
--| 7       | 200        | 2011 | 15       | 9000  |
--+---------+------------+------+----------+-------+
--Product table:
--+------------+--------------+
--| product_id | product_name |
--+------------+--------------+
--| 100        | Nokia        |
--| 200        | Apple        |
--| 300        | Samsung      |
--+------------+--------------+
--Output:
--+------------+------------+----------+-------+
--| product_id | first_year | quantity | price |
--+------------+------------+----------+-------+
--| 100        | 2008       | 10       | 5000  |
--| 200        | 2011       | 15       | 9000  |
--+------------+------------+----------+-------+

# Write your MySQL query statement below
select
    product_id ,
    year as first_year ,
    quantity ,
    price
from
    (
select
    product_id ,
    year,
    quantity ,
    price,
    rank() over(partition by product_id  order by year) as rnk
from
    Sales
        )a
        where a.rnk = 1;

--1077. Project Employees III
--Medium
--
--200
--
--7
--
--Add to List
--
--Share
--SQL Schema
--Table: Project
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| project_id  | int     |
--| employee_id | int     |
--+-------------+---------+
--(project_id, employee_id) is the primary key of this table.
--employee_id is a foreign key to Employee table.
--Each row of this table indicates that the employee with employee_id is working on the project with project_id.
--
--
--Table: Employee
--
--+------------------+---------+
--| Column Name      | Type    |
--+------------------+---------+
--| employee_id      | int     |
--| name             | varchar |
--| experience_years | int     |
--+------------------+---------+
--employee_id is the primary key of this table.
--Each row of this table contains information about one employee.
--
--
--Write an SQL query that reports the most experienced employees in each project. In case of a tie, report all employees with the maximum number of experience years.
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
--Project table:
--+-------------+-------------+
--| project_id  | employee_id |
--+-------------+-------------+
--| 1           | 1           |
--| 1           | 2           |
--| 1           | 3           |
--| 2           | 1           |
--| 2           | 4           |
--+-------------+-------------+
--Employee table:
--+-------------+--------+------------------+
--| employee_id | name   | experience_years |
--+-------------+--------+------------------+
--| 1           | Khaled | 3                |
--| 2           | Ali    | 2                |
--| 3           | John   | 3                |
--| 4           | Doe    | 2                |
--+-------------+--------+------------------+
--Output:
--+-------------+---------------+
--| project_id  | employee_id   |
--+-------------+---------------+
--| 1           | 1             |
--| 1           | 3             |
--| 2           | 1             |
--+-------------+---------------+
--Explanation: Both employees with id 1 and 3 have the most experience among the employees of the first project. For the second project, the employee with id 1 has the most experience.

with cte as
(
select
    p.project_id
    ,p.employee_id
    ,rank() over (partition by p.project_id order by experience_years desc) as rnk

from
    Project p join Employee e
on
    p.employee_id = e.employee_id
)
select
    project_id,
    employee_id
from
    cte
where
    rnk = 1;

--1098. Unpopular Books
--Medium
--
--164
--
--479
--
--Add to List
--
--Share
--SQL Schema
--Table: Books
--
--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| book_id        | int     |
--| name           | varchar |
--| available_from | date    |
--+----------------+---------+
--book_id is the primary key of this table.
--
--
--Table: Orders
--
--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| order_id       | int     |
--| book_id        | int     |
--| quantity       | int     |
--| dispatch_date  | date    |
--+----------------+---------+
--order_id is the primary key of this table.
--book_id is a foreign key to the Books table.
--
--
--Write an SQL query that reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than one month from today. Assume today is 2019-06-23.
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
--Books table:
--+---------+--------------------+----------------+
--| book_id | name               | available_from |
--+---------+--------------------+----------------+
--| 1       | "Kalila And Demna" | 2010-01-01     |
--| 2       | "28 Letters"       | 2012-05-12     |
--| 3       | "The Hobbit"       | 2019-06-10     |
--| 4       | "13 Reasons Why"   | 2019-06-01     |
--| 5       | "The Hunger Games" | 2008-09-21     |
--+---------+--------------------+----------------+
--Orders table:
--+----------+---------+----------+---------------+
--| order_id | book_id | quantity | dispatch_date |
--+----------+---------+----------+---------------+
--| 1        | 1       | 2        | 2018-07-26    |
--| 2        | 1       | 1        | 2018-11-05    |
--| 3        | 3       | 8        | 2019-06-11    |
--| 4        | 4       | 6        | 2019-06-05    |
--| 5        | 4       | 5        | 2019-06-20    |
--| 6        | 5       | 9        | 2009-02-02    |
--| 7        | 5       | 8        | 2010-04-13    |
--+----------+---------+----------+---------------+
--Output:
--+-----------+--------------------+
--| book_id   | name               |
--+-----------+--------------------+
--| 1         | "Kalila And Demna" |
--| 2         | "28 Letters"       |
--| 5         | "The Hunger Games" |
--+-----------+--------------------+

# Write your MySQL query statement below

select
    b.book_id,
    b.name
from
   Books b left join  Orders o
on
    b.book_id = o.book_id
where
    b.book_id not in (select
                            distinct book_id
                        from
                            Books
                        where
                            datediff('2019-06-23',available_from) <= 30)
group by
    1,2
having
    sum(case when dispatch_date > DATE_SUB('2019-06-23', INTERVAL 1 YEAR) THEN quantity else 0 end) < 10
    ;

--1107. New Users Daily Count
--Medium
--
--120
--
--131
--
--Add to List
--
--Share
--SQL Schema
--Table: Traffic
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| user_id       | int     |
--| activity      | enum    |
--| activity_date | date    |
--+---------------+---------+
--There is no primary key for this table, it may have duplicate rows.
--The activity column is an ENUM type of ('login', 'logout', 'jobs', 'groups', 'homepage').
--
--
--Write an SQL query to reports for every date within at most 90 days from today, the number of users that logged in for the first time on that date. Assume today is 2019-06-30.
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
--Traffic table:
--+---------+----------+---------------+
--| user_id | activity | activity_date |
--+---------+----------+---------------+
--| 1       | login    | 2019-05-01    |
--| 1       | homepage | 2019-05-01    |
--| 1       | logout   | 2019-05-01    |
--| 2       | login    | 2019-06-21    |
--| 2       | logout   | 2019-06-21    |
--| 3       | login    | 2019-01-01    |
--| 3       | jobs     | 2019-01-01    |
--| 3       | logout   | 2019-01-01    |
--| 4       | login    | 2019-06-21    |
--| 4       | groups   | 2019-06-21    |
--| 4       | logout   | 2019-06-21    |
--| 5       | login    | 2019-03-01    |
--| 5       | logout   | 2019-03-01    |
--| 5       | login    | 2019-06-21    |
--| 5       | logout   | 2019-06-21    |
--+---------+----------+---------------+
--Output:
--+------------+-------------+
--| login_date | user_count  |
--+------------+-------------+
--| 2019-05-01 | 1           |
--| 2019-06-21 | 2           |
--+------------+-------------+
--Explanation:
--Note that we only care about dates with non zero user count.
--The user with id 5 first logged in on 2019-03-01 so he's not counted on 2019-06-21.

-- Solution -1
--############
# Write your MySQL query statement below
with cte as
(
select

    user_id,
    activity_date ,
    row_number() over(partition by user_id order by activity_date) as rnk

from
    Traffic
where
    activity = 'login'
)
select
    activity_date as login_date,
    count(user_id) as user_count
from
    cte
where
    activity_date >= date_sub('2019-06-30', INTERVAL 90 DAY)
and
    rnk = 1
group by
    1
order by
    1 desc;

-- Solution -2
--############
# Write your MySQL query statement below
with cte as
(
select

    user_id,
    min(activity_date) as  login_date
from
    Traffic
where
    activity = 'login'
group by
    1
)
select
    login_date,
    count(user_id) as user_count
from
    cte
where
    login_date >= date_sub('2019-06-30', INTERVAL 90 DAY)
group by
    1
order by
    1 desc;



--1112. Highest Grade For Each Student
--Medium
--
--220
--
--11
--
--Add to List
--
--Share
--SQL Schema
--Table: Enrollments
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| student_id    | int     |
--| course_id     | int     |
--| grade         | int     |
--+---------------+---------+
--(student_id, course_id) is the primary key of this table.
--
--
--Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id.
--
--Return the result table ordered by student_id in ascending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Enrollments table:
--+------------+-------------------+
--| student_id | course_id | grade |
--+------------+-----------+-------+
--| 2          | 2         | 95    |
--| 2          | 3         | 95    |
--| 1          | 1         | 90    |
--| 1          | 2         | 99    |
--| 3          | 1         | 80    |
--| 3          | 2         | 75    |
--| 3          | 3         | 82    |
--+------------+-----------+-------+
--Output:
--+------------+-------------------+
--| student_id | course_id | grade |
--+------------+-----------+-------+
--| 1          | 2         | 99    |
--| 2          | 2         | 95    |
--| 3          | 3         | 82    |
--+------------+-----------+-------+

with cte as
(
select
    student_id,
    course_id,
    grade,
    dense_rank() over (partition by student_id order by grade desc,course_id) as rnk
from
    Enrollments
)
select
    student_id
    ,course_id
    ,grade
from
    cte
where
    rnk = 1;


