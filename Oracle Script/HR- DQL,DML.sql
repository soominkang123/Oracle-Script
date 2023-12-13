/*
    SQL: 모든 쿼리 구문, select, create, alter, drop, insert, update, delete, grant, revoke, rollbac, commit
       - 구조화된 질의 언어
    SQL 종류   
       - DQL(Data Quary Language) : 출력, 검색, select
       - DDL(Data Definition Language) : 스키마 (틀, 구조), 객체(테이블, 뷰, 함수, 시퀀스, 트리거, 저장프로시져, 인덱스) 생성, 수정, 삭제
             create(생성), alter(수정), drop(삭제)
       - DML (Data Manupulation Language) : 테이블의 레코드를 조작하는 언어
             insert(입력), update(수정), delete(삭제)
             -- 트랜잭션이 발생(RAM) , commit : RAM의 변경된 내용을 DataBase 영구히 저장하도록 함. .rollback: 원래대로 되돌림.
             -- 트랜잭션이 insert, updatem delete 시작되면 자동으로 트랜잭션이 시작
             -- 트랜잭션을 종료: rollback : 메모리에 변경된 내용을 다시 원래 상태로 되돌림. commit : DB에 영구적으로 적용함
             -- 트랜잭션이 종료 되지 않으면 LOCK 걸려서 트랜잭션 트랜잭션 종료될때 까지 LOCK이 걸려있다. 
             -- 오라클 : DML 문을 시작하면 자동으로 트랜잭션이 시작됨. 종료(rollback, commit) <== 명시
             -- MySQL, MSSQL : DML 문을 시작하면 자동으로 트랜잭션이 시작됨. commit 자동으로 처리됨
             -- 명시적으로 트랜잭션을 시작 할 수 있고, 명시적으로 끝낼 수 있다.
       - DCL( Data Control Language) : 계정(Account)에게 객체(Resource)에 권한을 부여함. grant(부여), revoke(제거)
       - TCL( Transaction Control Language ) : 트랜잭션을 관리 하는 언어, <== DML 문에서 사용됨
         - commit (DB에 영구히 저장), rollback ( 원래대로 되돌림), savepoint ( 트랜잭션 내에서 임시 저장시점 생성 )
           begin transaction : 명시적으로 트랜잭션 시작
*/

/*
   트랜잭션 : 작업(일_을 처리하는 최소단위 : ALL or NOTHING : 되면 전부 되게 하거나 안되면 전부 안되게 함.
     - 트랜잭션 log 에 기록되어 있다.  <== 오류난 시점까지 복원 , 백업 시점: 백업시점이 아니라 오류난 시점까지 복원가능
     - 
     - 트랜잭션의 4가지 특징
       - 원자성 (Atomicity) : 일을 처리하는 최소 단위
       - 일관성 (Consistency) : 트랜잭션에서 처리된 결과는 일관성을 가진다.
       - 독립성 (lsolation) : 하나의 트랜잭션은 다른 트랜잭션과 격리되어 있다. .LOCK
       - 직속성 (Durability) : commit ,DB에 영구적으로 저장됨
*/

-- 테이블 복사

create table account10
as
select eno as no, ename as name, salary as account
from employee;

-- 은행의 통장 테이블 : no : 계좌번호, name : 통장주인, account : 돈(입금액), 억
select * from account10;

-- SMITH에서 MITTER에게 10억을 입금 : 2개의 update 구문을 하나의 transaction 으로 처리 : ALL or NOTHING
  -- SMITH ACCOUNT - 10억 : update account10 set account = account -10 where no= 7369
  -- MILLER Account + 10억 : update account10 set account = account +10 where no= 7934
  
begin transaction; -- 명시적으로 트랜잭션을 시작 

  update account10
  set account = account -10
  where no = 7369;
  
  update account10
  set account = account +10
  where no = 7934;

select * from account10;
-- 트랜잭션 종료  
 rollback;
 commit;
 
desc account10;

/*
   DML : insert(값을 입력) , update(수정), delete(삭제)
     <== 트랜잭션 자동 시작, 
     <== 트랜잭션 종료 ( rollback, commit)는 명시 (오라클)
*/

-- 테이블 복사
create table dept03
as
select*from department;

select*from dept03;

-- dept03: primary key 제약 조건 추가
alter table dept03
add constraint PK_DEPT03_DNO primary key (dno);

-- INSERT: 주의 사항, 각 칼럼에 자료형 : number, 문자, 날짜, 칼럼의 적용된 제약 조건을 확인
desc dept03;
select*from user_constraints where table_name in('DEPT03');

-- insert into 테이블명 (칼럼명, 칼럼명, 칼럼명)values(값, 값, 값);

