
/* �׷� �Լ� : gooup by, having

select Į����
from���̺�[��]
whter ����
group by Į����[�����Ѱ����׷���]
having ���� [group by �� ��� ���� ����]
order by Į���� asc[desc]

*/

/* ���� �Լ� : number Ÿ���� Į���� ����  <=== NULL �� �ڵ����� ó����...
   SUM - Į���� ��� ���� ��
   AVG - Į���� ��� ���� ��
   MAX - Į���� �ִ밪
   MIN - Į���� �ּҰ�
   COUNT (*) - �׷��� �� ���ڵ� �� ���,
   
   ���� : ���� ������ ����� �Ǳ� ������ �ٸ� Į���� ���� ����.
       ��, group by ���� grouping �� Į���� ��� ����
       
*/
desc employee;

-- Į���� �Լ� ���: ����
-- ����(salary)
select SUM(salary)�հ�, ROUND (AVG(salary),2)���, MAX(salary)�ִ밪, Min(salary),count(*)���ȷ��ڵ��
from employee;

-- ���� �Լ��� NULL�� �ڵ����� ó����.
select commission
from employee;

-- ���ʽ�(commission) <== null�� �ڵ����� ó����
select SUM(commission)�հ�, ROUND (AVG(commission),2)���, MAX(commission)�ִ밪, 
       Min(commission),count(*)���ȷ��ڵ��
from employee;

-- �μ����� ������ �հ�, ���, �ִ����, �ּҿ���, �׷��ε� ���� ���

select dno �μ���ȣ, SUM(salary) �հ�, Round (AVG(salary))���, 
       MAX(salary) �ִ밪, MIN(salary) �ּҰ�, COUNT(*) �׷��εȼ�
from employee
group by dno;       -- DNO Į���� ������ ���� �׷����ؼ� �����Լ��� ������.

select salary, dno
from employee
order by dno asc;

--��å���� ������ �հ�, ��� �ִ밪, �ּҰ�, �׷��εȼ��� ����� ������
select ename, job, salary
from employee
order by job;

select job ��å,count(*) �׷��εȰ��� ,SUM(salary) �հ�,
       round(AVG(salary))���, MAX(salary)�ִ밪, MIN(salary)�ּҰ�
from employee
group by job;          -- job �÷��� ������ ���� �׷���

select count(*)��ü���ڵ�� from employee; --14

/*
  group by ������ where[����] vs having[����]
    where [����] : group by �ϱ����� ������ ������    , ��Ī�̸��� ����� �� ����.
    having [����] : group by �ؼ� ���� ����� ���� ���� , ��Ī�̸��� ����� �� ����.
    
    order by Į���� asc[desc] : ��Ī�̸��� ��밡��
      
*/

-- ���޺��� ������ �հ�, ���, �ִ밪, �ּҰ�, �׷��� �� ���� ����ϵ�, 
--   �μ���ȣ20�� �����ϰ� �μ����� ����� 2000�̻��� ���븸 ���

select ename, job, salary
from employee
order by job;

select job ��å,count(*)�׷��εȰ��� ,SUM(salary)�հ�,
 round(AVG(salary))���, MAX(salary)�ִ밪, MIN(salary)�ּҰ�
from employee
where dno <> 20
group by job 
HAVING AVG(salary) >= 2000;
--------------------------------------------------------
select*from employee
order by dno asc;

select job ����, count(job), SUM(salary) �������հ�, Round(AVG(salary))���,
      MAX(salary)�ִ밪,MIN(salary)�ּҰ�
from employee
where dno!=(20)    -- group by���� ����
group by job       -- �����޺���� 
having Round(AVG(salary))>=2000  -- 2000�̻� ���
order by ��� desc;


-- group by ������ Į���� 2�� �̻�, �� Į���� ���ļ� ������ ������ �׷�����.
  -- job, dno
  
select job , dno from employee
order by job asc; 

select dno, job, sum(salary) ���Ѱ�, count(*)
from employee
group by job, dno

-- �� ��å(job) �� ���ؼ� ������ �հ�, ���, �ִ밪, �ּҰ�, ī��Ʈ���� ����ϵ� �Ի����� 81�⵵�� �Ի��� ����� �� ����
-- ������ ����� 1500���� �̻��� �͸� ��� �ϵ� ����� �������� ����

SELECT job ��å, count(*), sum(salary) �հ�, round(avg(salary)) ���, max(salary)�ִ밪,
      min(salary) �ּҰ�
from employee
where hiredate like '81%'
group by job
having round(avg(salary)) >= 1500
order by ��� desc;

/*  group by ������ ���Ǵ� Ű����
    rollup : group by Į�� <== ��� ������ ���ο� ��ü ����� �ѹ��� ���
    cube   : �׷��� ������ ���ο� ��� ���, ������ ���ο� ��ü ����� ���������� ���
*/

