/* 계정 생성 */
CREATE USER magnolia IDENTIFIED BY magnolia;

/* 권한 부여 */
GRANT RESOURCE, CONNECT TO magnolia;


/* Drop Tables */
DROP TABLE customer_tbl;
DROP SEQUENCE seq_board_no;

COMMIT;
ROLLBACK;
SELECT * FROM TAB;
SELECT * FROM user_sequences;
purge recyclebin;

-------------------------------------------------------

CREATE TABLE customer_tbl (
    id        VARCHAR2(20)  NOT NULL,
    password  VARCHAR2(100) NOT NULL,
    name      VARCHAR2(20)  NOT NULL,
    birthday  DATE          NOT NULL,
    address   VARCHAR2(150) NOT NULL,
    hp        VARCHAR2(13)  NOT NULL,
    email     VARCHAR2(50)  NOT NULL,
    reg_date  TIMESTAMP     DEFAULT sysdate,
    point     NUMBER        DEFAULT 0,
	PRIMARY KEY (id)
);

SELECT *
  FROM customer_tbl
 ORDER BY reg_date DESC;

INSERT INTO customer_tbl
VALUES ('manager', '1234', '매니저', '23/10/03', '서울 강남구 가로수길 10-101호', '010-2345-6789', 'a@naver.com', sysdate, 200000);

-------------------------------------------------------

CREATE TABLE customer_tbl2 (
    id        VARCHAR2(20)  NOT NULL,
    password  VARCHAR2(100) NOT NULL,
    name      VARCHAR2(20)  NOT NULL,
    birthday  DATE          NOT NULL,
    address   VARCHAR2(150) NOT NULL,
    hp        VARCHAR2(13),
    email     VARCHAR2(50)  NOT NULL,
    reg_date  TIMESTAMP     DEFAULT sysdate,
    point     NUMBER        DEFAULT 0,
    authority VARCHAR2(30)  DEFAULT 'ROLE_USER',  -- 권한 : ROLE_USER:customer, ROLE_ADMIN:관리자
    enabled   CHAR(1)       DEFAULT 0,            -- 계정사용 가능여부(1:사용가능, 0:사용불가) : 이메일인증시 1로 update
    key       VARCHAR2(100),                      -- 회원가입시 이메일 key 추가
	PRIMARY KEY (id)
);

-- 시큐리티를 위한 추가 AUTHORITY ENABLED KEY

select * from customer_tbl
ORDER BY id ASC;

INSERT INTO customer_tbl (id, password, name, birthday, address, hp, email, regDate)
VALUES ('z', 'z', 'z', '22/03/13', '서울 강남구 가로수길 10-101호', '010-2345-6789', 'a@naver.com', sysdate);

UPDATE customer_tbl
    SET authority = 'ROLE_ADMIN'
 WHERE id = 'admin';

DELETE FROM customer_tbl
WHERE id = 'admin';

SELECT *
FROM (
SELECT A.* , rownum as rn
    FROM (
    SELECT * 
        FROM customer_tbl
        ORDER BY id DESC
        ) A 
    )
    WHERE rn BETWEEN 1 AND 2 ;