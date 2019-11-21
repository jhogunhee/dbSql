SELECT * 
FROM dept;

-- 전체직원의 급여 평균

;

-- 부서별 직원의 급여 평균
SELECT *
FROM 
(SELECT deptno, ROUND(avg(sal), 2) d_avgsal
FROM emp 
GROUP BY deptno)
WHERE d_avgsal > (SELECT ROUND(avg(sal), 2) FROM emp);

-- 쿼리 블럭을 with절에 선언하여
-- 쿼리를 간단하게 표현한다.
WITH dept_avg_sal as  
(
SELECT deptno, ROUND(avg(sal), 2) d_avgsal
FROM emp 
GROUP BY deptno
)
SELECT *
FROM dept_avg_sal
WHERE d_avgsal > (SELECT ROUND(AVG(sal), 2)
                  FROM emp);
                  
-- 달력 만들기
-- STEP1. 해당 년월의 일자 만들기
-- CONNECT BY LEVEL

-- 입력받은 달의 일자 구하기
SELECT LAST_DAY(sysdate) FROM dual;
SELECT to_date(:YYYYMM,'YYYYMM') + (level-1)
FROM dual
-- 30개의 행 출력
CONNECT BY LEVEL <= to_char(LAST_DAY(TO_DATE(:YYYYMM,'YYYYMM')), 'DD'); 

-- iw 주차별로 기록이 됨
SELECT  decode(d,1,a.iw+1,a.iw) iw, 
    MAX(DECODE(D,1,dt)) sun, 
    MAX(DECODE(D,2,dt)) mon, 
    MAX(DECODE(D,3,dt)) tue,
    MAX(DECODE(D,4,dt)) wed, 
    MAX(DECODE(D,5,dt)) thur,
    MAX(DECODE(D,6,dt)) fri,
    MAX(DECODE(D,7,dt)) sat
FROM
(
    SELECT TO_DATE(:YYYYMM, 'YYYYMM') + (level -1) dt,    
        -- iw는 주차
        TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level -1), 'iw') iw,
        -- d는 day(int값 저장되어있음)
        TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level -1), 'd')d
    FROM dual a
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')),'DD')
) a
GROUP BY decode(d,1,a.iw+1,a.iw)
ORDER BY decode(d,1,a.iw+1,a.iw); --마지막날짜 (동적으로 바뀌게끔)
    
-- iw 주차별로 기록이 됨
SELECT   decode(d,1,a.iw+1,a.iw) iw, 
    MAX(DECODE(D,1,dt)) sun, 
    MAX(DECODE(D,2,dt)) mon, 
    MAX(DECODE(D,3,dt)) tue,
    MAX(DECODE(D,4,dt)) wed, 
    MAX(DECODE(D,5,dt)) thur,
    MAX(DECODE(D,6,dt)) fri,
    MAX(DECODE(D,7,dt)) sat
    
FROM
(
    SELECT TO_DATE(:YYYYMM, 'YYYYMM') + (level -1) dt,  
        
        -- iw는 주차
        TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level -1), 'iw') iw,
        -- d는 day(int값 저장되어있음)
        TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level -1), 'd')d
    FROM dual a
--    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')),'DD') 
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')),'DD')  
) a
GROUP BY  decode(d,1,a.iw+1,a.iw) 
ORDER BY  decode(d,1,a.iw+1,a.iw); --마지막날짜 (동적으로 바뀌게끔)

create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

SELECT 
    NVL(MAX(DECODE(TO_CHAR(DT, 'MM'), '01', SUM(SALES))),0) feb,
    NVL(MAX(DECODE(TO_CHAR(DT, 'MM'), '02', SUM(SALES))),0) mar,
    NVL(MAX(DECODE(TO_CHAR(DT, 'MM'), '03', SUM(SALES))),0) apr,
    NVL(MAX(DECODE(TO_CHAR(DT, 'MM'), '04', SUM(SALES))),0) may,
    NVL(MAX(DECODE(TO_CHAR(DT, 'MM'), '05', SUM(SALES))),0) june
FROM sales
group by to_char(dt, 'MM');

SELECT * FROM sales;
        
SELECT DECODE(to_char(dt, 'MM') 
FROM sales
GROUP BY to_char(dt, 'MM');

-- 계층쿼리
SELECT *
FROM emp;

SELECT *
FROM dept_h;

-- 계층쿼리
-- START WITH : 계층의 시작 부분을 정의
-- CONNECT BY : 계층간 연결 조건을 정의
-- 하향식 계층쿼리(가장 최상위 조직에서부터 모든 조직을 탐색한다.)
SELECT LEVEL lv, dept_h.*, LPAD('  ', (LEVEL-1) * 4, ' ') || dept_h.deptnm
FROM dept_h
START WITH deptcd = 'dept0' -- START WITH p_deptcd is null
CONNECT BY PRIOR deptcd = p_deptcd; -- PRIOR 현재 읽은 데이터를 표시

SELECT LEVEL lv, dept_h.*, LPAD('  ', (LEVEL-1) * 4, ' ') || dept_h.deptnm
FROM dept_h
START WITH deptcd = 'dept0_02' -- START WITH p_deptcd is null
CONNECT BY PRIOR deptcd = p_deptcd; -- PRIOR 현재 읽은 데이터를 표시

SELECT * 
FROM dept_h
--START WITH p_deptcd is null
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

