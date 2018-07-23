// 2달 후와 같은 달에 입사한 사람들 
select * from employees
where substr(add_months(sysdate,2), 4,2) = substr(hire_date, 4,2);

select hire_date from employees
where substr(hire_date, 4,2) = '09';

// next_day : 정해진 날로부터 다가올 날에 있는 날짜를 찾는 식
select next_day(sysdate,'일요일') from dual;

select next_day(hire_date,'일요일') from employees;

// 입사일 마지막 날
select last_day(hire_date) from employees;

// 이번달 일자에 salary를 나눠서 일당이 얼마인지
select round(salary/to_number(substr(last_day(sysdate),7,2)),2) from employees;

select * from employees;

// 날짜 변환 함수
// 월드컵 2022년 11월 21일
select to_date('22/11/21') - sysdate from dual;

select months_between(sysdate, hire_date) from employees;

create table membership(
    mem_id varchar2(4),
    name1 varchar2(2),
    name2 varchar2(4),
    phone1 varchar2(3),
    phone2 varchar2(4),
    phone3 varchar2(4),
    tel varchar2(10),
    gender varchar2(4),
    address varchar2(20),
    habby varchar2(20),
    mem_date varchar2(10),
    birth varchar2(10)
);

desc membership;

commit;

insert into membership values('a001', '이', '순신', '010', '1111', '1111', '1234-1234', '남', '서울', '책보기', '2018-07-17', '2000-12-31');
insert into membership values('a002', '유', '관순', '010', '2222', '2222', '2345-2345', '여', '경기', '운동', '2018-07-17', '1999-03-01');
insert into membership values('a003', '김', '유신', '010', '3333', '3333', '3456-3456', '남', '경울', '말타기', '2018-07-17', '1988-07-17');
insert into membership values('a004', '안', '창호', '010', '4444', '4444', '4567-4567', '남', '광기', '사격', '2018-07-17', '1977-09-20');
insert into membership values('a005', '최', '영희', '010', '5555', '5555', '5678-5678', '여', '대전', '여행', '2018-07-17', '2001-01-30');

update membership set name1='최' where mem_id='a001';
update membership set name1='김' where mem_id='a002';
update membership set name1='이' where mem_id='a003';
update membership set habby='영화보기' where mem_id='a001';
update membership set phone2='8888' where mem_id='a004';
update membership set phone3='8888' where mem_id='a004';

select * from membership;

select mem_id"아이디", concat(name1, name2)"이름", phone1 || '-' || phone2 || '-' || phone3"연락처", gender"성별" from membership
where gender='남' and substr(birth, 6,2) = '07';

select mem_id, concat(name1, name2) as name, gender,
case when address='서울' then lpad(phone1 || '-' || phone2 || '-' || phone3 as phone, '02-')
when address='경기' then lpad(phone1 || '-' || phone2 || '-' || phone3 as phone, '031-')
when address='경주' then lpad(phone1 || '-' || phone2 || '-' || phone3 as phone, '053-')
when address='광주' then lpad(phone1 || '-' || phone2 || '-' || phone3 as phone, '041-')
when address='대전' then lpad(phone1 || '-' || phone2 || '-' || phone3 as phone, '063-')
from membership;

select to_char(12345,'$999,999,999') from dual;

select to_char(salary, '$999,999,999') from employees;

// 실월급 계산 (salary + salary * 커미션) 앞에는 $ 표시, 3자리마다 ,를 사용해 출력
select to_char(sysdate, 'yyyy-mm-dd') from dual;

select to_char(hire_date, 'yyyy/mm/dd day time') 
from employees;

// 하계올림픽 개최(20/07/24)

select to_char(to_date('20/07/24'), 'day') from dual;

select to_char(to_number('123456'), '999,999') from dual;

select employee_id, emp_name, manager_id from employees
where manager_id is null;

