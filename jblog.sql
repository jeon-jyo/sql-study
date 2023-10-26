/* 계정 생성 */
CREATE USER jblog IDENTIFIED BY jblog;

/* 권한 부여 */
GRANT RESOURCE, CONNECT TO jblog;

/* Drop Tables */
DROP TABLE USERS;
DROP TABLE BLOG;
DROP TABLE CATEGORY;
DROP TABLE POST;
DROP TABLE COMMENTS;
DROP SEQUENCE SEQ_USERS_NO;
DROP SEQUENCE SEQ_CATEGORY_NO;
DROP SEQUENCE SEQ_POST_NO;
DROP SEQUENCE SEQ_COMMENTS_NO;

SELECT *
  FROM users;
SELECT *
  FROM blog;
SELECT *
  FROM category;
SELECT *
  FROM post;
SELECT *
  FROM comments;

COMMIT;
ROLLBACK;
SELECT * FROM TAB;
SELECT * FROM user_sequences;
purge recyclebin;

-------------------------------------------------------

CREATE TABLE users (
    userNo      NUMBER,
    id          VARCHAR2(50)    NOT NULL    UNIQUE,
    userName    VARCHAR2(100)   NOT NULL,
    password    VARCHAR2(50)    NOT NULL,
    joinDate    DATE            NOT NULL,
    PRIMARY KEY (userNo)
);

CREATE SEQUENCE seq_users_no
INCREMENT BY 1
 START WITH 1
NOCACHE;

CREATE TABLE blog (
    id          VARCHAR2(50),
    blogTitle   VARCHAR2(200)   NOT NULL,
    logoFile    VARCHAR2(200),
    PRIMARY KEY (id),
    CONSTRAINT blog_users_fk FOREIGN KEY (id)
    REFERENCES users(id)
);

CREATE TABLE category (
    cateNo      NUMBER,
    id          VARCHAR2(50),
    cateName    VARCHAR2(200)   NOT NULL,
    description VARCHAR2(500),
    regDate     DATE            NOT NULL,
    PRIMARY KEY (cateNo),
    CONSTRAINT category_blog_fk FOREIGN KEY (id)
    REFERENCES blog(id)
);

CREATE SEQUENCE seq_category_no
INCREMENT BY 1
 START WITH 1
NOCACHE;

CREATE TABLE post (
    postNo      NUMBER,
    cateNo      NUMBER,
    postTitle   VARCHAR2(300)   NOT NULL,
    postContent VARCHAR2(4000),
    regDate     DATE            NOT NULL,
    PRIMARY KEY (postNo),
    CONSTRAINT post_category_fk FOREIGN KEY (cateNo)
    REFERENCES category(cateNo)
);

CREATE SEQUENCE seq_post_no
INCREMENT BY 1
 START WITH 1
NOCACHE;

CREATE TABLE comments (
    cmtNo       NUMBER,
    postNo      NUMBER,
    userNo      NUMBER,
    cmtContent  VARCHAR2(1000)  NOT NULL,
    regDate     DATE            NOT NULL,
    PRIMARY KEY (cmtNo),
    CONSTRAINT comments_post_fk FOREIGN KEY (postNo)
    REFERENCES post(postNo),
    CONSTRAINT comments_users_fk FOREIGN KEY (userNo)
    REFERENCES users(userNo)
);

CREATE SEQUENCE seq_comments_no
INCREMENT BY 1
 START WITH 1
NOCACHE;

-------------------------------------------------------

SELECT *
  FROM users;
SELECT *
  FROM blog;
SELECT *
  FROM category;
SELECT *
  FROM post;
SELECT *
  FROM comments;

SELECT userNo
       ,id
       ,userName
  FROM users
 WHERE id = 'manager'
   AND password = '1234';

SELECT u.userNo
       ,u.userName
       ,u.id
       ,b.blogTitle
       ,b.logoFile
  FROM users u, blog b
 WHERE u.id = b.id
   AND u.id = '22';

SELECT cateNo
       ,id
       ,cateName
       ,description
       ,regDate
  FROM category
 WHERE cateNo = '1';

SELECT count(postNo) cnt, cateNo
  FROM post
 GROUP BY cateNo;

SELECT c.cateNo
       ,c.id
       ,c.cateName
       ,c.description
       ,c.regDate
       ,NVL(p.cnt, 0)
  FROM category c, (SELECT NVL(count(postNo),0) cnt, cateNo
                      FROM post
                     GROUP BY cateNo
                    ) p
 WHERE c.cateNo = p.cateNo(+)
   AND c.id = '22'
 ORDER BY cateNo DESC;

SELECT c.cateNo
       ,c.id
       ,c.cateName
       ,c.description
       ,c.regDate
       ,NVL(p.cnt, 0)
  FROM category c
  LEFT OUTER JOIN (SELECT NVL(count(postNo),0) cnt, cateNo
                     FROM post
                    GROUP BY cateNo
                  ) p
    ON c.cateNo = p.cateNo
 WHERE c.id = '22'
 ORDER BY cateNo DESC;

