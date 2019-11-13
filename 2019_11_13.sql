SELECT * FROM lprod;

SELECT *
FROM dept_test;

DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    -- CONSTRAINT �������Ǹ� CONSTRAINT TYPE[(�÷�.....)]
    CONSTRAINT uk_dept_test_dname_loc UNIQUE (dname, loc)    
);
SELECT * FROM dept_test;
INSERT INTO dept_test VALUES(1, 'ddit', 'daegjeon');

-- ù���� ������ ���� dname, loc���� �ߺ��ǹǷ� �ι��� ������ ������� ���Ѵ�.
INSERT INTO dept_test VALUES(2, 'ddit2', 'daegjeon');

-- foreign key(��������)
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)    
);
INSERT INTO dept_test VALUES(1, 'ddit', 'daejeon');
COMMIT;
SELECT * FROM dept_test;

-- emp_test (empno, ename, deptno)
DESC emp;
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    -- dept_test ���̺��� deptno�� �����ؼ� ���ڴ�.
    deptno NUMBER(2) REFERENCES dept_test(deptno)
);
SELECT * FROM dept_test;
INSERT INTO emp_test values(9999, 'gunhee',1);

-- 2�� �μ��� dept_test ���̺� �������� �ʴ� �������̱� ������ 
-- fk���࿡ ���� INSERT�� ���������� �������� ���Ѵ�.
INSERT INTO emp_test values(9999, 'gunhee',2);
commit;

-- dept_test ���̺� 1�� �μ���ȣ�� �����ϱ� ������
-- fk ������ dept_test.deptno �÷��� �����ϵ��� �����Ͽ�
-- 1���̿��� �μ���ȣ�� �Էµ� �� ����.

-- ���Ἲ ���࿡�� �椩���� �� �ؾ� �ɱ�
-- �Է��Ϸ��� �ϴ� ���� �´°ǰ�??? (2���� �³�? 1���� �Ƴ�??)
-- . �θ����̺� ���� �� �Է��� �ȵǾ����� Ȯ��(dept_testȮ��)

-- fk���� table level constraint
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    CONSTRAINT fk_emp_test_to_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test(deptno)
);
DESC emp_test;

-- FK������ �����Ϸ��� �����Ϸ��� �÷��� �ε����� �����Ǿ��־���Ѵ�.
DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2), /* PRIMARY KEY --> UNIQUE ���� X --> �ε��� ����X*/
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2) REFERENCES dept_test(deptno)
);
-- dept_test.dept_no�÷��� �ε����� ���� ������ ����������
-- fk ������ ������ �� ����.

-- ���̺� ����
DROP TABLE emp_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY, --> UNIQUE ���� X --> �ε��� ����X*/
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
INSERT INTO emp_test VALUES (9999, 'brown', 1);

DELETE dept_test
WHERE deptno = 1;
DELETE emp_test
WHERE empno = 9999;

SELECT * FROM dept_test;
SELECT * FROM emp_test;

-- dept_test���̺��� deptno ���� �����ϴ� �����Ͱ� ���� ���
-- ������ �Ұ����ϴ�.
-- �� �ڽ� ���̺��� �����ϴ� �����Ͱ� ����� 
-- �θ� ���̺��� �����͸� ���� �����ϴ�.

-- FK ���� �ɼ�
-- default : ������ �Է� / ������ ���������� ó������� fk ������ �������� �ʴ´�.
-- ON DELETE CASCADE : �θ� ������ ������ �����ϴ� �ڽ� ���̺� ���� ����
-- ON DELETE NULL : �θ� ������ ������ �����ϴ� �ڽ� ���̺� �� NULL ����
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    CONSTRAINT fk_emp_test_to_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test(deptno) ON DELETE CASCADE
);
SELECT * FROM emp_test;
INSERT INTO dept_test  values(1, 'ddit', 'daejeon');
INSERT INTO emp_test  values(9999, 'brown', 1);
commit;

-- FK ���� default �ɼǽÿ��� �θ� ���̺��� �����͸� �����ϱ����� �ڽ� ���̺���
-- �����ϴ� �����Ͱ� ����� ���������� ������ ��������
-- ON DELETE CASCADE�� ��� �θ� ���̺� ������ �����ϴ� �ڽ� ���̺��� �����͸�
-- ���� �����Ѵ�.
-- 1. ���� ������ ���������� ����Ǵ���?
DELETE dept_test 
WHERE deptno = 1;

-- 2. �ڽ� ���̺� �����Ͱ� ���� �Ǿ�����??
SELECT *
FROM emp_test;

DROP TABLE emp_test;

--FK ���� ON DELETE SET NULL
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    CONSTRAINT fk_emp_test_to_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test(deptno) ON DELETE SET NULL
);
SELECT * FROM emp_test;
INSERT INTO dept_test  values(1, 'ddit', 'daejeon');
INSERT INTO emp_test  values(9999, 'brown', 1);
commit;

-- FK ���� default �ɼǽÿ��� �θ� ���̺��� �����͸� �����ϱ����� �ڽ� ���̺���
-- �����ϴ� �����Ͱ� ����� ���������� ������ ��������
-- ON DELETE SET NULL�� ��� �θ� ���̺� ������ �����ϴ� �ڽ� ���̺��� �����͸�
-- ���� �÷��� NULL�� �����Ѵ�.
-- 1. ���� ������ ���������� ����Ǵ���?
DELETE dept_test 
WHERE deptno = 1;

-- 2. �ڽ� ���̺� �ش� �����Ͱ� NULL�� �Ǿ�����??
SELECT *
FROM emp_test;

-- CHECK ���� : �÷��� ���� ������ ����, Ȥ�� ���� �����Բ� ����
DROP TABLE emp_test;
CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR2(10),
    sal NUMBER CHECK (sal >= 0)
);

