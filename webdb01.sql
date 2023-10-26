-- DDL(Data Definition Language, 데이터 정의어) --> 테이블 관리

/* 테이블 생성 */
CREATE TABLE book (
    book_id	    NUMBER(5),
    title       VARCHAR2(50),
    author	    VARCHAR2(10),
    pub_date    DATE
);                                              -- Table BOOK이(가) 생성되었습니다.

/* 컬럼 추가 */
ALTER TABLE book ADD ( pubs VARCHAR2(50) );     -- Table BOOK이(가) 변경되었습니다.

/* 컬럼 정보 변경 */
ALTER TABLE book MODIFY ( title VARCHAR2(100) );    -- Table BOOK이(가) 변경되었습니다.

ALTER TABLE book RENAME COLUMN title TO subject;

/* 컬럼 삭제 */
ALTER TABLE book DROP (author);                     -- Table BOOK이(가) 변경되었습니다.

/* 테이블명 변경 */
RENAME book TO article;                             -- 테이블 이름이 변경되었습니다.

/* 테이블 삭제 */
DROP TABLE article;                                 -- Table ARTICLE이(가) 삭제되었습니다.

-- TRUNCATE : 테이블의 모든 행을 제거 --> DML delete문과 비교
TRUNCATE TABLE article;

SELECT *
  FROM article;

--------------------------------------------------------------------------------

/* 테이블 만들기 */

CREATE TABLE author (
    author_id	NUMBER(10),
    author_name	VARCHAR2(100)   NOT NULL,
    author_desc	VARCHAR2(500),
    PRIMARY KEY(author_id)	
);

CREATE TABLE book (
    book_id     NUMBER(10),
    title       VARCHAR2(100)   NOT NULL,
    pubs	    VARCHAR2(100),
    pub_date    DATE,
    author_id   NUMBER(10),
    PRIMARY KEY(book_id),
    CONSTRAINT book_fk FOREIGN KEY (author_id)  -- book 테이블의 author_id
    REFERENCES author(author_id)                -- author 테이블의 author_id
);

SELECT *
  FROM author;
SELECT *
  FROM book;

--------------------------------------------------------------------------------

-- DML(Data Manipulation Language, 데이터 조작어) --> 데이터 관리

/* INSERT 문 */
INSERT INTO author
VALUES (1, '박경리', '토지 작가');                 -- 1 행 이(가) 삽입되었습니다.

INSERT INTO author( author_id, author_name )
VALUES (2, '이문열');

/* UPDATE 문 */
UPDATE author
   SET author_name = '지호',
       author_desc = '개발자'
 WHERE author_id = 2;                           -- 1 행 이(가) 업데이트되었습니다.

INSERT INTO author( author_id, author_name, author_desc )
VALUES (3, '아이유', '가수');
INSERT INTO author( author_id, author_name, author_desc )
VALUES (4, '태연', '가수');

UPDATE author
   SET author_desc = '작가 아님'
 WHERE author_id IN (3, 4);                     -- 2개 행 이(가) 업데이트되었습니다.

/* DELETE 문 */
DELETE FROM author
 WHERE author_id = 1;                           -- 1 행 이(가) 삭제되었습니다.

-- 트랜잭션 제어 명령어 - COMMIT : 확정
COMMIT;             -- 보류중인 모든 데이터 변경사항을 영구적으로 적용. 현재 트랜잭션 종료

INSERT INTO author( author_id, author_name, author_desc )
VALUES (5, '작가1', '작가');

-- 트랜잭션 제어 명령어 - ROLLBACK : 이전
ROLLBACK;           -- 보류중인 모든 데이터 변경사항을 폐기. 현재 트랜잭션 종료, 직전 커밋 직후의 단계로 회귀
                    -- 전체 트랜잭션을 롤백함

-- 트랜잭션 내의 DML 명령문들은 실행이 되어 SELECT - FROM 결과에 반영되더라도,
-- 커밋(COMMIT) 전까지는 임시적인 상태이므로
-- ROLLBACK 을 할 경우에는 트랜잭션이 취소되고 이전 커밋 직후의 상태로 돌아가게 됨

--------------------------------------------------------------------------------

/* SEQUENCE(시퀀스) */
CREATE SEQUENCE seq_author_id
INCREMENT BY 1
 START WITH 1
NOCACHE;                                                -- Sequence SEQ_AUTHOR_ID이(가) 생성되었습니다.

