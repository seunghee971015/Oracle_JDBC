/*
    *�������� (SUBQUERY)
    - �ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT��
    - ���� SQL���� ���� ���� ������ �ϴ� ������
*/

--������ �������� ����1.
-- ���ö ����� ���� �μ��� ���� ����� ��ȸ
--1) ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; -- D9

--2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ���� �δܰ踦 �ϳ��� ����������!
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE DEPT_CODE = ���ö����� �μ��ڵ�
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');
                    
--������ �������� ����2
--�� ������ ��� �޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
--1) �� ������ ��� �޿� ��ȸ
SELECT rOUND(AVG(SALARY))
FROM EMPLOYEE; -- 3047663

--2)3047663���� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿���ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

--�� �ܰ踦 �ϳ��� ���غ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT ROUND(AVG(SALARY))
                    FROM EMPLOYEE);

/*
    *���������� ����
    ���������� ������ ������� ���� ��� �����Ŀ� ���� �з���
    
    - ������ �������� : ���������� ��ȸ ������� ������ ������ 1���� ��(������ �ѿ�)
    - ������ �������� : ���������� ��ȸ ������� �������� ��(������ �ѿ�)
    - ���߿� �������� : ���������� ��ȸ ������� �� �������� �÷��� �������� ��(���� ������)
    - ������ ���߿� �������� : ���������� ��ȸ ������� ������ �����÷��� �� (������ ������)
    
    >> ���������� ������ ���Ŀ� ���� �������� �տ� �ٴ� �����ڰ� �޶���
*/

/*
    1. ������ ��������
    ���������� ��ȸ ������� ������ ������ 1���� ��(���� �ѿ�)
    �Ϲ� �񱳿����� ��� ����
    = != ? > <...
*/

--1) �� ������ ��� �޿����� �޿��� �� ���Թ޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                    FROM EMPLOYEE)
ORDER BY(JOB_CODE);

--2) �����޿��� �޴� ����� ���, �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
--WHERE SALARY = ������� �� �����޿�
WHERE SALARY =(SELECT MIN(SALARY)
                FROM EMPLOYEE);
                
--3) ���ö ����� �޿����� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿���ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE SALARY > ���ö ����� �޿�;
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
--4) ���ö ����� �޿����� ���� �޴� ������� ���, �̸�, �μ���, �޿���ȸ
--����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE E, DEPARTMENT D
WHERE DEPT_CODE = DEPT_ID AND SALARY > (SELECT SALARY
                                        FROM EMPLOYEE
                                        WHERE EMP_NAME = '���ö');
--ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
--GROUP BY ����
--4) �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿���
--4_1) �μ��� �޿����߿��� ���� ū �� �ϳ��� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- 17700000
--4_2) �μ��� �޿����� 17700000�� �μ��� �μ��ڵ�
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

--�� �� ������ ���غ���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);
                        
--������ ����� ���� �μ��� ������� ���, �����, ��ȭ��ȣ, �Ի���, �μ����� ��ȸ
--�� ������ ����� ����
--> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
        AND DEPT_CODE = (SELECT DEPT_CODE
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '������')
        AND EMP_NAME != '������';
--> ANSI ����
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
        AND EMP_NAME != '������';
        
--------------------------------------------------------
/*
    2. ������ ��������
    ���������� ������ ������� �������� �� (�÷��� �Ѱ�)
    
    IN (��������) : �������� ����� �߿��� �� ���� ��ġ�ϴ� ���� �ִٸ� ��ȸ
    > ANY (��������) : �������� ����� �߿��� �� ���� Ŭ ���
    < ANY (��������) : �������� ����� �߿��� �� ���� ���� ���
    �񱳴�� > ANY ((���������� ����� =)��1,��2,��3)
    �񱳴�� > ��1 OR �񱳴�� > ��2 OR �񱳴�� > ��3
    
    > ALL (��������) : �������� ��� ������麸�� Ŭ ���
    < ALL (��������) : �������� ��� ������麸�� ���� ���
        �񱳴�� > ALL ((���������� ����� =)��1,��2,��3)
        �񱳴�� > ��1 AND ��2 > AND �񱳴�� > ��3
*/

