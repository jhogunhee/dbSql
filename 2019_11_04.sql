-- ROUND(��� ����, �ݿø� ��� �ڸ���)
SELECT ROUND(105.54, 1) r1, -- �Ҽ��� ��° �ڸ����� �ݿø�
       ROUND(105.55, 1) r2,  -- �Ҽ��� ��° �ڸ����� �ݿø�
       ROUND(105.55, 0) r3,  -- �Ҽ��� ù° �ڸ����� �ݿø�
       ROUND(105.55, -1) r4  -- ���� ù° �ڸ����� �ݿø�
FROM dual;

desc emp
SELECT empno, ename,sal, sal/1000, qutient, MOD(sal, 1000) reminder
FROM emp;

SELECT
TRUNC(105.54, 1) T1, -- �Ҽ��� �Ѥ� �ڸ����� ����
TRUNC(105.55, 1) T2, -- �Ҽ��� �Ѥ� �ڸ����� ����
TRUNC(105.55, 0) T3, -- �Ҽ��� ù�� �ڸ����� ����
TRUNC(105.55, -1) T4, -- ���� ù�� �ڸ����� ����
TRUNC(115.55, -2) T5  -- ���� ù�� �ڸ����� ����
FROM dual;

-- SYSDATE : ����Ŭ�� ��ġ�� ������ ���� ��¥ + �ð������� �����Ѵ�.
-- ������ ���ڰ� ���� �Լ� / �Լ��� �׽�Ʈ���Ҷ� dual�� �ַ� ���

-- TO_CHAR : DATE Ÿ���� ���ڿ��� ��ȯ
-- ��¥�� ���ڿ��� ��ȯ�ÿ� ������ ����
SELECT to_char(SYSDATE, 'YYYY/MM/DD HH24:MI:SS'),
        to_char(SYSDATE + (1/24/60), 'YYYY/MM/DD HH24:MI:SS')
FROM dual;

-- 1. 2019�� 12�� 31���� DATE������ ǥ��
SELECT TO_DATE('2019/12/31' , 'YYYY/MM/DD')
FROM dual;


-- 2. 2019�� 12�� 31���� date������ ǥ���ϰ� 5�� ���� ��¥
SELECT TO_DATE('2019/12/31' , 'YYYY/MM/DD') -5
FROM dual;

-- 3. ���糯¥
SELECT SYSDATE 
FROM dual;

-- 4. ���糯¥���� 3������
SELECT SYSDATE -3
FROM dual;

-- �� 4�� �÷��� �����Ͽ� ������ ���� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT LAST_DAY(sysdate) LASTDAY, 
       TO_DATE('2019/12/31' , 'YYYY/MM/DD') -5 
       LASTDAY_BEFORE5, SYSDATE, SYSDATE -3
FROM dual;

SELECT LAST_DAY(ADD_MONTHS(sysdate,1))
FROM dual;

SELECT LASTDAY, LASTDAY - 5, NOW, NOW + 5
FROM
            (SELECT TO_DATE('2019/12/31', 'YYYY/MM/DD') LASTDAY,
            SYSDATE NOW
            FROM DUAL);

--date format
--�⵵ : YYYY, YY, RRRR, RR : ���ڸ��ϋ��� 4�ڸ��϶��� �ٸ�
--YYYY, RRRR�� ����
--RR�� 50���� Ŭ��� ���ڸ��� 19�� �ٰ� 50���� �������� 20�� �ٴ´�.
--�������̸� ��������� ǥ��
--D : ������ ���ڷ� ǥ�� ( �Ͽ��� -1, ������ -2, ȭ���� -3, ����� -7)

SELECT to_char(TO_DATE('35/03/01','RR/MM/DD'), 'YYYY/MM/DD') r1,
       to_char(TO_DATE('55/03/01','RR/MM/DD'), 'YYYY/MM/DD') r1,
       to_char(TO_DATE('35/03/01','YY/MM/DD'), 'YYYY/MM/DD') y1,
       TO_CHAR(SYSDATE, 'D') d, --������ �Ͽ��� 1
