--�ǽ����� --
--�������� ���α׷��� ����� ���� ���̺�� �����--
--�̶�, �������ǿ� �̸��� �ο��� ��
--   �� �÷��� �ּ��ޱ�

/*
    1. ���ǻ�鿡 ���� �����͸� ������� ���ǻ� ���̺�(TB_PUBLISHER)
    �÷� : PUB_NO(���ǻ� ��ȣ) - �⺻Ű(PUBLISHER_PK)
          PUB_NAME(���ǻ��) -- NOT NULL(PUBLISHER_NN)
          PHONE(���ǻ���ȭ��ȣ) -- �������Ǿ���
*/
--���� 3������ ����
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT TB_PUBLISHER PRIMARY KEY,
    PUB_NAME VARCHAR2(20) CONSTRAINT PUBLISHER_NN NOT NULL,
    PHONE VARCHAR2(20)
);
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '���ǻ��ȣ';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '���ǻ��';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '���ǻ���ȭ��ȣ';

INSERT INTO TB_PUBLISHER VALUES(152, '������', '02-483-9276');
INSERT INTO TB_PUBLISHER VALUES(565, '�ѿ�', '02-244-6665');
INSERT INTO TB_PUBLISHER VALUES(896, '��ջ�', '02-566-8871');

/*
    2. �����鿡 ���� �����͸� ������� ���� ���̺�(TB_BOOK)
    �÷� : BK_NO(������ȣ)--�⺻Ű(BOOK_PK)
          BK_TITLE(������)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(���ڸ�)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(����)-- �������Ǿ���
          BK_PUB_NO(���ǻ� ��ȣ)--�ܷ�Ű(BOOK_FK)(TB_PUBLISHER���̺��� ����)
                                �̶� �����ϰ� �ִ� �θ����� ������ �ڽĵ����͵� ���� �ǵ��� �ɼ�����
                                
*/
--5�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,--�⺻Ű(BOOK_PK)
    BK_TITLE VARCHAR2(30) CONSTRAINT BOOK__NN__TITLE NOT NULL, --NOT NULL(BOOK__NN_TITLE)
    BK_AUTHOR VARCHAR2(20) CONSTRAINT BOOK_NN_AUTHOR NOT NULL, --NOT NULL(BOOK__NN_AUTHOR)
    BK_PRICE NUMBER, -- �������Ǿ���
    BK_PUB_NO NUMBER CONSTRAINT BOOK_FK REFERENCES TB_PUBLISHER ON DELETE CASCADE --�ܷ�Ű(BOOK_FK)(TB_PUBLISHER���̺��� ����)
);
COMMENT ON COLUMN TB_BOOK.BK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '������';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '���ڸ�';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '����';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '���ǻ��ȣ';

