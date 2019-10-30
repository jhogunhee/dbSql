-- select : 조회할 컬럼 명시
--          -전체 컬럼 조회 : *
--          -일부 컬럼 : 해당 컬럼명 나열 (,구분)
--FROM : 조회할 테이블 명시
--SELECT * 
--FROM user_users
-- 쿼리를 여러줄에 나누어서 작성해도 상관없다.
-- 단 keyword는 붙여서 작성

--SELECT * FROM prod;

--select * 
--from user_users;

--특정 컬럼만 조회
--SELECT prod_id, prod_name
--FROM prod;

--1. prod 테이블의 모든 컬럼조회
--SELECT * FROM prod;

--2. buyer 테이블에서 buyer_id, buyer_name 컬럼만 조회하는 쿼리를 작성하세요
--SELECT buyer_id, buyer_name FROM buyer;

--3. cart 테이블에서 모든 데이터를 조회하는 쿼리를 작성하세요
--SELECT * FROM cart;

--4. member 테이블에서 mem_id, mem_pass mem_name 컬럼만 조회하는 쿼리를 작성하세요
--SELECT mem_id, mem_pass, mem_name FROM member;

--5. remain 테이블에서 remain_year, remain_prod, remain_date 컬럼만 조회하는 쿼리를 작성하세요
--SELECT remain_year, remain_prod, remain_date FROM remain;

--연산자 / 날짜연산
--date type + 정수 : 일자를 더한다.
--SELECT userid, usernm, reg_dt, 
--        reg_dt + 5 reg_dt_after5,
--        reg_dt -5 as reg_dt_before5
--FROM users;

--DELETE USERS
--WHERE userid not in ('brown', 'cony', 'sally', 'james', 'moon');

--SELECT * FROM USERS;
--commit;

-- 1번
SELECT prod_id id, prod_name name FROM prod;

-- 2번
SELECT * FROM lprod;
SELECT lprod_gu gu, lprod_nm nm FROM lprod;

SELECT buyer_id 바이어아이디, buyer_name 이름 FROM buyer;

-- 문자열 결합
-- java + --> sql ||
-- users테이블의 userid, usernm
-- CONCAT(str, str) 함수

SELECT * FROM users;
SELECT userid, usernm,
       userid || usernm,
       CONCAT(userid, usernm)
FROM users;

-- 문자열 상수(컬럼에 담긴 데이터가 아니라 개발자가 직접 입력한 문자열)
--SELECT '사용자 아이디 : ' || userid
SELECT CONCAT('사용자 아이디 : ', userid)
FROM users;

--실습 sel_con1
SELECT 'SELECT * FROM ' || table_name || ';' QUERY
FROM user_tables;

SELECT * FROM user_tables;
SELECT CONCAT('SELECT * FROM ',table_name) || ';' as QUERY
FROM user_tables;

desc emp;
-- 1. desc
-- 2. select * ....

-- where절 조건 연산자
SELECT *
FROM users
WHERE userid = 'brown';

--usernm이 샐리인 데이터를 조회하는 쿼리를 작성
SELECT *
FROM users
WHERE usernm = '샐리';