--SAL �÷��� CHECK ���� ���ǿ� ���� 0�̰ų�, 0���� ū ���� �Է��� �����ϴ�.
INSERT INTO emp_test values(9999, 'brown', 10000);
INSERT INTO emp_test values(9999, 'brown', -10000);

DROP TABLE emp_test;
CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR2(10),
    
    -- emp_gb : 01 - ������, 02 - ����
    emp_gb VARCHAR2(2) CHECK(emp_gb IN('01', '02'))
);

INSERT INTO emp_test VALUES(9999, 'brown', '01');

--emp_gb �÷� üũ���࿡ ���� 01, 02�� �ƴѰ��� �Էµ� �� ����.
INSERT INTO emp_test VALUES(9998, 'sally', '03');

-- SELECT ����� �̿��� TABLE ����
-- CREATE Table ���̺�� AS
-- SELECT ����
-- CTAs

DROP TABLE emp_test;
DROP TABLE dept_test;
SELECT * FROM customer_test;
-- CUSTOMER ���̺��� ����Ͽ� CUSTOMER_TEST���̺�� ����
-- CUSTOMER ���̺��� �����͵� ���� ����
CREATE TABLE customer_test as 
SELECT *
FROM customer;

-- �����ʹ� �������� �ʰ� Ư�� ���̺��� �÷� ���ĸ� ������ �� ������?
CREATE TABLE test AS
SELECT SYSDATE dt
FROM dual;

DROP TABLE test;
CREATE TABLE test AS
SELECT *
FROM customer
WHERE 1=2;

SELECT * FROM test;
CREATE TABLE test(
    c1 VARCHAR2(2) CHECK (c1 in ('01', '02')),
    c2 VARCHAR2(2) PRIMARY KEY,
    c3 VARCHAR2(3) UNIQUE
);

SELECT * FROM test2;
INSERT INTO test VALUES('01','2','3');
    
CREATE TABLE test2 as
SELECT * FROM test;

DROP TABLE test2;
SELECT * FROM test2;

SELECT * FROM emp_test;
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4) CONSTRAINT pk_emp_test primary key,
    ename VARCHAR2(10)
);

-- �ű� �÷� �߰�
ALTER TABLE emp_test ADD (deptno NUMBER(2) );
DESC emp_test;

-- ���� �÷� ����(���̺� �����Ͱ� ���� ��Ȳ)
ALTER TABLE EMP_TEST MODIFY ( ename NUMBER);
DESC emp_test;

-- �����Ͱ� �ִ� ��Ȳ���� �÷� ���� : �������̴�.
INSERT INTO emp_test VALUES(9999, 1000, 10);
COMMIT;
ALTER TABLE EMP_TEST MODIFY ( ename VARCHAR2(10));

-- DEFAULT ����
DESC emp_test;
ALTER TABLE emp_test MODIFY (deptno DEFAULT 10);

SELECT * FROM emp_test;

-- �÷��� ����
ALTER TABLE emp_test RENAME COLUMN DEPTNO TO dno;

-- �÷� ���� (DROP)
ALTER TABLE emp_test DROP COLUMN DNO;
--ALTER TABLE emp_test ADD (deptno NUMBER(2) );
ALTER TABLE emp_test add (DNO VARCHAR(2));

-- ���̺� ���� : �������� �߰�
-- PRIMARY KEY 
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);

-- ���� ���� ����
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

-- UNIQUE ���� - empno
ALTER TABLE emp_test ADD CONSTRAINT uk_emp_test UNIQUE(empno);

DESC emp_test;

-- FOREIGN KEY �߰�
-- �ǽ� 
-- 1. DEPT ���̺��� DEPTNO�÷����� PRIMARY KEY ������ ���̺� ����
-- ddl�� ���� ����
DESC dept;
SELECT * FROM dept;

ALTER TABLE dept ADD CONSTRAINT pk_dept_deptno PRIMARY KEY(deptno);
ALTER TABLE dept DROP CONSTRAINT pk_dept_deptno;
-- 2. emp ���̺��� empno �÷����� PRIMARY KEY ������ ���̺� ����
-- ddl�� ���� ����
ALTER TABLE emp ADD CONSTRAINT pk_emp_empno PRIMARY KEY(empno);
-- 3. emp ���̺��� dept �÷����� dept ���̺��� deptno �÷���
-- �����ϴ� fk ������ ���̺� ���� ddl�� ���� ����
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY(deptno) 
REFERENCES dept(deptno);

-- emp_test -> dept.deptno�� �����ϴ� fk ���� ���� (ALTER TABLE)
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2)
);

SELECT * FROM emp_test;
SELECT * FROM dept;
DROP TABLE emp_test;

--ALTER TABLE emp_test DROP CONSTRAINT pk_dept;
ALTER TABLE emp_test add CONSTRAINT fk_emp_dept2 FOREIGN KEY(deptno) REFERENCES
dept(deptno);

--ALTER TABLE emp_test DROP CONSTRAINT ;
-- CHECK ���� �߰�
ALTER TABLE emp_test ADD CONSTRAINT check_ename_len
CHECK (LENGTH(ename) > 3);

SELECT * FROM emp_test;
desc emp_test;
INSERT INTO emp_test VALUES(9999, 'brown', 10);
INSERT INTO emp_test VALUES(9998, 'br', 10);

-- CHECK ���� ����
ALTER TABLE emp_test DROP CONSTRAINT CHECK_ENAME_LEN;

-- NOT NULL ���� �߰�
ALTER TABLE emp_test MODIFY (ename NOT NULL);

-- NOT NULL ���� ����(NULL ���)
ALTER TABLE emp_test MODIFY (ename NULL);

