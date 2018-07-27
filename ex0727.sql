// as를 넣어서 조건을 걸어 테이블 내용을 복사할 수 있다
create table ex04 
as 
select * from employees 
where salary>(select avg(salary) from employees
where department_id = 80
group by department_id);

select * from ex04;

// 1) 각 부서별 평균월급중 
// 2) 부서별 최대평균월급을 받는 부서의 부서번호와 최대평균월급
select department_id, avg(salary)
from employees
group by department_id
having avg(salary) = (
select max(avg(salary))
from employees
group by department_id);

// 직무별 평균월급에서 직무별 최소평균월급보다 적게 받는 사원들
select employee_id, avg(salary)
from employees
group by employee_id
having avg(salary) < (select min(avg(salary))
from employees 
group by job_id);

create view ex05_view
as
select employee_id, emp_name, department_id, job_id
from employees;

select * from ex05_view
where department_id = 80;

create view emp_idv
as
select employee_id, emp_name, a.department_id, b.department_name, a.job_id, c.job_title
from employees a, departments b, jobs c
where a.department_id = b.department_id and a.job_id = c.job_id;

select * from emp_idv;

create view ex01_view
as
select *
from employees
where hire_date > to_date('2000/01/01') and department_id = 80;

select * from ex02_view;

// 전체 평균 월급보다 많이 받는 사원들만 view
create view ex02_view
as 
select employee_id"e_id", emp_name"e_name", department_id"d_id"
from employees
where salary > (
select avg(salary) from employees);

select * from ex02_view where e_id = 170;

// 의사
create table doctor(
    d_id varchar2(20),
    d_name varchar2(10),
    d_rrn number(13),
    d_age number(3),
    d_phone number(11),
    d_address varchar2(50),
    d_major varchar2(20)
);

// 환자
create table patient(
    p_insurance number,
    p_id varchar2(20),
    p_name varchar2(10),
    p_rrn number(13),
    p_age number(3),
    p_phone1 number(11),
    p_phone2 number(11),
    p_address varchar2(50),
    p_gender varchar2(4),
    p_bloodtype varchar2(10),
    p_height number(3),
    p_weight number(3)
    );

// 진료
create table treatment(
    disease varchar2(50),
    treat_date date,
    fee number(8),
    treatment varchar2(50)
);

// 간호사
create table nurse(
    n_id varchar2(20),
    n_name varchar2(10),
    n_rrn number(13),
    n_age number(3),
    n_phone number(11),
    n_address varchar2(50)
    );

// 차트
create table chart(
    prescript varchar2(50),
    progress varchar2(50),
    booking date,
    hospitalization_id varchar2(50),
    hospitalization_date date,
    discharge date,
    drug_id varchar2(20),
    drug_name varchar2(20),
    drug_price number(8)
);

insert into doctor values('d001', '김개똥', 8801011111111, 31, 01011111111, '서울', '외과');
insert into doctor values('d002', '이소똥', 8802022222222, 32, 01022222222, '경기', '내과');
insert into doctor values('d003', '박말똥', 8803033333333, 33, 01033333333, '인천', '안과');
insert into doctor values('d004', '최양똥', 8804044444444, 34, 01044444444, '부산', '치과');
insert into doctor values('d005', '심봉사', 8805055555555, 35, 01055555555, '울산', '피부과');

insert into patient values(0001, 'p001', '김환자', 8901011111111, 21, 01012341234, 01023452345, '서울', '남자', 'A+', 180, 80);
insert into patient values(0002, 'p002', '이환자', 8902022222222, 22, 01034563456, 01056785678, '경기', '여자', 'B+', 160, 60);
insert into patient values(0003, 'p003', '박환자', 8903033333333, 23, 01067896789, 01078907890, '인천', '남자', 'O+', 170, 70);
insert into patient values(0004, 'p004', '최환자', 8904044444444, 24, 01089018901, 01090129012, '부산', '여자', 'AB+', 150, 50);
insert into patient values(0005, 'p005', '심환자', 8905055555555, 25, 01001230123, 01000120012, '울산', '남자', 'A-', 160, 60);

select * from doctor;

insert into treatment values('화상', to_date(2017/03/18), 13500, '약 처방');

// 두번 넣을땐 이런 식으로 
insert all
into ex01_view values()
into ex01_view values();

// 조건을 넣어서 입력할땐 이런 식으로
insert all
into ex01_view values()
into ex01_view values()
select employee_id, emp_name, department_id, job_id, from employees
where employee_id;

// 칼럼만 복사하려면 where절에 잘못된 식 넣고 만들면 됨
create table ex02
as 
select * from employees
where 1=0;

desc ex01;
select * from ex01;

insert all
when hire_date > to_date('82/01/01', 'yy/mm/dd')
then into ex01 values(employee_id, emp_name, department_id)
when salary >= 2000 
then into ex02 values(employee_id, emp_name, job_id)
select employee_id, emp_name, department_id, job_id, salary, hire_date from employees;

// 동시에 열을 추가하시오



select * from user_tables;
