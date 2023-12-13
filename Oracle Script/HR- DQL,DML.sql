/*
    SQL: ��� ���� ����, select, create, alter, drop, insert, update, delete, grant, revoke, rollbac, commit
       - ����ȭ�� ���� ���
    SQL ����   
       - DQL(Data Quary Language) : ���, �˻�, select
       - DDL(Data Definition Language) : ��Ű�� (Ʋ, ����), ��ü(���̺�, ��, �Լ�, ������, Ʈ����, �������ν���, �ε���) ����, ����, ����
             create(����), alter(����), drop(����)
       - DML (Data Manupulation Language) : ���̺��� ���ڵ带 �����ϴ� ���
             insert(�Է�), update(����), delete(����)
             -- Ʈ������� �߻�(RAM) , commit : RAM�� ����� ������ DataBase ������ �����ϵ��� ��. .rollback: ������� �ǵ���.
             -- Ʈ������� insert, updatem delete ���۵Ǹ� �ڵ����� Ʈ������� ����
             -- Ʈ������� ����: rollback : �޸𸮿� ����� ������ �ٽ� ���� ���·� �ǵ���. commit : DB�� ���������� ������
             -- Ʈ������� ���� ���� ������ LOCK �ɷ��� Ʈ����� Ʈ����� ����ɶ� ���� LOCK�� �ɷ��ִ�. 
             -- ����Ŭ : DML ���� �����ϸ� �ڵ����� Ʈ������� ���۵�. ����(rollback, commit) <== ���
             -- MySQL, MSSQL : DML ���� �����ϸ� �ڵ����� Ʈ������� ���۵�. commit �ڵ����� ó����
             -- ��������� Ʈ������� ���� �� �� �ְ�, ��������� ���� �� �ִ�.
       - DCL( Data Control Language) : ����(Account)���� ��ü(Resource)�� ������ �ο���. grant(�ο�), revoke(����)
       - TCL( Transaction Control Language ) : Ʈ������� ���� �ϴ� ���, <== DML ������ ����
         - commit (DB�� ������ ����), rollback ( ������� �ǵ���), savepoint ( Ʈ����� ������ �ӽ� ������� ���� )
           begin transaction : ��������� Ʈ����� ����
*/

/*
   Ʈ����� : �۾�(��_�� ó���ϴ� �ּҴ��� : ALL or NOTHING : �Ǹ� ���� �ǰ� �ϰų� �ȵǸ� ���� �ȵǰ� ��.
     - Ʈ����� log �� ��ϵǾ� �ִ�.  <== ������ �������� ���� , ��� ����: ��������� �ƴ϶� ������ �������� ��������
     - 
     - Ʈ������� 4���� Ư¡
       - ���ڼ� (Atomicity) : ���� ó���ϴ� �ּ� ����
       - �ϰ��� (Consistency) : Ʈ����ǿ��� ó���� ����� �ϰ����� ������.
       - ������ (lsolation) : �ϳ��� Ʈ������� �ٸ� Ʈ����ǰ� �ݸ��Ǿ� �ִ�. .LOCK
       - ���Ӽ� (Durability) : commit ,DB�� ���������� �����
*/

-- ���̺� ����

create table account10
as
select eno as no, ename as name, salary as account
from employee;

-- ������ ���� ���̺� : no : ���¹�ȣ, name : ��������, account : ��(�Աݾ�), ��
select * from account10;

-- SMITH���� MITTER���� 10���� �Ա� : 2���� update ������ �ϳ��� transaction ���� ó�� : ALL or NOTHING
  -- SMITH ACCOUNT - 10�� : update account10 set account = account -10 where no= 7369
  -- MILLER Account + 10�� : update account10 set account = account +10 where no= 7934
  
begin transaction; -- ��������� Ʈ������� ���� 

  update account10
  set account = account -10
  where no = 7369;
  
  update account10
  set account = account +10
  where no = 7934;

select * from account10;
-- Ʈ����� ����  
 rollback;
 commit;
 
desc account10;

/*
   DML : insert(���� �Է�) , update(����), delete(����)
     <== Ʈ����� �ڵ� ����, 
     <== Ʈ����� ���� ( rollback, commit)�� ��� (����Ŭ)
*/

-- ���̺� ����
create table dept03
as
select*from department;

select*from dept03;

-- dept03: primary key ���� ���� �߰�
alter table dept03
add constraint PK_DEPT03_DNO primary key (dno);

-- INSERT: ���� ����, �� Į���� �ڷ��� : number, ����, ��¥, Į���� ����� ���� ������ Ȯ��
desc dept03;
select*from user_constraints where table_name in('DEPT03');

-- insert into ���̺�� (Į����, Į����, Į����)values(��, ��, ��);

