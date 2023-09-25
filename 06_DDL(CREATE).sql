/*
    *DDL : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü�� ���� �����(CREATE), ������ �����ϰ�(ALTER), ������ü�� ����(DELETE)�ϴ� ���
    ��, ���� ������ ���� �ƴ� ��Ģ ��ü�� �����ϴ� ���
    
    ����Ŭ������ ��ü(����) : ���̺�, ��, ������
                            �ε���, ��Ű��, Ʈ����
                            ���ν���, �Լ�, ���Ǿ�, �����
                            
    < CREATE >
    ��ü�� ���� �����ϴ� ����
*/

/*
    1.���̺� ����
    - ���̺��̶� : ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                 ��� �����͵��� ���̺��� ���ؼ� �����
                 (DBMS��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��)
                 
    [ǥ����]
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,
        ...
    )
    
    *�ڷ���
    -����(CHAR(����Ʈũ��) | VARCHAR2(����Ʈũ��)) -> �ݵ�� ũ������ �ؾ���
        -CHAR : �ִ� 2000����Ʈ���� �������� / ��������(������ ���ڼ��� �����Ͱ� ��� ���)
        (������ ũ�⺸�� �� ���� ���� ������ �������ζ� ä���� ó�� ������ ũ�⸸ŭ ����)
        -VARCHAR2 : �ִ� 4000����Ʈ���� �������� / ��������(������� �����Ͱ� ������ �𸣴� ���)
        (��� ���� ���� ���� ũ�Ⱑ ������)
    -����(NUMBER)
    -��¥(DATE)  
*/

--ȸ���� ���� �����͸� ������� ���̺� MEMBER ����
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

SELECT * FROM MEMBER;

--������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ��ִ� �ý��� ���̺�
-- [����]USER_TABLES : ����ڰ� ������ �ִ� ���̺���� �������� ������ Ȯ���� �� �ִ� �ý������̺�
-- [����]USER_TAB_COLUMNS : ����ڰ� ������ �ִ� ���̺�� ���� ��� �÷��� ������ Ȯ���� �� �ִ� �ý������̺�
SELECT * FROM USER_TABLES;
SELECT * FROM USER_TAB_COLUMNS;

------------------------------------------------------------------------------------
/*
    2. �÷��� �ּ��ޱ� (�÷��� ���� ������ ����)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
    -> �߸� �ۼ��� ���� �ۼ��ϸ� ������ �ȴ�.
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

--���̺� �����ϰ��� �� �� : DROP TABLE ���̺��;
--���̺� �����͸� �߰���Ű�� ����(INSERT)
--INSERT INTO ���̺�� VALUES(��,��,��,��,��...) 
INSERT INTO MEMBER 
VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1111-2222', 'AAAA@NAVER.COM','20/12/30');

SELECT * FROM MEMBER;

INSERT INTO MEMBER 
VALUES(2,'USER2','PASS2','ȫ���',NULL, NULL, NULL,SYSDATE);

INSERT INTO MEMBER 
VALUES(NULL,NULL,NULL,NULL,NULL, NULL, NULL,NULL);

---------------------------------------------------------------

/*
    <��������>
    -���ϴ� �����Ͱ�(��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
    -������ ���Ἲ ������ �������� �Ѵ�.
    
    *����: NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
    *NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ���(��, ���� NULL�� ������ �ȵǴ� ���)
    ����/������ NULL���� ������� �ʵ��� ����
    
    ���������� �ο��ϴ� ����� ũ�� 2������ �ִ�. (�÷��������/ ���̺������)
    NOT NULL���������� ������ �÷�����������θ� �����ϴ�.
*/

CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL, --�÷��������
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
INSERT INTO MEM_NOTNULL 
VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1111-2222', 'AAAA@NAVER.COM');

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL 
VALUES(2,'USER2','PASS2','ȫ���',NULL, NULL, NULL);

INSERT INTO MEM_NOTNULL 
VALUES(3,NULL,'PASS3','ȫȫȫ',NULL, NULL, NULL);
--�ǵ��ߴ���� ������ �߻��Ѵ�. (NOT NULL �������ǿ� ����Ǿ� ���� �߻�)

