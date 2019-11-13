SELECT * FROM lprod;

SELECT *
FROM dept_test;

DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    -- CONSTRAINT 제약조건명 CONSTRAINT TYPE[(컬럼.....)]
    CONSTRAINT uk_dept_test_dname_loc UNIQUE (dname, loc)    
);
SELECT * FROM dept_test;
INSERT INTO dept_test VALUES(1, 'ddit', 'daegjeon');

-- 첫번쨰 쿼리에 의해 dname, loc값이 중복되므로 두번쨰 쿼리는 실행되지 못한다.
INSERT INTO dept_test VALUES(2, 'ddit2', 'daegjeon');

-- foreign key(참조제약)
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
    -- dept_test 테이블의 deptno를 참조해서 쓰겠다.
    deptno NUMBER(2) REFERENCES dept_test(deptno)
);
SELECT * FROM dept_test;
INSERT INTO emp_test values(9999, 'gunhee',1);

-- 2번 부서는 dept_test 테이블에 존재하지 않는 데이터이기 떄문에 
-- fk제약에 의해 INSERT가 정상적으로 동작하지 못한다.
INSERT INTO emp_test values(9999, 'gunhee',2);
commit;

-- dept_test 테이블에 1번 부서번호만 존재하기 떄문에
-- fk 제약을 dept_test.deptno 컬럼을 참조하도록 생성하여
-- 1번이외의 부서번호는 입력될 수 없다.

-- 무결성 제약에러 방ㄹ생시 뭘 해야 될까
-- 입력하려고 하는 값이 맞는건가??? (2번이 맞나? 1번이 아냐??)
-- . 부모테이블에 값이 왜 입력이 안되었는지 확인(dept_test확인)

-- fk제약 table level constraint
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    CONSTRAINT fk_emp_test_to_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test(deptno)
);
DESC emp_test;

-- FK제약을 생성하려면 참조하려는 컬럼에 인덱스가 생성되어있어야한다.
DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2), /* PRIMARY KEY --> UNIQUE 제약 X --> 인덱스 생성X*/
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2) REFERENCES dept_test(deptno)
);
-- dept_test.dept_no컬럼에 인덱스가 없기 떄문에 정상적으로
-- fk 제약을 생성할 수 없다.

-- 테이블 삭제
DROP TABLE emp_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY, --> UNIQUE 제약 X --> 인덱스 생성X*/
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

-- dept_test테이블의 deptno 값을 참조하는 데이터가 있을 경우
-- 삭제가 불가능하다.
-- 즉 자식 테이블에서 참조하는 데이터가 없어야 
-- 부모 테이블의 데이터를 삭제 가능하다.

-- FK 제약 옵션
-- default : 데이터 입력 / 삭제시 순차적으로 처리해줘야 fk 제약을 위배하지 않는다.
-- ON DELETE CASCADE : 부모 데이터 삭제시 참조하는 자식 테이블 같이 삭제
-- ON DELETE NULL : 부모 데이터 삭제시 참조하는 자식 테이블 값 NULL 설정
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

-- FK 제약 default 옵션시에는 부모 테이블의 데이터를 삭제하기전에 자식 테이블에서
-- 참조하는 데이터가 없어야 정상적으로 삭제가 가능했음
-- ON DELETE CASCADE의 경우 부모 테이블 삭제시 참조하는 자식 테이블의 데이터를
-- 같이 삭제한다.
-- 1. 삭제 쿼리가 정상적으로 실행되는지?
DELETE dept_test 
WHERE deptno = 1;

-- 2. 자식 테이블에 데이터가 삭제 되었는지??
SELECT *
FROM emp_test;

DROP TABLE emp_test;

--FK 제약 ON DELETE SET NULL
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

-- FK 제약 default 옵션시에는 부모 테이블의 데이터를 삭제하기전에 자식 테이블에서
-- 참조하는 데이터가 없어야 정상적으로 삭제가 가능했음
-- ON DELETE SET NULL의 경우 부모 테이블 삭제시 참조하는 자식 테이블의 데이터를
-- 참조 컬럼을 NULL로 수정한다.
-- 1. 삭제 쿼리가 정상적으로 실행되는지?
DELETE dept_test 
WHERE deptno = 1;

-- 2. 자식 테이블에 해당 데이터가 NULL이 되었는지??
SELECT *
FROM emp_test;

-- CHECK 제약 : 컬럼의 값을 정해진 범위, 혹은 값만 들어오게끔 제약
DROP TABLE emp_test;
CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR2(10),
    sal NUMBER CHECK (sal >= 0)
);

