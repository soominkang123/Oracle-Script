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
    
-- 6-3. Unique ���� ���� �߰� : �ߺ��� ���� ���� ���ϵ��� ����
  -- �� ���̺� ���� �÷��� �ο� �� �� �ִ�.
  -- not null, null ��� Unique,   �ֹι�ȣ, Email
  -- null�� ������ ���� �� �ִ�.
  -- 
  
 select*from user_constraints where table_name in('DEPT60','EMP60');   
 desc dept60;
 desc emp60;
 
 select*from dept60;
 
 alter table dept60
 add constraint U_DEPT60_EMAIL unique(email);
 
 insert into dept60
 values(60,'������','�λ�',sysdate,yyy@yyy.com,'�λ�')

 commit;
 
 alter table dept60
 add constraint U_DEPT60_ADDERSS1 unique (address1);
 
 update dept60
 set address1 = '����'
 where dno = 60;
 
 -- ���� ���� ����
 alter table dept60
 drop constraint U_DEPT60_ADDRESS1
 
-- 6-4 check ���� ���� �߰�: �÷��� ������ �ο��ؼ� ���ǿ� �´� ���� �Է� 
select*from emp60;

select*from user_constraints where table_name in('DEPT60','EMP60');   

alter table emp60 
add (addr varchar2(50), hdate date); 

alter table emp60
add age number(3) ;


-- addr �÷��� : '����','�λ�','����'�� ���� �� �ֵ��� ����
-- hdate �÷��� : 2023�� 01�� 01 ~ 2023�� 12�� 31�ϱ����� �ֵ��� ����
-- age �÷��� 0�� ~ 300�� �� ������ ����

alter table emp60
add constraint CK_EMP60_ADDR check(addr in ('����','�λ�','����'));

insert into emp60(eno, dno, addr)
values(8080,20,'����')
commit;

alter table emp60;
add constraint CK_EMP60_HDATE
 check(hdate between to_date('20230101','YYYYMMDD')and to_date('20231231','YYYYMMDD'));
  
insert into emp60(eno, dno, addr,hdate)
values(8181,20,'����', '23/01/01')
commit;

alter table emp60
add constraint CK_EMP60_AGE check(age >= 0 and age <= 300);

insert into emp60(eno, dno, addr,hdate,age)
values(8282,20,'����', '23/01/01',88);
commit;

-- 6-5. NOT NULL �������� : �÷��� NULL������ ����, �ݵ�� ���� �Է��� �Ǿ�� �Ѵ�.
         -- �÷��� ���� NULL�� ������ ���� �߻�
desc dept60;
select*from dept60;

alter table dept60
modify address1 constraint NN_DEPT60_ADDRESS1 NOT NULL;

update dept60
set address1 = '����'
where address1 is null;

select*from user_constraints where table_name in('DEPT60','EMP60');   

insert into dept60
values (70,'������','�λ�',sysdate,'ccc@ccc.com','�뱸');

--6-6 default : ���� ������ �ƴϴ�. ���������̸��� �ο� �� ���� ����.
     -- �÷��� ���� ���� ���� ��� default�� ������ ���� �ڵ����� ��.
     -- default�� ������ �����ϱ� ���ؼ��� default null
     
  select*from dept60;   
  
  alter table dept60
  add address2 varchar2(100);
  
  alter table dept60
  modify address2 default '����';
  
  insert into dept60
  values (80,'������','�λ�',sysdate,'ddd@ccc.com','�뱸',default);
  commit;
  
  insert into dept60(dno,address1)
  values(90,'����');
  commit;
  
-- default ���� ���� ���� : default null
alter table dept60
modify address2 default null;

-- ���� ���� ���� : Primary Key, Foreign Key, Unique, NOT NULL, check
  -- alter table ���̺�� drop ���������̸�
  
-- ���� ���� ���� : default
 -- alter table ���̺�� modify �÷��� default null
 
