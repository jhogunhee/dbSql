-- tb_

SELECT * FROM emp;
-- VIEW 생성 (emp 테이블에서 sal, comm두개 컬럼을 제외한다)
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

-- INLINE VIEW
SELECT *
FROM ( SELECT empno, ename, job, mgr, hiredate, deptno
       FROM emp);

-- VIEW (위 인라인뷰와 동일하다)       
SELECT * 
FROM v_emp;       

-- 조인된 쿼리 결과를 view로 생성
-- emp, dept : dept.부서명, 사원번호, 사원명, 담당업무, 입사일자
CREATE OR REPLACE VIEW v_emp_dept as
SELECT a.dname, b.empno, b.ename, b.job, b.hiredate 
FROM dept a, emp b
WHERE a.deptno = b.deptno;

-- VIEW 제거
drop view v_emp_dept;

-- VIEW를 구성하는 테이블의 데이터를 변경하면 VIEW에도 영향이 간다.
-- dept 30 - SALES
SELECT * 
FROM v_emp_dept;

-- dept테이블의 SALES --> MARKET SALES
UPDATE dept set dname = 'MARKET SALES'
WHERE deptno = 30;

SELECT * FROM dept;
rollback;

-- HR 계정에게 v_emp_dept view 조회권한을 준다.
GRANT SELECT ON v_emp_dept TO hr;

-- SEQUENCE 생성 (게시글 번호 부여용 시퀀스)
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
AND title = '하하하하 재미있다'
AND reg_dt = TO_DATE('2019/11/14 15:40:15', 
                    'YYYY/MM/DD HH24:MI:SS');
                    
SELECT *
FROM post
WHERE post_id = 1;

-- 시퀀스 복습
-- 시퀀스 : 중복되지 않는 정수 값을 리턴 해주는 객체
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
-- rowid : 테이블 행의 물리적 주소, 해당 주소를 알면
-- 빠르게 테이블에 접근하는 것이 가능하다.
SELECT product.*, ROWID
FROM product
WHERE ROWID = 'AAAb7xAAMAAAAEuAAA';