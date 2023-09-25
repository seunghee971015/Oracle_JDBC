/*
    DDL : ������ ���Ǿ��
    
    ��ü�� ����(CREATE), ����(ALTER), ����(DELETE)�ϴ� ����
    
    <ALTER>
    ��ü�� �����ϴ� ����
    
    [ǥ����]
    ALTER TABLE ���̺�� ������ ����;
    
    *������ ����
    1) �÷� �߰�/����/����
    2) �������� �߰�/���� --> ������ X(���� �� �ٽ� �߰��ϸ� ��)
    3) �÷���/�������Ǹ�/���̺�� ���� 
*/

--1) �÷� �߰�/����/����

--1_1) �÷��߰�(ADD : ADD �÷��� ������Ÿ�� [DEFAULT �⺻��])
--DEPT_TABLE�� CNAME�÷� �߰�
ALTER TABLE DEPT_TABLE ADD CNAME VARCHAR2(20);

--LNAME �÷��߰�(�⺻�� ����)
ALTER TABLE DEPT_TABLE ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

--1_2) �÷� ����(MODIFY)
--> ������ Ÿ�� ���� : MODIFY �÷��� �ٲٰ����ϴµ�����Ÿ��
--> DEFAULT�� ���� : MODIFY �÷��� DEFAULT �ٲٰ����ϴ±⺻��

ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5); -- �����߻�
--ALTER TABLE DEPT_TABLE MODIFY DEPT_ID NUMBER; -- ���Ŀ��� �߻�
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(10); --ũ����� �߻�

--DEPT_TITLE �÷��� VARCHAR2(40)
--LOCATION_ID �÷��� VARCHAR2(2)
--LNAME �÷��� �⺻���� '�̱�'���� ����

--���ߺ��� ����
ALTER TABLE DEPT_TABLE
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '�̱�';
    
-- 1_3) �÷� ����(DROP COLUMN) : DROP COLUMN �����ϰ����ϴ� �÷�
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPT_TABLE;

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
--�ּ� �� ���� �÷��� �����ؾߵȴ�.
--�䰡�ΰ� �ϸ� ���� ����������

--------------------------------------------------------
--2) �������� �߰�/����(������ ���� �� �߰��ϸ� �ȴ�.)

/*
    2_1) 
    PRIMARY KEY : ADD PRIMARY KEY(�÷���)
    FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ���������̺�[(�÷���)]
    UNIQUE : ADD UNIQUE(�÷���)
    CHECK : ADD CHECK(�÷������� ����)
    NOT NULL : MODIFY �÷��� NULL|NOT NULL
    
    �������Ǹ� �����ϰ��� �Ѵٸ� [CONSTRAINT �������Ǹ�] ��������
*/

--DEPT_ID�� PRIMARY KEY �������� �߰�
--DEPT_TITLE�� UNIQUE �������� �߰�
--LNAME�� NOT NULL�������� �߰�

ALTER TABLE DEPT_TABLE
    ADD CONSTRAINT DTABLE_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DTABLE_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DTABLE_NN NOT NULL;
    
-- 2_2) �������� ���� : DROP CONSTRAINT �������Ǹ� / NOT NULL���� ��� ������ ����
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DTABLE_PK;

ALTER TABLE DEPT_TABLE
    DROP CONSTRAINT DTABLE_UQ
    MODIFY LNAME NULL;
    
---------------------------------------------------------
--3) �÷���/�������Ǹ�/���̺�� ����(RENAME)
--3_1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���
--DEPT_TITLE -> DEPT_NAME���� ����
ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

--3_2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C007154 TO DTABLE_LID_NN;

--3_3) ���̺�� ���� : RENAME �������̺�� TO �ٲ����̺��
--DEPT_TABLE --> DEPT_TEST
ALTER TABLE DEPT_TABLE RENAME TO DEPT_TEST;

---------------------------------------------------------------------
--���̺� ����
DROP TABLE DEPT_TEST;

DROP TABLE JOB;
--��򰡿� �����ǰ��ִ� �θ� ���̺��� �Ժη� ������ ���� �ʴ´�.
--���� �����ϰ��� �Ѵٸ�
-- 1. �ڽ����̺� ���� ���� �� ����
-- 2. �׳� �θ����̺� �����ϴµ� �������Ǳ��� �������Ǳ��� �����ϴ� ���
-- DROP TABLE ���̺�� CASCADE CONSTRAINT;