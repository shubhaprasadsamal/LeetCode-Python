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
group by date_id, make_name;

--1350. Students With Invalid Departments
--Table: Departments
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| name          | varchar |
--+---------------+---------+
--id is the primary key of this table.
--The table has information about the id of each department of a university.
--
--
--Table: Students
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| name          | varchar |
--| department_id | int     |
--+---------------+---------+
--id is the primary key of this table.
--The table has information about the id of each student at a university and the id of the department he/she studies at.
--
--
--Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exists.
--
--Return the result table in any order.
--
--The query result format is in the following example:
--
--Departments table:
--+------+--------------------------+
--| id   | name                     |
--+------+--------------------------+
--| 1    | Electrical Engineering   |
--| 7    | Computer Engineering     |
--| 13   | Bussiness Administration |
--+------+--------------------------+
--
--Students table:
--+------+----------+---------------+
--| id   | name     | department_id |
--+------+----------+---------------+
--| 23   | Alice    | 1             |
--| 1    | Bob      | 7             |
--| 5    | Jennifer | 13            |
--| 2    | John     | 14            |
--| 4    | Jasmine  | 77            |
--| 3    | Steve    | 74            |
--| 6    | Luis     | 1             |
--| 8    | Jonathan | 7             |
--| 7    | Daiana   | 33            |
--| 11   | Madelynn | 1             |
--+------+----------+---------------+
--
--Result table:
--+------+----------+
--| id   | name     |
--+------+----------+
--| 2    | John     |
--| 7    | Daiana   |
--| 4    | Jasmine  |
--| 3    | Steve    |
--+------+----------+
--
--John, Daiana, Steve and Jasmine are enrolled in departments 14, 33, 74 and 77 respectively. department 14, 33, 74 and 77 doesn't exist in the Departments table.
--
--Solution:

select
    s.id,s.name
from
    Students s
where s.department_id not in (select id from Departments)
order by 1;

--1378. Replace Employee ID With The Unique Identifier
--Table: Employees
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| name          | varchar |
--+---------------+---------+
--id is the primary key for this table.
--Each row of this table contains the id and the name of an employee in a company.
--
--
--Table: EmployeeUNI
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| unique_id     | int     |
--+---------------+---------+
--(id, unique_id) is the primary key for this table.
--Each row of this table contains the id and the corresponding unique id of an employee in the company.
--
--
--Write an SQL query to show the unique ID of each user, If a user doesn't have a unique ID replace just show null.
--
--Return the result table in any order.
--
--The query result format is in the following example:
--
--Employees table:
--+----+----------+
--| id | name     |
--+----+----------+
--| 1  | Alice    |
--| 7  | Bob      |
--| 11 | Meir     |
--| 90 | Winston  |
--| 3  | Jonathan |
--+----+----------+
--
--EmployeeUNI table:
--+----+-----------+
--| id | unique_id |
--+----+-----------+
--| 3  | 1         |
--| 11 | 2         |
--| 90 | 3         |
--+----+-----------+
--
--EmployeeUNI table:
--+-----------+----------+
--| unique_id | name     |
--+-----------+----------+
--| null      | Alice    |
--| null      | Bob      |
--| 2         | Meir     |
--| 3         | Winston  |
--| 1         | Jonathan |
--+-----------+----------+
--
--Alice and Bob don't have a unique ID, We will show null instead.
--The unique ID of Meir is 2.
--The unique ID of Winston is 3.
--The unique ID of Jonathan is 1.
--
--Solution:

select
    unique_id,name
from
    Employees left join EmployeeUNI
on Employees.id = EmployeeUNI.id;


