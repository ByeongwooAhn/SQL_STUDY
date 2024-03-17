-- 뷰 만들기
CREATE VIEW V_EMP
    AS SELECT EMPNO,  ENAME
        FROM EMP;

-- 뷰를 가지고 조회
SELECT *
    FROM V_EMP;
 
-- 뷰에 데이터 삽입은 되지 않는다.
INSERT INTO V_EMP VALUES(102, '신은혁');

-- 뷰를 가지고 삭제를 진행하니 뷰의 데이터도 삭제되고 실제 테이블의 데이터도 삭제됨(권장되어지는 방법은 절대로 아니다.)
DELETE FROM V_EMP
WHERE EMPNO = 100;

COMMIT;

SELECT *
    FROM EMP;

-- 뷰에 ALTER문은 적용되지 않는다.
/*ALTER VIEW V_EMP
    ADD(AGE NUMBER(2) DEFAULT 1);*/

-- 뷰 삭제하는 코드
DROP VIEW V_EMP;

DESC EMP;

-- 원하는 컬럼을 선택하여 데이터를 저장할 수 있다. NOT NULL 제약조건이 있는 컬럼은 반드시 값을 주어야 한다.
INSERT INTO EMP(EMPNO, ENAME, DEPTNO) VALUES(102, '강감찬', '1001');

SELECT *
    FROM DEPT;
    
-- 테이블 복사
-- 먼저 복사 대상 테이블을 만들고 난 뒤, INSERT구문으로 복사하는 코드.
CREATE TABLE DEPT_TEST(
    DEPT_CODE INT NOT NULL PRIMARY KEY,
    DEPT_NAME VARCHAR(30)
);

INSERT INTO DEPT_TEST
    SELECT *
        FROM DEPT;
        
COMMIT;
    
SELECT *
    FROM DEPT_TEST;

-- 테이블을 만들면서 바로 복사하는 방법 - 오라클에서는 적용이 안 됨.
/*CREATE TABLE DEPT_COPY(
    SELECT *
        FROM DEPT
);*/

-- NOLOGGING 옵션은 로그파일의 기록을 최소화하면서 입력시 성능을 향상시키는 방법적인 옵션이다.
-- NOLOGGING 옵션은 BUFFER CACH라는 메모리 영역을 생략하고 바로 기록을 한다.
ALTER TABLE DEPT NOLOGGING;

-- UPDATE문: 저장된 레코드의 컬럼에 값을 수정하고자 할 때, 사용한다.
-- UPDATE문 사용시 조건(WHERE절)을 사용하지 않으면 전체 레코드가 다 변경된다.(주의)
SELECT *
    FROM EMP;
    
UPDATE EMP
    SET EMP_NAME = '한국'
WHERE EMPNO = 1000;

COMMIT;
ROLLBACK;

-- DELETE문: 저장된 레코드의 컬럼에 값을 삭제하고자 할 때, 사용한다.
-- DELETE문 사용시 조건(WHERE절)을 사용하지 않으면 전체 레코드가 다 삭제된다.(주의)
-- DELETE문은 DML구문이라 TCL구문이 적용된다.
SELECT *
    FROM EMP;
    
DELETE FROM EMP
WHERE EMPNO = 1001;

-- TRUNCATE문: 모든 데이터를 삭제한다. 테이블 구조는 남겨둔다.
-- TRUNCATE문은 DDL구문이라서 TCL(ROLLBACK)문이 적용되지 않는다.
TRUNCATE TABLE EMP;