
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
select eno, ename, salary, ename, ename, salary*12
from employee;

-- 컬럼 이름을 별칭으로 바꾸고 출력 하기
select eno as"사원 번호", ename 사원명, salary as 월급, salary*12 as 연봉
from employee;

-- employee 테이블의 각 칼럼의 의미 
select*
from employee;

select eno 사원번호, ename 사원명, job 직책, manager 직속상관,
     hiredate 입사날짜,salary 월급,commission 보너스,dno 부서번호
from employee; 

-- 테이블 구조를 확인 하기 .desc테이블명, 실제 컬럼명, null 허용여부, 자료형(number: 정수, 실수, char, varchar2 : 문자열)
desc employee;  -- insert 시 컬럼의 자료형, NULL 허용여부를 확인후 값을 넣음

select*from employee;

--연봉을 계산 : 주의 : NuLL과의 연산은 결과가 NULL

select eno 사원번호, ename 사원명, salary 월급, commission 보너스
from employee;

-- 연봉 = 월급 * 12 + 보너스
    -- null 컬럼과 연산을 하면 모두 null

-- null 처리가 안됨
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,  --원본 레이블 출력
     salary* 12 + commission 연봉
from employee;

-- nvl (컬럼명,0) : null 을 처리하는 함수. null을 처리하는 함수, 컬럼의 값 중 null을 0으로 변환하는 함수

select eno 사원번호, ename 사원명, salary 월급, commission 보너스,  --원본 레이블 출력
    nvl(commission,0) 널처리됨, salary* 12 + nvl(commission,0) 연봉
from employee;

--컬럼과 컬럼을 연산 할 수 있다. : + , -, *, / <== number (정수,실수)타입
-- number : 정수
-- number(7,2) : 실수.   전체 7자리,소숫점이하2자리

select*from employee;
desc employee;

select ename, salary, salary + salary as "+연산" , salary * salary as"*연산", salary * 0.1 as"월급의10%"
from employee;

