-- emp_test 테이블 제거
DROP TABLE emp_test;

-- multiple insert를 위한 테스트 테이블 생성
-- empno, ename 두개의 컬럼을 가지는 emp_test, emp_test2 테이블을
-- emp 테이블로부터 생성한다(CTAS)

CREATE TABLE emp_test2 AS 
select empno, ename
FROM emp
WHERE 1=2;

CREATE TABLE emp_test AS 
select empno, ename
FROM emp
WHERE 1=2;

-- INSERT ALL
-- 하나의 INSERT SQL 문장으로 여러 테이블에 데이터를 입력
INSERT ALL
    INTO emp_test
    INTO emp_test2
-- 중복 제거 x
SELECT 1, 'brown' FROM dual UNION ALL
SELECT 2, 'sally' FROM dual;

SELECT *
FROM emp_test;

-- INSERT ALL 컬럼 정의
ROLLBACK;

-- UNION ALL 중복도 포함
-- UNION 중복제거
INSERT ALL
INTO emp_test (empno) VALUES (empno)
INTO emp_test2 VALUES (empno, ename)
SELECT 1 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;
     SELECT *
FROM emp_test2;

rollback;
-- multiple insert (conditional insert)
-- UNION ALL 중복도 포함
INSERT ALL
    WHEN empno < 10 THEN
        INTO emp_test (empno) VALUES (empno)
    ELSE -- 조건을 통과하지 못할떄만 실행
        INTO emp_test2 VALUES (empno, ename)        
        
SELECT 20 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;
ROLLBACK;
-- INSERT FIRST
-- 조건에 만족하는 첫번째 INSERT 구문만 실행
SELECT *
FROM emp_test;

INSERT FIRST
    WHEN empno > 1 THEN
        INTO emp_test (empno) VALUES (empno)
    WHEN empno > 10 THEN
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

-- MGERGE : 조건에 만족하는 데이터가 있으면 UPDATE
--          조건에 만족하는 데이터가 없으면 INESRT

-- empno가 7369인 데이터를 emp테이블로부터 복사(insert)
INSERT INTO emp_test
SELECT empno, ename
FROM emp
WHERE empno = 7369;

SELECT *
FROM emp_test;

rollback;
ALTER TABLE emp_test modify (ename varchar2(20));
-- emp 테이블의 데이터중 emp_test 테이블의 empno와 같은 값을 갖는 데이터가 있을경우
-- emp_test.ename = ename || '_merge' 값으로 update
-- 데이터가 없을 경우에는 emp_test테이블에 insert
MERGE INTO emp_test
USING (SELECT empno, ename
        FROM emp
        WHERE emp.empno IN (7369, 7499)) emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
     UPDATE SET ename = ename || '_merge'
WHEN NOT MATCHED THEN
     INSERT VALUES(emp.empno, emp.ename);
     
SELECT * FROM
emp_test;
rollback;
-- 다른 테이블을 통하지 않고 테이블 자체의 데이터 존재 유무로
-- merge 하는 경우
rollback;

-- empno = 1, ename = 'brown'
-- empno가 같은 값이 있으면 ename을 'brown'으로 update
-- empno가 같은 값이 없으면 신규 insert
MERGE INTO emp_test
USING dual
ON (emp_test.empno = 1)
WHEN MATCHED THEN
     UPDATE set ename = 'brown' || '_merge'
WHEN NOT MATCHED THEN    
     INSERT values(1, 'brown');
     
-- 아래와 같은 방법으로도 짤 수 있음
SELECT 'X'
FROM emp_test
WHERE empno = 1;

UPDATE emp_test set ename = 'brown' || '_merge'
WHERE empno=1;

INSERT INTO emp_test VALUES (1, 'brown');

-- GROUP_AD1, 모든 직원의 급여합
SELECT *
FROM 
(SELECT deptno, sum(sal)
FROM emp
GROUP by deptno
order by deptno)
UNION ALL
(SELECT null, sum(sal)
FROM emp);

-- ROLLUP
-- group by의 서브 그룹을 생성
-- GROUP BY ROLLUP( {col})
-- 컬럼을 오른쪽에서부터 제거해가면서 나온 서브그룹을
-- GROUP BY하여 UNION한 것과 동일
-- ex : GROUP BY ROLLUP (job, deptno)
--      GROUP BY job, deptno
--       UNION
--       GROUP BY job
--       UNION
--       GROUP BY --> 총계 (모든 행에 대해 그룹함수 적용)

SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

SELECT deptno, sum(sal)
FROM emp
GROUP BY rollup(deptno);

SELECT job, sum(sal)
FROM emp
GROUP BY rollup(job);

SELECT * FROM emp;

-- GROUPING SETS (col1, col2...)
-- GROUPING SETS의 나열된 항목이 하나의 서브그룹으로 GROUP BY절에 이용된다.

-- GROUP BY col1
-- UNION ALL
-- GROUP BY col2

-- emp 테이블을 이용하여 부서별 급여합과, 담당업무(job)별 급여합을 구하시오

-- 부서번호, job, 급여합계
SELECT deptno, null job, SUM(sal)
FROM emp
GROUP BY deptno
UNION ALL
SELECT null, job , SUM(sal)
FROM emp
GROUP BY job;

-- deptno, job -> job -> deptno 순으로 그룹정렬된다.
SELECT deptno, job, sum(sal)
FROM emp
GROUP BY GROUPING SETS(deptno, job, (deptno, job));
