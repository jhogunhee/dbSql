SELECT SUM(sal)
FROM emp;

-- emp ���̺� empno�÷��� �������� primary key�� ����
-- PRIMARY KEY = UNIQUE + NOT NULL
-- UNIQUE ==> �ش� �÷����� UNIQUE INDEX�� �ڵ����� ����

SELECT * FROM emp;
ALTER TABLE emp add constraint pk_emp primary key(empno);
alter table emp drop primary key;

commit;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

-- empno �÷����� �ε����� �����ϴ� ��Ȳ�֤���
-- �ٸ��÷� ������ �����͸� ��ȸ �ϴ� ���
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

-- EXPLAIN PLAN FOR -> TABLE(dbms_xplan.display);

-- �ε��� ���� �÷��� SELECT���� ����� ���
-- ���̺� ������ �ʿ� ����.

EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

-- �÷��� �ߺ��� ������ non-unique �ε��� ������
-- unique index���� �����ȹ ��
-- PRIMARY KEY �������� ����(unique �ε��� ����)
ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE /*UNIQUE*/ INDEX IDX_emp_01 ON emp(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE(dbms_xplan.display);

-- emp ���̺� job �÷����� �ι��� �ε��� ���� (non-unique index)
-- job �÷��� �ٸ� �ο��� job �÷��� �ߺ��� ������ �÷��̴�.
CREATE INDEX idx_emp_02 ON emp (job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'manager';

-- UNIQUE �ε����� ������ �ʾұ� ������ RANGE SCAN�� ���´�.
-- UNIQUE�� ����ÿ��� INDEX ? SCAN
SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

-- ename�� ���̺� �����ؾ����� �� �� ����
-- p376
SELECT *
FROM TABLE(dbms_xplan.display);

-- emp ���̺� job, ename �÷��� �������� non-unique �ε��� ����
CREATE INDEX IDX_emp_03 ON emp (job, ename);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

-- emp ���̺� ename, job �÷����� non-unique �ε��� ����
CREATE INDEX IDX_EMP_04 ON emp (ename, job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

-- HINT�� ����� �����ȹ ����
EXPLAIN PLAN FOR
SELECT * /*+ INDEX(emp idx_emp_01) */
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

CREATE TABLE DEPT_TEST AS ;
SELECT *
FROM DEPT
WHERE 1 = 1;

desc dept;

CREATE unique INDEX idx_deptno on dept_test(deptno);
drop INDEX idx_dname;
drop index idx_deptno_dname;
create INDEX idx_dname on dept_test(dname);
create INDEX idx_deptno_dname on dept_test(deptno, dname);

-- �ǽ� idx1���� ������ �ε����� �����ϴ� DDL
drop index idx_dname;
drop index idx_deptno;
drop index idx_deptno_dname;

-- INDEX �ǽ� idx 3
-- �ý��ۿ��� ����ϴ� ������ ������ ���ٰ� �Ҷ� ������
-- emp ���̺� �ʿ��ϴٰ� �����Ǵ� �ε����� 
-- ���� ��ũ��Ʈ��  ����� ������
SELECT * FROM emp;
--CREATE INDEX IDX_EMP_01 on emp(empno);
CREATE INDEX IDX_EMP_02 on emp(ename);
CREATE INDEX IDX_EMP_03 on emp(deptno);
commit;