--1) ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿�
--1_1) ����� �Ǵ� ������ ����� �����ڵ�
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('������','�����'); -- J3, J7 -- IN() : OR

--1_2) J3,J7�� ������ ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN('J3','J7');

--�� ������ ���������� ���� ���غ���
 SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN(SELECT JOB_CODE
                  FROM EMPLOYEE
                  WHERE EMP_NAME 
                  IN ('������','�����'));
                  
--2) �븮 �����ӿ��� ���� ���� �޿��� �� �ּ� �޿����� ���� �޴� ������ ��ȸ
--(���, �̸�, ����, �޿�)
--2_1) ���� ���� �޿���
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'; --3760000,2200000,2500000

--2_2) �븮�����̸鼭 ���� ��������� �ϳ��� ū ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
        AND SALARY > ANY (2200000, 2500000, 3760000)
        AND JOB_NAME IN('�븮');

--�� ������ ��������
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
        AND SALARY > ANY (SELECT SALARY
                          FROM EMPLOYEE
                          JOIN JOB USING(JOB_CODE)
                          WHERE JOB_NAME = '����')
        AND JOB_NAME ='�븮';
        
--���������� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
        AND SALARY > (SELECT MIN(SALARY)
                      FROM EMPLOYEE
                      JOIN JOB USING(JOB_CODE)
                      WHERE JOB_NAME = '����')
        AND JOB_NAME ='�븮';
------------------------------------------------------------
/*
    3. ���߿� ��������
    ������� �� �������� ������ �÷����� �������� ���
*/

--1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ
--(�����, �μ��ڵ�, �����ڵ�, �Ի���)
-->������ ���������� ��������
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������') -- ����������� �μ��ڵ�
        AND JOB_CODE = (SELECT JOB_CODE
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '������');
--���߿� ���������� �ۼ�       
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '������');
                                
--�ڳ��� ����� ���� �����ڵ�, ���� ����� �������ִ� ������� ���, �����, �����ڵ�, ����ڵ� ��ȸ
--1) �ڳ��� ����� �����ڵ�, ����ڵ带 ��ȸ
SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '�ڳ���'; --J7	207

--1_2)J7	207�� ������� ���� ������� ���, �����, �����ڵ�, �����ȣ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' AND MANAGER_ID = 207;

--�� ������ ��ħ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���')
        AND EMP_NAME != '�ڳ���';
        
----------------------------------------------------------------------
/*
    4. ������ ���߿� ��������
    ���������� ��ȸ ������� ������ �������� ���(���̺� �ϳ�)
*/

--1) �� ���޺� �ּұ޿��� �޴� ��� ��ȸ(���, �����, �����ڵ�, �޿�)
--> �� ���޺� �ּұ޿�
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;
/*
J2	3700000
J7	1380000
J3	3400000
J6	2000000
J5	2200000
J1	8000000
J4	1550000
*/
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
    OR JOB_CODE = 'J7' AND SALARY = 1380000
    OR JOB_CODE = 'J3' AND SALARY = 3400000;

--���������� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                              FROM EMPLOYEE
                              GROUP BY JOB_CODE);
--2) �� �μ��� �ְ�޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE)
ORDER BY EMP_ID;

-----------------------------------------------------
--�� WHERE������ ���������� ���°� �ƴ�

/*
    5. �ζ��� ��(���� ���̺��� �ƴ϶� RESULT SET �� �������)
    FROM���� ���������� �ۼ��� ��
    ���������� ������ ����� ��ġ ���̺�ó�� ���
*/

--������� ���, �̸�, ���ʽ����Կ���, �μ��ڵ� ��ȸ
--�� ���ʽ����� ������ NULL�� �Ǹ� �ȵȴ�.
--�� ���ʽ� ���� ������ 3000���� �̻��� ����鸸 ��ȸ�غ���

