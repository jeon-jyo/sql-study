-- 전체 컬럼 조회
SELECT * FROM employees;
SELECT *
  FROM departments;

-- 원하는 컬럼 조회
-- 사원의 이름(first_name)과 전화번호 입사일 연봉을 출력하세요
SELECT first_name,
       phone_number,
       hire_date,
       salary
  FROM employees;

-- 사원의 이름(first_name)과 성(last_name), 연봉 전화번호 이메일 입사일을 출력하세요
SELECT first_name
       ,last_name
       ,salary
       ,phone_number
       ,email
       ,hire_date
  FROM employees;

-- 별명 추가
SELECT first_name 이름,
       phone_number 전화번호,
       hire_date AS 입사일,
       salary AS 연봉
  FROM employees;

-- 사원의 사원번호와 이름(first_name), 성(last_name), 연봉 전화번호 이메일 입사일로 표시되도록 출력하세요
SELECT employee_id 사원번호
       ,first_name 이름
       ,last_name 성
       ,salary 연봉
       ,phone_number 전화번호
       ,email 이메일
       ,hire_date 입사일
  FROM employees;

-- 대소문자, 뛰어쓰기 구별을 위한 ""
SELECT employee_id "eID" 
       ,first_name "f-name"
       ,salary "연 봉"
  FROM employees;

--------------------------------------------------------------------------------

-- 연결 연산자(Concatenation)로 컬럼들 붙이기
SELECT first_name||last_name
  FROM employees;

-- '' 는 글자로 판단
SELECT first_name || '   ' || last_name
  FROM employees;
SELECT first_name || '-' || last_name AS name
  FROM employees;
  
-- 산술 연산자 사용하기
SELECT first_name
       ,salary
       ,salary*12 AS "year-salary"
  FROM employees;
SELECT first_name
       ,salary
       ,salary*12 ysalary
       ,salary/30 dsalary
       ,(salary+300)*12 bsalary
  FROM employees;

-- 전체직원의 정보를 다음과 같이 출력하세요
-- 성명(first_name last_name) -> 성과 이름사이에 – 로 구분 ex) William-Gietz
-- 급여 연봉(급여*12) 연봉2(급여*12+5000) 전화번호
SELECT first_name || '-' || last_name AS 성명
       ,salary 급여
       ,salary*12 연봉
       ,(salary*12)+5000 연봉2
       ,phone_number 전화번호
  FROM employees;

--------------------------------------------------------------------------------

-- WHERE
-- =, !=, >, <, >=, <= 연산자 사용하기
-- 부서번호가 50인 사원의 이름을 구하시오
SELECT *
  FROM employees
 WHERE department_id = 50;

-- 연봉이 15000 이상인 사원들의 이름과 월급을 출력하세요
SELECT first_name
       ,salary
  FROM employees
 WHERE salary >= 15000;

-- 문자, 날짜는 '' 로 감싸줌
-- 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
SELECT first_name
       ,hire_date
  FROM employees
 WHERE hire_date >= '07/01/01';

-- 이름이 Lex인 직원의 연봉을 출력하세요
SELECT salary
  FROM employees
 WHERE first_name = 'Lex';

-- 조건이 2개 이상일 때 -> AND, BETWEEN, OR
-- 연봉이 14000 이상 17000 이하인 사원의 이름과 연봉을 구하시오
SELECT first_name
       ,salary
  FROM employees
 WHERE salary >= 14000
   AND salary <= 17000;

SELECT first_name
       ,salary
  FROM employees
 WHERE salary BETWEEN 14000 AND 17000;

-- 연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
SELECT first_name
       ,salary
  FROM employees
 WHERE salary <= 14000
    OR salary >= 17000;

-- 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
SELECT first_name
       ,hire_date
  FROM employees
 WHERE hire_date >= '04/01/01'
   AND hire_date <= '05/12/31';

SELECT first_name
       ,hire_date
  FROM employees
 WHERE hire_date BETWEEN '04/01/01' AND '05/12/31';

--------------------------------------------------------------------------------

-- IN
-- 이름이 Neena, Lex, John인 사원의 이름과 연봉을 구하시오
SELECT first_name
       ,last_name
       ,salary
  FROM employees
 WHERE first_name IN ('Neena', 'Lex', 'John');

-- 연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
SELECT first_name
       ,salary
  FROM employees
 WHERE salary IN (2100, 3100, 4100, 5100);

-- LIKE
-- % : 임의의 길이의 문자열(공백 문자 가능) / 대소문자 구별함
SELECT *
  FROM employees
 WHERE first_name LIKE 'A%';
SELECT *
  FROM employees
 WHERE first_name LIKE '%m';
SELECT *
  FROM employees
 WHERE first_name LIKE 'K%n';

-- 이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
SELECT first_name
       ,salary
  FROM employees
 WHERE first_name LIKE '%am%';

-- _  : 한글자 길이
-- 이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
SELECT first_name
       ,salary
  FROM employees
 WHERE first_name LIKE '_a%';

-- 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
SELECT first_name
  FROM employees
 WHERE first_name LIKE '___a%';

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
SELECT first_name
  FROM employees
 WHERE first_name LIKE '__a_';
 
--------------------------------------------------------------------------------

-- NULL
SELECT first_name
       ,salary
       ,commission_pct
  FROM employees
 WHERE salary BETWEEN 13000 AND 15000;

SELECT first_name
       ,salary
       ,commission_pct
       ,salary*commission_pct
  FROM employees
 WHERE salary BETWEEN 13000 AND 15000;

-- 커미션이 null인 사원을 구하시오
SELECT *
  FROM employees
 WHERE commission_pct IS NULL;

-- 커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
SELECT first_name
       ,salary
       ,commission_pct
  FROM employees
 WHERE commission_pct IS NOT NULL;

-- 담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
SELECT first_name
  FROM employees
 WHERE manager_id IS NULL
   AND commission_pct IS NULL;
   
--------------------------------------------------------------------------------

-- ORDER BY 절
/*
    내림차순 : 큰거 -> 작은거 DESC
    오름차순 : 작은거 -> 큰거 ASC
*/
-- 연봉 내림차순 + 이름 오름차순
SELECT salary
       ,first_name
  FROM employees
 WHERE salary >= 9000
 ORDER BY salary DESC, first_name ASC;

-- 부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
SELECT department_id
       ,salary
       ,first_name
  FROM employees
 ORDER BY department_id;

-- 급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
SELECT first_name
       ,salary
  FROM employees
 WHERE salary >= 10000
 ORDER BY salary DESC;

-- 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요
SELECT department_id
       ,salary
       ,first_name
  FROM employees
 WHERE salary >= 10000
 ORDER BY department_id, salary DESC;