--1587. Bank Account Summary II
--Table: Users
--
--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| account      | int     |
--| name         | varchar |
--+--------------+---------+
--account is the primary key for this table.
--Each row of this table contains the account number of each user in the bank.
--
--
--Table: Transactions
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| trans_id      | int     |
--| account       | int     |
--| amount        | int     |
--| transacted_on | date    |
--+---------------+---------+
--trans_id is the primary key for this table.
--Each row of this table contains all changes made to all accounts.
--amount is positive if the user received money and negative if they transferred money.
--All accounts start with a balance 0.
--
--
--Write an SQL query to report the name and balance of users with a balance higher than 10000. The balance of an account is equal to the sum of the amounts of all transactions involving that account.
--
--Return the result table in any order.
--
--The query result format is in the following example.
--
--
--
--Users table:
--+------------+--------------+
--| account    | name         |
--+------------+--------------+
--| 900001     | Alice        |
--| 900002     | Bob          |
--| 900003     | Charlie      |
--+------------+--------------+
--
--Transactions table:
--+------------+------------+------------+---------------+
--| trans_id   | account    | amount     | transacted_on |
--+------------+------------+------------+---------------+
--| 1          | 900001     | 7000       |  2020-08-01   |
--| 2          | 900001     | 7000       |  2020-09-01   |
--| 3          | 900001     | -3000      |  2020-09-02   |
--| 4          | 900002     | 1000       |  2020-09-12   |
--| 5          | 900003     | 6000       |  2020-08-07   |
--| 6          | 900003     | 6000       |  2020-09-07   |
--| 7          | 900003     | -4000      |  2020-09-11   |
--+------------+------------+------------+---------------+
--
--Result table:
--+------------+------------+
--| name       | balance    |
--+------------+------------+
--| Alice      | 11000      |
--+------------+------------+
--Alice's balance is (7000 + 7000 - 3000) = 11000.
--Bob's balance is 1000.
--Charlie's balance is (6000 + 6000 - 4000) = 8000.
--
--Solution:

select
    name,
    sum(amount) as balance
from
    Users,Transactions
where
    Users.account = Transactions.account
group by
    name
having sum(amount) > 10000;

--1571. Warehouse Manager
--able: Warehouse
--
--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| name         | varchar |
--| product_id   | int     |
--| units        | int     |
--+--------------+---------+
--(name, product_id) is the primary key for this table.
--Each row of this table contains the information of the products in each warehouse.
--
--
--Table: Products
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| product_id    | int     |
--| product_name  | varchar |
--| Width         | int     |
--| Length        | int     |
--| Height        | int     |
--+---------------+---------+
--product_id is the primary key for this table.
--Each row of this table contains the information about the product dimensions (Width, Lenght and Height) in feets of each product.
--
--
--Write an SQL query to report, How much cubic feet of volume does the inventory occupy in each warehouse.
--
--warehouse_name
--volume
--Return the result table in any order.
--
--The query result format is in the following example.
--
--
--
--Warehouse table:
--+------------+--------------+-------------+
--| name       | product_id   | units       |
--+------------+--------------+-------------+
--| LCHouse1   | 1            | 1           |
--| LCHouse1   | 2            | 10          |
--| LCHouse1   | 3            | 5           |
--| LCHouse2   | 1            | 2           |
--| LCHouse2   | 2            | 2           |
--| LCHouse3   | 4            | 1           |
--+------------+--------------+-------------+
--
--Products table:
--+------------+--------------+------------+----------+-----------+
--| product_id | product_name | Width      | Length   | Height    |
--+------------+--------------+------------+----------+-----------+
--| 1          | LC-TV        | 5          | 50       | 40        |
--| 2          | LC-KeyChain  | 5          | 5        | 5         |
--| 3          | LC-Phone     | 2          | 10       | 10        |
--| 4          | LC-T-Shirt   | 4          | 10       | 20        |
--+------------+--------------+------------+----------+-----------+
--
--Result table:
--+----------------+------------+
--| warehouse_name | volume     |
--+----------------+------------+
--| LCHouse1       | 12250      |
--| LCHouse2       | 20250      |
--| LCHouse3       | 800        |
--+----------------+------------+
--Volume of product_id = 1 (LC-TV), 5x50x40 = 10000
--Volume of product_id = 2 (LC-KeyChain), 5x5x5 = 125
--Volume of product_id = 3 (LC-Phone), 2x10x10 = 200
--Volume of product_id = 4 (LC-T-Shirt), 4x10x20 = 800
--LCHouse1: 1 unit of LC-TV + 10 units of LC-KeyChain + 5 units of LC-Phone.
--          Total volume: 1*10000 + 10*125  + 5*200 = 12250 cubic feet
--LCHouse2: 2 units of LC-TV + 2 units of LC-KeyChain.
--          Total volume: 2*10000 + 2*125 = 20250 cubic feet
--LCHouse3: 1 unit of LC-T-Shirt.
--          Total volume: 1*800 = 800 cubic feet.
--
--Solution:

select
    name as warehouse_name,
    sum(units*vol) as volume
from
    Warehouse join
                    (select
                        product_id,Width*Length*Height as vol
                    from
                        Products) prod_res
on
    Warehouse.product_id = prod_res.product_id
group by
    name;

--1581. Customer Who Visited but Did Not Make Any Transactions
--Table: Visits
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| visit_id    | int     |
--| customer_id | int     |
--+-------------+---------+
--visit_id is the primary key for this table.
--This table contains information about the customers who visited the mall.
--
--
--Table: Transactions
--
--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| transaction_id | int     |
--| visit_id       | int     |
--| amount         | int     |
--+----------------+---------+
--transaction_id is the primary key for this table.
--This table contains information about the transactions made during the visit_id.
--
--
--Write an SQL query to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
--
--Return the result table sorted in any order.
--
--The query result format is in the following example:
--
--Visits
--+----------+-------------+
--| visit_id | customer_id |
--+----------+-------------+
--| 1        | 23          |
--| 2        | 9           |
--| 4        | 30          |
--| 5        | 54          |
--| 6        | 96          |
--| 7        | 54          |
--| 8        | 54          |
--+----------+-------------+
--
--Transactions
--+----------------+----------+--------+
--| transaction_id | visit_id | amount |
--+----------------+----------+--------+
--| 2              | 5        | 310    |
--| 3              | 5        | 300    |
--| 9              | 5        | 200    |
--| 12             | 1        | 910    |
--| 13             | 2        | 970    |
--+----------------+----------+--------+
--
--Result table:
--+-------------+----------------+
--| customer_id | count_no_trans |
--+-------------+----------------+
--| 54          | 2              |
--| 30          | 1              |
--| 96          | 1              |
--+-------------+----------------+
--Customer with id = 23 visited the mall once and made one transaction during the visit with id = 12.
--Customer with id = 9 visited the mall once and made one transaction during the visit with id = 13.
--Customer with id = 30 visited the mall once and did not make any transactions.
--Customer with id = 54 visited the mall three times. During 2 visits they did not make any transactions, and during one visit they made 3 transactions.
--Customer with id = 96 visited the mall once and did not make any transactions.
--As we can see, users with IDs 30 and 96 visited the mall one time without making any transactions. Also user 54 visited the mall twice and did not make any transactions.
--
--Solution:

select
    customer_id,
    count(*) as count_no_trans
from
    Visits left join Transactions
on
    Visits.visit_id  = Transactions.visit_id
where    transaction_id is null
group by customer_id;

--1303. Find the Team Size          [Amazon]
--Table: Employee
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| employee_id   | int     |
--| team_id       | int     |
--+---------------+---------+
--employee_id is the primary key for this table.
--Each row of this table contains the ID of each employee and their respective team.
--Write an SQL query to find the team size of each of the employees.
--
--Return result table in any order.
--
--The query result format is in the following example:
--
--Employee Table:
--+-------------+------------+
--| employee_id | team_id    |
--+-------------+------------+
--|     1       |     8      |
--|     2       |     8      |
--|     3       |     8      |
--|     4       |     7      |
--|     5       |     9      |
--|     6       |     9      |
--+-------------+------------+
--Result table:
--+-------------+------------+
--| employee_id | team_size  |
--+-------------+------------+
--|     1       |     3      |
--|     2       |     3      |
--|     3       |     3      |
--|     4       |     1      |
--|     5       |     2      |
--|     6       |     2      |
--+-------------+------------+
--Employees with Id 1,2,3 are part of a team with team_id = 8.
--Employees with Id 4 is part of a team with team_id = 7.
--Employees with Id 5,6 are part of a team with team_id = 9.
--
--Solution:

select
    employee_id,
    count(*) over (partition by team_id) as team_size
from
    Employee ;