INSERT INTO MEM_NOTNULL 
VALUES(3,'USER2','PASS3','�谳��',NULL, NULL, NULL);
--���̵� �ߺ��Ǿ������� �ұ��ϰ� �� �߰��� �ȴ�.�̤�

-------------------------------------------------------------

/*
    *UNIQUE ��������
    �ش��÷��� �ߺ��� ���� ������ �ȵ� ��� ����Ѵ�.
    �÷����� �ߺ����� �����ϴ� ���������̴�.
    ����/������ ������ �ִ� �����Ͱ� �� �ߺ����� ���� ��� ������ �߻���Ų��.
*/
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --�÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) --> ���̺������
);

INSERT INTO MEM_UNIQUE 
VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1111-2222', 'AAAA@NAVER.COM');

INSERT INTO MEM_UNIQUE 
VALUES(2,'USER1','PASS2','ȫ���','��', NULL, NULL);
-- UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT ����
--> ���������� �������Ǹ����� �˷��ش�.
--> ���� �ľ��ϱ�� ��ƴ�. 
--> �������� �ο��� �������Ǹ��� ���������� ������ �ý��ۿ��� ������ �̸��� �ο���

-------------------------------------------------------------------------
/*
    *�������� �ο��� �������Ǹ���� �����ִ� ���
    > �÷��������
    CREATE TABLE ���̺�� (
        �÷��� �ڷ��� [CONSTRAINT  �������Ǹ�]��������
    )
     > ���̺������
    CREATE TABLE ���̺�� (
        �÷��� �ڷ��� ,
        �÷��� �ڷ��� ,
        [CONSTRAINT  �������Ǹ�]��������(�÷���)
    )
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NT NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) --> ���̺������
);
INSERT INTO MEM_UNIQUE 
VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1111-2222', 'AAAA@NAVER.COM');

INSERT INTO MEM_UNIQUE 
VALUES(2,'USER2','PASS2','ȫ���','��', NULL, NULL);

INSERT INTO MEM_UNIQUE 
VALUES(3,'USER3','PASS3','�谳��', NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE 
VALUES(4,'USER4','PASS4','�ְ���', '��', NULL, NULL);

-------------------------------------------------------------------
/*
    *CHECK(���ǽ�)
    �ش��÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� ����
    �ش����ǿ� �����ϴ� �����Ͱ��� ��� �� ����
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)
);

INSERT INTO MEM_CHECK 
VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1111-2222', 'AAAA@NAVER.COM');

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK 
VALUES(4,'USER4','PASS4','�ְ���', '��', NULL, NULL);
--> CHECK �������� ������ ������ �߻��Ѵ�.
-->���� GENDER�÷��� �����͸� �ְ��� �Ѵٸ� CHECK�������ǿ� �����ϴ� ���� �־���Ѵ�.
-->NULL�� ���� ���ٴ� ���̱� ������ �����ϴ�.

INSERT INTO MEM_CHECK 
VALUES(4,'USER5','PASS4','�ְ���', '��', NULL, NULL);

-------------------------------------------------------------------

/*
    *PRIMARY KEY(�⺻Ű) ��������
    ���̺��� �� ��(ROW)���� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� ��������(�ĺ��� ����)
    
    EX) ȸ����ȣ, �й�, ����, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, �ù������ȣ, �����ȣ
    PRIMARY KEY ���������� �ο��ϸ� �� �÷��� NOT NULL + UNIQUE ���������� �ɷ����� �ǹ��Ѵ�.
    
    ���ǻ��� :  �� ���̺�� ������ �Ѱ��� ���� ����
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)
);

INSERT INTO MEM_PRI 
VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1111-2222', 'AAAA@NAVER.COM');

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI 
VALUES(1,'USER2','PASS2','ȫ���','��',NULL, NULL);
--> �⺻Ű�� �ߺ����� �������� �� ��(UNIQUE�������� ����)

INSERT INTO MEM_PRI 
VALUES(NULL,'USER2','PASS2','ȫ���','��',NULL, NULL);
--> �⺻Ű�� NULL�� �������� �� ��(NOT NULL�������� ����)

INSERT INTO MEM_PRI 
VALUES(2,'USER2','PASS2','ȫ���','��',NULL, NULL);

-----------------------------------------------------------------------
DROP TABLE MEM_PRI2;
CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID)
);

INSERT INTO MEM_PRI2 VALUES(1,'USER1','PASS1','ȫ�浿',NULL,NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(1,'USER2','PASS2','ȫ���',NULL,NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(2,'USER2','PASS2','ȫ���',NULL,NULL, NULL);
SELECT * FROM MEM_PRI2;
INSERT INTO MEM_PRI2 VALUES(2,'USER2','PASS2','ȫ���',NULL,NULL, NULL);

--����Ű ��� ����(� ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�)
CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

-- 1,2��ȸ�� 2���� �����Ѵ�.
-- ������A, ������B��ǰ�� �����Ѵ�.

INSERT INTO TB_LIKE VALUES(1, '������A', SYSDATE);
SELECT * FROM TB_LIKE;
INSERT INTO TB_LIKE VALUES(1, '������B', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '������A', SYSDATE);


------------------------------------------------------------------------------------
--ȸ����޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');
------------------------------------------------------------------------

SELECT * FROM MEM_GRADE;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER
);

INSERT INTO MEM VALUES(1,'USER01','PASS01','ȫ�浿','��',NULL,NULL,NULL);
INSERT INTO MEM VALUES(2,'USER02','PASS02','ȫ���','��',NULL,NULL,10);
INSERT INTO MEM VALUES(3,'USER03','PASS03','������',NULL,NULL,NULL,40);
--> ��ȿ�� ȸ����޹�ȣ�� �ƴϿ��� �ұ��ϰ� INSERT�� �� �ȴ�.

----------------------------------------------------------------------

/*
    *FOREIGN KEY(�ܷ�Ű) ��������
    �ٸ����̺� �����ϴ� ���� ���;ߵǴ� Ư�� �÷��� �ο��ϴ� ��������
    --> �ٸ� ���̺��� �����Ѵٰ� ǥ��
    --> �ַ� FOREIGN KEY �������ǿ� ���ؼ� ���̺� ���谡 �����ȴ�.
    
    > �÷��������
    �÷��� �ڷ��� REFERENCES ���������̺��[(������ �÷���)]
    
    > ���̺������
    FOREIGN KEY(�÷���) REFERENCES ���������̺��[(������ �÷���)]
    
    -> �������÷��� ������ ���������̺� PRIMARY KEY�� ������ �÷��� ��Ī�ȴ�.
*/

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE)
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

