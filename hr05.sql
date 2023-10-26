-- SubQuery

-- 단일행 SubQuery
-- 연산자 : =, >, >=, <, <=, <>(같지않다)

-- ‘Den’ 보다 급여를 많이 받은 사람의 이름과 급여는?
SELECT first_name
       ,salary
  FROM employees
 WHERE salary >= (SELECT salary
                    FROM employees
                   WHERE first_name = 'Den');

-- 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
SELECT first_name
       ,salary
       ,employee_id
  FROM employees
 WHERE salary = (SELECT MIN(salary)
                   FROM employees);

-- 평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요
SELECT first_name
       ,salary
  FROM employees
 WHERE salary < (SELECT AVG(salary)
                   FROM employees);

--------------------------------------------------------------------------------

-- 다중행 SubQuery
-- 연산자 : ANY, ALL, IN ...

-- IN
-- 부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요
SELECT employee_id
       ,first_name
       ,salary
  FROM employees
 WHERE salary IN (SELECT salary
                    FROM employees
                   WHERE department_id = 110);

-- 각 부서별로 최고급여를 받는 사원을 출력하세요
-- 주의) 100번 부서의 최고연봉이 12008인 경우
--      -> 다른 부서의 최고연봉이 12008인 사람은 구해지면 안됨
--      -> 100번 부서에서는 2명 이상일 수 있음
SELECT employee_id
       ,first_name
       ,salary
       ,department_id
  FROM employees
 WHERE (salary, department_id) IN (SELECT MAX(salary), department_id
                                     FROM employees
                                    GROUP BY department_id);

-- 부서별 최고연봉 액 --> 어느부서인지는 모름
SELECT MAX(salary)
  FROM employees
 GROUP BY department_id;
-- 부서별 최고급여 리스트 --> 이름을 출력할 수 없음
SELECT MAX(salary), department_id
  FROM employees
 GROUP BY department_id;

--------------------------------------------------------------------------------

-- ANY (or)
-- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
-- 사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
SELECT salary
  FROM employees
 WHERE department_id = 110;
                      
SELECT employee_id
       ,first_name
       ,salary
  FROM employees
 WHERE salary > ANY (SELECT salary
                       FROM employees
                      WHERE department_id = 110);

-- ALL (and)
-- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
-- 사번, 이름, 급여를 출력하세요.(and연산--> 12008보다 큰)
SELECT employee_id
       ,first_name
       ,salary
  FROM employees
 WHERE salary > ALL (SELECT salary
                       FROM employees
                      WHERE department_id = 110);

-- ANY 를 쓰면 (8300 or 12008) 되어서 급여가 8300보다 큰 사람부터 나옴
-- ALL 을 쓰면 (8300 and 12008) 되어서 급여가 12008 보다 큰 사람부터 나옴

--------------------------------------------------------------------------------

-- 조건절에서 비교 vs 테이블에서 비교
-- 각 부서별로 최고급여를 받는 사원을 출력하세요
SELECT department_id, employee_id, first_name, salary
  FROM employees
 WHERE (department_id, salary) IN (SELECT department_id, MAX(salary)
                                     FROM employees
                                    GROUP BY department_id);

SELECT e.department_id, e.employee_id, e.first_name, e.salary
  FROM employees e, (SELECT department_id, MAX(salary) salary
                       FROM employees
                      GROUP BY department_id) s
 WHERE e.department_id = s.department_id
   AND e.salary = s.salary;

--------------------------------------------------------------------------------

-- ROWNUM : 질의의 결과에 가상으로 부여되는 Oracle의 가상 Column (일렬번호)
-- 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
SELECT *
  FROM employees;

SELECT ROWNUM
       ,first_name
       ,salary
  FROM employees
 WHERE ROWNUM >= 1
   AND ROWNUM <= 5;

-- 정렬, ROWNUM 을 같이 사용하면 번호부터 부여한 뒤에 정렬함
SELECT ROWNUM
       ,first_name
       ,salary
  FROM employees
 WHERE ROWNUM >= 1
   AND ROWNUM <= 5
 ORDER BY salary DESC;

-- ★
-- 정렬된 테이블부터 만들고 다음에 번호를 매겨야 함
--SELECT ROWNUM
--       ,first_name
--       ,salary
--  FROM (연봉 순으로 정렬된 데이터);
SELECT ROWNUM
       ,first_name
       ,salary
  FROM (SELECT first_name
               ,salary
          FROM employees
         ORDER BY salary DESC)
 WHERE ROWNUM >= 1
   AND ROWNUM <= 5;

--------------------------------------------------------------------------------

-- 5부터 10까지는 안됨
SELECT ROWNUM
       ,first_name
       ,salary
  FROM (SELECT first_name
               ,salary
          FROM employees
         ORDER BY salary DESC)
 WHERE ROWNUM >= 5
   AND ROWNUM <= 10;

-- (정렬, ROWNUM rn)
--SELECT *
--  FROM (정렬, ROWNUM rn)
-- WHERE rn >= 2
--   AND rn <= 3;

--SELECT ROWNUM
--       ,salary
--  FROM (급여순 정렬된 테이블);

SELECT ROWNUM
       ,ot.first_name
       ,ot.salary
  FROM (SELECT first_name
               ,salary
          FROM employees
         ORDER BY salary DESC
       ) ot; -- 급여순 정렬된 테이블

-- ★
SELECT ort.rn
       ,ort.first_name
       ,ort.salary
  FROM (SELECT ROWNUM rn
               ,ot.first_name
               ,ot.salary
          FROM (SELECT first_name
                       ,salary
                  FROM employees
                 ORDER BY salary DESC
               ) ot -- 급여순 정렬된 테이블
       ) ort
 WHERE ort.rn >= 2
   AND ort.rn <= 3;

-- 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
SELECT ort.rn
       ,ort.first_name
       ,ort.salary
       ,ort.hire_date
  FROM (SELECT ROWNUM rn
               ,ot.first_name
               ,ot.salary
               ,ot.hire_date
          FROM (SELECT first_name
                       ,salary
                       ,hire_date
                  FROM employees
                 WHERE hire_date LIKE '07/__/__'
                 ORDER BY salary DESC
               ) ot
       ) ort
 WHERE ort.rn BETWEEN 3 AND 7;