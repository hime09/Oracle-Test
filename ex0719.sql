select a.department_id, b.department_name, round(avg(a.salary),2), sum(a.salary)
from employees a, departments b
where a.department_id = b.department_id
group by a.department_id, b.department_name
order by department_id;

select employee_id, department_id, sum(salary)
from employees
group by employee_id, department_id;

// kor_loan_status 테이블에서 2013년도 기간별 대출 합계
select * from kor_loan_status;

select period, region, gubun, sum(loan_jan_amt)
from kor_loan_status
where period like '2013%'
group by region
order by region;

select max(avg(salary)) from employees group by department_id;

// 2013년 11월 총 합계

select period, region, sum(loan_jan_amt)
from kor_loan_status
where period = '201311'
group by period, region
order by period, region;

desc employees;

// employees 테이블에서 근무년수가 8~11년 이상인 직원의 job_id로 그룹하여 연봉 평균 구하시오
select job_id, hire_date, avg(salary)
from employees
where (to_char(sysdate, 'yyyy') - to_char(hire_date, 'yyyy')) between 8 and 11
group by job_id, hire_date
order by job_id, hire_date;

// sales 테이블에서 employee_id, sales_month 그룹으로 amount_sold 합계를 구하시오
select * from sales;

desc sales;

SELECT employee_id, sales_month, sum(amount_sold)
FROM sales
where employee_id between 105 and 159
group by employee_id, sales_month
having sum(amount_sold) >= 1000000
order by employee_id;

// kor_loan_status 테이블에서 지역, 기간으로 합계를 구하시오
// 단, 조건은 합계가 100000 이상인 것만 출력
select period, region, sum(loan_jan_amt)
from kor_loan_status
where substr(period, 1, 4) in(2012,2013)
group by period, region
having sum(loan_jan_amt) >= 100000
order by period, region;

desc kor_loan_status;

select * from kor_loan_status;

select period, gubun, sum(loan_jan_amt)
from kor_loan_status
where period like '2013%'
group by rollup(period, gubun);

// employees 테이블에서 manager_id, job_id 그룹으로 월급 합계 구하기
// manager_id의 소계 포함
select manager_id, job_id, sum(salary)
from employees
group by manager_id, rollup(job_id);

// sales 테이블에서 employee_id, sales_month 그룹으로
// 입사년도 가 98~99년도까지의 사원만
// amount_sold 합계를 구하고
// sales_month 소계 나타내서 출력

select a.employee_id, a.sales_month, sum(a.amount_sold)
from sales a, employees b
where substr(b.hire_date, 1,2) between '98' and '99' and a.employee_id = b.employee_id
group by a.employee_id, rollup(a.sales_month);

select a.employee_id, a.sales_month, sum(a.amount_sold)
from sales a, employees b
where substr(b.hire_date, 1,2) between '98' and '99' and a.employee_id = b.employee_id
group by rollup(a.employee_id), a.sales_month;

commit;

create table exp_goods_asia(
    county varchar2(10),
    seq number,
    goods varchar2(80)
);

insert into exp_goods_asia values('한국', 1, '원유제와 석유제');
insert into exp_goods_asia values('한국', 2, '자동차');
insert into exp_goods_asia values('한국', 3, '전자집적회로');
insert into exp_goods_asia values('한국', 4, '선박');
insert into exp_goods_asia values('한국', 5, 'LCD');
insert into exp_goods_asia values('한국', 6, '자동차부품');
insert into exp_goods_asia values('한국', 7, '휴대전화');
insert into exp_goods_asia values('한국', 8, '환식탄화수소');
insert into exp_goods_asia values('한국', 9, '무선송신기 디스플레이 부속품');
insert into exp_goods_asia values('한국', 10, '철 또는 비합금강');

select * from exp_goods_asia;

insert into exp_goods_asia values('일본', 1, '원유제와 석유제');
insert into exp_goods_asia values('일본', 2, '자동차');
insert into exp_goods_asia values('일본', 3, '전자집적회로');
insert into exp_goods_asia values('일본', 4, '선박');
insert into exp_goods_asia values('일본', 5, '반도체웨이퍼');
insert into exp_goods_asia values('일본', 6, '화물차');
insert into exp_goods_asia values('일본', 7, '원유제와 석유류');
insert into exp_goods_asia values('일본', 8, '건설기계');
insert into exp_goods_asia values('일본', 9, '다이오드, 트랜지스터');
insert into exp_goods_asia values('일본', 10, '기계류');

alter table exp_goods_asia rename column county to country;

desc exp_goods_asia;

update exp_goods_asia set goods='자동차' where country='일본' and seq=1;
update exp_goods_asia set goods='자동차부품' where country='일본' and seq=2;

select * from exp_goods_asia;

create sequence seq_trade
increment by 1
start with 1
minvalue 1
maxvalue 1000
nocycle
nocache;

insert into exp_goods_asia(seq) values(seq_trade.nextval);

select goods from exp_goods_asia
where country = '한국'
minus
select goods from exp_goods_asia
where country = '일본'

// 합집합 union
// 모두 출력은 union all
// 교집합 intersect
// 차집합 minus

select employee_id, sales_month, sum(amount_sold)
from sales
group by grouping sets(employee_id, sales_month);

// employees 테이블에서 입사년도별 사원수
select to_char(hire_date,'yyyy'), count(*)
from employees
group by to_char(hire_date,'yyyy')      // group by 로 저 칼럼에 맞는 애들 그룹짓기
order by to_char(hire_date,'yyyy');     // order by 로 정렬

select department_id, count(*)
from employees
group by department_id;

// kor_loan_status 테이블에 연도별, 지역별 대출 합계를 구하라
// 조건은 대출합계 100000 이상
select period, region, sum(loan_jan_amt)
from kor_loan_status
where substr(period, 1, 4) = '2012' and sum(loan_jan_amt) >= 10000
group by grouping sets(period, region)
order by period;

// manager_id가 120-130 사이에 있는 사원의 job_id와 job_title을 출력하시오
select a.job_id, b.job_title
from employees a, jobs b
where a.job_id = b.job_id and a.manager_id between 120 and 130;

select department_id, department_name
from departments a
where a.department_id in(
select b.department_id from employees b
where b.salary > 3000 
);

select a.department_id, a.department_name
from departments a, employees b
where a.department_id = b.department_id and b.salary > 3000;


// manager_id가 120~130 사이에 있는 사원의 job_id, job_title을
select a.job_id, b.job_title
from employees a, jobs b
where a.job_id = b.job_id and a.manager_id between 120 and 130;



