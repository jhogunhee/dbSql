SELECT level, LPAD(' ', 4*(level-1), ' ') deptnm, p_deptcd
FROM dept_h a
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

-- ����� ��������
-- Ư�� ���κ��� �ڽ��� �θ��带 Ž��(Ʈ�� ��ü Ž���� �ƴϴ�.)
-- ���������� �������� ���� �μ��� ��ȸ

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

-- LPAD ('��', '�� ���ڱ���', 'ä����')
-- ����� ��������
SELECT LPAD(' ', 4*(level-1), ' ') || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

-- ����� ��������
SELECT LPAD(' ', 4*(level-1), ' ') || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = '��������'
CONNECT BY PRIOR parent_org_cd = org_cd;

SELECT *
FROM no_emp;

-- pruning branch (����ġ��)
-- ������������ [where]wjfdms START WITH, CONNECT BY ���� ���� ����� ���Ŀ�
-- ����ȴ�

-- ���������� �ϼ��� ���� WHERE���� ����ȴ�.
-- ����� ����
SELECT deptcd, LPAD(' ', 4*(level-1), ' ') || deptnm deptnm
FROM dept_h
--WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd
AND deptnm != '������ȹ��';

SELECT *
FROM dept_h;

SELECT deptcd, LPAD(' ', 4*(level-1), ' ') || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0_00_0_0'
CONNECT BY PRIOR p_deptcd = deptcd;

-- CONNECT_BY_ROOT(col) : col�� �ֻ��� ��� �÷� ��
-- SYS_CONNECT_BY_PATH(col, ������) : col�� �������� ������ �����ڷ� ���� ���
-- CONNECT_BY_ISLEAF : �ش� ROW�� leaf node���� �Ǻ�(1�� ������� 0�� ������� x (�θ�����))
-- LTRIM�� ���� �ֻ��� ��� ������ �����ڸ� ���� �ִ� ���°� �Ϲ����̴�.
SELECT LPAD(' ', 4*(level-1), ' ') || org_cd org_cd,
       CONNECT_BY_ROOT(org_cd) root_org_cd,
       LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'),'-') path_org_cd ,
       CONNECT_BY_ISLEAF is_leaf
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
SELECT * from board_test; 
insert into board_test values (1, null, 'ù��° ���Դϴ�');
insert into board_test values (2, null, '�ι�° ���Դϴ�');
insert into board_test values (3, 2, '����° ���� �ι�° ���� ����Դϴ�');
insert into board_test values (4, null, '�׹�° ���Դϴ�');
insert into board_test values (5, 4, '�ټ���° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (6, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (7, 6, '�ϰ���° ���� ������° ���� ����Դϴ�');
insert into board_test values (8, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (9, 1, '��ȩ��° ���� ù��° ���� ����Դϴ�');
insert into board_test values (10, 4, '����° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (11, 10, '���ѹ�° ���� ����° ���� ����Դϴ�');
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

-- �� �׷��ȣ �÷� �߰�
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





