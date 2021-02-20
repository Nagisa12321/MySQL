USE myemployees;

# 1. 查询员工的姓名和部门号和年薪，按年薪降序 按姓名升序
SELECT last_name, department_id, (salary * 12 + IFNULL(commission_pct, 0)) AS 'Annual salary'
FROM employees
ORDER BY `Annual salary` DESC, LENGTH(last_name);

# 2. 选择工资不在 8000 到 17000 的员工的姓名和工资，按工资降序
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 8000 AND 17000
ORDER BY salary DESC;

# 3. 查询邮箱中包含 e 的员工信息，并先按邮箱的字节数降序，再按部门号升序
SELECT last_name, email, department_id
FROM employees
WHERE email like '%e%'
ORDER BY LENGTH(email) DESC, department_id;
