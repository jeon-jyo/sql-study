SELECT *
  FROM employees, departments;
--      107     *    27         = 2889
-- 두 테이블의 행들의 가능한 모든 쌍이 추출됨

-- 카티젼 프로덕트(Cartesian Product) : 올바른 JOIN 조건을 WHERE 절에 부여
-- EQUI JOIN
SELECT *
  FROM employees, departments
 WHERE employees.department_id = departments.department_id;
--      106
-- NULL은 조인안됨(제외됨)

SELECT e.first_name
       ,e.salary
       ,d.department_name
       ,e.department_id AS "eID"
       ,d.department_id AS "dID"
  FROM employees e, departments d
 WHERE e.department_id = d.department_id;
-- Kimberely x

-- 모든 직원이름, 부서이름, 업무명 을 출력하세요
SELECT e.first_name
       ,d.department_name
       ,j.job_title
  FROM employees e, departments d, jobs j
 WHERE e.department_id = d.department_id
   AND e.job_id = j.job_id;

--------------------------------------------------------------------------------

-- OUTER JOIN
-- JOIN 조건을 만족하지 않는 컬럼이 없는 경우 - NULL을 포함하여 결과를 생성
-- 모든 행이 결과 테이블에 참여

-- LEFT JOIN
SELECT e.department_id, e.first_name, d.department_name
  FROM employees e LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id;

-- NULL이 올 수 있는 쪽 조건에 (+)를 붙인다.
SELECT e.department_id, e.first_name, d.department_name
  FROM employees e, departments d
 WHERE e.department_id = d.department_id(+);
-- 107 (null) Kimberely (null)

-- RIGHT JOIN
SELECT e.department_id, e.first_name, d.department_name
  FROM employees e RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id;

SELECT e.department_id, e.first_name, d.department_name
  FROM employees e, departments d
 WHERE e.department_id(+) = d.department_id;
-- (null) (null) IT Support
-- Kimberely x

-- FULL OUTER JOIN
SELECT e.department_id, e.first_name, d.department_name
  FROM employees e FULL OUTER JOIN departments d
    ON e.department_id = d.department_id;
-- 107 (null) Kimberely (null)

--SELECT e.department_id, e.first_name, d.department_name
--  FROM employees e, departments d
-- WHERE e.department_id(+) = d.department_id(+);

--------------------------------------------------------------------------------

-- SELF JOIN
-- 가상으로 2개의 테이블인 것처럼 간주한 뒤 JOIN
-- 다른 컬럼을 통해서 위계 또는 관계를 알 수 있는 모습으로 조회할 수 있음
SELECT e.first_name name
       ,e.phone_number phone
       ,m.first_name mngName
       ,m.phone_number mngPhone
  FROM employees e, employees m
 WHERE e.manager_id = m.employee_id;