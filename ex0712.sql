# oracleTest

create table ex01 (
    stu_id number(5) primary key,
    name varchar2(20) not null,
    major varchar2(20),
    rank number(1),
    phone1 number(3),
    phone2 number(4),
    phone3 number(4)
);

commit;

desc ex01;

alter table ex01 modify phone1 varchar2(3);

insert into ex01 values ('a0001', '홍길동', '컴퓨터공학', 3, '010', '1111', '1111');
insert into ex01 values ('a0002', '이순신', '컴퓨터공학', 4, '010', '2222', '2222');
insert into ex01(stu_id, name, major) values ('a0003', '강감찬', '컴퓨터 공학'); 

select * from ex01;

commit;

delete ex01 where stu_id = 'a0002';

select * from ex01 where rank is not null;

delete ex01 where rank is not null;

update ex01 set major='컴퓨터정보공학과' where stu_id='이순신';

insert into ex01 values ('a0001', '유관순', '영문학과', 3, '010', '8787', '8787');
insert into ex01 values ('a0002', '강감찬', '도서학과', 2, '010', '9999', '9999');
insert into ex01 values ('a0003', '김유신', '경영학과', 1, '010', '8484', '8484');

select * from ex01;

select a.employee_id, b.emp_name, a.department_id, c.department_name 
from job_history a, employees b, departments c 
where department_id between 60 and 90 and a.employee_id = b.employee_id and a.department_id=c.department_id;


// 같은 칼럼이 겹치게 나오는 경우, 테이블에 약칭을 넣어서 설정한다
select a.employee_id, a.emp_name, a.salary, a.manager_id, b.emp_name
from employees a, employees b
where a.manager_id=124 and b.employee_id = 124 and a.salary between 2000 and 3000;

commit;

// 테이블 복사하기
create table employees_02 as select * from employees;

select * from employees_02;

// 테이블 내용 제거하기
delete employees_02;

desc employees_02;

insert into employees_02 select * from employees where manager_id=147;

select * from employees_02;

drop table employees_02;

drop table ex01;

commit;

create table ex01(
    stu_id varchar2(3),
    name varchar2(20),
    kor number(3),
    eng number(3),
    math number(3),
    ave number(3),
    total number(3)
);

select * from ex01;

insert into ex01 (stu_id, name, kor, eng, math) values ('001', '홍길동', 100, 89, 95);
insert into ex01 (stu_id, name, kor, eng, math) values ('002', '이순신', 99, 92, 98);
insert into ex01 (stu_id, name, kor, eng, math) values ('003', '유관순', 88, 100, 100);

commit;

select * from ex01;

alter table ex01 add rank varchar2(3);

create table result as select * from ex01;

select * from result;

delete result;

select * from result;

insert into result (stu_id, name, kor, eng, math, ave, total) 
select stu_id, name, kor, eng, math, (kor+eng+math)/3, (kor+eng+math) from  ex01;

select * from result;

commit;

insert into result (stu_id, name, kor, eng, math) values ('004', '김유신', 88, 80, 79);
insert into result (stu_id, name, kor, eng, math) values ('005', '강감찬', 79, 75, 75);
insert into result (stu_id, name, kor, eng, math) values ('006', '안창호', 66, 65, 68);

select * from result;

select * from ex01;

delete ex01;

insert into ex01 select * from result;

delete result;

commit;

insert into result(stu_id, name, kor, eng, math, ave, total) 
select stu_id, name, kor, eng, math, (kor+eng+math)/3, (kor+eng+math)
from ex01;

select * from result;

commit;

create table result2(
    stu_id number(3),
    name varchar2(10),
    major varchar2(10),
    kor number(3),
    eng number(3),
    math number(3),
    sci1 number(3),
    sci2 number(3)
);

select * from result2;

desc result2;

insert into result2 values (001, '이순신', '이과', 100, 85, 100, 99, '');
insert into result2 values (002, '홍길동', '이과', 99, 99, 88, 80, '');
insert into result2 values (003, '안창호', '문과', 100, 70, 80, '', 80);
insert into result2 values (004, '김유신', '문과', 70, 75, 78, '', 78);
insert into result2 values (005, '강감찬', '이과', 65, 66, 69, 69, '');

select * from result2;

insert into result2 values (006, '강현석', '이과', 89, 100, 90, 100, '');
insert into result2 values (007, '이민하', '문과', 100, 100, 90, '', 90);

select * from result2;

commit;

create table stu_result as select * from result2;

select * from stu_result;

alter table stu_result add ave number(3);
alter table stu_result add sum number(3);
alter table stu_result add rank varchar2(2);

select * from stu_result;

commit;

// 아닌가보다. 임시 보류
update stu_result set sci1=0 where sci1='';

// 이것도 아닌가?
insert into stu_result (sci1) values (0) where sci1='';

select * from stu_result;

