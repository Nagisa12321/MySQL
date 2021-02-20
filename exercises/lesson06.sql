use myemployees;
-- 1. 查询公司员工工资的最大值，最小值，平均值，总和
select max(salary) as 'max salary',
       min(salary) as 'min salary',
       round(avg(salary), 2) as 'avg salary',
       sum(salary) as 'sum salary'
from employees;

-- 2. 查询员工表中的最大入职时间和最小入职时间的相差天数 （DIFFRENCE）

select datediff('2017-10-1', '2017-9-29');
select datediff(now(), '1999-9.16');

select datediff(max(hiredate), min(hiredate)) as DIFFRENCE
from employees;

-- 3. 查询部门编号为 90 的员工个数
select count(*) as count
from employees
where department_id = 90;