insert into dept03(dno, dname, loc)
values(50, 'HR', 'SEOUL');

rollback;
commit;

select*from dept03;

-- insert시 칼럼이름을 명시 하지 않는 경우 모든 칼럼에 값을 넣어야함.
insert into dept03
values(60,'인사부','부산');

commit;

--칼럼 생략 할때는 모든 칼럼에 값이 순서에 맞게 입력 
insert into dept03 
values(60,'인사부'); -- 오류코드 부산까지 넣어줘야됨

-- 칼럼을 명시할때 순서를 바꿀 수 있고, 특정칼럼은 값을 넣지 않아도 됨.
insert into dept03(dname, dno)
values('영업부',80);

select*from dept03;
commit;


-- UPDATE 문 : 입력된 값을 수정시 사용, 반드시 where 조건을 사용, where 조건에 사용되는 칼럼은 Primary Key 칼럼이어야 함.
/*
 update 테이블명
 set 칼럼명 = 바꿀값, 칼럼명=바꿀값
 where 조건 
*/

--중요 
update dept03 
set loc = '대구'
where dno = 80;

update dept03
set dname = '관리부', loc = '광주'
where dno = 40;

rollback;

select*from dept03;

--
insert into dept03
values(90,'영업부','대구');

insert into dept03
values(91,'영업부','광주');

commit;
-- update에서 반드시 where 조건, 조건을 처리하는 칼럼은 Primary key, Unique 키 칼럼을 정의
update dept03
set dname = '인쇄부'
where loc = '광주';  -- 중복된 값

-- update 시 primary key 칼럼을 조건으로 처리해서 원하는 값만 수정
update dept03
set dname = '인쇄부'
where dno in(91,80);

-- Delete : 레코드를 삭제 할때, Where<조건>, <조건: 중복되지 않는 칼럼>
/*
  delete 테이블명
  where 조건
*/

select*from dept03;

--delete문에서 조건을 사용하지 않는 경우 모든 레코드가 삭제됨
delete dept03
rollback;

-- delete, where 조건 사용,  <== 
delete dept03
where dno = 91;

-- 모든 레코드를 삭제 :
   /* delete                : 레코드 하나하나를 삭제함, 시간이 오래 걸림. << 로우레벨 포멧>>       
      truncate table 테이블명 :    한꺼번에 통째로 모든 레코드를 날림. <<빠른 포멧>>
      
      drop table 테이블명    :  테이블 자체를 삭제
    */
select*from dept03;    
rollback;
commit;

-- 모든 레코드 삭제 : 값만 삭제 롤백가능
delete dept03;

-- 모든 레코드 삭제 : 값만 삭제  <== DDL 문이기 때문에 Rollback이 안됨. 실행후 바로 커밋됨
  -- 빠르게 처리됨
  
truncate table dept03;
-------------------------------------------------------------
create table emp04
as
select*from employee;

select*from emp04;

/*
   임의의 값을 추가: insert
   임의의 값을 수정: update
   임의의 값을 삭제: delete
*/
desc emp04;
select*from user_constraints where table_name in('EMP04');

insert into emp04(eno,ename,job,dno)
values(7899,'KANG','WORKER',20);

update emp04
set manager = 7777
where eno = 7899;

delete emp04;

rollback;
commit;
-------------------------------------------------
/*   DDL : create(생성),alter(수정),drop(삭제)<== 테이블,뷰,함수,시퀀스,트리거,저장프로시져, 스키마를 생성, 수정, 삭제
  
   자료형: 데이터를 저장하는 타입
   - 숫자: number(정수자릿수) :정수 3자리
          number(7,2) : 소수 , 전체7자리, 소숫점이하2자리까지
   - 문자: char(n) : 영문1자(1byte), 한글1자(3byte)
           - 성능이 빠르다.하드 공간 낭비가 발생할 수 있다.
           - 주민번호(13), 자릿수가 지정된 곳에 사용됨
          varchar2(n) : 영문1자(1byte), 한글1자(3byte)
            - 가변공간으로 적용됨, 성능은 char보다 느릴수 있다. 하드공간 낭비를 시키지 않는다.
            - 자릿수를 알 수 없는 문자열일때 사용됨
            nchar(n)     : nchar(10) : 한글10자
            nvarchar2(n) : nchar(10) : 한글10자
    - 날짜 : date : BC 4712년1월1일 ~~~9999년 12월 31일까지 저장, 년, 월, 일, 시, 분, 초 까지만 저장 가능
             timestamp: insert(값이 들어오는 시스템의 시간): 년, 월, 일, 시, 분, 초 밀리세컨드까지 저장
             
     - LOB 데이터 타입 : 대량의 값을 저장, 바이너리 파일
          CLOB: 문자를 대량으로 넣을수 있다. <==글 내용
          BLOB: mp3,jpeg,hwp 이진 데이터 파일
          BFILE: 대용량 파일을 저장
             
*/  

