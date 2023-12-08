/*
1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 
2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�.
3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
4. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
5. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 
6. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ�
   ������ ������ ��ġ ��Ű�ÿ�.
7. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
8. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���.
9. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�.
10.   �����ȣ,
      [�����ȣ 2�ڸ������ �������� *���� ] as "������ȣ", 
      �̸�, 
       [�̸��� ù�ڸ� ��� �� ���ڸ�, ���ڸ��� * ����] as "�����̸�"       
11.  �ֹι�ȣ:   �� ����ϵ� 801210-1*******   ��� �ϵ��� , ��ȭ ��ȣ : 010-12*******
	dual ���̺� ���
    
12 �ڽ��� ���Ͽ��� ������� ��� ��Ҵ��� ?  ���� ��Ҵ��� ���   <== months_between ( ���糯¥, ����)  : ������ 
        -- sysdate - ���� (date) 
        
13.  employee ���̺��� 2050�� 12�� 24 �ϱ����� ��¥(�ϼ�)  �� ��� 
*/  

select*from employee;
--1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 
select ename ���, hiredate �Ի糯¥,
substr(hiredate, 1, 2) as �Ի�⵵,
substr(hiredate, 4, 2) as �Ի��
from employee;

select * from employee; 
select substr ( hiredate, 1,5 ) as ��� 
from employee; 
--2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�.
select ename as ���, hiredate �Ի���, substr(hiredate, 4,2)
from employee
where substr(hiredate, 4,2)= '04';

--3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
SELECT *
FROM employee
WHERE MOD(MANAGER, 2) = 1;

select ename, manager 
from employee
where MOD (manager , 2) = 1; 

--4. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select ename, salary 
from employee
where MOD ( salary , 3) = 0 ; 

--5. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 
select hiredate , to_char ( hiredate, 'YY MON DD DY') as ��°�� 
from employee; 

--6. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ�
--   ������ ������ ��ġ ��Ű�ÿ�.
select trunc (sysdate - to_date ( 20220101 , 'YYYYMMDD')) as ���س�¥�� from dual  

--7. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
 select trunc (sysdate - to_date ( 19800101 , 'YYYYMMDD')) as �ѳ�¥�� from dual  

--8. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���.
select trunc( months_between (sysdate , to_date ( 19800101 , 'YYYYMMDD'))) as �Ѱ����� from dual 

--9. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�.
select ename, manager , nvl (manager, 0), nvl2 (manager, manager,0)
from employee; 

/*10.   �����ȣ,
      [�����ȣ 2�ڸ������ �������� *���� ] as "������ȣ", 
      �̸�, 
      [�̸��� ù�ڸ� ��� �� ���ڸ�, ���ڸ��� * ����] as "�����̸�"     
*/ 
select eno, rpad (substr (eno , 1 ,2) , length(eno), '*')  as ������ȣ ,  
ename, rpad ( substr (ename, 1,1), 4,'*')
from employee;

select eno, rpad (substr (eno , 1 ,2) , length(eno), '*')  as ������ȣ ,  
ename, rpad ( substr (ename, 1,1), length (ename),'*')
from employee;

select ename, length(ename)
from employee; 

11.  �ֹι�ȣ:   �� ����ϵ� 801210-1*******   ��� �ϵ��� , ��ȭ ��ȣ : 010-12*******
	dual ���̺� ���
select  RPAD (substr ('801210-1234578', 1,8) , length ('801210-1234578'), '*') as �ֹι�ȣ,
        RPAD ( substr ('010-1234-5678', 1,6), length ('010-1234-5678'), '*') as ��ȭ��ȣ
        from dual ;     
