select * from employees order by employee_id desc;

drop table ex3_3;

rollback;

desc ex3_3;

select * from ex3_3;

select * from sales;

select trunc(amount_sold,1) from sales;
select round(amount_sold,-1) from sales;

select mod(11,2) from dual;

select employee_id from employees where mod(employee_id, 2)=1;
// employee_id, 홀수|짝수"홀짝비교" 라고 출력을 해 보세요
// 컬럼은
// employee_id, 홀수, emp_name

select employee_id,
case when mod(employee_id,2)=1 then '홀수'
else '짝수'
end "홀짝비교",
emp_name 
from employees
where mod(employee_id, 2)=1;

// lower : 대소문자 전부 소문자로 치환
select * from employees where lower(emp_name) = 'william smith';    

// upper : 대소문자 전부 대문자로 치환
select * from employees where upper(emp_name) = 'WILLIAM SMITH'; 

// 대문자로 출력하기
select upper(emp_name) from employees where emp_name='William Smith';

// 소문자로 출력하기
select lower(emp_name) from employees where emp_name='William Smith';

// 첫부분만 대문자로 출력하기
select initcap(emp_name) from employees where emp_name='William Smith';

// concat ||
select concat('ezen','academy'),'HAPPY'||'birthday to you' from dual;

select concat(emp_name, email) from employees;

create table ex01(
    id varchar2(4),
    f_name varchar2(2),
    name varchar2(4),
    gender varchar2(2),
    tel1 number(3),
    tel2 number(4),
    tel3 number(4),
    birth number(6),
    address varchar2(10)
);

desc ex01;

insert into ex01 values ('a001', '이', '순신', '남', 010, 1111, 1111, 880101, '서울');
insert into ex01 values ('a002', '유', '관순', '여', 010, 2222, 2222, 780401, '부산');
insert into ex01 values ('a003', '김', '유신', '남', 010, 3333, 3333, 680701, '경주');
insert into ex01 values ('a004', '최', '영희', '여', 010, 4444, 4444, 981001, '광주');
insert into ex01 values ('a005', '안', '창호', '남', 010, 5555, 5555, 990201, '대전');

alter table ex01 modify tel1 varchar2(3);

// 영어로 칼럼명 지정하려면 as tel, 한글이면 "연락처"
select id, concat(f_name, name)"이름", gender, tel1 ||'-'|| tel2 ||'-'|| tel3 as tel, birth, address from ex01;

select * from ex01;

select substr(birth, 5, 2) from ex01;
// 11~2월 겨울, 3~5 봄, 6~8 여름, 9~11 가을
// 성+이름, 생년월일, 월, 계절 출력

// any 쓰면 or 라고 생각하면 됨
select concat(f_name, name), birth, substr(birth, 3, 2)"월",
case when substr(birth, 3, 2) = any('12','01','02') then '겨울'
when substr(birth, 3, 2) = any('03','04','05') then '봄'
when substr(birth, 3, 2) = any('06','07','08') then '여름'
else '가을'
end "계절"
from ex01;

// employees 테이블에서 입사일이 3월인 직원의 이메일을 출력하시오.
select * from employees;

select email, hire_date from employees
where substr(hire_date, 4,2) = '03';

// substr ,a번째 자리부터, b는 a번째부터 b개 자리까지
// substrb 는 byte 단위
select substr('나는행복합니다', 2, 4), substrb('나는행복합니다', 2, 4) from dual;

// ltrim
select ltrim('ABCDEFGABC', 'ABC') from dual;

// 왼쪽 공백 제거
select ltrim('     abcdefg     ') from dual;

// 오른쪽 공백 제거
select rtrim('     abcdefg     ') from dual;

// 왼쪽 오른쪽 공백 제거
select ltrim(rtrim('     abcdefg     ')) from dual;

// 왼쪽 오른쪽 공백 제거
select trim('     abcd efg     ') from dual;

// trim('제거하기 위한 본문', '제거하려는 내용') 만약 제거하려는 내용이 없으면 공백만 제거
select ltrim('010-9999-9999','0') from dual;

// lpad('본문', '본문 왼쪽에 추가하려는 내용')
desc ex01;

alter table ex01 add fax varchar2(10);

select * from ex01;

rollback;

commit;

update ex01 set fax='1111-1111' where id='a001';
update ex01 set fax='2222-2222' where id='a002';
update ex01 set fax='3333-3333' where id='a003';
update ex01 set fax='4444-4444' where id='a004';
update ex01 set fax='5555-5555' where id='a005';