select stu_id"학번", name"이름", major"전공", kor"국어", eng"영어", math"수학", nvl(sci1,0)"과1", nvl(sci2,0)"과2", (kor+eng+math+nvl(sci1,0)+nvl(sci2,0))/4, (kor+eng+math+nvl(sci1,0)+nvl(sci2,0)),
case when (kor+eng+math+nvl(sci1,0)+nvl(sci2,0))/4 >= 90 then 'A'
when (kor+eng+math+nvl(sci1,0)+nvl(sci2,0))/4 < 90 and (kor+eng+math+nvl(sci1,0)+nvl(sci2,0))/4 >= 80 then 'B'
when (kor+eng+math+nvl(sci1,0)+nvl(sci2,0))/4 < 80 and (kor+eng+math+nvl(sci1,0)+nvl(sci2,0))/4 >= 70 then 'C'
when (kor+eng+math+nvl(sci1,0)+nvl(sci2,0))/4 < 70 and (kor+eng+math+nvl(sci1,0)+nvl(sci2,0))/4 >= 60 then 'D'
else 'F'
end "등급"
from stu_result;

// 커미션이 비지 않은 사람 찾기
select employee_id, emp_name, commission_pct from employees where commission_pct is not null;

// A로 시작되는 이름 찾기. like 뒤에는 대소문자 구분함
select emp_name from employees where emp_name like 'A%';

// a로 끝나는 이름 찾기. 마찬가지로 대소문자 구분함
select emp_name from employees where emp_name like '%a';

SELECT * FROM employees where emp_name like '%m%';

// LL이 들어가있는 모든 것
select * from employees where email like '%LL%';

// 3번째 자리에 n이 들어가는 모든 것
select * from employees where emp_name like '__n%';

select a.employee_id, a.emp_name, a.job_id, b.job_title, a.department_id, c.department_name 
from employees a, jobs b, departments c 
where a.job_id=b.job_id and a.department_id=c.department_id and b.job_title like '%n%';

select department_id, department_name from departments a
where exists (select * from employees b  where a.department_id = b.department_id and b.salary>3000);

select a.job_id, a.job_title from jobs a
where exists ( select * from employees b
where a.job_id = b.job_id and b.salary between 3000 and 12000);

select job_id, salary from employees
where exists ( select * from employees where salary between 3000 and 12000);

select distinct job_id from employees where salary between 3000 and 12000;

select salary, salary+salary*0.3 from employees;

create table employees_02 as select * from employees;

desc employees_02;

select commission_pct from employees_02;


create table ex02(
    // 8자리 숫자, 2자리까지 숫자
    id number(8,2)
);

insert into ex02 values (round(100.2345,3));

select * from ex02;

insert into ex02 values (round(100000.2345,3));

select * from employees_02;

insert into employees_02 (employee_id, emp_name, hire_date, salary) 
select employee_id, emp_name, hire_date, salary*1.005 
from employees;

select salary from employees_02;

desc employees_02;

drop table employees_02;

drop table ex01;

drop table result;

drop table ex02;

commit;

drop table result2;

create table result (
    stu_id varchar2(3) primary key,
    name varchar2(20) not null,
    major varchar2(20) not null,
    kor number(3),
    eng number(3),
    math number(3),
    sci1 number(3),
    sci2 number(3),
    ave number(3),
    total number(3),
    rank number(3)
);

insert into result (stu_id, name, major, kor, eng, math, sci1, sci2)
values ('a01', '홍길동', '이과', 100, 99, 98, 100, '');
insert into result (stu_id, name, major, kor, eng, math, sci1, sci2) 
values ('a02', '이순신', '이과', 80, 88, 87, 80, '');
insert into result (stu_id, name, major, kor, eng, math, sci1, sci2) 
values ('a03', '유관순', '문과', 70, 77, 74, '', 76);
insert into result (stu_id, name, major, kor, eng, math, sci1, sci2) 
values ('a04', '안창호', '문과', 60, 65, 67, '', 69);

select * from result;

// 평균값 넣기
update result set ave=(kor+eng+math+nvl(sci1,0)+nvl(sci2,0))/4;

// 반올림 해서 값 넣기
update result set ave=round(ave,1);

update result set total=kor+eng+math+nvl(sci1,0)+nvl(sci2,0);

alter table result modify rank varchar2(3);

update result set rank = case
when ave >= 90 then 'A'
when ave >= 80 and ave < 90 then 'B'
when ave >= 70 and ave < 80 then 'C'
when ave >= 60 and ave < 70 then 'D'
else 'F'
end;

create table day_sal(
    id varchar2(3),
    name varchar2(20),
    d_sal number(9,2),
    m_sal number(11,2),
    y_sal number(13,2)
);

desc day_sal;

insert into day_sal (id, name, d_sal) values ('a01', '홍길동', 180780);
insert into day_sal (id, name, d_sal) values ('a02', '이순신', 145682);
insert into day_sal (id, name, d_sal) values ('a03', '김유신', 230456);
insert into day_sal (id, name, d_sal) values ('a04', '안창호', 280123);
insert into day_sal (id, name, d_sal) values ('a05', '유관순', 127856);

select * from day_sal;

commit;

update day_sal set d_sal = d_sal + (d_sal*0.045);

update day_sal set m_sal = d_sal*20;

update day_sal set y_sal = m_sal*12;

select * from day_sal;
