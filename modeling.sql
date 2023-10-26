CREATE TABLE TB_CUST
(
    CUST_NO    character(10) NOT NULL,
    CUST_NAME    character varying(50) NOT NULL,
    AGE    numeric(15) NOT NULL,
    JOB_NO    character(4) NOT NULL
);

ALTER TABLE TB_CUST
 ADD CONSTRAINT PK_TB_CUST PRIMARY KEY ( CUST_NO );

ALTER TABLE TB_CUST
 ADD CONSTRAINT FK_TB_CUST FOREIGN KEY ( JOB_NO )
 REFERENCES TB_JOB (JOB_NO );

COMMENT ON COLUMN TB_CUST.CUST_NO IS '고객번호';

COMMENT ON COLUMN TB_CUST.CUST_NAME IS '고객명';

COMMENT ON COLUMN TB_CUST.AGE IS '나이';

COMMENT ON COLUMN TB_CUST.JOB_NO IS '직업코드';

COMMENT ON TABLE TB_CUST IS '고객';


CREATE TABLE TB_JOB
(
    JOB_NO    character(4) NOT NULL,
    JOB_NAME    character varying(150) NOT NULL
);

ALTER TABLE TB_JOB
 ADD CONSTRAINT PK_TB_JOB PRIMARY KEY ( JOB_NO );

COMMENT ON COLUMN TB_JOB.JOB_NO IS '직업코드';

COMMENT ON COLUMN TB_JOB.JOB_NAME IS '직업명';

COMMENT ON TABLE TB_JOB IS '직업';


CREATE TABLE TB_ORD
(
    ORD_NO    character(14) NOT NULL,
    ORD_DE    character(8) NOT NULL,
    ORD_TIME    character(6) NOT NULL,
    ORD_AMT    numeric(15) NOT NULL,
    CUST_NO    character(10) NOT NULL
);

ALTER TABLE TB_ORD
 ADD CONSTRAINT PK_TB_ORD PRIMARY KEY ( ORD_NO );

ALTER TABLE TB_ORD
 ADD CONSTRAINT FK_TB_ORD FOREIGN KEY ( CUST_NO )
 REFERENCES TB_CUST (CUST_NO );

COMMENT ON COLUMN TB_ORD.ORD_NO IS '주문번호';

COMMENT ON COLUMN TB_ORD.ORD_DE IS '주문일자';

COMMENT ON COLUMN TB_ORD.ORD_TIME IS '주문시간';

COMMENT ON COLUMN TB_ORD.ORD_AMT IS '주문금액';

COMMENT ON COLUMN TB_ORD.CUST_NO IS '고객번호';

COMMENT ON TABLE TB_ORD IS '주문';


CREATE TABLE TB_ORD_DET
(
    ORD_DET_NO    character(14) NOT NULL,
    ORD_DET_AMT    numeric(15) NOT NULL,
    ORD_NO    character(14) NOT NULL
);

ALTER TABLE TB_ORD_DET
 ADD CONSTRAINT PK_TB_ORD_DET PRIMARY KEY ( ORD_DET_NO );

ALTER TABLE TB_ORD_DET
 ADD CONSTRAINT FK_TB_ORD_DET FOREIGN KEY ( ORD_NO )
 REFERENCES TB_ORD (ORD_NO );

COMMENT ON COLUMN TB_ORD_DET.ORD_DET_NO IS '주문상세번호';

COMMENT ON COLUMN TB_ORD_DET.ORD_DET_AMT IS '주문상세금액';

COMMENT ON COLUMN TB_ORD_DET.ORD_NO IS '주문번호';

COMMENT ON TABLE TB_ORD_DET IS '주문상세';


CREATE TABLE TB_PROD
(
    PROD_NO    character(10) NOT NULL,
    PROD_NAME    character varying(150) NOT NULL,
    ORD_DET_NO    character(14) NOT NULL
);

ALTER TABLE TB_PROD
 ADD CONSTRAINT PK_TB_PROD PRIMARY KEY ( PROD_NO );

ALTER TABLE TB_PROD
 ADD CONSTRAINT FK_TB_PROD FOREIGN KEY ( ORD_DET_NO )
 REFERENCES TB_ORD_DET (ORD_DET_NO );

COMMENT ON COLUMN TB_PROD.PROD_NO IS '상품번호';

COMMENT ON COLUMN TB_PROD.PROD_NAME IS '상품명';

COMMENT ON COLUMN TB_PROD.ORD_DET_NO IS '주문상세번호';

COMMENT ON TABLE TB_PROD IS '상품';