
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
     hiredate �Ի糯¥,salary����,commission���ʽ�,dno�μ���ȣ
from employee;     