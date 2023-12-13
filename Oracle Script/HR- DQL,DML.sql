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

