# 进阶4: 常见函数
/*
 概念: 类似于java的方法,将一组逻辑语句封装在方法体中, 对外暴露方法名
 好处: 隐藏实现细节, 提高了代码的重用性
 调用: select 函数名 (实参列表) 【from 表】
 特点: 1. 叫什么(函数名)
      2. 干什么(函数功能)
 分类:
      1. 单行函数
        - concat, length, ifnull
      2. 分组列表
        - 功能: 做统计使用, 聚合函数、组函数

 常见函数:
    >> 字符函数
        length
        concat
        substr
        instr
        trim
        UPPER
        LOWER
        lpad
        rpad
        replace

    >> 数学函数
        round
        ceil
        floor
        truncate
        mod

    >> 日期函数
        now
        curdate
        curtime
        year
        month
        monthname
        day
        hour
        minute
        second
        str_to_date
        date_format

    >> 其他函数
        version
        database
        user

    >> 控制函数
        if
        case
 */

# 一、字符函数

# 1. length 获取参数值的字节个数
SELECT LENGTH('john');
SELECT LENGTH('哈');

SHOW VARIABLES LIKE '%char%';

# 2. concat拼接字符串
SELECT CONCAT(last_name, '_', first_name) AS 'name'
FROM employees;

# 3. upper/lower 将字符变为大小写
SELECT UPPER('jOhN');
SELECT LOWER('jOhn');
-- 案例: 将性变大写名变小写之后拼接
SELECT CONCAT(LOWER(last_name), ' ', UPPER(first_name)) AS name
FROM employees;

# 4. substr 截取字符(substring)
/*
    注意: 索引从1开始, 从第几个开始, 索引就应该写为几
 */
SELECT SUBSTR('just a test', 5);
SELECT SUBSTRING('just a test', 1 ,1);
SELECT SUBSTRING('你好', 2);

# 5. instr 用于返回字串在字符串中的第一次起始索引, 0为不存在
SELECT INSTR('just a test', 'juse') AS output;

# 6. trim 去掉前后的空格
SELECT TRIM('   te  st ') AS out_put;
SELECT TRIM('a' FROM 'aaaaaaaaSHAaaaaBIaaaa') AS out_put;

# 7. lpad 用指定的字符实现昨天冲指定长度
/*
 数字规定的是字符个数, 少的话会在前面填充第三个字符
 多的话会删除后面的字符
 */
SELECT LPAD('just a test', 20, '*');
SELECT LPAD('just a test', 10, '*');

# 8. rpad 右填充, 依然会在右边删除
SELECT RPAD('just a test', 20, '*');
SELECT RPAD('just a test', 10, '*');

# 9. replace 替换
/*
 用选定字符串替换源字符串
 如果原来没有指定字符串, 则什么都不做
 如果有多个, 全部替换
 */
SELECT REPLACE('张无忌爱上周芷若周芷若周芷若', '周芷若', '赵敏') AS outtput;
SELECT REPLACE('张无忌爱上周芷若', '周芷若', '赵敏') AS outtput;

# 二、数学函数

# 1. round 四舍五入
SELECT ROUND(1.65);
SELECT ROUND(-1.45);
SELECT ROUND(1.575, 2);

# 2. ceil 向上取正数 返回大于等于该参数的最小整数
SELECT CEIL(1.00);
SELECT CEIL(1.01);
SELECT CEIL(-1.02);

# 3. floor 向下取整, 返回<=该参数的最小整数
SELECT FLOOR(9.99);
SELECT FLOOR(-9.99);

# 4. truncate 截断
SELECT TRUNCATE(1.6999, 1);

# 5. 取余 (符号取决于被除数)
SELECT MOD(10, 3);
SELECT 10 % 3;
SELECT MOD(10, 3);


# 三、日期函数

# 1. now 返回当前日期+时间
SELECT NOW();

# 2. curdate 返回当前系统日期不包含时间
SELECT CURDATE();
SELECT CURRENT_DATE();

# 3. ccurtime 返回当前时间不包含日期
SELECT CURTIME();

# 4. 可以获取指定的部分: 年月日小时分钟秒
SELECT YEAR(NOW()) AS year;
SELECT YEAR('1999-09-16') AS year;

SELECT MONTHNAME(NOW());

# 5.str_to_date 将日期格式的字符转换成指定格式的日期
SELECT STR_TO_DATE('1999@09@16', '%Y@%m@%d');

-- 案例: 查询入职日期为1992年4月3号入职的员工信息
SELECT *
FROM employees
WHERE hiredate = '1992-04-03';

SELECT *
FROM employees
WHERE hiredate = STR_TO_DATE('1992年4月3日', '%Y年%m月%d日');

# 6. date_format 将日期转换成字符
SELECT DATE_FORMAT('1999-09-16', '%Ynian%myue%dri');

-- 查询有奖金的员工名和入职日期(xx月/xx日 xx年)
SELECT last_name, DATE_FORMAT(hiredate, '%m月/%d日 %Y年')
FROM employees
WHERE commission_pct IS NOT NULL;


# 四、其他函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();

# 五、流程控制函数
# 1. IF 函数: if else 效果 (? :)
SELECT IF(10 > 5, 'enen', 'no');
SELECT last_name, commission_pct, IF(commission_pct IS NULL, '没奖金', '有奖金') AS '备注'
FROM employees;

# 2. case 函数 的 使用 一: 类似switch case
/*
 switch(变量或者表达式) {
    case 变量值:
        语句一; break;
    ...
    default: ...
 }

 mysql 之中
 case 要判断的字段或者表达式
 when 常量1 then 要显示的值1或者语句1;
 when 常量2 ...
 ...
 else 要显示的值n或语句n;
 END
 */

/*
   案例: 查询员工的工资, 要求
   部门号 = 30, 显示的工资为1.1倍
   部门号 = 40, 显示的工资为1.2被
   部门号 = 50 ...........1.3
   其他为源工资
*/

SELECT last_name,
       department_id,
       salary,
       CASE department_id
           WHEN 30 THEN 1.1 * salary
           WHEN 40 THEN 1.2 * salary
           WHEN 50 THEN 1.3 * salary
           ELSE salary
           END
           AS `new salary`
FROM employees;


# case 函数的使用二: 类似于多重if
/*
 java中:

    if (条件1) {
        语句1;
    } else if (条件2) {
       语句2;
    }
    ...
    else {
       语句n;
    }

 mysql中
    case
    when 条件1 then 要显示的值1/语句1;
    when 条件2 then 要显示的值2;
    ...
    else 要显示的值n
    end

 */

/*
 案例: 查询员工的工资情况
 如果工资大于两万显示A级别
 如果工资大于一万五显示B级别
 如果工资大于一万显示C级别
 否则显示D级别
 */
SELECT salary,
       CASE
           WHEN salary > 20000 THEN 'A'
           WHEN salary > 15000 THEN 'B'
           WHEN salary > 10000 THEN 'C'
           ELSE 'D'
           END AS 'type'
FROM employees;
