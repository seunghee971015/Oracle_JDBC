/*
    <DCL :  ������ ���>
    
    �������� �ý��۱��� �Ǵ� ��ü���ٱ����� �ο��ϰų� ȸ���ϴ� ����
    
    > �ý��۱��� :  DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
    > ��ü���ٱ��� : Ư�� ��ü���� ������ �� �ִ� ����
    
    CREATE USER ������ IDENTIFIED BY ��й�ȣ;
    GRANT ����(RESOURCE, CONNECT) TO ����
*/

SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('RESOURCE', 'CONNECT');

/*
    <TCL : Ʈ����� ���>
    
    *Ʈ�����
    -�����ͺ��̽��� ���� �������
    -�������� �������(DML)���� �ϳ��� Ʈ����ǿ� ��� ó��
     DML�� �Ѱ��� ������ �� Ʈ������� �������� �ʴ´ٸ� Ʈ������� ���� ����
                         Ʈ������� �����Ѵٸ� �ش� Ʈ����ǿ� ��� ó��
     COMMIT �ϱ� �������� ������׵��� �ϳ��� Ʈ����ǿ� ��´�.
    -Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE(DML)
    
    COMMIT(Ʈ����� ���� ó�� �� Ȯ��)
    ROLLBACK(Ʈ����� ���)
    SAVEPOINT(�ӽ�����)
    
    -COMMIT; --> �� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ���Ű�ڴٴ� �ǹ�
    -ROLLBACK; --> �� Ʈ����ǿ� ����ִ� ������׵��� ����(���) �� �� ������ COMMIT�������� ���ư�
    -SAVEPOINT ����Ʈ��; --> ���� ������ �ش� ����Ʈ������ �ӽ��������� �����صδ� ��
*/
CREATE TABLE EMP_01
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE 
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) FROM EMPLOYEE);
    
    
SELECT * FROM EMP_01;    
--����� 900���� ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 900;

DELETE FROM EMP_01
WHERE EMP_ID = 901;

ROLLBACK;

SELECT * FROM EMP_01;

-----------------------------------------------------------
--����� 900���� ��� �����
DELETE EMP_01
WHERE EMP_ID = 900;

--800, ȫ�浿, �ѹ����� ����߰�
INSERT INTO EMP_01
VALUES(800, 'ȫ�浿','�ѹ���');

COMMIT;
ROLLBACK;

-----------------------------------------------------------------
-- 217, 216, 214��� ����
DELETE FROM EMP_01
WHERE EMP_ID IN (217,216,214);

SAVEPOINT SP;

--801, �踻��, ���������
INSERT INTO EMP_01
VALUES(801, '�踻��', '���������');

DELETE FROM EMP_01
WHERE EMP_ID = 218;

ROLLBACK TO SP;

COMMIT;

---------------------------------------------------
--800�� ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 800;

--DDL������
CREATE TABLE TEST(
    TID NUMBER
);

--�̶� �ݿ��� �Ϸ�
ROLLBACK;

-- DDL��(CREATE, ALTER, DROP)�� �����ϴ� ���� ������ Ʈ����ǿ� �ִ� ������׵���
-- ������ COMMIT(���� DB�ݿ��ȴ�.)
-- ��, DDL�� ���� �� ������׵��� �ִٸ� ��Ȯ�ϰ� �Ƚ��ϰ� �ض�!