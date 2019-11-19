SELECT *
FROM USER_VIEWS;

-- 만든 뷰 검색하기
SELECT *
FROM ALL_VIEWS
WHERE OWNER = 'PC03';

-- OWNER.VIEW_NAME
SELECT *
FROM PC03.V_EMP_DEPT;

-- PC03 계정에서 조회권한을 받은 V_EMP_DEPT view를 hr 계정에서 조회하기 위해서는
-- 계정명.view이름 형식으로 기술으 해야 한다.
-- 매번 계정명을 기술하기 귀찮으므로 synonym을 통해 다른 별칭을 생성한다.

-- pc03.V_EMP_DEPT 를 V_EMP_DEPT로도 검색이 가능하게 한다.
CREATE SYNONYM V_EMP_DEPT FOR pc03.V_EMP_DEPT;
SELECT *
FROM V_EMP_DEPT;

-- synonym 삭제
DROP SYNONYM V_EMP_DEPT;

-- hr 계정 비밀번호 : java
-- hr 계정 비밀번호 변경 : hr
ALTER USER pc03 IDENTIFIED by java;
-- ALTER USER pc03 IDENTIFIED BY java; -- 본인 계정이 아니라 에러