SELECT ROWNUM rn
       ,ot.cateNo
       ,ot.id
       ,ot.cateName
       ,ot.description
       ,ot.postCnt
  FROM (SELECT c.cateNo
               ,c.id
               ,c.cateName
               ,c.description
               ,NVL(p.cnt, 0) postCnt
          FROM category c
          LEFT OUTER JOIN (SELECT count(postNo) cnt, cateNo
                             FROM post
                            GROUP BY cateNo
                          ) p
            ON c.cateNo = p.cateNo
         WHERE c.id = '22'
         ORDER BY cateNo ASC
       ) ot
 ORDER BY rn DESC;

SELECT ot.cnt rn
       ,c.cateNo
       ,c.id
       ,c.cateName
       ,c.description
       ,NVL(NULL, 0) postCnt
  FROM category c, (SELECT count(cateNo) cnt
                      FROM category
                     WHERE id = '11'
                   ) ot
 WHERE c.cateNo = '6';

SELECT postNo
       ,cateNo
       ,postTitle
       ,postContent
       ,TO_CHAR(regDate, 'YYYY/MM/DD') regDate
  FROM post
 WHERE postNo IN (SELECT MAX(postNo) no
                    FROM post
                   WHERE cateNo = '10'
                 );

SELECT postNo
       ,cateNo
       ,postTitle
       ,postContent
       ,TO_CHAR(regDate, 'YYYY/MM/DD') regDate
  FROM post
 WHERE cateNo = '10'
 ORDER BY postNo DESC;

SELECT c.cmtNo
       ,c.postno
       ,u.userno
       ,u.username
       ,c.cmtcontent
       ,TO_CHAR(c.regDate, 'YYYY/MM/DD') regDate
  FROM comments c, users u
 WHERE postno = '3'
   AND c.userno = u.userno;

SELECT c.cmtNo
       ,c.postno
       ,c.userno
       ,u.username
       ,c.cmtcontent
       ,TO_CHAR(c.regDate, 'YYYY/MM/DD') regDate
  FROM comments c, users u
 WHERE cmtNo IN (SELECT MAX(cmtNo)
                   FROM comments
                  WHERE postno = '3')
   AND c.postno = '3'
   AND c.userno = u.userno;

SELECT ot.cnt rn
       ,c.cateNo
       ,c.id
       ,c.cateName
       ,c.description
       ,NVL(NULL, 0) postCnt
  FROM category c, (SELECT count(cateNo) cnt
                      FROM category
                     WHERE id = '11'
                   ) ot
 WHERE c.cateNo = '6';

SELECT MAX(cmtNo)
  FROM comments
 WHERE postno = '3';

SELECT c.cmtNo
       ,c.postno
       ,c.userno
       ,u.username
       ,c.cmtcontent
       ,TO_CHAR(c.regDate, 'YYYY/MM/DD') regDate
  FROM comments c, users u
 WHERE cmtNo IN (SELECT count(cmtNo)
                   FROM comments
                  WHERE postno = '3')
   AND postno = '3'
   AND c.userno = u.userno;

SELECT ort.rn
       ,ort.postNo
       ,ort.cateNo
       ,ort.postTitle
       ,ort.postContent
       ,ort.regDate
  FROM (SELECT ROWNUM rn
               ,ot.postNo
               ,ot.cateNo
               ,ot.postTitle
               ,ot.postContent
               ,ot.regDate
          FROM (SELECT postNo
                       ,cateNo
                       ,postTitle
                       ,postContent
                       ,TO_CHAR(regDate, 'YYYY/MM/DD') regDate
                  FROM post
                 WHERE cateNo = '10'
                 ORDER BY postNo DESC) ot
       ) ort
 WHERE ort.rn >= 1
   AND ort.rn <= 16;

SELECT ort.rn
       ,ort.id
       ,ort.blogTitle
       ,ort.logofile
       ,ort.userno
       ,ort.username
       ,ort.joinDate
  FROM (SELECT ROWNUM rn
               ,ot.id
               ,ot.blogTitle
               ,ot.logofile
               ,ot.userno
               ,ot.username
               ,ot.joinDate
          FROM (SELECT b.id
                       ,b.blogTitle
                       ,b.logofile
                       ,u.userno
                       ,u.username
                       ,TO_CHAR(u.joinDate, 'YYYY/MM/DD') joinDate
                  FROM blog b, users u
                 WHERE b.id = u.id
                   AND b.blogTitle LIKE '%11%'
                 ORDER BY u.userno DESC) ot
       ) ort
 WHERE ort.rn >= 1
   AND ort.rn <= 16;

INSERT INTO users
VALUES (seq_users_no.NEXTVAL, 'manager', '매니저', '1234', sysdate);

INSERT INTO blog (id, blogTitle)
VALUES ('22', '22의 블로그입니다.');

INSERT INTO category
VALUES (seq_category_no.NEXTVAL, '22', '카테고리2 이름', '카테고리2 설명', sysdate);

INSERT INTO post
VALUES (seq_post_no.NEXTVAL, '11', '포스트 이름', '포스트 내용', sysdate);

INSERT INTO comments
VALUES (seq_comments_no.NEXTVAL, '3', '1', '안녕하세요 매니저입니다.', sysdate);

UPDATE users
   SET userName = '매니저'
 WHERE userNo = '1';

UPDATE blog
   SET blogTitle = '매니저의 블로그'
 WHERE id = 'manager';

UPDATE category
   SET description = '설명'
 WHERE cateNo = '8';