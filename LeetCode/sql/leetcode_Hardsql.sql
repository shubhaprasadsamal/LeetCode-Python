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

--1225. Report Contiguous Dates
--Table: Failed
--
--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| fail_date    | date    |
--+--------------+---------+
--fail_date is the primary key for this table.
--This table contains the days of failed tasks.
--
--
--Table: Succeeded
--
--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| success_date | date    |
--+--------------+---------+
--success_date is the primary key for this table.
--This table contains the days of succeeded tasks.
--
--
--A system is running one task every day. Every task is independent of the previous tasks. The tasks can fail or succeed.
--
--Write an SQL query to generate a report of period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.
--
--period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded. Interval of days are retrieved as start_date and end_date.
--
--Return the result table ordered by start_date.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Failed table:
--+-------------------+
--| fail_date         |
--+-------------------+
--| 2018-12-28        |
--| 2018-12-29        |
--| 2019-01-04        |
--| 2019-01-05        |
--+-------------------+
--Succeeded table:
--+-------------------+
--| success_date      |
--+-------------------+
--| 2018-12-30        |
--| 2018-12-31        |
--| 2019-01-01        |
--| 2019-01-02        |
--| 2019-01-03        |
--| 2019-01-06        |
--+-------------------+
--Output:
--+--------------+--------------+--------------+
--| period_state | start_date   | end_date     |
--+--------------+--------------+--------------+
--| succeeded    | 2019-01-01   | 2019-01-03   |
--| failed       | 2019-01-04   | 2019-01-05   |
--| succeeded    | 2019-01-06   | 2019-01-06   |
--+--------------+--------------+--------------+
--Explanation:
--The report ignored the system state in 2018 as we care about the system in the period 2019-01-01 to 2019-12-31.
--From 2019-01-01 to 2019-01-03 all tasks succeeded and the system state was "succeeded".
--From 2019-01-04 to 2019-01-05 all tasks failed and the system state was "failed".
--From 2019-01-06 to 2019-01-06 all tasks succeeded and the system state was "succeeded".

-- WHAT"S WRONG WITH THIS SOLUTION??
--SOLUTION-1
# Write your MySQL query statement below

with cte as
(
select
    "failed" as state ,
    fail_date as event_dt
from
    Failed
where
    YEAR(fail_date) = '2019'
union all
select
    "succeeded" as state,
    success_date  as event_dt
from
    Succeeded
where
    YEAR(success_date) = '2019'
)
,cte_group_dt as
(
select
    *,row_number() over(order by event_dt) as rnk
from
    cte
)
,cte_category_conv as
(
select
    *,row_number() over(partition by state order by event_dt) as rnk_category
from
    cte_group_dt
), cte_category as
(
select
    *,rnk-rnk_category as category
from
    cte_category_conv
)
# select * from cte_category
select
    max(state) as period_state,
    min(event_dt) as start_date,
    max(event_dt) as end_date
from
    cte_category
group by
    category
order by
    2

--SOLUTION-2
# Write your MySQL query statement below

with x as (
select fail_date as dat, 'failed'  as period_state, rank() over(order by fail_date) as rnk
from Failed
where year(fail_date)=2019
union all
select success_date as dat, 'succeeded' as period_state, rank() over(order by success_date) as rnk
from Succeeded
where year(success_date)=2019
    )

Select period_state, min(dat) as start_date, max(dat) as end_date
 from (
 select *, (rank() over(order by dat)-rnk) as group_rnk from x
     ) y
group by period_state, group_rnk
order by 2

