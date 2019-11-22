SELECT level, LPAD(' ', 4*(level-1), ' ') deptnm, p_deptcd
FROM dept_h a
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

-- 상향식 계층쿼리
-- 특정 노드로부터 자신의 부모노드를 탐색(트리 전체 탐색이 아니다.)
-- 디자인팀을 시작으로 상위 부서를 조회

SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

--SELECT LPAD(s_id , 4*(level-1), ' ') s_id, value
SELECT LPAD(' ', 4*(level-1), ' ') || s_id s_id, value
FROM h_sum
START WITH s_id = 0
CONNECT BY PRIOR s_id = ps_id;

SELECT * FROM h_sum;

SELECT * 
FROM no_emp;

-- LPAD ('값', '총 문자길이', '채움문자')
-- 하향식 계층쿼리
SELECT LPAD(' ', 4*(level-1), ' ') || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

-- 상향식 계층쿼리
SELECT LPAD(' ', 4*(level-1), ' ') || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = '디자인팀'
CONNECT BY PRIOR parent_org_cd = org_cd;

SELECT *
FROM no_emp;

-- pruning branch (가지치기)
-- 계층쿼리에서 [where]wjfdms START WITH, CONNECT BY 절이 전부 적용된 이후에
-- 실행된다

-- 계층쿼리가 완성된 이후 WHERE절이 적용된다.
-- 하향식 쿼리
SELECT deptcd, LPAD(' ', 4*(level-1), ' ') || deptnm deptnm
FROM dept_h
--WHERE deptnm != '정보기획부'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd
AND deptnm != '정보기획부';

SELECT *
FROM dept_h;

SELECT deptcd, LPAD(' ', 4*(level-1), ' ') || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0_00_0_0'
CONNECT BY PRIOR p_deptcd = deptcd;

-- CONNECT_BY_ROOT(col) : col의 최상위 노드 컬럼 값
-- SYS_CONNECT_BY_PATH(col, 구분자) : col의 계층구조 순서를 구분자로 이은 경로
-- CONNECT_BY_ISLEAF : 해당 ROW가 leaf node인지 판별(1은 리프노드 0은 리프노드 x (부모있음))
-- LTRIM을 통해 최상위 노드 왼쪽의 구분자를 없애 주는 형태가 일반적이다.
SELECT LPAD(' ', 4*(level-1), ' ') || org_cd org_cd,
       CONNECT_BY_ROOT(org_cd) root_org_cd,
       LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'),'-') path_org_cd ,
       CONNECT_BY_ISLEAF is_leaf
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
SELECT * from board_test; 
insert into board_test values (1, null, '첫번째 글입니다');
insert into board_test values (2, null, '두번째 글입니다');
insert into board_test values (3, 2, '세번째 글은 두번째 글의 답글입니다');
insert into board_test values (4, null, '네번째 글입니다');
insert into board_test values (5, 4, '다섯번째 글은 네번째 글의 답글입니다');
insert into board_test values (6, 5, '여섯번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (7, 6, '일곱번째 글은 여섯번째 글의 답글입니다');
insert into board_test values (8, 5, '여덜번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (9, 1, '아홉번째 글은 첫번째 글의 답글입니다');
insert into board_test values (10, 4, '열번째 글은 네번째 글의 답글입니다');
insert into board_test values (11, 10, '열한번째 글은 열번째 글의 답글입니다');
commit;

SELECT seq, LPAD(' ', 4*(level-1), ' ') || title
FROM board_test
start with parent_seq is null
CONNECT BY prior seq = parent_seq;

SELECT seq, LPAD(' ', 4*(level-1), ' ') || title title, level
FROM board_test
start with parent_seq is null
CONNECT BY prior seq = parent_seq
order siblings by seq desc;

SELECT seq, LPAD(' ', 4*(level-1), ' ') || title title,
        CASE WHEN parent_seq is null then seq ELSE 0 end o1
        
FROM board_test
start with parent_seq is null
CONNECT BY prior seq = parent_seq
order siblings by CASE WHEN parent_seq is null then seq end desc, seq;

SELECT *
FROM board_test;

-- 글 그룹번호 컬럼 추가
ALTER TABLE board_test ADD (gn NUMBER);

SELECT seq, LPAD(' ', 4*(level-1), ' ') || title title
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn desc, seq;

-- h6
SELECT *
FROM board_test;

SELECT e.ename, e.sal, rownum rn
FROM emp e,
    (SELECT em.*,rownum rn2
     FROM
        (SELECT ename, sal
        FROM emp
        order by sal desc) em
    ) em2 
WHERE e.rn = em2.rn2;
--WHERE e.rn =

SELECT * from emp;





