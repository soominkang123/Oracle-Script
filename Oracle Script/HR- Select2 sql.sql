
/*
   Oracle�� �پ��� �Լ� ��� �ϱ� : ��ǲ == ���> ���
   1. ���ڸ� ó���ϴ� �Լ�
   2. ���ڸ� ó���ϴ� �Լ�
   3. ��¥�� ó���ϴ� �Լ�
   4. ��ȯ �Լ�
   5. �Ϲ� �Լ�
 */
 /*
  1. ���ڸ� ó���ϴ� �Լ� :
  - UPPER : �ҹ��ڸ� �빮�ڷ� ��ȯ���ִ� �Լ�.
  - LOWER : �ҹ��ڷ� ó���� �ִ� �Լ�
  - INITCAP : ù �ڸ� �빮�ڷ� ó���� �ִ� �Լ�
  - LENGTH : ���ڼ��� ��ȯ (����: 1byte, �ѱ� : 2byte, 3byte )
  - LENGTHB : ���ڼ� ��ȯ (����: 1byte, �ѱ� : 3byte)
  - CONCAT : ���ڿ��� �������ִ� �Լ�
  - SUBSTR : ���ڸ� �߶���� �Լ�
  - INSTR : Ư�� ������ ��ġ���� ���
  - LPAD : ���� �ڸ����� �Է� �޾Ƽ� �������� Ư�� ��ȣ�� ä��( ���� )
  - RPAD : ���� �ڸ����� �Է� �޾Ƽ� �������� Ư�� ��ȣ�� ä��( ������ )
  - RTRIM : �������� ���� ����
  - LTRIM : ������ ���� ����
    
  dual : ������ ���̺�
 */
 
 select UPPER('Oracle')from dual;
 
 select*from employee;
 
 select ename as �����̸�, UPPER(ename) �빮���̸�, LOWER(ename)�ҹ���,
 INITCAP(ename)ù�ڸ��빮�� from employee;
 
 -- �˻��� �ȵ� Į���� ���� ��ҹ��ڸ� ���� (��������)
 select*
 from employee
 where ename ='smith';
 
 --��µ�
 select*
 from employee
 where ename = UPPER('smith');
 ----------------------------------
 select LENGTH('Oracle mania') from dual;  -- 12 (������ ���� ��������)
 select LENGTH('����Ŭ �ŴϾ�') from dual;  --7
 
 select LENGTHB('Oracle mania') from dual;  -- 12 
 select LENGTHB('����Ŭ �ŴϾ�') from dual;  --19   //�ѱ� 1��: 3byte (UTF-8) 19���
 
 select ename ����, LENGTH(ename) ���ڼ� from employee;
 select ename ����, LENGTHB(ename) ���ڼ� from employee;
 
 -- CONTAT : ���ڿ��� ���ڿ��� ���� ���ִ� �Լ�
 -- || �÷��� ������ �ִ� ������.
 select 'Oracle Mania' , 'Mania' from dual; -- ������ִ� �������̺�
 
 select concat ('Oracle' , 'Mania') as ����� from dual;

 select concat (ename, job) from employee;
 
 select ename ||job from employee;
 
 select ename ||'  '||job as �̸�����å from employee;
 
 -- SUBSTR : ���ڸ� �߶���� �Լ�, substr(Į��,4,3) <== Į���� �ִ� ���ڿ���, 4��° �ڸ����� 3�ڸ� �߶�ͼ� ���
 
 select substr ('Oracle Mania', 4,3) from dual;  --index : 1������ ����
 
 select ename �����̸�, substr (ename, 2,3) from employee;

 select * from employee; 
 
 -- employee ���̺��� �̸�, �Ի���� ��� �ϼ���. substr �Լ��� ���
  select ename as �̸�, substr(hiredate, 4,2) �Ի�� from employee;
  
 -- employee ���̺��� �̸�, �Ի���� ��� �ϼ���. suwstr �Լ��� ��� -- 2���޿� �Ի��� ��� ���
  select ename as �̸�, substr(hiredate, 4,2) �Ի��
  from employee
  where substr(hiredate, 4,2) = '02';
  
 -- 81�⵵�� �Ի��� ����� �̸�, �Ի��, �Ի��, �Ի����� ����ϼ���. <== substr , where
  select ename �̸�, substr(hiredate,1,2) �Ի��, substr(hiredate,4,2)�Ի��, substr(hiredate,7,2)�Ի���
  from employee
  where substr(hiredate,1,2)='81';

 -- INSTR : Ư�� ������ index ��ȣ�� ���  // index ��ȣ�� 1����
   -- instr(Į����, 'A') : Į������ ���ڿ��߿� 'A' �� �ִ� index ��ȣ�� ���
   -- instr(Į����, 'A', 4) : index4�� ���� �������� A�� �� �ִ� index ��ȣ�� ���
   -- �˻� ���� ������ 0 ���� ���
 select (instr('Oracle Mania','a')) from dual;  -- 3  <== a�� ��ġ�� index // a��3��° ��ġ
 
 select (instr('Oracle Mania','a',4)) from dual; -- 9 <== index 4�� ���ĺ��� �˻�'a'�� ��ġ�� index �˻�
 
 select ename �̸�, instr(ename, 'M') as M����ġ
 from employee;
 
 --LPAD: LPAD(Į����, �ø��ڸ���, '*') : ���� �ڸ��� *�� ä�� (����)
 --RPAD: RPAD(Į����, �ø��ڸ���, '*') : ���� �ڸ��� *�� ä�� (������)
 
 select '770824-123456' �ֹι�ȣ, LPAD('770824-1', 20,'*')as "LPAD" from dual;
 
 select '770824-123456' �ֹι�ȣ, RPAD('770824-1', 20,'*')as "LPAD" from dual; 
 
 select*from employee;
 
 -- hiredate Į���� �⵵�� ����ϰ� �������� *�� ���.  <== Substr, read �� ����ؼ� ó��
 select ename �̸�, rpad(substr(hiredate,1,2), 8, '*') �Ի����� 
 from employee;
 
 --���� ó�� : RTRIM : �������� ������ ����, LTRIM: ������ ������ ����, TRIM : ����, ������ ������ ��� ����
 
 select '      Oracle Mania       ' as ����,
         LTRIM('      Oracle Mania       ') �����ǰ�������,
         RTRIM('      Oracle Mania       ') �������ǰ�������,
         TRIM('      Oracle Mania       ') ����������
         
 from dual;
 
 -- �յ� ���������� ���� �빮�ڷ� ��ȯ
 select *
 from employee
 where ename = UPPER (TRIM ('  SMITH  '));
 
 -- ��2. ���ڸ� ó���ϴ� �Լ� : ROUND : �ݿø� �ϴ� �Լ�, TRUNC : Ư���ڸ������� �߶󳻾����, MOD : ������ ���� ���
 
 -- ROUND : Ư�� �ڸ� ������ �ݿø�, 5�̻� �ݿø�, 5�̸��� �߶� ����.
 /*
   ROUND (�Ǽ�) : �Ҽ��� ���ڸ����� �ݿø�
   ROUND (�Ǽ�, �Ҽ����ڸ���) :
    �� -�Ҽ����ڸ�(���) : �Ҽ��� �������� ���������� �̵��ؼ� �� ���ڸ����� �ݿø��� <== ����
       -�Ҽ����ڸ�(����) : �Ҽ��� �������� �������� �̵��ؼ� �� ���ڸ����� �ݿø��� 
 */
 
