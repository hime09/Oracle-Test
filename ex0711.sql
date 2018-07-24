# oracleTest
create table result (
    stu_id number(3),
    stu_name varchar2(20),
    kor number(3),
    eng number(3),
    math number(3),
    ave number(3,2),
    total number(3),
    rank number(3)
);

desc result;

ALTER table result modify stu_id varchar2(3);

desc result;

alter table result modify stu_id number(3);

desc result;

insert into result(stu_id, stu_name, kor, eng, math, ave, total, rank) values(1,'홍길동',80,80,80,'','','');

commit;

select stu_id,stu_name,kor,eng,math,ave,total,rank from result;

select stu_id,stu_name,kor,eng,math,(kor+eng+math)/3"평균",(kor+eng+math)"합계",rank from result;

// stu_id not null 추가
alter table result modify(stu_id number(3) not null);

desc result;

select * from result;

select stu_id, stu_name, kor, eng, math, (kor+eng+math)/3 as pyungGyun, (kor+eng+math) as hapgye from result;

// order by 내림차순, +desc 오름차순
select * from employees order by employee_id desc;

// where 조건
select employee_id, salary from employees where employee_id>150 and salary>8300;

select * from employees where salary=9500;

select * from employees where salary>10000 and department_id=80;

select distinct department_id from employees;

select * from departments;

select employees.department_id, departments.department_name from employees, departments where employees.department_id=departments.department_id;

select * from employees where employees.job_id='sa_rep' or employees.employee_id>=140 order by employee_id desc;

select * from jobs;
select * from employees;

select employees.job_id, jobs.job_title from employees, jops where employees.job_id = jobs.job_id;

select * from departments;

select a.department_id,a.department_name,a.manager_id,b.emp_name "매니저 이름"
from departments a,employees b where a.manager_id = b.employee_id;

select emp_name from employees where employee_id=200;

select a.prod_id, a.cust_id, b.cust_name, a.channel_id, a.employee_id, c.emp_name
from sales a, customers b, employees c;

select * from sales;

select employee_id, emp_name, salary*1121, salary*1121*12 "연봉" from employees;

select * from employees where hire date > "00/03/19";

insert into result values(1,'김개똥',82,99,89,'','','');

insert into result values(2,'김소똥',99,100,100,'','','');

insert into result values(3,'김말똥',89,97,95,'','','');

select stu_id,stu_name,kor,eng,math,(kor+eng+math)/3"평균",(kor+eng+math)"합계" from result;

select * from result;

delete from result stu_id where stu_id=3;

create table result2 (
    stu_id number(3),
    stu_name varchar2(20),
    major varchar2(20),
    kor number(3),
    eng number(3),
    math number(3),
    sci1 number(3),
    sci2 number(3),
    ave number(3),
    sco_sum number(3)
);

select * from result2;

desc result2;

commit;

alter table result2 modify stu_name varchar2(20);

insert into result2 values (1,'홍길동','이과',100,80,90,90,'','','');
insert into result2 values (2,'유관순','문과',100,90,90,'',100,'','');
insert into result2 values (3,'이순신','이과',100,100,100,100,'','','');

select stu_id,stu_name,kor,eng,math,sci1,sci2,(kor+eng+math+sci1+sci2)/5"평균",(kor+eng+math+sci1+sci2)"합계" from result2;

update result2 set kor=87, eng=97, math=100, sci1=88 where stu_id=1;

select * from result2;

rollback;

commit;

// 롤백이 되지 않는 삭제
TRUNCATE TABLE result;

select * from employees;

select salary"기본급", salary*12"연봉",salary+(salary*nvl(commission_pct,0))"이달의 월급" from employees;

create table join (
    id varchar2(10),
    pass varchar2(10),
    name varchar2(20),
    p_num1 varchar2(3),
    p_num2 number(4),
    p_num3 number(4),
    address varchar2(50),
    email varchar2(20)
);

select * from join;

desc join;

insert into join values ('aaa','a11','홍길동','010','8912','3456','서울','aaa@google.com');
insert into join values ('bbb','b22','이순신','010','9123','4567','부산','bbb@google.com');
insert into join values ('ccc','c33','김유신','010','1234','5678','광주','ccc@google.com');


// 번호 사이에 다른거 넣어서 연결하기
select p_num1||'-'||p_num2||'-'||p_num3"국제전화" from join;

alter table join add idc varchar2(3);

DELETE FROM join idc;

rollback;

select idc||')'||p_num1||'-'||p_num2||'-'||p_num3"국제전화" from join;

select emp_name from employees where salary <> 10000;

select emp_name, salary,
case when salary <= 5000 then 'c등급'
when salary > 5000 and salary <10000 then 'b등급'
when salary >= 10000 and salary < 11000 then 'a등급'
else 'a+등급'
end "월급 등급표"
from employees;

// 등급 나누는 방식
select emp_name,
case when employee_id <=140 then '1번차로 이동'
when employee_id > 140 and employee_id <=180 then '2번차로 이동'
else '3번차로 이동'
end "차번호"
from employees;

commit;

create table result3 (
    name varchar2(10),
    java number(3),
    html number(3),
    javascript number(3),
    oracle number(3),
    ave number(3),
    sum number(3),
    grade varchar2(10)
);

desc result3;

insert into result3 values ('강현석',90,100,100,90,'','','');
insert into result3 values ('김민규',98,95,90,90,'','','');
insert into result3 values ('홍길동',82,79,99,81,'','','');
insert into result3 values ('이순신',70,75,81,79,'','','');

select * from result3;

select name,java,html,javascript,oracle,(java+html+javascript+oracle)/4"평균",(java+html+javascript+oracle)"합계",
case when (java+html+javascript+oracle)/4 >= 90 then 'A'
when (java+html+javascript+oracle)/4 < 90 and (java+html+javascript+oracle)/4 >= 80 then 'B'
when (java+html+javascript+oracle)/4 < 80 and (java+html+javascript+oracle)/4 >= 70 then 'C'
when (java+html+javascript+oracle)/4 < 70 and (java+html+javascript+oracle)/4 >= 60 then 'D'
else 'F'
end "성적 등급"
from result3;

// 사이값 조건식
select salary from emplyees where salary > 5000 and salary < 7000);
select salary from emplyees where salary between 5000 and 7000);

// or 조건식
select salary from emplyees where salary = 5000 or salary = 7000);
select salary from emplyees where salary = any(5000,6000,7000);
select salary from emplyees where salary = some(5000,6000,7000);
select salary from emplyees where salary in(5000,6000,7000);

// and 조건식
select salary from emplyees where salary = all(5000,6000,7000);

select emp_name from employees where manager_id = 148 or manager_id = 149;
select emp_name from employees where salary > 4000 and salary < 8000;

select emp_name, hire_date from employees where hire_date >= '05/09/21' and hire_date <= '07/12/31';

select emp_name, employee_id from employees where employee_id = 100 or employee_id = 150 or employee_id = 160 or employee_id = 170;

desc employees;
