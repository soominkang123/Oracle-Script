/*
    CRUD : Create, Read, Update, Delete 
            (����), (�˻�), (����) (����)
*/ 

-- ������ ���̺� ���� 
Create Table member (
    idx number not null , 
    name varchar2(50) not null, 
    id varchar2(50) not null, 
    pw varchar2(50) not null, 
    addr varchar2(50) null
    ); 
-- �˻� : select 
select * from member ; 

-- �Է� : ���̺� ���� ����. 
insert into member ( idx, name, id , pw, addr) 
values (1 , 'ȫ�浿', 'pjw', '1234', '����') ; 
commit;    -- DB�� ������ �����϶� 

insert into member ( idx, name, id , pw, addr) 
values (2 , '��浿', 'pjw1', '1234', '�λ�') ; 
commit; 

-- C##HR3 ������ �����ϰ�, HR3 �������� ����,   member ���̺� ������ ���ڵ� 2�� �ֱ� 
