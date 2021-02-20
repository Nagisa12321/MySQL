# 进阶3: 排序查询
/*
    引入
        SELECT * FROM employees;
    语法:
        select 查询列表
        from 表
        【where 筛选条件】
        order by 排序列表 【asc/desc】

        - desc: 降序, 从高到底
        - asc: 升序
    特点:
        1. asc为升序, desc 为降序, 如果不写默认为升序
        2. order by 可以支持单个字段, 多个字段、表达式、函数、别名
        3. order by 一般放在查询语句的最后面, limit字句除外
 */
USE myemployees;

# 案例1: 查询员工工资, 要求工资从高到低排序
SELECT *
FROM employees
ORDER BY salary DESC;

SELECT *
FROM employees
ORDER BY salary;

# 案例2:拆线呢部门编号>=90的员工信息, 按入职时间的先后进行排序(添加筛选条件)
SELECT *
FROM employees
WHERE department_id >= 90
ORDER BY hiredate;

# 案例3:按年薪的高低显示我们员工的信息和年薪【按表达式排序】
SELECT last_name, salary * 12 + IFNULL(commission_pct, 0) AS yearMoney
FROM employees
ORDER BY salary * 12 + IFNULL(commission_pct, 0) DESC;

# 案例4 按年薪的高低显示我们员工的信息和年薪【按别名排序】
SELECT last_name, salary * 12 + IFNULL(commission_pct, 0) AS yearMoney
FROM employees
ORDER BY yearMoney DESC;

# 案例5: 按姓名的长度来显示员工的姓名和工资【按函数排序】
SELECT last_name, salary, LENGTH(last_name) AS 字节长度
FROM employees
ORDER BY LENGTH(last_name);

# 案例6: 查询员工信息, 要求先按工资排序, 再按员工编号排序【按多个字段排序】
SELECT last_name, salary, employee_id
FROM employees
ORDER BY salary, employee_id DESC;
