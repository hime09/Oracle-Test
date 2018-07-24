select department_id, b.department_name, (avg(a.salary))
from employees a
inner join departments b
using(department_id)
group by department_id, b.department_name
having avg(a.salary) = (select max(avg(a.salary)) from employees a group by department_id);

select a.department_id, b.department_name, avg(a.salary)
from employees a, departments b
where a.department_id = b.department_id
group by a.department_id, b.department_name
having avg(salary) = (select max(avg(salary)) from employees group by department_id);

// 입사일이 2003/01/01 이후 사원들 (사원번호, 사원명, 부서번호, 부서명)
select a.employee_id, a.emp_name, department_id, b.department_name
from employees a
inner join departments b
on(a.department_id = b.department_id)
where a.department_id = b.department_id 
and a.hire_date >= to_date('03/01/01', 'yy/mm/dd');

select a.employee_id, a.emp_name, a.department_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id 
and a.hire_date >= to_date('03/01/01', 'yy/mm/dd')
group by a.employee_id, a.emp_name, a.department_id, b.department_name;

//사원 이름중 e 또는 o가 들어간 사원 부서들 월급 합 최대월급 (부서번호 부서명 최대합계월급)
select a.department_id, b.department_name, sum(a.salary)
from employees a, departments b
where a.emp_name like '%e%' or a.emp_name like '%o%'
and a.department_id = b.department_id
group by a.department_id, b.department_name
having sum(a.salary) = (select max(sum(salary))
from employees
where emp_name like '%e%' or emp_name like '%o%'
group by department_id);

select a.employee_id, a.emp_name, b.job_id, b.department_id
from employees a, job_history b
where a.employee_id = b.employee_id(+)
and a.department_id = b.department_id(+);

select a.employee_id, a.emp_name, b.job_id, b.department_id
from employees a
left outer join job_history b
on(a.employee_id = b.employee_id
and a.department_id = b.department_id);

select distinct(department_id) from employees
order by department_id;

create table ex01(
    emp_id number(2)
);
create table ex02(
    emp_id number(2)
);

commit;

insert into ex01 values(10);
insert into ex01 values(20);
insert into ex01 values(40);

insert into ex02 values(10);
insert into ex02 values(20);
insert into ex02 values(30);

select * from ex02;

select a.emp_id, b.emp_id
from ex01 a, ex02 b
where a.emp_id(+) = b.emp_id(+);

// 전체 출력
select a.emp_id, b.emp_id
from ex01 a
full outer join ex02 b
on(a.emp_id = b.emp_id);

// tucker(대소문자 구분 없이) 사원보다 월급 많이 받는 사원의 사원번호, 사원명, 직급, 월급 출력
select employee_id, emp_name, job_id, salary
from employees
where salary > (select salary from employees where lower(emp_name) like '%tucker%');

// 전체 평균 월급보다 더 많이 받는 사원 번호, 사원명, 부서번호, 부서명, 직급, 월급
select a.employee_id, a.emp_name, a.department_id, b.department_name, a.job_id, a.salary
from employees a, departments b
where a.salary > (select avg(salary) from employees) 
and a.department_id = b.department_id;

select a.employee_id, a.emp_name, a.department_id, b.department_name, a.job_id, c.job_title, a.salary
from employees a
inner join departments b
on(a.department_id = b.department_id)
inner join jobs c
on(a.job_id = c.job_id)
where (a.salary > (select avg(salary) from employees));

// 경리부 평균 월급보다 더 많이 받는 사람들 사원번호, 사원명, 부서번호, 부서명, 월급
select a.employee_id, a.emp_name, a.department_id, b.department_name, a.salary
from employees a, departments b
where a.department_id = b.department_id
and a.salary > (select avg(salary) 
from employees 
where department_id = 110
group by department_id);

commit;

update employees set salary = (select avg(salary) from employees);

select employee_id, salary from employees;

desc ex01;

alter table ex01 modify emp_id number(6);

rollback;

// commit시 savepoint는 전부 날라감
// table을 추가, 수정, 삭제 할 시 savepoint가 사라짐
savepoint aaa1;

update ex01 set emp_id = (select employee_id from employees where lower(emp_name) like '%tucker%');

select * from ex01;

update ex01 set emp_id = 100;

savepoint aaa2;

update ex01 set emp_id = 200;

// 원하는 savepoint로 롤백함
rollback to aaa1;

commit;

// 부서별 급여평균이 10000보다 큰 부서의 직원들
select employee_id, emp_name, salary
from employees
where department_id in(select department_id
from employees 
group by department_id
having avg(salary) > 10000);

select department_id
from employees
group by department_id
having avg(salary) > 10000;

//
select department_id, emp_name 
from employees 
where department_id = '90' or department_id = '110';

// 부서별 급여평균이 4000보다 큰 부서 직원들 출력, clerk 직급 제외하고
select employee_id, emp_name, department_id, job_id
from employees
where lower(job_id) not like '%clerk%' and 
department_id in (select department_id
from employees 
group by department_id 
having avg(salary) > 4000);

// job_history에 속한 부서번호, 부서이름 출력
select a.department_id, a.department_name
from departments a
where exists(select * from job_history b
where a.department_id = b.department_id);









