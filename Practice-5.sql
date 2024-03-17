-- 테이블 만들기(DDL구문)
DROP TABLE EMP;
CREATE TABLE EMP(
    EMPNO NUMBER(5) PRIMARY KEY,
    ENAME VARCHAR(30) NOT NULL,
    DEPTNO NUMBER(5) NOT NULL,
    MGR VARCHAR2(5),
    JOB VARCHAR2(20) NOT NULL,
    SAL NUMBER(10, 0) NOT NULL
);

-- 아래와 같이 데이터를 입력한다.(11행)
INSERT INTO EMP VALUES(1000, 'TEST1', 20, NULL, 'CLERK', 800);
INSERT INTO EMP VALUES(1001, 'TEST2', 30, 1000, 'SALESMAN', 1000);
INSERT INTO EMP VALUES(1002, 'TEST3', 30, 1000, 'SALESMAN', 2000);
INSERT INTO EMP VALUES(1003, 'TEST4', 20, 1000, 'MANAGER', 2900);
INSERT INTO EMP VALUES(1004, 'TEST5', 30, 1000, 'SALESMAN', 1000);
INSERT INTO EMP VALUES(1005, 'TEST6', 30, 1001, 'MANAGER', 2900);
INSERT INTO EMP VALUES(1006, 'TEST7', 10, NULL, 'MANAGER', 2900);
INSERT INTO EMP VALUES(1007, 'TEST8', 30, 1002, 'MANAGER', 2200);
INSERT INTO EMP VALUES(1008, 'TEST9', 10, 1002, 'MANAGER', 2800);
INSERT INTO EMP VALUES(1009, 'TEST10', 30, 1002, 'SALESMAN', 1500);
INSERT INTO EMP VALUES(1010, 'TEST11', 20, 1002, 'CLERK', 1100);

COMMIT;

SELECT *
    FROM EMP;
    
-- NULL값의 특징: 모르는 값, 값의 부재, 숫자 혹은 날짜를 더하면 NULL이 된다. 다른 값과 비교할 때 '알 수 없음' 반환.
-- IS NULL
SELECT *
    FROM EMP
WHERE MGR IS NULL;

-- IS NOT NULL
SELECT *
    FROM EMP
WHERE MGR IS NOT NULL;

-- NVL() 함수
SELECT NVL(MGR, 0)
    FROM EMP;
    
-- NVL2() 함수 - NVL()와 DECODE() 함수를 하나로 만든 것.
SELECT NVL2(MGR, 1, 0)
    FROM EMP;
    
-- NULLIF() 함수
SELECT NULLIF(10, 10)
    FROM DUAL;
    
-- COALESCE() 함수: NULL이 아닌 최초의 인자값을 반환한다.
SELECT COALESCE(NULL, NULL, NULL, -100)
    FROM DUAL;
    
-- GROUP BY구문 - 집계함수와 같이 사용함.
SELECT DEPTNO AS "부서번호", SUM(SAL) AS "연봉합계" -- 3
    FROM EMP ----------------------------------- 1
GROUP BY DEPTNO  ------------------------------ 2
ORDER BY DEPTNO; ------------------------------ 4

-- 그룹핑 된 내용에 조건식을 주기 위해서는 HAVING구문을 사용한다. HAVING 구문은 항상 GROUP BY와 함께 사용된다.
SELECT DEPTNO AS "부서번호", SUM(SAL) AS "연봉합계" -- 4
    FROM EMP ------------------------------------1
GROUP BY DEPTNO ------------------------------ 2
HAVING SUM(SAL) >= 10000 ----------------------- 3
ORDER BY DEPTNO; ------------------------------ 5

-- COUNT() 함수: 인자값으로 *(전체), 컬럼명(NULL)값을 제외한 컬럼 수 반환.
SELECT COUNT(*)
    FROM EMP;
 
-- MGR 컬럼은 2개의 NULL값이 존재하므로 9개의 레코드가 출력된다.   
SELECT COUNT(MGR)
    FROM EMP;
    
-- 부서별(DEPTNO), 관리자(MGR)별 평균급여 계산
SELECT DEPTNO AS "부서", MGR AS "관리자", FLOOR(AVG(SAL)) AS "평균급여"
    FROM EMP
GROUP BY DEPTNO, MGR
ORDER BY DEPTNO;

-- 직업별(JOB), 급여합계 중에서 5000 이상인 직업 추출
SELECT JOB AS "직업", SUM(SAL) AS "급여합계"
    FROM EMP
-- WHERE SUM(SAL) >= 5000 -- WHERE절은 집계함수가 조건으로 오면 안 된다.(중요)
GROUP BY JOB
HAVING SUM(SAL) >= 5000
ORDER BY JOB;

-- 사원번호가 1000 ~ 1003번까지의 부서별 급여 합계
SELECT DEPTNO AS "부서코드", SUM(SAL) AS "급여합계"
    FROM EMP
WHERE EMPNO BETWEEN 1000 AND 1003
GROUP BY DEPTNO
ORDER BY DEPTNO;

SELECT DEPTNO AS "부서번호", JOB AS "직업",  SUM(SAL) AS "급여합계"
    FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO;