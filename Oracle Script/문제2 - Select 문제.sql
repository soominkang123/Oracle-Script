/*
1. ���� �����ڸ� ����Ͽ� ��� ����� ���ؼ� $300�� �޿� �λ��� ������� ����̸�, �޿�, �λ�� �޿��� ����ϼ���. 
2. ����� �̸�, �޿�, ���� �� ������ ������ ���� ���������� ��� �Ͻÿ�. 
    ���� �� ������ ���޿� 12�� ������ $100�� �󿩱��� ���ؼ� ��� �Ͻÿ�. 
3. �޿��� 2000�� �Ѵ� ����� �̸��� �޿��� �޿��� ������ ���� ���������� ����ϼ���. 
4. �����ȣ�� 7788�� ����� �̸��� �μ���ȣ�� ����ϼ���. 
5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ��� �ϼ���. 
6. 1981�� 2�� 20�Ϻ��� 81�� 5�� 1�� ������ �Ի��� ����� �̸� ������, �Ի����� ����Ͻÿ�
7. �μ���ȣ�� 20�� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� �̸��� ����(��������)���� ����Ͻÿ�. 
8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30�� ����� �̸�, �޿��� �μ���ȣ�� ����ϵ� �̸��� ������������ ����ϼ���. 
9. 1981�⵵ �Ի��� ����� �̸��� �Ի����� ��� �Ͻÿ� ( like �����ڿ� ���ϵ� ī�� ��� : _ , % )
10. �����ڰ� ���� ����� �̸��� �������� ����ϼ���.
11. Ŀ�Լ��� ���� �� �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼��� ����ϵ� �޿� �� Ŀ�Լ��� �������� �������� �����Ͽ� ǥ���Ͻÿ�.
12. �̸��� ����° ������ R�� ����� �̸��� ǥ���Ͻÿ�.
13. �̸��� A �� E �� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�.
14. ��� ������ �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸缭 
    �޿��� $1600, $950, �Ǵ� $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�.
15. Ŀ�̼��� $500�̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�.  
*/

--1. ���� �����ڸ� ����Ͽ� ��� ����� ���ؼ� $300�� �޿� �λ��� ������� ����̸�, �޿�, �λ�� �޿��� ����ϼ���. 
select*from employee;
select ename as "����̸�", salary as "�޿�" , salary +300 as "�λ�ȱ޿�"
from employee;

desc employee; 

select * 
from employee; 

select eno as �����ȣ, ename �����, job ��å, manager "���ӻ��  ID",
    hiredate �Ի糯¥, salary ����, commission ���ʽ�, dno �μ���ȣ
from employee; 

select ename, salary, salary + 300 as �λ�ȱ޿�
from employee; 
--2. ����� �̸�, �޿�, ���� �� ������ ������ ���� ���������� ��� �Ͻÿ�. 
--    ���� �� ������ ���޿� 12�� ������ $100�� �󿩱��� ���ؼ� ��� �Ͻÿ�. 
select ename as "����̸�", salary as "�޿�" , (salary * 12) + 100 AS "�����Ѽ���"
from employee;

-- ����� DataBase���� ��� ���̺� ��� 
select*from tab;  -- tab=table

select ename, salary, commission from employee; 
    
select ename, salary,commission,salary *12, salary *12 + NVL(commission,0) + 100 as �ѿ���
from employee;   
--3. �޿��� 2000�� �Ѵ� ����� �̸��� �޿��� �޿��� ������ ���� ���������� ����ϼ���. 
desc employee;

select ename as "����̸�",salary as "�޿�"   -- �÷���
from employee                               -- ���̺�, ��
where salary>2000                           -- ����   
order by salary DESC                        -- ����

--4. �����ȣ�� 7788�� ����� �̸��� �μ���ȣ�� ����ϼ���.
select ename as "����̸�",dno as "�μ���ȣ"
from employee
where eno = 7788;  --ebo noŸ��

--5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ��� �ϼ���. 
select ename as "����̸�", salary as "�޿�"
from employee
where salary not between 2000 and 3000;

where salary < 2000 or salary > 3000 ;

--6. 1981�� 2�� 20�Ϻ��� 81�� 5�� 1�� ������ �Ի��� ����� �̸� ������, �Ի����� ����Ͻÿ�
select ename as "����̸�", job as "������",  hiredate as "�Ի���"
from employee
WHERE hiredate BETWEEN '1981-02-20' AND '1981-05-01';  --between A and B '' '' �־�ߵ�

--7. �μ���ȣ�� 20�� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� �̸��� ����(��������)���� ����Ͻÿ�.
select ename as "����̸�",dno as "�μ���ȣ"
from employee
where dno in(20,30)
order by ename desc;

select ename, dno 
from employee
where dno = 20 or dno = 30 
order by ename asc; 

--8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30�� ����� �̸�, �޿��� �μ���ȣ�� ����ϵ� �̸��� ������������ ����ϼ���.
select ename as "����̸�",salary as "�޿�", dno as "�μ���ȣ"
from employee
where salary between 2000 and 3000
and (dno= 20 or dno= 30) 

--9. 1981�⵵ �Ի��� ����� �̸��� �Ի����� ��� �Ͻÿ� ( like �����ڿ� ���ϵ� ī�� ��� : _ , % )
select ename as "����̸�", hiredate as "�Ի���"
from employee 
where hiredate like '81%';

select ename as "����̸�", hiredate as "�Ի���"
from employee 
where substr(hiredate,1,2)-'81';

--10. �����ڰ� ���� ����� �̸��� �������� ����ϼ���.
select * from employee; 

select ename as "����̸�",job as "������"
from employee
where manager IS NULL;

--11. Ŀ�Լ��� ���� �� �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼��� ����ϵ� �޿� �� Ŀ�Լ��� �������� �������� �����Ͽ� ǥ���Ͻÿ�.
select * from employee
order by commission desc

select ename as "����̸�",salary as "�޿�",commission as "Ŀ�̼�"
FROM employee
WHERE commission IS NOT NULL
ORDER BY salary DESC, commission DESC;

--12. �̸��� ����° ������ R�� ����� �̸��� ǥ���Ͻÿ�.
select ename as "����̸�"
from employee
where ename like '__R%' --__

select ename
from employee
where instr(ename, 'R', 3)=3;

select ename , instr(ename, 'R', 3) from employee; 

--13. �̸��� A �� E �� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�.
select ename as "����̸�"
from employee
where ename like '%A%' and ename like '%E%'; 

select ename 
from employee
where instr(ename, 'A')!=0 and instr(ename, 'E')!=0;

select ename , instr (ename, 'A') , instr(ename , 'E') from employee; 
--14. ��� ������ �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸缭 
--    �޿��� $1600, $950, �Ǵ� $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�.
select ename as "����̸�",job as "������",salary as "�޿�"   
from employee
where job in ('CLERK', 'SALESMAN')
 and salary not in (1600,950,1300);
 
--15. Ŀ�̼��� $500�̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�.  
select ename as "����̸�",salary as "�޿�",commission as "Ŀ�̼�"
from employee
where commission >= 500;