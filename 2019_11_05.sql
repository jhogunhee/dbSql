SELECT to_char('20191111','YYYYMMDD')
FROM dual;

-- ��� �Ķ���Ͱ� �־������� �ش����� �ϼ��� ���ϴ� ����
-- 2019 --> 30 / 2019 --> 31

-- �Ѵ� ������ �������� ���� = �ϼ�
-- ��������¥ ������ --> DD�� ����
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

-- ����� 1�� ���ϱ�
SELECT trunc(sysdate,'MM') 
FROM dual;

-- function null
-- nv1(col1, null�� ��� ��ü�� ��)
SELECT sal,empno, ename, comm, nvl(comm + sal, 0),
       empno + nvl(comm, 0), sal + nvl(comm,0)
FROM emp;

SELECT NVL(comm, 0)
FROM emp;

-- NVL2(col1, col1�� null�̰�� ǥ���Ǵ� ��, col1 null�� �ƴ� ��� ǥ�� �Ǵ� ��)
SELECT empno, ename, sal, comm, NVL2(comm, comm, 0) + sal
FROM emp;

-- NULLIF(expr1, expr2)
-- expr1 == expr2 ������ null
-- else : expr1
SELECT empno, ename, sal, comm, NULLIF(sal, 1250)
FROM emp;

-- COALESCE(expr1, expr2, expr3 ....)
-- �Լ� ������ null�� �ƴ� ù���� ����
-- comm�� null�ϋ��� sal�� comm�� �������� comm��
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
        WHEN MOD(to_char(hiredate, 'YYYY'),2) = 0 then '�ǰ����� �����'
        WHEN MOD(to_char(hiredate, 'YYYY'),2) = 1 then '�ǰ����� ������'
    END          
        
FROM emp;

SELECT EMPNO,ENAME, HIREDATE, 
    CASE
        WHEN MOD(to_char(SYSDATE, 'YYYY') - to_char(hiredate, 'YYYY'), 2) = 0  then '�ǰ����� �����'
        else '�ǰ����� ������'    
    END                  
FROM emp;

SELECT empno, ename, Ename, deptno,
    DECODE(deptno, '10', 'ACCOUNTING',
                   '20', 'RESEARCH',
                   '30', 'SALES',
                   '40','OPERATIONS',
                   'DDIT')                   
FROM emp;

-- ���ؼ��� ¦���ΰ�? Ȧ���ΰ�?
-- 2. ���� �⵵�� ¦������ ���
-- ����� 2�� ������ �������� �׻� 2���� �۴�.
-- 2�� ������� �������� 0, 1
-- MOD(���, ������)
SELECT MOD(to_char(SYSDATE,'YYYY'), 2)
FROM DUAL;

-- EMP ���̺��� �Ի����ڰ� Ȧ�������� ¦�������� Ȯ��
SELECT MOD(to_char(hiredate,'YYYY'), 2)
FROM emp;

SELECT EMPNO,ENAME, HIREDATE, 
    CASE
        WHEN MOD(to_char(SYSDATE,'YYYY'), 2) = MOD(to_char(hiredate,'YYYY'), 2) then '�ǰ����� �����'
        else '�ǰ����� ������'    
    END contact_to_doctor                
FROM emp;

SELECT userid, usernm, alias, reg_dt,
       CASE
          WHEN MOD(to_char(SYSDATE,'YYYY'), 2) = MOD(to_char(REG_DT,'YYYY'), 2) then '�ǰ����� �����'
          else '�ǰ����� ������'
       END          
FROM users;

--DECODE(deptno, '10', 'ACCOUNTING',
--                   '20', 'RESEARCH',
--                   '30', 'SALES',
--                   '40','OPERATIONS',
--                   'DDIT')      
SELECT userid, usernm, alias, reg_dt,
       DECODE(MOD(to_char(SYSDATE, 'YYYY') - to_char(REG_DT, 'YYYY'), 2), 0, '�ǰ����� �����',
                                                                        '�ǰ����� ������')
FROM users;

-- �׷��Լ� ( AVG, MAX, MIN, SUM, COUNT)
-- �׷��Լ��� NNULL���� ����󿡼� �����Ѵ�.
-- SUM(comm), COUNT(*), COUNT(mgr)
-- ������ ���� ���� �޿��� �޴»��
-- ������ ���� ���� �޿��� �޴� ���
SELECT *
FROM emp;

-- ������ �޿� ���
-- ������ �޿� ��ü��
-- ������ ��
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

-- �μ��� ���� ���� �޿��� �޴� ����� �޿�
-- group by���� ������� ���� �÷��� SELECT ���� ����� ��� ����
-- �׷�ȭ�� ���þ��� ������ ���ڿ�, ����� �� �� �ִ�.
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
    
