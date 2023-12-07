
/*
   Oracle의 다양한 함수 사용 하기 : 인풋 == 기능> 결과
   1. 문자를 처리하는 함수
   2. 숫자를 처리하는 함수
   3. 날짜를 처리하는 함수
   4. 변환 함수
   5. 일반 함수
 */
 /*
  1. 문자를 처리하는 함수 :
  - UPPER : 소문자를 대문자로 변환해주는 함수.
  - LOWER : 소문자로 처리해 주는 함수
  - INITCAP : 첫 자만 대문자로 처리해 주는 함수
  - LENGTH : 글자수를 반환 (영문: 1byte, 한글 : 2byte, 3byte )
  - LENGTHB : 글자수 반환 (영문: 1byte, 한글 : 3byte)
  - CONCAT : 문자열을 연결해주는 함수
  - SUBSTR : 글자를 잘라오는 함수
  - INSTR : 특정 문자의 위치값을 출력
  - LPAD : 글자 자릿수를 입력 받아서 나머지는 특정 기호로 채움( 왼쪽 )
  - RPAD : 글자 자릿수를 입력 받아서 나머지는 특정 기호로 채움( 오른쪽 )
  - RTRIM : 오른쪽의 공백 제거
  - LTRIM : 왼쪽의 공백 제거
    
  dual : 가상의 테이블
 */
 
 select UPPER('Oracle')from dual;
 
 select*from employee;
 
 select ename as 원본이름, UPPER(ename) 대문자이름, LOWER(ename)소문자,
 INITCAP(ename)첫자만대문자 from employee;
 
 -- 검색이 안됨 칼럼의 값은 대소문자를 구분 (오류구문)
 select*
 from employee
 where ename ='smith';
 
 --출력됨
 select*
 from employee
 where ename = UPPER('smith');
 ----------------------------------
 select LENGTH('Oracle mania') from dual;  -- 12 (글자의 갯수 공백포함)
 select LENGTH('오라클 매니아') from dual;  --7
 
 select LENGTHB('Oracle mania') from dual;  -- 12 
 select LENGTHB('오라클 매니아') from dual;  --19   //한글 1자: 3byte (UTF-8) 19출력
 
 select ename 원본, LENGTH(ename) 글자수 from employee;
 select ename 원본, LENGTHB(ename) 글자수 from employee;
 
 -- CONTAT : 문자열과 문자열을 연결 해주는 함수
 -- || 컬럼을 연결해 주는 연산자.
 select 'Oracle Mania' , 'Mania' from dual; -- 출력해주는 가상테이블
 
 select concat ('Oracle' , 'Mania') as 연결됨 from dual;

 select concat (ename, job) from employee;
 
 select ename ||job from employee;
 
 select ename ||'  '||job as 이름과직책 from employee;
 
 -- SUBSTR : 문자를 잘라오는 함수, substr(칼럼,4,3) <== 칼럼에 있는 문자열중, 4번째 자리에서 3자를 잘라와서 출력
 
 select substr ('Oracle Mania', 4,3) from dual;  --index : 1번부터 시작
 
 select ename 원본이름, substr (ename, 2,3) from employee;

 select * from employee; 
 
 -- employee 테이블에서 이름, 입사월만 출력 하세요. substr 함수를 사용
  select ename as 이름, substr(hiredate, 4,2) 입사월 from employee;
  
 -- employee 테이블에서 이름, 입사월만 출력 하세요. suwstr 함수를 사용 -- 2월달에 입사한 사원 출력
  select ename as 이름, substr(hiredate, 4,2) 입사월
  from employee
  where substr(hiredate, 4,2) = '02';
  
 -- 81년도에 입사한 사원의 이름, 입사년, 입사월, 입사일을 출력하세요. <== substr , where
  select ename 이름, substr(hiredate,1,2) 입사년, substr(hiredate,4,2)입사월, substr(hiredate,7,2)입사일
  from employee
  where substr(hiredate,1,2)='81';

 -- INSTR : 특정 문자의 index 번호를 출력  // index 번호는 1부터
   -- instr(칼럼명, 'A') : 칼럼에서 문자열중에 'A' 가 있는 index 번호를 출력
   -- instr(칼럼명, 'A', 4) : index4번 부터 으론쪽을 A가 들어가 있는 index 번호를 출력
   -- 검색 되지 않으면 0 으로 출력
 select (instr('Oracle Mania','a')) from dual;  -- 3  <== a가 위치한 index // a가3번째 위치
 
 select (instr('Oracle Mania','a',4)) from dual; -- 9 <== index 4번 이후부터 검색'a'가 위치한 index 검색
 
 select ename 이름, instr(ename, 'M') as M의위치
 from employee;
 
 --LPAD: LPAD(칼럼명, 늘릴자릿수, '*') : 공백 자리에 *를 채움 (왼쪽)
 --RPAD: RPAD(칼럼명, 늘릴자릿수, '*') : 공백 자리에 *를 채움 (오른쪽)
 
 select '770824-123456' 주민번호, LPAD('770824-1', 20,'*')as "LPAD" from dual;
 
 select '770824-123456' 주민번호, RPAD('770824-1', 20,'*')as "LPAD" from dual; 
 
 select*from employee;
 
 -- hiredate 칼럼을 년도만 출력하고 나머지는 *로 출력.  <== Substr, read 를 사용해서 처리
 select ename 이름, rpad(substr(hiredate,1,2), 8, '*') 입사년월일 
 from employee;
 
 --공백 처리 : RTRIM : 오른쪽의 공백을 제거, LTRIM: 왼쪽의 공백을 제거, TRIM : 왼쪽, 오른쪽 공백을 모두 제거
 
 select '      Oracle Mania       ' as 원본,
         LTRIM('      Oracle Mania       ') 왼쪽의공백제거,
         RTRIM('      Oracle Mania       ') 오른쪽의공백제거,
         TRIM('      Oracle Mania       ') 모든공백제거
         
 from dual;
 
 -- 앞뒤 공백제거후 값을 대문자로 변환
 select *
 from employee
 where ename = UPPER (TRIM ('  SMITH  '));
 
 -- ★2. 숫자를 처리하는 함수 : ROUND : 반올림 하는 함수, TRUNC : 특정자리수에서 잘라내어버림, MOD : 나머지 값만 출력
 
 -- ROUND : 특정 자릿 수에서 반올림, 5이상 반올림, 5미만은 잘라내 버림.
 /*
   ROUND (실수) : 소숫점 뒷자리에서 반올림
   ROUND (실수, 소숫점자릿수) :
    ★ -소숫점자리(양수) : 소숫점 기준으로 오른쪽으로 이동해서 그 뒷자리에서 반올림됨 <== 주의
       -소숫점자리(음수) : 소숫점 기준으로 왼쪽으로 이동해서 그 뒷자리에서 반올림됨 
 */
 
