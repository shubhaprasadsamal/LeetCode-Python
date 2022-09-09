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

--1126. Active Businesses
--Medium
--
--208
--
--23
--
--Add to List
--
--Share
--SQL Schema
--Table: Events
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| business_id   | int     |
--| event_type    | varchar |
--| occurences    | int     |
--+---------------+---------+
--(business_id, event_type) is the primary key of this table.
--Each row in the table logs the info that an event of some type occurred at some business for a number of times.
--
--
--The average activity for a particular event_type is the average occurences across all companies that have this event.
--
--An active business is a business that has more than one event_type such that their occurences is strictly greater than the average activity for that event.
--
--Write an SQL query to find all active businesses.
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
--Events table:
--+-------------+------------+------------+
--| business_id | event_type | occurences |
--+-------------+------------+------------+
--| 1           | reviews    | 7          |
--| 3           | reviews    | 3          |
--| 1           | ads        | 11         |
--| 2           | ads        | 7          |
--| 3           | ads        | 6          |
--| 1           | page views | 3          |
--| 2           | page views | 12         |
--+-------------+------------+------------+
--Output:
--+-------------+
--| business_id |
--+-------------+
--| 1           |
--+-------------+
--Explanation:
--The average activity for each event can be calculated as follows:
--- 'reviews': (7+3)/2 = 5
--- 'ads': (11+7+6)/3 = 8
--- 'page views': (3+12)/2 = 7.5
--The business with id=1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8), so it is an active business.

# Write your MySQL query statement below

with temp as (
    select
        business_id ,
        occurences ,
        case
            when (avg(occurences) over (partition by event_type)) < occurences then 1 else 0 end as active_business
    from
        Events
    )
select
    distinct business_id
from
    temp
group by
    business_id
having
    sum(active_business)>1;

--1132. Reported Posts II
--Medium
--
--122
--
--469
--
--Add to List
--
--Share
--SQL Schema
--Table: Actions
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| user_id       | int     |
--| post_id       | int     |
--| action_date   | date    |
--| action        | enum    |
--| extra         | varchar |
--+---------------+---------+
--There is no primary key for this table, it may have duplicate rows.
--The action column is an ENUM type of ('view', 'like', 'reaction', 'comment', 'report', 'share').
--The extra column has optional information about the action, such as a reason for the report or a type of reaction.
--
--
--Table: Removals
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| post_id       | int     |
--| remove_date   | date    |
--+---------------+---------+
--post_id is the primary key of this table.
--Each row in this table indicates that some post was removed due to being reported or as a result of an admin review.
--
--
--Write an SQL query to find the average daily percentage of posts that got removed after being reported as spam, rounded to 2 decimal places.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Actions table:
--+---------+---------+-------------+--------+--------+
--| user_id | post_id | action_date | action | extra  |
--+---------+---------+-------------+--------+--------+
--| 1       | 1       | 2019-07-01  | view   | null   |
--| 1       | 1       | 2019-07-01  | like   | null   |
--| 1       | 1       | 2019-07-01  | share  | null   |
--| 2       | 2       | 2019-07-04  | view   | null   |
--| 2       | 2       | 2019-07-04  | report | spam   |
--| 3       | 4       | 2019-07-04  | view   | null   |
--| 3       | 4       | 2019-07-04  | report | spam   |
--| 4       | 3       | 2019-07-02  | view   | null   |
--| 4       | 3       | 2019-07-02  | report | spam   |
--| 5       | 2       | 2019-07-03  | view   | null   |
--| 5       | 2       | 2019-07-03  | report | racism |
--| 5       | 5       | 2019-07-03  | view   | null   |
--| 5       | 5       | 2019-07-03  | report | racism |
--+---------+---------+-------------+--------+--------+
--Removals table:
--+---------+-------------+
--| post_id | remove_date |
--+---------+-------------+
--| 2       | 2019-07-20  |
--| 3       | 2019-07-18  |
--+---------+-------------+
--Output:
--+-----------------------+
--| average_daily_percent |
--+-----------------------+
--| 75.00                 |
--+-----------------------+
--Explanation:
--The percentage for 2019-07-04 is 50% because only one post of two spam reported posts were removed.
--The percentage for 2019-07-02 is 100% because one post was reported as spam and it was removed.
--The other days had no spam reports so the average is (50 + 100) / 2 = 75%
--Note that the output is only one number and that we do not care about the remove dates.

with cte1 as
(
select
    action_date,
    (count(distinct r.post_id)/count(distinct a.post_id))*100 as percent
from actions a
left join removals r using (post_id)
where action = 'report' and extra = 'spam'
group by 1
)

select round(avg(percent), 2) as average_daily_percent from cte1;

--1149. Article Views II
--Medium
--
--101
--
--27
--
--Add to List
--
--Share
--SQL Schema
--Table: Views
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| article_id    | int     |
--| author_id     | int     |
--| viewer_id     | int     |
--| view_date     | date    |
--+---------------+---------+
--There is no primary key for this table, it may have duplicate rows.
--Each row of this table indicates that some viewer viewed an article (written by some author) on some date.
--Note that equal author_id and viewer_id indicate the same person.
--
--
--Write an SQL query to find all the people who viewed more than one article on the same date.
--
--Return the result table sorted by id in ascending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Views table:
--+------------+-----------+-----------+------------+
--| article_id | author_id | viewer_id | view_date  |
--+------------+-----------+-----------+------------+
--| 1          | 3         | 5         | 2019-08-01 |
--| 3          | 4         | 5         | 2019-08-01 |
--| 1          | 3         | 6         | 2019-08-02 |
--| 2          | 7         | 7         | 2019-08-01 |
--| 2          | 7         | 6         | 2019-08-02 |
--| 4          | 7         | 1         | 2019-07-22 |
--| 3          | 4         | 4         | 2019-07-21 |
--| 3          | 4         | 4         | 2019-07-21 |
--+------------+-----------+-----------+------------+
--Output:
--+------+
--| id   |
--+------+
--| 5    |
--| 6    |
--+------+

with cte as
(
select
viewer_id ,
view_date
,count(distinct article_id)  as tot_view

from
    Views
group by
    1,2
)
select distinct viewer_id as id
from cte
where
    tot_view > 1
order by
    1;

--1158. Market Analysis I
--Medium
--
--291
--
--49
--
--Add to List
--
--Share
--SQL Schema
--Table: Users
--
--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| user_id        | int     |
--| join_date      | date    |
--| favorite_brand | varchar |
--+----------------+---------+
--user_id is the primary key of this table.
--This table has the info of the users of an online shopping website where users can sell and buy items.
--
--
--Table: Orders
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| order_id      | int     |
--| order_date    | date    |
--| item_id       | int     |
--| buyer_id      | int     |
--| seller_id     | int     |
--+---------------+---------+
--order_id is the primary key of this table.
--item_id is a foreign key to the Items table.
--buyer_id and seller_id are foreign keys to the Users table.
--
--
--Table: Items
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| item_id       | int     |
--| item_brand    | varchar |
--+---------------+---------+
--item_id is the primary key of this table.
--
--
--Write an SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019.
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
--Users table:
--+---------+------------+----------------+
--| user_id | join_date  | favorite_brand |
--+---------+------------+----------------+
--| 1       | 2018-01-01 | Lenovo         |
--| 2       | 2018-02-09 | Samsung        |
--| 3       | 2018-01-19 | LG             |
--| 4       | 2018-05-21 | HP             |
--+---------+------------+----------------+
--Orders table:
--+----------+------------+---------+----------+-----------+
--| order_id | order_date | item_id | buyer_id | seller_id |
--+----------+------------+---------+----------+-----------+
--| 1        | 2019-08-01 | 4       | 1        | 2         |
--| 2        | 2018-08-02 | 2       | 1        | 3         |
--| 3        | 2019-08-03 | 3       | 2        | 3         |
--| 4        | 2018-08-04 | 1       | 4        | 2         |
--| 5        | 2018-08-04 | 1       | 3        | 4         |
--| 6        | 2019-08-05 | 2       | 2        | 4         |
--+----------+------------+---------+----------+-----------+
--Items table:
--+---------+------------+
--| item_id | item_brand |
--+---------+------------+
--| 1       | Samsung    |
--| 2       | Lenovo     |
--| 3       | LG         |
--| 4       | HP         |
--+---------+------------+
--Output:
--+-----------+------------+----------------+
--| buyer_id  | join_date  | orders_in_2019 |
--+-----------+------------+----------------+
--| 1         | 2018-01-01 | 1              |
--| 2         | 2018-02-09 | 2              |
--| 3         | 2018-01-19 | 0              |
--| 4         | 2018-05-21 | 0              |
--+-----------+------------+----------------+

with temp as (
    select
        buyer_id,
        count(order_id) as order_count
    from
        orders
    where
        left(order_date,4) = '2019'
    group by
        buyer_id
    )
select
    user_id as buyer_id,
    join_date,
    ifnull(t.order_count,0) as orders_in_2019