INSERT INTO MEM VALUES(1,'USER01','PASS01','ȫ�浿','��',NULL,NULL,NULL);
--> �ܷ�Ű ���������� �ο��� �÷��� �⺻������ NULL�� ����
INSERT INTO MEM VALUES(2,'USER02','PASS02','ȫ���','��',NULL,NULL,10);
INSERT INTO MEM VALUES(3,'USER03','PASS03','������',NULL,NULL,NULL,40);
--> parent key�� ã�� �� ���ٴ� ���� �߻�

--  MEM_GRADE(�θ����̺�) -|------<- MEM(�ڽ����̺�)
--> 1:N���� 1���� �θ����̺� N�� �ڽ����̺�
INSERT INTO MEM VALUES(3,'USER03','PASS03','������','��',NULL,NULL,20);
INSERT INTO MEM VALUES(4,'USER04','PASS04','�����','��',NULL,NULL,10);

--> �̶� �θ����̺�(MEM_GRADE)���� �����Ͱ��� ������ ��� ������� ������?
--������ ���� :  DELETE FROM ���̺�� WHERE ����;

--> MEM_GRADE ���̺��� 10����� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--> �ڽ����̺�(MEM)�� 10�̶�� ���� ����ϰ� �ֱ� ������ ������ �ȵ�

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;
--> �ڽ����̺�(MEM)�� 30�̶�� ���� ����ϰ� ���� �ʱ� ������ ������ �ȴ�.

--> �ڽ����̺� �̹� ����ϰ� �ִ� ���� ���� ���
--> �θ����̺�κ��� ������ ������ �ȵǴ� "��������" �ɼ��� �ɷ��ִ�.

ROLLBACK;

------------------------------------------------------------

