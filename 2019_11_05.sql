SELECT to_char('20191111','YYYYMMDD')
FROM dual;

-- 년월 파라미터가 주어졌을떄 해당년월의 일수를 구하는 문제
-- 2019 --> 30 / 2019 --> 31

-- 한달 더한후 원래값을 빼면 = 일수
-- 마지막날짜 구한후 --> DD만 추출
SELECT to_char(LAST_DAY(TO_DATE('201911', 'YYYYMM')), 'DD')
FROM dual;

SELECT LAST_DAY((to_char(hiredate, 'YYYY-MM-DD')))
FROM emp;

SELECT hiredate, to_char(LAST_DAY((to_char(hiredate, 'YYYY-MM-DD'))),'DD') lastDay
FROM emp;

SELECT : yyyymm as param,TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') dt
FROM dual;

SELECT sysdate, TO_CHAR(:yyyymm,'DD')
FROM dual;

explain plan for
SELECT *
FROM emp
WHERE empno = '7369';

SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT empno, ename, sal, TO_CHAR(sal, 'L999,999.99') sal_fmt
FROM emp;

-- 현재달 1일 구하기
SELECT trunc(sysdate,'MM') 
FROM dual;

-- function null
-- nv1(col1, null일 경우 대체할 값)
SELECT sal,empno, ename, comm, nvl(comm + sal, 0),
       empno + nvl(comm, 0), sal + nvl(comm,0)
FROM emp;

SELECT NVL(comm, 0)
FROM emp;

-- NVL2(col1, col1이 null이경우 표현되는 값, col1 null일 아닐 경우 표현 되는 값)
SELECT empno, ename, sal, comm, NVL2(comm, comm, 0) + sal
FROM emp;

-- NULLIF(expr1, expr2)
-- expr1 == expr2 같으면 null
-- else : expr1
SELECT empno, ename, sal, comm, NULLIF(sal, 1250)
FROM emp;

-- COALESCE(expr1, expr2, expr3 ....)
-- 함수 인자중 null이 아닌 첫번쨰 인자
-- comm가 null일떄는 sal이 comm가 있을떄는 comm이
SELECT empno, ename, sal, comm, coalesce(comm, sal)
FROM emp;

SELECT empno, ename, mgr, nvl(mgr, 9999) MGR_N, NVL2(mgr, mgr, 9999) as MGR_N_1, coalesce(MGR, 9999) MGR_N_2
FROM emp;

SELECT to_char(LAST_DAY(SYSDATE),'DD')+1 - to_char((trunc(SYSDATE, 'MM')),'DD') as Day
FROM dual;

SELECT LAST_DAY(:YYYYMMDD)
FROM dual;

SELECT COALESCE(sal, sal, 5)
FROM emp;

SELECT *
FROM users;

SELECT USERID, USERNM, REG_DT, NVL(REG_DT, sysdate) n_reg_dt
FROM users;

-- case when
SELECT empno, ename, job, sal,
        case
            when job = 'SALESMAN' then sal*1.05 
            when job = 'MANAGER' then sal*1.10
            when job = 'PRESIDENT' then sal*1.10
            else sal
        end as next_salary,
        
        DECODE(job, 'SALESMAN', SAL * 1.05,
                'MANAGER', SAL * 1.1,
                'PRESIDENT', SAL * 1.20,
                SAL) decode_sal
FROM emp;

--decode(col, search1, return1, search2, return2......... default)
SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN', SAL * 1.05,
                'MANAGER', SAL * 1.1,
                'PRESIDENT', SAL * 1.20,
                SAL) decode_sal 
FROM emp;
                   
SELECT * 
FROM emp;

SELECT empno, ename, Ename,
    DECODE(deptno, '10', 'ACCOUNTING',
                   '20', 'RESEARCH',
                   '30', 'SALES',
                   '40','OPERATIONS',
                   'DDIT')                   
FROM emp;

SELECT empno, ename, Ename,
    CASE
        WHEN deptno = 10 then 'ACCOUNTING'
        WHEN deptno = 20 then 'RESEARCH'
        WHEN deptno = 30 then 'SALES'
        WHEN deptno = 40 then 'OPERATIONS'
        ELSE 'DDIT'
    end
FROM emp;    

SELECT *
FROM emp;

