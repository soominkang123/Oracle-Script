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
      
    
*/

select * from employee;      -- employee ���̺��� dno Į���� �����Ѵ�. ( Foreign Key )

select * from department;    -- department ���̺��� dno Į���� �����Ѵ�.

-- ���̺� ���� : ���� ���̺��� ���� ������ ���� �Ǿ� ���� �ʴ´�. Alter Table �� ����ؼ� ���� ������ �ο�
create table emp01
as 
select * from employee;

create table dept01
as
select * from department;

/*
   ���̺��� ���� ������ Ȯ�� �ϴ� ��ɾ� : 
   user_constraints : ������ ���� <== ���̺��� ���� ������ �˷��ִ� ���̺�
*/
select * from user_constraints;

select * from user_constraints
where table_name in ('EMPLOYEE','DEPARTMENT');

-- ���̺��� �����ϸ� ���̺��� Į���� �ο��� ���� ������ ����Ǿ� ���� �ʴ´�. Į���� ���� ����Ǿ�´�.
-- altertable �� ����ؼ� ���� ������ �ο��ؾ� �Ѵ�.
-- alter table : ������ ���̺��� ����
select * from user_constraints
where table_name in ('EMP01','DEPT01');

-- dept01 ���̺� dnoĮ���� Primary Key ���� ������ �߰�
alter table dept01
add constraint PK_DEPT01_DNO primary key(dno);

-- emp01 ���̺� eno Į���� Primmary Key ���� ���� �߰�
alter table emp01
add constraint PK_EMP01_ENO primary key(eno);

-- emp01 ���̺��� dno Į���� Foreign Key �ο�, ����(references)�� ���̺��� Į���� Depe01 ���̺��� dno Į���� ����
alter table emp01 
add constraint FK_EMP01_DNO foreign key(dno) references dept01(dno);

-- Primary Key Į���� Ȯ�� :
desc emp01; 

select * from emp01;

-- ���� ������ Į���� �ο��� ���� ������ �� Ȯ�� �ϰ� ���� insert 
-- eno : Primary Key �� ���, �ߺ��� ���� ������ �ȵ�
-- dno : Foreign Key ���, Dept01 ���̺��� dno Į���� �����ϴ� ���� �־�� �Ѵ�.

insert into emp01(eno, ename, job, manager, hiredate, salary, commission, dno)
values( 7977, 'KSM', 'CLERK', 7782, '23/12/11', 1500, null, 40 );

commit;  -- DML ( insert, updatem delete ) ���� DB�� ������ ����ǵ��� ��. <����Ŭ>

select * from emp01;
select * from dept01;

-- dept ���̺� �� �ֱ� : dnoĮ�� : Primary key�� ����.
desc dept01;

insert into dept01( dno, dname, loc)
values (50, 'HR', 'SEOUL');

commit; -- DML (insert, update, delete ) ���� �ݵ�� ����

select * from dept01;

select * from emp01;
