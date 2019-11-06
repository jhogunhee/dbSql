-- 그룹함수
-- multi row function : 여러개의 행을 입력으로 하나의 결과 행을 생성
-- SUM, MAX, MIN, AVG, COUNT
-- GROUP BY col | express
-- SELECT 절에는 GROUP BY 절에 기술된 COL, EXPRESS 표기 가능

-- 직원중 가장 높은 급여 조회
SELECT MAX(sal) max_sal
FROM emp;

-- 부서별로 가장 높은 급여 조회
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno;

SELECT DECODE(DEPTNO, '10', 'ACCOUNTING',
                     '20', 'RESEARCH',
                     '30', 'SALES') DNAME, MAX(SAL) max_sal, MIN(SAL) MIN_SAL,
       ROUND(AVG(sal),0) avg_sal,
       SUM(SAL) SUM_SAL,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,  
       COUNT(mgr) mgr_cnt,
       nvl(SUM(comm),0)
FROM emp    
GROUP BY DECODE(DEPTNO, '10', 'ACCOUNTING', '20', 'RESEARCH', '30', 'SALES');

SELECT to_char(hiredate,'YYYYMM') hire,count(*)
FROM emp
group by to_char(hiredate,'YYYYMM');

SELECT to_char(hiredate,'YYYY'),count(*) CNT
FROM emp
Group by to_char(hiredate,'YYYY');

SELECT COUNT(deptno) cnt, count(*) cnt
FROM dept;

SELECT count(distinct deptno) deptno_num
FROM dept;

------------------
-- join문 
SELECT dept.dname, emp.ename, emp.job
FROM emp NATURAL join dept;

-- 데이터 결합 join0
SELECT emp.empno, emp.ename,emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
order by dname;

-- 실습 join0_1
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE (emp.deptno = 10 or emp.deptno = 30) and
       (dept.deptno = 10 or dept.deptno = 30);
       
-- 실습 join0_2

SELECT * FROM emp;
SELECT * FROM dept;

SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.sal > 2500;

-- JOIN
-- emp 테이블에는 dname 컬럼이 없다.

-- emp 테이블에 부서이름을 저장할 수 있는 dname 컬럼 추가
ALTER TABLE emp ADD (dname VARCHAR2(14));

UPDATE emp SET dname = 'ACCOUNTING' WHERE DEPTNO=10;
UPDATE emp SET dname = 'ACCOUNTING' WHERE DEPTNO=20;
UPDATE emp SET dname = 'ACCOUNTING' WHERE DEPTNO=30;

SELECT dname, MAX(sal) max_sal
FROM emp
GROUP BY dname;

SELECT *
FROM emp;

ALTER TABLE emp drop column dname;

-- ansi natural join : 조인하는 테이블의 컬럼명이 같은 컬럼을 기준으로
-- JOIN 
SELECT *
FROM EMP NATURAL JOIN dept ;

-- ORACLE join
SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- ANSI JOIN WITH USINGG
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept USING (deptno);

-- 기존에 사용하던 조건 제약도 기술가능
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- job이 sales인사람만
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE (emp.deptno = dept.deptno)
and emp.job = 'SALESMAN';

SELECT emp.empno, emp.ename, dept.dname, job
FROM emp, dept
WHERE (emp.deptno = dept.deptno);

-- JOIN with Using
SELECT dept.dname, emp.ename, emp.job
FROM emp JOIN dept USING (deptno);

-- join(oracle)
SELECT dept.dname, emp.ename, emp.job
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- JOIN with ON (개발자가 조인 컬럼을 on절에 직접 기술)
SELECT dept.dname, emp.ename, emp.job
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT dept.    dname, emp.ename, emp.job
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- SELF join : 같은 테이블끼리 조인
-- emp테이블의 mgr 정보를 참고하기 위해서 emp 테이블과 조인을 해야한다.
SELECT dept.dname, emp.ename, emp.job
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename,b.mgr
FROM emp a JOIN emp b ON (a.mgr = b.empno)
WHERE a.empno BETWEEN 7369 AND 7698;

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename 
FROM emp a, emp b
WHERE (a.mgr = b.empno) and (a.empno BETWEEN 7369 AND 7698);

-- non-equijoing (등식 조인이 아닌경우)
SELECT *
FROM salgrade;

SELECT *
FROM emp;

-- 직원의 급여 등급은?
SELECT a.empno, a.ename, a.sal, b.*
FROM emp a, salgrade b
WHERE a.sal BETWEEN b.losal and b.hisal;

-- 조인 ON절로 변환하기
SELECT a.empno, a.ename, a.sal, b.*
FROM emp a JOIN salgrade b ON(a.sal BETWEEN b.losal and b.hisal);

--non equi joining
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE (a.mgr != b.empno) and a.empno = 7369;

-- 실습 JOIN 0
SELECT empno,ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY DNAME;

SELECT emp.empno,emp.ename, deptno, dept.dname
FROM emp JOIN dept USING (deptno)
ORDER BY DNAME;

SELECT emp.empno,emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
ORDER BY DNAME;

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.empno = 7369;

SELECT *
FROM emp;

SELECT *
FROM dept;
-- 실습 jon0_1
SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
and e.deptno in(10,30);


SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno and 
e.deptno in(10,30);

--ORDER BY deptno desc;

-- join on을 이용한 컬럼
SELECT e.empno, e.ename, d.deptno, dname
FROM emp e join dept d on(e.deptno = d.deptno)
and (d.deptno = 10 or d.deptno = 30)
ORDER BY deptno desc;

-- join using을 이용한 컬럼
SELECT e.empno, e.ename, deptno, dname
FROM emp e join dept d using(deptno)
WHERE deptno IN(10,30);












 