SELECT EMPNO,ENAME, HIREDATE, 
    CASE
        WHEN MOD(to_char(hiredate, 'YYYY'),2) = 0 then '건강검진 대상자'
        WHEN MOD(to_char(hiredate, 'YYYY'),2) = 1 then '건강검진 비대상자'
    END          
        
FROM emp;

SELECT EMPNO,ENAME, HIREDATE, 
    CASE
        WHEN MOD(to_char(SYSDATE, 'YYYY') - to_char(hiredate, 'YYYY'), 2) = 0  then '건강검진 대상자'
        else '건강검진 비대상자'    
    END                  
FROM emp;

SELECT empno, ename, Ename, deptno,
    DECODE(deptno, '10', 'ACCOUNTING',
                   '20', 'RESEARCH',
                   '30', 'SALES',
                   '40','OPERATIONS',
                   'DDIT')                   
FROM emp;

-- 올해수는 짝수인가? 홀수인가?
-- 2. 올해 년도가 짝수인지 계산
-- 어떤수를 2로 나누면 나머지는 항상 2보다 작다.
-- 2로 나눌경우 나머지는 0, 1
-- MOD(대상, 나눌값)
SELECT MOD(to_char(SYSDATE,'YYYY'), 2)
FROM DUAL;

-- EMP 테이블에서 입사일자가 홀수년인지 짝수년인지 확인
SELECT MOD(to_char(hiredate,'YYYY'), 2)
FROM emp;

SELECT EMPNO,ENAME, HIREDATE, 
    CASE
        WHEN MOD(to_char(SYSDATE,'YYYY'), 2) = MOD(to_char(hiredate,'YYYY'), 2) then '건강검진 대상자'
        else '건강검진 비대상자'    
    END contact_to_doctor                
FROM emp;

SELECT userid, usernm, alias, reg_dt,
       CASE
          WHEN MOD(to_char(SYSDATE,'YYYY'), 2) = MOD(to_char(REG_DT,'YYYY'), 2) then '건강검진 대상자'
          else '건강검진 비대상자'
       END          
FROM users;

--DECODE(deptno, '10', 'ACCOUNTING',
--                   '20', 'RESEARCH',
--                   '30', 'SALES',
--                   '40','OPERATIONS',
--                   'DDIT')      
SELECT userid, usernm, alias, reg_dt,
       DECODE(MOD(to_char(SYSDATE, 'YYYY') - to_char(REG_DT, 'YYYY'), 2), 0, '건강검진 대상자',
                                                                        '건강검진 비대상자')
FROM users;

-- 그룹함수 ( AVG, MAX, MIN, SUM, COUNT)
-- 그룹함수는 NNULL값을 계산대상에서 제외한다.
-- SUM(comm), COUNT(*), COUNT(mgr)
-- 직원중 가장 높은 급여를 받는사람
-- 직원중 가장 낮은 급여를 받는 사람
SELECT *
FROM emp;

-- 직원의 급여 평균
-- 직원의 급여 전체합
-- 직원의 수
SELECT MAX(SAL) max_sal, MIN(SAL) MIN_SAL,
       ROUND(AVG(sal),2) avg_sal,
       SUM(SAL) SUM_SAL,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm)
FROM emp;

SELECT empno, ename, sal
FROM emp
ORDER BY sal;

-- 부서별 가장 높은 급여를 받는 사람의 급여
-- group by절에 기술되지 않은 컬럼이 SELECT 절에 기술될 경우 에러
-- 그룹화와 관련없는 임의의 문자열, 상수는 올 수 있다.
SELECT deptno, MAX(SAL) max_sal, MIN(SAL) MIN_SAL,
       ROUND(AVG(sal),2) avg_sal,
       SUM(SAL) SUM_SAL,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm)
FROM emp
GROUP BY deptno;

SELECT deptno, max(sal)
FROM emp
GROUP BY deptno
having max(sal) >= 3000;

SELECT max(sal), min(sal), ROUND(avg(sal),2), 
       sum(sal), count(sal), count(mgr), count(*)
FROM emp;

SELECT deptno,max(sal), min(sal), ROUND(avg(sal),2), 
       sum(sal), count(sal), count(mgr), count(*)
FROM emp
group by deptno;
    
