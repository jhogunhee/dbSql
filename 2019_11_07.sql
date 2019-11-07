-- emp���̺��� �μ���ȣ(deptno)�� ����
-- emp ���̺��� �μ����� ��ȸ�ϱ� ���ؼ���
-- dept ���̺�� ������ ���� �μ��� ��ȸ
SELECT * FROM
emp;

-- ���� ���� :
-- ANSI : ���̺� JOIN ���̺�2 ON(���̺�.COL = ���̺�2.COL)
-- emp JOIN dept on(emp.empno = dept.deptno)
-- ORACLE : FROM ���̺�, ���̺�2 WHERE ���̺�.col = ���̺�2.col
--          FROM emp, dept WHERE emp.deptno = dept.deptno

-- �����ȣ, �����, �μ���ȣ, �μ���
-- emp ���̺�� dept���̺��� �μ���ȣ�� ���� �͵鳢�� ����
SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- ANSI ǥ��
SELECT e.empno, e.ename, deptno, d.dname
FROM emp e JOIN dept d USING(deptno);

SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e JOIN dept d ON(e.deptno = d.deptno);

SELECT e.empno, e.ename, deptno, d.dname
FROM emp e NATURAL JOIN dept d;

-- �ǽ� join 0_2
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno and sal > 2500;

SELECT e.empno, e.ename, e.sal, deptno, d.dname
FROM emp e join dept d using(deptno)
WHERE sal > 2500;

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e join dept d ON(e.deptno = d.deptno and sal > 2500);

-- join0_3 �޿� 2500�ʰ�, ����� 7600���� ū ����
SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = e.deptno and sal > 2500 and empno > 7600;

SELECT e.empno, e.ename, e.sal, deptno, d.dname
FROM emp e join dept d using(deptno)
WHERE sal > 2500 and empno > 7600;

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e join dept d on(e.deptno = d.deptno and sal > 2500 and empno > 7600);

-- �ǽ� join0_4
SELECT e.empno, e.ename, e.sal, deptno, d.dname
FROM emp e join dept d using(deptno)
WHERE sal > 2500 and empno > 7600 and d.dname = 'RESEARCH';

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e join dept d on(e.deptno = d.deptno and sal > 2500 and empno > 7600 and d.dname = 'RESEARCH'); 

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno and sal > 2500 and empno > 7600
and d.dname = 'RESEARCH';

SELECT l.lprod_gu, l.lprod_nm, p.prod_id,p.prod_name
FROM lprod l, prod p
WHERE l.lprod_gu = p.prod_lgu
order by lprod_gu;

SELECT b.buyer_id, b.buyer_name, p.prod_id, p.prod_name
FROM buyer b, prod p
WHERE b.buyer_id = p.prod_buyer;

SELECT *
FROM buyer b, prod p
WHERE b.buyer_id = p.prod_buyer
order by prod_id;

SELECT m.mem_id, m.mem_name, p.prod_id, p.prod_name, c.cart_qty
FROM member m, prod p, cart c
WHERE m.mem_id = c.cart_member and p.prod_id = cart_prod;

-- �ǽ� join 3 p187
SELECT m.mem_id, m.mem_name, prod.prod_id, prod.prod_name, c.cart_qty
from member m join cart c on(m.mem_id = c.cart_member)
join prod on(cart_prod =  prod_id);

-- �ǽ� join 4
SELECT cyc.cid, cus.cnm, cyc.pid, cyc.day, cyc.cnt
FROM cycle cyc, customer cus
WHERE cus.cid = cyc.cid and cus.cnm in('brown', 'sally');

-- �ǽ� join 5
SELECT cyc.cid, cus.cnm, cyc.pid, pro.pnm, cyc.day, cyc.cnt
FROM cycle cyc, customer cus, product pro
WHERE cus.cid = cyc.cid AND cyc.pid = pro.pid
AND cus.cnm in('brown', 'sally');

-- �ǽ� join 6
SELECT total.*
FROM 
(SELECT cyc.cid, cus.cnm, cyc.pid, pro.pnm, cyc.cnt 
FROM cycle cyc, customer cus, product pro 
WHERE cus.cid = cyc.cid AND cyc.pid = pro.pid) total;
--group by product.pnm;

--SELECT cycle.cnt, total.*
--FROM cycle,
SELECT *
FROM 
(SELECT cid, pid, sum(cnt)
FROM cycle
GROUP BY cid, pid);

-- ��, ��ǰ�� ���� �Ǽ��� ���Ѵ�.(inline-view)
with cycle_groupby as (
SELECT cid, pid, sum(cnt) cnt
FROM cycle
GROUP BY cid, pid
)

SELECT customer.cid, cnm, cycle.pid, pnm, sum(cnt) cnt
FROM customer, cycle, product
WHERE cycle.cid = customer.cid AND cycle.pid = product.pid
GROUP BY customer.cid, cnm, cycle.pid, pnm;

-- join 7
SELECT *
FROM cycle;

SELECT *
FROM product,
(SELECT pid, sum(cnt)
FROM cycle
group by pid) cycle
WHERE cycle.pid = product.pid;

SELECT * FROM cycle;
SELECT * FROM product;

--SELECT sum(cnt)
--FROM pid
-- �ǽ� join 7
SELECT product.pid, product.pnm, sum(cnt) cnt, count(*)
FROM product, cycle
WHERE product.pid = cycle.pid
group by product.pid, product.pnm;

SELECT *
FROM cycle;
-- �ǽ� join 8
SELECT *
FROM countries;

SELECT *
FROM regions;








