--1384. Total Sales Amount by Year
--Table: Product
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| product_id    | int     |
--| product_name  | varchar |
--+---------------+---------+
--product_id is the primary key for this table.
--product_name is the name of the product.
--
--
--Table: Sales
--
--+---------------------+---------+
--| Column Name         | Type    |
--+---------------------+---------+
--| product_id          | int     |
--| period_start        | date    |
--| period_end          | date    |
--| average_daily_sales | int     |
--+---------------------+---------+
--product_id is the primary key for this table.
--period_start and period_end indicate the start and end date for the sales period, and both dates are inclusive.
--The average_daily_sales column holds the average daily sales amount of the items for the period.
--The dates of the sales years are between 2018 to 2020.
--
--
--Write an SQL query to report the total sales amount of each item for each year, with corresponding product_name, product_id, product_name, and report_year.
--
--Return the result table ordered by product_id and report_year.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Product table:
--+------------+--------------+
--| product_id | product_name |
--+------------+--------------+
--| 1          | LC Phone     |
--| 2          | LC T-Shirt   |
--| 3          | LC Keychain  |
--+------------+--------------+
--Sales table:
--+------------+--------------+-------------+---------------------+
--| product_id | period_start | period_end  | average_daily_sales |
--+------------+--------------+-------------+---------------------+
--| 1          | 2019-01-25   | 2019-02-28  | 100                 |
--| 2          | 2018-12-01   | 2020-01-01  | 10                  |
--| 3          | 2019-12-01   | 2020-01-31  | 1                   |
--+------------+--------------+-------------+---------------------+
--Output:
--+------------+--------------+-------------+--------------+
--| product_id | product_name | report_year | total_amount |
--+------------+--------------+-------------+--------------+
--| 1          | LC Phone     |    2019     | 3500         |
--| 2          | LC T-Shirt   |    2018     | 310          |
--| 2          | LC T-Shirt   |    2019     | 3650         |
--| 2          | LC T-Shirt   |    2020     | 10           |
--| 3          | LC Keychain  |    2019     | 31           |
--| 3          | LC Keychain  |    2020     | 31           |
--+------------+--------------+-------------+--------------+
--Explanation:
--LC Phone was sold for the period of 2019-01-25 to 2019-02-28, and there are 35 days for this period. Total amount 35*100 = 3500.
--LC T-shirt was sold for the period of 2018-12-01 to 2020-01-01, and there are 31, 365, 1 days for years 2018, 2019 and 2020 respectively.
--LC Keychain was sold for the period of 2019-12-01 to 2020-01-31, and there are 31, 31 days for years 2019 and 2020 respectively.

--# Write your MySQL query statement below

--# Inner Query Method

select
    t.product_id ,
    p.product_name ,
    t.report_year ,
    t.total_amount
From
    (
        select
        product_id,
        '2018' as report_year ,
        average_daily_sales *(datediff(LEAST(period_end,'2018-12-31'),GREATEST(period_start,'2018-01-01'))+1) as total_amount
    from Sales
        where YEAR(period_start) = '2018' OR YEAR(period_end) = '2018'

    UNION ALL

        select
        product_id,
        '2019' as report_year ,
        average_daily_sales *(datediff(LEAST(period_end,'2019-12-31'),GREATEST(period_start,'2019-01-01'))+1) as total_amount
    from Sales
        where YEAR(period_start) <= '2019' and YEAR(period_end) >= '2019'

    UNION ALL

        select
        product_id,
        '2020' as report_year ,
        average_daily_sales *(datediff(LEAST(period_end,'2020-12-31'),GREATEST(period_start,'2020-01-01'))+1) as total_amount
    from Sales
        where YEAR(period_start) = '2020' OR YEAR(period_end) = '2020'
    ) t
join
    Product p
on
    t.product_id = p.product_id

-- # Recursive CTE:

with recursive cte as (
select product_id, period_start, period_end, year(period_start) as start_yr, average_daily_sales  from sales
    union all
select product_id, period_start, period_end, start_yr+1 as yr, average_daily_sales  from cte
    where start_yr<year(period_end)
)
select c.product_id,p.product_name, cast(start_yr as char) as report_year,
sum(case
    when year(c.period_start)=start_yr and year(c.period_end)=start_yr then average_daily_sales*(datediff(c.period_end,c.period_start )+1)
    when year(c.period_start)=start_yr and start_yr<year(c.period_end) then average_daily_sales*(datediff(cast(concat(start_yr,'-12-31')as date),c.period_start)+1)
    when year(c.period_start)<start_yr and start_yr<year(c.period_end) then average_daily_sales* (datediff(cast(concat(start_yr,'-12-31')as date),cast(concat(start_yr,'-01-01')as date))+1)
    when year(c.period_start)<start_yr and start_yr=year(c.period_end) then average_daily_sales* (datediff(period_end,cast(concat(start_yr, '-01-01')as date))+1)
end) as total_amount
    from cte c
    join Product p
    on p.product_id =c.product_id
