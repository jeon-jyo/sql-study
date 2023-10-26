SELECT *
  FROM departments;
SELECT *
  FROM employees;

-- 부서별로 합계를 내시오
-- (연봉이 10000 이상인 직원만)
SELECT SUM(salary), department_id
  FROM employees
 WHERE salary >= 10000
 GROUP BY department_id;

-- 부서별로 합계를 내시오
-- (부서별 합계가 10000 이상되는 부서만)
SELECT SUM(salary), department_id
  FROM employees
 GROUP BY department_id
HAVING SUM(salary) >= 10000;

SELECT SUM(salary), department_id
  FROM employees
 GROUP BY department_id
HAVING SUM(salary) >= 10000
   AND department_id >= 100
 ORDER BY department_id DESC;
--SELECT SUM(salary), department_id
--  FROM employees
-- GROUP BY department_id
--HAVING SUM(salary) >= 10000
--   AND first_name LIKE '%n';

--------------------------------------------------------------------------------

-- CASE ~ END 문
SELECT employee_id
       ,first_name
       ,salary
       ,job_id
       ,CASE
            WHEN job_id='AC_ACCOUNT' THEN salary+salary*0.1
            WHEN job_id='SA_REP'     THEN salary+salary*0.2
            WHEN job_id='ST_CLERK'   THEN salary+salary*0.3
            ELSE salary
         END "addBonus"
  FROM employees;

-- DECODE 문
SELECT employee_id
       ,first_name
       ,salary
       ,job_id
       ,DECODE(job_id, 'AC_ACCOUNT', salary*0.1,
                       'SA_REP', salary*0.2,
                       'ST_CLERK', salary*0.3,
                       0) AS "Bonus"
  FROM employees;

-- 직원의 이름, 부서, 팀을 출력하세요
-- 팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’,
-- 60~100이면 ‘B-TEAM’, 110~150이면 ‘C-TEAM’, 나머지는 ‘팀없음’ 으로 출력하세요.
SELECT first_name
       ,department_id
       ,CASE
            WHEN department_id BETWEEN 10 AND 50 THEN 'A-TEAM'
            WHEN department_id BETWEEN 60 AND 100 THEN 'B-TEAM'
            WHEN department_id BETWEEN 110 AND 150 THEN 'C-TEAM'
            ELSE '팀 없음'
         END "TEAM"
  FROM employees;