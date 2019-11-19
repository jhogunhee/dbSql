-- tb_

SELECT * FROM emp;
-- VIEW ���� (emp ���̺��� sal, comm�ΰ� �÷��� �����Ѵ�)
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

-- INLINE VIEW
SELECT *
FROM ( SELECT empno, ename, job, mgr, hiredate, deptno
       FROM emp);

-- VIEW (�� �ζ��κ�� �����ϴ�)       
SELECT * 
FROM v_emp;       

-- ���ε� ���� ����� view�� ����
-- emp, dept : dept.�μ���, �����ȣ, �����, ������, �Ի�����
CREATE OR REPLACE VIEW v_emp_dept as
SELECT a.dname, b.empno, b.ename, b.job, b.hiredate 
FROM dept a, emp b
WHERE a.deptno = b.deptno;

-- VIEW ����
drop view v_emp_dept;

-- VIEW�� �����ϴ� ���̺��� �����͸� �����ϸ� VIEW���� ������ ����.
-- dept 30 - SALES
SELECT * 
FROM v_emp_dept;

-- dept���̺��� SALES --> MARKET SALES
UPDATE dept set dname = 'MARKET SALES'
WHERE deptno = 30;

SELECT * FROM dept;
rollback;

-- HR �������� v_emp_dept view ��ȸ������ �ش�.
GRANT SELECT ON v_emp_dept TO hr;

-- SEQUENCE ���� (�Խñ� ��ȣ �ο��� ������)
CREATE SEQUENCE seq_post 
INCREMENT BY 1
START WITH 1;

SELECT seq_post.nextval, seq_post.currval
FROM dual;

SELECT seq_post.currval
FROM dual;

SELECT * 
FROM post
WHERE post_id = 'brown'
AND title = '�������� ����ִ�'
AND reg_dt = TO_DATE('2019/11/14 15:40:15', 
                    'YYYY/MM/DD HH24:MI:SS');
                    
SELECT *
FROM post
WHERE post_id = 1;

-- ������ ����
-- ������ : �ߺ����� �ʴ� ���� ���� ���� ���ִ� ��ü
-- 1, 2, 3, .......
DESC emp_test;
DROP TABLE emp_test;
SELECT *
FROM emp_test;

CREATE TABLE emp_test(  
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(15)
);
-- 
INSERT INTO emp_test values(seq_emp_test.nextval, 'brown');
delete from emp_TEST where EMPNO = 1;
SELECT seq_emp_test.nextval
FROM dual;
rollback;
CREATE SEQUENCE seq_emp_test;
SELECT *
FROM emp_test;
-- index
-- rowid : ���̺� ���� ������ �ּ�, �ش� �ּҸ� �˸�
-- ������ ���̺� �����ϴ� ���� �����ϴ�.
SELECT product.*, ROWID
FROM product
WHERE ROWID = 'AAAb7xAAMAAAAEuAAA';