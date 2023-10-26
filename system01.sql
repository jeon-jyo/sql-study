-- DCL(Data Control Language, 데이터 제어어) --> User 관리

/* 계정 삭제 */
DROP USER webdb CASCADE;                -- User WEBDB이(가) 삭제되었습니다.

/* 계정 생성 */
CREATE USER webdb IDENTIFIED BY 1234;   -- User WEBDB이(가) 생성되었습니다.

/* 권한 부여 */
GRANT RESOURCE, CONNECT TO webdb;       -- Grant을(를) 성공했습니다.

/* 비밀번호 수정 */
ALTER USER webdb IDENTIFIED BY webdb;   -- User WEBDB이(가) 변경되었습니다.

DROP USER webdb CASCADE;                -- cannot drop a user that is currently connected
                                        -- -> webdb 접속 해제 후 다시 실행

--------------------------------------------------------------------------------

-- USER system IDENTIFIED BY manager;
-- USER hr IDENTIFIED BY hr;