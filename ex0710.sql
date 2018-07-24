# oracleTest
insert into stu(stu_id,stu_name,address,major,class) values ('a0001','고길동','서울시','컴터과',4);
insert into stu(stu_id,stu_name,address,major,class) values ('a0002','김개똥','서울시','컴터과',3);
insert into stu(stu_id,stu_name,address,major,class) values ('a0003','박나래','서울시','컴터과',2);
insert into stu(stu_id,stu_name,address,major,class) values ('a0004','김광수','서울시','컴터과',1);
insert into stu(stu_id,stu_name,address,major,class) values ('a0005','조혜경','서울시','컴터과',1);

select * from ex02;
// ex02 라는 테이블 안에 모든 내용 표시

// 테이블을 만드는 식
create table ex02(
// 만든다  테이블 테이블명
    clo_date date,
    // 테이블 안에 내용명 / 데이터 타입(길이)
    col_name varchar2(20),
    col_title varchar2(50)
);

select table_name from user_tables;
// 유저가 갖고있는 테이블들 전부 보여주기

// ex02 라는 테이블 안에 각각 ()위치에 values 뒤 ()위치로 값을 넣어준다
insert into ex02(clo_date,col_name,col_title) values (sysdate,'김광수','HTML');
insert into ex02(clo_date,col_name,col_title) values (sysdate,'조혜경','CSS');
insert into ex02(clo_date,col_name,col_title) values (sysdate,'정인용','Javascript');
insert into ex02(clo_date,col_name,col_title) values (sysdate,'나폴레옹','뻘짓');
insert into ex02 values (sysdate,'임꺽정','산도적질');

commit;
// 내용 마지막 입력

select * from employees where emp_name='David Lee';
// employees 테이블 안에 emp_name이 David Lee 인 사람 찾기. 대소문자 구별한다

drop table ex01;
// ex01이라는 테이블 제거

commit;

create table board(
    board_num number(5),
    board_name varchar2(50),
    board_writer varchar2(50),
    board_content varchar2(500),
    board_date date
);

insert into board values (1,'게시판1','김광수','안녕하세요',sysdate);
insert into board values (2,'게시판2','조혜경','인삿말입니다',sysdate);
insert into board values (3,'게시판3','정인용','반갑습니다',sysdate);

select * from board;

create table board2(
    board_num number(5) primary key,
    board_name varchar2(50) not null,
    board_writer varchar2(50) not null,
    boad_content varchar2(500) unique,
    board_date date
);

commit;

insert into board2 values (1,'제목1','홍길동','내용1',sysdate);
insert into board2 values (1,'제목1','김유긴','내용2',sysdate);


create table board3(
    b_id number(5),
    b_title varchar2(50),
    b_writer varchar2(50),
    b_contents varchar2(500),
    b_date date
);

commit;

alter table board3 rename COLUMN b_num to b_id;
// alter라는 식으로 테이블명 board3 안에 b_num의 이름을 b_id로 변경한다

commit;

desc board1;
// column을 보여줌
select * from board1;
// 데이터를 보여줌

// board3 테이블 안 b_id의 데이터 타입과 값을 변경
alter table board3 modify b_id varchar2(5);
alter table board3 modify b_date number(8);
alter table board3 modify b_title varchar2(20);
alter table board3 modify b_writer varchar2(30);

drop table board;
drop table board2;
drop table stu;
drop table ex02;
drop table board3;

commit;


create table board (
    b_id number(5),
    b_title varchar2(50),
    b_writer varchar2(50),
    b_contents varchar2(500),
    b_date date
);

commit;

alter table board rename COLUMN b_id to b_num;

desc board;

alter table board add b_id varchar2(50);

alter table board drop COLUMN b_writer;

insert into board values (1,'title01','contents01',sysdate,'a0001');
insert into board values (2,'title02','contents02',sysdate,'a0002');

select * from board;


// 시퀀스 만드는 방식. my_seql이 이름
create sequence my_seql
// 1씩 늘어남
increment BY 1
// 1부터 시작
start with 1
// 최소값 1
minvalue 1
// 최대값 100
maxvalue 100
//
nocycle
nocache;

create table ex01(
    num number(3),
    id varchar2(3),
    name varchar2(20)
);

commit;

insert into ex01 values (my_seql.nextval,'a01','홍길동');

select * from ex01;

insert into ex01 values (my_seql.nextval,'a02','김유신');
insert into ex01 values (my_seql.nextval,'a03','강감찬');

select my_seql.currval from dual;

select my_seql.nextval from dual;

create table ex02 (
    num number(3),
    id varchar2(3),
    name varchar2(20)
);

commit;

insert into ex02 values (my_seql.nextval,'b02','aabbcc');
insert into ex02 values (my_seql.nextval,'b03','dddddd');

select * from ex02;

drop sequence my_seql;



create table board1(
    b_id number(5),
    b_name varchar2(20),
    b_writer varchar2(30),
    b_contents varchar2(500),
    b_date date
);

create sequence my_seq1
increment by 1
start with 1
minvalue 1
maxvalue 100
nocycle
nocache;

commit;

insert into board1 values (my_seq1.nextval,'제목','글쓴이','내용',sysdate);