from
    Users u left join temp t
on
    u.user_id = t.buyer_id;


--1164. Product Price at a Given Date
--Medium
--
--301
--
--83
--
--Add to List
--
--Share
--SQL Schema
--Table: Products
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| product_id    | int     |
--| new_price     | int     |
--| change_date   | date    |
--+---------------+---------+
--(product_id, change_date) is the primary key of this table.
--Each row of this table indicates that the price of some product was changed to a new price at some date.
--
--
--Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
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
--Products table:
--+------------+-----------+-------------+
--| product_id | new_price | change_date |
--+------------+-----------+-------------+
--| 1          | 20        | 2019-08-14  |
--| 2          | 50        | 2019-08-14  |
--| 1          | 30        | 2019-08-15  |
--| 1          | 35        | 2019-08-16  |
--| 2          | 65        | 2019-08-17  |
--| 3          | 20        | 2019-08-18  |
--+------------+-----------+-------------+
--Output:
--+------------+-------+
--| product_id | price |
--+------------+-------+
--| 2          | 50    |
--| 1          | 35    |
--| 3          | 10    |
--+------------+-------+

with cte as
(
select
     product_id,
     new_price ,
    row_number() over (partition by product_id order by change_date desc) as rnk
from
    Products
where
    change_date <= '2019-08-16'
)
select
    a.product_id,
    coalesce(c.new_price,10) as price
from
    (select distinct product_id from Products) a left join cte c
on
    a.product_id = c.product_id
and
    c.rnk = 1;

--1174. Immediate Food Delivery II
--Medium
--
--100
--
--50
--
--Add to List
--
--Share
--SQL Schema
--Table: Delivery
--
--+-----------------------------+---------+
--| Column Name                 | Type    |
--+-----------------------------+---------+
--| delivery_id                 | int     |
--| customer_id                 | int     |
--| order_date                  | date    |
--| customer_pref_delivery_date | date    |
--+-----------------------------+---------+
--delivery_id is the primary key of this table.
--The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
--
--
--If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.
--
--The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.
--
--Write an SQL query to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Delivery table:
--+-------------+-------------+------------+-----------------------------+
--| delivery_id | customer_id | order_date | customer_pref_delivery_date |
--+-------------+-------------+------------+-----------------------------+
--| 1           | 1           | 2019-08-01 | 2019-08-02                  |
--| 2           | 2           | 2019-08-02 | 2019-08-02                  |
--| 3           | 1           | 2019-08-11 | 2019-08-12                  |
--| 4           | 3           | 2019-08-24 | 2019-08-24                  |
--| 5           | 3           | 2019-08-21 | 2019-08-22                  |
--| 6           | 2           | 2019-08-11 | 2019-08-13                  |
--| 7           | 4           | 2019-08-09 | 2019-08-09                  |
--+-------------+-------------+------------+-----------------------------+
--Output:
--+----------------------+
--| immediate_percentage |
--+----------------------+
--| 50.00                |
--+----------------------+
--Explanation:
--The customer id 1 has a first order with delivery id 1 and it is scheduled.
--The customer id 2 has a first order with delivery id 2 and it is immediate.
--The customer id 3 has a first order with delivery id 5 and it is scheduled.
--The customer id 4 has a first order with delivery id 7 and it is immediate.
--Hence, half the customers have immediate first orders.

# Write your MySQL query statement below
with cte as
(
select
    customer_id,
    order_date ,
    customer_pref_delivery_date ,
    rank() over(partition by customer_id order by order_date) as rnk
from
    Delivery
)
select
    round((sum(if(order_date=customer_pref_delivery_date,1,0))/count(order_date))*100,2) as immediate_percentage
from
    cte
where
    rnk = 1;

--1193. Monthly Transactions I
--Medium
--
--142
--
--22
--
--Add to List
--
--Share
--SQL Schema
--Table: Transactions
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| country       | varchar |
--| state         | enum    |
--| amount        | int     |
--| trans_date    | date    |
--+---------------+---------+
--id is the primary key of this table.
--The table has information about incoming transactions.
--The state column is an enum of type ["approved", "declined"].
--
--
--Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.
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
--Transactions table:
--+------+---------+----------+--------+------------+
--| id   | country | state    | amount | trans_date |
--+------+---------+----------+--------+------------+
--| 121  | US      | approved | 1000   | 2018-12-18 |
--| 122  | US      | declined | 2000   | 2018-12-19 |
--| 123  | US      | approved | 2000   | 2019-01-01 |
--| 124  | DE      | approved | 2000   | 2019-01-07 |
--+------+---------+----------+--------+------------+
--Output:
--+----------+---------+-------------+----------------+--------------------+-----------------------+
--| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
--+----------+---------+-------------+----------------+--------------------+-----------------------+
--| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
--| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
--| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
--+----------+---------+-------------+----------------+--------------------+-----------------------+

select
    distinct left(trans_date,7) as month
    ,country
    ,count(id) over (partition by left(trans_date,7),country) as trans_count
    ,sum(if(state='approved',1,0)) over (partition by left(trans_date,7),country) as approved_count
    ,sum(amount) over (partition by left(trans_date,7),country) as trans_total_amount
    ,sum(if(state='approved',amount,0)) over (partition by left(trans_date,7),country) as approved_total_amount
from
    Transactions;

--1204. Last Person to Fit in the Bus
--Medium
--
--219
--
--19
--
--Add to List
--
--Share
--SQL Schema
--Table: Queue
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| person_id   | int     |
--| person_name | varchar |
--| weight      | int     |
--| turn        | int     |
--+-------------+---------+
--person_id is the primary key column for this table.
--This table has the information about all people waiting for a bus.
--The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
--turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
--weight is the weight of the person in kilograms.
--
--
--There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.
--
--Write an SQL query to find the person_name of the last person that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Queue table:
--+-----------+-------------+--------+------+
--| person_id | person_name | weight | turn |
--+-----------+-------------+--------+------+
--| 5         | Alice       | 250    | 1    |
--| 4         | Bob         | 175    | 5    |
--| 3         | Alex        | 350    | 2    |
--| 6         | John Cena   | 400    | 3    |
--| 1         | Winston     | 500    | 6    |
--| 2         | Marie       | 200    | 4    |
--+-----------+-------------+--------+------+
--Output:
--+-------------+
--| person_name |
--+-------------+
--| John Cena   |
--+-------------+
--Explanation: The folowing table is ordered by the turn for simplicity.
--+------+----+-----------+--------+--------------+
--| Turn | ID | Name      | Weight | Total Weight |
--+------+----+-----------+--------+--------------+
--| 1    | 5  | Alice     | 250    | 250          |
--| 2    | 3  | Alex      | 350    | 600          |
--| 3    | 6  | John Cena | 400    | 1000         | (last person to board)
--| 4    | 2  | Marie     | 200    | 1200         | (cannot board)
--| 5    | 4  | Bob       | 175    | ___          |
--| 6    | 1  | Winston   | 500    | ___          |
--+------+----+-----------+--------+--------------+

with cte as
(
select
    person_name
    ,sum(weight) over (order by turn) as weight
from
    Queue
    )
, cte1 as
(
select
    person_name,
    weight
from
    cte
where
    weight <= 1000
order by
    2 desc
limit 1
)
select person_name from cte1;
--1205. Monthly Transactions II
--Medium
--
--118
--
--438
--
--Add to List
--
--Share
--SQL Schema
--Table: Transactions
--
--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| id             | int     |
--| country        | varchar |
--| state          | enum    |
--| amount         | int     |
--| trans_date     | date    |
--+----------------+---------+
--id is the primary key of this table.
--The table has information about incoming transactions.
--The state column is an enum of type ["approved", "declined"].
--Table: Chargebacks
--
--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| trans_id       | int     |
--| trans_date     | date    |
--+----------------+---------+
--Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
--trans_id is a foreign key to the id column of Transactions table.
--Each chargeback corresponds to a transaction made previously even if they were not approved.
--
--
--Write an SQL query to find for each month and country: the number of approved transactions and their total amount, the number of chargebacks, and their total amount.
--
--Note: In your query, given the month and country, ignore rows with all zeros.
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
--Transactions table:
--+-----+---------+----------+--------+------------+
--| id  | country | state    | amount | trans_date |
--+-----+---------+----------+--------+------------+
--| 101 | US      | approved | 1000   | 2019-05-18 |
--| 102 | US      | declined | 2000   | 2019-05-19 |
--| 103 | US      | approved | 3000   | 2019-06-10 |
--| 104 | US      | declined | 4000   | 2019-06-13 |
--| 105 | US      | approved | 5000   | 2019-06-15 |
--+-----+---------+----------+--------+------------+
--Chargebacks table:
--+----------+------------+
--| trans_id | trans_date |
--+----------+------------+
--| 102      | 2019-05-29 |
--| 101      | 2019-06-30 |
--| 105      | 2019-09-18 |
--+----------+------------+
--Output:
--+---------+---------+----------------+-----------------+------------------+-------------------+
--| month   | country | approved_count | approved_amount | chargeback_count | chargeback_amount |
--+---------+---------+----------------+-----------------+------------------+-------------------+
--| 2019-05 | US      | 1              | 1000            | 1                | 2000              |
--| 2019-06 | US      | 2              | 8000            | 1                | 1000              |
--| 2019-09 | US      | 0              | 0               | 1                | 5000              |
--+---------+---------+----------------+-----------------+------------------+-------------------+