/*
    �ڽ����̺� ������ �ܷ�Ű �������� �ο��� �� �����ɼ� ��������
    *�����ɼ� : �θ����̺��� ������ ������ �� �����͸� ����ϰ� �ִ� �ڽ����̺��� ����
                ��� ó���� ����
                
    -ON DELETE RESTRICTED(�⺻��): �������ѿɼ�, �ڽĵ����ͷ� ���̴� �θ����ʹ� ������ �ƿ� �ȵ�
    -ON DELETE SET NULL : �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽĵ������� ���� NULL�� ����
    -ON DELETE CASCADE : �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͵� ���� ������Ű�� �ɼ�
*/

DROP TABLE MEM;
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO MEM VALUES(1,'USER01','PASS01','ȫ�浿','��',NULL,NULL,NULL);
INSERT INTO MEM VALUES(2,'USER02','PASS02','ȫ���','��',NULL,NULL,10);
INSERT INTO MEM VALUES(3,'USER03','PASS03','������','��',NULL,NULL,20);
INSERT INTO MEM VALUES(4,'USER04','PASS04','�����','��',NULL,NULL,10);

--10����� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--> �� ������ �Ǿ���. �� 10�� ������ ���� �ִ� �ڽĵ������� ���� NULL�� �����!

ROLLBACK;
DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO MEM VALUES(1,'USER01','PASS01','ȫ�浿','��',NULL,NULL,NULL);
INSERT INTO MEM VALUES(2,'USER02','PASS02','ȫ���','��',NULL,NULL,10);
INSERT INTO MEM VALUES(3,'USER03','PASS03','������','��',NULL,NULL,20);
INSERT INTO MEM VALUES(4,'USER04','PASS04','�����','��',NULL,NULL,10);

--10����� ����
DELETE FROM MEM_GRADE WHERE GRADE_CODE = 10;
--> ������ �� ��. �� �ش絥���͸� ����ϰ� �ִ� �ڽĵ����͵� ���� DELETE�� ��
---------------------------------------------------------------

/*
    <DEFAULT �⺻��> *���������� �ƴϴ�.
    �÷��� �������� �ʰ� INSERT�� NULL�� �ƴ� �⺻���� INSERT�ϰ��� �Ѵ�.
    �̶� �����ص� �� �ִ� ��
    
    �÷��� �ڷ��� DEFAULT �⺻�� 
*/

DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '����',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

-- INSERT INTO ���̺�� VALUES(�÷���,�÷���,..)
INSERT INTO MEMBER VALUES(1,'����', 20 , '�', '15/12/12');
INSERT INTO MEMBER VALUES(2,'ȫ���', NULL , NULL, NULL);
INSERT INTO MEMBER VALUES(3,'ȫ�浿', NULL , DEFAULT, DEFAULT);

--INSERT INTO ���̺��(�÷�1,�÷�2,�÷�3) VALUES(�÷�1��,�÷�2��,�÷�3��);
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4,'�谳��');
--> ���õ��� ���� �÷����� �⺻������ NULL�� ��
--> ��. �ش� �÷��� DEFAULT���� �ο��Ǿ� ���� ��� NULL�� �ƴ� DEFAULT���� ��
-------------------------------------------------------------------

CREATE TABLE EMPLOYE_COPY
AS (SELECT * FROM EMPLOYEE);

/*
    *���̺��� �� ������ �Ŀ� �ڴʰ� ���������� �߰��ϴ� ���
    ALTER TABLE ���̺�� ������ ����
    
    -PRIMARY KEY :  ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
    -FOREIGN KEY :  ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ���������̺�� [(�����÷���)];
    -UNIQUE      :  ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
    -CHECK       :  ALTER TABLE ���̺�� ADD CHECK(�÷������� ���ǽ�);
    -NOT NULL    :  ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;
*/
--EMPLOYEE_COPY ���̺� PRIMARY_KEY ���������� �߰�(EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

--EMPLOYEE ���̺� DEPT_CODE�� �ܷ�Ű �������� �߰�
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;
--EMPLOYEE ���̺� JOB_CODE�� �ܷ�Ű �������� �߰�
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;
--DEPARTMENT ���̺� LOCATION_ID�� �ܷ�Ű �������� �߰�
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;