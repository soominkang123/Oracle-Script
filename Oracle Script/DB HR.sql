create table guestboard(
    name varchar2(200),
    email varchar2(200),
    subject varchar2(200),
    content varchar2(200)
    );
    
    select*from guestboard;
  --   
  insert into guestboard (name, email, subject, content) 
  values ('ȫ�浿','aaa@aaa.com','�����Դϴ�.','�����Դϴ�.');
  commit;
  -- developer ������ �ݵ�� : commit �ؾ���. 
  -- commit �ϱ��������� Lock�� �ɷ��ִ�.
  
  insert into guestboard (name, email, subject, content)
  values ('��浿8','bbb@bbb.com8','����8','����8')
  
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