create table ex02 (
    s_id varchar2(4),
    s_name varchar2(6),
    gender varchar2(2),
    tel varchar2(13),
    birth number(6),
    address varchar2(4),
    fax varchar2(10) 
);

alter table ex02 modify s_name varchar2(10);

insert into ex02(s_id, s_name, gender, tel, birth, address, fax)
select id, f_name || name, gender, tel1 ||'-'|| tel2 ||'-'|| tel3, birth, address, fax
from ex01;

select * from ex02;

rollback;

commit;

// 왼쪽에 추가
select lpad(fax, 12, '02-') from ex02;

update ex02 set lpad(fax, 12, '02-') where address='서울';

select s_id, s_name, gender,
case when address='서울' then lpad(tel, 16, '02-')
when address='부산' then lpad(tel, 16, '051-')
when address='경주' then lpad(tel, 16, '052-')
when address='광주' then lpad(tel, 16, '041-')
when address='대전' then lpad(tel, 16, '053-')
end as address
from ex02;


select s_id, s_name, address,
case when address='서울' then lpad(address, 10, '당첨')
else '꽝'
end "당첨결과"
from ex02;

// replace 변환
select replace('나는너를 모르는데 너는 나를 알겠는가' ,'나', '너') from dual;

select replace(s_name, '이', '김') from ex02 where s_name='이순신';

// employees 테이블에서 m이 들어가있는 이름을 aa로 변경해서 출력
select replace(emp_name, 'm', 'aa') from employees;

select replace('         aaa          bbb              ', '  ', '') from dual;

select replace(emp_name, ' ', '') from employees;


select * from employees;

select phone_number,
translate(phone_number, '.', '-'),
hire_date,
translate(hire_date, '/', '-')
from employees;

select job_id,
translate(job_id, 'ST_CLERK', 'SM_CLERK')
from employees;

select a.employee_id, a.job_id, b.job_title,
case when a.job_id = 'ST_MAN' then a.email || '@st.com'
when a.job_id = 'MK_REP' then a.email || '@mk.com'
when a.job_id = 'SA_MAN' then a.email || '@sa.com'
else a.email ||'@ssg.com'
end "이메일"
from employees a, jobs b
where a.job_id = b.job_id;

// instr('본문 내용', '찾고싶은 내용')
// instr('본문 내용', '찾고싶은 내용', 숫자가 있을 경우 그 자리 숫자에서부터 찾음)
select instr('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5) from dual;

select instr('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5,2) from dual;

// length
select lengthb('대한민국') from dual;

select job_id, email,
case when job_id = 'ST_MAN' then rpad(email, length(email)+7, '@st.com')
when job_id = 'MK_REP' then rpad(email, length(email)+7, '@mk.com')
when job_id = 'SA_MAN' then rpad(email, length(email)+7, '@sa.com')
else rpad(email, length(email)+7, '@ssg.com')
end as email
from employees;

// sysdate : 현재 시간

select sysdate, systimestamp from dual;

select (sysdate - hire_date)/365"총 근무일수" from employees;

select 'D-DAY : ' || trunc((to_date('22/11/01') - sysdate)/365) from dual;

// add-months 날짜에 달을 더해줄때 사용하는 함수
select add_months(sysdate,1) "다음달", sysdate "이번달", add_months(sysdate,-1) "지난달"
from dual;

select sysdate+1, sysdate-1 from dual;

select hire_date, add_months(hire_date,1) from employees;

// months_between 날짜와 날짜 사이의 개월수를 계산하는 함수
select months_between(sysdate, hire_date) from employees;

select trunc(sysdate-hire_date, 2) from employees;

select months_between('22/11/01', sysdate) from dual;

// last_day
select last_day(hire_date) from employees;

// emploees 테이블에서 각 사원이 현재까지 받은 월급을 계산하시오
// 월급 금액은 현재 월급으로 계산할 것(소수점 올림)
select months_between(sysdate, hire_date)"개월",
months_between(sysdate, hire_date)*salary"월급"
from employees;

// 근무년수에 따라 차등 계산
// 입사일부터 10년까지 현재 salary에서 -6% 차감
// 11년부터 15년까지 현재 salary에서 -3% 차감
// 이후 salary로 계산
select months_between(sysdate, hire_date)"개월", 
case when  then (months_between(hire_date+'120/00/00' ,hire_date)*salary)*-6%