select employee_id, emp_name,
case when manager_id is null then 'ceo'
else to_char(manager_id)
end manager_id
from employees;

// nvl(commission_pct,0)
select employee_id, emp_name, commission_pct, nvl(commission_pct,0) from employees;

select employee_id,
nvl2(commission_pct, salary+salary*commission_pct, salary) from employees;

select employee_id, salary+salary*nvl(commission_pct,0) from employees;

select * from customers;
desc customers;

select cust_id, cust_name,
case when to_char(sysdate,'yyyy') between 30 and 39 then "30대"
when (2018 - to_number(cust_year_of_birth)) between 40 and 49 then "40대"
when (2018 - to_number(cust_year_of_birth)) between 50 and 59 then "50대"
else "60대 이상"
end
from customers;

select greatest(1,2,3,4,5,6,7) from dual;
select least(1,2,3,4,5,6,7) from dual;

select department_id, count(department_id) from employees 
group by department_id order by department_id;

// count : 수를 집계해서 반환하는 함수, null값은 집계하지 않는다
select count(*) "총인원" from employees;

select manager_id from employees;
select count(distinct manager_id) from employees;

// sum : 합계를 반환하는 함수
select to_char(sum(salary), '1000,999,999') from employees;

// avg : 평균을 구하는 함수
select avg(salary) from employees;

select * from kor_loan_status;

select period, region, sum(loan_jan_amt)
from kor_loan_status
where period like '2013%'
group by period, region;

// manager_id 그룹으로 salary 합계
select manager_id, sum(salary), avg(salary)
from employees
group by manager_id;

// min : 최소값을 반환하는 함수
select min(salary) from employees;

select min(loan_jan_amt) from kor_loan_status;

// max : 최대값을 반환하는 함수
select min(salary), max(salary) from employees;
select region, max(loan_jan_amt) from kor_loan_status 
group by region
order by max(loan_jan_amt) desc;

select * from kor_loan_status
order by loan_jan_amt desc;
select max(loan_jan_amt) from kor_loan_status;

// 부서가 같은 그룹의 월급의 평균을 구하시오
select max(avg(salary)) from employees
group by department_id;

// job_id 그룹으로 월급 합계
select sum(salary) from employees
group by job_id;

// 입사일 2000년도 이상인 사람만 부서아이디 그룹으로 월급 합계
select department_id, sum(salary) from employees
where to_char(hire_date, 'yyyy') > '2000'
group by department_id;

desc kor_loan_status;

// kor_loan_status 테이블에서 2011년도 지역별 대출 합계 구하기
select period, region, sum(loan_jan_amt)
from kor_loan_status
where substr(period,1,4) = '2011'
group by period, region
order by sum(loan_jan_amt);

// 입사일 07~12월까지의 job_id 그룹의 월급합계를 구하시오
select job_id, sum(salary) from employees
where to_char(hire_date,'mm') between '07' and '12'
group by job_id;

// 이름에 e가 들어가는 사원들의 부서별 그룹으로 월급 평균
select job_id, sum(salary) from employees
where 


// 부서 그룹으로 월급 합계, 평균, 최대, 최소 구하기
// $와 자릿수 표시. 부서 null인 경우 제외
select department_id"부서id", to_char(sum(salary), '$999,999' )"합계", to_char(avg(salary), '$999,999')"평균", to_char(max(salary), '$999,999')"최대", to_char(min(salary), '$999,999')"최소"
from employees
group by department_id;

// job_id 그룹으로  월급 합계, 평균, 최대, 최소 구하기
// 월급 계산은 salary + salary * commission_pct로 계산
// 조건 98~00년까지 입사한 사원
select employee_id, emp_name, hire_date, sum(salary + (salary*commission_pct)), avg(salary + (salary*commission_pct)), max(salary + (salary*commission_pct)), min(salary + (salary*commission_pct))
from employees
where to_char(hire_date, 'yyyy') between '1998' and '2000'
group by job_id;
