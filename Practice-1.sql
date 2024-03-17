-- 테이블 만들기(DDL구문)
CREATE TABLE EMP(
    EMPNO INT NOT NULL PRIMARY KEY,
    EMP_NAME VARCHAR(30) NOT NULL,
    AGE INT NOT NULL,
    SAL INT NOT NULL,
    DEPT_CODE VARCHAR(5) NOT NULL
);

-- 테이블 수정(DDL구문)
ALTER TABLE EMP MODIFY DEPT_CODE VARCHAR(5);

-- 테이블 삭제(DDL구문)
DROP TABLE EMP;

-- 테이블 조회(DML구문)
-- AS는 ALLIAS의 약자로 별칭을 사용하여 가독성을 좋게 만들어 준다.
SELECT EMPNO AS "사원번호", EMP_NAME AS "이름", AGE AS "나이", SAL AS "연봉", DEPT_CODE AS "부서코드"
 FROM EMP;

-- 데이터 입력(DML구문)
INSERT INTO EMP VALUES (1000, '임베스트', 20, 10000, '001'); --좌측과 같이 입력해도 무방함.
INSERT INTO EMP(EMPNO, EMP_NAME, AGE, SAL, DEPT_CODE) VALUES(1001, '문재인', 22, 21000, '002'); --정상적인 방법
INSERT INTO EMP VALUES(1002, '안철수', 32, 32000, '003');

-- 데이터 삭제하는데 조건(WHERE)이 EMPNO가 1000번에 대해서 삭제함.(DML구문)
DELETE FROM EMP
WHERE EMPNO = 1000;

-- TCL의 한 명령어로 물리적인 저장장치(서버, HDD, SSD 등)에 보내기 전에 이전 상태로 돌리는 명령어.
-- DML구문(INSERT, DELETE, UPADTE)문에 사용할 때 적용이 된다.
ROLLBACK;

-- TCL의 한 명령어로 물리적인 저장장치(서버, HDD, SSD 등)에 보낸다. 한 번 COMMIT이 된 내용은 ROLLBACK이 되지 않음을 기억하자.
COMMIT;

CREATE TABLE DEPT(
    DEPT_CODE INT NOT NULL PRIMARY KEY,
    DEPT_NAME VARCHAR(30)
);

DROP TABLE DEPT;