--1623. All Valid Triplets That Can Represent a Country           [Amazon]
--able: SchoolA
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| student_id    | int     |
--| student_name  | varchar |
--+---------------+---------+
--student_id is the primary key for this table.
--Each row of this table contains the name and the id of a student in school A.
--All student_name are distinct.
--
--
--Table: SchoolB
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| student_id    | int     |
--| student_name  | varchar |
--+---------------+---------+
--student_id is the primary key for this table.
--Each row of this table contains the name and the id of a student in school B.
--All student_name are distinct.
--
--
--Table: SchoolC
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| student_id    | int     |
--| student_name  | varchar |
--+---------------+---------+
--student_id is the primary key for this table.
--Each row of this table contains the name and the id of a student in school C.
--All student_name are distinct.
--
--
--There is a country with three schools, where each student is enrolled in exactly one school. The country is joining a competition and wants to select one student from each school to represent the country such that:
--
--member_A is selected from SchoolA,
--member_B is selected from SchoolB,
--member_C is selected from SchoolC, and
--The selected students' names and IDs are pairwise distinct (i.e. no two students share the same name, and no two students share the same ID).
--Write an SQL query to find all the possible triplets representing the country under the given constraints.
--
--Return the result table in any order.
--
--The query result format is in the following example.
--
--
--
--SchoolA table:
--+------------+--------------+
--| student_id | student_name |
--+------------+--------------+
--| 1          | Alice        |
--| 2          | Bob          |
--+------------+--------------+
--
--SchoolB table:
--+------------+--------------+
--| student_id | student_name |
--+------------+--------------+
--| 3          | Tom          |
--+------------+--------------+
--
--SchoolC table:
--+------------+--------------+
--| student_id | student_name |
--+------------+--------------+
--| 3          | Tom          |
--| 2          | Jerry        |
--| 10         | Alice        |
--+------------+--------------+
--
--Result table:
--+----------+----------+----------+
--| member_A | member_B | member_C |
--+----------+----------+----------+
--| Alice    | Tom      | Jerry    |
--| Bob      | Tom      | Alice    |
--+----------+----------+----------+
--Let us see all the possible triplets.
--- (Alice, Tom, Tom) --> Rejected because member_B and member_C have the same name and the same ID.
--- (Alice, Tom, Jerry) --> Valid triplet.
--- (Alice, Tom, Alice) --> Rejected because member_A and member_C have the same name.
--- (Bob, Tom, Tom) --> Rejected because member_B and member_C have the same name and the same ID.
--- (Bob, Tom, Jerry) --> Rejected because member_A and member_C have the same ID.
--- (Bob, Tom, Alice) --> Valid triplet.
--
--Solution:

SELECT
    a.student_name member_A,
    b.student_name member_B,
    c.student_name member_C
FROM
    SchoolA a, SchoolB b, SchoolC c
WHERE
    a.student_id <> b.student_id AND
    b.student_id <> c.student_id AND
    c.student_id <> a.student_id AND
    a.student_name <> b.student_name AND
    b.student_name <> c.student_name AND
    c.student_name <> a.student_name;

--1484. Group Sold Products By The Date               [Revision]
                                                      [GROUP_CONCAT]
--Table Activities:
--
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| sell_date   | date    |
--| product     | varchar |
--+-------------+---------+
--There is no primary key for this table, it may contains duplicates.
--Each row of this table contains the product name and the date it was sold in a market.
--
--
--Write an SQL query to find for each date, the number of distinct products sold and their names.
--
--The sold-products names for each date should be sorted lexicographically.
--
--Return the result table ordered by sell_date.
--
--The query result format is in the following example.
--
--Activities table:
--+------------+-------------+
--| sell_date  | product     |
--+------------+-------------+
--| 2020-05-30 | Headphone   |
--| 2020-06-01 | Pencil      |
--| 2020-06-02 | Mask        |
--| 2020-05-30 | Basketball  |
--| 2020-06-01 | Bible       |
--| 2020-06-02 | Mask        |
--| 2020-05-30 | T-Shirt     |
--+------------+-------------+
--
--Result table:
--+------------+----------+------------------------------+
--| sell_date  | num_sold | products                     |
--+------------+----------+------------------------------+
--| 2020-05-30 | 3        | Basketball,Headphone,T-shirt |
--| 2020-06-01 | 2        | Bible,Pencil                 |
--| 2020-06-02 | 1        | Mask                         |
--+------------+----------+------------------------------+
--For 2020-05-30, Sold items were (Headphone, Basketball, T-shirt), we sort them lexicographically and separate them by comma.
--For 2020-06-01, Sold items were (Pencil, Bible), we sort them lexicographically and separate them by comma.
--For 2020-06-02, Sold item is (Mask), we just return it.
--
--Solution:

