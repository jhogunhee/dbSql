-- �μ���ȣ�� 30~40���� ���� �μ��� ���� ����
--SELECT * 
--FROM dept
--WHERE deptno BETWEEN 30 AND 40;

-- �μ���ȣ�� 30������ ũ�ų� ���� �μ��� ���� ����
SELECT * 
FROM dept
WHERE deptno >= 30;

-- �μ���ȣ�� 30������ ���� �μ��� ���� ����
SELECT * 
FROM dept
WHERE deptno < 30;

-- dept ���̺��� LOC�� N���� �����ϴ� ����
SELECT *
FROM dept
WHERE LOC like 'N%';

-- dept ���̺��� LOC�� K�� ������ ����
SELECT *
FROM DEPT
WHERE LOC LIKE '%K';

-- �Ի����ڰ� 1982�� 1�� 1�� ������ ���� ��ȸ
SELECT *
FROM emp
WHERE hiredate >= '1982/01/01';

-- �Ի����ڰ� 1982�� 1�� 1�� ������ ���� ��ȸ
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101','YYYYMMDD');
-- �Ի����ڰ� 1982�� 1�� 1�Ͽ��� 3�� 3�� ������ ���� ��ȸ
SELECT *
FROM emp
WHERE hiredate BETWEEN '1982/01/01' AND '1982/03/03';

-- EMP ���̺��� SAL ������ 3000������ ���������� ���ݸ� ����Ͻÿ�
SELECT *
FROM emp
WHERE SAL BETWEEN 3000 AND 10000;

-- col BETWEEN X AND Y ����
-- �÷��� ���� X���� ũ�ų� ����, Y���� �۰ų� ���� ������
-- �޿�(sal)�� 1000���� ũ�ų� ���� y���� �۰ų� ���� �����͸� ��ȸ
SELECT *
FROM emp
WHERE SAL BETWEEN 1000 AND 2000
AND DEPTNO = 20;

SELECT *
FROM emp
WHERE SAL BETWEEN 1000 AND 2000;

--���� BETWEEN AND �����ڴ� �Ʒ��� <=, >= ���հ� ����.
SELECT *
FROM emp
WHERE sal >= 1000 and sal <= 2000 
and deptno = 30;

-- IN�� ����Ͽ� EMP ���̺��� DEPTNO�� 20�� ���� �����Ͻÿ�
SELECT *
FROM emp
WHERE DEPTNO IN('20');

SELECT ename, hiredate
FROM emp 
WHERE hiredate BETWEEN '1982-01-01' AND '1983-01-01';

SELECT ename, hiredate
FROM emp 
WHERE hiredate BETWEEN to_date('19820101','YYYYMMDD') AND to_date('19830101','YYYYMMDD');

SELECT ename, hiredate
FROM emp 
WHERE hiredate >= to_date('19820101','YYYYMMDD') and hiredate <= to_date('19830101','YYYYMMDD');

-- IN ������
-- COL IN(values...)
-- �μ���ȣ�� 10 Ȥ�� 20�� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno = 10 or empno = 20;

SELECT *
FROM emp
WHERE deptno in(10,20);

SELECT userid as ���̵�, usernm �̸�, filename ����
FROM users
WHERE userid in('brown','cony','sally');

--COL LIKE 'S%'
--COL�� ���� �빮�� S�� �����ϴ� ��� ��
--COL LIKE 'S____'
--COL�� ���� �빮�� S�� �����ϰ� �̾ 4���� ���ڿ��� �����ϴ� ��

--emp ���̺��� �����̸��� S�� �����ϴ� ��� ���� ��ȸ
SELECT *
FROM emp
WHERE eNAME LIKE 'S%';

--emp ���̺��� �����̸��� S�� �����ϰ� 5������ ���� ���
SELECT *
FROM emp
WHERE eNAME LIKE 'S____';

--member ���̺��� ȸ���� ���� �ž��� ����� mem_id, mem_name�� ��ȸ�ϴ� �����ۼ�
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

--NULL ��
--col is null;
--EMP ���̺��� MGR ������ ���� ���(NULL) ��ȸ
SELECT *
FROM emp
WHERE MGR is null;

--�Ҽ� �μ��� 10���� �ƴ� ������
SELECT *
FROM emp
WHERE deptno != '10';

-- emp���̺��� COMM�� NULL�� �ƴѰ͵� ���
SELECT *
FROM emp
WHERE COMM is not null;


-- AND / OR 
-- emp ���̺��� mgr ����� 7698�̰ų�
-- �޿��� 1000�̻��� ����
SELECT *
FROM emp
WHERE mgr = 7698 
OR sal >= 1000;

-- emp ���̺��� ������ ����� 7698�� �ƴϰ�, 7839�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE MGR NOT IN('7698','7839');

SELECT *
FROM emp
WHERE MGR != 7698 AND MGR != 7839;

--IN, NOT IN �������� NULL ó��
--emp ���̺��� ������(mgr) ����� 7698, 7839�� �ƴϰ� null�� �ƴ� ������ ��ȸ
SELECT * 
FROM emp
WHERE mgr IN('7698','7839')  
AND mgr IS NOT NULL; 

-- emp ���̺��� job�� SALESMAN�̰� �Ի����ڰ� 1981�� 6�� 1�� ������ 
-- ������ ������ ������ ���� ��ȸ�ϼ���
SELECT to_char(hiredate, 'YYYY/MM/DD')
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE(19810601, 'YYYYMMDD');

--SELECT *
--FROM emp
--WHERE job = 'SALESMAN' AND hiredate >= TO_DATE(19810601, 'YYYYMMDD');

-- EMP ���̺��� �μ���ȣ�� 10�� �ƴϰ� �Ի����ڰ� 1981�� 6��
-- 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���
SELECT *
FROM emp
WHERE deptno != 10 AND hiredate > TO_DATE('19810601','YYYYMMDD'); 

-- emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի��ȣ�� 1981�� 6��
--1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���
--not in ������ ���
SELECT *
FROM emp
WHERE deptno not in(10) and (hiredate > TO_DATE('19810601','YYYYMMDD')); 

-- 10��
SELECT *
FROM emp
WHERE deptno != 10 and (hiredate > TO_DATE('19810601','YYYYMMDD')); 

-- 11��
SELECT *
FROM emp
WHERE job = 'SALESMAN' or (hiredate > TO_DATE('19810601','YYYYMMDD'));

-- 12��
SELECT *
FROM emp
WHERE job like 'SALESMAN' or DEPTNO = 30;

-- 13��
SELECT *
FROM emp
WHERE job = 'SALESMAN' or empno between 7800 and 7899; 

SELECT *
FROM emp;

desc emp;
insert into emp values(785,'smit','clerk',7999,'1981/12/17',800,300,20);

-- 14��
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%'
and hiredate > TO_DATE('19810601','YYYYMMDD');