insert into dept03(dno, dname, loc)
values(50, 'HR', 'SEOUL');

rollback;
commit;

select*from dept03;

-- insert�� Į���̸��� ��� ���� �ʴ� ��� ��� Į���� ���� �־����.
insert into dept03
values(60,'�λ��','�λ�');

commit;

--Į�� ���� �Ҷ��� ��� Į���� ���� ������ �°� �Է� 
insert into dept03 
values(60,'�λ��'); -- �����ڵ� �λ���� �־���ߵ�

-- Į���� ����Ҷ� ������ �ٲ� �� �ְ�, Ư��Į���� ���� ���� �ʾƵ� ��.
insert into dept03(dname, dno)
values('������',80);

select*from dept03;
commit;


-- UPDATE �� : �Էµ� ���� ������ ���, �ݵ�� where ������ ���, where ���ǿ� ���Ǵ� Į���� Primary Key Į���̾�� ��.
/*
 update ���̺��
 set Į���� = �ٲܰ�, Į����=�ٲܰ�
 where ���� 
*/

--�߿� 
update dept03 
set loc = '�뱸'
where dno = 80;

update dept03
set dname = '������', loc = '����'
where dno = 40;

rollback;

select*from dept03;

--
insert into dept03
values(90,'������','�뱸');

insert into dept03
values(91,'������','����');

commit;
-- update���� �ݵ�� where ����, ������ ó���ϴ� Į���� Primary key, Unique Ű Į���� ����
update dept03
set dname = '�μ��'
where loc = '����';  -- �ߺ��� ��

-- update �� primary key Į���� �������� ó���ؼ� ���ϴ� ���� ����
update dept03
set dname = '�μ��'
where dno in(91,80);

-- Delete : ���ڵ带 ���� �Ҷ�, Where<����>, <����: �ߺ����� �ʴ� Į��>
/*
  delete ���̺��
  where ����
*/

select*from dept03;

--delete������ ������ ������� �ʴ� ��� ��� ���ڵ尡 ������
delete dept03
rollback;

-- delete, where ���� ���,  <== 
delete dept03
where dno = 91;

-- ��� ���ڵ带 ���� :
   /* delete                : ���ڵ� �ϳ��ϳ��� ������, �ð��� ���� �ɸ�. << �ο췹�� ����>>       
      truncate table ���̺�� :    �Ѳ����� ��°�� ��� ���ڵ带 ����. <<���� ����>>
      
      drop table ���̺��    :  ���̺� ��ü�� ����
    */
select*from dept03;    
rollback;
commit;

-- ��� ���ڵ� ���� : ���� ���� �ѹ鰡��
delete dept03;

-- ��� ���ڵ� ���� : ���� ����  <== DDL ���̱� ������ Rollback�� �ȵ�. ������ �ٷ� Ŀ�Ե�
  -- ������ ó����
  
truncate table dept03;
-------------------------------------------------------------
create table emp04
as
select*from employee;

select*from emp04;

/*
   ������ ���� �߰�: insert
   ������ ���� ����: update
   ������ ���� ����: delete
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
/*   DDL : create(����),alter(����),drop(����)<== ���̺�,��,�Լ�,������,Ʈ����,�������ν���, ��Ű���� ����, ����, ����
  
   �ڷ���: �����͸� �����ϴ� Ÿ��
   - ����: number(�����ڸ���) :���� 3�ڸ�
          number(7,2) : �Ҽ� , ��ü7�ڸ�, �Ҽ�������2�ڸ�����
   - ����: char(n) : ����1��(1byte), �ѱ�1��(3byte)
           - ������ ������.�ϵ� ���� ���� �߻��� �� �ִ�.
           - �ֹι�ȣ(13), �ڸ����� ������ ���� ����
          varchar2(n) : ����1��(1byte), �ѱ�1��(3byte)
            - ������������ �����, ������ char���� ������ �ִ�. �ϵ���� ���� ��Ű�� �ʴ´�.
            - �ڸ����� �� �� ���� ���ڿ��϶� ����
            nchar(n)     : nchar(10) : �ѱ�10��
            nvarchar2(n) : nchar(10) : �ѱ�10��
    - ��¥ : date : BC 4712��1��1�� ~~~9999�� 12�� 31�ϱ��� ����, ��, ��, ��, ��, ��, �� ������ ���� ����
             timestamp: insert(���� ������ �ý����� �ð�): ��, ��, ��, ��, ��, �� �и���������� ����
             
     - LOB ������ Ÿ�� : �뷮�� ���� ����, ���̳ʸ� ����
          CLOB: ���ڸ� �뷮���� ������ �ִ�. <==�� ����
          BLOB: mp3,jpeg,hwp ���� ������ ����
          BFILE: ��뷮 ������ ����
             
*/  

