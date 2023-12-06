
/*
  Select : ���̺��� ���� �˻� 
  
  Select �÷��� from ���̺�� [���]
  
  Select * from employee;
*/

-- employee ���̺��� ��� �÷��� ����ϱ�

select * from employee;

SELECT*
from employee;

-- Ư�� �÷��� ��� �ϱ�
select eno,ename,job
from employee;

-- Ư�� �÷��� ������ ��� �ϱ� , �÷��� ������ �� �� �ִ�. �÷��̸��� �ٲ� �� �ִ�.
select eno,ename,salary,ename,ename,salary * 12
from employee;

-- �÷� �̸��� ��Ī���� �ٲٰ� ��� �ϱ�
select eno as "��� ��ȣ",ename �����,salary ����, salary*12 as����
from employee;

-- employee ���̺��� �� Į���� �ǹ� 
select *
from employee;

select eno �����ȣ, ename �����, job ��å, manager ���ӻ��,
     hiredate �Ի糯¥,salary ����,commission ���ʽ�,dno �μ���ȣ
from employee; 

-- ���̺� ������ Ȯ�� �ϱ� , desc ���̺�� ,  ���� �÷���, null ��뿩��, �ڷ���(number : ����, �Ǽ� , char, varchar2  : ���ڿ�)
desc employee;      -- insert �� �÷��� �ڷ���, NULL ��� ���θ� Ȯ����  ���� ����.

select * from employee;

-- �츮ȸ���� �μ��� ���
select distinct dno
from employee;

-- �츮 ȸ���� ��å�� �ߺ������� ��� ( CLERK : �繫��, SALESMAN: �������, MANAGER : ������, ANALYST : �м���
  -- PRESIDENT : ����)
  -- ��ҹ��� ���� ���� ���� : ���� ( select, create, from, group by, order by ), �÷���, ���̺��
  -- ���̺� ���� ���ڵ��� ���� ��ҹ��ڸ� ������.
  
select distinct job
from employee;

select * from employee;

--JOB(��å) �� MANAGER (������) �� ����� ������ ���

select ename �����,job ��å
from employee
where job = 'MANAGER';

-- �μ� ���̺� Ȯ�� : department

select * from department ;

select dno �μ���ȣ, dname �μ���, loc �μ���ġ
from department;

-- salgtade : ������ ������ �����ϴ� ���̺�  <== JOIN
select * from salgrade;

select grade �����ǵ��,losal ���ϳ�������,hisal ���ϳ�������
from salgrade;

-- SELECT ���� ��ü ����, SQL : ����ȭ�� ���� ���
/*
SELECT �÷���
FROM ���̺��[���]
WHERE ����
GROUP BY �׷���ó�����÷��� <== �÷��� ������ ���� �׷����ؼ� ó����.
HAVING ����              <== GROUP BY ����� ���� ����
ODER BY �÷��� ASC[DESC]  <=== �÷��� �����ؼ� ���, ASC: ������������, DESC: �������� ����     
*/

--where ���� ����ϱ� : �� ������(NUMBER Ÿ���� Į������ ���); = : ����. > , < , >= , <=
   -- ���� �ʴ� : <>  , != , ^=
   -- or           -- in (��, ��, ��)
   -- and
   -- between
   -- in (   )
select*from employee;

select*
from employee
where salary > 1500;

select*
from employee
where salary = 1500;

select*
from employee
where salary <> 1500;

--or ������
select*
from employee
where salary = 1500 or salary = 800 or salary = 1600;

--inŰ���� : in (��, ��, ��)
select*
from employee
where salary in(1500,800,1600); 

-- and ������ ��� : �μ���ȣ�� 10���� ����� ������ 1500 �̻��� ����ڸ� ���
select*
from employee
where dno = 10 and salary > 1500;

-- ��å�� manager �̸鼭 ������ 2000�̻��� ����� �����ȣ, �����, ������ ���
select eno �����ȣ, ename ����� , salary ����, job ��å
from employee
where job = 'MANAGER' and salary > 2000 ;

-- �� �����ڸ� date, varchar, char : 81�⵵ �Ի��� ����� ��� ���
select *
from employee
where hiredate> '81/01/01' and hiredate < '81/02/28';

-- ���ڿ� : char, varchar, nvarchar, nchar : ���ڿ�,''
  --
select*
from employee
where ename < 'D';

-- like in : ���ڿ����� Ư�� ���� �˻� : % : ������ �͵� �������. _: �ѱ��ڰ� ����� �͵� �������.
-- Į���� Ư�� ���� �˻��� ����.
select * from employee
where ename like '%LA%';

select*from employee
where ename like '_CO%';

--NULL �˻� : is null, is not null
select * from employee;

-- commission Į���� ���� null �� ����ڸ� ��� : ���ʽ��� �ִ� ���
select * from employee
where commission is null;

-- commission Į���� ���� null �� ����ڸ� ��� : ���ʽ��� �ִ� ���
select * from employee
where commission is null;

-- count(): ���ڵ��� ������ ���: ����¡ ó��, <==
  --null�� ī��Ʈ ���� �ʴ´�.

select count(*) �ѷ��ڵ��
from employee;

select count (ename)
from employee;

select count(commission) --���ڵ� �� : null �÷��� ��� ���� �ʴ´�.
from employee;

select commission ��������   --null : ����ִ� ����, 0 ��
from employee;

desc employee;

-- ���̺��� ��ü ���ڵ带 ��Ȯ�ϰ� ���: not null �÷��� count(�÷���), count(*)

-- Ư�� �÷��� �����ؼ� ��� : order by �÷��� ASC[DESC], select ������ ���� �������� �;� ��.
 -- ASC : ���� ���� ���� : A =====> Z , �� ===> �� , 1 ==> 9 
 -- DESC : ���� ���� ���� : Z=====> A,  �� ===> ��,  9 ==> 1
 
 -- ����(salary) Į���� �������� ����
 select*
 from employee
 order by salary asc;  -- asc�� ���� �� �� �ִ�.
 
  -- ����(salary) Į���� �������� ����
 select*
 from employee
 order by salary desc;
 
 --�̸�(ename) Į���� ���� ���� ����
 select*
 from employee
 order by ename;
 
 -- ��å(job) Į���� ���� ���� ����
 select*
 from employee
 order by job desc;
 
 -- ������ Į���� where �� ���� ����Ҷ� order by�� where �� ������ ó��
 select*
 from employee
 where salary>1500
 order by salary desc;
 --where salary>1500; //from ������ where�� �;ߵȴ�.
 
 -- ��order by���� ���� �÷��� ���� �Ҷ�, ���� �÷��� ��� �����ϰ�, �������� �����Ҷ� ���� ���� ���ؼ� ���� Į���� ����
  -- �亯�� �Խ��� ���鶧 ����....
  
 select dno, ename
 from employee
 order by dno asc, ename desc;
 
 -- job : ���� ���� ����, dno : job �� ������ ���� ���ؼ� dno�� ��������, 
   -- ename : dno���� ������ ���� ���ؼ� ename�� �������� ����
 select job, dno, ename
 from employee
 order by job asc, dno asc, ename asc;
 
 select job, dno, ename
 from employee
 order by dno desc, job asc, ename desc;
 
 