SELECT
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product
        ORDER BY product
        SEPARATOR ',') AS products
FROM
    activities
GROUP BY sell_date;

--1407. Top Travellers
--able: Users
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| name          | varchar |
--+---------------+---------+
--id is the primary key for this table.
--name is the name of the user.
--
--
--Table: Rides
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| user_id       | int     |
--| distance      | int     |
--+---------------+---------+
--id is the primary key for this table.
--user_id is the id of the user who travelled the distance "distance".
--
--
--Write an SQL query to report the distance travelled by each user.
--
--Return the result table ordered by travelled_distance in descending order, if two or more users travelled the same distance, order them by their name in ascending order.
--
--The query result format is in the following example.
--
--
--
--Users table:
--+------+-----------+
--| id   | name      |
--+------+-----------+
--| 1    | Alice     |
--| 2    | Bob       |
--| 3    | Alex      |
--| 4    | Donald    |
--| 7    | Lee       |
--| 13   | Jonathan  |
--| 19   | Elvis     |
--+------+-----------+
--
--Rides table:
--+------+----------+----------+
--| id   | user_id  | distance |
--+------+----------+----------+
--| 1    | 1        | 120      |
--| 2    | 2        | 317      |
--| 3    | 3        | 222      |
--| 4    | 7        | 100      |
--| 5    | 13       | 312      |
--| 6    | 19       | 50       |
--| 7    | 7        | 120      |
--| 8    | 19       | 400      |
--| 9    | 7        | 230      |
--+------+----------+----------+
--
--Result table:
--+----------+--------------------+
--| name     | travelled_distance |
--+----------+--------------------+
--| Elvis    | 450                |
--| Lee      | 450                |
--| Bob      | 317                |
--| Jonathan | 312                |
--| Alex     | 222                |
--| Alice    | 120                |
--| Donald   | 0                  |
--+----------+--------------------+
--Elvis and Lee travelled 450 miles, Elvis is the top traveller as his name is alphabetically smaller than Lee.
--Bob, Jonathan, Alex and Alice have only one ride and we just order them by the total distances of the ride.
--Donald didn't have any rides, the distance travelled by him is 0.
--
--SQL Solution:

SELECT
    U.name,
    IF(R.distance IS NOT NULL, SUM(R.distance),0) AS travelled_distance
FROM
    Users AS U LEFT JOIN Rides AS R
ON
    U.id=R.user_id
GROUP BY
    U.id
ORDER BY
    travelled_distance DESC, U.name ASC;

