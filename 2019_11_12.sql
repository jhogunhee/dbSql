-- �ǽ� sub7
SELECT cycle.cid, customer.cnm, product.pid, product.pnm,day, cnt
FROM cycle, customer, product
WHERE cycle.cid = 1 
and cycle.cid = customer.cid
and cycle.pid = product.pid
and cycle.pid IN (SELECT pid FROM cycle where cid=2);

-- �ǽ� sub9
SELECT *
FROM product
WHERE not exists
(SELECT 'x'
FROM cycle
WHERE cid = 1 and pid = product.pid);

--DML
delete from emp where empno=9999;

desc emp;

SELECT * 
FROM user_tab_columns
WHERE table_name = 'EMP'
ORDER BY column_id;
commit;

-- UPDATE
-- UPDATE ���̺� SET �÷� = ��, �÷� = �� .....
-- WHERE condition
desc dept;
SELECT * FROM dept, emp
WHERE deptno = 99;

-- �����ȣ�� 9999�� ������ emp ���̺��� ����
DELETE FROM emp
WHERE empno = 9999;

--�μ����̺��� �̿��ؼ� emp ���̺� �Է��� 5���� �����͸� ����
-- 10, 20, 30, 40  1. empno < 50 empno between 10 and 40
SELECT * FROM emp;
DELETE FROM emp
WHERE empno <= 40;

DELETE FROM emp
WHERE empno BETWEEN 10 AND 40;

DELETE FROM emp
WHERE empno IN(SELECT deptno FROM dept);

-- LV1 --> LV3
SET TRANSACTION
SET TRANSACTION SERIALIZABLE;
commit;
SET TRANSACTION isolation LEVEL READ COMMITTED;
-- DML������ ���� Ʈ����ǽ���
SELECT *
FROM dept;
commit;

-- DDL : AUTO COMMIT, rollback�� �ȵȴ�.
CREATE TABLE ranger_new (
    ranger_no NUMBER,   -- ���� Ÿ��
    ranger_name VARCHAR2(50),  -- ���� : [VARCHAR2], CHAR
    reg_dt DATE DEFAULT sysdate -- DEFAULT : SYSDATE
);
desc ranger_new;

SELECT * FROM ranger_new;
INSERT INTO ranger_new(ranger_no,
ranger_name) values(1000, 'brown');
commit;

SELECT to_char(sysdate,'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt, to_char(reg_dt, 'MM'),
       EXTRACT(MONTH FROM reg_dt) mm,
       EXTRACT(YEAR FROM reg_dt) year,
       EXTRACT(day FROM reg_dt) day
FROM ranger_new;
 
-- PRIMARY KEY = UNIQUE + NOT NULL
-- FOREIGN KEY = �ش� �÷��� �����ϴ� 

-- ��������
-- DEPT ����ؼ� DEPT_TEST ����
desc dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY, -- deptno �÷��� �ĺ��ڷ� ����
    dname varchar2(14),           -- �ĺ��ڷ� ������ �Ǹ� ���� �ߺ���
    loc varchar2(13)              -- �� �� ������ null �� ���� ����.
);   

-- Primary Key ���� ���� Ȯ��
-- 1. deptno �÷��� null�� �� �� ����.
-- 2. deptno �÷��� �ߺ��� ���� �� �� ����.
INSERT INTO dept_test (deptno, dname, loc) 
values(1, 'ddit','daejeon');

INSERT INTO dept_test 
values(1, 'ddit2','gimpo2');

SELECT * FROM dept_test;
desc dept_test;

rollback;

-- ����� ���� �������Ǹ��� �ο��� PRIMARY KEY
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY, -- �������� �̸����� ����
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

-- TABLE CONSTRAINT 
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2), 
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT PK_DEPT_TEST PRIMARY KEY deptno
);
SELECT * FROM dept_test;
INSERT INTO dept_test 
values(1, 'ddit2','gimpo2');
INSERT INTO dept_test 
values(1, 'ddit2','gimpo2');

ROLLBACK;

-- NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13)
);

INSERT INTO dept_test values(1, 'ddit', 'daejeon');
INSERT INTO dept_test values(2, null, 'daejeon');

-- UNIQUE
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);

INSERT INTO dept_test values(1, 'ddit', 'daejeon');
INSERT INTO dept_test values(2, 'ddit2', 'daejeon');
ROLLBACK;
SELECT * FROM dept_test;