group by 1,2,3
order by 1,3

--1194. Tournament Winners
--Table: Players
--
--+-------------+-------+
--| Column Name | Type  |
--+-------------+-------+
--| player_id   | int   |
--| group_id    | int   |
--+-------------+-------+
--player_id is the primary key of this table.
--Each row of this table indicates the group of each player.
--Table: Matches
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| match_id      | int     |
--| first_player  | int     |
--| second_player | int     |
--| first_score   | int     |
--| second_score  | int     |
--+---------------+---------+
--match_id is the primary key of this table.
--Each row is a record of a match, first_player and second_player contain the player_id of each match.
--first_score and second_score contain the number of points of the first_player and second_player respectively.
--You may assume that, in each match, players belong to the same group.
--
--
--The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowest player_id wins.
--
--Write an SQL query to find the winner in each group.
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
--Players table:
--+-----------+------------+
--| player_id | group_id   |
--+-----------+------------+
--| 15        | 1          |
--| 25        | 1          |
--| 30        | 1          |
--| 45        | 1          |
--| 10        | 2          |
--| 35        | 2          |
--| 50        | 2          |
--| 20        | 3          |
--| 40        | 3          |
--+-----------+------------+
--Matches table:
--+------------+--------------+---------------+-------------+--------------+
--| match_id   | first_player | second_player | first_score | second_score |
--+------------+--------------+---------------+-------------+--------------+
--| 1          | 15           | 45            | 3           | 0            |
--| 2          | 30           | 25            | 1           | 2            |
--| 3          | 30           | 15            | 2           | 0            |
--| 4          | 40           | 20            | 5           | 2            |
--| 5          | 35           | 50            | 1           | 1            |
--+------------+--------------+---------------+-------------+--------------+
--Output:
--+-----------+------------+
--| group_id  | player_id  |
--+-----------+------------+
--| 1         | 15         |
--| 2         | 35         |
--| 3         | 40         |
--+-----------+------------+
# Write your MySQL query statement below
WITH subtotals AS (
SELECT
    first_player AS player ,
    sum(first_score) AS total_score
FROM Matches
GROUP BY 1
UNION ALL
SELECT
    second_player AS player,
    sum(second_score) AS total_score
FROM Matches
GROUP BY 1
),

total_scores AS (
SELECT
    p.group_id,
    p.player_id,
    sum(s.total_score) AS total_score
FROM Players p
LEFT JOIN subtotals s
ON p.player_id = s.player
GROUP BY 1, 2
)

SELECT
    group_id,
    player_id
FROM (
    SELECT
        group_id,
        player_id,
        RANK() OVER (PARTITION BY group_id ORDER BY total_score DESC, player_id) AS ranking
    FROM total_scores
) rankings
WHERE ranking = 1

--185. Department Top Three Salaries
--able: Employee
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
--A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
--
--Write an SQL query to find the employees who are high earners in each of the departments.
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
--| 1  | Joe   | 85000  | 1            |
--| 2  | Henry | 80000  | 2            |
--| 3  | Sam   | 60000  | 2            |
--| 4  | Max   | 90000  | 1            |
--| 5  | Janet | 69000  | 1            |
--| 6  | Randy | 85000  | 1            |
--| 7  | Will  | 70000  | 1            |
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
--| IT         | Max      | 90000  |
--| IT         | Joe      | 85000  |
--| IT         | Randy    | 85000  |
--| IT         | Will     | 70000  |
--| Sales      | Henry    | 80000  |
--| Sales      | Sam      | 60000  |
--+------------+----------+--------+
--Explanation:
--In the IT department:
--- Max earns the highest unique salary
--- Both Randy and Joe earn the second-highest unique salary
--- Will earns the third-highest unique salary
--
--In the Sales department:
--- Henry earns the highest salary
--- Sam earns the second-highest salary
--- There is no third-highest salary as there are only two employees

# Write your MySQL query statement below
with cte as
(
select
    d.name as Department ,
    e.name  as Employee ,
    salary  as Salary,
    dense_rank() over (partition by d.name order by salary desc) as rnk
from
    Department d join Employee e
on
    d.id = e.departmentId
    )
select
    Department,
    Employee,
    Salary
from
    cte
where
    rnk <=3