-- 1. rollup , cube Ű���带 ������� �ʴ� ��� : �׷����� ����� ���
 select dno, job , count(*), SUM(salary), round(avg(salary),2) , max(salary), min(salary)
 from employee
 group by dno, job 
 order by count(*) desc;
 
 select dno , job
 from employee
 order by dno asc
  
-- 2. rollup Ű���带 ������� �ʴ� ��� : �׷����� ��� ���, ��ü ���뵵 ��� 
 select dno, job , count(*), SUM(salary), round(avg(salary),2) , max(salary), min(salary)
 from employee
 group by rollup (dno,job) 
 order by count(*) desc;


-- 3. cube Ű���带 ����ϴ°�� : �׷����� ��� ���, ��ü ���뵵 ���, ���λ��ױ��� ���
 select dno, job , count(*), SUM(salary), round(avg(salary),2) , max(salary), min(salary)
 from employee
 group by cube(dno,job) 
 order by count(*) desc;

/*
   SubQuery : SElect ������ select ���� [ sub query ] , �������� �۾��� �� �������� ó�� 
     - where ������ ���� ����
 */
-- ename[����̸�]�� SCOOTT�� ����� ��å�� ���� ������� ��� : 2�� ������ �ʿ���.

-- 1. SCOTT ����� ��å�� �˾ƿ��� ����
 select job 
 from employee 
 where ename = 'SCOTT'
 
-- 2. �˾ƿ� ��å�� �������� �ؼ� �̸��� ��� 
select ename , job
from employee
where job = 'ANALYST'

-- SubQuery�� ����ؼ� �ϳ��� ������ ó����.

select ename ,job
from employee
where job =(select job from employee where ename= 'ALLEN');

select * from employee;

-- SCOTT�� ALLEN �� ��å�� �ش���� �ʴ� ������� ��� ���
-- 1. scott�� ��å�� ����ϴ� ����
-- 2. allen�� ��å�� ����ϴ� ����
-- 3. where job not in('scott�� ��å','aleen��å'

-- 1. scott�� ��å�� ����ϴ� ����
select job, ename from employee where ename = 'SCOTT' -- ANALYIST
from employee

-- 2. allen�� ��å�� ����ϴ� ����
select job, ename from employee where ename = 'ALLEN'-- SALESMAN

-- 3. SCOTT�� ALLEN�� ��å�� �ش���� �ʴ� ������ ��� ���
select ename, job
freom employee
where job not in('ANALYIST','SALESMAN');

--- SUbQUery�� �� �������� ���
select ename, job
from employee
where job not in(
(select job from employee where ename= 'SCOTT'),
(select job from employee where ename= 'ALLEN')
);

select ename, job
from employee
where job not in(
select job from employee
where ename = 'SCOTT' or ename = 'ALLEN'
);

select ename, job
from employee
where job not in(
select job from employee
where ename in('SCOTT','ALLEN')
);

select * from employee;
-- ���� �� :  =
-- �������� �� : in

-- 'SCOTT' ���� ���� ������ �޴� ����� ����, ������ ���

select ename ���, salary ����
from employee
where salary > (select salary from employee where ename = 'SCOTT');

select*from employee
order by salary desc;

-- �ּ� �޿��� �޴� ������� �̸� ������ �޿� ���
select ename, job, salary
from employee
where salary =(select MIN(salary) from employee);

-- subquery�� ����ؼ� ���
--  �μ���(dno) �� �ּ� �޿��� �޴� ��������� �̸�, ��å, ������ ��� : hint : group by , do , dno , min , in Ű����
select ename, job, salary
from employee
where (dno, salary) in (
select dno, min(salary)
from employee
group by dno
);
------------------------------------------------
select salary, dno, ename
from employee
order by dno asc, salary desc;

--subquery
select ename �̸�, job ��å, salary ����, dno �μ���ȣ
from employee
where salary in (
  -- �� �μ��� �ּҿ����� select �� ���� ���
   select min(salary)
   from employee
   group by dno
   );
-- subquery   
-- �� �μ��� �ּ� �޿��� 30�� �μ��� �ּ� �޿����� ū �μ��� ��� 
select ename �̸�, job ��å, salary ����, dno �μ���ȣ
from employee
where dno <> 30 and salary > (
   select min(salary)
   from employee
   where dno = 30
   );
 ------------------------------------------------
select dno, count(*),min(salary)
from employee
group by dno   -- �μ���ȣ ������ ���� �׷���
having min(salary)>(
        -- �������� : 30�� �μ��� �ּ� ����
        select min(salary) from employee
        where dno = 30   -- �������� �����ݷ� �����ʱ�
        
        );

        