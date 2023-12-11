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
      
    
*/

select * from employee;      -- employee 테이블의 dno 칼럼은 참조한다. ( Foreign Key )

select * from department;    -- department 테이블의 dno 칼럼을 참조한다.

-- 테이블 복사 : 원본 테이블의 제약 조건은 복사 되어 오지 않는다. Alter Table 을 사용해서 제약 조건을 부여
create table emp01
as 
select * from employee;

create table dept01
as
select * from department;

/*
   테이블의 제약 조건을 확인 하는 명령어 : 
   user_constraints : 데이터 사전 <== 테이블의 각종 정보를 알려주는 테이블
*/
select * from user_constraints;

select * from user_constraints
where table_name in ('EMPLOYEE','DEPARTMENT');

-- 테이블을 복사하면 테이블의 칼럼에 부여된 제약 조건은 복사되어 오지 않는다. 칼럼과 값만 복사되어온다.
-- altertable 을 사용해서 제약 조건을 부여해야 한다.
-- alter table : 생성된 테이블을 수정
select * from user_constraints
where table_name in ('EMP01','DEPT01');

-- dept01 테이블에 dno칼럼에 Primary Key 제약 조건을 추가
alter table dept01
add constraint PK_DEPT01_DNO primary key(dno);

-- emp01 테이블에 eno 칼럼에 Primmary Key 제약 조건 추가
alter table emp01
add constraint PK_EMP01_ENO primary key(eno);

-- emp01 테이블의 dno 칼럼에 Foreign Key 부여, 참조(references)할 테이블의 칼럼은 Depe01 테이블의 dno 칼럼을 참조
alter table emp01 
add constraint FK_EMP01_DNO foreign key(dno) references dept01(dno);

-- Primary Key 칼럼을 확인 :
desc emp01; 

select * from emp01;

-- 값을 넣을때 칼럼에 부여된 제약 조건을 잘 확인 하고 값을 insert 
-- eno : Primary Key 가 등록, 중복된 값을 넣으면 안됨
-- dno : Foreign Key 등록, Dept01 테이블의 dno 칼럼에 존재하는 값만 넣어야 한다.

insert into emp01(eno, ename, job, manager, hiredate, salary, commission, dno)
values( 7977, 'KSM', 'CLERK', 7782, '23/12/11', 1500, null, 40 );

commit;  -- DML ( insert, updatem delete ) 에서 DB에 영구히 저장되도록 함. <오라클>

select * from emp01;
select * from dept01;

-- dept 테이블에 값 넣기 : dno칼럼 : Primary key가 있음.
desc dept01;

insert into dept01( dno, dname, loc)
values (50, 'HR', 'SEOUL');

commit; -- DML (insert, update, delete ) 에서 반드시 적용

select * from dept01;

select * from emp01;