--
drop table test10;
create table test10(
   id number(4)not null primary key,  -- 중복된 값 넣을 수 없다. 정수 4자
   n1 char(10) ,              -- 영문10자, 한글3자
   n2 char(10) ,              -- 영문10자, 한글10자
   n3 varchar2(10) ,          -- 영문10자, 한글3자
   n4 nvarchar2(10)          -- 영문10자, 한글10자
  ); 
  
select*from test10;  
commit;
rollback;
insert into test10(id,n1,n2,n3,n4)
values ( 1111, 'abc','가나','abc','가나');

insert into test10(id,m1)
values(1112,'가나다');

/*
JOIN : Datebase에는 많은 테이블이 존재합니다. 모델링을 통해서 테이블이 분리 되어 있다. ( R-DBMS )
    employee 테이블과 department 테이블은 하나의 테이블인데 모델링을 (1,2,3정규화), 을 통해서 테이블을 분리
    모델링 : 중복 제거, 성능향상, 
    
    제약 조건 : 테이블의 칼럼에 들어가는 키 , 데이터의 무결성 ( 결함없는데이터, 원하는 값만 )
      Primary Key : 
        - 테이블의 칼럼에 1번만 넣을 수 있다.
        - 2개 칼럼을 묶어서  Primary Key 를 넣을 수 있다.
        - 테이블을 생성할때 반드시 PK 이 존재해야 한다. - Update, Delete 구분해서 PK 칼럼을 where 조건으로 사용함.
        - 특정 칼럼에 중복 된 값을 넣지 못하도록 함.
        - 반드시 not null 컬럼이어야함. null을 넣을 수 없다.
        - index 가 자동으로 생성 된다. 칼럼의 검색을 빠르게 한다.
        - JOIN 시 ON 에서 많이 사용하는 키 칼럼.
        
      Unique Key :  
       - 칼럼에 중복된 값을 넣지 못하도록 함.
       - null을 넣을 수 있다. 단 1번만 넣을 수 있다. not null, null
       - 하나의 테이블에 여러번 Unique Key를 넣을 수 있다.
       - index 가 자동으로 생성됨, JOIN 시 ON 에 사용됨
       
      Foreign Key :  
      - 다른 테이블(부모 테이블) 의 특정 칼럼을 참조해서 값을 넣도록 함.
      - Foreign key 가 참조하는 칼럼은 부모테이블의 Primary Key, Unique Key 를 참조함.
      -
      
     NOT NULL
     - 칼럼에 NULL을 넣을 수 없도록 하는 제약 조건
     
     CHECK 
     - 칼럼에 조건을 넣어서 내가 원하는 값만 넣을 수 있도록 함.
     - 월 칼럼에 1 ~ 12 까지 넣을 수 있도록 
     
     default : 제약 조건은 아니지만 제약 조건처럼 사용됨
        - 칼럼에 값을 넣지 않으면 default 로 설정된 값이 등록됨.
     
     제약 조건을 출력하는 데이터 사전: user_constraints
       select*from user_constraints where table_name in ('테이블명');
       
*/

-- 제약 조건 이름을 넣지 않고 테이블 생성 한 경우 : Oracle에서 제약조건이름을 랜덤하게 생성한다.
-- insert시 오류가 발생할 경우 제약조건 이름으로 오류난 칼럼을 찾기 힘들다. Primary Key : 
create table member1(
  id varchar2(50) not null primary key,   -- 제약 조건 이름을 생략하면 Oracle에서 자동으로 지정함.
  pass varchar2(50) not null,
  addr varchar2(100) null,
  jumin char(13) null,      -- 자릿수가 지정된 칼럼
  phone varchar2(50),
  age number(3),            -- 정수 3자리
  weight number(5,2)        -- 실수 전체 5자리, 소숫점이하2자리
  );     
desc member1;  
select*from member1;  
commit;
insert into member1( id, pass, addr, jumin, phone, age, weight)
values('abc','1234','서울','123456-789101','010-1111-1111',30,77.77);  --같은 값 재입력시 제약조건 위배

select*from user_constraints where table_name in ('MEMBER1');

