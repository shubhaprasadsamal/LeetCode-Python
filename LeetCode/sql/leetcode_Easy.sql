--2329. Product Sales Analysis V
--Easy
--
--8
--
--5
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
--| user_id     | int   |
--| quantity    | int   |
--+-------------+-------+
--sale_id is the primary key of this table.
--product_id is a foreign key to Product table.
--Each row of this table shows the ID of the product and the quantity purchased by a user.
--
--
--Table: Product
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| product_id  | int  |
--| price       | int  |
--+-------------+------+
--product_id is the primary key of this table.
--Each row of this table indicates the price of each product.
--
--
--Write an SQL query that reports the spending of each user.
--
--Return the resulting table ordered by spending in descending order. In case of a tie, order them by user_id in ascending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Sales table:
--+---------+------------+---------+----------+
--| sale_id | product_id | user_id | quantity |
--+---------+------------+---------+----------+
--| 1       | 1          | 101     | 10       |
--| 2       | 2          | 101     | 1        |
--| 3       | 3          | 102     | 3        |
--| 4       | 3          | 102     | 2        |
--| 5       | 2          | 103     | 3        |
--+---------+------------+---------+----------+
--Product table:
--+------------+-------+
--| product_id | price |
--+------------+-------+
--| 1          | 10    |
--| 2          | 25    |
--| 3          | 15    |
--+------------+-------+
--Output:
--+---------+----------+
--| user_id | spending |
--+---------+----------+
--| 101     | 125      |
--| 102     | 75       |
--| 103     | 75       |
--+---------+----------+
--Explanation:
--User 101 spent 10 * 10 + 1 * 25 = 125.
--User 102 spent 3 * 15 + 2 * 15 = 75.
--User 103 spent 3 * 25 = 75.
--Users 102 and 103 spent the same amount and we break the tie by their ID while user 101 is on the top.

# Write your MySQL query statement below

select
    user_id,
    sum(quantity * price) as spending

from
    Sales s join Product p
on
    s.product_id = p.product_id
group by
    1
order by
    2 desc,1;

--2339. All the Matches of the League
--Easy
--
--15
--
--2
--
--Add to List
--
--Share
--SQL Schema
--Table: Teams
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| team_name   | varchar |
--+-------------+---------+
--team_name is the primary key of this table.
--Each row of this table shows the name of a team.
--
--
--Write an SQL query that reports all the possible matches of the league. Note that every two teams play two matches with each other, with one team being the home_team once and the other time being the away_team.
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
--Teams table:
--+-------------+
--| team_name   |
--+-------------+
--| Leetcode FC |
--| Ahly SC     |
--| Real Madrid |
--+-------------+
--Output:
--+-------------+-------------+
--| home_team   | away_team   |
--+-------------+-------------+
--| Real Madrid | Leetcode FC |
--| Real Madrid | Ahly SC     |
--| Leetcode FC | Real Madrid |
--| Leetcode FC | Ahly SC     |
--| Ahly SC     | Real Madrid |
--| Ahly SC     | Leetcode FC |
--+-------------+-------------+
--Explanation: All the matches of the league are shown in the table.

# Write your MySQL query statement below
select
    t1.team_name  as home_team    ,
    t2.team_name   as away_team
from
    Teams  t1 join Teams t2
on
    t1.team_name    != t2.team_name   ;


--2356. Number of Unique Subjects Taught by Each Teacher
--Easy
--
--13
--
--4
--
--Add to List
--
--Share
--SQL Schema
--Table: Teacher
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| teacher_id  | int  |
--| subject_id  | int  |
--| dept_id     | int  |
--+-------------+------+
--(subject_id, dept_id) is the primary key for this table.
--Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id.
--
--
--Write an SQL query to report the number of unique subjects each teacher teaches in the university.
--
--Return the result table in any order.
--
--The query result format is shown in the following example.
--
--
--
--Example 1:
--
--Input:
--Teacher table:
--+------------+------------+---------+
--| teacher_id | subject_id | dept_id |
--+------------+------------+---------+
--| 1          | 2          | 3       |
--| 1          | 2          | 4       |
--| 1          | 3          | 3       |
--| 2          | 1          | 1       |
--| 2          | 2          | 1       |
--| 2          | 3          | 1       |
--| 2          | 4          | 1       |
--+------------+------------+---------+
--Output:
--+------------+-----+
--| teacher_id | cnt |
--+------------+-----+
--| 1          | 2   |
--| 2          | 4   |
--+------------+-----+
--Explanation:
--Teacher 1:
--  - They teach subject 2 in departments 3 and 4.
--  - They teach subject 3 in department 3.
--Teacher 2:
--  - They teach subject 1 in department 1.
--  - They teach subject 2 in department 1.
--  - They teach subject 3 in department 1.
--  - They teach subject 4 in department 1.

# Write your MySQL query statement below
select
    teacher_id ,
    count(distinct subject_id ) as cnt
from
    Teacher
group by
    1;

--2377. Sort the Olympic Table
--Easy
--
--12
--
--0
--
--Add to List
--
--Share
--SQL Schema
--Table: Olympic
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| country       | varchar |
--| gold_medals   | int     |
--| silver_medals | int     |
--| bronze_medals | int     |
--+---------------+---------+
--country is the primary key for this table.
--Each row in this table shows a country name and the number of gold, silver, and bronze medals it won in the Olympic games.
--
--
--The Olympic table is sorted according to the following rules:
--
--The country with more gold medals comes first.
--If there is a tie in the gold medals, the country with more silver medals comes first.
--If there is a tie in the silver medals, the country with more bronze medals comes first.
--If there is a tie in the bronze medals, the countries with the tie are sorted in ascending order lexicographically.
--Write an SQL query to sort the Olympic table
--
--The query result format is shown in the following example.
--
--
--
--Example 1:
--
--Input:
--Olympic table:
--+-------------+-------------+---------------+---------------+
--| country     | gold_medals | silver_medals | bronze_medals |
--+-------------+-------------+---------------+---------------+
--| China       | 10          | 10            | 20            |
--| South Sudan | 0           | 0             | 1             |
--| USA         | 10          | 10            | 20            |
--| Israel      | 2           | 2             | 3             |
--| Egypt       | 2           | 2             | 2             |
--+-------------+-------------+---------------+---------------+
--Output:
--+-------------+-------------+---------------+---------------+
--| country     | gold_medals | silver_medals | bronze_medals |
--+-------------+-------------+---------------+---------------+
--| China       | 10          | 10            | 20            |
--| USA         | 10          | 10            | 20            |
--| Israel      | 2           | 2             | 3             |
--| Egypt       | 2           | 2             | 2             |
--| South Sudan | 0           | 0             | 1             |
--+-------------+-------------+---------------+---------------+
--Explanation:
--The tie between China and USA is broken by their lexicographical names. Since "China" is lexicographically smaller than "USA", it comes first.
--Israel comes before Egypt because it has more bronze medals.

# Write your MySQL query statement below
select
    country     ,
    gold_medals ,
    silver_medals ,
    bronze_medals
from
    Olympic
order by
    2 desc, 3 desc, 4 desc, 1;
