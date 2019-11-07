-- emp테이블에는 부서번호(deptno)만 존재
-- emp 테이블에서 부서명을 조회하기 위해서는
-- dept 테이블과 조인을 통해 부서명 조회
SELECT * FROM
emp;

-- 조인 문법 :
-- ANSI : 테이블 JOIN 테이블2 ON(테이블.COL = 테이블2.COL)
-- emp JOIN dept on(emp.empno = dept.deptno)
-- ORACLE : FROM 테이블, 테이블2 WHERE 테이블.col = 테이블2.col
--          FROM emp, dept WHERE emp.deptno = dept.deptno

-- 사원번호, 사원명, 부서번호, 부서명
-- emp 테이블과 dept테이블의 부서번호가 같은 것들끼리 묶기
SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- ANSI 표준
SELECT e.empno, e.ename, deptno, d.dname
FROM emp e JOIN dept d USING(deptno);

SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e JOIN dept d ON(e.deptno = d.deptno);

SELECT e.empno, e.ename, deptno, d.dname
FROM emp e NATURAL JOIN dept d;

-- 실습 join 0_2
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno and sal > 2500;

SELECT e.empno, e.ename, e.sal, deptno, d.dname
FROM emp e join dept d using(deptno)
WHERE sal > 2500;

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e join dept d ON(e.deptno = d.deptno and sal > 2500);

-- join0_3 급여 2500초과, 사번이 7600보다 큰 직원
SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = e.deptno and sal > 2500 and empno > 7600;

SELECT e.empno, e.ename, e.sal, deptno, d.dname
FROM emp e join dept d using(deptno)
WHERE sal > 2500 and empno > 7600;

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
FROM emp e join dept d on(e.deptno = d.deptno and sal > 2500 and empno > 7600);

-- 실습 join0_4
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

-- 실습 join 3 p187
SELECT m.mem_id, m.mem_name, prod.prod_id, prod.prod_name, c.cart_qty
from member m join cart c on(m.mem_id = c.cart_member)
join prod on(cart_prod =  prod_id);

-- 실습 join 4
SELECT cyc.cid, cus.cnm, cyc.pid, cyc.day, cyc.cnt
FROM cycle cyc, customer cus
WHERE cus.cid = cyc.cid and cus.cnm in('brown', 'sally');

-- 실습 join 5
SELECT cyc.cid, cus.cnm, cyc.pid, pro.pnm, cyc.day, cyc.cnt
FROM cycle cyc, customer cus, product pro
WHERE cus.cid = cyc.cid AND cyc.pid = pro.pid
AND cus.cnm in('brown', 'sally');

-- 실습 join 6
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

-- 고객, 제품별 애음 건수를 구한다.(inline-view)
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
-- 실습 join 7
SELECT product.pid, product.pnm, sum(cnt) cnt, count(*)
FROM product, cycle
WHERE product.pid = cycle.pid
group by product.pid, product.pnm;

SELECT *
FROM cycle;
-- 실습 join 8
SELECT *
FROM countries;

SELECT *
FROM regions;








