SELECT *
  FROM tabs;
SELECT *
  FROM user_sequences;

-- PhoneBook

SELECT *
  FROM person
 ORDER BY id;

CREATE TABLE person (
    id          NUMBER(10),
    name        VARCHAR2(100)   NOT NULL,
    hp          VARCHAR2(500)   NOT NULL,
    company     VARCHAR2(500),
    PRIMARY KEY (id)
);

CREATE SEQUENCE seq_person_id
INCREMENT BY 1
 START WITH 10
NOCACHE;

INSERT INTO person
VALUES (seq_person_id.NEXTVAL, '이름', '010-1234-5678', '010-1234-5678');

SELECT name
       ,hp
       ,company
  FROM person
 ORDER BY id DESC;

SELECT name
       ,hp
       ,company
  FROM person
 WHERE name LIKE '%름%';

UPDATE person
   SET name = 'jiho'
       ,hp = '010-1234-5678'
       ,company = '010-1234-5678'
 WHERE id = 23;

DELETE FROM person
 WHERE id = 50;

RENAME phone TO person;

COMMIT;

--------------------------------------------------------------------------------

-- GuestBook

SELECT *
  FROM guest
 ORDER BY no;

CREATE TABLE guest (
    no          NUMBER,
    name        VARCHAR2(80),
    password    VARCHAR2(20),
    content     VARCHAR2(2000),
    reg_date    date,
    PRIMARY KEY (no)
);

CREATE SEQUENCE seq_guest_id
INCREMENT BY 1
 START WITH 1
NOCACHE;

INSERT INTO guest
VALUES (seq_guest_id.NEXTVAL, '이름', '1234', '안녕하세요', sysdate);

SELECT no
       ,name
       ,password
       ,content
       ,reg_date
  FROM guest
 ORDER BY no;

COMMIT;

--------------------------------------------------------------------------------

-- MySite

DROP TABLE board;
DROP SEQUENCE seq_board_no;

CREATE TABLE users (
    no          NUMBER,
    id          VARCHAR2(20)    UNIQUE NOT NULL,
    password    VARCHAR2(20)    NOT NULL,
    name        VARCHAR2(20),
    gender      VARCHAR2(10),
    PRIMARY KEY (no)
);

CREATE SEQUENCE seq_users_id
INCREMENT BY 1
 START WITH 1
NOCACHE;

CREATE TABLE board (
    no          NUMBER,
    title       VARCHAR2(500)   NOT NULL,
    content     VARCHAR2(4000),
    hit         NUMBER,
    reg_date    DATE            NOT NULL,
    user_no,
    PRIMARY KEY (no),
    CONSTRAINT board_fk FOREIGN KEY (user_no)
    REFERENCES users(no)
);

CREATE SEQUENCE seq_board_no
INCREMENT BY 1
 START WITH 1
NOCACHE;

CREATE TABLE rboard (
    no          NUMBER,
    user_no     NUMBER,
    title       VARCHAR2(500),
    content     VARCHAR2(4000),
    hit         NUMBER,
    reg_date    DATE,
    group_no    NUMBER,
    order_no    NUMBER,
    depth       NUMBER,
    show        VARCHAR2(10),
    PRIMARY KEY (no),
    CONSTRAINT  rboard_fk FOREIGN KEY (user_no)
    REFERENCES  users(no)
);

CREATE SEQUENCE seq_rboard_no
INCREMENT BY 1
 START WITH 1
NOCACHE;

CREATE TABLE gallery (
    no          NUMBER,
    user_no     NUMBER,
    content     VARCHAR2(1000),
    filePath    VARCHAR2(500),
    orgName     VARCHAR2(200),
    saveName    VARCHAR2(500),
    fileSize    NUMBER,
    PRIMARY KEY (no),
    CONSTRAINT  gallery_fk FOREIGN KEY (user_no)
    REFERENCES  users(no)
);

CREATE SEQUENCE seq_gallery_no
INCREMENT BY 1
 START WITH 1
NOCACHE;

DROP TABLE rboard;
DROP SEQUENCE seq_rboard_no;

INSERT INTO users
VALUES (0, 'undefined', '1234', 'undefined', 'female');
INSERT INTO users
VALUES (seq_users_id.NEXTVAL, 'manager', '1234', '이름', 'female');

INSERT INTO board
VALUES (seq_board_no.NEXTVAL, '제목', '안녕하세요', 0, sysdate, 1);

INSERT INTO rboard
VALUES (seq_rboard_no.NEXTVAL, 2, '제목', '안녕하세요', 0, sysdate, seq_rboard_no.NEXTVAL, 1, 0, 'Y');

SELECT *
  FROM users
 ORDER BY no;

SELECT *
  FROM board
 ORDER BY no DESC;

SELECT *
  FROM rboard
 ORDER BY no DESC;

SELECT *
  FROM gallery
 ORDER BY no DESC;