--       TO_CHAR(SYSDATE, 'D')+1 d, --������ ������ 2 
--       TO_CHAR(SYSDATE, 'D')+2 d, --������ ������ 3
        TO_CHAR(SYSDATE,'IW') IW,  --iw����
       TO_DATE('20191231', 'YYYYMMDD') this_year
FROM dual;

-- ���� ��¥�� ������ ���� �������� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') DT_DASH_WIDTH_TIME, 
       TO_CHAR(SYSDATE, 'HH24:MI:SS') DT_DD_MM_YYYY
FROM dual;

-- ��¥�� �ݿø�(ROUND), ����(TRUNC)
-- ROUND(DATE, '����') YYYY, MM, DD
SELECT ename, 
        to_char(hiredate, 'YYYY/MM/DD HH24:MI:SS') as hiredate,
        to_char(ROUND(hiredate, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as round_MM,
        to_char(ROUND(hiredate-2, 'MM')) as round_mm
FROM emp
WHERE ename = 'SMITH';

-- ADD_MONTHS(DATE, NUMBER)
-- NUMBER���� ������ ��¥
SELECT ADD_MONTHS(sysdate, 3)
FROM dual;

-- ��¥ ���� �Լ�
-- MONTHS_BETWEEN(DATE, DATE) : �� ��¥ ������ ���� �� 
-- 19801217 ~ 20191104 --> 20191117
SELECT ename, to_char(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       round(MONTHS_BETWEEN(SYSDATE, hiredate),0) months_between,
       MONTHS_BETWEEN(TO_DATE('20191117','YYYY-MM-DD'), hiredate) months_between
FROM emp
WHERE ename='SMITH';

--ADD_MONTHS(DATE, ������) : DATE�� �������� ���� ��¥
--�������� ����ϰ�� �̷�, ������ ��� ����
SELECT ename, to_char(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       ADD_MONTHS(hiredate, 467) add_months,
       ADD_MONTHS(hiredate, -467) add_months
FROM emp
WHERE ename='SMITH';

-- NEXT_DAY(DATE, ����) : DATE ���� ù���� ������ ��¥
SELECT SYSDATE, NEXT_DAY(SYSDATE, 7) first_sat, -- ���� ��¥���� ù ����� ����
       SYSDATE, NEXT_DAY(SYSDATE, '�����') first_sat -- ���� ��¥���� ù ����� ���� -> ������ �ٸ��� �����Ƿ� �Ⱦ��°� ����
FROM dual;

-- LAST_DAY(DATE) �ش� ��¥�� ���� ���� ������ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) LAST_DAY, 
       ADD_MONTHS(LAST_DAY(SYSDATE), 1) LAST_DAY_12,
       LAST_DAY(ADD_MONTHS(SYSDATE,1))
FROM dual;

-- DATE + ���� = DATE (DATE���� ������ŭ ������ DATE)
-- D1 + ���� = D2
-- �纯���� D2 ����
-- D1 + ���� - D2 = D2-D2
-- D1 + ���� - D2 = 0
-- D1 + ���� = D2
-- �纯�� D1 ����
-- D1 + ���� -D1 = D2 - D1
-- ���� = D2 - D1
-- ��¥���� ��¥�� ���� ���ڰ� ���´�.

SELECT TO_DATE('20191104', 'YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') as m_day,
       TO_DATE('20191201', 'YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') as m_date,
       ADD_MONTHS(TO_DATE('201602', 'YYYYMM'),1) - TO_DATE('201602', 'YYYYMM')
       -- 201908 : 2019�� 8���� �ϼ� : 31    
FROM dual;

SELECT last_day('20190801')+1 - TO_DATE('20190801', 'YYYYMMDD'),  
       last_day('20190901')+1 - TO_DATE('20190901', 'YYYYMMDD')
FROM dual;



 


            

