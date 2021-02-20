# 进阶2: 条件查询
/*
    语法
        select 查询列表 - 3
        from 表名 - 1
        where 筛选条件; - 2

    分类
        - 按条件表达式筛选
            条件运算符: > < = != <> >= <=
        - 按逻辑表达式筛选
            逻辑表达式作用: 用于链接条件表达式
            逻辑运算符: &&  || !
                      and or not (标准)
        - 模糊查询
            like
            between and
            in
            is null
 */

USE myemployees;

# 1.按条件表达式筛选

-- 查询工资大于12000的员工信息
SELECT *
FROM employees
WHERE salary > 12000;

-- 查询部门编号不等于90号的员工名和部门编号
SELECT CONCAT(first_name, ' ', last_name) AS name, department_id AS department
FROM employees
WHERE department_id <> 90;

# 2.按逻辑表达式筛选

-- 查询工资在10000到20000之间的员工名字
SELECT last_name, salary, IFNULL(commission_pct, 0)
FROM employees
WHERE salary < 20000
  and salary > 10000;

-- 查询部门编号不是在90到110之间的, 或者工资高于15000的员工信息
SELECT salary, department_id
FROM employees
WHERE salary > 15000
   OR NOT (department_id >= 90 AND department_id <= 100);

# 3. 模糊查询
/*
 - like
    特点:
    - 一般和通配符搭配使用
        - 通配符
            - % 任意多个字符, 包含0个字符
            - _ 任意单个字符 (注意转义符号)
 - between and
 in
 is null/is not null
 */

-- (like)查询员工名中包含字符a的员工信息
SELECT *
FROM employees
WHERE last_name LIKE '%a%';
-- 类似正则表达

-- (like)查询员工名中第二个字符为a的员工名和工资
SELECT last_name, salary
FROM employees
WHERE last_name like '_a%';

-- (like)查询出员工名中第二个字符为_的员工名
SELECT last_name
FROM employees
# WHERE last_name like '_\_%';
WHERE last_name like '_$_%' ESCAPE '$';

-- (between and)查询员工编号在100到120之间的所有员工信息
SELECT *
FROM employees
WHERE employee_id BETWEEN 100 AND 120;
#[100, 120]
/*
    - 使用between and可以提高语法的简洁度
    - 包含临界值
    - 这两个值不可以颠倒顺序 --> between 小 and 大
*/

-- (in) 查询员工工种编号是 IT_PROG、AD_VP、AD_PRES 中的一个的员工名、工种编号
SELECT last_name, job_id
FROM employees
WHERE job_id IN ('IT_PROG', 'AD_VP', 'AD_PRES');
/*
    含义: 用于判断某字段的值是否属于in列表中的某一项
    - in比使用or提高了语句简洁度
    - in列表的值类型必须统一、兼容
    - 不支持通配符匹配, 只是=
*/

-- (IS NULL)查询没有奖金的员工名和奖金率
SELECT last_name, commission_pct
FROM employees
WHERE commission_pct IS NULL;

-- (IS NOT NULL)查询有奖金的员工名和奖金率
SELECT last_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

/*
    注意:
    - '=', '<>' 不能用于判断NULL
    - IS NULL/IS NOT NULL 可以用于判断NULL
*/

# 安全等于 <=>
-- (<=>)查询没有奖金的员工名和奖金率
SELECT last_name, commission_pct
FROM employees
WHERE commission_pct <=> NULL;
-- 查询工资为12000的员工信息
SELECT *
FROM employees
WHERE salary <=> 12000;

# is null PK <=>
/*
 IS NULL: 只可判断NULL, 可读性较高
 <=>: 可以判断NULL, 又可以判断普通数值
 */