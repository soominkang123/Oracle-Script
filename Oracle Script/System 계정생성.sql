
/*
  Select : 테이블의 값을 검색 
  
  Select 컬럼명 from 테이블명 [뷰명]
  
  Select * from employee;
*/

-- employee 테이블의 모든 컬럼을 출력하기

select * from employee;

SELECT*
from employee;

-- 특정 컬럼만 출력 하기
select eno,ename,job
from employee;

-- 특정 컬럼을 여러번 출력 하기 , 컬럼에 연산을 할 수 있다. 컬럼이름이 바뀔 수 있다.
select eno,ename,salary,ename,ename,salary * 12
from employee;

-- 컬럼 이름을 별칭으로 바꾸고 출력 하기
select eno as "사원 번호",ename 사원명,salary 월급, salary*12 as연봉
from employee;

-- employee 테이블의 각 칼럼의 의미 
select *
from employee;

select eno 사원번호, ename 사원명, job 직책, manager 직속상관,
     hiredate 입사날짜,salary월급,commission보너스,dno부서번호
from employee;     