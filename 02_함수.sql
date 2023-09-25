/*
    <�Լ� FUNCTION>
    ���޵� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ�Ѵ�.
    
    - ������ �Լ� : N���� ���� �о�鿩�� N���� ������� ����(���ึ�� �Լ������ �����ȯ)
    - �׷��Լ� : N���� ���� �о�鿩�� 1���� ������� ����(�׷��� ��� �׷캰�� �Լ������ ��� ��ȯ)
    
    >> SELECT���� �������Լ��� �׷��Լ��� �Բ� ������� ���Ѵ�.
    -> ��� ���� ������ �ٸ��� ������
    
    >> �Լ����� ����� �� �ִ� ��ġ : SELECT�� WHERE�� ORDER BY�� GROUP BY�� HAVING��
*/

--=======================================<�������Լ�>===============================
/*
    <���� ó�� �Լ�>
    
    *LENGTH / LENGTHB => ��������� NUMBERŸ�� ��ȯ
    -> LENGTH(�÷� | '���ڿ���') : �ش� ���ڿ��� ���ڼ��� ��ȯ
    -> LENGTHB(�÷� | '���ڿ���') : �ش繮�ڿ��� ����Ʈ���� ��ȯ
    
    '��' '��' '��' '��' ���ڴ� 3BYTE
    ������,Ư������,���� ���ڴ� 1BYTE
*/
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;

SELECT LENGTH('ORACLE'), LENGTHB('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
        EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE
WHERE LENGTH(EMAIL) = 15;

-----------------------------------------------------------

/*
    *INSTR
    ���ڿ��κ��� Ư�������� ������ġ�� ã�Ƽ� ��ȯ
    
    [ǥ����]
    INSTR(�÷�|'���ڿ���', 'ã�����ϴ� ����', ['ã�� ��ġ�� ���۰�',[����]] ) => ������� NUMBERŸ��
    
    'ã�� ��ġ�� ���۰�'
    1 ,2,3 : ���ʺ��� Ư�� ��ġ�� ������ �� �ִ�
    -1 ,-2,-3 : ���ʺ��� Ư�� ��ġ�� ������ �� �ִ�
*/

SELECT INSTR('AABAACAABBAA','B') FROM DUAL; --  ���ʿ� ù B�� 3��° ��ġ�� �ִٰ� ���´�.
-- �⺻���� ������ġ 1, ���� 1
SELECT INSTR('AABAACAABBAA','B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA','B', -1) FROM DUAL; -- �ڿ������� ã���� ��ġ���� ���� ���� ���ʺ��� �д´�
SELECT INSTR('AABAACAABBAA','B', 1, 2) FROM DUAL; -- �ι�°�� �˻��Ǵ� B�� ��ġ�� ��Ÿ���ش�.

SELECT EMAIL, INSTR(EMAIL, '@') - 1 AS "���̵����"
FROM EMPLOYEE;

-- �̸����� _��ġ�� ��ȸ
SELECT EMAIL, INSTR(EMAIL, '_', 1, 1)
FROM EMPLOYEE;

-------------------------------------------------------------------------------------

/*
    *SUBSTR / ���־���
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
    
    [ǥ����]
    SUBSTR(STRING, POSITION, [LENGTH])
    - STRING : ����Ÿ���÷� OR '���ڿ���'
    - POSITION : ���ڿ��� ������ ������ġ ��
    - LENGTH : ������ ������ ����(������ ������)
*/

SELECT SUBSTR('SHOWMETHEMONEY',7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',5,2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',1,6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',-8,6) FROM DUAL;

--�ֹε�Ϲ�ȣ���� ������ ��Ÿ���� ���ڸ� �����ؼ� , �̸�, �ֹε�Ϲ�ȣ, �������� ���
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE;

-- ���ڻ���鸸 ��ȸ
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';

-- ���ڻ���鸸 ��ȸ
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN('1','3');

-- �Լ� ��ø���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1) AS "���̵�"
FROM EMPLOYEE;

-----------------------------------------------------------------

/*

    *LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ��ְ� ��ȸ�ϰ��� �� �� ���
    
    [ǥ����]
    LPAD / RPAD(STRING, ���������� ��ȯ�� ������ ����, [�����̰��� �ϴ� ����] => ������� CHARCTER)
    
    ���ڿ��� �����̰����ϴ� ���ڸ� ���� �Ǵ� �����ʿ� �ٿ��� ���������� N���̸�ŭ ���ڿ��� ��ȯ
    
*/

--20��ŭ�� ���� �� EMAIL�÷����� ���������� �����ϰ� ������ �κ��� �������� ä���� ��ȸ
SELECT EMP_NAME, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20)
FROM EMPLOYEE;

