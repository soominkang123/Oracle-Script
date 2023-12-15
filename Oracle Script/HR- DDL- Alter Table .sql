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