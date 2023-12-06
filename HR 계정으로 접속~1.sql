
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

-- �ߺ�ó���� ��� : distinct �÷��� , �÷����� �ߺ��� ������ ���

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