select 98.7654 as원본,
       round (98.7654) as R1,   -- 소숫점 뒤에서 반올림
       round (98.7654,2) as R2,  -- 소숫점 오른쪽으로 2자리 이동후 그 뒤에서 반올림 <== 주의 ★
       round (98.7654,-1) as R3, -- 소숫점 왼쪽으로 1자리 이동후 그 자리에서 반올림
       round (98.7654,-2) as R3,
       round (98.7654,-3) as R3
from dual; 

-- 근로 소득세 : 월급의 3.3,    salary * 0.033 소득세

select salary 월급, salary*0.033 소득세, Round ( salary*0.033)R1, Round((salary*0.033),2)R2,
       Round(salary -( salary *0.033),2)실수령액
from employee;

-- TRUNC : 특정 자리에서 잘라내 버림.   <== 특정 날짜를 연산 , 오늘 날짜에서 100 이후의 날짜가 언제 입니까?
select trunc(98.7654) T1,
       trunc(98.7654,2) T2,
       trunc(98.7654,-1) T3,
       trunc(98.7654,-2) T4
from dual;   

-- MOD : 나머지 값만 출력 , MOD (인자1, 인자2)
-- TRUNC : 몫 만 출력 할때 
select MOD (3,2),     -- 나머지
      TRUNC(31/2)     -- 몫만 출력
from dual;

/*
-- 날짜 함수 : 
    - sysdate : 현재 시스템의  날짜를 출력 하는 함수
    - months_between : 두 날짜 사이의 개월수를 출력
    - add_months : 특정 날짜에서 개월수를 더 해서 출력
    - next_day : 특정 날짜에서 다음에 초래하는 요일을 인자로 받아서 도래하는 날짜를 출력
    - last_day : 달의 마지막 날짜를 출력
    - round (날짜) : 날짜를 반올림 : 15일 이상 반올림, 15일 미만 : 삭제
    - trunc(날짜) : 날짜를 잘라내는 함수
*/

select sysdate from dual;  -- 23/12/07

-- 날짜에 연산이 가능  23/12/07   23/12/06   23/12/08
select sysdate 현재날짜, sysdate-1 어제날짜, sysdate +1 내일날짜 from dual;