INSERT INTO TB_BOOK VALUES(20005, '�ڵ�������', '������', 25000, 152);
INSERT INTO TB_BOOK VALUES(65555, '����¹�', '������', 13000, 565);
INSERT INTO TB_BOOK VALUES(11155, '�����̿���', '������Ű', 15000, 896);
INSERT INTO TB_BOOK VALUES(56222, '�츮�ǲ�', '������', 8000, 896);
INSERT INTO TB_BOOK VALUES(21444, '�̱���ȭ������', '������', 33000, 152);
/*
    3. ȸ���� ���� �����͸� ������� ȸ�� ���̺�(TB_MEMBER)
    �÷��� : MEMBER_NO(ȸ����ȣ) -- �⺻Ű(MEMBER_PK)
            MEMBER_ID(���̵�) -- �ߺ�����(MEMBER_UQ_ID)
            MEMBER_PWD(��й�ȣ) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(ȸ����) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(����) -- M�Ǵ� F�� �Էµǵ��� ����(MEMBER_CK_GEN)
            ADDRESS(�ּ�) -- �������Ǿ���
            PHONE(����ó)-- �������Ǿ���
            STATUS(Ż�𿩺�) -- �⺻���� N���� ����, �׸��� N�Ǵ� Y�� �Էµǵ��� �������� ����(MEMBER_CK_STA)
            ENROLL_DATE(������) -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)
*/
--5�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY, -- �⺻Ű(MEMBER_PK)
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_UQ_ID UNIQUE, -- �ߺ�����(MEMBER_UQ_ID)
    MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_NN_PWD NOT NULL, -- NOT NULL(MEMBER_NN_PWD)
    MEMBER_NAME VARCHAR2(20)CONSTRAINT MEMBER_NN_NAME NOT NULL, -- NOT NULL(MEMBER_NN_NAME)
    GENDER CHAR(3)CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN ('M','F')), -- M�Ǵ� F�� �Էµǵ��� ����(MEMBER_CK_GEN)
    ADDRESS VARCHAR2(30),-- �������Ǿ���
    PHONE NUMBER,-- �������Ǿ���
    STATUS CHAR(3) DEFAULT 'N' CONSTRAINT MEMBER_CK_STA CHECK(STATUS IN ('N','Y')), -- �⺻���� N���� ����, �׸��� N�Ǵ� Y�� �Էµǵ��� �������� ����(MEMBER_CK_STA)
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)
);
COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '���̵�';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '��й�ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS 'ȸ����';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN TB_MEMBER.STATUS IS 'Ż�𿩺�';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '������';

INSERT INTO TB_MEMBER VALUES(2665, 'abc123', 'abc123', '������', 'M', '����� ������ ���ϵ�', 01022226666, 'N', DEFAULT);
INSERT INTO TB_MEMBER VALUES(5666, 'efef12', 'tmdgm1l2', '����', 'M', '����� ������ ���ϵ�', 01022226666, 'N', DEFAULT);
INSERT INTO TB_MEMBER VALUES(1222, 'eieie123', 'tmdrn12', '��ȫ��', 'M', '����� ������ ���ϵ�', 01022226666, 'N', DEFAULT);
INSERT INTO TB_MEMBER VALUES(9494, 'thiefjef', 'efef123', '�ڱ⼺', 'M', '����� ������ ���ϵ�', 01022226666, 'N', DEFAULT);
INSERT INTO TB_MEMBER VALUES(6545, 'vwneof', 'titn123', '������', 'M', '����� ������ ���ϵ�', 01022226666, 'N', DEFAULT);
/*
    4.� ȸ���� � ������ �뿩�ߴ����� ���� �뿩��� ���̺�(TB_RENT)
    �÷��� : RENT_NO(�뿩��ȣ)-- �⺻Ű(RENT_PK)
            RENT_MEM_NO(�뿩ȸ����ȣ)-- �ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_BOOK_NO(�뿩������ȣ)-- �ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_DATE(�뿩��) -- �⺻�� SYSDATE
*/

--3�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,-- �⺻Ű(RENT_PK)
    RENT_MEM_NO NUMBER CONSTRAINT RENT_FK_MEM REFERENCES TB_MEMBER(MEMBER_NO)ON DELETE SET NULL,-- �ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
                                        --�̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
    RENT_BOOK_NO NUMBER CONSTRAINT RENT_FK_BOOK REFERENCES TB_BOOK(BK_NO)ON DELETE SET NULL,-- �ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
                                       -- �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
    RENT_DATE DATE DEFAULT SYSDATE
);
COMMENT ON COLUMN TB_RENT.RENT_NO IS '�뿩��ȣ';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '�뿩ȸ����ȣ';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '�뿩������ȣ';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '�뿩��';

INSERT INTO TB_RENT VALUES(122, 6545, 65555, DEFAULT);
INSERT INTO TB_RENT VALUES(655, 2665, 56222 , DEFAULT);
INSERT INTO TB_RENT VALUES(455, 9494, 21444, DEFAULT);
