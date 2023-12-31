CREATE TABLE TB_SHOES_PRODUCT(
    PCODE NUMBER PRIMARY KEY, --상품번호
    PNAME VARCHAR2(30) NOT NULL, --상품명
    BRAND VARCHAR2(30) NOT NULL, --브랜드
    SHOE_SIZE NUMBER NOT NULL, --사이즈
    PRICE NUMBER, --가격
    STOCK NUMBER DEFAULT 0 --재고
);

CREATE SEQUENCE SEQ_PCODE
START WITH 200
NOCACHE;

CREATE TABLE TB_PRODETAIL(
    DECODE NUMBER PRIMARY KEY, --이력번호
    PCODE NUMBER REFERENCES TB_SHOES_PRODUCT, --상품번호
    PDATE DATE NOT NULL, --입출고일
    AMOUNT NUMBER NOT NULL, --입출고수량
    STATUS CHAR(6) CHECK(STATUS IN ('입고', '출고')) --상태(입고, 출고)
);

CREATE SEQUENCE SEQ_DECODE
NOCACHE;

UPDATE TB_SHOES_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    IF(:NEW.STATUS = '입고')
        THEN UPDATE TB_SHOES_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    IF(:NEW.STATUS = '출고')
        THEN UPDATE TB_SHOES_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    
END;
/

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 200, SYSDATE, 5, '입고');
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 200, SYSDATE, 2, '입고');