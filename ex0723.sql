select goods
from exp_goods_asia
where country = '한국'
union
select goods
from exp_goods_asia
where country = '일본';

// kor_loan_status 테이블에서 2013년 월별로 댗울합계 출력
select period, gubun, sum(loan_jan_amt)
from kor_loan_status
where period like '2013%'
group by rollup(period, gubun);

// employees 테이블에서 부서별 월급합계를 출력하시오
select job_id, sum(salary)
from employees
group by job_id;

// 입사년도별 소계
// 부서번호, 부서명, 입사년도, 부서별 우러급 합계
select a.department_id, b.department_name, a.hire_date, a.sum(salary)
from employees a, departments b
where rollup(a.department_id, to_char(a.hire_date,'yyyy')) and a.department_id = b.department_id;

// 부서별 월급 평균이 가장 높은 평군월급
// 부서번호, 부서명, 가장 높은 월급 평균
select a.department_id, b.department_name, max(a.salary)
from employees a, departments b
where a.department_id = b.department_id;

select emp_name, salary
from employees
where salary > (select min(salary)
from employees
where department_id=30
group by department_id
);

// manager_id가 null이 아닌 직원의 department_id, 사원이름, 부서번호, 부서이름
select a.employee_id, a.emp_name, a.department_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id
and a.department_id in 
(select department_id 
from departments 
where manager_id is not null);

// employees테이블에서 사원번호, 사원이름, 매니저아이디, 매니저 이름
select a.employee_id, a.emp_name, a.manager_id, b.emp_name
from employees a, employees b
where b.employee_id = a.manager_id;

// department 테이블, job_history 테이블에서 부서번호, 부서명, 잡번호, 부서번호
select a.department_id, a.department_name, b.job_id, b.department_id
from departments a, job_history b
where a.department_id = b.department_id(+);

create table ex01(
    subject varchar2(20),
    score number(3)
);

create table ex02(
    subcode varchar2(20),
    score number(3)
);

insert into ex01 values('국어', 100);
insert into ex01 values('영어', 100);
insert into ex01 values('수학', 100);

insert into ex02 values('b0001', 5);
insert into ex02 values('b0002', 5);
insert into ex02 values('b0003', 5);

commit;

select a.employee_id, a.emp_name, a.department_id, b.department_name
from employees a, departments b
where a.department_id(+) = b.department_id;

// employees 테이블과 job_history 테이블에서 사원번호, 사원이름, 잡번호, 부서번호 출력
select a.employee_id, a.emp_name, b.job_id, b.department_id
from employees a, job_history b
where a.department_id = b.department_id(+) and a.employee_id = b.employee_id(+);

// 2003/01/01 이후 입사한 사원
select a.employee_id, a.emp_name, a.department_id, b.department_name, a.hire_date
from employees a, departments b
where a.department_id = b.department_id 
and a.hire_date >= to_date('03/01/01','yy/mm/dd');

// ansi join 을 사용해서
select a.employee_id, a.emp_name, department_id, b.department_name
from employees a
inner join departments b
using(department_id)
where a.hire_date >= to_date('03/01/01','yy/mm/dd');

// 사원번호, 사원이름, 잡아이디, 잡타이틀 안시쪼인 사용
// using 안에는 두 테이블에서 서로 같은 칼럼명만 쓰면 된다. 그 두가지가 같은 내용만 출력
select a.employee_id, a.emp_name, job_id, b.job_title 
from employees a
inner join jobs b
using(job_id);

// 월급이 9000 이상 12000 이하인 사원번호, 사원이름, 부서아이디, 부서이름, 월급 출력 (안시조인 사용)
select a.employee_id, a.emp_name, department_id, b.department_name, a.salary
from employees a
inner join departments b
using(department_id)
where a.salary between 9000 and 12000;

// 부서별 평균을 구한 다음 평균 최대값
select a.department_id, b.department_name, (avg(a.salary))
from employees a, departments b
where a.department_id = b.department_id
group by a.department_id, b.department_name
having avg(a.salary) = (select max(avg(a.salary)) from employees a group by department_id);
// inner join으로 할 시
select department_id, b.department_name, (avg(a.salary))
from employees a
inner join departments b
using(department_id)
group by department_id, b.department_name
having avg(a.salary) = (select max(avg(a.salary)) from employees a group by department_id);

// departments와 job_history 테이블에서 부서번호, 부서명, 잡번호, 부서번호 출력
select department_id, a.department_name, b.job_id, department_id
from departments a
left outer join job_history b
using(department_id);

// employees 테이블과 job_history 테이블에서 직급 없는 사람들도 모두 출력(사원번호, 사원이름, 잡번호, 부서번호)
select employee_id, a.emp_name, b.job_id, b.department_id
from employees a
right outer join job_history b
using(employee_id);

select a.employee_id, a.emp_name, b.job_id, b.department_id
from employees a, job_history b
where a.employee_id(+) = b.employee_id
and a.department_id(+) = b.department_id;














