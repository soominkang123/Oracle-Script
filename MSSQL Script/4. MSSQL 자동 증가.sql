-- �÷��� ���� ���� ���� �� �ڵ����� �����Ǵ� �÷�: identity
-- identity �÷��� ���� ���� �ʴ´�.
-- �ʱⰪ: 1, ������: 1
-- ���� ����(int, bigint)
-- primary key

create table abc (
	a int not null identity primary key,
	b varchar(50),
	c varchar(50)
);

insert into abc
values ('����', 'add1');

select * from abc;