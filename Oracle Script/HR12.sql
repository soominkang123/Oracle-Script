-- MVC �� ���ߵ� ���̺�

create table board (
  seq number(5)not null primary key,
  title varchar2(200) not null,
  write varchar2(20) null,
  content varchar2(2000) null,
  regdate date default sysdate null,
  cnt number(5) default 0 null
  );
  select *from board;
  
  create table users (
  id varchar2(8)not null primary key,
  password varchar2(8) null,
  name varchar2(20), 
  role varchar2(5) 
  );
  
  create table products(
  p_code number(5) not null primary key,
  p_name varchar2(200) null,
  P_kind char(1) null,
  p_price varchar2(10) null,
  p_content varchar2(2000) null,
  p_quantity varchar2(5),
  indate date default sysdate null
  );
  
  -- ���� ������ �Է� :
  insert into board 
  values ( 1, 'MVC M2 �Խ��� ����' , 'admin' , 'MVC M2 �Խ��� ����' , default, 0 ); 
  insert into board 
  values ( 2, 'MVC M2 �Խ��� ����2' , 'user' , 'MVC M2 �Խ��� ����2' , default, 0 ) ; 

  commit; 
  select * from board; 

  insert into users
  values ( 'admin' , '1234', '������', 'Admin'); 
  insert into users
  values ( 'user' , '1234', '�����', 'Users'); 
  commit; 

  select * from users; 

  drop table users; 


