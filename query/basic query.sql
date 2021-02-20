# 进阶1: 数据查询
/*
    语法
    select 查询列表
    from 表名;

    类似于: System.out.println(打印东西);

    - 查询列表可以是: 表中的字段、常量值、表达式、函数
    - 查询的结果是一个虚拟的表格, 不是真实存在的
*/

-- 打开指定的库
USE myemployees;

-- 1.查询单个字段
SELECT last_name
FROM employees;

-- 2.查询表中的多个字段
SELECT last_name, salary, email
FROM employees;

-- 3.查询表中所有字段
SELECT *
FROM employees;

-- 4.查询常量值
SELECT 'shit';
SELECT 123;

-- 5.查询表达式
SELECT 100 * 98;

-- 6.查询函数
SELECT version();

-- 7.为字段起别名
SELECT version() AS result;
-- 方式一: 使用AS
SELECT last_name AS lastname, first_name AS firstname
FROM employees;
-- 方式二: 使用空格
SELECT last_name lastname, first_name firstname
FROM employees;
#案例: 查询salary, 显示结果为out put(要加上单引号)
SELECT salary AS 'out put'
FROM employees;
/*
    好处:
    - 便于理解
    - 如果查询字段有重名的情况, 可以用取别名来解决
*/

-- 8.去重
# 案例: 查询员工表中涉及到的所有部门编号

-- 未去重
SELECT department_id
FROM employees;

-- 去重
SELECT DISTINCT department_id
FROM employees;

-- 9. + 号的作用
/*
    java中的加号
    - 运算符
    - 连接符

    mysql中的加号
    仅仅只有一个功能, 那就是运算符
    - select 100 + 90; 两个操作数都是数值型, 则做加法运算
    - select '100' + 90; 有一方为字符型, 会试图将字符型转化为数值型,
                        如果转化成果则作加法运算
    - select 'shit' + 90; 如果转换失败会变为0;
    - select null + 10; 只有一方为null 则变为null

    mysql中的CONCAT(函数)
    - select concat('a', 'b', 'c');
*/
# 案例: 查询员工名和性链接成一个字段并显示为姓名
SELECT CONCAT(first_name, ' ', last_name) AS name
FROM employees;