--
drop table test10;
create table test10(
   id number(4)not null primary key,  -- �ߺ��� �� ���� �� ����. ���� 4��
   n1 char(10) ,              -- ����10��, �ѱ�3��
   n2 char(10) ,              -- ����10��, �ѱ�10��
   n3 varchar2(10) ,          -- ����10��, �ѱ�3��
   n4 nvarchar2(10)          -- ����10��, �ѱ�10��
  ); 
  
select*from test10;  
commit;
rollback;
insert into test10(id,n1,n2,n3,n4)
values ( 1111, 'abc','����','abc','����');

insert into test10(id,m1)
values(1112,'������');

/*
JOIN : Datebase���� ���� ���̺��� �����մϴ�. �𵨸��� ���ؼ� ���̺��� �и� �Ǿ� �ִ�. ( R-DBMS )
    employee ���̺�� department ���̺��� �ϳ��� ���̺��ε� �𵨸��� (1,2,3����ȭ), �� ���ؼ� ���̺��� �и�
    �𵨸� : �ߺ� ����, �������, 
    
    ���� ���� : ���̺��� Į���� ���� Ű , �������� ���Ἲ ( ���Ծ��µ�����, ���ϴ� ���� )
      Primary Key : 
        - ���̺��� Į���� 1���� ���� �� �ִ�.
        - 2�� Į���� ���  Primary Key �� ���� �� �ִ�.
        - ���̺��� �����Ҷ� �ݵ�� PK �� �����ؾ� �Ѵ�. - Update, Delete �����ؼ� PK Į���� where �������� �����.
        - Ư�� Į���� �ߺ� �� ���� ���� ���ϵ��� ��.
        - �ݵ�� not null �÷��̾����. null�� ���� �� ����.
        - index �� �ڵ����� ���� �ȴ�. Į���� �˻��� ������ �Ѵ�.
        - JOIN �� ON ���� ���� ����ϴ� Ű Į��.
        
      Unique Key :  
       - Į���� �ߺ��� ���� ���� ���ϵ��� ��.
       - null�� ���� �� �ִ�. �� 1���� ���� �� �ִ�. not null, null
       - �ϳ��� ���̺� ������ Unique Key�� ���� �� �ִ�.
       - index �� �ڵ����� ������, JOIN �� ON �� ����
       
      Foreign Key :  
      - �ٸ� ���̺�(�θ� ���̺�) �� Ư�� Į���� �����ؼ� ���� �ֵ��� ��.
      - Foreign key �� �����ϴ� Į���� �θ����̺��� Primary Key, Unique Key �� ������.
      -
      
     NOT NULL
     - Į���� NULL�� ���� �� ������ �ϴ� ���� ����
     
     CHECK 
     - Į���� ������ �־ ���� ���ϴ� ���� ���� �� �ֵ��� ��.
     - �� Į���� 1 ~ 12 ���� ���� �� �ֵ��� 
     
     default : ���� ������ �ƴ����� ���� ����ó�� ����
        - Į���� ���� ���� ������ default �� ������ ���� ��ϵ�.
     
     ���� ������ ����ϴ� ������ ����: user_constraints
       select*from user_constraints where table_name in ('���̺��');
       
*/

-- ���� ���� �̸��� ���� �ʰ� ���̺� ���� �� ��� : Oracle���� ���������̸��� �����ϰ� �����Ѵ�.
-- insert�� ������ �߻��� ��� �������� �̸����� ������ Į���� ã�� �����. Primary Key : 
create table member1(
  id varchar2(50) not null primary key,   -- ���� ���� �̸��� �����ϸ� Oracle���� �ڵ����� ������.
  pass varchar2(50) not null,
  addr varchar2(100) null,
  jumin char(13) null,      -- �ڸ����� ������ Į��
  phone varchar2(50),
  age number(3),            -- ���� 3�ڸ�
  weight number(5,2)        -- �Ǽ� ��ü 5�ڸ�, �Ҽ�������2�ڸ�
  );     
desc member1;  
select*from member1;  
commit;
insert into member1( id, pass, addr, jumin, phone, age, weight)
values('abc','1234','����','123456-789101','010-1111-1111',30,77.77);  --���� �� ���Է½� �������� ����

select*from user_constraints where table_name in ('MEMBER1');

-- ���̺� ������ ���� ���� �̸� �ο�
create table member2(
  id varchar2(50) not null constraint PK_MEMBER2_ID primary key,   -- ���� ���� �̸��� �����ϸ� Oracle���� �ڵ����� ������.
  pass varchar2(50) constraint NN_MEMBER2_PASS not null,
  addr varchar2(100) null,
  jumin char(13) null,      -- �ڸ����� ������ Į��
  phone varchar2(50),
  age number(3),            -- ���� 3�ڸ�
  weight number(5,2)        -- �Ǽ� ��ü 5�ڸ�, �Ҽ�������2�ڸ�
  );    