select 98.7654 as����,
       round (98.7654) as R1,   -- �Ҽ��� �ڿ��� �ݿø�
       round (98.7654,2) as R2,  -- �Ҽ��� ���������� 2�ڸ� �̵��� �� �ڿ��� �ݿø� <== ���� ��
       round (98.7654,-1) as R3, -- �Ҽ��� �������� 1�ڸ� �̵��� �� �ڸ����� �ݿø�
       round (98.7654,-2) as R3,
       round (98.7654,-3) as R3
from dual; 

-- �ٷ� �ҵ漼 : ������ 3.3,    salary * 0.033 �ҵ漼

select salary ����, salary*0.033 �ҵ漼, Round ( salary*0.033)R1, Round((salary*0.033),2)R2,
       Round(salary -( salary *0.033),2)�Ǽ��ɾ�
from employee;

-- TRUNC : Ư�� �ڸ����� �߶� ����.   <== Ư�� ��¥�� ���� , ���� ��¥���� 100 ������ ��¥�� ���� �Դϱ�?
select trunc(98.7654) T1,
       trunc(98.7654,2) T2,
       trunc(98.7654,-1) T3,
       trunc(98.7654,-2) T4
from dual;   

-- MOD : ������ ���� ��� , MOD (����1, ����2)
-- TRUNC : �� �� ��� �Ҷ� 
select MOD (3,2),     -- ������
      TRUNC(31/2)     -- �� ���
from dual;