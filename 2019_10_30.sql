-- select : ��ȸ�� �÷� ���
--          -��ü �÷� ��ȸ : *
--          -�Ϻ� �÷� : �ش� �÷��� ���� (,����)
--FROM : ��ȸ�� ���̺� ���
--SELECT * 
--FROM user_users
-- ������ �����ٿ� ����� �ۼ��ص� �������.
-- �� keyword�� �ٿ��� �ۼ�

--SELECT * FROM prod;

--select * 
--from user_users;

--Ư�� �÷��� ��ȸ
--SELECT prod_id, prod_name
--FROM prod;

--1. prod ���̺��� ��� �÷���ȸ
--SELECT * FROM prod;

--2. buyer ���̺��� buyer_id, buyer_name �÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���
--SELECT buyer_id, buyer_name FROM buyer;

--3. cart ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���
--SELECT * FROM cart;

--4. member ���̺��� mem_id, mem_pass mem_name �÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���
--SELECT mem_id, mem_pass, mem_name FROM member;

--5. remain ���̺��� remain_year, remain_prod, remain_date �÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���
--SELECT remain_year, remain_prod, remain_date FROM remain;

--������ / ��¥����
--date type + ���� : ���ڸ� ���Ѵ�.
--SELECT userid, usernm, reg_dt, 
--        reg_dt + 5 reg_dt_after5,
--        reg_dt -5 as reg_dt_before5
--FROM users;

--DELETE USERS
--WHERE userid not in ('brown', 'cony', 'sally', 'james', 'moon');

--SELECT * FROM USERS;
--commit;

-- 1��
SELECT prod_id id, prod_name name FROM prod;

-- 2��
SELECT * FROM lprod;
SELECT lprod_gu gu, lprod_nm nm FROM lprod;

SELECT buyer_id ���̾���̵�, buyer_name �̸� FROM buyer;

-- ���ڿ� ����
-- java + --> sql ||
-- users���̺��� userid, usernm
-- CONCAT(str, str) �Լ�

SELECT * FROM users;
SELECT userid, usernm,
       userid || usernm,
       CONCAT(userid, usernm)
FROM users;

-- ���ڿ� ���(�÷��� ��� �����Ͱ� �ƴ϶� �����ڰ� ���� �Է��� ���ڿ�)
--SELECT '����� ���̵� : ' || userid
SELECT CONCAT('����� ���̵� : ', userid)
FROM users;

--�ǽ� sel_con1
SELECT 'SELECT * FROM ' || table_name || ';' QUERY
FROM user_tables;

SELECT * FROM user_tables;
SELECT CONCAT('SELECT * FROM ',table_name) || ';' as QUERY
FROM user_tables;

desc emp;
-- 1. desc
-- 2. select * ....

-- where�� ���� ������
SELECT *
FROM users
WHERE userid = 'brown';

--usernm�� ������ �����͸� ��ȸ�ϴ� ������ �ۼ�
SELECT *
FROM users
WHERE usernm = '����';