SELECT no
       ,id
       ,password
       ,name
       ,gender
  FROM users
 WHERE id = 'manager'
   AND password = '1234';

SELECT id
  FROM users
 WHERE id = 'manager';

SELECT b.no
       ,b.title
       ,b.content
       ,b.hit
       ,TO_CHAR(b.reg_date, 'YY-MM-DD HH24:MI') regDate 
       ,u.no
       ,u.name
  FROM board b, users u
 WHERE b.user_no = u.no
 ORDER BY b.no DESC;

SELECT b.no
       ,b.title
       ,b.content
       ,b.hit
       ,TO_CHAR(b.reg_date, 'YY-MM-DD HH24:MI') regDate 
       ,u.no
       ,u.name
  FROM board b, users u
 WHERE b.user_no = u.no
 ORDER BY b.no ASC;

SELECT ort.rn
       ,ort.no
       ,ort.title
       ,ort.content
       ,ort.hit
       ,ort.regDate
       ,ort.userNo
       ,ort.userName
  FROM (SELECT ROWNUM rn
               ,ot.no
               ,ot.title
               ,ot.content
               ,ot.hit
               ,ot.regDate
               ,ot.userNo
               ,ot.userName
          FROM (SELECT b.no
                       ,b.title
                       ,b.content
                       ,b.hit
                       ,TO_CHAR(b.reg_date, 'YY-MM-DD HH24:MI') regDate 
                       ,u.no userNo
                       ,u.name userName
                  FROM board b, users u
                 WHERE b.user_no = u.no
                 ORDER BY b.no ASC) ot
       ) ort
 WHERE ort.rn >= 11
   AND ort.rn <= 20;

SELECT ort.rn
       ,ort.no
       ,ort.title
       ,ort.content
       ,ort.hit
       ,ort.regDate
       ,ort.userNo
       ,ort.userName
  FROM (SELECT ROWNUM rn
               ,ot.no
               ,ot.title
               ,ot.content
               ,ot.hit
               ,ot.regDate
               ,ot.userNo
               ,ot.userName
          FROM (SELECT b.no
                       ,b.title
                       ,b.content
                       ,b.hit
                       ,TO_CHAR(b.reg_date, 'YY-MM-DD HH24:MI') regDate 
                       ,u.no userNo
                       ,u.name userName
                  FROM board b, users u
                 WHERE b.user_no = u.no
                   AND b.title LIKE '%1%'
                 ORDER BY b.no ASC) ot
       ) ort
 WHERE ort.rn >= 1
   AND ort.rn <= 16;

SELECT COUNT(*)
  FROM board;

SELECT COUNT(*)
  FROM board
 WHERE title LIKE '%1%';

SELECT b.no
       ,b.title
       ,b.content
       ,b.hit
       ,TO_CHAR(b.reg_date, 'YY-MM-DD HH24:MI') regDate
       ,u.no userNo
       ,u.name userName
  FROM board b, users u
 WHERE b.user_no = u.no
   AND b.title LIKE '%안녕%';

SELECT r.no
       ,u.no userNo
       ,u.name userName
       ,r.title
       ,r.content
       ,r.hit
       ,TO_CHAR(r.reg_date, 'YY-MM-DD HH24:MI') regDate
       ,r.group_no
       ,r.order_no
       ,r.depth
       ,r.show
  FROM rboard r, users u
 WHERE r.user_no = u.no
 ORDER BY r.group_no DESC, r.order_no ASC;

SELECT no
       ,group_no
       ,order_no
       ,depth
  FROM rboard
 WHERE group_no = 4
   AND order_no IN (SELECT MAX(order_no)
                      FROM rboard
                     WHERE group_no = 4
                     GROUP BY group_no);

SELECT order_no
       ,depth
  FROM rboard
 WHERE group_no = 13
   AND order_no = 1;

SELECT g.no
       ,u.no
       ,u.name
       ,g.content
       ,g.filePath
       ,g.orgName
       ,g.saveName
       ,g.fileSize
  FROM gallery g, users u
 WHERE g.user_no = u.no;

SELECT g.no
       ,u.no
       ,u.name
       ,g.content
       ,g.filePath
       ,g.orgName
       ,g.saveName
       ,g.fileSize
  FROM gallery g, users u
 WHERE g.user_no = u.no
   AND g.no = 3;

UPDATE users
   SET no = 3
 WHERE no = 4;

UPDATE users
   SET password = '1234'
       ,name = '이름'
       ,gender = 'female'
 WHERE no = 7;

UPDATE board
   SET hit = (SELECT hit
                FROM board
               WHERE no = 9)+1
 WHERE no = 9;

UPDATE rboard
   SET title = '삭제'
       ,content = '삭제'
       ,user_no = 0
 WHERE no = 6;

UPDATE board
   SET title = '안녕'
       ,content = '안녕'
 WHERE no = 9;

DELETE FROM board
 WHERE no = 9;

COMMIT;