--MS SQL Server Solution:                                 [How to remove duplicate rows with no use of DISTINCT]
--                                                          [https://www.sqlservercentral.com/articles/eliminating-duplicate-rows-using-the-partition-by-clause]

SELECT
    distinct U.name,
    (case when R.distance is not null then sum(R.distance) over (partition by U.id) else 0 end) as travelled_distance
FROM
    Users AS U LEFT JOIN Rides AS R
ON
    U.id=R.user_id
ORDER BY
    travelled_distance DESC, U.name ASC;

--OR

select
    u.name,
    isnull(sum(r.distance),0) as travelled_distance
from
    Users u left join Rides r
on
    u.id=r.user_id
group by
    u.name
order by
    travelled_distance desc, u.name;


--1069. Product Sales Analysis II                                 [Amazon]
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
--sale_id is the primary key of this table.
--product_id is a foreign key to Product table.
--Note that the price is per unit.
--Table: Product
--
--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| product_id   | int     |
--| product_name | varchar |
--+--------------+---------+
--product_id is the primary key of this table.
--
--
--Write an SQL query that reports the total quantity sold for every product id.
--
--The query result format is in the following example:
--
--Sales table:
--+---------+------------+------+----------+-------+
--| sale_id | product_id | year | quantity | price |
--+---------+------------+------+----------+-------+
--| 1       | 100        | 2008 | 10       | 5000  |
--| 2       | 100        | 2009 | 12       | 5000  |
--| 7       | 200        | 2011 | 15       | 9000  |
--+---------+------------+------+----------+-------+
--
--Product table:
--+------------+--------------+
--| product_id | product_name |
--+------------+--------------+
--| 100        | Nokia        |
--| 200        | Apple        |
--| 300        | Samsung      |
--+------------+--------------+
--
--Result table:
--+--------------+----------------+
--| product_id   | total_quantity |
--+--------------+----------------+
--| 100          | 22             |
--| 200          | 15             |
--+--------------+----------------+
--
--MySQL Solution:
--
select
    p.product_id,sum(s.quantity) as total_quantity
from
    Sales s  left join Product p
on
    p.product_id = s.product_id
group by
    p.product_id
order by 1;

--MS SQL Server Solution:
--
SELECT
    Product.product_id,
    SUM(Sales.quantity) AS total_quantity
FROM
    Sales LEFT JOIN Product
on
    Sales.product_id = Product.product_id
GROUP BY
    Product.product_id;
--OR

select
    p.product_id,
    sum(s.quantity) as total_quantity
from
    Product p  left join Sales s
on
    p.product_id = s.product_id
group by p.product_id
having sum(s.quantity) is not null
order by 1;


--1565. Unique Orders and Customers Per Month
                                                        [Left]
--Table: Orders
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| order_id      | int     |
--| order_date    | date    |
--| customer_id   | int     |
--| invoice       | int     |
--+---------------+---------+
--order_id is the primary key for this table.
--This table contains information about the orders made by customer_id.
--
--
--Write an SQL query to find the number of unique orders and the number of unique customers with invoices > $20 for each different month.
--
--Return the result table sorted in any order.
--
--The query result format is in the following example:
--
--Orders
--+----------+------------+-------------+------------+
--| order_id | order_date | customer_id | invoice    |
--+----------+------------+-------------+------------+
--| 1        | 2020-09-15 | 1           | 30         |
--| 2        | 2020-09-17 | 2           | 90         |
--| 3        | 2020-10-06 | 3           | 20         |
--| 4        | 2020-10-20 | 3           | 21         |
--| 5        | 2020-11-10 | 1           | 10         |
--| 6        | 2020-11-21 | 2           | 15         |
--| 7        | 2020-12-01 | 4           | 55         |
--| 8        | 2020-12-03 | 4           | 77         |
--| 9        | 2021-01-07 | 3           | 31         |
--| 10       | 2021-01-15 | 2           | 20         |
--+----------+------------+-------------+------------+
--
--Result table:
--+---------+-------------+----------------+
--| month   | order_count | customer_count |
--+---------+-------------+----------------+
--| 2020-09 | 2           | 2              |
--| 2020-10 | 1           | 1              |
--| 2020-12 | 2           | 1              |
--| 2021-01 | 1           | 1              |
--+---------+-------------+----------------+
--In September 2020 we have two orders from 2 different customers with invoices > $20.
--In October 2020 we have two orders from 1 customer, and only one of the two orders has invoice > $20.
--In November 2020 we have two orders from 2 different customers but invoices < $20, so we don't include that month.
--In December 2020 we have two orders from 1 customer both with invoices > $20.
--In January 2021 we have two orders from 2 different customers, but only one of them with invoice > $20.
--
--My SQL:

select
    left(order_date ,7) as month,
    count(order_id) as order_count,
    count(distinct customer_id) as customer_count
from
    Orders
where
    invoice > 20
group by 1;


--1251. Average Selling Price                                     [Revision]
--Table: Prices
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| product_id    | int     |
--| start_date    | date    |
--| end_date      | date    |
--| price         | int     |
--+---------------+---------+
--(product_id, start_date, end_date) is the primary key for this table.
--Each row of this table indicates the price of the product_id in the period from start_date to end_date.
--For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.
--
--
--Table: UnitsSold
--
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| product_id    | int     |
--| purchase_date | date    |
--| units         | int     |
--+---------------+---------+
--There is no primary key for this table, it may contain duplicates.
--Each row of this table indicates the date, units and product_id of each product sold.
--
--
--Write an SQL query to find the average selling price for each product.
--
--average_price should be rounded to 2 decimal places.
--
--The query result format is in the following example:
--
--Prices table:
--+------------+------------+------------+--------+
--| product_id | start_date | end_date   | price  |
--+------------+------------+------------+--------+
--| 1          | 2019-02-17 | 2019-02-28 | 5      |
--| 1          | 2019-03-01 | 2019-03-22 | 20     |
--| 2          | 2019-02-01 | 2019-02-20 | 15     |
--| 2          | 2019-02-21 | 2019-03-31 | 30     |
--+------------+------------+------------+--------+
--
--UnitsSold table:
--+------------+---------------+-------+
--| product_id | purchase_date | units |
--+------------+---------------+-------+
--| 1          | 2019-02-25    | 100   |
--| 1          | 2019-03-01    | 15    |
--| 2          | 2019-02-10    | 200   |
--| 2          | 2019-03-22    | 30    |
--+------------+---------------+-------+
--
--Result table:
--+------------+---------------+
--| product_id | average_price |
--+------------+---------------+
--| 1          | 6.96          |
--| 2          | 16.96         |
--+------------+---------------+
--Average selling price = Total Price of Product / Number of products sold.
--Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
--Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96
--
--MySQL:

select
    p.product_id,
    round((sum(u.units*p.price)/sum(u.units)),2) as average_price
from
    Prices p,UnitsSold u
where
    p.product_id = u.product_id
    and u.purchase_date between p.start_date and p.end_date
group by 1
order by 1;


1173. Immediate Food Delivery I                                 [Revision]
Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the primary key of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).


