# noinspection NonAsciiCharactersForFile

# 进阶5 分组查询
/*
 语法:
    select 分组函数, 列(要求出现在group by的后面)
    from 表名
    【where】 筛选条件
    group by 分组的列表
    【order by 子句】
 注意
    查询列表比较特殊， 要求是分组函数和group by后面出现的字段

 特点
    >> 分组查询的筛选条件可以分为两类
                        数据源             位置                  关键字
        分组前筛选       原始表             group by 子句前面       where
        分组后筛选       分组后的结果集      group by 子句后面       having
            >> 分组函数做条件肯定是放在having字句中
            >> 能用分组前筛选有限考虑分组前筛选
 */
# 案例: 查询每个部门的平均工资
select avg(salary)
from employees;

select avg(salary), department_id
from employees
group by department_id;

# 简单的分组查询
# 案例1: 查询每个工种的最高工资
select max(salary) as 'max salary', job_id
from employees
group by job_id
order by `max salary`;

# 案例2: 查询每个位置的部门个数
select count(*), location_id
from departments
group by location_id;

# 添加筛选条件
# 案例一: 查询邮箱中包含a字符的每个部门的平均工资
select avg(salary), department_id
from employees
where email like '%a%'
group by department_id;

# 案例二: 查询有奖金的每个领导手下员工的最高工资
select max(salary), manager_id
from employees
where commission_pct is not null
group by manager_id;

# 添加分组后的筛选条件
# 案例1: 查询哪个部门的员工个数>2
/*
    1. 查询每个部门的员工个数
    2. 根据1. 的结果进行筛选, 查询哪个部门的员工个数>2
 */
select count(*), department_id
from employees
group by department_id
having count(*) > 2;

# 案例2; 查询每个工种有奖金的最高工资>12000的工种编号和最高工资
/*
 1. 查询每个工种有奖金的员工的最高工资
 2. 添加筛选条件
 */
select max(salary) as '最高工资', job_id as '工种编号'
from employees
where commission_pct is not null
group by job_id
having max(salary) > 12000;

# 案例3: 查询领导编号>102的每个领导手下最低工资>5000的领导编号是哪个

/*
 1. 查询每个领导手下员工的最低工资
 2. 添加筛选条件 编号>102
 3. 添加是选条件 最低工资>5000
 */
select min(salary) as '最低工资', manager_id
from employees
where manager_id > 102
group by manager_id
having min(salary) > 5000;

# 按表达式分组
# 案例: 按员工i姓名的长度分组, 查询每一组的员工个数, 筛选员工个数 > 5 的有哪些
select