select*from user_constraints where table_name in ('MEMBER2');  -- 

insert into member2( id, addr, jumin, phone, age, weight)
values('abc','����','123456-789101','010-1111-1111',30,77.77);
commit;
----------------------------------------------

/* UNIQUE: �ߺ��� ���� ���� �� ����. null�� ���� �� �ִ�. ���̺� ������ ���� �� �ִ�.
 
*/
create table member3(
  id varchar2(50) not null constraint PK_MEMBER3_ID primary key,   -- ���� ���� �̸��� �����ϸ� Oracle���� �ڵ����� ������.
  pass varchar2(50) constraint NN_MEMBER3_PASS not null,
  addr varchar2(100) null,
  jumin char(13) null constraint U_MEMBER3_JUMIN unique,      -- �ߺ��Ǹ� �ȵ�
  phone varchar2(50)not null constraint U_MEMBER3_PHONE unique, -- �ߺ��Ǹ� �ȵ�
  age number(3),            -- ���� 3�ڸ�
  weight number(5,2)        -- �Ǽ� ��ü 5�ڸ�, �Ҽ�������2�ڸ�
  );
insert into member3( id, pass, addr, jumin, phone, age, weight)
values('abc','1234','����','123456-789101','010-1111-1111',30,77.77);
commit;  
select*from member3  


---------------------------------------------------------------

--CHECK ���� ���� : Į���� ���ǿ� �´� ���� ���� �� �ֵ��� ��.
drop table member4;

create table member4(
  id varchar2(50) not null constraint PK_MEMBER4_ID primary key,   -- ���� ���� �̸��� �����ϸ� Oracle���� �ڵ����� ������.
  pass varchar2(50) constraint NN_MEMBER4_PASS not null,
  addr varchar2(100) null constraint CK_MEMBER4_ADDR check (addr in('����', '�λ�', '�뱸')),
  jumin char(13) null constraint U_MEMBER4_JUMIN unique,      -- �ߺ��Ǹ� �ȵ�
  phone varchar2(50)not null constraint U_MEMBER4_PHONE unique, -- �ߺ��Ǹ� �ȵ�
  age number(3) constraint CK_MEMBER4_AGE check(age>0 and age<200),            -- ���� 3�ڸ�
  gender char(1)constraint CK_MEMBER4_GENDER check(gender in('w','m')),
  weight number(5,2),        -- �Ǽ� ��ü 5�ڸ�, �Ҽ�������2�ڸ�
  hiredate date default sysdate,
  addr2 char(10) default '����',
  age2 number default 0     -- �������� ,����
  );
  
insert into member4( id, pass, addr, jumin, phone, age, weight,gender)
values('abc','1234','�뱸','123456-789101','010-1111-1111',100,77.77,'w'); -- ���ǿ� �´� ������ ���� �λ� �뱸
commit;  
--------------------------------------------------------------

-- default : ���������� �ƴϴ�. �������� �̸��� �ο� �� �� ����.
  -- ���� ������ ���� ���� ���� ���� ������ default�� ������ ���� ����.

create table member5(
  id varchar2(50) not null constraint PK_MEMBER5_ID primary key,   -- ���� ���� �̸��� �����ϸ� Oracle���� �ڵ����� ������.
  pass varchar2(50) constraint NN_MEMBER5_PASS not null,
  addr varchar2(100) null constraint CK_MEMBER5_ADDR check (addr in('����', '�λ�', '�뱸')),
  jumin char(13) null constraint U_MEMBER5_JUMIN unique,      -- �ߺ��Ǹ� �ȵ�
  phone varchar2(50)not null constraint U_MEMBER5_PHONE unique, -- �ߺ��Ǹ� �ȵ�
  age number(3) constraint CK_MEMBER5_AGE check(age>0 and age<200),            -- ���� 3�ڸ�
  gender char(1)constraint CK_MEMBER5_GENDER check(gender in('w','m')),
  weight number(5,2),        -- �Ǽ� ��ü 5�ڸ�, �Ҽ�������2�ڸ�
  addr2 char(10) default '����',
  age2 number default 0     -- �������� ,����
  );
select *from member5;  
  
insert into member5( id, pass, addr, jumin, phone, age, weight,gender)
values('abc','1234','�뱸','123456-789101','010-1111-1111',100,77.77,'w'); 

insert into member5( id, pass, addr, jumin, phone, age, weight,gender,hiredate,addr2,age2)
values('abcd','1234','�뱸','123456-789103','010-1111-1113',100,77.77,'w','22/11/11','����',30); 
commit;  