If the preferred delivery date of the customer is the same as the order date then the order is called immediate otherwise it's called scheduled.

Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.

The query result format is in the following example:

Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 5           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-11                  |
| 4           | 3           | 2019-08-24 | 2019-08-26                  |
| 5           | 4           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
+-------------+-------------+------------+-----------------------------+

Result table:
+----------------------+
| immediate_percentage |
+----------------------+
| 33.33                |
+----------------------+
The orders with delivery id 2 and 3 are immediate while the others are scheduled.

MySQL:
select
    round((count(d1.delivery_id)/count(d2.delivery_id))*100,2) immediate_percentage
from
    Delivery d1 right outer join Delivery d2
on
    d1.delivery_id = d2.delivery_id
and
    d1.order_date = d2.customer_pref_delivery_date;

Explain:
select
    d1.delivery_id,
    d1.customer_id,
    d1.order_date,
    d1.customer_pref_delivery_date,
    d2.delivery_id,
    d2.customer_id,
    d2.order_date,
    d2.customer_pref_delivery_date
from
    Delivery d1 right outer join Delivery d2
on
    d1.delivery_id = d2.delivery_id
and
    d1.order_date = d2.customer_pref_delivery_date;

	["d1.delivery_id", "d1.customer_id", "d1.order_date", "d1.customer_pref_delivery_date", "d2.delivery_id", "d2.customer_id", "d2.order_date", "d2.customer_pref_delivery_date"]
		[null, 		null, 		null, 		null, 				1, 			1, 		"2019-08-01", 		"2019-08-02"],
		[2, 		5, 		"2019-08-02", 	"2019-08-02", 			2, 			5, 		"2019-08-02", 		"2019-08-02"],
		[3, 		1, 		"2019-08-11", 	"2019-08-11", 			3, 			1, 		"2019-08-11", 		"2019-08-11"],
		[null, 		null, 		null, 		null, 				4, 			3, 		"2019-08-24", 		"2019-08-26"],
		[null, 		null, 		null, 		null, 				5, 			4, 		"2019-08-21", 		"2019-08-22"],
		[null, 		null, 		null, 		null, 				6, 			2, 		"2019-08-11", 		"2019-08-13"]

	["d1.delivery_id", "d1.customer_id", "d1.order_date", "d1.customer_pref_delivery_date", "d2.delivery_id", "d2.customer_id", "d2.order_date", "d2.customer_pref_delivery_date"]
		[null, 		    null, 		        null, 		    null, 				                1, 			            1, 		"2019-08-01", 		"2019-08-02"],
		[2, 		    5, 		            "2019-08-02", 	"2019-08-02", 			            2, 			            5, 		"2019-08-02", 		"2019-08-02"],
		[3, 		    1, 		            "2019-08-11", 	"2019-08-11", 			            3, 			            1, 		"2019-08-11", 		"2019-08-11"],
		[null, 		    null, 		        null, 		    null, 				                4, 			            3, 		"2019-08-24", 		"2019-08-26"],
		[null, 		    null, 		        null, 		    null, 				                5, 			            4, 		"2019-08-21", 		"2019-08-22"],
		[null, 		    null, 		        null, 		    null, 				                6, 			            2, 		"2019-08-11", 		"2019-08-13"]

