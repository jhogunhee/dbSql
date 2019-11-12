-- 실습 sub7
SELECT cycle.cid, customer.cnm, product.pid, product.pnm,day, cnt
FROM cycle, customer, product
WHERE cycle.cid = 1 
and cycle.cid = customer.cid
and cycle.pid = product.pid
and cycle.pid IN (SELECT pid FROM cycle where cid=2);

-- 실습 sub9
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
-- UPDATE 테이블 SET 컬럼 = 값, 컬럼 = 값 .....
-- WHERE condition
desc dept;
SELECT * FROM dept, emp
WHERE deptno = 99;

-- 사원번호가 9999인 직원을 emp 테이블에서 삭제
DELETE FROM emp
WHERE empno = 9999;

--부서테이블을 이용해서 emp 테이블에 입력한 5건의 데이터를 삭제
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
-- DML문장을 통해 트랙잭션시작
SELECT *
FROM dept;
commit;

-- DDL : AUTO COMMIT, rollback이 안된다.
CREATE TABLE ranger_new (
    ranger_no NUMBER,   -- 숫자 타입
    ranger_name VARCHAR2(50),  -- 문자 : [VARCHAR2], CHAR
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
-- FOREIGN KEY = 해당 컬럼이 참조하는 

-- 제약조건
-- DEPT 모방해서 DEPT_TEST 생성
desc dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY, -- deptno 컬럼을 식별자로 지정
    dname varchar2(14),           -- 식별자로 지정이 되면 값이 중복이
    loc varchar2(13)              -- 될 수 없으며 null 일 수도 없다.
);   

-- Primary Key 제약 조건 확인
-- 1. deptno 컬럼에 null이 들어갈 수 없다.
-- 2. deptno 컬럼에 중복된 값이 들어갈 수 없다.
INSERT INTO dept_test (deptno, dname, loc) 
values(1, 'ddit','daejeon');

INSERT INTO dept_test 
values(1, 'ddit2','gimpo2');

SELECT * FROM dept_test;
desc dept_test;

rollback;

-- 사용자 지정 제약조건명을 부여한 PRIMARY KEY
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY, -- 제약조건 이름까지 설정
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

