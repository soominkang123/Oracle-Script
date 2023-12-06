
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
     hiredate 입사날짜,salary 월급,commission 보너스,dno 부서번호
from employee; 

-- 테이블 구조를 확인 하기 , desc 테이블명 ,  실제 컬럼명, null 허용여부, 자료형(number : 정수, 실수 , char, varchar2  : 문자열)
desc employee;      -- insert 시 컬럼의 자료형, NULL 허용 여부를 확인후  값을 넣음.

select * from employee;

-- 우리회사의 부서만 출력
select distinct dno
from employee;

-- 우리 회사의 직책만 중복제거후 출력 ( CLERK : 사무원, SALESMAN: 영업사원, MANAGER : 관리자, ANALYST : 분석가
  -- PRESIDENT : 사장)
  -- 대소문자 구분 하지 않음 : 쿼리 ( select, create, from, group by, order by ), 컬럼명, 테이블명
  -- 테이블 안의 레코드의 값은 대소문자를 구분함.
  
select distinct job
from employee;

select * from employee;

--JOB(직책) 이 MANAGER (관리자) 인 사용자 정보만 출력

select ename 사원명,job 직책
from employee
where job = 'MANAGER';

-- 부서 테이블 확인 : department

select * from department ;

select dno 부서번호, dname 부서명, loc 부서위치
from department;

-- salgtade : 연봉의 순위를 적용하는 테이블  <== JOIN
select * from salgrade;

select grade 연봉의등급,losal 제일낮은연봉,hisal 제일높은연봉
from salgrade;

-- SELECT 문의 전체 내용, SQL : 구조화된 질의 언어
/*
SELECT 컬럼명
FROM 테이블명[뷰명]
WHERE 조건
GROUP BY 그룹핑처리할컬럼명 <== 컬럼에 동일한 값을 그룹핑해서 처리함.
HAVING 조건              <== GROUP BY 결과에 대한 조건
ODER BY 컬럼명 ASC[DESC]  <=== 컬럼을 정렬해서 출력, ASC: 내림차순정렬, DESC: 오름차순 정렬     
*/

--where 조건 사용하기 : 비교 연산자(NUMBER 타입의 칼럼에서 사용); = : 같다. > , < , >= , <=
   -- 같지 않다 : <>  , != , ^=
   -- or           -- in (값, 값, 값)
   -- and
   -- between
   -- in (   )
select*from employee;

select*
from employee
where salary > 1500;

select*
from employee
where salary = 1500;

select*
from employee
where salary <> 1500;

--or 연산자
select*
from employee
where salary = 1500 or salary = 800 or salary = 1600;

--in키워드 : in (값, 값, 값)
select*
from employee
where salary in(1500,800,1600); 

-- and 연산자 사용 : 부서번호가 10번인 사원의 연봉이 1500 이상인 사용자를 출력
select*
from employee
where dno = 10 and salary > 1500;

-- 직책이 manager 이면서 월급이 2000이상인 사원의 사원번호, 사원명, 월급을 출력
select eno 사원번호, ename 사원명 , salary 월급, job 직책
from employee
where job = 'MANAGER' and salary > 2000 ;

-- 비교 연산자를 date, varchar, char : 81년도 입사한 사원을 모두 출력
select *
from employee
where hiredate> '81/01/01' and hiredate < '81/02/28';

-- 문자열 : char, varchar, nvarchar, nchar : 문자열,''
  --
select*
from employee
where ename < 'D';

-- like in : 문자열에서 특정 값만 검색 : % : 모든것이 와도 상관없다. _: 한글자가 어떤것이 와도 상관없다.
-- 칼럼의 특정 값을 검색시 사용됨.
select * from employee
where ename like '%LA%';

select*from employee
where ename like '_CO%';

--NULL 검색 : is null, is not null
select * from employee;

-- commission 칼럼의 값이 null 인 사용자만 출력 : 보너스가 있는 사원
select * from employee
where commission is null;

-- commission 칼럼의 값이 null 인 사용자만 출력 : 보너스가 있는 사원
select * from employee
where commission is null;

-- count(): 레코드의 갯수를 출력: 페이징 처리, <==
  --null은 카운트 하지 않는다.

select count(*) 총레코드수
from employee;

select count (ename)
from employee;

select count(commission) --레코드 수 : null 컬럼은 출력 하지 않는다.
from employee;

select commission 수능점수   --null : 비어있는 상태, 0 점
from employee;

desc employee;

-- 테이블의 전체 레코드를 정확하게 출력: not null 컬럼을 count(컬럼명), count(*)

-- 특정 컬럼을 정렬해서 출력 : order by 컬럼명 ASC[DESC], select 절에서 제일 마지막에 와야 함.
 -- ASC : 내림 차순 정렬 : A =====> Z , 가 ===> 하 , 1 ==> 9 
 -- DESC : 오름 차순 정렬 : Z=====> A,  하 ===> 가,  9 ==> 1
 
 -- 월급(salary) 칼럼을 오름차순 정렬
 select*
 from employee
 order by salary asc;  -- asc는 생략 할 수 있다.
 
  -- 월급(salary) 칼럼을 내림차순 정렬
 select*
 from employee
 order by salary desc;
 
 --이름(ename) 칼럼을 오름 차순 정렬
 select*
 from employee
 order by ename;
 
 -- 직책(job) 칼럼을 내림 차순 정렬
 select*
 from employee
 order by job desc;
 
 -- 정렬할 칼럼을 where 와 같이 사용할때 order by는 where 절 다음에 처리
 select*
 from employee
 where salary>1500
 order by salary desc;
 --where salary>1500; //from 다음에 where가 와야된다.
 
 -- ★order by에서 여러 컬럼을 정렬 할때, 앞의 컬럼을 모두 정렬하고, 같은값이 존재할때 같은 값에 대해서 뒤의 칼럼을 정렬
  -- 답변형 게시판 만들때 사용됨....
  
 select dno, ename
 from employee
 order by dno asc, ename desc;
 
 -- job : 오름 차순 정렬, dno : job 의 동일한 값에 대해서 dno를 오름차순, 
   -- ename : dno에서 동일한 값에 대해서 ename을 오름차순 정렬
 select job, dno, ename
 from employee
 order by job asc, dno asc, ename asc;
 
 select job, dno, ename
 from employee
 order by dno desc, job asc, ename desc;
 
 