--971015-1XXXXXX ��ȸ
SELECT RPAD('971015-1',14, '*')
FROM DUAL;

SELECT EMP_NAME, SUBSTR(EMP_NO,1,8) || '******'

--SELECT EMP_NAME, RPAD(�ֹε�Ϲ�ȣ�� �߶� �����ڵ������, 14, '*')
--SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,INSTR(EMP_NO,'-')+ 1), 14, '*') AS "�ֹε�Ϲ�ȣ"
--SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8), 14, '*') AS "�ֹε�Ϲ�ȣ"
FROM EMPLOYEE;


---------------------------------------------------------------

/*
    
    *LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    [ǥ����]
    LTRIM/RTRIM(STRING, [�����ϰ���� ���ڵ�]) => ������� CHARACTER
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ����ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ
*/

SELECT LTRIM('   K   H   ') FROM DUAL;
SELECT RTRIM('   K   H   ') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABAACCKHAC','ABC') FROM DUAL;

SELECT RTRIM('578284KH123447', '0123456789') FROM DUAL;

/*
    *TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    
    [ǥ����]
    TRIM([[] �����ϰ����ϴ� ���ڵ�  FROM ]STRING)
*/

SELECT TRIM('    K     H      ')FROM DUAL;
SELECT TRIM('Z' FROM 'ZZKHZZZ')FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZKHZZZ') FROM DUAL; -- LTRIM ����
SELECT TRIM(TRAILING 'Z' FROM 'ZZKHZZZ') FROM DUAL; --RTRIM ����
SELECT TRIM(BOTH 'Z' FROM 'ZZKHZZZ') FROM DUAL;-- ������ ���ÿ� ������, ������ �⺻��

/*

    *LOWER / UPPER / INITCAP
    
    [ǥ����]
    LOWER / UPPER / INITCAP(STRING) => ������� CHARACTER
    LOWER : ��� ���ڸ� �ҹ��ڷ� ������ ���ڿ� ��ȯ
    UPPER : ��� ���ڸ� �빮�ڷ� ������ ���ڿ� ��ȯ
    INITCAP : ���� �������� ù ���ڸ� �빮�ڷ� ������ ���ڿ��� ��ȯ
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!') FROM DUAL;
SELECT INITCAP('Welcome To My World!') FROM DUAL;

-----------------------------------------------------------------

/*
    *CONCAT
    ���ڿ� �� �� ���� �޾� �ϳ��� ��ģ �� ��ȯ => ����� CHARACTER
    
    [ǥ����]
    CONCAT(STRING, STRING)
*/

SELECT CONCAT('������', 'ABC') FROM DUAL; -- 2���ۿ� �ȵ�
SELECT '������'|| 'ABC' FROM DUAL;

---------------------------------------------------------------

/*
    *REPLACE
    Ư�� ���ڿ��� �����Ͽ� �ٸ� ���ڿ��� ��ü�Ͽ� ��ȯ
    
    [ǥ����]
    REPLACE(STRING(�������÷�), ã�Ƴ����ڿ�, ��ü�ҹ��ڿ�)
*/
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'KH.or.kr', 'naver.com')
FROM EMPLOYEE;

--------------------------------------------------------------

/*
    <���� ó�� �Լ�>
    
    *ABS
    ������ ���밪�� �����ִ� �Լ�
    
    ABS(NUMBER) => ����� NUMBER
*/
SELECT ABS(-10) FROM DUAL;
SELECT ABS(-5.7) FROM DUAL;

------------------------------------------------------------------

