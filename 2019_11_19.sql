-- emp_test ���̺� ����
DROP TABLE emp_test;

-- multiple insert�� ���� �׽�Ʈ ���̺� ����
-- empno, ename �ΰ��� �÷��� ������ emp_test, emp_test2 ���̺���
-- emp ���̺�κ��� �����Ѵ�(CTAS)

CREATE TABLE emp_test2 AS 
select empno, ename
FROM emp
WHERE 1=2;

CREATE TABLE emp_test AS 
select empno, ename
FROM emp
WHERE 1=2;

-- INSERT ALL
-- �ϳ��� INSERT SQL �������� ���� ���̺� �����͸� �Է�
INSERT ALL
    INTO emp_test
    INTO emp_test2
-- �ߺ� ���� x
SELECT 1, 'brown' FROM dual UNION ALL
SELECT 2, 'sally' FROM dual;

SELECT *
FROM emp_test;

-- INSERT ALL �÷� ����
ROLLBACK;

-- UNION ALL �ߺ��� ����
-- UNION �ߺ�����
INSERT ALL
INTO emp_test (empno) VALUES (empno)
INTO emp_test2 VALUES (empno, ename)
SELECT 1 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;
     SELECT *
FROM emp_test2;

rollback;
-- multiple insert (conditional insert)
-- UNION ALL �ߺ��� ����
INSERT ALL
    WHEN empno < 10 THEN
        INTO emp_test (empno) VALUES (empno)
    ELSE -- ������ ������� ���ҋ��� ����
        INTO emp_test2 VALUES (empno, ename)        
        
SELECT 20 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;
ROLLBACK;
-- INSERT FIRST
-- ���ǿ� �����ϴ� ù��° INSERT ������ ����
SELECT *
FROM emp_test;

INSERT FIRST
    WHEN empno > 1 THEN
        INTO emp_test (empno) VALUES (empno)
    WHEN empno > 10 THEN
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

-- MGERGE : ���ǿ� �����ϴ� �����Ͱ� ������ UPDATE
--          ���ǿ� �����ϴ� �����Ͱ� ������ INESRT

-- empno�� 7369�� �����͸� emp���̺�κ��� ����(insert)
INSERT INTO emp_test
SELECT empno, ename
FROM emp
WHERE empno = 7369;

SELECT *
FROM emp_test;

rollback;
ALTER TABLE emp_test modify (ename varchar2(20));
-- emp ���̺��� �������� emp_test ���̺��� empno�� ���� ���� ���� �����Ͱ� �������
-- emp_test.ename = ename || '_merge' ������ update
-- �����Ͱ� ���� ��쿡�� emp_test���̺� insert
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
-- �ٸ� ���̺��� ������ �ʰ� ���̺� ��ü�� ������ ���� ������
-- merge �ϴ� ���
rollback;

-- empno = 1, ename = 'brown'
-- empno�� ���� ���� ������ ename�� 'brown'���� update
-- empno�� ���� ���� ������ �ű� insert
MERGE INTO emp_test
USING dual
ON (emp_test.empno = 1)
WHEN MATCHED THEN
     UPDATE set ename = 'brown' || '_merge'
WHEN NOT MATCHED THEN    
     INSERT values(1, 'brown');
     
-- �Ʒ��� ���� ������ε� © �� ����
SELECT 'X'
FROM emp_test
WHERE empno = 1;

UPDATE emp_test set ename = 'brown' || '_merge'
WHERE empno=1;

INSERT INTO emp_test VALUES (1, 'brown');

-- GROUP_AD1, ��� ������ �޿���
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
-- group by�� ���� �׷��� ����
-- GROUP BY ROLLUP( {col})
-- �÷��� �����ʿ������� �����ذ��鼭 ���� ����׷���
-- GROUP BY�Ͽ� UNION�� �Ͱ� ����
-- ex : GROUP BY ROLLUP (job, deptno)
--      GROUP BY job, deptno
--       UNION
--       GROUP BY job
--       UNION
--       GROUP BY --> �Ѱ� (��� �࿡ ���� �׷��Լ� ����)

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
-- GROUPING SETS�� ������ �׸��� �ϳ��� ����׷����� GROUP BY���� �̿�ȴ�.

-- GROUP BY col1
-- UNION ALL
-- GROUP BY col2

-- emp ���̺��� �̿��Ͽ� �μ��� �޿��հ�, ������(job)�� �޿����� ���Ͻÿ�

-- �μ���ȣ, job, �޿��հ�
SELECT deptno, null job, SUM(sal)
FROM emp
GROUP BY deptno
UNION ALL
SELECT null, job , SUM(sal)
FROM emp
GROUP BY job;

-- deptno, job -> job -> deptno ������ �׷����ĵȴ�.
SELECT deptno, job, sum(sal)
FROM emp
GROUP BY GROUPING SETS(deptno, job, (deptno, job));
