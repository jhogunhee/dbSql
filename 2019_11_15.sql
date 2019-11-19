SELECT SUM(sal)
FROM emp;

-- emp 테이블에 empno컬럼을 기준으로 primary key를 생성
-- PRIMARY KEY = UNIQUE + NOT NULL
-- UNIQUE ==> 해당 컬럼으로 UNIQUE INDEX를 자동으로 생성

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

-- empno 컬럼으로 인덱스가 존재하는 상황애ㅐ서
-- 다른컬럼 값으로 데이터를 조회 하는 경우
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

-- EXPLAIN PLAN FOR -> TABLE(dbms_xplan.display);

-- 인덱스 구성 컬럼만 SELECT절에 기술한 경우
-- 테이블 접근이 필요 없다.

EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

-- 컬럼에 중복이 가능한 non-unique 인덱스 생성후
-- unique index와의 실행계획 비교
-- PRIMARY KEY 제약조건 삭제(unique 인덱스 삭제)
ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE /*UNIQUE*/ INDEX IDX_emp_01 ON emp(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE(dbms_xplan.display);

-- emp 테이블에 job 컬럼으로 두번쨰 인덱스 생성 (non-unique index)
-- job 컬럼은 다른 로우의 job 컬럼과 중복이 가능한 컬럼이다.
CREATE INDEX idx_emp_02 ON emp (job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'manager';

-- UNIQUE 인덱스로 만들지 않았기 때문에 RANGE SCAN이 나온다.
-- UNIQUE로 만들시에는 INDEX ? SCAN
SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

-- ename은 테이블에 접근해야지만 알 수 있음
-- p376
SELECT *
FROM TABLE(dbms_xplan.display);

-- emp 테이블에 job, ename 컬럼을 기준으로 non-unique 인덱스 생성
CREATE INDEX IDX_emp_03 ON emp (job, ename);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

-- emp 테이블에 ename, job 컬럼으로 non-unique 인덱스 생성
CREATE INDEX IDX_EMP_04 ON emp (ename, job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

-- HINT를 사용한 실행계획 제어
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

-- 실습 idx1에서 생성한 인덱스를 삭제하는 DDL
drop index idx_dname;
drop index idx_deptno;
drop index idx_deptno_dname;

-- INDEX 실습 idx 3
-- 시스템에서 사용하는 쿼리가 다음과 같다고 할때 적절한
-- emp 테이블에 필요하다고 생각되는 인덱스를 
-- 생성 스크립트를  만들어 보세요
SELECT * FROM emp;
--CREATE INDEX IDX_EMP_01 on emp(empno);
CREATE INDEX IDX_EMP_02 on emp(ename);
CREATE INDEX IDX_EMP_03 on emp(deptno);
commit;
