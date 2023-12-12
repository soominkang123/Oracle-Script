/*
    JOIN �ǽ� 
        member10 : ȸ�������� �����ϴ� ���̺� 
        zipcode10 : �����ȣ�� �����ϴ� ���̺� 
        product10 : ��ǰ ������ �����ϴ� ���̺� 
        order10 : �ֹ� ������ �����ϴ� ���̺� 
*/
-- ���̺� ���� : Foreign Key �� �����ϴ� ���̺��� ���� ���� �ʴ´�. : cascade constraints
  -- 1. �����ϴ� ���̺��� ���� ������ �����ؾ� �Ѵ�.
  -- 2. ���̺� ������ cascade constraints �ɼ��� ����ؼ� ���� ����

-- Member10 Table���� ���� �Ǵ� ���̺� �̹Ƿ� ������ �ȵȴ�.
drop table zipcode10;
-- Order10 ���̺��� �����Ǳ� ������ ���� �� �� ����. 
drop table member10;

--select*from user_constraints where table_name = 'MEMBER10';
drop table order10; -- order member zip product ������ ������ ��
drop table product10;

-- 2.���̺� ������ cascade constraints �ɼ��� ����ؼ� ���� ����
   --zipcode10 ���̺��� �����ϴ� ���̺��� ���������̺��� ������
drop table zipcode10 cascade constraints;
drop table member10 cascade constraints;
drop table order10 cascade constraints;
drop table product10 cascade constraints;

create table zipcode10 (
        zipcode number(6) not null constraint PK_ZIPCODE10_ZIPCODE Primary key, 
        si_do varchar2(200) not null, 
        gu_gun varchar2(200) not null, 
        bungi varchar2(200) not null
) ; 

create table member10 (
        m_id number(4) not null constraint PK_MEMBER10_M_ID primary key, 
        pass varchar2(200) not null , 
        name varchar2(200) not null, 
        email varchar2(200) not null , 
        zipcode number(6) null , 
        -- Foreign Key ���� ���� �߰���. : member10(zipcode)  ===> zipcode10(zipcode) 
            constraint FK_MEMBER10_ZIPCODE foreign key (zipcode) references ZIPCODE10(zipcode) 
); 

create table product10 (
        pro_id number(6) not null constraint PK_PRODUCT10_PRO_ID primary key , 
        pro_name varchar2(200) not null, 
        pro_price number(7,2) not null , 
        pro_cnt number(4) default 0 not null 
);

create table order10 (
    ord_id number(6) not null constraint PK_ORDER10_ORD_ID primary key, 
    m_id  number(4) not null,      -- FK  : MEMBER10(m_id)
    pro_id number(6) not null,    -- FK  : PRODUCT10 (pro_id) 
        -- Foreign Key 2�� 
        constraint FK_ORDER10_M_ID foreign key (m_id) references member10(m_id), 
        constraint FK_ORDER10_PRO_ID foreign key (pro_id) references product10(pro_id)   
);

-- �� ���̺� ���ڵ� 5���� �ֽ��ϴ�. 

-- ANSI JOIN ���� ����ؼ� �ֹ�����(Order10)���̺��� �������� 
     -- �ֹ��ڸ�, �ֹ��ڸ����ּ�, �ֹ��ڹ���(�õ�), �ֹ���ǰ��, ��ǰ�� ������ ��� �մϴ�.   , 
     --order10, member10, zipcode10, product10
     
desc zipcode10;

insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(10, '����', '���α�', '��ö�� 100����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(20, '�λ�', '���α�', '��ö�� 100����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(30, '�뱸', '���α�', '��ö�� 100����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(40, '����', '���α�', '��ö�� 100����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(50, '��õ', '���α�', '��ö�� 100����');

-- Member10 Table���� ���� ���� ������ zipcode10 ���̺��� ������. <== RIGHT OUTER JOIN
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(60, '����', '���α�', '��ö�� 100����');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(70, '����', '���α�', '��ö�� 100����');

commit;

select * from zipcode10;

--member10 ���̺� ���ڵ� 5�� �Է�
desc member10;

insert into member10 (m_id, pass, name, email, zipcode)
values(1, '1234','ȫ�浿', 'aaa@aaa.com',10);
insert into member10 (m_id, pass, name, email, zipcode)
values(2, '1234','��浿', 'bbb@aaa.com',20); 
insert into member10 (m_id, pass, name, email, zipcode)
values(3, '1234','�ڱ浿', 'ccc@aaa.com',30); 
insert into member10 (m_id, pass, name, email, zipcode)
values(4, '1234','���浿', 'ddd@aaa.com',40); 
insert into member10 (m_id, pass, name, email, zipcode)
values(5, '1234','�ֱ浿', 'eee@aaa.com',50); 

--member10 ���̺��� ���������� �ֹ��������� ����ȸ�� <== LEFT OUTER JOIN
insert into member10 (m_id, pass, name, email, zipcode)
values(6, '1234','�ɱ浿', 'fff@aaa.com',40); 
insert into member10 (m_id, pass, name, email, zipcode)
values(7, '1234','�̱浿', 'hhh@aaa.com',50);

commit;

-- delete 
delete zipcode10 
where zipcode in ( 7977, 7978, 7979,7980,7981); 
commit ; 



select*from member10;

-- product10 ���̺� ���ֱ�
desc product10;

insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(100,'���',25000,100);
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(200,'����',30000,100);
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(300,'��',35000,100);
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(400,'�ٳ���',40000,100);
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(500,'��',45000,100);

-- �ֹ��������� ���� ��ǰ(�ֹ����� �ʴ� ��ǰ) , <== RIGHT OUTER JOIN
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(600,'����', 35000,100); 
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(700,'����',5000,100); 

commit;

select*from product10;

-- order10 ���̺��� ���� �Է�
desc oders10;

insert into order10( ord_id, m_id, pro_id)
values(1000,1,500);  -- ȫ�浿, ��, ����
insert into order10( ord_id, m_id, pro_id)
values(2000,2,400);  -- ��浿, �ٳ���, �λ�
insert into order10( ord_id, m_id, pro_id)
values(3000,3,300);  -- �ڱ浿, ��, �뱸
insert into order10( ord_id, m_id, pro_id)
values(4000,4,200);  -- ���浿, ����, ����
insert into order10( ord_id, m_id, pro_id)
values(5000,5,100);  -- �ֱ浿, ���, ��õ

commit;


     -- �ֹ��ڸ�, �ֹ��ڸ����ּ�, �ֹ��ڹ���(�õ�), �ֹ���ǰ��, ��ǰ�� ������ ��� �մϴ�.   , 
     --order10, member10, zipcode10, product10
   select name,email,si_do,pro_name,pro_price
   from order10 o 
    JOIN member10 m
    on o.m_id = m.m_id
   JOIN product10 p
    on o.pro_id = p.pro_id
   JOIN zipcode10 z
    on m.zipcode = z.zipcode
    
-- �𵨸� ���� �ʴ� �ֹ� ���̺� <== order11 
create table order11 (
   o_id number(6)not null primary key,
   m_name varchar2(200)not null,      -- �ֹ��� �̸�
   m_phone varchar2(200)not null,     -- �ֹ��� �ڵ��� ��ȣ
   m_add varchar2(200)not null,        -- �ֹ����� ����ּ�
   m_email varchar2(200)null,         -- �ֹ����� �����ּ�
   
  p_id number(6)not null,            -- ��ǰ ��ȣ
  p_name varchar2(200) not null,     -- ��ǰ �̸�
  p_price number(7,2) not null,      -- ��ǰ ����
  p_cnt number(6)null                -- ��ǰ ����
  )
  
  insert into order11(o_id,m_name,m_phone,m_add,m_email,p_id,p_name,p_price,p_cnt)
  values(10, 'ȫ�浿','010-1111-1111','����','aaa@aaa.com',100,'���',25000,100);
   insert into order11(o_id,m_name,m_phone,m_add,m_email,p_id,p_name,p_price,p_cnt)
  values(20, '��浿','010-2222-1111','�λ�','bbb@aaa.com',100,'��',25000,100);
  
  commit;
  
  select*from order11;
 
 -- JOIN : ANSI JOIN ,
   -- INNER JOIN : on ���� ������ ���� ��� �Ѵ�.
   -- LEFT OUTER JOIN : ���� ���̺��� ��� ���� ���
   -- RIGHT OUTER JOIN : ������ ���̺��� ��� ���� ���
   
-- member10(��) , zipcode(1) ���̺�:
select*
from member10 m
JOIN zipcode10 z
ON m.zipcode = z.zipcode;

-- member10 ���� on ���� ��Ī ���� �ʴ��� ������ ���̺��� ��� ���� ��� : RIGHT OUTER JOIN

select*
from member10 m
RIGHT OUTER JOIN zipcode10 z
ON m.zipcode = z.zipcode;

-- �ֹ� ���̺� ( order10 ), �ֹ��� ����( member10 ) <== on m_id
select*from order10;

select*
from order10 o
JOIN member10 m
ON o.m_id = m.m_id;

--�ֹ� ������ ���� ����� ��� (�ֹ����� �ʴ� �����) : RIGHT OUTER JOIN
select*
from order10 o
RIGHT OUTER JOIN member10 m
ON o.m_id = m.m_id;

select*
from member10 m
LEFT OUTER JOIN order10 o
ON m.m_id = o.m_id;

-- 3�� ���̺� ���� : Order10, member10, zipcode10 

select*
from order10 o
JOIN member10 m
ON o.m_id = m.m_id
join zipcode10 z
ON m.zipcode = z.zipcode;


-- 4�� ���̺� ���� : order10, member10, zipcode10, product10
-- INNER ����
select*
from order10 o
JOIN member10 m
ON o.m_id = m.m_id
JOIN zipcode10 z
ON m.zipcode = z.zipcode
JOIN product10 p
ON o.pro_id = p.pro_id;

-- �ֹ����� �ʴ� ����� ������ ���, �Ǹŵ��� �ʴ� ��ǰ�� OUTER JOIN �� ����ؼ� ���
select*  
from order10 o
JOIN member10 m  
ON o.m_id = m.m_id
JOIN zipcode10 z
ON m.zipcode = z.zipcode
RIGHT OUTER JOIN product10 p 
ON o.pro_id = p.pro_id;

-- Left OUTER JOIN
select*  
from member10 m
 LEFT OUTER JOIN order10 o
 ON o.m_id = m.m_id
 JOIN zipcode10 z
  ON m.zipcode = z.zipcode
 LEFT OUTER JOIN product10 p 
  ON o.pro_id = p.pro_id;