--1336. Number of Transactions per Visit
--Hard
--
--70
--
--263
--
--Add to List
--
--Share
--SQL Schema
--Table: Visits
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| user_id       | int     |
--| visit_date    | date    |
--+---------------+---------+
--(user_id, visit_date) is the primary key for this table.
--Each row of this table indicates that user_id has visited the bank in visit_date.
--
--
--Table: Transactions
--
--+------------------+---------+
--| Column Name      | Type    |
--+------------------+---------+
--| user_id          | int     |
--| transaction_date | date    |
--| amount           | int     |
--+------------------+---------+
--There is no primary key for this table, it may contain duplicates.
--Each row of this table indicates that user_id has done a transaction of amount in transaction_date.
--It is guaranteed that the user has visited the bank in the transaction_date.(i.e The Visits table contains (user_id, transaction_date) in one row)
--
--
--A bank wants to draw a chart of the number of transactions bank visitors did in one visit to the bank and the corresponding number of visitors who have done this number of transaction in one visit.
--
--Write an SQL query to find how many users visited the bank and didn't do any transactions, how many visited the bank and did one transaction and so on.
--
--The result table will contain two columns:
--
--transactions_count which is the number of transactions done in one visit.
--visits_count which is the corresponding number of users who did transactions_count in one visit to the bank.
--transactions_count should take all values from 0 to max(transactions_count) done by one or more users.
--
--Return the result table ordered by transactions_count.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--
--Input:
--Visits table:
--+---------+------------+
--| user_id | visit_date |
--+---------+------------+
--| 1       | 2020-01-01 |
--| 2       | 2020-01-02 |
--| 12      | 2020-01-01 |
--| 19      | 2020-01-03 |
--| 1       | 2020-01-02 |
--| 2       | 2020-01-03 |
--| 1       | 2020-01-04 |
--| 7       | 2020-01-11 |
--| 9       | 2020-01-25 |
--| 8       | 2020-01-28 |
--+---------+------------+
--Transactions table:
--+---------+------------------+--------+
--| user_id | transaction_date | amount |
--+---------+------------------+--------+
--| 1       | 2020-01-02       | 120    |
--| 2       | 2020-01-03       | 22     |
--| 7       | 2020-01-11       | 232    |
--| 1       | 2020-01-04       | 7      |
--| 9       | 2020-01-25       | 33     |
--| 9       | 2020-01-25       | 66     |
--| 8       | 2020-01-28       | 1      |
--| 9       | 2020-01-25       | 99     |
--+---------+------------------+--------+
--Output:
--+--------------------+--------------+
--| transactions_count | visits_count |
--+--------------------+--------------+
--| 0                  | 4            |
--| 1                  | 5            |
--| 2                  | 0            |
--| 3                  | 1            |
--+--------------------+--------------+
--Explanation: The chart drawn for this example is shown above.
--* For transactions_count = 0, The visits (1, "2020-01-01"), (2, "2020-01-02"), (12, "2020-01-01") and (19, "2020-01-03") did no transactions so visits_count = 4.
--* For transactions_count = 1, The visits (2, "2020-01-03"), (7, &quo;2020-01-11"), (8, "2020-01-28"), (1, "2020-01-02") and (1, "2020-01-04") did one transaction so visits_count = 5.
--* For transactions_count = 2, No customers visited the bank and did two transactions so visits_count = 0.
--* For transactions_count = 3, The visit (9, "2020-01-25") did three transactions so visits_count = 1.
--* For transactions_count >= 4, No customers visited the bank and did more than three transactions so we will stop at transactions_count = 3

# Write your MySQL query statement below

with recursive cte1 as
# get different user_id's daily transaction count on different day with group by user_id and visit_date
(
select
    v.user_id ,
    v.visit_date ,
    sum(if(transaction_date is null,0,1)) as transaction_date_cnt
from
   Visits v left join Transactions t
on
    v.user_id = t.user_id
and
    v.visit_date = transaction_date
group by
    1,2
),
cte2 as
(
    #group by daily transaction count to find number of user_id that visited
select
    transaction_date_cnt as transactions_cnt ,
    count(*) as visits_count
from
    cte1
group by
    1
),
 cte3 as
(
# use recursive table to generate a growing list BECAUSE we need to include results that does not happen. e.g. the customer make 2 daily transaction does not happen
select 0 as num
UNION ALL
select num+1
from
    cte3
where
    num < (select max(transactions_cnt) as max_count from cte2)

)
#left join and replace null with 0
select
    num as transactions_count ,
    ifnull(visits_count,0) as visits_count
from
    cte3 left join cte2
on
   num = transactions_cnt ;

--1369. Get the Second Most Recent Activity
--Hard
--
--122
--
--12
--
--Add to List
--
--Share
--SQL Schema
--Table: UserActivity
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| username      | varchar |
--| activity      | varchar |
--| startDate     | Date    |
--| endDate       | Date    |
--+---------------+---------+
--There is no primary key for this table. It may contain duplicates.
--This table contains information about the activity performed by each user in a period of time.
--A person with username performed an activity from startDate to endDate.
--
--
--Write an SQL query to show the second most recent activity of each user.
--
--If the user only has one activity, return that one. A user cannot perform more than one activity at the same time.
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
--UserActivity table:
--+------------+--------------+-------------+-------------+
--| username   | activity     | startDate   | endDate     |
--+------------+--------------+-------------+-------------+
--| Alice      | Travel       | 2020-02-12  | 2020-02-20  |
--| Alice      | Dancing      | 2020-02-21  | 2020-02-23  |
--| Alice      | Travel       | 2020-02-24  | 2020-02-28  |
--| Bob        | Travel       | 2020-02-11  | 2020-02-18  |
--+------------+--------------+-------------+-------------+
--Output:
--+------------+--------------+-------------+-------------+
--| username   | activity     | startDate   | endDate     |
--+------------+--------------+-------------+-------------+
--| Alice      | Dancing      | 2020-02-21  | 2020-02-23  |
--| Bob        | Travel       | 2020-02-11  | 2020-02-18  |
--+------------+--------------+-------------+-------------+
--Explanation:
--The most recent activity of Alice is Travel from 2020-02-24 to 2020-02-28, before that she was dancing from 2020-02-21 to 2020-02-23.
--Bob only has one record, we just take that one.
# Write your MySQL query statement below
with cte1 as
(
select
    username,
    activity,
    startDate,
    endDate,
    dense_rank() over (partition by username order by startDate desc,endDate desc) as rnk
from
    UserActivity
)
# select * from cte1
,
cte2 as
(
select
    username,
    max(rnk) as max_rnk
from
    cte1
group by
    1
)
select
    username,
    activity,
    startDate,
    endDate
from
    cte1
where
    rnk = 2
union all
select
    username,
    activity,
    startDate,
    endDate
from
    cte1
where
    username in (
                    select username from cte2 where max_rnk<2
)
;

--1412. Find the Quiet Students in All Exams
--Hard
--
--167
--
--12
--
--Add to List
--
--Share
--SQL Schema
--Table: Student
--
--+---------------------+---------+
--| Column Name         | Type    |
--+---------------------+---------+
--| student_id          | int     |
--| student_name        | varchar |
--+---------------------+---------+
--student_id is the primary key for this table.
--student_name is the name of the student.
--
--
--Table: Exam
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| exam_id       | int     |
--| student_id    | int     |
--| score         | int     |
--+---------------+---------+
--(exam_id, student_id) is the primary key for this table.
--Each row of this table indicates that the student with student_id had a score points in the exam with id exam_id.
--
--
--A quiet student is the one who took at least one exam and did not score the high or the low score.
--
--Write an SQL query to report the students (student_id, student_name) being quiet in all exams. Do not return the student who has never taken any exam.
--
--Return the result table ordered by student_id.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Student table:
--+-------------+---------------+
--| student_id  | student_name  |
--+-------------+---------------+
--| 1           | Daniel        |
--| 2           | Jade          |
--| 3           | Stella        |
--| 4           | Jonathan      |
--| 5           | Will          |
--+-------------+---------------+
--Exam table:
--+------------+--------------+-----------+
--| exam_id    | student_id   | score     |
--+------------+--------------+-----------+
--| 10         |     1        |    70     |
--| 10         |     2        |    80     |
--| 10         |     3        |    90     |
--| 20         |     1        |    80     |
--| 30         |     1        |    70     |
--| 30         |     3        |    80     |
--| 30         |     4        |    90     |
--| 40         |     1        |    60     |
--| 40         |     2        |    70     |
--| 40         |     4        |    80     |
--+------------+--------------+-----------+
--Output:
--+-------------+---------------+
--| student_id  | student_name  |
--+-------------+---------------+
--| 2           | Jade          |
--+-------------+---------------+
--Explanation:
--For exam 1: Student 1 and 3 hold the lowest and high scores respectively.
--For exam 2: Student 1 hold both highest and lowest score.
--For exam 3 and 4: Studnet 1 and 4 hold the lowest and high scores respectively.
--Student 2 and 5 have never got the highest or lowest in any of the exams.
--Since student 5 is not taking any exam, he is excluded from the result.
--So, we only return the information of Student 2.

# Write your MySQL query statement below

WITH cte1 AS
(
SELECT
    exam_id,
    max(score) AS maxs,
    min(score) AS mins
FROM
    Exam
GROUP BY
    exam_id
)
# select * from cte1

SELECT
    DISTINCT a.student_id,
    b.student_name
FROM
    Exam a JOIN Student b
ON
    a.student_id = b.student_id
WHERE
    a.student_id NOT IN
    (
        SELECT
            Exam.student_id
        FROM
            Exam JOIN cte1
        ON
            Exam.exam_id = cte1.exam_id
        WHERE
            Exam.score = maxs OR Exam.score = mins
    )
ORDER BY
    a.student_id ASC;

--2153. The Number of Passengers in Each Bus II
--Hard
--
--37
--
--17
--
--Add to List
--
--Share
--SQL Schema
--Table: Buses
--
--+--------------+------+
--| Column Name  | Type |
--+--------------+------+
--| bus_id       | int  |
--| arrival_time | int  |
--| capacity     | int  |
--+--------------+------+
--bus_id is the primary key column for this table.
--Each row of this table contains information about the arrival time of a bus at the LeetCode station and its capacity (the number of empty seats it has).
--No two buses will arrive at the same time and all bus capacities will be positive integers.
--
--
--Table: Passengers
--
--+--------------+------+
--| Column Name  | Type |
--+--------------+------+
--| passenger_id | int  |
--| arrival_time | int  |
--+--------------+------+
--passenger_id is the primary key column for this table.
--Each row of this table contains information about the arrival time of a passenger at the LeetCode station.
--
--
--Buses and passengers arrive at the LeetCode station. If a bus arrives at the station at a time tbus and a passenger arrived at a time tpassenger where tpassenger <= tbus and the passenger did not catch any bus, the passenger will use that bus. In addition, each bus has a capacity. If at the moment the bus arrives at the station there are more passengers waiting than its capacity capacity, only capacity passengers will use the bus.
--
--Write an SQL query to report the number of users that used each bus.
--
--Return the result table ordered by bus_id in ascending order.
--
--The query result format is in the following example.
--
--
--
--Example 1:
--
--Input:
--Buses table:
--+--------+--------------+----------+
--| bus_id | arrival_time | capacity |
--+--------+--------------+----------+
--| 1      | 2            | 1        |
--| 2      | 4            | 10       |
--| 3      | 7            | 2        |
--+--------+--------------+----------+
--Passengers table:
--+--------------+--------------+
--| passenger_id | arrival_time |
--+--------------+--------------+
--| 11           | 1            |
--| 12           | 1            |
--| 13           | 5            |
--| 14           | 6            |
--| 15           | 7            |
--+--------------+--------------+
--Output:
--+--------+----------------+
--| bus_id | passengers_cnt |
--+--------+----------------+
--| 1      | 1              |
--| 2      | 1              |
--| 3      | 2              |
--+--------+----------------+
--Explanation:
--- Passenger 11 arrives at time 1.
--- Passenger 12 arrives at time 1.
--- Bus 1 arrives at time 2 and collects passenger 11 as it has one empty seat.
--
--- Bus 2 arrives at time 4 and collects passenger 12 as it has ten empty seats.
--
--- Passenger 12 arrives at time 5.
--- Passenger 13 arrives at time 6.
--- Passenger 14 arrives at time 7.
--- Bus 3 arrives at time 7 and collects passengers 12 and 13 as it has two empty seats.

# Write your MySQL query statement below

WITH RECURSIVE A AS(
    SELECT bus_id,
    LAG(arrival_time, 1, -1) OVER( ORDER BY arrival_time) AS last_arrival_time,
    arrival_time,  capacity FROM Buses
)
# select * from A;
,
B AS(
    SELECT A.bus_id, A.arrival_time,  A.capacity, COUNT(P.passenger_id) AS passager_count FROM A LEFT JOIN Passengers P
    ON A.last_arrival_time < P.arrival_time AND P.arrival_time<= A.arrival_time GROUP BY 1
)
# select * from B;
,
C AS(
    SELECT bus_id,
    capacity,
    passager_count AS total_passenger,
    ROW_NUMBER() OVER(ORDER BY arrival_time) AS id
    FROM B
)
# select * from C;
,
D AS(
    SELECT bus_id,capacity , total_passenger,id,
    IF(capacity>total_passenger, total_passenger, capacity) AS passager_taken,
    IF(capacity<total_passenger, total_passenger - capacity, 0) AS passager_overleft
    FROM C WHERE id = 1
    UNION
    SELECT C.bus_id,C.capacity , C.total_passenger, C.id,
    IF(C.capacity>C.total_passenger+D.passager_overleft, C.total_passenger+D.passager_overleft, C.capacity) AS passager_taken,
    IF(C.capacity<C.total_passenger+D.passager_overleft, C.total_passenger+D.passager_overleft - C.capacity, 0) AS passager_overleft
    FROM C
    INNER JOIN D ON D.id+1 = C.id
)
# select * from D;
SELECT bus_id, passager_taken AS passengers_cnt FROM D ORDER BY 1