/*
    *MOD
    %�����ڿ� ���� - �� ���� ���� ���������� ��ȯ���ִ� �Լ�
    
    [ǥ��]
    MOD(NUMBER, NUMBER) => ����� NUMBER
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

------------------------------------------------------------------
/*
    *ROUND 
    �ݿø��� ����� ��ȯ
    
    [ǥ��]
    ROUND(NUMBER, [��ġ]) => ������� NUMBERŸ�� 
*/
SELECT ROUND(123.456, 1) FROM DUAL;
------------------QUIZ----------------------------
--�˻��ϰ��� �ϴ� ����
-- JOB_CODE�� J7�̰ų� J6�̸鼭 SALARY���� 200���� �̻��̰�
-- BONUS�� �ְ� �����̸� �̸����ּҴ� _�տ� 3���ڸ� �ִ� �����
-- �̸�, �ֹε�Ϲ�ȣ, �����ڵ�, �μ��ڵ�, �޿�, ���ʽ��� ��ȸ�ϰ� �ʹ�.
-- ���������� ��ȸ�� �ȴٸ� �������� 2���� �ุ ��ȸ�� �Ǿ�� �Ѵ�.

-- ���� ������ �ۼ��� SQL���� �Ʒ��� ����.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
 AND EMAIL LIKE '___\_%'ESCAPE '\' AND BONUS IS NOT NULL
 AND SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';

 
-- �� SQL�� ����� ���ϴ� ����� ����� ��ȸ���� �ʴ´�. � ���������� �ִ���
-- ��� ã�Ƽ� �����ϰ�, ��ġ�Ͽ� �Ϻ��� SQL���� �ۼ��غ���
--=============================================================

/*
    *CEIL
    �ø�ó���� ���� �Լ�
    
    [ǥ����]
    CEIL(NUMBER)
*/
SELECT CEIL(123.456) FROM DUAL;

/*
    *FLOOR
    ����ó�� �Լ�
    
    [ǥ����]
    FLORR(NUMBER)
*/
SELECT FLOOR(123.952) FROM DUAL;

/*
    *TRUNC
    ����ó�� �Լ�
    
    [ǥ����]
    TRUNC(NUMBER, [��ġ])
*/
SELECT TRUNC(123.952) FROM DUAL;
SELECT TRUNC(123.952, 1) FROM DUAL;
SELECT TRUNC(123.952, -1) FROM DUAL;
--==============================================================

/*
    <��¥ ó�� �Լ�>
*/
-- *SYSDATE : �ý����� ���� ��¥ �� �ð��� ��ȯ
SELECT SYSDATE FROM DUAL;

-- *MONTHS_BETWEEN : �� ��¥ ������ ���� �� -> ������� NUMBER
--�����, �Ի���, �ٹ��ϼ�, �ٹ� ���� ��
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE),
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '������' AS "�ټӰ���"
FROM EMPLOYEE;

-- *ADD_MONTHS : Ư�� ��¥�� NUMBER�������� ���ؼ� ��ȯ
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL;

--�ٷ��� ���̺��� �����, �Ի���, �Ի��� 6���� ���� ��¥
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) AS "������ ��ȯ��"
FROM EMPLOYEE;

-- *NEXT_DAY(DATE, ����(���� | ����)) : Ư����¥ ���� ���� ����� ������ ��¥�� ��ȯ
-- ��ȯ���� DATE

SELECT NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
-- 1 :��, 2: ������, 3: ȭ����...7:�����
SELECT NEXT_DAY(SYSDATE, 7) FROM DUAL;

--����
ALTER SESSION SET NLS_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- *LAST_DAY(DATE) : �ش� ���� ������ ��¥ ���ؼ� ��ȯ
--> ������� DATE
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--������̺��� �����, �Ի���, �Ի���� ������ ��¥, �Ի���� �ٹ��ϼ�
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    *EXTRACT : Ư�� ��¥�κ��� �⵵|��|�� ���� �����ؼ� ��ȯ�ϴ� �Լ�
    
    [ǥ����]
    EXTRACT(YEAR FROM DATE) : ������ ����
    EXTRACT(MONTH FROM DATE) : ����ŭ ����
    EXTRACT(DAY FROM DATE) : �ϸ�ŭ ����
    => ����� NUMBER
*/
--�����, �Ի�⵵, �Ի���, �Ի����� ��ȸ
SELECT EMP_NAME,
    EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵",
    EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի��",
    EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
FROM EMPLOYEE
--ORDER BY �Ի�⵵, �Ի��, �Ի���;
ORDER BY 2, 3, 4;

