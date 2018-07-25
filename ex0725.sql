select * from kor_loan_status;

// 2013년도 충남지역 평균대출보다 큰 지역의 대출평균을 출력하시오(region, 대출평균)
select region, avg(loan_jan_amt)
from kor_loan_status
having avg(loan_jan_amt) > (select avg(loan_jan_amt) from kor_loan_status where period like '2013%' and region = '충남'
group by region)
group by region;

// 예전 부서
select employee_id, job_id from job_history;
//현재 부서
select employee_id, job_id from employees;
// 현재 부서가 변경된 사원을 출력해 보세요
select a.employee_id, a.job_id 
from employees a, job_history b
where a.job_id != b.job_id;

// 부서 변경 안된 사원 출력
select a.employee_id, a.job_id 
from employees a, job_history b
where a.job_id = b.job_id;

// employees 테이블에서 hr_rep 10%, mk_rep 12%, pr_rep 15%, sa_rep 18%, it_prog 20% 인상 출력
select a.employee_id, a.emp_name, a.department_id, b.department_name, salary, 
case job_id
when 'HR_REP' then salary*1.1 + (salary*1.1)*nvl(commission_pct,0)
when 'MK_REP' then salary*1.12 + (salary*1.12)*nvl(commission_pct,0)
when 'PR_REP' then salary*1.15 + (salary*1.15)*nvl(commission_pct,0)
when 'SA_REP' then salary*1.18 + (salary*1.18)*nvl(commission_pct,0)
when 'IT_PROG' then salary*1.2 + (salary*1.2)*nvl(commission_pct,0)
else salary + salary*nvl(commission_pct,0)
end "인상분 월급"
from employees a, departments b
where a.department_id = b.department_id;

// 2001년 입사자 5%, 2002년 입사자 3%, 2003년 입사자 1% 인상하여 인상 전,후 월급 출력 커미션도
select a.employee_id, a.emp_name, a.department_id, b.department_name, a.hire_date, salary"인상 전 월급", 
case to_char(hire_date, 'yy')
when '01' then salary*1.5 + (salary*1.5)*nvl(commission_pct,0)
when '02' then salary*1.3 + (salary*1.3)*nvl(commission_pct,0)
when '03' then salary*1.1 + (salary*1.1)*nvl(commission_pct,0)
else salary + salary*nvl(commission_pct,0)
end "인상 후 월급"
from employees a, departments b
where a.department_id = b.department_id;

// 사원의 전체 평균월급보다 많이 ㅂ다는 사원이 속한 부서
select a.department_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id
and salary > (select avg(salary) from employees)
group by a.department_id, b.department_name;

select department_id, department_name
from departments a
where exists(select * from employees b where a.department_id = b.department_id
and salary > (select avg(salary) from employees));

// 부서별 급여합계에 따라 합계금액이 1000000 이상은 최고, 500000이상 상, 10000 중, 미만 하등급 표시
select department_id, sum(salary), 
case 
when sum(salary) > 100000 then '최고'
when sum(salary) > 50000 then '상'
when sum(salary) > 10000 then '중'
else '하'
end
from employees
group by department_id;
// from 뒤에 select 문을 넣어서 출력
select department_id, sum_s, 
case 
when sum_s > 100000 then '최고'
when sum_s > 50000 then '상'
when sum_s > 10000 then '중'
else '하'
end
from(select department_id, sum(salary) as sum_s from employees
group by department_id
order by department_id);

// departments 테이블에서 상위부서(parent_id) 90인 사원들 부서별 평균 월급
select department_id, avg(salary)
from employees
where department_id in(select department_id from departments
where parent_id = 90)
group by department_id;

// 2005년 이전 입사한 사원 중 job_id mgr이 포함된 사원은 15%, man 포함은 20%
// 2005년 이후 mgr은 25%
select emp_name, salary,
case 
when to_char(hire_date,'yyyy') < '2005' then salary*1.15
when to_char(hire_date,'yyyy') > '2005' then salary*1.25
end
from employees
where job_id like '%mgr%'

union

select emp_name, salary,
case when to_char(hire_date,'yyyy') > '2005' then salary*1.2 
end
from employees
where job_id like '%man%';

// 연도별 sales 테이블에서 찾기 이탈리아
select substr(sales_month,1,4),c.country_name, sum(amount_sold)
from sales a, customers b, countries c
where a.cust_id = b.cust_id and b.country_id = c.country_id and c.country_name = 'Italy'
group by substr(sales_month, 1, 4), c.country_name;

// 연도별 합계 최고합계금액 출력
select substr(sales_month, 1, 4), sum(amount_sold)
from sales a, customers b, countries c
where a.cust_id = b.cust_id and b.country_id = c.country_id
group by substr(sales_month, 1, 4)
having sum(amount_sold) = (
select max(sum(amount_sold))
from sales a, customers b, countries c
where a.cust_id = b.cust_id and b.country_id = c.country_id
group by substr(sales_month, 1, 4)
);

select years,
max(amount_sold)
from (
select substr(a.sales_month, 1, 4) as years, a.employee_id, sum(a.amount_sold) as amount_sold
from sales a, customers b, countries c
where a.cust_id = b.cust_id and b.country_id = c.country_id and c.country_name = 'Italy'
group by substr(a.sales_month, 1, 4), a.employee_id)
group by years;









