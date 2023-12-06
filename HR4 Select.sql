
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
select eno, ename, salary, ename, ename, salary*12
from employee;

-- �÷� �̸��� ��Ī���� �ٲٰ� ��� �ϱ�
select eno as"��� ��ȣ", ename �����, salary as ����, salary*12 as ����
from employee;

-- employee ���̺��� �� Į���� �ǹ� 
select*
from employee;

select eno �����ȣ, ename �����, job ��å, manager ���ӻ��,
     hiredate �Ի糯¥,salary ����,commission ���ʽ�,dno �μ���ȣ
from employee; 

-- ���̺� ������ Ȯ�� �ϱ� .desc���̺��, ���� �÷���, null ��뿩��, �ڷ���(number: ����, �Ǽ�, char, varchar2 : ���ڿ�)
desc employee;  -- insert �� �÷��� �ڷ���, NULL ��뿩�θ� Ȯ���� ���� ����

select*from employee;

--������ ��� : ���� : NuLL���� ������ ����� NULL

select eno �����ȣ, ename �����, salary ����, commission ���ʽ�
from employee;

-- ���� = ���� * 12 + ���ʽ�
    -- null �÷��� ������ �ϸ� ��� null

-- null ó���� �ȵ�
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,  --���� ���̺� ���
     salary* 12 + commission ����
from employee;

-- nvl (�÷���,0) : null �� ó���ϴ� �Լ�. null�� ó���ϴ� �Լ�, �÷��� �� �� null�� 0���� ��ȯ�ϴ� �Լ�

select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,  --���� ���̺� ���
    nvl(commission,0) ��ó����, salary* 12 + nvl(commission,0) ����
from employee;

--�÷��� �÷��� ���� �� �� �ִ�. : + , -, *, / <== number (����,�Ǽ�)Ÿ��
-- number : ����
-- number(7,2) : �Ǽ�.   ��ü 7�ڸ�,�Ҽ�������2�ڸ�

select*from employee;
desc employee;

select ename, salary, salary + salary as "+����" , salary * salary as"*����", salary * 0.1 as"������10%"
from employee;