WITH table1 AS (
    SELECT
       substring(trans_date,1,7) AS month,
       country,
       count(state) AS approved_count,
       sum(amount) AS approved_amount,
       0 AS chargeback_count,
       0 AS chargeback_amount
    FROM Transactions
    WHERE state = 'approved'
    GROUP BY month, country
    UNION
    SELECT
        substring(c.trans_date,1,7) AS month,
        t.country AS country,
        0 AS approved_count,
        0 AS approved_amount,
        count(c.trans_id) AS chargeback_count,
        sum(t.amount) AS chargeback_amount
    FROM Chargebacks c
    LEFT JOIN Transactions t
    ON c.trans_id = t.id
    GROUP BY month, country
)
SELECT
    month,
    country,
    sum(approved_count) AS approved_count,
    sum(approved_amount) AS approved_amount,
    sum(chargeback_count) AS chargeback_count,
    sum(chargeback_amount) AS chargeback_amount
FROM table1
GROUP BY month, country;

--1212. Team Scores in Football Tournament
--Medium
--
--250
--
--21
--
--Add to List
--
--Share
--SQL Schema
--Table: Teams
--
--+---------------+----------+
--| Column Name   | Type     |
--+---------------+----------+
--| team_id       | int      |
--| team_name     | varchar  |
--+---------------+----------+
--team_id is the primary key of this table.
--Each row of this table represents a single football team.
--
--
--Table: Matches
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| match_id      | int     |
--| host_team     | int     |
--| guest_team    | int     |
--| host_goals    | int     |
--| guest_goals   | int     |
--+---------------+---------+
--match_id is the primary key of this table.
--Each row is a record of a finished match between two different teams.
--Teams host_team and guest_team are represented by their IDs in the Teams table (team_id), and they scored host_goals and guest_goals goals, respectively.
--
--
--You would like to compute the scores of all teams after all matches. Points are awarded as follows:
--A team receives three points if they win a match (i.e., Scored more goals than the opponent team).
--A team receives one point if they draw a match (i.e., Scored the same number of goals as the opponent team).
--A team receives no points if they lose a match (i.e., Scored fewer goals than the opponent team).
--Write an SQL query that selects the team_id, team_name and num_points of each team in the tournament after all described matches.
--
--Return the result table ordered by num_points in decreasing order. In case of a tie, order the records by team_id in increasing order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Teams table:
--+-----------+--------------+
--| team_id   | team_name    |
--+-----------+--------------+
--| 10        | Leetcode FC  |
--| 20        | NewYork FC   |
--| 30        | Atlanta FC   |
--| 40        | Chicago FC   |
--| 50        | Toronto FC   |
--+-----------+--------------+
--Matches table:
--+------------+--------------+---------------+-------------+--------------+
--| match_id   | host_team    | guest_team    | host_goals  | guest_goals  |
--+------------+--------------+---------------+-------------+--------------+
--| 1          | 10           | 20            | 3           | 0            |
--| 2          | 30           | 10            | 2           | 2            |
--| 3          | 10           | 50            | 5           | 1            |
--| 4          | 20           | 30            | 1           | 0            |
--| 5          | 50           | 30            | 1           | 0            |
--+------------+--------------+---------------+-------------+--------------+
--Output:
--+------------+--------------+---------------+
--| team_id    | team_name    | num_points    |
--+------------+--------------+---------------+
--| 10         | Leetcode FC  | 7             |
--| 20         | NewYork FC   | 3             |
--| 50         | Toronto FC   | 3             |
--| 30         | Atlanta FC   | 1             |
--| 40         | Chicago FC   | 0             |
--+------------+--------------+---------------+

# Write your MySQL query statement below

with cte as
(
select
    t.team_id,
    t.team_name,
    sum(case when host_goals > guest_goals then 3
        when host_goals = guest_goals then 1
        else 0 end) as num_points
from
   Teams  t left join  Matches  m
on
    t.team_id = m.host_team
group by
    1,2
UNION ALL
select
    t.team_id,
    t.team_name,
    sum(case when host_goals < guest_goals then 3
        when host_goals = guest_goals then 1
        else 0 end) as num_points
from
   Teams  t left join  Matches  m
on
    t.team_id = m.guest_team
group by
    1,2
)
select
    team_id,
    team_name,
    sum(num_points) as num_points
from
    cte
group by
    1,2
order by
    3 desc,1;

--1264. Page Recommendations
--Medium
--
--178
--
--15
--
--Add to List
--
--Share
--SQL Schema
--Table: Friendship
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| user1_id      | int     |
--| user2_id      | int     |
--+---------------+---------+
--(user1_id, user2_id) is the primary key for this table.
--Each row of this table indicates that there is a friendship relation between user1_id and user2_id.
--
--
--Table: Likes
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| user_id     | int     |
--| page_id     | int     |
--+-------------+---------+
--(user_id, page_id) is the primary key for this table.
--Each row of this table indicates that user_id likes page_id.
--
--
--Write an SQL query to recommend pages to the user with user_id = 1 using the pages that your friends liked. It should not recommend pages you already liked.
--
--Return result table in any order without duplicates.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Friendship table:
--+----------+----------+
--| user1_id | user2_id |
--+----------+----------+
--| 1        | 2        |
--| 1        | 3        |
--| 1        | 4        |
--| 2        | 3        |
--| 2        | 4        |
--| 2        | 5        |
--| 6        | 1        |
--+----------+----------+
--Likes table:
--+---------+---------+
--| user_id | page_id |
--+---------+---------+
--| 1       | 88      |
--| 2       | 23      |
--| 3       | 24      |
--| 4       | 56      |
--| 5       | 11      |
--| 6       | 33      |
--| 2       | 77      |
--| 3       | 77      |
--| 6       | 88      |
--+---------+---------+
--Output:
--+------------------+
--| recommended_page |
--+------------------+
--| 23               |
--| 24               |
--| 56               |
--| 33               |
--| 77               |
--+------------------+
--Explanation:
--User one is friend with users 2, 3, 4 and 6.
--Suggested pages are 23 from user 2, 24 from user 3, 56 from user 3 and 33 from user 6.
--Page 77 is suggested from both user 2 and user 3.
--Page 88 is not suggested because user 1 already likes it.

with cte as
(
select
     distinct page_id as recommended_page
from
    Friendship f1 join Likes l
on
    f1.user1_id = l.user_id
and
    f1.user2_id = 1
UNION
select
     distinct page_id as recommended_page
from
    Friendship f2 join Likes l
on
    f2.user2_id = l.user_id
and
    f2.user1_id = 1
) select recommended_page from cte
where recommended_page not in (select page_id from Likes where user_id = 1);

--1270. All People Report to the Given Manager
--Medium
--
--319
--
--23
--
--Add to List
--
--Share
--SQL Schema
--Table: Employees
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| employee_id   | int     |
--| employee_name | varchar |
--| manager_id    | int     |
--+---------------+---------+
--employee_id is the primary key for this table.
--Each row of this table indicates that the employee with ID employee_id and name employee_name reports his work to his/her direct manager with manager_id
--The head of the company is the employee with employee_id = 1.
--
--
--Write an SQL query to find employee_id of all employees that directly or indirectly report their work to the head of the company.
--
--The indirect relation between managers will not exceed three managers as the company is small.
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
--Employees table:
--+-------------+---------------+------------+
--| employee_id | employee_name | manager_id |
--+-------------+---------------+------------+
--| 1           | Boss          | 1          |
--| 3           | Alice         | 3          |
--| 2           | Bob           | 1          |
--| 4           | Daniel        | 2          |
--| 7           | Luis          | 4          |
--| 8           | Jhon          | 3          |
--| 9           | Angela        | 8          |
--| 77          | Robert        | 1          |
--+-------------+---------------+------------+
--Output:
--+-------------+
--| employee_id |
--+-------------+
--| 2           |
--| 77          |
--| 4           |
--| 7           |
--+-------------+
--Explanation:
--The head of the company is the employee with employee_id 1.
--The employees with employee_id 2 and 77 report their work directly to the head of the company.
--The employee with employee_id 4 reports their work indirectly to the head of the company 4 --> 2 --> 1.
--The employee with employee_id 7 reports their work indirectly to the head of the company 7 --> 4 --> 2 --> 1.
--The employees with employee_id 3, 8, and 9 do not report their work to the head of the company directly or indirectly.

