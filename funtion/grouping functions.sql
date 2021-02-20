USE myemployees;
# 分组函数
/*
 功能: 做统计使用，又称为聚合函数或者统计函数或者组函数

 分类:
 sum 求和、avg 平均值、max 最大值、 min 最小值、 count 计算个数

 特点:
    1.  >> sum, avg 一般处理数值类型
        >> max, min, count 可以处理任何类型
    2. 是否忽略null?
        >> sum, avg, min, max, count都忽略null
    3. 可以和distinct搭配使用?
        >> sum, avg, min, max, count都可以和distinct搭配使用
    4. count 函数的详细介绍
        >> count(*) 查询个数
    5. 和分组函数一同查询的字段一般要求是group by 后字段
 */

# 1. 简单的使用
SELECT SUM(salary) AS 'sum of salary'
FROM employees;

SELECT AVG(salary) AS 'AVG of salary'
FROM employees;

SELECT MAX(salary) AS 'MAX of salary'
FROM employees;

SELECT MIN(salary) AS 'MIN of salary'
FROM employees;

SELECT COUNT(salary) AS 'COUNT of salary'
FROM employees;

# 2. 参数支持哪些类型

-- sum,avg只支持数值类型
SELECT SUM(last_name), AVG(last_name)
FROM employees;
SELECT SUM(hiredate), AVG(hiredate)
FROM employees;

-- min,max支持字符型、日期型
SELECT MAX(last_name), MIN(last_name), COUNT(last_name)
FROM employees;
SELECT MAX(hiredate), MIN(hiredate)
FROM employees;

-- count不管类型, 计算的是非空的值
SELECT COUNT(commission_pct), COUNT(salary)
FROM employees;

SELECT commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

# 3. 是否忽略NULL
/*
    null参与运算的话null与任何数运算都为null, 因此sum中null不参与运算
    通过实践AVG也不计入null的运算
 */
SELECT SUM(commission_pct),
       AVG(commission_pct),
       SUM(commission_pct) / 35,
       SUM(commission_pct) / 107
FROM employees;

# 4. 和distinct搭配
SELECT SUM(DISTINCT salary), SUM(salary)
FROM employees;

SELECT COUNT(DISTINCT salary), COUNT(salary)
FROM employees;

# 5. count 函数的详细介绍
SELECT COUNT(commission_pct)
FROM employees;

SELECT COUNT(*)
FROM employees;

SELECT COUNT(1)
FROM employees;
/*
 效率:
    MYISAM 存储引擎下, count(*) 效率最高
    INNODB 存储引擎下, count(*) 和 count(1) 最高
 */


# 6. 和分组函数一同查询的字段有限制
SELECT AVG(salary), employee_id
FROM employees;