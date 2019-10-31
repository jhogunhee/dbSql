-- 부서번호가 30~40사이 같은 부서에 속한 직원
--SELECT * 
--FROM dept
--WHERE deptno BETWEEN 30 AND 40;

-- 부서번호가 30번보다 크거나 같은 부서에 속한 직원
SELECT * 
FROM dept
WHERE deptno >= 30;

-- 부서번호가 30번보다 작은 부서에 속한 직원
SELECT * 
FROM dept
WHERE deptno < 30;

-- dept 테이블의 LOC가 N으로 시작하는 지역
SELECT *
FROM dept
WHERE LOC like 'N%';

-- dept 테이블의 LOC가 K로 끝나는 지역
SELECT *
FROM DEPT
WHERE LOC LIKE '%K';

-- 입사일자가 1982년 1월 1일 이후인 직원 조회
SELECT *
FROM emp
WHERE hiredate >= '1982/01/01';

-- 입사일자가 1982년 1월 1일 이후인 직원 조회
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101','YYYYMMDD');
-- 입사일자가 1982년 1월 1일에서 3월 3일 사이인 직원 조회
SELECT *
FROM emp
WHERE hiredate BETWEEN '1982/01/01' AND '1982/03/03';

-- EMP 테이블의 SAL 가격이 3000원에서 만원사이의 가격만 출력하시오
SELECT *
FROM emp
WHERE SAL BETWEEN 3000 AND 10000;

-- col BETWEEN X AND Y 연산
-- 컬럼의 값이 X보다 크거나 같고, Y보다 작거나 같은 데이터
-- 급여(sal)이 1000보다 크거나 같고 y보다 작거나 같은 데이터를 조회
SELECT *
FROM emp
WHERE SAL BETWEEN 1000 AND 2000
AND DEPTNO = 20;

SELECT *
FROM emp
WHERE SAL BETWEEN 1000 AND 2000;

--위의 BETWEEN AND 연산자는 아래의 <=, >= 조합과 같다.
SELECT *
FROM emp
WHERE sal >= 1000 and sal <= 2000 
and deptno = 30;

-- IN을 사용하여 EMP 테이블의 DEPTNO가 20인 것을 추출하시오
SELECT *
FROM emp
WHERE DEPTNO IN('20');

SELECT ename, hiredate
FROM emp 
WHERE hiredate BETWEEN '1982-01-01' AND '1983-01-01';

SELECT ename, hiredate
FROM emp 
WHERE hiredate BETWEEN to_date('19820101','YYYYMMDD') AND to_date('19830101','YYYYMMDD');

SELECT ename, hiredate
FROM emp 
WHERE hiredate >= to_date('19820101','YYYYMMDD') and hiredate <= to_date('19830101','YYYYMMDD');

-- IN 연산자
-- COL IN(values...)
-- 부서번호가 10 혹은 20인 직원 조회
SELECT *
FROM emp
WHERE deptno = 10 or empno = 20;

SELECT *
FROM emp
WHERE deptno in(10,20);

SELECT userid as 아이디, usernm 이름, filename 별명
FROM users
WHERE userid in('brown','cony','sally');

--COL LIKE 'S%'
--COL의 값이 대문자 S로 시작하는 모든 값
--COL LIKE 'S____'
--COL의 값이 대문자 S로 시작하고 이어서 4개의 문자열이 존재하는 값

--emp 테이블에서 직원이름이 S로 시작하는 모든 직원 조회
SELECT *
FROM emp
WHERE eNAME LIKE 'S%';

--emp 테이블에서 직원이름이 S로 시작하고 5글자인 직원 출력
SELECT *
FROM emp
WHERE eNAME LIKE 'S____';

--member 테이블에서 회원의 성이 신씨인 사람의 mem_id, mem_name을 조회하는 쿼리작성
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

--NULL 비교
--col is null;
--EMP 테이블에서 MGR 정보가 없는 사람(NULL) 조회
SELECT *
FROM emp
WHERE MGR is null;

--소속 부서가 10번이 아닌 직원들
SELECT *
FROM emp
WHERE deptno != '10';

-- emp테이블에서 COMM이 NULL이 아닌것들 출력
SELECT *
FROM emp
WHERE COMM is not null;


-- AND / OR 
-- emp 테이블에서 mgr 사번이 7698이거나
-- 급여가 1000이상인 쿼리
SELECT *
FROM emp
WHERE mgr = 7698 
OR sal >= 1000;

-- emp 테이블에서 관리자 사번이 7698이 아니고, 7839가 아닌 직원들 조회
SELECT *
FROM emp
WHERE MGR NOT IN('7698','7839');

SELECT *
FROM emp
WHERE MGR != 7698 AND MGR != 7839;

--IN, NOT IN 연산자의 NULL 처리
--emp 테이블에서 관리자(mgr) 사번이 7698, 7839가 아니고 null이 아닌 직원들 조회
SELECT * 
FROM emp
WHERE mgr IN('7698','7839')  
AND mgr IS NOT NULL; 

-- emp 테이블에서 job이 SALESMAN이고 입사일자가 1981년 6월 1일 이후인 
-- 직원의 정보를 다음과 같이 조회하세요
SELECT to_char(hiredate, 'YYYY/MM/DD')
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE(19810601, 'YYYYMMDD');

--SELECT *
--FROM emp
--WHERE job = 'SALESMAN' AND hiredate >= TO_DATE(19810601, 'YYYYMMDD');

-- EMP 테이블에서 부서번호가 10이 아니고 입사일자가 1981년 6월
-- 1일 이후인 직원의 정보를 다음과 같이 조회 하세요
SELECT *
FROM emp
WHERE deptno != 10 AND hiredate > TO_DATE('19810601','YYYYMMDD'); 

-- emp 테이블에서 부서번호가 10번이 아니고 입사번호가 1981년 6월
--1일 이후인 직원의 정보를 다음과 같이 조회 하세요
--not in 연산자 사용
SELECT *
FROM emp
WHERE deptno not in(10) and (hiredate > TO_DATE('19810601','YYYYMMDD')); 

-- 10번
SELECT *
FROM emp
WHERE deptno != 10 and (hiredate > TO_DATE('19810601','YYYYMMDD')); 

-- 11번
SELECT *
FROM emp
WHERE job = 'SALESMAN' or (hiredate > TO_DATE('19810601','YYYYMMDD'));

-- 12번
SELECT *
FROM emp
WHERE job like 'SALESMAN' or DEPTNO = 30;

-- 13번
SELECT *
FROM emp
WHERE job = 'SALESMAN' or empno between 7800 and 7899; 

SELECT *
FROM emp;

desc emp;
insert into emp values(785,'smit','clerk',7999,'1981/12/17',800,300,20);

-- 14번
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%'
and hiredate > TO_DATE('19810601','YYYYMMDD');



