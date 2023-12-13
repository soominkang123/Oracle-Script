create table sale30(
     sale_date date not null constraint PK_SALE30_SALE_DATE primary key,
     wine_code varchar2(6)not null, 
     constraint FK_SALE30_WINE_CODE foreign key(wine_code)references wine30(wine_code),
     mem_id varchar2(30)not null,
     constraint FK_SALE30_MEM_ID foreign key(mem_id)references member30(mem_id),
     sale_amount varchar2(6) default 0,
     sale_price varchar2(6) default 0,
     sale_tot_price varchar2(15) default 0
);
 
create table member30(
      mem_id varchar2(6)
      not null constraint PK_MEMBER30_MEM_ID primary key,
      mem_grade varchar2(20),
      constraint FK_MEMBER30_MEM_GRADE foreign key(mem_grade)references grade_pt_rade30(mem_grade), 
      mem_pw varchar2(20) not null,
      mem_birth date default sysdate,
      mem_tel varchar2(20),
      mem_pt varchar2(10) default 0
);


drop table grade_pt_rade30;
create table grade_pt_rade30(
       mem_grade varchar2(20)not null constraint PK_grade_pt_rade30_MEM_GRADE primary key,
       grade_pt_rate number(3,2)
);
select*from WINE_DB;

create table today30(
    today_code varchar2(6)not null constraint PK_TODAY30_TODAY_CODE primary key,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
);

create table nation30(
   nation_code varchar2(26)not null constraint PK_NATION30_NATION_CODE primary key,
   nation_name varchar2(50) not null
);

create table wine30(
   wine_code varchar2(26) not null constraint PK_WINE30_WINE_CODE primary key,
   wine_name varchar2(100) not null,
   wine_url blob,
   nation_code varchar2(6),
   constraint FK_WINE30_NATION_CODE foreign key(nation_code)references nation30(nation_code),
   wine_type_code varchar2(6),
   constraint FK_WINE30_WINE_TYPE_CODE foreign key (wine_type_code) references wine_type30 (wine_type_code), 
   wine_sugar_code number(2),
   wine_price number(15)default 0,
   wine_vintage date, 
   theme_code varchar2(6),constraint FK_WINE30_THEME_CODE foreign key(theme_code)references theme30(theme_code),
   today_code varchar2(6),constraint FK_WINE30_TODAY_CODE foreign key(today_code)references today30(today_code)
);

create table theme30 (
    theme_code varchar2(6) not null constraint PK_THEME30_THEME_CODE primary key,
    theme_name varchar2(50) not null
);

create table stock_mamagement30(
    stock_code varchar2(6) not null constraint PK_STOCK_MAMAGEMENT30_STOCK_CODE primary key,
    wine_code varchar2(6),
     constraint FK_STOCK_MANAGEMENT30_WINE_CODE foreign key (wine_code) references wine30(wine_code),
    manager_id varchar2(30),
    constraint FK_STOCK_MANAGEMENT30_MANAGER_ID foreign key(manager_id)references manager30(manager_id),
    ware_date date default sysdate,
    stock_amount number(5) default 0
);
create table manager30(
  manager_id varchar2(30) not null constraint PK_MANAGER_MANAGER30_MANAGER_CODE primary key,
  manager_pwd varchar2(20) not null,
  manager_tel varchar2(20)
  );

create table wine_type30(
    wine_type_code varchar2(6) not null constraint PK_WINE_TYPE30_WINE_TYPE_CODE primary key,
    wine_type_name varchar2(50)
);