/*
    JOIN 실습 
        member10 : 회원정보를 저장하는 테이블 
        zipcode10 : 우편번호를 저장하는 테이블 
        product10 : 제품 정보를 저장하는 테이블 
        order10 : 주문 정보를 저장하는 테이블 
*/
-- 테이블 삭제 : Foreign Key 가 참조하는 테이블은 삭제 되지 않는다. : cascade constraints
  -- 1. 참조하는 테이블을 먼저 삭제후 삭제해야 한다.
  -- 2. 테이블 삭제시 cascade constraints 옵션을 사용해서 강제 삭제

-- Member10 Table에서 참조 되는 테이블 이므로 삭제가 안된다.
drop table zipcode10;
-- Order10 테이블에서 참조되기 때문에 삭제 할 수 없다. 
drop table member10;

--select*from user_constraints where table_name = 'MEMBER10';
drop table order10; -- order member zip product 순서로 지워야 함
drop table product10;

-- 2.테이블 삭제시 cascade constraints 옵션을 사용해서 강제 삭제
   --zipcode10 테이블을 참조하는 테이블을 강제로테이블을 삭제함
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
        -- Foreign Key 제약 조건 추가함. : member10(zipcode)  ===> zipcode10(zipcode) 
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
        -- Foreign Key 2개 
        constraint FK_ORDER10_M_ID foreign key (m_id) references member10(m_id), 
        constraint FK_ORDER10_PRO_ID foreign key (pro_id) references product10(pro_id)   
);

-- 각 테이블에 레코드 5개씩 넣습니다. 

-- ANSI JOIN 문을 사용해서 주문정보(Order10)테이블을 기준으로 
     -- 주문자명, 주문자메일주소, 주문자번지(시도), 주문제품명, 제품의 가격을 출력 합니다.   , 
     --order10, member10, zipcode10, product10
     
desc zipcode10;

insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(10, '서울', '종로구', '관철동 100번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(20, '부산', '종로구', '관철동 100번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(30, '대구', '종로구', '관철동 100번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(40, '광주', '종로구', '관철동 100번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(50, '인천', '종로구', '관철동 100번지');

-- Member10 Table에는 참조 되지 않지만 zipcode10 테이블에는 존재함. <== RIGHT OUTER JOIN
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(60, '강릉', '종로구', '관철동 100번지');
insert into zipcode10 (zipcode, si_do, gu_gun, bungi)
values(70, '울진', '종로구', '관철동 100번지');

commit;

select * from zipcode10;

--member10 테이블에 레코드 5개 입력
desc member10;

insert into member10 (m_id, pass, name, email, zipcode)
values(1, '1234','홍길동', 'aaa@aaa.com',10);
insert into member10 (m_id, pass, name, email, zipcode)
values(2, '1234','김길동', 'bbb@aaa.com',20); 
insert into member10 (m_id, pass, name, email, zipcode)
values(3, '1234','박길동', 'ccc@aaa.com',30); 
insert into member10 (m_id, pass, name, email, zipcode)
values(4, '1234','옥길동', 'ddd@aaa.com',40); 
insert into member10 (m_id, pass, name, email, zipcode)
values(5, '1234','최길동', 'eee@aaa.com',50); 

--member10 테이블에는 존재하지만 주문정보에는 없는회원 <== LEFT OUTER JOIN
insert into member10 (m_id, pass, name, email, zipcode)
values(6, '1234','심길동', 'fff@aaa.com',40); 
insert into member10 (m_id, pass, name, email, zipcode)
values(7, '1234','이길동', 'hhh@aaa.com',50);

commit;

-- delete 
delete zipcode10 
where zipcode in ( 7977, 7978, 7979,7980,7981); 
commit ; 



select*from member10;

-- product10 테이블에 값넣기
desc product10;

insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(100,'사과',25000,100);
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(200,'딸기',30000,100);
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(300,'배',35000,100);
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(400,'바나나',40000,100);
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(500,'귤',45000,100);

-- 주문정보에는 없는 제품(주문되지 않는 제품) , <== RIGHT OUTER JOIN
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(600,'망고', 35000,100); 
insert into product10(pro_id,pro_name,pro_price,pro_cnt)
values(700,'대추',5000,100); 

commit;

select*from product10;

-- order10 테이블의 값을 입력
desc oders10;

insert into order10( ord_id, m_id, pro_id)
values(1000,1,500);  -- 홍길동, 귤, 서울
insert into order10( ord_id, m_id, pro_id)
values(2000,2,400);  -- 김길동, 바나나, 부산
insert into order10( ord_id, m_id, pro_id)
values(3000,3,300);  -- 박길동, 배, 대구
insert into order10( ord_id, m_id, pro_id)
values(4000,4,200);  -- 옥길동, 딸기, 광주
insert into order10( ord_id, m_id, pro_id)
values(5000,5,100);  -- 최길동, 사과, 인천

commit;


     -- 주문자명, 주문자메일주소, 주문자번지(시도), 주문제품명, 제품의 가격을 출력 합니다.   , 
     --order10, member10, zipcode10, product10
   select name,email,si_do,pro_name,pro_price
   from order10 o 
    JOIN member10 m
    on o.m_id = m.m_id
   JOIN product10 p
    on o.pro_id = p.pro_id
   JOIN zipcode10 z
    on m.zipcode = z.zipcode
    
-- 모델링 되지 않는 주문 테이블 <== order11 
create table order11 (
   o_id number(6)not null primary key,
   m_name varchar2(200)not null,      -- 주문자 이름
   m_phone varchar2(200)not null,     -- 주문자 핸드폰 번호
   m_add varchar2(200)not null,        -- 주문자의 배송주소
   m_email varchar2(200)null,         -- 주문자의 메일주소
   
  p_id number(6)not null,            -- 제품 번호
  p_name varchar2(200) not null,     -- 제품 이름
  p_price number(7,2) not null,      -- 제품 가격
  p_cnt number(6)null                -- 제품 수량
  )
  
  insert into order11(o_id,m_name,m_phone,m_add,m_email,p_id,p_name,p_price,p_cnt)
  values(10, '홍길동','010-1111-1111','서울','aaa@aaa.com',100,'사과',25000,100);
   insert into order11(o_id,m_name,m_phone,m_add,m_email,p_id,p_name,p_price,p_cnt)
  values(20, '김길동','010-2222-1111','부산','bbb@aaa.com',100,'배',25000,100);
  
  commit;
  
  select*from order11;
 
 -- JOIN : ANSI JOIN ,
   -- INNER JOIN : on 절에 공통의 값만 출력 한다.
   -- LEFT OUTER JOIN : 왼쪽 테이블의 모든 내용 출력
   -- RIGHT OUTER JOIN : 오른쪽 테이블의 모든 내용 출력
   
-- member10(다) , zipcode(1) 테이블:
select*
from member10 m
JOIN zipcode10 z
ON m.zipcode = z.zipcode;

-- member10 에는 on 절에 매칭 되지 않더라도 오른쪽 테이블의 모든 값을 출력 : RIGHT OUTER JOIN

select*
from member10 m
RIGHT OUTER JOIN zipcode10 z
ON m.zipcode = z.zipcode;

-- 주문 테이블 ( order10 ), 주문자 정보( member10 ) <== on m_id
select*from order10;

select*
from order10 o
JOIN member10 m
ON o.m_id = m.m_id;

--주문 정보에 없는 사용자 출력 (주문하지 않는 사용자) : RIGHT OUTER JOIN
select*
from order10 o
RIGHT OUTER JOIN member10 m
ON o.m_id = m.m_id;

select*
from member10 m
LEFT OUTER JOIN order10 o
ON m.m_id = o.m_id;

-- 3개 테이블 조인 : Order10, member10, zipcode10 

select*
from order10 o
JOIN member10 m
ON o.m_id = m.m_id
join zipcode10 z
ON m.zipcode = z.zipcode;


-- 4개 테이블 조인 : order10, member10, zipcode10, product10
-- INNER 조인
select*
from order10 o
JOIN member10 m
ON o.m_id = m.m_id
JOIN zipcode10 z
ON m.zipcode = z.zipcode
JOIN product10 p
ON o.pro_id = p.pro_id;

-- 주문하지 않는 사용자 정보도 출력, 판매되지 않는 제품도 OUTER JOIN 을 사용해서 출력
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