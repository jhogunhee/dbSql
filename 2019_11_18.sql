SELECT *
FROM USER_VIEWS;

-- ���� �� �˻��ϱ�
SELECT *
FROM ALL_VIEWS
WHERE OWNER = 'PC03';

-- OWNER.VIEW_NAME
SELECT *
FROM PC03.V_EMP_DEPT;

-- PC03 �������� ��ȸ������ ���� V_EMP_DEPT view�� hr �������� ��ȸ�ϱ� ���ؼ���
-- ������.view�̸� �������� ����� �ؾ� �Ѵ�.
-- �Ź� �������� ����ϱ� �������Ƿ� synonym�� ���� �ٸ� ��Ī�� �����Ѵ�.

-- pc03.V_EMP_DEPT �� V_EMP_DEPT�ε� �˻��� �����ϰ� �Ѵ�.
CREATE SYNONYM V_EMP_DEPT FOR pc03.V_EMP_DEPT;
SELECT *
FROM V_EMP_DEPT;

-- synonym ����
DROP SYNONYM V_EMP_DEPT;

-- hr ���� ��й�ȣ : java
-- hr ���� ��й�ȣ ���� : hr
ALTER USER pc03 IDENTIFIED by java;
-- ALTER USER pc03 IDENTIFIED BY java; -- ���� ������ �ƴ϶� ����


