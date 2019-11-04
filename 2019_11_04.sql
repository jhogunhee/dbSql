-- ROUND(대상 숫자, 반올림 결과 자리수)
SELECT ROUND(105.54, 1) r1, -- 소수점 둘째 자리에서 반올림
       ROUND(105.55, 1) r2,  -- 소수점 둘째 자리에서 반올림
       ROUND(105.55, 0) r3,  -- 소수점 첫째 자리에서 반올림
       ROUND(105.55, -1) r4  -- 정수 첫째 자리에서 반올림
FROM dual;

desc emp
SELECT empno, ename,sal, sal/1000, qutient, MOD(sal, 1000) reminder
FROM emp;

SELECT
TRUNC(105.54, 1) T1, -- 소수점 둘쨰 자리에서 절삭
TRUNC(105.55, 1) T2, -- 소수점 둘쨰 자리에서 절삭
TRUNC(105.55, 0) T3, -- 소수점 첫쨰 자리에서 절삭
TRUNC(105.55, -1) T4, -- 정수 첫쨰 자리에서 절삭
TRUNC(115.55, -2) T5  -- 정수 첫쨰 자리에서 절삭
FROM dual;

-- SYSDATE : 오라클이 설치된 서버의 현재 날짜 + 시간정보를 리턴한다.
-- 별도의 인자가 없는 함수 / 함수를 테스트를할때 dual을 주로 사용

-- TO_CHAR : DATE 타입을 문자열로 변환
-- 날짜를 문자열로 변환시에 포맷을 지정
SELECT to_char(SYSDATE, 'YYYY/MM/DD HH24:MI:SS'),
        to_char(SYSDATE + (1/24/60), 'YYYY/MM/DD HH24:MI:SS')
FROM dual;

-- 1. 2019년 12월 31일을 DATE형으로 표현
SELECT TO_DATE('2019/12/31' , 'YYYY/MM/DD')
FROM dual;


-- 2. 2019년 12월 31일을 date형으로 표현하고 5일 이전 날짜
SELECT TO_DATE('2019/12/31' , 'YYYY/MM/DD') -5
FROM dual;

-- 3. 현재날짜
SELECT SYSDATE 
FROM dual;

-- 4. 현재날짜에서 3일전값
SELECT SYSDATE -3
FROM dual;

-- 위 4개 컬럼을 생성하여 다음과 같이 조회하는 쿼리를 작성하세요
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
--년도 : YYYY, YY, RRRR, RR : 두자리일떄랑 4자리일때랑 다름
--YYYY, RRRR은 동일
--RR은 50보다 클경우 앞자리는 19가 붙고 50보다 작을때는 20이 붙는다.
--가급적이면 명시적으로 표현
--D : 요일을 숫자로 표기 ( 일요일 -1, 월요일 -2, 화요일 -3, 토요일 -7)

SELECT to_char(TO_DATE('35/03/01','RR/MM/DD'), 'YYYY/MM/DD') r1,
       to_char(TO_DATE('55/03/01','RR/MM/DD'), 'YYYY/MM/DD') r1,
       to_char(TO_DATE('35/03/01','YY/MM/DD'), 'YYYY/MM/DD') y1,
       TO_CHAR(SYSDATE, 'D') d, --오늘은 일요일 1
--       TO_CHAR(SYSDATE, 'D')+1 d, --오늘은 월요일 2 
--       TO_CHAR(SYSDATE, 'D')+2 d, --오늘은 월요일 3
        TO_CHAR(SYSDATE,'IW') IW,  --iw주차
       TO_DATE('20191231', 'YYYYMMDD') this_year
FROM dual;

-- 오늘 날짜를 다음과 같은 포맷으로 조회하는 쿼리를 작성하세요
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') DT_DASH_WIDTH_TIME, 
       TO_CHAR(SYSDATE, 'HH24:MI:SS') DT_DD_MM_YYYY
FROM dual;

-- 날짜의 반올림(ROUND), 절삭(TRUNC)
-- ROUND(DATE, '포맷') YYYY, MM, DD
SELECT ename, 
        to_char(hiredate, 'YYYY/MM/DD HH24:MI:SS') as hiredate,
        to_char(ROUND(hiredate, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as round_MM,
        to_char(ROUND(hiredate-2, 'MM')) as round_mm
FROM emp
WHERE ename = 'SMITH';

-- ADD_MONTHS(DATE, NUMBER)
-- NUMBER개월 이후의 날짜
SELECT ADD_MONTHS(sysdate, 3)
FROM dual;

-- 날짜 연산 함수
-- MONTHS_BETWEEN(DATE, DATE) : 두 날짜 사이의 개월 수 
-- 19801217 ~ 20191104 --> 20191117
SELECT ename, to_char(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       round(MONTHS_BETWEEN(SYSDATE, hiredate),0) months_between,
       MONTHS_BETWEEN(TO_DATE('20191117','YYYY-MM-DD'), hiredate) months_between
FROM emp
WHERE ename='SMITH';

--ADD_MONTHS(DATE, 개월수) : DATE에 개월수가 지난 날짜
--개월수가 양수일경우 미래, 음수일 경우 과거
SELECT ename, to_char(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       ADD_MONTHS(hiredate, 467) add_months,
       ADD_MONTHS(hiredate, -467) add_months
FROM emp
WHERE ename='SMITH';

-- NEXT_DAY(DATE, 요일) : DATE 이후 첫번쨰 요일의 날짜
SELECT SYSDATE, NEXT_DAY(SYSDATE, 7) first_sat, -- 오늘 날짜이후 첫 토요일 일자
       SYSDATE, NEXT_DAY(SYSDATE, '토요일') first_sat -- 오늘 날짜이후 첫 토요일 일자 -> 툴마다 다르게 먹히므로 안쓰는게 나음
FROM dual;

-- LAST_DAY(DATE) 해당 날짜가 속한 월의 마지막 일자
SELECT SYSDATE, LAST_DAY(SYSDATE) LAST_DAY, 
       ADD_MONTHS(LAST_DAY(SYSDATE), 1) LAST_DAY_12,
       LAST_DAY(ADD_MONTHS(SYSDATE,1))
FROM dual;

-- DATE + 정수 = DATE (DATE에서 정수만큼 이후의 DATE)
-- D1 + 정수 = D2
-- 양변에서 D2 차감
-- D1 + 정수 - D2 = D2-D2
-- D1 + 정수 - D2 = 0
-- D1 + 정수 = D2
-- 양변에 D1 차감
-- D1 + 정수 -D1 = D2 - D1
-- 정수 = D2 - D1
-- 날짜에서 날짜를 뺴면 일자가 나온다.

SELECT TO_DATE('20191104', 'YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') as m_day,
       TO_DATE('20191201', 'YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') as m_date,
       ADD_MONTHS(TO_DATE('201602', 'YYYYMM'),1) - TO_DATE('201602', 'YYYYMM')
       -- 201908 : 2019년 8월의 일수 : 31    
FROM dual;

SELECT last_day('20190801')+1 - TO_DATE('20190801', 'YYYYMMDD'),  
       last_day('20190901')+1 - TO_DATE('20190901', 'YYYYMMDD')
FROM dual;



 


            

