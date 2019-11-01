-- SELECT�� �÷� ���� �ε����� ����
SELECT empno, ename, sal, sal * 12 as year_sal
FROM emp
ORDER BY 4;

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

SELECT *
FROM emp
WHERE comm is not null
ORDER BY comm DESC, empno ASC;

-- orderby 3
SELECT *
FROM emp
WHERE mgr is not null
ORDER BY job, empno desc;

-- order by 4
SELECT *
FROM emp
WHERE (deptno = 10 or deptno = 30) and sal > 1500
ORDER BY ename desc;

desc emp;
SELECT ROWNUM, empno, ename
FROM emp
WHERE rownum between 1 and 8;

SELECT ROWNUM, empno, ename
FROM emp
WHERE rownum = 1;


-- �Ŵ����� ���� ���� 0���� �ٲپ ����ϴ� ����.
SELECT deptno, empno, NVL(mgr, 0)
  FROM emp  
 WHERE deptno = 10;
 
--emp ���̺��� ���(empno), �̸�(ename)�� �޿� �������� �������� �����ϰ�
--���ĵ� ��������� ROWNUM
SELECT *
FROM emp;
ORDER BY sal;

SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp 
ORDER BY sal) a;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

SELECT ROWNUM, a.* 
FROM emp a;

SELECT *
FROM emp;

SELECT *
FROM (
    SELECT rownum rnum, t1.*
    from emp t1    
    order by sal
)
where rnum between 11 and 20;

SELECT *
FROM
(SELECT ROWNUM rn, B.* FROM (SELECT empno, ename, sal FROM emp ORDER BY sal) B)
WHERE rn >= 11 and rn <= 20;

SELECT empno, ename, sal FROM emp ORDER BY sal;

--FUNCTION
--DUAL ���̺� ��ȸ
SELECT 'HELLO WORLD' as msg
FROM dual;

SELECT 'HELLO WORLD'
FROM emp;

-- ���ڿ� ��ҹ��� ���� �Լ�
-- LOWER, UPPER, INITCAP
SELECT LOWER('Hello, World'), UPPER('Hello, World'),
INITCAP('hello, world')
FROM emp
where job = 'SALESMAN';

--FUNCTION�� WHERE�������� ��밡��
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

-- ������ SQL ĥ������
-- 1. �º��� �������� ���ƶ�
-- �º�(TABLE�� �÷�)�� �����ϰ� �Ǹ� INDEX�� ���������� ������� ����
-- Function Based Index -> FBI

-- CONCAT : ���ڿ� ����
-- SUBSTR : ���ڿ��� �κ� ��Ʈ��(java : String.substring)
-- INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù���� �ε���
-- LPAD : ���ڿ��� Ư�� ���ڿ��� ����

SELECT CONCAT(CONCAT('HELLO',', '),'WORLD') CONCAT
FROM dual;

SELECT CONCAT(CONCAT('HELLO',', '), 'WORLD') CONCAT,
       SUBSTR('HELLO, WORLD', 0, 5) substr,
       SUBSTR('HELLO, WORLD', 1, 5) substr1,
       LENGTH('HELLO, WORLD') length,
       -- INSTR(���ڿ�, ã�� ���ڿ�, ���ڿ��� Ư�� ��ġ ���� ǥ��)
       INSTR('HELLO, WORLD', 'O', 6), 
       
       -- LPAD(���ڿ�, ��ü ���ڿ�����, ���ڿ��� ��ü���ڿ����̿� ��ġ�� ���Ұ�� �߰��� ����)
       LPAD('HELLO, WORLD', 15, ' '),
       RPAD('HELLO, WORLD', 15, ' ')
FROM dual;