-- 테이블 생성시 제약 조건 이름 부여
create table member2(
  id varchar2(50) not null constraint PK_MEMBER2_ID primary key,   -- 제약 조건 이름을 생략하면 Oracle에서 자동으로 지정함.
  pass varchar2(50) constraint NN_MEMBER2_PASS not null,
  addr varchar2(100) null,
  jumin char(13) null,      -- 자릿수가 지정된 칼럼
  phone varchar2(50),
  age number(3),            -- 정수 3자리
  weight number(5,2)        -- 실수 전체 5자리, 소숫점이하2자리
  );    
select*from user_constraints where table_name in ('MEMBER2');  -- 

insert into member2( id, addr, jumin, phone, age, weight)
values('abc','서울','123456-789101','010-1111-1111',30,77.77);
commit;
----------------------------------------------

/* UNIQUE: 중복된 값을 넣을 수 없다. null을 넣을 수 있다. 테이블에 여러번 넣을 수 있다.
 
*/
create table member3(
  id varchar2(50) not null constraint PK_MEMBER3_ID primary key,   -- 제약 조건 이름을 생략하면 Oracle에서 자동으로 지정함.
  pass varchar2(50) constraint NN_MEMBER3_PASS not null,
  addr varchar2(100) null,
  jumin char(13) null constraint U_MEMBER3_JUMIN unique,      -- 중복되면 안됨
  phone varchar2(50)not null constraint U_MEMBER3_PHONE unique, -- 중복되면 안됨
  age number(3),            -- 정수 3자리
  weight number(5,2)        -- 실수 전체 5자리, 소숫점이하2자리
  );
insert into member3( id, pass, addr, jumin, phone, age, weight)
values('abc','1234','서울','123456-789101','010-1111-1111',30,77.77);
commit;  
select*from member3  


---------------------------------------------------------------

--CHECK 제약 조건 : 칼럼에 조건에 맞는 값만 넣을 수 있도록 함.
drop table member4;

create table member4(
  id varchar2(50) not null constraint PK_MEMBER4_ID primary key,   -- 제약 조건 이름을 생략하면 Oracle에서 자동으로 지정함.
  pass varchar2(50) constraint NN_MEMBER4_PASS not null,
  addr varchar2(100) null constraint CK_MEMBER4_ADDR check (addr in('서울', '부산', '대구')),
  jumin char(13) null constraint U_MEMBER4_JUMIN unique,      -- 중복되면 안됨
  phone varchar2(50)not null constraint U_MEMBER4_PHONE unique, -- 중복되면 안됨
  age number(3) constraint CK_MEMBER4_AGE check(age>0 and age<200),            -- 정수 3자리
  gender char(1)constraint CK_MEMBER4_GENDER check(gender in('w','m')),
  weight number(5,2),        -- 실수 전체 5자리, 소숫점이하2자리
  hiredate date default sysdate,
  addr2 char(10) default '서울',
  age2 number default 0     -- 마지막엔 ,제외
  );
  
insert into member4( id, pass, addr, jumin, phone, age, weight,gender)
values('abc','1234','대구','123456-789101','010-1111-1111',100,77.77,'w'); -- 조건에 맞는 값만들어감 서울 부산 대구
commit;  
--------------------------------------------------------------

-- default : 제약조건이 아니다. 제약조건 이름을 부여 할 수 없다.
  -- 값을 넣을때 값이 들어가고 값을 넣지 않을때 default로 설정된 값이 들어간다.

create table member5(
  id varchar2(50) not null constraint PK_MEMBER5_ID primary key,   -- 제약 조건 이름을 생략하면 Oracle에서 자동으로 지정함.
  pass varchar2(50) constraint NN_MEMBER5_PASS not null,
  addr varchar2(100) null constraint CK_MEMBER5_ADDR check (addr in('서울', '부산', '대구')),
  jumin char(13) null constraint U_MEMBER5_JUMIN unique,      -- 중복되면 안됨
  phone varchar2(50)not null constraint U_MEMBER5_PHONE unique, -- 중복되면 안됨
  age number(3) constraint CK_MEMBER5_AGE check(age>0 and age<200),            -- 정수 3자리
  gender char(1)constraint CK_MEMBER5_GENDER check(gender in('w','m')),
  weight number(5,2),        -- 실수 전체 5자리, 소숫점이하2자리
  addr2 char(10) default '서울',
  age2 number default 0     -- 마지막엔 ,제외
  );
select *from member5;  
  
insert into member5( id, pass, addr, jumin, phone, age, weight,gender)
values('abc','1234','대구','123456-789101','010-1111-1111',100,77.77,'w'); 

insert into member5( id, pass, addr, jumin, phone, age, weight,gender,hiredate,addr2,age2)
values('abcd','1234','대구','123456-789103','010-1111-1113',100,77.77,'w','22/11/11','광주',30); 
commit;  