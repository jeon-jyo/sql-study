-- 단일행 함수 : 각각의 데이터를 한건 씩 처리

-- 문자열
-- 첫 글자를 대문자로 바꾸는 문자함수 - INITCAP(컬럼명)
SELECT email, INITCAP(email), department_id
  FROM employees
 WHERE department_id = 100;

-- 전부 대문자 또는 소문자로 바꾸는 문자함수 - LOWER(컬럼명), UPPER(컬럼명)
SELECT first_name, LOWER(first_name), UPPER(first_name)
  FROM employees
 WHERE department_id = 100;

-- 주어진 문자열에서 특정길이의 문자열을 구하는 문자함수 - SUBSTR(컬럼명, 시작위치, 글자수)
/*
    양수인 경우 왼쪽 -> 오른쪽으로 검색해서 글자수 만큼 추출
    음수인 경우 오른쪽 -> 왼쪽 검색을 한 후 왼쪽 -> 오른쪽으로 글자수 만큼 추출
*/
SELECT first_name, 
       SUBSTR(first_name, 1, 3),
       SUBSTR(first_name, -3, 2)
  FROM employees
 WHERE department_id = 100;

-- 문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) / RPAD(컬럼명, 자리수, ‘채울문자’)
-- LPAD() : 왼쪽 공백에 특별한 문자로 채우기
-- RPAD() : 오른쪽 공백에 특별한 문자로 채우기
SELECT first_name, 
       LPAD(first_name, 10, '*'),
       RPAD(first_name, 10, '12345678')
  FROM employees
 WHERE department_id = 100;

-- 문자함수 – REPLACE (컬럼명, 문자1, 문자2)
SELECT first_name, 
       REPLACE(first_name, 'a', '*****'),
       REPLACE(first_name, SUBSTR(first_name, 2, 3), '*****') eventName
  FROM employees;

--------------------------------------------------------------------------------

-- 숫자
-- 숫자함수 - ROUND(숫자, 출력을 원하는 자리수) : 자리수까지 반올림
SELECT ROUND(123.456, 2) AS R2
       ,ROUND(123.456, 0) AS R0
       ,ROUND(123.456, -1) AS "R-1"
  FROM DUAL;

-- 숫자함수 – TRUNC(숫자, 출력을 원하는 자리수) : 자리수 이후 버림
SELECT TRUNC(123.456, 2) AS T2
       ,TRUNC(123.456, 0) AS T0
       ,TRUNC(123.456, -1) AS "T-1"
  FROM DUAL;

-- 날짜함수 – SYSDATE()
SELECT sysdate
  FROM DUAL;

-- 단일함수 > 날짜함수 – MONTHS_BETWEEN(d1, d2)
-- d1날짜와 d2날짜의 개월수를 출력하는 함수
SELECT first_name
       ,hire_date
       ,sysdate
       ,MONTHS_BETWEEN('2002-07-27', hire_date)
  FROM employees
 WHERE department_id = 110;

SELECT first_name
       ,hire_date
       ,sysdate
       ,TRUNC(MONTHS_BETWEEN('2002-07-27', hire_date), 0)
  FROM employees
 WHERE department_id = 110;

-- 변환함수 > TO_CHAR(숫자, ‘출력모양’) : 숫자형 -> 문자형으로 변환하기
SELECT first_name,
       salary,
       salary*12,
       TO_CHAR(salary, '99,999,999'),
       TO_CHAR(salary*102, '$999,999,999.99'),
       TO_CHAR(salary, '099999')
  FROM employees
 WHERE department_id =110;
 
-- 변환함수 > TO_CHAR(날짜, ‘출력모양’) : 날짜 -> 문자형으로 변환하기
SELECT first_name,
       hire_date,
       TO_CHAR(hire_date,'YYYY-MM-DD HH:MI:SS'),
       TO_CHAR(hire_date, 'YYYY"년"MM"월"DD"일" HH"시"MI"분"SS"초"')
  FROM employees;
  
-- 일반함수 > NVL(컬럼명, null일때값) / NVL2(컬럼명, null아닐때값, null일때 값)
-- NVL(조사할 컬럼, NULL일 경우 치환할 값)
-- NVL2(조사할 컬럼, NULL이 아닐때 치환할 값, NULL일때 치환할 값)
SELECT first_name, 
       salary,
       commission_pct, 
       NVL(commission_pct, 0),
       salary + (salary*NVL(commission_pct, 0))
  FROM employees;

SELECT first_name, 
       salary,
       commission_pct, 
       NVL(commission_pct, 0),
       NVL2(commission_pct, 100,0)
  FROM employees;

--------------------------------------------------------------------------------

-- 복수행 함수 : 여러건의 데이터를 한꺼번에 처리 후 1개의 결과로 처리
-- 그룹함수, 집계함수 라고도 불림

-- 그룹함수 - AVG()
SELECT AVG(salary)
  FROM employees;
--SELECT AVG(salary), first_name
--  FROM employees;

-- 그룹함수 - COUNT()
-- null 빼고 특정값 개수는 컬럼명으로
-- null 포함은 *
SELECT COUNT(*), COUNT(commission_pct)
  FROM employees;

-- WHERE 절 있을 때
SELECT COUNT(*)
  FROM employees
 WHERE salary > 16000;

-- 그룹함수 - SUM()
SELECT SUM(salary), COUNT(salary), COUNT(*)
  FROM employees;

SELECT SUM(salary), AVG(salary), COUNT(salary), COUNT(*)
  FROM employees
 WHERE salary > 16000;

SELECT COUNT(*)
       ,SUM(salary)
       ,AVG(salary)
  FROM employees;

SELECT COUNT(*)
       ,SUM(salary)
       ,AVG(NVL(salary, 0))
  FROM employees;

-- 그룹함수 - MAX() / MIN()
SELECT COUNT(*)
       ,MAX(salary)
       ,MIN(salary)
  FROM employees
 WHERE department_id = 90;

--------------------------------------------------------------------------------

-- GROUP BY 절 : 특정 컬럼을 기준으로 집계
SELECT department_id
       ,SUM(salary)
       ,COUNT(department_id)
  FROM employees
 GROUP BY department_id
 ORDER BY department_id;

SELECT department_id
       ,job_id
       ,SUM(salary)
       ,AVG(salary)
       ,MAX(salary)
       ,COUNT(department_id)
  FROM employees
 GROUP BY department_id, job_id
 ORDER BY department_id;

-- 연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 인원수, 급여합계를 출력하세요
-- HAVING 절
SELECT department_id
       ,COUNT(*)
       ,SUM(salary)
  FROM employees
 GROUP BY department_id
HAVING SUM(salary) >= 20000;