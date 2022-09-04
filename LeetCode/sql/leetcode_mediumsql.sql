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