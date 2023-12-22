-- MVC 로 개발될 테이블

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
  
  -- 더미 데이터 입력 :
  insert into board 
  values ( 1, 'MVC M2 게시판 제목' , 'admin' , 'MVC M2 게시판 내용' , default, 0 ); 
  insert into board 
  values ( 2, 'MVC M2 게시판 제목2' , 'user' , 'MVC M2 게시판 내용2' , default, 0 ) ; 

  commit; 
  select * from board; 

  insert into users
  values ( 'admin' , '1234', '관리자', 'Admin'); 
  insert into users
  values ( 'user' , '1234', '사용자', 'Users'); 
  commit; 

  select * from users; 

  drop table users; 


