-- ���� �ּ�
/*
������ �ּ�
*/

-- RESULT SET -> �ڵ带 �����ؼ� ������ ����� 
select * from tab;

--kh(��ҹ��� ���о���)��� ������ ����� ��й�ȣ�� 
--kh(��ҹ��� ������)�� �ϰڴ�
-- CREATE USER ������ IDENTIFIED BY ��й�ȣ;
CREATE USER kh IDENTIFIED BY kh;

--������ �����Ŀ��� ������ ������ �ο��ؾ� ����ϴ� �ǹ̰� �ִ�.
-- GRANT ����1, ����2 ... TO ������;
GRANT RESOURCE, CONNECT TO KH;
