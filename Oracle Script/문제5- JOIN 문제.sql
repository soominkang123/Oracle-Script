/*
    JOIN �ǽ� 
        member10 : ȸ�������� �����ϴ� ���̺� 
        zipcode10 : �����ȣ�� �����ϴ� ���̺� 
        product10 : ��ǰ ������ �����ϴ� ���̺� 
        order10 : �ֹ� ������ �����ϴ� ���̺� 
*/

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

commit;

select * from zipcode10;

--member10 ���̺� ���ڵ� 5�� �Է�
desc member10;

select *
from zipcode10;

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

commit;

-- delete 
delete zipcode10 
where zipcode in ( 7977, 7978, 7979,7980,7981); 
commit ; 



select*from member10;

-- product10 ���̺� ���ֱ�
desc product10;

insert into product10(pro_id,pro name,pro_price,pro_cnt)
values(100,'���',25000,100);

insert into product10(pro_id,pro name,pro_price,pro_cnt)
values(200,'����',30000,100);
insert into product10(pro_id,pro name,pro_price,pro_cnt)
values(300,'��',35000,100);
insert into product10(pro_id,pro name,pro_price,pro_cnt)
values(400,'�ٳ���',40000,100);
insert into product10(pro_id,pro name,pro_price,pro_cnt)
values(500,'��',45000,100);

commit;

select*from product10;

-- order10 ���̺��� ���� �Է�
desc oders10;

insert into order10( ord_id, m_id, pro_id)
values(1000,1,500,);  -- ȫ�浿, ��, ����
insert into order10( ord_id, m_id, pro_id)
values(2000,2,400,);  -- ��浿, �ٳ���, �λ�
insert into order10( ord_id, m_id, pro_id)
values(3000,3,300,);  -- �ڱ浿, ��, �뱸
insert into order10( ord_id, m_id, pro_id)
values(4000,4,200,);  -- ���浿, ����, ����
insert into order10( ord_id, m_id, pro_id)
values(5000,5,100,);  -- �ֱ浿, ���, ��õ

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
    