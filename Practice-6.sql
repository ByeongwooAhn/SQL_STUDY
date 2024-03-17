-- DUAL 테이블 오라클에서 제공해주는 더미 테이블이다.
DESC DUAL;

-- 내장형 함수(문자형) - 오라클 엔진에서 제공해주는 함수
-- ASCII(문자) -> 아스키코드로 출력
-- SUBSTR() -> 문자열을 자르는 함수
-- LENGTHB(문자열) -> 해당 문자열의 바이트의 크기(한글: 3바이트, 영문: 1바이트)
-- LTRIM() -> 좌측 공백 제거 함수
-- RTRIM() -> 우측 공백 제거 함수
-- TRIM() -> 좌우측 공백 제거 함수
-- CHR() -> 아스키코드 값에 해당하는 문자를 출력
SELECT ASCII('A'), SUBSTR('ABCDEFG', 1, 4), LENGTH('홍길동'), LENGTHB('ABC'),
LENGTH(LTRIM('  홍')), LENGTH(RTRIM('홍  ')), LENGTH(TRIM('  홍  ')), CHR(97)
    FROM DUAL;
 
 -- CONCAT(): 문자열을 연결해주는 함수   
SELECT CONCAT('아름다운 ', '대한민국')
    FROM DUAL;

-- || 문자열 연결 연산자
SELECT '아름다운 ' || '대한민국'
    FROM DUAL;

-- LOWER(): 영문자를 무조건 소문자로 변경
-- UPPER(): 영문자를 무조건 대문자로 변경
SELECT LOWER('ABCDeee'), UPPER('ABCDeee')
    FROM DUAL;
    
-- 내장형 함수(날짜형 함수)
-- SYSDATE: 지금 날짜를 출력
-- EXTRACT(): 년, 월, 일을 추출해서 출력
SELECT SYSDATE, EXTRACT(YEAR FROM SYSDATE), EXTRACT(MONTH FROM SYSDATE), EXTRACT(DAY FROM SYSDATE)
    FROM DUAL;

-- TO_CHAR(): 형변환 함수인데, 포맷에 맞게끔 날짜 및 시각을 표현한다
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MM:DD AM')
    FROM DUAL;
    
-- 내장형 함수(숫자형)
-- ABS(): 절댓값을 구하는 함수
-- SIGN(): 양수, 0, 음수인지를 확인하는 함수(1이면 양수, -1이면 음수)
-- MOD(): 나머지를 구하는 함수
-- CEIL(): 무조건 올림하는 함수, 숫자보다 크거나 같은 최소의 정수를 돌려준다
-- FLOOR(): 무조건 내림하는 함수, 숫자보다 작거나 같은 최대의 정수를 돌려준다
-- ROUND(실수, 자릿수): 자릿수로 만드는데 반올림 처리를 하는 함수
-- TRUNC(실수, 자릿수): 자릿수로 만드는데 절삭 처리를 하는 함수
SELECT ABS(-1), SIGN(-100), MOD(11, 4), CEIL(10.9), FLOOR(10.1), ROUND(55.255, 2), TRUNC(15.255, 1)
    FROM DUAL;
    
-- DECODE() 함수: IF문으로 구현할 수 있다
-- DECODE() 함수는 컬럼값이 비교값과 비교해서 그 결과가 참이면 3번째 인자값을 리턴, 거짓이면 4번째 인자값을 리턴
SELECT DECODE(EMPNO, 1000, '참', '거짓')
    FROM EMP;
    
SELECT *
    FROM EMP;
    
SELECT DECODE(MGR, NULL, 'NULL값이다.', 'NULL값이 아니다.')
    FROM EMP;

-- 테이블에 컬럼 추가 ADD
ALTER TABLE EMP
    ADD(GENDER VARCHAR2(2));

-- 데이터 타입을 변경할 때는 변경할 테이블에 데이터가 존재하면 에러가 발생하므로 설계단계에서 잘 설계하여 진행하여야 한다.
ALTER TABLE EMP
    MODIFY(GENDER VARCHAR2(6));
    
-- 컬럼에 데이터 추가
UPDATE EMP
    SET GENDER = '남자'
WHERE EMPNO = 1000 OR EMPNO = 1002 OR EMPNO = 1004 OR EMPNO = 1006 OR EMPNO = 1008 OR EMPNO = 1010;

UPDATE EMP
    SET GENDER = '여자'
WHERE EMPNO = 1001 OR EMPNO = 1003 OR EMPNO = 1005 OR EMPNO = 1007 OR EMPNO = 1009 OR EMPNO = 1011;
    
-- 성별이 남자이면 M, 여자이면 F를 출력하는 DECODE문을 작성하시오.
SELECT DECODE(GENDER, '남자', 'M', 'F')
    FROM EMP;
    
-- CASE문: 프로그래밍 언어처럼 조건문을 사용할 수 있다.
SELECT CASE
                WHEN EMPNO = 1000 THEN 'A'
                WHEN EMPNO = 1001 THEN 'B'
                ELSE 'C'
              END
    FROM EMP;
    
-- DEPTNO가 10번이면 인사팀, 20번이면 총무팀, 30번이면 전산팀, 그 외 나머지는 부서없음으로 표시하시오. 단, CASE문을 이용하시오.
-- CASE WHEN THEN ELSE END 문법을 알 수 있도록 하자.
SELECT CASE
                WHEN DEPTNO = 10 THEN '인사팀'
                WHEN DEPTNO = 20 THEN '총무팀'
                WHEN DEPTNO = 30 THEN '전산팀'
                ELSE '부서없음'
              END
    FROM EMP;