-- Recursion:
with recursive CTE_EMP as
(
select employee_id from Employees  e
where employee_id=1
    union
select e.employee_id from CTE_EMP ce
join Employees e
on ce.employee_id=e.manager_id
 )
select * from CTE_EMP
where employee_id!=1;

-- Normal:

select
    e1.employee_id
from
    Employees e1 join Employees e2
on
    e1.manager_id = e2.employee_id and
    e1.employee_id != 1 # to exclude the head of the company from the list
join
    Employees e3
on
    e2.manager_id = e3.employee_id
join
    Employees e4
on
    e3.manager_id = e4.employee_id

where
    (e1.manager_id = 1 )
or
    e2.manager_id = 1
or
    e3.manager_id = 1
;


--1285. Find the Start and End Number of Continuous Ranges
--Medium
--
--407
--
--27
--
--Add to List
--
--Share
--SQL Schema
--Table: Logs
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| log_id        | int     |
--+---------------+---------+
--log_id is the primary key for this table.
--Each row of this table contains the ID in a log Table.
--
--
--Write an SQL query to find the start and end number of continuous ranges in the table Logs.
--
--Return the result table ordered by start_id.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Logs table:
--+------------+
--| log_id     |
--+------------+
--| 1          |
--| 2          |
--| 3          |
--| 7          |
--| 8          |
--| 10         |
--+------------+
--Output:
--+------------+--------------+
--| start_id   | end_id       |
--+------------+--------------+
--| 1          | 3            |
--| 7          | 8            |
--| 10         | 10           |
--+------------+--------------+
--Explanation:
--The result table should contain all ranges in table Logs.
--From 1 to 3 is contained in the table.
--From 4 to 6 is missing in the table
--From 7 to 8 is contained in the table.
--Number 9 is missing from the table.
--Number 10 is contained in the table.

# Write your MySQL query statement below

with cte as
(
select
    log_id,
    (log_id - row_number() over(order by log_id)) as rnk
from
   Logs
)
select
    min(log_id) as start_id   ,
    max(log_id) as end_id
from
    cte
group by
    rnk;

--1308. Running Total for Different Genders
--Medium
--
--163
--
--48
--
--Add to List
--
--Share
--SQL Schema
--Table: Scores
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| player_name   | varchar |
--| gender        | varchar |
--| day           | date    |
--| score_points  | int     |
--+---------------+---------+
--(gender, day) is the primary key for this table.
--A competition is held between the female team and the male team.
--Each row of this table indicates that a player_name and with gender has scored score_point in someday.
--Gender is 'F' if the player is in the female team and 'M' if the player is in the male team.
--
--
--Write an SQL query to find the total score for each gender on each day.
--
--Return the result table ordered by gender and day in ascending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Scores table:
--+-------------+--------+------------+--------------+
--| player_name | gender | day        | score_points |
--+-------------+--------+------------+--------------+
--| Aron        | F      | 2020-01-01 | 17           |
--| Alice       | F      | 2020-01-07 | 23           |
--| Bajrang     | M      | 2020-01-07 | 7            |
--| Khali       | M      | 2019-12-25 | 11           |
--| Slaman      | M      | 2019-12-30 | 13           |
--| Joe         | M      | 2019-12-31 | 3            |
--| Jose        | M      | 2019-12-18 | 2            |
--| Priya       | F      | 2019-12-31 | 23           |
--| Priyanka    | F      | 2019-12-30 | 17           |
--+-------------+--------+------------+--------------+
--Output:
--+--------+------------+-------+
--| gender | day        | total |
--+--------+------------+-------+
--| F      | 2019-12-30 | 17    |
--| F      | 2019-12-31 | 40    |
--| F      | 2020-01-01 | 57    |
--| F      | 2020-01-07 | 80    |
--| M      | 2019-12-18 | 2     |
--| M      | 2019-12-25 | 13    |
--| M      | 2019-12-30 | 26    |
--| M      | 2019-12-31 | 29    |
--| M      | 2020-01-07 | 36    |
--+--------+------------+-------+
--Explanation:
--For the female team:
--The first day is 2019-12-30, Priyanka scored 17 points and the total score for the team is 17.
--The second day is 2019-12-31, Priya scored 23 points and the total score for the team is 40.
--The third day is 2020-01-01, Aron scored 17 points and the total score for the team is 57.
--The fourth day is 2020-01-07, Alice scored 23 points and the total score for the team is 80.
--
--For the male team:
--The first day is 2019-12-18, Jose scored 2 points and the total score for the team is 2.
--The second day is 2019-12-25, Khali scored 11 points and the total score for the team is 13.
--The third day is 2019-12-30, Slaman scored 13 points and the total score for the team is 26.
--The fourth day is 2019-12-31, Joe scored 3 points and the total score for the team is 29.
--The fifth day is 2020-01-07, Bajrang scored 7 points and the total score for the team is 36.


select
   gender
   ,day
   ,sum(score_points) over (partition by gender order by day) as total
from
    Scores
order by
    1,2;

