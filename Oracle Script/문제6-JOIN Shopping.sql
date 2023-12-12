-- 데이터베이스 설계서 member20
create table member20 (
    id varchar2(20) not null constraint PK_member_id primary key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
    constraint FK_member_id_tb_zipcode Foreign key (zipcode) references tb_zipcode20 (zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
);
-- 데이터베이스 설계서 2 tb_zipcode
create table tb_zipcode20(
     zipcode varchar2(7)not null constraint PK_tb_zipcode_zipcode primary key,
     sido varchar2(30),
     gugum varchar2(30),
     dong varchar2(30),
     bungi varchar2(30)
    );

--데이터베이스 설계서3
create table products20(
          product_code varchar2(20)not null constraint PK_products_product_code primary key,
          product_name varchar2(100),
          product_kind char(1),
          product_price1 varchar2(10), 
          product_price2 varchar2(10),
          product_content varchar2(1000), 
          product_image varchar2(50), 
          sizeSt varchar2(5), 
          sizeEt varchar2(5), 
          product_quantity varchar2(5), 
          useyn char(1), 
          indate date 
         );

--데이터베이스 설계서4
create table orders20 (
    o_seq number(10) not null constraint PK_orders_o_seq primary key,
    product_code varchar2(20),
    constraint FK_orders_product_code_products foreign key (product_code) references products20 (product_code),
    id varchar2(16),
    constraint FK_orders_id_member foreign key (id) references member20 (id),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date
);

select *from member20;

insert into member20 (id, pwd, name, zipcode, address, tel, indate)
values('aaa', 'aaa', '홍길동', '11111', '서울', '010-1111-1111', '23/12/12');

insert into member20 (id, pwd, name, zipcode, address, tel, indate)
values('bbb', 'bbb', '김길동', '22222', '대전', '010-2222-1111', '23/12/13');
insert into member20 (id, pwd, name, zipcode, address, tel, indate)
values('ccc', 'ccc', '강길동', '33333', '대구', '010-3333-1111', '23/12/14');
insert into member20 (id, pwd, name, zipcode, address, tel, indate)
values('ddd', 'ddd', '이길동', '44444', '부산', '010-4444-1111', '23/12/15');
insert into member20 (id, pwd, name, zipcode, address, tel, indate)
values('eee', 'eee', '고길동', '55555', '인천', '010-5555-1111', '23/12/16');
commit;

select *from tb_zipcode20;
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values('11111', '서울', '강동구', '강일동', '1번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values('22222', '대전', '마포구', '강이동', '2번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values('33333', '대구', '강서구', '강삼동', '3번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values('44444', '부산', '서초구', '강사동', '4번지');
insert into tb_zipcode20 (zipcode, sido, gugum, dong, bungi)
values('55555', '인천', '강남구', '강오동', '5번지');
commit;

select *from products20;
insert into products20 ( product_code, product_name, product_kind, product_price1, product_price2, product_content,
product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('1', '사과', 'a', '2000', '3000', '홍옥' ,'사과사진', '100' ,'200', '50', 'y', '23/12/12');
insert into products20 ( product_code, product_name, product_kind, product_price1, product_price2, product_content,
product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('2', '딸기', 'b', '3000', '3500', '큰딸기' ,'딸기사진', '100' ,'200', '50', 'b', '23/12/10');
insert into products20 ( product_code, product_name, product_kind, product_price1, product_price2, product_content,
product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('3', '배', 'c', '4000', '5000', '먹골배' ,'배사진', '100' ,'200', '50', 'c', '23/12/01');
insert into products20 ( product_code, product_name, product_kind, product_price1, product_price2, product_content,
product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('4', '바나나', 'd', '5000', '7000', '청바나나' ,'바나나사진', '100' ,'200', '50', 'r', '23/12/06');
insert into products20 ( product_code, product_name, product_kind, product_price1, product_price2, product_content,
product_image, sizeSt, sizeEt, product_quantity, useyn, indate)
values ('5', '귤', 'e', '6000', '3000', '청귤' ,'귤사진', '100' ,'200', '50', 'n', '23/12/08');
commit;

select * from orders20;
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (10, '1', 'aaa', '100', '500', 'n', '17/12/12');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (20, '2', 'bbb', '20', '20', 'y', '19/1/11');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (30, '3', 'ccc', '670', '5200', 'y', '13/6/8');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (40, '4', 'ddd', '40', '54', 'y', '23/12/11');
insert into orders20 (o_seq, product_code, id, product_size, quantity, result, indate)
values (50, '5', 'eee', '190', '122', 'y', '22/3/2');
commit;

select * from member20; 
select * from orders20;
select * from tb_zipcode20;
select * from products20;

-- JOIN  orders20, member20, tb_zipcode20, products20 

select *
from orders20 o 
    join member20 m 
        on o.id = m.id 
    join tb_zipcode20 z
        on m.zipcode = z.zipcode
    join products20 p
        on o.product_code = p.product_code 
        