--615. Average Salary: Departments VS Company
--Hard
--
--193
--
--65
--
--Add to List
--
--Share
--SQL Schema
--Table: Salary
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| id          | int  |
--| employee_id | int  |
--| amount      | int  |
--| pay_date    | date |
--+-------------+------+
--id is the primary key column for this table.
--Each row of this table indicates the salary of an employee in one month.
--employee_id is a foreign key from the Employee table.
--
--
--Table: Employee
--
--+---------------+------+
--| Column Name   | Type |
--+---------------+------+
--| employee_id   | int  |
--| department_id | int  |
--+---------------+------+
--employee_id is the primary key column for this table.
--Each row of this table indicates the department of an employee.
--
--
--Write an SQL query to report the comparison result (higher/lower/same) of the average salary of employees in a department to the company's average salary.
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
--Salary table:
--+----+-------------+--------+------------+
--| id | employee_id | amount | pay_date   |
--+----+-------------+--------+------------+
--| 1  | 1           | 9000   | 2017/03/31 |
--| 2  | 2           | 6000   | 2017/03/31 |
--| 3  | 3           | 10000  | 2017/03/31 |
--| 4  | 1           | 7000   | 2017/02/28 |
--| 5  | 2           | 6000   | 2017/02/28 |
--| 6  | 3           | 8000   | 2017/02/28 |
--+----+-------------+--------+------------+
--Employee table:
--+-------------+---------------+
--| employee_id | department_id |
--+-------------+---------------+
--| 1           | 1             |
--| 2           | 2             |
--| 3           | 2             |
--+-------------+---------------+
--Output:
--+-----------+---------------+------------+
--| pay_month | department_id | comparison |
--+-----------+---------------+------------+
--| 2017-02   | 1             | same       |
--| 2017-03   | 1             | higher     |
--| 2017-02   | 2             | same       |
--| 2017-03   | 2             | lower      |
--+-----------+---------------+------------+
--Explanation:
--In March, the company's average salary is (9000+6000+10000)/3 = 8333.33...
--The average salary for department '1' is 9000, which is the salary of employee_id '1' since there is only one employee in this department. So the comparison result is 'higher' since 9000 > 8333.33 obviously.
--The average salary of department '2' is (6000 + 10000)/2 = 8000, which is the average of employee_id '2' and '3'. So the comparison result is 'lower' since 8000 < 8333.33.
--
--With he same formula for the average salary comparison in February, the result is 'same' since both the department '1' and '2' have the same average salary with the company, which is 7000.

# Write your MySQL query statement below
select
    a.pay_month,
    department_id,
    # com_avg,
    # dep_avg,
    case when com_avg = dep_avg then "same"
        when com_avg < dep_avg then "higher"
        else "lower" end as comparison
 From

(
    select
        left(pay_date,7) as pay_month,
        avg(amount) as com_avg
    from
        Salary
    group by
        1
) a right join

(
    select
        department_id,
        left(pay_date,7) as pay_month,
        avg(amount) as dep_avg
    from
        Salary s join Employee e
    on
        s.employee_id = e.employee_id
    group by
        1,2
) b
on a.pay_month = b.pay_month
order by 1,2

--
--1097. Game Play Analysis V
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
--The install date of a player is the first login day of that player.
--
--We define day one retention of some date x to be the number of players whose install date is x and they logged back in on the day right after x, divided by the number of players whose install date is x, rounded to 2 decimal places.
--
--Write an SQL query to report for each install date, the number of players that installed the game on that day, and the day one retention.
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
--| 1         | 2         | 2016-03-02 | 6            |
--| 2         | 3         | 2017-06-25 | 1            |
--| 3         | 1         | 2016-03-01 | 0            |
--| 3         | 4         | 2016-07-03 | 5            |
--+-----------+-----------+------------+--------------+
--Output:
--+------------+----------+----------------+
--| install_dt | installs | Day1_retention |
--+------------+----------+----------------+
--| 2016-03-01 | 2        | 0.50           |
--| 2017-06-25 | 1        | 0.00           |
--+------------+----------+----------------+
--Explanation:
--Player 1 and 3 installed the game on 2016-03-01 but only player 1 logged back in on 2016-03-02 so the day 1 retention of 2016-03-01 is 1 / 2 = 0.50
--Player 2 installed the game on 2017-06-25 but didn't log back in on 2017-06-26 so the day 1 retention of 2017-06-25 is 0 / 1 = 0.00

# Write your MySQL query statement below
with cte as
(
select
    player_id,
    min(event_date) as install_dt
from
    Activity
group by
    1
)
select
    install_dt,
    count(c.player_id) as installs,
    round(avg(case when a.event_date is not null then 1 else 0 end),2) as Day1_retention
from
    cte c left join Activity a
on
    c.player_id = a.player_id
and
    datediff(event_date,install_dt) = 1
group by
    1

