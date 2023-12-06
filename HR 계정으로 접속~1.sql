
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

-- 중복처리후 출력 : distinct 컬럼명 , 컬럼명의 중복을 제거후 출력

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
