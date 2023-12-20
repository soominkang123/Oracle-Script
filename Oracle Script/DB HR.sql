create table guestboard(
    name varchar2(200),
    email varchar2(200),
    subject varchar2(200),
    content varchar2(200)
    );
    
    select*from guestboard;
  --   
  insert into guestboard (name, email, subject, content) 
  values ('홍길동','aaa@aaa.com','제목입니다.','내용입니다.');
  commit;
  -- developer 에서는 반드시 : commit 해야함. 
  -- commit 하기전까지는 Lock이 걸려있다.
  
  insert into guestboard (name, email, subject, content)
  values ('김길동8','bbb@bbb.com8','제목8','내용8')
  
  rollback;
  
  
  create table mem (
    name varchar2(200), 
    age varchar2(200),
    weight varchar2(200),
    addr varchar2(200),
    phone  varchar2(200)
    )
  
 select * from mem; 
 
 select*from guestboard;