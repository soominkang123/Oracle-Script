
/* 그룹 함수 : gooup by, having

select 칼럼명
from테이블[뷰]
whter 조건
group by 칼럼명[동일한값을그룹핑]
having 조건 [group by 한 결과 값의 조건]
order by 칼럼명 asc[desc]

*/

/* 집계 함수 : number 타입의 칼럼에 적용  <=== NULL 을 자동으로 처리됨...
   SUM - 칼럼의 모든 값의 합
   AVG - 칼럼의 모든 값의 합
   MAX - 칼럼의 최대값
   MIN - 칼럼의 최소값
   COUNT (*) - 그룹핑 된 레코드 수 출력,
   
   주의 : 단일 행으로 출력이 되기 때문에 다른 칼럼과 사용시 오류.
       단, group by 절에 grouping 된 칼럼은 출력 가능
       
*/
desc employee;

-- 칼럼에 함수 사용: 주의
-- 월급(salary)
select SUM(salary)합계, ROUND (AVG(salary),2)평균, MAX(salary)최대값, Min(salary),count(*)계산된레코드수
from employee;

-- 집계 함수는 NULL을 자동으로 처리함.
select commission
from employee;

-- 보너스(commission) <== null은 자동으로 처리됨
select SUM(commission)합계, ROUND (AVG(commission),2)평균, MAX(commission)최대값, 
       Min(commission),count(*)계산된레코드수
from employee;

-- 부서별로 월급의 합계, 평균, 최대월급, 최소월급, 그룹핑된 수를 출력

select dno 부서번호, SUM(salary) 합계, Round (AVG(salary))평균, 
       MAX(salary) 최대값, MIN(salary) 최소값, COUNT(*) 그룹핑된수
from employee
group by dno;       -- DNO 칼럼의 동일한 값을 그룹핑해서 집계함수를 적용함.

select salary, dno
from employee
order by dno asc;

--직책별로 월급의 합계, 평균 최대값, 최소값, 그룹핑된수를 출력해 보세요
select ename, job, salary
from employee
order by job;

select job 직책,count(*) 그룹핑된갯수 ,SUM(salary) 합계,
       round(AVG(salary))평균, MAX(salary)최대값, MIN(salary)최소값
from employee
group by job;          -- job 컬럼의 동일한 값을 그룹핑

select count(*)전체레코드수 from employee; --14

/*
  group by 절에서 where[조건] vs having[조건]
    where [조건] : group by 하기전에 조건을 가져옴    , 별칭이름을 사용할 수 없다.
    having [조건] : group by 해서 나온 결과에 대한 조건 , 별칭이름을 사용할 수 없다.
    
    order by 칼럼명 asc[desc] : 별칭이름을 사용가능
      
*/

-- 직급별로 월급의 합계, 평균, 최대값, 최소값, 그룹핑 된 수를 출력하되, 
--   부서번호20은 제외하고 부서별로 평균이 2000이상인 내용만 출력

select ename, job, salary
from employee
order by job;

select job 직책,count(*)그룹핑된갯수 ,SUM(salary)합계,
 round(AVG(salary))평균, MAX(salary)최대값, MIN(salary)최소값
from employee
where dno <> 20
group by job 
HAVING AVG(salary) >= 2000;
--------------------------------------------------------
select*from employee
order by dno asc;

select job 직급, count(job), SUM(salary) 월급의합계, Round(AVG(salary))평균,
      MAX(salary)최대값,MIN(salary)최소값
from employee
where dno!=(20)    -- group by전의 조건
group by job       -- 각직급별평균 
having Round(AVG(salary))>=2000  -- 2000이상값 출력
order by 평균 desc;


-- group by 절에서 칼럼이 2개 이상, 두 칼럼에 걸쳐서 동일한 내용을 그룹핑함.
  -- job, dno
  
select job , dno from employee
order by job asc; 

select dno, job, sum(salary) 합한값, count(*)
from employee
group by job, dno

-- 각 직책(job) 에 대해서 월급의 합계, 평균, 최대값, 최소값, 카운트수를 출력하되 입사일이 81년도에 입사한 사원들 만 적용
-- 월급의 평균이 1500만원 이상인 것만 출력 하되 평균을 내림차순 정렬

SELECT job 직책, count(*), sum(salary) 합계, round(avg(salary)) 평균, max(salary)최대값,
      min(salary) 최소값
from employee
where hiredate like '81%'
group by job
having round(avg(salary)) >= 1500
order by 평균 desc;

/*  group by 절에서 사용되는 키워드
    rollup : group by 칼럼 <== 결과 마지막 라인에 전체 결과도 한번더 출력
    cube   : 그룹핑 마지막 라인에 결과 출력, 마지막 라인에 전체 결과도 세부적으로 출력
*/

-- 1. rollup , cube 키워드를 사용하지 않는 경우 : 그룹핑한 결과만 출력
 select dno, job , count(*), SUM(salary), round(avg(salary),2) , max(salary), min(salary)
 from employee
 group by dno, job 
 order by count(*) desc;
 
 select dno , job
 from employee
 order by dno asc
  
-- 2. rollup 키워드를 사용하지 않는 경우 : 그룹핑한 결과 출력, 전체 내용도 출력 
 select dno, job , count(*), SUM(salary), round(avg(salary),2) , max(salary), min(salary)
 from employee
 group by rollup (dno,job) 
 order by count(*) desc;


-- 3. cube 키워드를 사용하는경우 : 그룹핑한 결과 출력, 전체 내용도 출력, 세부사항까지 출력
 select dno, job , count(*), SUM(salary), round(avg(salary),2) , max(salary), min(salary)
 from employee
 group by cube(dno,job) 
 order by count(*) desc;

/*
   SubQuery : SElect 문내의 select 쿼리 [ sub query ] , 여러번의 작업을 한 구문에서 처리 
     - where 절에서 많이 사용됨
 */
-- ename[사원이름]이 SCOOTT인 사원의 직책과 같은 사원들을 출력 : 2번 쿼리가 필요함.

-- 1. SCOTT 사원의 직책을 알아오는 쿼리
 select job 
 from employee 
 where ename = 'SCOTT'
 
-- 2. 알아온 직책을 조건으로 해서 이름을 출력 
select ename , job
from employee
where job = 'ANALYST'

-- SubQuery를 사용해서 하나의 쿼리로 처리함.

select ename ,job
from employee
where job = (select job from employee where ename= 'ALLEN');

select * from employee;