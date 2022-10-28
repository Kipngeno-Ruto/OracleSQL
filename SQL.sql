--1.The Date Function
--current date
select sysdate AS Current_Date from dual;

--current time
select current_timestamp As Current_Time from dual;

--date Five 5 days from day
select sysdate + 5 AS Current_Date from dual;

--A month ago from today
select trunc(sysdate) from dual;

--Roudning date to the nearest month
select round(sysdate,'month') from dual;

--Query to return employees experience
select Ename,Round(months_between(sysdate,hiredate)/12) As Years_Exp
from emp

--data from emp table whose joined in the month of may but not between year 82 to 88
SELECT *
FROM EMP
WHERE to_char(hiredate,'month') = '05'
AND to_char(hiredate,'yyyy') NOT BETWEEN '1982' AND '1988'

--display data from emp table whose names starts with 'A' and joined in the year '87'
SELECT *
FROM EMP
WHERE ENAME LIKE 'A%'
AND to_char(hiredate,'yyyy') = '1987';

--Aggregate Functions

--all duplicates on the employee table
SELECT EMPNO,COUNT(*) As Dup_Enames
FROM EMP
GROUP BY EMPNO
HAVING COUNT(*) >1

--Fisrt 5 employees by deptno in the table
select * 
from emp
order by deptno
fetch first 5 rows only;

--Substr
--display the last 2 characters of employee names
select ename,substr(ename,-2,2) AS Last_2_char
from emp;

--instr
--The position of character 'S' in the names with the character
select ename,instr(ename,'S') AS Char_Pos
from emp
where ename like '%S%';

--JOINS
--Select the details of employees with the same salary.
--self join
select s1.empno,s1.ename,s1.sal
from emp s1
inner join emp s2 
ON s1.SAL = s2.SAL AND s1.ENAME <> s2.ENAME;

 --display employee names and departments of employees with a null commission In the result show the commission as 0 (zero).
 --inner join
select ename,d.dname,nvl(comm,0) As Commision
from emp
join dept d on emp.deptno = d.deptno
where emp.comm is null;

--concatination
select first_name||' '|| last_name as full_name,salary from employees

--set operators(Union,union all,minus,intersect)
--show one row twice?
select empno,ename,job from emp where empno = 7369
UNION ALL
select empno,ename,job from emp where empno = 7369

--return data from two tables without duplicates
select empno,ename,job from emp
UNION
select empno,ename,job from emp

--return all rows in the first select statement that are not return by the second select statement
select empno,ename,job from emp
MINUS
select empno,ename,job from emp

--show common records between 2 tables
select empno,ename,job from emp
INTERSECT
select empno,ename,job from emp

 --ctes
 WITH emp_sal as
 (SELECT first_name,last_name,salary from employees)
 Select * from emp_sal;


--Common Table Expressions(CTEs),they are used to make the queries readable and manageable,avoiding nested or subqueries
WITH CTE_1 as
 (SELECT first_name,last_name,salary from employees)
 Select * from CTE_1;
 
--Views;used for security purposes and to hide complexity of databases
Create view  vw_emp As
select ename,sal
from emp;

--Materialised views;One of the perfomance tuning technique
Create  materialized view mv_emp1 As
select * from emp;

--Analytical Functions;
--display employees data in desc order of their salaries
select first_name,salary,row_number() Over(order by salary desc) AS rank
from employees

--display the data of employees with the 2nd highest salary
with cte2 as (
select first_name,salary,dense_rank() Over(order by salary desc) AS rank
from employees
)
select first_name,salary 
from cte2 where rank = 2

--Employees salary Running total
select first_name,salary,sum(salary) over(order by salary) As Running_Total
From employees;




















