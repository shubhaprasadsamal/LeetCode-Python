--1757. Recyclable and Low Fat Products
--Table: Products
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| product_id  | int     |
--| low_fats    | enum    |
--| recyclable  | enum    |
--+-------------+---------+
--product_id is the primary key for this table.
--low_fats is an ENUM of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
--recyclable is an ENUM of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.
--
--
--Write an SQL query to find the ids of products that are both low fat and recyclable.
--
--Return the result table in any order.
--
--The query result format is in the following example:
--
--
--
--Products table:
--+-------------+----------+------------+
--| product_id  | low_fats | recyclable |
--+-------------+----------+------------+
--| 0           | Y        | N          |
--| 1           | Y        | Y          |
--| 2           | N        | Y          |
--| 3           | Y        | Y          |
--| 4           | N        | N          |
--+-------------+----------+------------+
--Result table:
--+-------------+
--| product_id  |
--+-------------+
--| 1           |
--| 3           |
--+-------------+
--Only products 1 and 3 are both low fat and recyclable.

--Solution:

select product_id
    from Products
    where low_fats  = 'Y'
    and recyclable  = 'Y';


--1741. Find Total Time Spent by Each Employee
--Table: Employees
--
--+-------------+------+
--| Column Name | Type |
--+-------------+------+
--| emp_id      | int  |
--| event_day   | date |
--| in_time     | int  |
--| out_time    | int  |
--+-------------+------+
--(emp_id, event_day, in_time) is the primary key of this table.
--The table shows the employees' entries and exits in an office.
--event_day is the day at which this event happened, in_time is the minute at which the employee entered the office, and out_time is the minute at which they left the office.
--in_time and out_time are between 1 and 1440.
--It is guaranteed that no two events on the same day intersect in time, and in_time < out_time.
--
--
--Write an SQL query to calculate the total time in minutes spent by each employee on each day at the office. Note that within one day, an employee can enter and leave more than once. The time spent in the office for a single entry is out_time - in_time.
--
--Return the result table in any order.
--
--The query result format is in the following example:
--
--Employees table:
--+--------+------------+---------+----------+
--| emp_id | event_day  | in_time | out_time |
--+--------+------------+---------+----------+
--| 1      | 2020-11-28 | 4       | 32       |
--| 1      | 2020-11-28 | 55      | 200      |
--| 1      | 2020-12-03 | 1       | 42       |
--| 2      | 2020-11-28 | 3       | 33       |
--| 2      | 2020-12-09 | 47      | 74       |
--+--------+------------+---------+----------+
--Result table:
--+------------+--------+------------+
--| day        | emp_id | total_time |
--+------------+--------+------------+
--| 2020-11-28 | 1      | 173        |
--| 2020-11-28 | 2      | 30         |
--| 2020-12-03 | 1      | 41         |
--| 2020-12-09 | 2      | 27         |
--+------------+--------+------------+
--Employee 1 has three events: two on day 2020-11-28 with a total of (32 - 4) + (200 - 55) = 173, and one on day 2020-12-03 with a total of (42 - 1) = 41.
--Employee 2 has two events: one on day 2020-11-28 with a total of (33 - 3) = 30, and one on day 2020-12-09 with a total of (74 - 47) = 27.
--
--Solution:

select
    event_day  day,
    emp_id,
    sum(out_time - in_time) as total_time
from
    Employees
group by
    1,2;

--1683. Invalid Tweets
--Table: Tweets
--
--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| tweet_id       | int     |
--| content        | varchar |
--+----------------+---------+
--tweet_id is the primary key for this table.
--This table contains all the tweets in a social media app.
--
--
--Write an SQL query to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
--
--Return the result table in any order.
--
--The query result format is in the following example:
--
--
--
--Tweets table:
--+----------+----------------------------------+
--| tweet_id | content                          |
--+----------+----------------------------------+
--| 1        | Vote for Biden                   |
--| 2        | Let us make America great again! |
--+----------+----------------------------------+
--
--Result table:
--+----------+
--| tweet_id |
--+----------+
--| 2        |
--+----------+
--Tweet 1 has length = 14. It is a valid tweet.
--Tweet 2 has length = 32. It is an invalid tweet.
--
--Solution:

select
    tweet_id
from
    Tweets
where
    length(content)>15;


--1693. Daily Leads and Partners
--
--Table: DailySales
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| date_id     | date    |
--| make_name   | varchar |
--| lead_id     | int     |
--| partner_id  | int     |
--+-------------+---------+
--This table does not have a primary key.
--This table contains the date and the name of the product sold and the IDs of the lead and partner it was sold to.
--The name consists of only lowercase English letters.
--
--
--Write an SQL query that will, for each date_id and make_name, return the number of distinct lead_id's and distinct partner_id's.
--
--Return the result table in any order.
--
--The query result format is in the following example:
--
--
--
--DailySales table:
--+-----------+-----------+---------+------------+
--| date_id   | make_name | lead_id | partner_id |
--+-----------+-----------+---------+------------+
--| 2020-12-8 | toyota    | 0       | 1          |
--| 2020-12-8 | toyota    | 1       | 0          |
--| 2020-12-8 | toyota    | 1       | 2          |
--| 2020-12-7 | toyota    | 0       | 2          |
--| 2020-12-7 | toyota    | 0       | 1          |
--| 2020-12-8 | honda     | 1       | 2          |
--| 2020-12-8 | honda     | 2       | 1          |
--| 2020-12-7 | honda     | 0       | 1          |
--| 2020-12-7 | honda     | 1       | 2          |
--| 2020-12-7 | honda     | 2       | 1          |
--+-----------+-----------+---------+------------+
--Result table:
--+-----------+-----------+--------------+-----------------+
--| date_id   | make_name | unique_leads | unique_partners |
--+-----------+-----------+--------------+-----------------+
--| 2020-12-8 | toyota    | 2            | 3               |
--| 2020-12-7 | toyota    | 1            | 2               |
--| 2020-12-8 | honda     | 2            | 2               |
--| 2020-12-7 | honda     | 3            | 2               |
--+-----------+-----------+--------------+-----------------+
--For 2020-12-8, toyota gets leads = [0, 1] and partners = [0, 1, 2] while honda gets leads = [1, 2] and partners = [1, 2].
--For 2020-12-7, toyota gets leads = [0] and partners = [1, 2] while honda gets leads = [0, 1, 2] and partners = [1, 2].
--
--Solution:

select
    date_id,
    make_name,
    count(distinct lead_id) as unique_leads,
    count(distinct partner_id) as unique_partners
from
    DailySales
group by date_id, make_name