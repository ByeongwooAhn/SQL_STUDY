-- 마스터(부모) 테이블 만들기
CREATE TABLE DEPT(
    DEPTNO VARCHAR2(4) PRIMARY KEY,
    DEPTNAME VARCHAR2(20)
);

INSERT INTO DEPT VALUES('1000', '인사팀');
INSERT INTO DEPT VALUES('1001', '총무팀');
INSERT INTO DEPT VALUES('1002', '관리팀');

SELECT *
    FROM DEPT;
COMMIT;

-- 슬레이브(자식) 테이블 만들기
CREATE TABLE EMP(
    EMPNO NUMBER(10),
    ENAME VARCHAR2(20) NOT NULL,
    SAL NUMBER(10, 2) DEFAULT 0,  -- DEFAULT 제약조건 입력할 때 비워두게 되면 기본값으로 0이 들어간다.
    DEPTNO VARCHAR2(4) NOT NULL,
    CREATEDATE DATE DEFAULT SYSDATE,  -- 현재 PC의 날짜, 시간(시분초)로 기본값으로 저장된다.
    CONSTRAINT EMPPK PRIMARY KEY(EMPNO),  -- EMP테이블의 EMPNO컬럼을 EMPPK라는 이름으로 기본키를 설정함.
    --외래키를 설정하는데 DEPTFK이름으로 하고 DEPT테이블의 DEPTNO와 참조하게 만드는 제약조건이다.
    CONSTRAINT DEPTFK FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
    ON DELETE CASCADE  -- 옵션은 자신이 참조하고 있는 테이블(DEPT)의 데이터가 삭제되면 EMP테이블도 영향을 받아서 해당되는 레코드
    -- 가 존재한다면 같이 삭제가 이루어진다. '참조 무결성'을 지킬 수 있다. 참조 무결성이란 마스터 테이블(DEPT)에는 해당 부서번호가 없는데
    -- 슬레이브 테이블에 해당 부서번호가 있는 경우를 참조 무결성 위배로 볼 수가 있다.
);

INSERT INTO EMP VALUES(100, '임베스트', 1000, '1000', SYSDATE);
INSERT INTO EMP VALUES(101, '을지문덕', 2000, '1001', SYSDATE);

-- 부모테이블의 부서코드가 없으므로 무결성 제약조건 위반
INSERT INTO EMP VALUES(102, '강감찬', 3000, '1002', SYSDATE);

ROLLBACK;

SELECT *
    FROM EMP;

-- DESC(DECRIBE)명령어는 간단하게 테이블 구조를 확인하는 명령어이다.
DESC EMP;
DESC DEPT;

-- 마스터 테이블인 DEPT는 EMP테이블이 참조하고 있으므로 삭제도 되질 않는다. 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다.
DROP TABLE DEPT;

-- 마스터 테이블인 DEPT, 슬레이브 테이블은 EMP테이블
-- 마스터 테이블인 DEPT이 슬레이브 테이블과 같이 외래키 제약조건을 가지고 있을 때는, 항상 슬레이브 테이블을 먼저 삭제하고
-- 난 뒤 마스터 테이블인 DEPT테이블을 삭제해야 한다.
DROP TABLE EMP;

SELECT *
    FROM DEPT;
    
SELECT *
    FROM EMP;

-- 마스터 테이블의 레코드 중에서 1000번인 인사팀을 삭제하는 코드
DELETE FROM DEPT
WHERE DEPTNO = '1001';

COMMIT;

-- 테이블명 수정 ALTER TABLE ~ RENAME TO구문을 사용한다.
ALTER TABLE EMP
    RENAME TO NEW_EMP;

ALTER TABLE NEW_EMP
    RENAME TO EMP;
    
-- 테이블에 컬럼 추가 ADD
ALTER TABLE EMP
    ADD(AGE NUMBER(2) DEFAULT 1);
    
-- 테이블의 컬럼 변경
ALTER TABLE EMP
    MODIFY(ENAME VARCHAR2(50));

-- 데이터 타입을 변경할 때는 변경할 테이블에 데이터가 존재하면 에러가 발생하므로 설계단계에서 잘 설계하여 진행하여야 한다.
ALTER TABLE EMP
    MODIFY(SAL VARCHAR2(10) NOT NULL);

-- 컬럼 삭제
ALTER TABLE EMP
    DROP COLUMN AGE;
    
-- 컬럼명 변경
ALTER TABLE EMP
    RENAME COLUMN ENAME TO NEW_ENAME;
    
ALTER TABLE EMP
    RENAME COLUMN NEW_ENAME TO ENAME;

-- 테이블 제약 조건 삭제
DROP TABLE EMP CASCADE CONSTRAINT;

DROP TABLE EMP;