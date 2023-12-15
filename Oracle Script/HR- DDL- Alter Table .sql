/*
   DDL : Creat, Alter, drop <-- 객체 (테이블, 뷰, 함수, 저장프로시져, 트리거, 시퀀스...)
   
   -테이블 생성후 , 기존에 생성된 테이블에 대해서 빈번하게 유지 보수(Alter Table)
     - 1. 컬럼의 자료형을 변경: varchar(50)===>varchar(100)
     - 2. 컬럼의 이름을 변경 , 컬럼을 삭제, 컬럼을 추가 
     - 3. 컬럼의 제약조건을 추가 , 삭제( Primary key, Unique, NOT NULL, CHECK, Foreign Key, default )
        
*/

-- 실습을 위한 테이블 복사 : 컬럼명,값 만 복사됨, 컬럼에 부여된 제약 조건은 복사되지 않음.
create table emp60
as
select*from employee;

create table dept60
as
select*from department;

select*from emp60;
select*from dept60;

-- 데이터 사전 : user_  ,  user_constraints : 데이터 베이스에 존재하는 모든 테이블에 대한 제약조건을 출력
select*from user_constraints
where table_name in('EMPLOYEE', 'DEPATRMENT');

-- 복사한 테이블은 제약 조건은 복사 되지 않는다.
select*from user_constraints
where table_name in('EMP60', 'DEPT60'); -- 제약조건 복사X

-- 1. Alter Table 을 사용해서 기존 테이블에 컬럼을  추가 : birth(date), email(varchar2(100),
   -- 테이블에 컬럼을 추가시 null로 처리후 컬럼을 추가해야함.
desc dept60;

alter table dept60
add(birth date);

-- 기존 테이블에 여러개의 컬럼을 한꺼번에 추가 하기 
alter table dept60
add(email varchar2(100), addr varchar2(200), jumin char(14));

-- 기존 생성된 컬럼에 값 넣기 : update
update dept60
set birth = sysdate, email = 'aaa@www.com',addr = '서울',jumin = '123456-7891011' -- where문 필요 한꺼번에 업데이트됨
where dno = 10;

rollback;
commit;

select*from dept60;