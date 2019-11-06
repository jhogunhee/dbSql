-- �׷��Լ�
-- multi row function : �������� ���� �Է����� �ϳ��� ��� ���� ����
-- SUM, MAX, MIN, AVG, COUNT
-- GROUP BY col | express
-- SELECT ������ GROUP BY ���� ����� COL, EXPRESS ǥ�� ����

-- ������ ���� ���� �޿� ��ȸ
SELECT MAX(sal) max_sal
FROM emp;

-- �μ����� ���� ���� �޿� ��ȸ
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
-- join�� 
SELECT dept.dname, emp.ename, emp.job
FROM emp NATURAL join dept;

-- ������ ���� join0
SELECT emp.empno, emp.ename,emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
order by dname;

-- �ǽ� join0_1
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE (emp.deptno = 10 or emp.deptno = 30) and
       (dept.deptno = 10 or dept.deptno = 30);
       
-- �ǽ� join0_2

SELECT * FROM emp;
SELECT * FROM dept;

SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.sal > 2500;

-- JOIN
-- emp ���̺��� dname �÷��� ����.

-- emp ���̺� �μ��̸��� ������ �� �ִ� dname �÷� �߰�
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

-- ansi natural join : �����ϴ� ���̺��� �÷����� ���� �÷��� ��������
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

-- ������ ����ϴ� ���� ���൵ �������
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- job�� sales�λ����
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

-- JOIN with ON (�����ڰ� ���� �÷��� on���� ���� ���)
SELECT dept.dname, emp.ename, emp.job
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT dept.    dname, emp.ename, emp.job
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- SELF join : ���� ���̺��� ����
-- emp���̺��� mgr ������ �����ϱ� ���ؼ� emp ���̺�� ������ �ؾ��Ѵ�.
SELECT dept.dname, emp.ename, emp.job
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename,b.mgr
FROM emp a JOIN emp b ON (a.mgr = b.empno)
WHERE a.empno BETWEEN 7369 AND 7698;

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename 
FROM emp a, emp b
WHERE (a.mgr = b.empno) and (a.empno BETWEEN 7369 AND 7698);

-- non-equijoing (��� ������ �ƴѰ��)
SELECT *
FROM salgrade;

SELECT *
FROM emp;

-- ������ �޿� �����?
SELECT a.empno, a.ename, a.sal, b.*
FROM emp a, salgrade b
WHERE a.sal BETWEEN b.losal and b.hisal;

-- ���� ON���� ��ȯ�ϱ�
SELECT a.empno, a.ename, a.sal, b.*
FROM emp a JOIN salgrade b ON(a.sal BETWEEN b.losal and b.hisal);

--non equi joining
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE (a.mgr != b.empno) and a.empno = 7369;

-- �ǽ� JOIN 0
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
-- �ǽ� jon0_1
SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
and e.deptno in(10,30);


SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno and 
e.deptno in(10,30);

--ORDER BY deptno desc;

-- join on�� �̿��� �÷�
SELECT e.empno, e.ename, d.deptno, dname
FROM emp e join dept d on(e.deptno = d.deptno)
and (d.deptno = 10 or d.deptno = 30)
ORDER BY deptno desc;

-- join using�� �̿��� �÷�
SELECT e.empno, e.ename, deptno, dname
FROM emp e join dept d using(deptno)
WHERE deptno IN(10,30);












 