SELECT ROWNUM,EMP_ID, EMP_NAME, SALARY + (SALARY * NVL(BONUS,0)) * 12 AS "����", DEPT_CODE
FROM EMPLOYEE
WHERE(SALARY + (SALARY * NVL(BONUS,0))) * 12 >= 3000000
ORDER BY ���� DESC;

--> �ζ��κ並 �ַ� ����ϴ� ��>> TOP-N�м� : ���� ��� ��ȸ
--�� ���� �� �޿��� ���� ���� 5�� ��ȸ
-- *ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-->ORDER BY���� ����� ����� ������ ROWNUM �ο� �� 5�� �߸���
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC) E -- �տ��Ű� ���̺�, ��Ī�ٿ��� ���� ���
WHERE ROWNUM <=5;

--���� �ֱٿ� �Ի��� ��� 5�� ��ȸ(�����, �޿�, �Ի���)
SELECT ROWNUM, EMP_NAME, SALARY, HIRE_DATE
FROM (SELECT EMP_NAME, SALARY, HIRE_DATE
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC) E
WHERE ROWNUM <= 5;

--�� �μ��� ��ձ޿������� 3���� �μ���ȸ
-- �μ��ڵ�, ��ձ޿��� ��Ÿ����
SELECT DEPT_CODE, FLOOR(��ձ޿�)
FROM (SELECT DEPT_CODE, AVG(SALARY) AS "��ձ޿�"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY 2 DESC) --FROM���� ���̺� �������� ROWNUM �ڵ����� ����
WHERE ROWNUM <= 3;

---------------------------------------------------

/*
    *������ �ű�� �Լ� (WINDOW FUNCTION)
    RANK() OVER(���ı���) | DANSE_RANK() OVER(���ı���)
    RACK() OVER(���ı���) : ������ ���� ������ ����� ������ �ο� �� ��ŭ �ǳʶٰ� �������
    DANSE_RANK() OVER(���ı���) : ������ ������ �ֵ��� �ص� �� ���� ����� ������ 1�� ������Ŵ
    
    -������ SELECT�������� ����� �����ϴ�.
*/
--�޿��� ���� ������� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, RANK() OVER(ORDER BY SALARY DESC) AS "����", SALARY
FROM EMPLOYEE;
--> ���� 19�� 2�� �� ���� ����� 21������ �ϳ� �ǳ� �� �� �� �� �ִ�.
SELECT EMP_NAME, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����", SALARY
FROM EMPLOYEE
--> 19���� ���������� �� �ڿ� 20���� �ٷ� ������ ���� �� �� �ִ�.

SELECT *
FROM (SELECT EMP_NAME, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����", SALARY
        FROM EMPLOYEE)
WHERE ���� <=5;

-------------------------����-----------------------------------
--1) ROWNUM�� Ȱ���ؼ� �޿��� ���� ���� 5���� ��ȸ�ϰ� �;�����, ����� ��ȸ�� ���� �ʴ´�.
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5;
 ORDER BY SALARY DESC
--�������� �����ϰ�(����) : �ڵ尡 ����Ǵ� ������ ������ �Ǳ⵵ ���� 5���� �̹� �߷�����.
--�����ڵ�(��ġ) : 
SELECT *
FROM (SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

--2) �μ��� ��ձ޿��� 270������ �ʰ��ϴ� �μ��鿡 ����(�μ��ڵ�, �μ��� �� �޿���, �μ��� ��ձ޿�, �μ��� �����)�� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) AS "����", FLOOR(AVG(SALARY)) AS "���", COUNT(*) AS �ο���
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

--������(����) : 
--�����ڵ�(��ġ) :
SELECT *
FROM (SELECT DEPT_CODE, SUM(SALARY) AS "����", FLOOR(AVG(SALARY)) AS "���", COUNT(*) AS �ο��� 
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY DEPT_CODE ASC)
WHERE ��� >= 2700000;