SELECT * 
FROM dept;

-- ��ü������ �޿� ���

;

-- �μ��� ������ �޿� ���
SELECT *
FROM 
(SELECT deptno, ROUND(avg(sal), 2) d_avgsal
FROM emp 
GROUP BY deptno)
WHERE d_avgsal > (SELECT ROUND(avg(sal), 2) FROM emp);

-- ���� ���� with���� �����Ͽ�
-- ������ �����ϰ� ǥ���Ѵ�.
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
                  
-- �޷� �����
-- STEP1. �ش� ����� ���� �����
-- CONNECT BY LEVEL

-- �Է¹��� ���� ���� ���ϱ�
SELECT LAST_DAY(sysdate) FROM dual;
SELECT to_date(:YYYYMM,'YYYYMM') + (level-1)
FROM dual
-- 30���� �� ���
CONNECT BY LEVEL <= to_char(LAST_DAY(TO_DATE(:YYYYMM,'YYYYMM')), 'DD'); 

-- iw �������� ����� ��
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
        -- iw�� ����
        TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level -1), 'iw') iw,
        -- d�� day(int�� ����Ǿ�����)
        TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level -1), 'd')d
    FROM dual a
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')),'DD')
) a
GROUP BY decode(d,1,a.iw+1,a.iw)
ORDER BY decode(d,1,a.iw+1,a.iw); --��������¥ (�������� �ٲ�Բ�)
    
-- iw �������� ����� ��
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
        
        -- iw�� ����
        TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level -1), 'iw') iw,
        -- d�� day(int�� ����Ǿ�����)
        TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level -1), 'd')d
    FROM dual a
--    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')),'DD') 
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')),'DD')  
) a
GROUP BY  decode(d,1,a.iw+1,a.iw) 
ORDER BY  decode(d,1,a.iw+1,a.iw); --��������¥ (�������� �ٲ�Բ�)

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

-- ��������
SELECT *
FROM emp;

SELECT *
FROM dept_h;

-- ��������
-- START WITH : ������ ���� �κ��� ����
-- CONNECT BY : ������ ���� ������ ����
-- ����� ��������(���� �ֻ��� ������������ ��� ������ Ž���Ѵ�.)
SELECT LEVEL lv, dept_h.*, LPAD('  ', (LEVEL-1) * 4, ' ') || dept_h.deptnm
FROM dept_h
START WITH deptcd = 'dept0' -- START WITH p_deptcd is null
CONNECT BY PRIOR deptcd = p_deptcd; -- PRIOR ���� ���� �����͸� ǥ��

SELECT LEVEL lv, dept_h.*, LPAD('  ', (LEVEL-1) * 4, ' ') || dept_h.deptnm
FROM dept_h
START WITH deptcd = 'dept0_02' -- START WITH p_deptcd is null
CONNECT BY PRIOR deptcd = p_deptcd; -- PRIOR ���� ���� �����͸� ǥ��

SELECT * 
FROM dept_h
--START WITH p_deptcd is null
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

