/*
     myDB2 데이타 베이스 생성
     member 테이블 생성
     레코드 2개 넣기
 */    
 
 -- 1. 데이터베이스 생성
 create database myDB2;
 
 -- 2. 해당 사용자 DataBase 에 접속 
 use myDB2;
 
 -- 3. 접속한 DB에서 테이블 생성
 create table member (
 idx int not null,
 name varchar(50) not null,
     addr varchar(50) not null
     );
     
     
   -- 4. 테이블의 내용을 출력 : select
   select * from member;
   
 -- 5. 생성된 테이블에 값넣기 (레코드) : 자동 커밋 <== commit; 명시하지 않아도 된다.
 insert into member ( idx, name , addr )
 values ( 1 , '허준', '대구'); 
 
 insert into member ( idx, name , addr ) 
values ( 2 , '이순신', '인천');  