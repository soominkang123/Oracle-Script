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