--=============================================================

/*
    <����ȯ �Լ�>
    *TO_CHAR : ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    [ǥ����]
    TO_CHAR(����|��¥,[����]) => ������ CHARACTER
*/

--- ����Ÿ�� -> ����Ÿ��
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5ĭ�� ���� Ȯ��, ������ ����, ��ĭ ����
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- ���� ���������� ��ĭ�� 0���� ä��
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- ���� ������ ������ ���� ȭ���� ����
SELECT TO_CHAR(1234, '$99999') FROM DUAL; -- ���� ������ ������ ���� ȭ���� ����

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

--����� �����, ���� ��ȸ
SELECT EMP_NAME, TO_CHAR(SALARY, 'L9,999,999') AS "����",
    TO_CHAR(SALARY * 12, 'L999,999,999') AS "����"
FROM EMPLOYEE;

--��¥ Ÿ�� => ����Ÿ��
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- AM�� ���� PM�� ���� ���Ŀ� ���缭 ���´�.
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 24�ð����� ǥ��
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

--������� �̸�, �Ի糯¥ (000�� 00�� 00��)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"')
FROM EMPLOYEE;

--�⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
    TO_CHAR(SYSDATE, 'YY'),
    TO_CHAR(SYSDATE, 'RRRR'),
    TO_CHAR(SYSDATE, 'RR'),
    TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

--���� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
        TO_CHAR(SYSDATE, 'MON'),
        TO_CHAR(SYSDATE, 'MONTH'),
         TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

--�Ͽ����� ����
SELECT TO_CHAR(SYSDATE, 'DDD'),-- ������ �̹��⵵�� ���° �ϼ�
       TO_CHAR(SYSDATE, 'DD'),-- �̹����� ��ĥ °
       TO_CHAR(SYSDATE, 'D')-- �̹����� ��ĥ °
FROM DUAL;

--���Ͽ����� ����
SELECT TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

--===========================================================

/*
    *TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ���� ��¥Ÿ������ �����ϴ� �Լ�
    
    *TO_DATE(���� | ����, [����]) => ��� DATE
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(500101) FROM DUAL; -- 50�� �̸��� �ڵ����� 20XX���� ���� 50�̻��� 19XX�� ����

SELECT TO_DATE(070101) FROM DUAL; -- ���ڴ� 0���� �����ϸ� �ȵ�
SELECT TO_DATE('070101') FROM DUAL;

--SELECT TO_DATE('041030 143000') -- ������ ������� ��,��,�ʸ� ǥ���� �� �ִ�.
--SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS')
SELECT TO_DATE('550630','YYMMDD'),
        TO_DATE('980630','YYMMDD') , 
        TO_DATE('980630','RRMMDD')-- 50�� �̸��� �ڵ����� 20XX���� ���� 50�̻��� 19XX�� ����
FROM DUAL; 

--================================================================

/*
    *TO_NUMBER : ����Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    [ǥ����] 
    TO_NUMBER(����, [����]) => ����� NUMBER
*/
SELECT TO_NUMBER('012341505405') FROM DUAL;

SELECT '100000' + '55000' FROM DUAL;
SELECT '100000' + '55,000' FROM DUAL; --������ ,�� �������̶� �׷��� ������ �������
SELECT TO_NUMBER('100,000','999,999') + TO_NUMBER('55,000','99,999')
FROM DUAL;

/*
    <NULL ó�� �Լ�> 
*/

--*NVL(�÷�, �ش��ø��� NULL�� ��� ������ ��)
SELECT EMP_NAME, NVL(BONUS, 0) AS "���ʽ�"
FROM EMPLOYEE;

--�� ����� �̸�, ���ʽ� ���� ����
SELECT EMP_NAME, (SALARY + (SALARY * NVL(BONUS, 0))) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '�μ�����')
FROM EMPLOYEE;

--*NVL2(�÷�, ��ȯ��1, ��ȯ��2)
--��ȯ�� 1 : �ش��÷��� ������ ��� ������ ��
--��ȯ�� 2 : �ش��ø��� NULL�� ��캸���� ��
SELECT EMP_NAME, BONUS, NVL2(BONUS, 'O', 'X')
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(DEPT_CODE, '�����Ϸ�','�̹���')
FROM EMPLOYEE;

