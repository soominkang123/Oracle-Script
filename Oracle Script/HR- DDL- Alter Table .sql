/*
   DDL : Creat, Alter, drop <-- ��ü (���̺�, ��, �Լ�, �������ν���, Ʈ����, ������...)
   
   -���̺� ������ , ������ ������ ���̺� ���ؼ� ����ϰ� ���� ����(Alter Table)
     - 1. �÷��� �ڷ����� ����: varchar(50)===>varchar(100)
     - 2. �÷��� �̸��� ���� , �÷��� ����, �÷��� �߰� 
     - 3. �÷��� ���������� �߰� , ����( Primary key, Unique, NOT NULL, CHECK, Foreign Key, default )
        
*/

-- �ǽ��� ���� ���̺� ���� : �÷���,�� �� �����, �÷��� �ο��� ���� ������ ������� ����.
create table emp60
as
select*from employee;

create table dept60
as
select*from department;

select*from emp60;
select*from dept60;

-- ������ ���� : user_  ,  user_constraints : ������ ���̽��� �����ϴ� ��� ���̺� ���� ���������� ���
select*from user_constraints
where table_name in('EMPLOYEE', 'DEPATRMENT');

-- ������ ���̺��� ���� ������ ���� ���� �ʴ´�.
select*from user_constraints
where table_name in('EMP60', 'DEPT60'); -- �������� ����X

-- 1. Alter Table �� ����ؼ� ���� ���̺� �÷���  �߰� : birth(date), email(varchar2(100),
   -- ���̺� �÷��� �߰��� null�� ó���� �÷��� �߰��ؾ���.
desc dept60;

alter table dept60
add(birth date);

-- ���� ���̺� �������� �÷��� �Ѳ����� �߰� �ϱ� 
alter table dept60
add(email varchar2(100), addr varchar2(200), jumin char(14));

-- ���� ������ �÷��� �� �ֱ� : update
update dept60
set birth = sysdate, email = 'aaa@www.com',addr = '����',jumin = '123456-7891011' -- where�� �ʿ� �Ѳ����� ������Ʈ��
where dno = 10;

rollback;
commit;

select*from dept60;

-- default ���������� not null �տ� ��ġ �ؾ� �Ѵ�.
create table account11 (
    ino number not null primary key,
    aname varchar(50) not null,
    money number default 0 not null 
    );
select*from account11;    


-- 2. �÷��� �ο��� �ڷ��� ���� : char(10) ===>char(50), varchar2(100) ==> varchar2(200)
desc dept60 ; 

alter table dept60 
modify email varchar2(200);

-- 3. Ư�� �÷��� ���� :

alter table dept60
drop column JUMIN;

-- 4. �÷��� �̸� ���� :addr ==> address1

alter table dept60
rename column addr to address1;

-- 5. ���̺� �̸� ���� : dept60 ==> dept70
desc dept70;
rename dept60 to dept70;

select*from dept60; --���� X ���� �߻�
select*from dept70;

rename dept70 to dept60;
-- 6. ���� ���̺��� ���� ���� �߰�, ����, (Primary key, Uniquem Foreign key, check, default)
select*from user_constraints where table_name in('DEPARTMENT','EMPLOYEE');
select*from user_constraints where table_name in('DEPT60','EMP60');

-- 6-1. Primary Key ���� ���� �߰� : dept60(dno), emp60(ename)
  -- ���̺��� 1���� ���� �� �ִ�.
  -- not null �÷��� primary key�� ���� �� �ִ�.
  -- �÷��� null ���� ����� ��.
  
-- dept60(dno)�� Primary Key ���� ���� �߰� : ���� ���� �̸��� ����ؼ� �ο���.
alter table dept60
add constraint PK_DEPT60_DNO primary key(dno);

-- ���� ���� �̸��� ���� �� ��� : Oracle ���� sys_* �� ���� �Ǵ� ������ �̸��� ���� 
alter table dept60
add primary key(dno);

alter table emp60
add constraint PK_EMP60_ENO primary key(eno);

--���� ���� ����
alter table dept60
drop constraint PK_DEPT60_DNO;

-- 6-2 Foreign Key : �ٸ� ���̺��� �÷��� ���� ���� �ؼ� ���� ���� �� �ִ�.
          -- ���̺�(�θ�:1) <=== FK���̺�(�ڽ�:��)
          -- JOIN �� on ������ ���Ǵ� Ű �÷�
          -- �θ� ���̺��� ���� �÷��� Primary key, Unique �� ���� �� �� �ִ�.
          -- ���� �÷��� ������ Ÿ���� ����ϰų� ���ƾ� �Ѵ�.

select*from user_constraints where table_name in('DEPT60','EMP60');   

-- Foreign Key(2����)        Primary Key(1����)
-- EMP60(dno) ===>          DEPT60(dno)
desc dept60;
desc emp60;

alter table emp60
drop constraint SYS_C008492;

--Foreign Key ���� ������ �ֱ� ���ؼ��� 1. �θ����̺��� �÷��� : Primary Key, Unique, 2. ���� �÷��� �ڷ����� ����ϰų� ���ƾ���.
    --1. �θ����̺��� Primary Key �Ҵ�
  alter table dept60
  add constraint PK_DEPT60_DNO primary key (dno);
  
   --2. �ڽ� ���̺��� Foreign Key �Ҵ� : �θ� ���̺��� Primary Key�� ����
  alter table emp60
  add constraint FK_EMP60_dno Foreign Key(dno)references DEPT60(dno);
  
  select*from dept60;
  select*from emp60;

-- Foreign Key�� JOIN �� ON������ �����ϴ� �÷�:

  select eno, ename, salary, e.dno, d.dno, dname, loc
  from emp60 e
   join dept60 d
    on e.dno = d.dno;
    
    