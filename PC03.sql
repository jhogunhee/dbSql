-- SELECT절 컬럼 순서 인덱스로 정렬
SELECT empno, ename, sal, sal * 12 as year_sal
FROM emp
ORDER BY 4;

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

SELECT *
FROM emp
WHERE comm is not null
ORDER BY comm DESC, empno ASC;

-- orderby 3
SELECT *
FROM emp
WHERE mgr is not null
ORDER BY job, empno desc;

-- order by 4
SELECT *
FROM emp
WHERE (deptno = 10 or deptno = 30) and sal > 1500
ORDER BY ename desc;

desc emp;
SELECT ROWNUM, empno, ename
FROM emp
WHERE rownum between 1 and 8;

SELECT ROWNUM, empno, ename
FROM emp
WHERE rownum = 1;


-- 매니저가 없는 값을 0으로 바꾸어서 출력하는 예제.
SELECT deptno, empno, NVL(mgr, 0)
  FROM emp  
 WHERE deptno = 10;
 
--emp 테이블에서 사번(empno), 이름(ename)을 급여 기준으로 오름차순 정렬하고
--정렬된 결과순으로 ROWNUM
SELECT *
FROM emp;
ORDER BY sal;

SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp 
ORDER BY sal) a;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

SELECT ROWNUM, a.* 
FROM emp a;

SELECT *
FROM emp;

SELECT *
FROM (
    SELECT rownum rnum, t1.*
    from emp t1    
    order by sal
)
where rnum between 11 and 20;

SELECT *
FROM
(SELECT ROWNUM rn, B.* FROM (SELECT empno, ename, sal FROM emp ORDER BY sal) B)
WHERE rn >= 11 and rn <= 20;

SELECT empno, ename, sal FROM emp ORDER BY sal;

--FUNCTION
--DUAL 테이블 조회
SELECT 'HELLO WORLD' as msg
FROM dual;

SELECT 'HELLO WORLD'
FROM emp;

-- 문자열 대소문자 관련 함수
-- LOWER, UPPER, INITCAP
SELECT LOWER('Hello, World'), UPPER('Hello, World'),
INITCAP('hello, world')
FROM emp
where job = 'SALESMAN';

--FUNCTION은 WHERE절에서도 사용가능
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

-- 개발자 SQL 칠거지악
-- 1. 좌변을 가공하지 말아라
-- 좌변(TABLE의 컬럼)을 가공하게 되면 INDEX를 정상적으로 사용하지 못함
-- Function Based Index -> FBI

-- CONCAT : 문자열 결합
-- SUBSTR : 문자열의 부분 스트링(java : String.substring)
-- INSTR : 문자열에 특정 문자열이 등장하는 첫번쨰 인덱스
-- LPAD : 문자열에 특정 문자열을 삽입

SELECT CONCAT(CONCAT('HELLO',', '),'WORLD') CONCAT
FROM dual;

SELECT CONCAT(CONCAT('HELLO',', '), 'WORLD') CONCAT,
       SUBSTR('HELLO, WORLD', 0, 5) substr,
       SUBSTR('HELLO, WORLD', 1, 5) substr1,
       LENGTH('HELLO, WORLD') length,
       -- INSTR(문자열, 찾을 문자열, 문자열의 특정 위치 이후 표시)
       INSTR('HELLO, WORLD', 'O', 6), 
       
       -- LPAD(문자열, 전체 문자열길이, 문자열이 전체문자열길이에 미치지 못할경우 추가할 문자)
       LPAD('HELLO, WORLD', 15, ' '),
       RPAD('HELLO, WORLD', 15, ' ')
FROM dual;


