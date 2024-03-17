-- DCL(DATA CONTROL LANGUAGE)
-- GRANT 데이터베이스 사용자에게 권한을 부여한다.
-- 데이터 사용하기 위해서는 권한이 필요하며 연결, 입력, 수정, 삭제, 조회를 할 수 있다.

-- 계정 생성하기
SHOW USER;

CONNECT SYSTEM/sqldeveloper;  -- SQLPLUS에서만 적용된다.

-- 해당 DB의 우클릭 후 접속해제 하고 SYSTEM계정으로 접속한다.
SHOW USER;

CREATE USER C##TEST IDENTIFIED BY 1234;
COMMIT;

SELECT *
    FROM EMP;

-- C##TEST계정에게 접속, 자원에 대한 권한을 부여함
GRANT CONNECT, RESOURCE TO C##TEST;
COMMIT;

-- C##TEST계정으로 EMP테이블을 조회하니깐 테이블이 존재하지 않는다라는 메시지가 출력되었다.
-- 이유는 EMP테이블에 대한 권한이 없기 때문이다.
SELECT *
    FROM EMP;
    
-- C##TEST 에게 SELECT, INSERT, UPDATE 권한 부여하는 코드
GRANT SELECT, INSERT, UPDATE
    ON EMP
    TO C##TEST;
COMMIT;

SHOW USER;

-- C##STUDY계정에서 만들어진 테이블 EMP를 조회하고자 한다면 아래와 같이 조회를 한다.
SELECT *
    FROM C##STUDY.EMP;

-- DELETE에 대한 권한은 주지 않았으므로 삭제가 안 된다.
DELETE FROM C##STUDY.EMP
WHERE C##STUDY.EMP.EMPNO = 1000;

-- UPDATE에 대한 권한은 주었기에 수정이 된다.
UPDATE C##STUDY.EMP
    SET ENAME = '홍길동'
WHERE EMPNO = 1000;
COMMIT;

-- REVOKE: 주어진 권한을 회수하는 명령어
REVOKE INSERT, UPDATE
    ON EMP
FROM C##TEST;
COMMIT;

-- 다시 권한을 회수한 후 C##TEST로 접속하여 아래 쿼리문을 실행해 보자
UPDATE C##STUDY.EMP
    SET ENAME = '김말자'
WHERE EMPNO = 1000;

SHOW USER;

-- TCL(TRANSACTION CONTROL LANGUAGE)
-- COMMIT, ROLLBACK, SAVEPOINT 존재한다.
UPDATE C##STUDY.EMP
    SET ENAME = '김말자'
WHERE EMPNO = 1000;

SELECT *
    FROM EMP;
    
COMMIT;  -- 한 번 커밋이 이루어지면 ROLLBACK이 되지 않는다.
ROLLBACK;

UPDATE C##STUDY.EMP
    SET ENAME = '홍말자'
WHERE EMPNO = 1000;

SELECT *
    FROM EMP;

ROLLBACK;  -- 커밋이 되지 않은 상태에서는 얼마든지 ROLLBACK이 가능하다.

-- SAVEPOINT: 트랜잭션을 작게 분할하여 관리하는 것, 지정된 위치에서만 롤백이 가능하다.
UPDATE C##STUDY.EMP
    SET ENAME = '김연아'
WHERE EMPNO = 1000;

SAVEPOINT KIM;

UPDATE C##STUDY.EMP
    SET ENAME = '손연재'
WHERE EMPNO = 1001;

SAVEPOINT SON;

SELECT *
    FROM EMP;

-- 손연재는 롤백이 되어 지고 김연아는 롤백이 되어지지 않음을 알 수가 있다.
ROLLBACK TO KIM;

-- 마지막 커밋까지 롤백을 다 해준다.
ROLLBACK;