/* 시퀀스 사용 */
INSERT INTO author
VALUES (seq_author_id.NEXTVAL, '박경리', '토지 작가');

INSERT INTO author
VALUES (seq_author_id.NEXTVAL, '박경리2', '토지 작가2');   -- unique constraint (WEBDB.SYS_C007002) violated

SELECT *
  FROM author;

/* 시퀀스 조회 */
SELECT * FROM USER_SEQUENCES;

/* 시퀀스 현재값 조회 */
SELECT seq_author_id.CURRVAL FROM DUAL;

/* 시퀀스 다음값 조회 */
SELECT seq_author_id.NEXTVAL FROM DUAL;                 -- 조회만 해도 숫자가 올라감

/* 시퀀스 삭제 */
DROP SEQUENCE seq_author_id;

COMMIT;
SELECT *
  FROM author;

--------------------------------------------------------------------------------

-- SYSDATE : 현재시간이 입력이 됨

SELECT *
  FROM tabs;
SELECT *
  FROM user_sequences;

-- author, book 테이블을 생성하고 데이터를 입력
-- 강풀의 author_desc 정보를 ‘서울특별시’ 로 변경해 보세요
-- author 테이블에서 ‘작가없음’ 데이터를 삭제해 보세요 -> 삭제 안됨 -> book 테이블에서 삭제

DROP TABLE book;
DROP TABLE author;

DROP SEQUENCE seq_book_id;
DROP SEQUENCE seq_author_id;

SELECT *
  FROM book;
SELECT *
  FROM author;

CREATE TABLE author (
    author_id   NUMBER(10),
    author_name VARCHAR2(100)   NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id)
);

CREATE TABLE book (
    book_id         NUMBER(10),
    title           VARCHAR2(100)   NOT NULL,
    pubs            VARCHAR2(100),
    pub_date        DATE,
    author_id       NUMBER(10),
    PRIMARY KEY (book_id),
    CONSTRAINT book_fk FOREIGN KEY (author_id)
    REFERENCES author(author_id)
);

CREATE SEQUENCE seq_author_id
INCREMENT BY 1
 START WITH 1
NOCACHE;

CREATE SEQUENCE seq_book_id
INCREMENT BY 1
 START WITH 1
NOCACHE;

INSERT INTO author
VALUES (SEQ_AUTHOR_ID.NEXTVAL, '김문열', '경북 영양');
INSERT INTO author
VALUES (SEQ_AUTHOR_ID.NEXTVAL, '박경리', '경상남도 통영');
INSERT INTO author
VALUES (SEQ_AUTHOR_ID.NEXTVAL, '유시민', '17대 국회의원');
INSERT INTO author
VALUES (SEQ_AUTHOR_ID.NEXTVAL, '작가없음', '작가없음');
INSERT INTO author
VALUES (SEQ_AUTHOR_ID.NEXTVAL, '강풀', '온라인 만화가 1세대');
INSERT INTO author
VALUES (SEQ_AUTHOR_ID.NEXTVAL, '김영하', '알쓸신잡');

INSERT INTO book
VALUES (SEQ_BOOK_ID.NEXTVAL, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);
INSERT INTO book
VALUES (SEQ_BOOK_ID.NEXTVAL, '삼국지', '민음사', '2002-03-01', 1);
INSERT INTO book
VALUES (SEQ_BOOK_ID.NEXTVAL, '토지', '마로니에북스', '2012-08-15', 2);
INSERT INTO book
VALUES (SEQ_BOOK_ID.NEXTVAL, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);
INSERT INTO book
VALUES (SEQ_BOOK_ID.NEXTVAL, '작가없음', '작가없음', '2012-02-22', 4);
INSERT INTO book
VALUES (SEQ_BOOK_ID.NEXTVAL, '순정만화', '재미주의', '2011-08-03', 5);
INSERT INTO book
VALUES (SEQ_BOOK_ID.NEXTVAL, '오직두사람', '문학동네', '2017-05-04', 6);
INSERT INTO book
VALUES (SEQ_BOOK_ID.NEXTVAL, '26년', '재미주의', '2012-02-04', 5);

SELECT b.book_id
       ,b.title
       ,b.pubs
       ,b.pub_date
       ,a.author_id
       ,a.author_name
       ,a.author_desc
  FROM book b, author a
 WHERE b.author_id = a.author_id;

UPDATE author
   SET author_desc = '서울특별시'
 WHERE author_id = 5;

DELETE FROM book
 WHERE author_id = 4;

COMMIT;