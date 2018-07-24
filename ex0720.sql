drop table exp_goods_asia;

select employees.employee_id, departments.department_id, department_name
from employees, departments
where employees.department_id(+) = departments.department_id
order by employees.employee_id;

select employee_id, department_id FROM employees;

// employee_id, department_id, department_name, job_id, job_title
select a.employee_id, a.department_id, c.department_name, b.job_id, b.job_title
from employees a, jobs b, departments c
where a.department_id = c.department_id and a.job_id = b.job_id;

// 월급이 3000 이상인 부서번호, 부서이름
select department_id, department_name
from departments a
where exists(select * from employees b
where a.department_id = b.department_id
and b.salary >= 3000);

select department_id, department_name
from departments a
where a.department_id in (select b.department_id
from employees b
where b.salary > 3000);

// 월급이 평균 월급보다 많은 사람들의 부서번호, 부서이름
select department_id, department_name
from departments a
where exists(select * from employees b
where a.department_id = b.department_id
and b.salary > (select avg(c.salary) from employees c));