--*NULLIF(�񱳴��1, �񱳴��2)
--�� �񱳴���� ���� ��ġ�ϸ� NULL �ƴϸ� �񱳴��1��ȯ
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

--==========================================================

/*
    <�����Լ�>
    *DECODE(���ϰ����ϴ� ���(�÷�|�������|�Լ���), �񱳰�1, �����1, �񱳰�2, �����2, ... �����(N)
    
    SWITCH(�񱳴��){
        CASE �񱳰�1:
            �����ڵ�1
        CASE �񱳰�2:
            �����ڵ�2
            ...
            DEFAULT:
        }
*/

--���, �����, �ֹι�ȣ, ����
SELECT EMP_ID, EMP_NAME, EMP_NO,
    DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��','�ܰ���') AS "����"
    FROM EMPLOYEE;
    
-- ������ �޿� ��ȸ�� �� ���޺��� �λ��ؼ� ��ȸ
-- J7�� ����� �޿��� 10% �λ��ؼ� (SALARY * 1.1)
-- J6�� ����� �޿��� 15% �λ��ؼ� (SALARY * 1.15)
-- J5�� ����� �޿��� 120% �λ��ؼ� (SALARY * 1.2)
-- J7�� ������� �޿��� 5% �λ� (SALARY * 1.05)

--�����, �����ڵ�, �����޿�, �λ�� �ݾ�
SELECT EMP_NAME, JOB_CODE, SALARY AS "�λ� ��",
    DECODE(JOB_CODE,
            'J7', SALARY * 1.1, 
            'J6', SALARY * 1.15,
            'J5', SALARY * 1,2,
                SALARY * 1.05) AS "�λ� ��"
    FROM EMPLOYEE;
    
/*
    *CASE WHEN THEN
    
    CASE WHEN ���ǽ�1 THEN �����1
        WHEN ���ǽ�1 THEN �����1
        ...
        ELSE �����N
    END
    
    �ڹٿ��� IF ELSE���� �����̴�.
    
*/
SELECT EMP_NAME SALARY,
        CASE WHEN SALARY >= 5000000 THEN '���'
            WHEN SALARY >= 350000 THEN '�߱�'
            ELSE '�ʱ�'
        END
FROM EMPLOYEE;

--===================<�׷��Լ�>============================

--1. SUM(����Ÿ���÷�) : �ش��÷� ������ �� �հ踦 ���ؼ� ��ȯ���ִ� �Լ�

--EMPLOYEE ���̺��� �� ��� �ѱ޿�
SELECT SUM(SALARY)
FROM EMPLOYEE;

--���ڻ������ �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN('1','3');

--�μ��ڵ尡 D5�� ������� �� ����
SELECT SUM(SALARY * 12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--2. AVG(NUMBER) : �ش� �÷������� ��հ��� ���ؼ� ��ȯ
SELECT ROUND (AVG(SALARY))
FROM EMPLOYEE;


--3. MIN(��� Ÿ�� ����) : �ش� �÷��� �� ���� ���� �� ���ؼ� ��ȯ
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

--4. MAB(��� Ÿ�� ����) : �ش� �÷����� �߿� ���� ū ���� ���ؼ� ��ȯ
SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

--5. COUNT(*|�÷�|DISTINCT �÷�) : �ش� ���ǿ� �´� ���� ������ ���� ��ȯ
--COUNT(*) : ��ȸ�� ����� ��� ���� ������ ���� ��ȯ
--COUNT(�÷�) : ������ �ش� �÷����� NULL�� �ƴ� �͸� ���� ������ ���� ��ȯ
--COUNT(DISTINCT �÷�) : �ش� �÷����� �ߺ��� ������ �� �� ���� ���� ��ȯ

--��ü ��� ��
SELECT COUNT(*)
FROM EMPLOYEE;

--���� ��� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2','4');

--���ʽ��� �޴� ��� ��
SELECT COUNT(BONUS) -- �÷����� ������ �����ϴ� ���� ���ڸ� ���ش�.
FROM EMPLOYEE;

--�μ���ġ�� ���� ��� ��
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

--���� ������� �� �� ���� �μ��� �����Ǿ� �ִ��� ��ȸ
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;