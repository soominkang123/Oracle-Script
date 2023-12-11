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
*/

select * from employee;      -- employee ���̺��� dno Į���� �����Ѵ�. ( Foreign Key )

select * from department;    -- department ���̺��� dno Į���� �����Ѵ�.

-- ���̺� ���� : ���� ���̺��� ���� ������ ���� �Ǿ� ���� �ʴ´�. Alter Table �� ����ؼ� ���� ������ �ο�
create table emp01

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

-- JOIN : ���� ���̺��� Į���� ��� �Ҷ� JOIN�� ����ؼ� �ϳ��� ���̺� ó�� �����.
  -- �� ���̺��� ���� Ű Į���� Ȯ��.
  -- emp01, dept01 ���̺��� ���� Ű Į���� dno �̴�.
  -- EQUI JOIN : ����Ŭ������ �۵��ϴ� JOIN ����
  -- ANSI JOIN : ��� DBMS���� �������� ���Ǵ� JOIN ����

-- EQUI JOIN �������� �� ���̺� ����
 -- from ������ JOIN �� ���̺��� ��� (,)
 -- ���̺� �̸��� ��Ī�̸����� ��.
 -- where ������ �� ���̺��� ���� Ű Į���� ���
 -- and ������ ������ ó��
 -- ���� Ű Į���� ��½� �ݵ�� ���̺��.Į���� 
 
select e.eno, e.ename, e.job, d.dno, d.dname, d.loc  -- �׳� dno �Է½� �����߻�
from emp01 e, dept01 d
where e.dno = d.dno

select eno, ename, job, d.dno, dname, loc  
from emp01 e, dept01 d
where e.dno = d.dno
and d.dno = 10;  

-- ANSI JOIN : ��� DBMS���� �������� ���Ǵ� JOIN ����
 -- INNER JOIN : �� ���̺��� Ű Į���� ����Ǵ� �κи� ���  <--- 80 %
 -- OUTER JOIN
       -- LEFT OUTER JOIN
       -- RIGHT OUTER JOIN
       -- FULL OUTER JOIN
 -- SELF JOIN
 -- CLOSS JOIN
 
 -- �� INNER JOIN : ANSI JOIN
    -- from ���� JOIN ���̺� �̸��� ���
    -- INNER Ű�� ���� �� �� �ִ�. <== 80% �̻�
    -- on ���� �� ���̺��� ���� Ű Į���� ���. �� ���̺��� ������ �͸� ���
    
 
 -- ���̺� �̸��� alias(��Ī) ��Ű�� �ʴ� ���   
 select eno, ename, salary, dept01.dno, dname, loc
 from emp01 INNER JOIN dept01 
 on emp01.dno = dept01.dno
 
 -- ���̺� �̸��� alias (��Ī) ����� ���
 select eno, ename, salary, d.dno, dname, loc
 from emp01 e JOIN dept01 d
 on e.dno = d.dno
 where e.dno = 20
 order by ename desc;
 
 -- INNER JOIN : ANSI SQL : ��� DBMS���� �������� ���Ǵ� SQL ���� ( Oracle, MySQL, MSSQL, DB2, ....)
    -- ON ���� �� ���̺��� ����и� ��� 
 select*
 from emp01 e JOIN dept01 d
 on e.dno = d.dno
 
 -- OUTER JOIN : 
   -- LEFT OUTER JOIN : ���� ���̺��� ��� ������ �����.
   -- RIGHT OUTER JOIN : ������ ���̺��� ��� ������ �����.
   -- FULL OUTER JOIN : ����, ������ ���̺��� ��� ������ �����.

select*from dept01;

insert into dept01 (dno, dname, loc)
values (60, 'MANAGE', 'BUSAN');

commit;

-- ���� ��� ��.
--RIGHT OUTER JOIN : �� ���̺��� ���� �κа� ������ (dept01)���̺��� ��� ���� ���
select*
from emp01 e RIGHT OUTER JOIN dept01 d    -- INNER ��������
on e.dno = d.dno 

-- FULL OUTER JOIN : �� ���̺�(����, ������)�� ��� ������ ���
select*
from emp01 e FULL OUTER JOIN dept01 d
on e.dno = d.dno;

-- SELF JOIN : �ڽ��� ���̺��� JOIN. �ڽ��� ���̺��� ��Ī�̸����� �������� �����ؼ� JOIN
  -- ������ ���, ���� ��縦 �ٷ� ��� �Ҷ� ����
 
 select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ����ȣ, m.eno ���ӻ�����, m.ename ���ӻ����
 from emp01 e JOIN emp01 m
 on e.manager = m.eno;
 
 -- SELF JOIN���� ��� �̸��� ���� ���� ����� �������� ���
 -- ���ӻ���� ���� ����� ��� : LEFT OUTER JOIN
 select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ����ȣ, m.eno ���ӻ�����, m.ename ���ӻ����
 from emp01 e LEFT OUTER JOIN emp01 m
 on e.manager = m.eno;
 
 -- �����ȣ�� ������ � ����� ����� �ƴ� ����� ��� ��� �ض� :  RIGHT OUTER JOIN
 select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ����ȣ, m.eno ���ӻ�����, m.ename ���ӻ����
 from emp01 e RIGHT OUTER JOIN emp01 m
 on e.manager = m.eno;
 
 -- ���ӻ���� ���°� (����), �����ȣ�� �������� ������ ���� ����� �ƴ� ���(������) : FULL OUTER JOIN
  select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ����ȣ, m.eno ���ӻ�����, m.ename ���ӻ����
 from emp01 e FULL OUTER JOIN emp01 m
 on e.manager = m.eno;
 
 select eno,ename , manager, eno,ename
 from employee;

-- ����̸� 'SCOTT'�� �μ���(dnane), �μ���ġ(loc)  <== ename : 'SCOTT'�� emp01, dept01: dname,loc
-- ANSI JOIN 

select*from emp01;
select*from dept01;

--emp01, dept01 �� JOIN�ؼ� ���

select ename, dname,loc, e.dno
from emp01 e JOIN dept01 d
on e.dno = d.dno
where ename = 'SCOTT';

-- 2. ������ 2000���� �̻��� ����� �̸�, ����, �μ���,�μ���ġ, ��� : ANSI JOIN
select ename, salary, dname, loc, e.dno
from emp01 e JOIN dept01 d
on e.dno = d.dno
where salary >= 2000
order by dno desc;

-- ANSI JOIN
-- 3. ��å�� 'MANAGER'�� ����̸�(eno), �μ���ȣ(dno), �μ���(dname), �μ���ġ(loc) ����ϵ� ����̸� �������� ����
select job ��å, ename ����̸�, e.dno �μ���ȣ, dname �μ���, loc �μ���ġ
from emp01 e JOIN dept01 d
on e.dno = d.dno
where job = 'MANAGER'