--SAL 컬럼은 CHECK 제약 조건에 의해 0이거나, 0보다 큰 값만 입력이 가능하다.
INSERT INTO emp_test values(9999, 'brown', 10000);
INSERT INTO emp_test values(9999, 'brown', -10000);

DROP TABLE emp_test;
CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR2(10),
    
    -- emp_gb : 01 - 정직원, 02 - 인턴
    emp_gb VARCHAR2(2) CHECK(emp_gb IN('01', '02'))
);

INSERT INTO emp_test VALUES(9999, 'brown', '01');

--emp_gb 컬럼 체크제약에 의해 01, 02가 아닌값은 입력될 수 없다.
INSERT INTO emp_test VALUES(9998, 'sally', '03');

-- SELECT 결과를 이용한 TABLE 생성
-- CREATE Table 테이블명 AS
-- SELECT 쿼리
-- CTAs

DROP TABLE emp_test;
DROP TABLE dept_test;
SELECT * FROM customer_test;
-- CUSTOMER 테이블을 사용하여 CUSTOMER_TEST테이블로 생성
-- CUSTOMER 테이블의 데이터도 같이 복제
CREATE TABLE customer_test as 
SELECT *
FROM customer;

-- 데이터는 복제하지 않고 특정 테이블의 컬럼 형식만 가져올 순 없을까?
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

-- 신규 컬럼 추가
ALTER TABLE emp_test ADD (deptno NUMBER(2) );
DESC emp_test;

-- 기존 컬럼 변경(테이블에 데이터가 없는 상황)
ALTER TABLE EMP_TEST MODIFY ( ename NUMBER);
DESC emp_test;

-- 데이터가 있는 상황에서 컬럼 변경 : 제한적이다.
INSERT INTO emp_test VALUES(9999, 1000, 10);
COMMIT;
ALTER TABLE EMP_TEST MODIFY ( ename VARCHAR2(10));

-- DEFAULT 설정
DESC emp_test;
ALTER TABLE emp_test MODIFY (deptno DEFAULT 10);

SELECT * FROM emp_test;

-- 컬럼명 변경
ALTER TABLE emp_test RENAME COLUMN DEPTNO TO dno;

-- 컬럼 제거 (DROP)
ALTER TABLE emp_test DROP COLUMN DNO;
--ALTER TABLE emp_test ADD (deptno NUMBER(2) );
ALTER TABLE emp_test add (DNO VARCHAR(2));

-- 테이블 변경 : 제약조건 추가
-- PRIMARY KEY 
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);

-- 제약 조건 삭제
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

-- UNIQUE 제약 - empno
ALTER TABLE emp_test ADD CONSTRAINT uk_emp_test UNIQUE(empno);

DESC emp_test;

-- FOREIGN KEY 추가
-- 실습 
-- 1. DEPT 테이블의 DEPTNO컬럼으로 PRIMARY KEY 제약을 테이블 변경
-- ddl을 통해 생성
DESC dept;
SELECT * FROM dept;

ALTER TABLE dept ADD CONSTRAINT pk_dept_deptno PRIMARY KEY(deptno);
ALTER TABLE dept DROP CONSTRAINT pk_dept_deptno;
-- 2. emp 테이블의 empno 컬럼으로 PRIMARY KEY 제약을 테이블 변경
-- ddl을 통해 생성
ALTER TABLE emp ADD CONSTRAINT pk_emp_empno PRIMARY KEY(empno);
-- 3. emp 테이블의 dept 컬럼으로 dept 테이블의 deptno 컬럼을
-- 참조하는 fk 제약을 테이블 변경 ddl을 통해 생성
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY(deptno) 
REFERENCES dept(deptno);

-- emp_test -> dept.deptno을 참조하는 fk 제약 생성 (ALTER TABLE)
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
-- CHECK 제약 추가
ALTER TABLE emp_test ADD CONSTRAINT check_ename_len
CHECK (LENGTH(ename) > 3);

SELECT * FROM emp_test;
desc emp_test;
INSERT INTO emp_test VALUES(9999, 'brown', 10);
INSERT INTO emp_test VALUES(9998, 'br', 10);

-- CHECK 제약 제거
ALTER TABLE emp_test DROP CONSTRAINT CHECK_ENAME_LEN;

-- NOT NULL 제약 추가
ALTER TABLE emp_test MODIFY (ename NOT NULL);

-- NOT NULL 제약 조건(NULL 허용)
ALTER TABLE emp_test MODIFY (ename NULL);