-- 오늘에서 100일전 날짜가?  
select sysdate - 100"100전날짜" from dual;
-- 오늘 1000일 후의 날짜는?
select sysdate + 1000"1000일후날짜" from dual;

-- 입사일에서 오늘날까지 총근무일수를 구함. date 칼럼, (sysdate - hiredate)
desc employee;

-- 총근일수 = trunc(오늘날짜- 입사날짜)
select ename 이름, trunc(sysdate - hiredate) 총근무일수 from employee;

-- 입사일에서 1000일 시점의 날짜
select ename 이름, hiredate 입사날짜, hiredate + 1000입사후1000일날짜 from employee;

-- 특정 날짜에서 월만 출력 : TRUNC ( 날짜, 'MONTH') ,ROUND(날짜,'MONTH')
select hiredate 원본날짜, TRUNC(hiredate,'MONTH'),ROUND(hiredate,'MONTH')from employee;

-- 현재 까지의 근무 개월수를 출력 : months_between(날짜,날짜) : 두 날짜 사이의 개월수 출력
select ename 이름, hiredate 입사날짜,trunc(months_between(sysdate,hiredate))개월수 from employee;

-- 오늘 날짜에서 100개월 이후의 날짜, 100일 후의 날짜
-- date 타입 일때 가능

select sysdate 오늘날짜, add_months (sysdate,100)"100개월후", sysdate+100"100일후"from dual;

-- last_day : 그 날짜의 마지막 날짜를 출력함
select last_day(sysdate) from dual;

-- 모든 사원의 입사한 날의 마지막 날짜가 무엇인지 출력
select hiredate 입사날짜, last_day(hiredate) 마지막날짜 from employee;

/*
   ★ 형식 변환 함수
     TO_CHAR : 날짜형, 숫자형 ===> 문자형
     TO_DATE : 문자 ===> 날짜형식으로 변환
     TO_NUMBER : 문자 ==> 숫자형식으로 변환
   
*/

-- TO_CHAR : 날짜 ==> 문자

select sysdate from dual; -- 23/12/07 년, 월, 일

-- YYYY : 년도 , MM: 월, DD : 일, HH : 시간, MI : 분, SS : 초, DAY : 요일 (월요일), DY(월, 화)
select TO_CHAR (sysdate, 'YYYY-MM-DD HH:MI:SS') from dual; --2023-12-07

select hiredate 입사날짜 , TO_CHAR (hiredate, 'YYYY"년"-MI"월"-DD"일" HH:mm:SS')입사날짜2
from employee;

select TO_CHAR (sysdate, 'YYYY-MM-DD MON DAY DY HH:MI:SS') from dual;

-- TO_CHAR : 숫자 ==> 문자
/*
   0 : 자릿수를 처리함, 자릿수가 많으면 0으로 처리됨.
   9 : 자릿수를 처리함, 자릿수가 많으면 공백으로 처리됨.
   L : 각 지역의 통화를 기호로 표시함.
   
   . : 소숫점으로 처리됨
   , : 천단위 구분자
*/

select TO_CHAR( 9876 , 'L000,000')from dual; 
select TO_CHAR( 9876 , 'L999,999')from dual; 

-- 월급을 그 나라의 통화 기록을 붙여서 천단위로 출력

select salary 월급, to_char(salary,'L999,999')"월급(한국)"
from employee;

-- TO_DATE : 문자 , 숫자 ==> 날짜 형식으로 바꿈.
  -- 날짜 + 100일
  -- months_between(날짜, 날짜) : 개월 수
  
select to_date('1998-10-10' , 'YYYY-MM-DD')from dual;

-- 1981년 01월 01에서 100일 지난 시점의 날짜를 출력 , 100개월 지난 시점의 날짜 , add_month(날짜, 개월수)
select to_date('1981/01/01' , 'YYYY/MM/DD')+100 "100일후 날짜",
add_months(to_date('1981/01/01' , 'YYYY/MM/DD'),100) "100개월이후의 날짜"
from dual;

select to_date (770814, 'YYMMDD')from dual;

-- 자신의 생일에서 현재까지 몇개월 남았는지 ? 몇일 살았는지 출력/ <== months_between (현재날짜, 생일) : 개월수
   -- sysdate - 생일 (date)
select months_between(sysdate, to_date('1995-07-07' , 'YYYY/MM/DD')) as "현재까지 남은 개월수",

from dual
--employee 테이블에서 2050년 12월 24일까지의 날짜를 출력
select*
from employee