--1321. Restaurant Growth
--Medium
--
--303
--
--49
--
--Add to List
--
--Share
--SQL Schema
--Table: Customer
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| customer_id   | int     |
--| name          | varchar |
--| visited_on    | date    |
--| amount        | int     |
--+---------------+---------+
--(customer_id, visited_on) is the primary key for this table.
--This table contains data about customer transactions in a restaurant.
--visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
--amount is the total paid by a customer.
--
--
--You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).
--
--Write an SQL query to compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.
--
--Return result table ordered by visited_on in ascending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Customer table:
--+-------------+--------------+--------------+-------------+
--| customer_id | name         | visited_on   | amount      |
--+-------------+--------------+--------------+-------------+
--| 1           | Jhon         | 2019-01-01   | 100         |
--| 2           | Daniel       | 2019-01-02   | 110         |
--| 3           | Jade         | 2019-01-03   | 120         |
--| 4           | Khaled       | 2019-01-04   | 130         |
--| 5           | Winston      | 2019-01-05   | 110         |
--| 6           | Elvis        | 2019-01-06   | 140         |
--| 7           | Anna         | 2019-01-07   | 150         |
--| 8           | Maria        | 2019-01-08   | 80          |
--| 9           | Jaze         | 2019-01-09   | 110         |
--| 1           | Jhon         | 2019-01-10   | 130         |
--| 3           | Jade         | 2019-01-10   | 150         |
--+-------------+--------------+--------------+-------------+
--Output:
--+--------------+--------------+----------------+
--| visited_on   | amount       | average_amount |
--+--------------+--------------+----------------+
--| 2019-01-07   | 860          | 122.86         |
--| 2019-01-08   | 840          | 120            |
--| 2019-01-09   | 840          | 120            |
--| 2019-01-10   | 1000         | 142.86         |
--+--------------+--------------+----------------+
--Explanation:
--1st moving average from 2019-01-01 to 2019-01-07 has an average_amount of (100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
--2nd moving average from 2019-01-02 to 2019-01-08 has an average_amount of (110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
--3rd moving average from 2019-01-03 to 2019-01-09 has an average_amount of (120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
--4th moving average from 2019-01-04 to 2019-01-10 has an average_amount of (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86

with temp1 as (
        select
            visited_on,
            sum(amount) as amount
        from
            Customer
        group by
            visited_on
),
temp2 as (
    select
        visited_on,
        sum(amount) over (order by visited_on rows between 6 PRECEDING and current row) as amount,
        dense_rank() over (order by visited_on) as rnk
from
    temp1
)

select
    visited_on,
    amount,
    round(amount/7,2) as average_amount
from
    temp2
where rnk > 6;

select
    b.visited_on,
    b.amount,
    b.average_amount
from
(
        select
            a.visited_on,
            sum(a.amount) over (order by a.visited_on rows between 6 preceding and current row) as amount,
            round(avg(a.amount) over (order by a.visited_on rows between 6 preceding and current row),2) as average_amount ,
            LAG(a.visited_on,6) over (order by visited_on) as start_date
        from

        (
                            select
                            visited_on,
                            sum(amount) as amount
                        from
                            Customer
                        group by
                            visited_on
        ) a
    ) b
where
    b.start_date is not null;

--1341. Movie Rating
--Medium
--
--120
--
--73
--
--Add to List
--
--Share
--SQL Schema
--Table: Movies
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| movie_id      | int     |
--| title         | varchar |
--+---------------+---------+
--movie_id is the primary key for this table.
--title is the name of the movie.
--
--
--Table: Users
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| user_id       | int     |
--| name          | varchar |
--+---------------+---------+
--user_id is the primary key for this table.
--
--
--Table: MovieRating
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| movie_id      | int     |
--| user_id       | int     |
--| rating        | int     |
--| created_at    | date    |
--+---------------+---------+
--(movie_id, user_id) is the primary key for this table.
--This table contains the rating of a movie by a user in their review.
--created_at is the user's review date.
--
--
--Write an SQL query to:
--
--Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
--Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Movies table:
--+-------------+--------------+
--| movie_id    |  title       |
--+-------------+--------------+
--| 1           | Avengers     |
--| 2           | Frozen 2     |
--| 3           | Joker        |
--+-------------+--------------+
--Users table:
--+-------------+--------------+
--| user_id     |  name        |
--+-------------+--------------+
--| 1           | Daniel       |
--| 2           | Monica       |
--| 3           | Maria        |
--| 4           | James        |
--+-------------+--------------+
--MovieRating table:
--+-------------+--------------+--------------+-------------+
--| movie_id    | user_id      | rating       | created_at  |
--+-------------+--------------+--------------+-------------+
--| 1           | 1            | 3            | 2020-01-12  |
--| 1           | 2            | 4            | 2020-02-11  |
--| 1           | 3            | 2            | 2020-02-12  |
--| 1           | 4            | 1            | 2020-01-01  |
--| 2           | 1            | 5            | 2020-02-17  |
--| 2           | 2            | 2            | 2020-02-01  |
--| 2           | 3            | 2            | 2020-03-01  |
--| 3           | 1            | 3            | 2020-02-22  |
--| 3           | 2            | 4            | 2020-02-25  |
--+-------------+--------------+--------------+-------------+
--Output:
--+--------------+
--| results      |
--+--------------+
--| Daniel       |
--| Frozen 2     |
--+--------------+
--Explanation:
--Daniel and Monica have rated 3 movies ("Avengers", "Frozen 2" and "Joker") but Daniel is smaller lexicographically.
--Frozen 2 and Joker have a rating average of 3.5 in February but Frozen 2 is smaller lexicographically.

with cte as
(
select
    u.name as results
    ,rank() over (order by count(distinct movie_id) desc,u.name) as rnk
from
    MovieRating mr join Users u
on
    mr.user_id = u.user_id
group by
    1
UNION
select
    m.title as results
    ,rank() over (order by avg(rating)desc,m.title) as rnk
from
    MovieRating mr join Movies m
on
    mr.movie_id = m.movie_id
where
    left(created_at  ,7) = '2020-02'
group by
    1
)
select results from cte where rnk = 1;


--1355. Activity Participants
--Medium
--
--107
--
--40
--
--Add to List
--
--Share
--SQL Schema
--Table: Friends
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| name          | varchar |
--| activity      | varchar |
--+---------------+---------+
--id is the id of the friend and primary key for this table.
--name is the name of the friend.
--activity is the name of the activity which the friend takes part in.
--
--
--Table: Activities
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| name          | varchar |
--+---------------+---------+
--id is the primary key for this table.
--name is the name of the activity.
--
--
--Write an SQL query to find the names of all the activities with neither the maximum nor the minimum number of participants.
--
--Each activity in the Activities table is performed by any person in the table Friends.
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
--Friends table:
--+------+--------------+---------------+
--| id   | name         | activity      |
--+------+--------------+---------------+
--| 1    | Jonathan D.  | Eating        |
--| 2    | Jade W.      | Singing       |
--| 3    | Victor J.    | Singing       |
--| 4    | Elvis Q.     | Eating        |
--| 5    | Daniel A.    | Eating        |
--| 6    | Bob B.       | Horse Riding  |
--+------+--------------+---------------+
--Activities table:
--+------+--------------+
--| id   | name         |
--+------+--------------+
--| 1    | Eating       |
--| 2    | Singing      |
--| 3    | Horse Riding |
--+------+--------------+
--Output:
--+--------------+
--| activity     |
--+--------------+
--| Singing      |
--+--------------+
--Explanation:
--Eating activity is performed by 3 friends, maximum number of participants, (Jonathan D. , Elvis Q. and Daniel A.)
--Horse Riding activity is performed by 1 friend, minimum number of participants, (Bob B.)
--Singing is performed by 2 friends (Victor J. and Jade W.)

# Write your MySQL query statement below
with cte as
(
select
    activity      ,
    count(activity) as cnt,
    dense_rank() over(order by count(activity)) as highest,
    dense_rank() over(order by count(activity) desc) as lowest
from
    Friends
group by
    activity
)
select
    activity
from
    cte
where
    highest != 1
and
    lowest != 1;

--1393. Capital Gain/Loss
--Medium
--
--393
--
--30
--
--Add to List
--
--Share
--SQL Schema
--Table: Stocks
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| stock_name    | varchar |
--| operation     | enum    |
--| operation_day | int     |
--| price         | int     |
--+---------------+---------+
--(stock_name, operation_day) is the primary key for this table.
--The operation column is an ENUM of type ('Sell', 'Buy')
--Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
--It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day. It is also guaranteed that each 'Buy' operation for a stock has a corresponding 'Sell' operation in an upcoming day.
--
--
--Write an SQL query to report the Capital gain/loss for each stock.
--
--The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
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
--Stocks table:
--+---------------+-----------+---------------+--------+
--| stock_name    | operation | operation_day | price  |
--+---------------+-----------+---------------+--------+
--| Leetcode      | Buy       | 1             | 1000   |
--| Corona Masks  | Buy       | 2             | 10     |
--| Leetcode      | Sell      | 5             | 9000   |
--| Handbags      | Buy       | 17            | 30000  |
--| Corona Masks  | Sell      | 3             | 1010   |
--| Corona Masks  | Buy       | 4             | 1000   |
--| Corona Masks  | Sell      | 5             | 500    |
--| Corona Masks  | Buy       | 6             | 1000   |
--| Handbags      | Sell      | 29            | 7000   |
--| Corona Masks  | Sell      | 10            | 10000  |
--+---------------+-----------+---------------+--------+
--Output:
--+---------------+-------------------+
--| stock_name    | capital_gain_loss |
--+---------------+-------------------+
--| Corona Masks  | 9500              |
--| Leetcode      | 8000              |
--| Handbags      | -23000            |
--+---------------+-------------------+
--Explanation:
--Leetcode stock was bought at day 1 for 1000$ and was sold at day 5 for 9000$. Capital gain = 9000 - 1000 = 8000$.
--Handbags stock was bought at day 17 for 30000$ and was sold at day 29 for 7000$. Capital loss = 7000 - 30000 = -23000$.
--Corona Masks stock was bought at day 1 for 10$ and was sold at day 3 for 1010$. It was bought again at day 4 for 1000$ and was sold at day 5 for 500$. At last, it was bought at day 6 for 1000$ and was sold at day 10 for 10000$. Capital gain/loss is the sum of capital gains/losses for each ('Buy' --> 'Sell') operation = (1010 - 10) + (500 - 1000) + (10000 - 1000) = 1000 - 500 + 9000 = 9500$.

select
    stock_name
    ,sum(case when operation = 'Buy' then -price else price end) as capital_gain_loss
from
    Stocks
group by
    1;

--1398. Customers Who Bought Products A and B but Not C
--Medium
--
--205
--
--10
--
--Add to List
--
--Share
--SQL Schema
--Table: Customers
--
--+---------------------+---------+
--| Column Name         | Type    |
--+---------------------+---------+
--| customer_id         | int     |
--| customer_name       | varchar |
--+---------------------+---------+
--customer_id is the primary key for this table.
--customer_name is the name of the customer.
--
--
--Table: Orders
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| order_id      | int     |
--| customer_id   | int     |
--| product_name  | varchar |
--+---------------+---------+
--order_id is the primary key for this table.
--customer_id is the id of the customer who bought the product "product_name".
--
--
--Write an SQL query to report the customer_id and customer_name of customers who bought products "A", "B" but did not buy the product "C" since we want to recommend them to purchase this product.
--
--Return the result table ordered by customer_id.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Customers table:
--+-------------+---------------+
--| customer_id | customer_name |
--+-------------+---------------+
--| 1           | Daniel        |
--| 2           | Diana         |
--| 3           | Elizabeth     |
--| 4           | Jhon          |
--+-------------+---------------+
--Orders table:
--+------------+--------------+---------------+
--| order_id   | customer_id  | product_name  |
--+------------+--------------+---------------+
--| 10         |     1        |     A         |
--| 20         |     1        |     B         |
--| 30         |     1        |     D         |
--| 40         |     1        |     C         |
--| 50         |     2        |     A         |
--| 60         |     3        |     A         |
--| 70         |     3        |     B         |
--| 80         |     3        |     D         |
--| 90         |     4        |     C         |
--+------------+--------------+---------------+
--Output:
--+-------------+---------------+
--| customer_id | customer_name |
--+-------------+---------------+
--| 3           | Elizabeth     |
--+-------------+---------------+
--Explanation: Only the customer_id with id 3 bought the product A and B but not the product C.

# Write your MySQL query statement below

with cte as
(
select
   distinct c.customer_id,
   c.customer_name,
   sum(if(o.product_name = 'A',1,0)) as A,
   sum(if(o.product_name = 'B',1,0)) as B,
   sum(if(o.product_name = 'C',1,0)) as C
from
    Customers c join Orders o
on
    c.customer_id = o.customer_id
group by
    c.customer_id
)
select
    customer_id,
    customer_name
from
    cte
where
    A > 0
and
    B > 0
and
    C = 0;

--1440. Evaluate Boolean Expression
--Medium
--
--154
--
--10
--
--Add to List
--
--Share
--SQL Schema
--Table Variables:
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| name          | varchar |
--| value         | int     |
--+---------------+---------+
--name is the primary key for this table.
--This table contains the stored variables and their values.
--
--
--Table Expressions:
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| left_operand  | varchar |
--| operator      | enum    |
--| right_operand | varchar |
--+---------------+---------+
--(left_operand, operator, right_operand) is the primary key for this table.
--This table contains a boolean expression that should be evaluated.
--operator is an enum that takes one of the values ('<', '>', '=')
--The values of left_operand and right_operand are guaranteed to be in the Variables table.
--
--
--Write an SQL query to evaluate the boolean expressions in Expressions table.
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
--Variables table:
--+------+-------+
--| name | value |
--+------+-------+
--| x    | 66    |
--| y    | 77    |
--+------+-------+
--Expressions table:
--+--------------+----------+---------------+
--| left_operand | operator | right_operand |
--+--------------+----------+---------------+
--| x            | >        | y             |
--| x            | <        | y             |
--| x            | =        | y             |
--| y            | >        | x             |
--| y            | <        | x             |
--| x            | =        | x             |
--+--------------+----------+---------------+
--Output:
--+--------------+----------+---------------+-------+
--| left_operand | operator | right_operand | value |
--+--------------+----------+---------------+-------+
--| x            | >        | y             | false |
--| x            | <        | y             | true  |
--| x            | =        | y             | false |
--| y            | >        | x             | true  |
--| y            | <        | x             | false |
--| x            | =        | x             | true  |
--+--------------+----------+---------------+-------+
--Explanation:
--As shown, you need to find the value of each boolean expression in the table using the variables table.

# Write your MySQL query statement below

select
    left_operand,
    operator ,
    right_operand ,
    # v1.name,
    # v1.value,
    # v2.name,
    # v2.value,
    case when operator = '=' and v1.value = v2.value then "true"
        when operator = '>' and v1.value > v2.value then "true"
        when operator = '<' and v1.value < v2.value then "true"
        else "false" end as value
from
    Expressions e join Variables v1
on
    e.left_operand = v1.name
join
    Variables v2
on
   e.right_operand  = v2.name  ;


--1445. Apples & Oranges
--Medium
--
--178
--
--17
--
--Add to List
--
--Share
--SQL Schema
--Table: Sales
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| sale_date     | date    |
--| fruit         | enum    |
--| sold_num      | int     |
--+---------------+---------+
--(sale_date, fruit) is the primary key for this table.
--This table contains the sales of "apples" and "oranges" sold each day.
--
--
--Write an SQL query to report the difference between the number of apples and oranges sold each day.
--
--Return the result table ordered by sale_date.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Sales table:
--+------------+------------+-------------+
--| sale_date  | fruit      | sold_num    |
--+------------+------------+-------------+
--| 2020-05-01 | apples     | 10          |
--| 2020-05-01 | oranges    | 8           |
--| 2020-05-02 | apples     | 15          |
--| 2020-05-02 | oranges    | 15          |
--| 2020-05-03 | apples     | 20          |
--| 2020-05-03 | oranges    | 0           |
--| 2020-05-04 | apples     | 15          |
--| 2020-05-04 | oranges    | 16          |
--+------------+------------+-------------+
--Output:
--+------------+--------------+
--| sale_date  | diff         |
--+------------+--------------+
--| 2020-05-01 | 2            |
--| 2020-05-02 | 0            |
--| 2020-05-03 | 20           |
--| 2020-05-04 | -1           |
--+------------+--------------+
--Explanation:
--Day 2020-05-01, 10 apples and 8 oranges were sold (Difference  10 - 8 = 2).
--Day 2020-05-02, 15 apples and 15 oranges were sold (Difference 15 - 15 = 0).
--Day 2020-05-03, 20 apples and 0 oranges were sold (Difference 20 - 0 = 20).
--Day 2020-05-04, 15 apples and 16 oranges were sold (Difference 15 - 16 = -1).

select
    sale_date,
    sum(case when fruit = 'apples' then sold_num end) - sum(case when fruit = 'oranges' then sold_num end) as diff

from
    Sales
group by
    1;

--1454. Active Users
--Medium
--
--319
--
--30
--
--Add to List
--
--Share
--SQL Schema
--Table: Accounts
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| name          | varchar |
--+---------------+---------+
--id is the primary key for this table.
--This table contains the account id and the user name of each account.
--
--
--Table: Logins
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| login_date    | date    |
--+---------------+---------+
--There is no primary key for this table, it may contain duplicates.
--This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
--
--
--Active users are those who logged in to their accounts for five or more consecutive days.
--
--Write an SQL query to find the id and the name of active users.
--
--Return the result table ordered by id.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Accounts table:
--+----+----------+
--| id | name     |
--+----+----------+
--| 1  | Winston  |
--| 7  | Jonathan |
--+----+----------+
--Logins table:
--+----+------------+
--| id | login_date |
--+----+------------+
--| 7  | 2020-05-30 |
--| 1  | 2020-05-30 |
--| 7  | 2020-05-31 |
--| 7  | 2020-06-01 |
--| 7  | 2020-06-02 |
--| 7  | 2020-06-02 |
--| 7  | 2020-06-03 |
--| 1  | 2020-06-07 |
--| 7  | 2020-06-10 |
--+----+------------+
--Output:
--+----+----------+
--| id | name     |
--+----+----------+
--| 7  | Jonathan |
--+----+----------+
--Explanation:
--User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
--User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, so, Jonathan is an active user.

# Write your MySQL query statement below
SELECT
    DISTINCT t1.id,
    a.name
FROM Logins t1
JOIN Logins t2
ON t1.id = t2.id
AND DATEDIFF(t2.login_date, t1.login_date) BETWEEN 1 AND 4
JOIN Accounts a
ON t1.id = a.id
GROUP BY t1.id, t1.login_date
HAVING COUNT(DISTINCT t2.login_date) = 4;

--1468. Calculate Salaries
--Medium
--
--92
--
--16
--
--Add to List
--
--Share
--SQL Schema
--Table Salaries:
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| company_id    | int     |
--| employee_id   | int     |
--| employee_name | varchar |
--| salary        | int     |
--+---------------+---------+
--(company_id, employee_id) is the primary key for this table.
--This table contains the company id, the id, the name, and the salary for an employee.
--
--
--Write an SQL query to find the salaries of the employees after applying taxes. Round the salary to the nearest integer.
--
--The tax rate is calculated for each company based on the following criteria:
--
--0% If the max salary of any employee in the company is less than $1000.
--24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
--49% If the max salary of any employee in the company is greater than $10000.
--Return the result table in any order.
--
--The query result format is in the following example.

with comp_sal as
(
select
    company_id
    ,max(salary) as max_sal
from
    Salaries
group by
    1
)
select
    s.company_id
    ,employee_id
    ,employee_name
    ,round(case when max_sal < 1000 then salary
        when (max_sal>= 1000 and max_sal <= 10000) then (salary - salary*24/100)
        when max_sal> 10000  then (salary - salary*49/100)
    end) as salary
from
    Salaries s join comp_sal c
on
    s.company_id = c.company_id ;

--1501. Countries You Can Safely Invest In
--Medium
--
--222
--
--32
--
--Add to List
--
--Share
--SQL Schema
--Table Person:
--
--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| id             | int     |
--| name           | varchar |
--| phone_number   | varchar |
--+----------------+---------+
--id is the primary key for this table.
--Each row of this table contains the name of a person and their phone number.
--Phone number will be in the form 'xxx-yyyyyyy' where xxx is the country code (3 characters) and yyyyyyy is the phone number (7 characters) where x and y are digits. Both can contain leading zeros.
--
--
--Table Country:
--
--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| name           | varchar |
--| country_code   | varchar |
--+----------------+---------+
--country_code is the primary key for this table.
--Each row of this table contains the country name and its code. country_code will be in the form 'xxx' where x is digits.
--
--
--Table Calls:
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| caller_id   | int  |
--| callee_id   | int  |
--| duration    | int  |
--+-------------+------+
--There is no primary key for this table, it may contain duplicates.
--Each row of this table contains the caller id, callee id and the duration of the call in minutes. caller_id != callee_id
--
--
--A telecommunications company wants to invest in new countries. The company intends to invest in the countries where the average call duration of the calls in this country is strictly greater than the global average call duration.
--
--Write an SQL query to find the countries where this company can invest.
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
--Person table:
--+----+----------+--------------+
--| id | name     | phone_number |
--+----+----------+--------------+
--| 3  | Jonathan | 051-1234567  |
--| 12 | Elvis    | 051-7654321  |
--| 1  | Moncef   | 212-1234567  |
--| 2  | Maroua   | 212-6523651  |
--| 7  | Meir     | 972-1234567  |
--| 9  | Rachel   | 972-0011100  |
--+----+----------+--------------+
--Country table:
--+----------+--------------+
--| name     | country_code |
--+----------+--------------+
--| Peru     | 051          |
--| Israel   | 972          |
--| Morocco  | 212          |
--| Germany  | 049          |
--| Ethiopia | 251          |
--+----------+--------------+
--Calls table:
--+-----------+-----------+----------+
--| caller_id | callee_id | duration |
--+-----------+-----------+----------+
--| 1         | 9         | 33       |
--| 2         | 9         | 4        |
--| 1         | 2         | 59       |
--| 3         | 12        | 102      |
--| 3         | 12        | 330      |
--| 12        | 3         | 5        |
--| 7         | 9         | 13       |
--| 7         | 1         | 3        |
--| 9         | 7         | 1        |
--| 1         | 7         | 7        |
--+-----------+-----------+----------+
--Output:
--+----------+
--| country  |
--+----------+
--| Peru     |
--+----------+
--Explanation:
--The average call duration for Peru is (102 + 102 + 330 + 330 + 5 + 5) / 6 = 145.666667
--The average call duration for Israel is (33 + 4 + 13 + 13 + 3 + 1 + 1 + 7) / 8 = 9.37500
--The average call duration for Morocco is (33 + 4 + 59 + 59 + 3 + 7) / 6 = 27.5000
--Global call duration average = (2 * (33 + 4 + 59 + 102 + 330 + 5 + 13 + 3 + 1 + 7)) / 20 = 55.70000
--Since Peru is the only country where the average call duration is greater than the global average, it is the only recommended country.

with person_country as
(
    select
        p.id as p_id,
        c.name as cntry_name
    from
        Person  p join Country c
    on
        left(p.phone_number,3) = c.country_code
),
average as
(
    select
        avg(duration)
    from
        Calls
),
duration as
(
    select
        caller_id,
        sum(call_duration) as call_duration,
        sum(call_count) as call_count
    from
        (
            select
           caller_id ,
            sum(duration) as call_duration,
            count(caller_id) as call_count
        from
           Calls
        group by
            caller_id
        UNION
        select
           callee_id as caller_id,
            sum(duration) as call_duration,
            count(callee_id) as call_count
        from
           Calls
        group by
            callee_id
            )a
        group by a.caller_id
)
select cntry_name as country from
(select
    cntry_name,
    sum(call_duration)/sum(call_count) as cntry_avg

from
    person_country p join duration d
on
   p.p_id = d.caller_id
group by
    cntry_name
having
    sum(call_duration)/sum(call_count) > (select * from average)
    )a;

--1532. The Most Recent Three Orders
--Medium
--
--105
--
--9
--
--Add to List
--
--Share
--SQL Schema
--Table: Customers
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| customer_id   | int     |
--| name          | varchar |
--+---------------+---------+
--customer_id is the primary key for this table.
--This table contains information about customers.
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
--| cost          | int     |
--+---------------+---------+
--order_id is the primary key for this table.
--This table contains information about the orders made by customer_id.
--Each customer has one order per day.
--
--
--Write an SQL query to find the most recent three orders of each user. If a user ordered less than three orders, return all of their orders.
--
--Return the result table ordered by customer_name in ascending order and in case of a tie by the customer_id in ascending order. If there is still a tie, order them by order_date in descending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Customers table:
--+-------------+-----------+
--| customer_id | name      |
--+-------------+-----------+
--| 1           | Winston   |
--| 2           | Jonathan  |
--| 3           | Annabelle |
--| 4           | Marwan    |
--| 5           | Khaled    |
--+-------------+-----------+
--Orders table:
--+----------+------------+-------------+------+
--| order_id | order_date | customer_id | cost |
--+----------+------------+-------------+------+
--| 1        | 2020-07-31 | 1           | 30   |
--| 2        | 2020-07-30 | 2           | 40   |
--| 3        | 2020-07-31 | 3           | 70   |
--| 4        | 2020-07-29 | 4           | 100  |
--| 5        | 2020-06-10 | 1           | 1010 |
--| 6        | 2020-08-01 | 2           | 102  |
--| 7        | 2020-08-01 | 3           | 111  |
--| 8        | 2020-08-03 | 1           | 99   |
--| 9        | 2020-08-07 | 2           | 32   |
--| 10       | 2020-07-15 | 1           | 2    |
--+----------+------------+-------------+------+
--Output:
--+---------------+-------------+----------+------------+
--| customer_name | customer_id | order_id | order_date |
--+---------------+-------------+----------+------------+
--| Annabelle     | 3           | 7        | 2020-08-01 |
--| Annabelle     | 3           | 3        | 2020-07-31 |
--| Jonathan      | 2           | 9        | 2020-08-07 |
--| Jonathan      | 2           | 6        | 2020-08-01 |
--| Jonathan      | 2           | 2        | 2020-07-30 |
--| Marwan        | 4           | 4        | 2020-07-29 |
--| Winston       | 1           | 8        | 2020-08-03 |
--| Winston       | 1           | 1        | 2020-07-31 |
--| Winston       | 1           | 10       | 2020-07-15 |
--+---------------+-------------+----------+------------+
--Explanation:
--Winston has 4 orders, we discard the order of "2020-06-10" because it is the oldest order.
--Annabelle has only 2 orders, we return them.
--Jonathan has exactly 3 orders.
--Marwan ordered only one time.
--We sort the result table by customer_name in ascending order, by customer_id in ascending order, and by order_date in descending order in case of a tie.

with order_details as
(
select
    name as customer_name
    ,c.customer_id
    ,order_id
    ,order_date
    ,dense_rank() over (partition by c.customer_id order by order_date desc) as rnk
from
    Customers c join Orders o
on
    c.customer_id = o.customer_id
)
select
    customer_name
    ,customer_id
    ,order_id
    ,order_date
from
    order_details
where
    rnk <= 3
order by
    1,2,4 desc;

--1596. The Most Frequently Ordered Products for Each Customer
--Medium
--
--176
--
--15
--
--Add to List
--
--Share
--SQL Schema
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
--No customer will order the same product more than once in a single day.
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
--This table contains information about the products.
--
--
--Write an SQL query to find the most frequently ordered product(s) for each customer.
--
--The result table should have the product_id and product_name for each customer_id who ordered at least one order.
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
--Customers table:
--+-------------+-------+
--| customer_id | name  |
--+-------------+-------+
--| 1           | Alice |
--| 2           | Bob   |
--| 3           | Tom   |
--| 4           | Jerry |
--| 5           | John  |
--+-------------+-------+
--Orders table:
--+----------+------------+-------------+------------+
--| order_id | order_date | customer_id | product_id |
--+----------+------------+-------------+------------+
--| 1        | 2020-07-31 | 1           | 1          |
--| 2        | 2020-07-30 | 2           | 2          |
--| 3        | 2020-08-29 | 3           | 3          |
--| 4        | 2020-07-29 | 4           | 1          |
--| 5        | 2020-06-10 | 1           | 2          |
--| 6        | 2020-08-01 | 2           | 1          |
--| 7        | 2020-08-01 | 3           | 3          |
--| 8        | 2020-08-03 | 1           | 2          |
--| 9        | 2020-08-07 | 2           | 3          |
--| 10       | 2020-07-15 | 1           | 2          |
--+----------+------------+-------------+------------+
--Products table:
--+------------+--------------+-------+
--| product_id | product_name | price |
--+------------+--------------+-------+
--| 1          | keyboard     | 120   |
--| 2          | mouse        | 80    |
--| 3          | screen       | 600   |
--| 4          | hard disk    | 450   |
--+------------+--------------+-------+
--Output:
--+-------------+------------+--------------+
--| customer_id | product_id | product_name |
--+-------------+------------+--------------+
--| 1           | 2          | mouse        |
--| 2           | 1          | keyboard     |
--| 2           | 2          | mouse        |
--| 2           | 3          | screen       |
--| 3           | 3          | screen       |
--| 4           | 1          | keyboard     |
--+-------------+------------+--------------+
--Explanation:
--Alice (customer 1) ordered the mouse three times and the keyboard one time, so the mouse is the most frequently ordered product for them.
--Bob (customer 2) ordered the keyboard, the mouse, and the screen one time, so those are the most frequently ordered products for them.
--Tom (customer 3) only ordered the screen (two times), so that is the most frequently ordered product for them.
--Jerry (customer 4) only ordered the keyboard (one time), so that is the most frequently ordered product for them.
--John (customer 5) did not order anything, so we do not include them in the result table.

with temp as
    (select
        customer_id,
        product_id,
        dense_rank() over (partition by customer_id order by count(customer_id) desc) as rnk
    from
        Orders
    group by
        customer_id,
        product_id

    )

select
    t.customer_id,
    p.product_id,
    p.product_name
from
    temp t join Products p
on
    t.product_id = p.product_id
where t.rnk = 1;

--1613. Find the Missing IDs
--Medium
--
--158
--
--22
--
--Add to List
--
--Share
--SQL Schema
--Table: Customers
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| customer_id   | int     |
--| customer_name | varchar |
--+---------------+---------+
--customer_id is the primary key for this table.
--Each row of this table contains the name and the id customer.
--
--
--Write an SQL query to find the missing customer IDs. The missing IDs are ones that are not in the Customers table but are in the range between 1 and the maximum customer_id present in the table.
--
--Notice that the maximum customer_id will not exceed 100.
--
--Return the result table ordered by ids in ascending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Customers table:
--+-------------+---------------+
--| customer_id | customer_name |
--+-------------+---------------+
--| 1           | Alice         |
--| 4           | Bob           |
--| 5           | Charlie       |
--+-------------+---------------+
--Output:
--+-----+
--| ids |
--+-----+
--| 2   |
--| 3   |
--+-----+
--Explanation:
--The maximum customer_id present in the table is 5, so in the range [1,5], IDs 2 and 3 are missing from the table.

-- Recursive:
# Write your MySQL query statement below

with recursive cte as
(
    select 1 as val
    UNION ALL
    select
        val+1
    from
        cte
    where
        val < (select max(customer_id) from Customers )
)
select
 val as ids
from
    cte c1 left join Customers c2
on
    c1.val = c2.customer_id
where
   c2.customer_id is null ;

-- Need to understand why this solution is getting wrong for some use cases:
-- #########################################################################

with cte as
(
select
    customer_id ,
    row_number() over(order by customer_id) as rnk

from
    Customers
)
# select * from cte

select
    case when customer_id = rnk then 1 else rnk end as ids
from
    cte
where
	case when customer_id = rnk then 1 else rnk end is not null;

--1699. Number of Calls Between Two Persons
--Medium
--
--173
--
--11
--
--Add to List
--
--Share
--SQL Schema
--Table: Calls
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| from_id     | int     |
--| to_id       | int     |
--| duration    | int     |
--+-------------+---------+
--This table does not have a primary key, it may contain duplicates.
--This table contains the duration of a phone call between from_id and to_id.
--from_id != to_id
--
--
--Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.
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
--Calls table:
--+---------+-------+----------+
--| from_id | to_id | duration |
--+---------+-------+----------+
--| 1       | 2     | 59       |
--| 2       | 1     | 11       |
--| 1       | 3     | 20       |
--| 3       | 4     | 100      |
--| 3       | 4     | 200      |
--| 3       | 4     | 200      |
--| 4       | 3     | 499      |
--+---------+-------+----------+
--Output:
--+---------+---------+------------+----------------+
--| person1 | person2 | call_count | total_duration |
--+---------+---------+------------+----------------+
--| 1       | 2       | 2          | 70             |
--| 1       | 3       | 1          | 20             |
--| 3       | 4       | 4          | 999            |
--+---------+---------+------------+----------------+
--Explanation:
--Users 1 and 2 had 2 calls and the total duration is 70 (59 + 11).
--Users 1 and 3 had 1 call and the total duration is 20.
--Users 3 and 4 had 4 calls and the total duration is 999 (100 + 200 + 200 + 499).

# Write your MySQL query statement below

with cte as
(
select
    case when from_id < to_id then from_id  else to_id end as person1 ,
    case when from_id > to_id then from_id  else to_id end as person2 ,
    duration
from
    Calls
)
select
    person1,
    person2,
    count(duration) as call_count,
    sum(duration) as total_duration
from
    cte
group by
    1,2;

--1709. Biggest Window Between Visits
--Medium
--
--134
--
--8
--
--Add to List
--
--Share
--SQL Schema
--Table: UserVisits
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| user_id     | int  |
--| visit_date  | date |
--+-------------+------+
--This table does not have a primary key.
--This table contains logs of the dates that users visited a certain retailer.
--
--
--Assume today's date is '2021-1-1'.
--
--Write an SQL query that will, for each user_id, find out the largest window of days between each visit and the one right after it (or today if you are considering the last visit).
--
--Return the result table ordered by user_id.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--UserVisits table:
--+---------+------------+
--| user_id | visit_date |
--+---------+------------+
--| 1       | 2020-11-28 |
--| 1       | 2020-10-20 |
--| 1       | 2020-12-3  |
--| 2       | 2020-10-5  |
--| 2       | 2020-12-9  |
--| 3       | 2020-11-11 |
--+---------+------------+
--Output:
--+---------+---------------+
--| user_id | biggest_window|
--+---------+---------------+
--| 1       | 39            |
--| 2       | 65            |
--| 3       | 51            |
--+---------+---------------+
--Explanation:
--For the first user, the windows in question are between dates:
--    - 2020-10-20 and 2020-11-28 with a total of 39 days.
--    - 2020-11-28 and 2020-12-3 with a total of 5 days.
--    - 2020-12-3 and 2021-1-1 with a total of 29 days.
--Making the biggest window the one with 39 days.
--For the second user, the windows in question are between dates:
--    - 2020-10-5 and 2020-12-9 with a total of 65 days.
--    - 2020-12-9 and 2021-1-1 with a total of 23 days.
--Making the biggest window the one with 65 days.
--For the third user, the only window in question is between dates 2020-11-11 and 2021-1-1 with a total of 51 days.

# Write your MySQL query statement below

with cte as
(
select
    user_id,
    visit_date ,
    ifnull(lead(visit_date) over(partition by user_id order by visit_date),'2021-1-1') as next_vixit
from
    UserVisits
)
select
    user_id,
   max(datediff(next_vixit,visit_date)) as biggest_window
from
    cte
group by
    1;

--1715. Count Apples and Oranges
--Medium
--
--62
--
--8
--
--Add to List
--
--Share
--SQL Schema
--Table: Boxes
--
--+--------------+------+
--| Column Name  | Type |
--+--------------+------+
--| box_id       | int  |
--| chest_id     | int  |
--| apple_count  | int  |
--| orange_count | int  |
--+--------------+------+
--box_id is the primary key for this table.
--chest_id is a foreign key of the chests table.
--This table contains information about the boxes and the number of oranges and apples they have. Each box may include a chest, which also can contain oranges and apples.
--
--
--Table: Chests
--
--+--------------+------+
--| Column Name  | Type |
--+--------------+------+
--| chest_id     | int  |
--| apple_count  | int  |
--| orange_count | int  |
--+--------------+------+
--chest_id is the primary key for this table.
--This table contains information about the chests and the corresponding number of oranges and apples they have.
--
--
--Write an SQL query to count the number of apples and oranges in all the boxes. If a box contains a chest, you should also include the number of apples and oranges it has.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Boxes table:
--+--------+----------+-------------+--------------+
--| box_id | chest_id | apple_count | orange_count |
--+--------+----------+-------------+--------------+
--| 2      | null     | 6           | 15           |
--| 18     | 14       | 4           | 15           |
--| 19     | 3        | 8           | 4            |
--| 12     | 2        | 19          | 20           |
--| 20     | 6        | 12          | 9            |
--| 8      | 6        | 9           | 9            |
--| 3      | 14       | 16          | 7            |
--+--------+----------+-------------+--------------+
--Chests table:
--+----------+-------------+--------------+
--| chest_id | apple_count | orange_count |
--+----------+-------------+--------------+
--| 6        | 5           | 6            |
--| 14       | 20          | 10           |
--| 2        | 8           | 8            |
--| 3        | 19          | 4            |
--| 16       | 19          | 19           |
--+----------+-------------+--------------+
--Output:
--+-------------+--------------+
--| apple_count | orange_count |
--+-------------+--------------+
--| 151         | 123          |
--+-------------+--------------+
--Explanation:
--box 2 has 6 apples and 15 oranges.
--box 18 has 4 + 20 (from the chest) = 24 apples and 15 + 10 (from the chest) = 25 oranges.
--box 19 has 8 + 19 (from the chest) = 27 apples and 4 + 4 (from the chest) = 8 oranges.
--box 12 has 19 + 8 (from the chest) = 27 apples and 20 + 8 (from the chest) = 28 oranges.
--box 20 has 12 + 5 (from the chest) = 17 apples and 9 + 6 (from the chest) = 15 oranges.
--box 8 has 9 + 5 (from the chest) = 14 apples and 9 + 6 (from the chest) = 15 oranges.
--box 3 has 16 + 20 (from the chest) = 36 apples and 7 + 10 (from the chest) = 17 oranges.
--Total number of apples = 6 + 24 + 27 + 27 + 17 + 14 + 36 = 151
--Total number of oranges = 15 + 25 + 8 + 28 + 15 + 15 + 17 = 123

# Write your MySQL query statement below

select
    sum(b.apple_count+ifnull(c.apple_count,0)) as apple_count,
    sum(b.orange_count+ifnull(c.orange_count,0)) as orange_count
from
    Boxes b left join Chests c
on
    b.chest_id = c.chest_id;