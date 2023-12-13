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