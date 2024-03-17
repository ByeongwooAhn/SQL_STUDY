-- EQUI(등가)조인 --> 교집합
-- 조인: 2개 이상의 릴레이션(테이블)을 사용해서 새로운 릴레이션을 만드는 과정이다.
-- 두 릴레이션(기본키, 외래키) 일치하는 것을 조인의 조건으로 한다.
SELECT *
    FROM USERTBL;
    
SELECT *
    FROM BUYTBL;

-- 오라클에서의 등가 내부조인의 결과는 USERID같은 것만 추출하므로 12개행만 출력된다.
SELECT *
    FROM USERTBL, BUYTBL
WHERE USERTBL.USERID = BUYTBL.USERID;


-- 조인을 하더라도 추가적으로 조건을 줄 수도 있고, 집계함수 및 GROUP BY도 사용할 수가 있다.
SELECT *
    FROM USERTBL, BUYTBL
WHERE USERTBL.USERID = BUYTBL.USERID
    AND USERTBL.USERNAME LIKE '이%'
ORDER BY USERTBL.USERNAME;

-- ISO 표준 SQL로 테이블1 INNER JOIN 테이블2 ON 테이블간에 교집합 조건
SELECT *
    FROM USERTBL
    INNER JOIN BUYTBL
    ON USERTBL.USERID = BUYTBL.USERID
WHERE USERTBL.USERNAME = '강호동';

/*EQUI조인(내부조인, 등가조인)만 해시조인을 사용한다.
해시조인은 먼저 선행 테이블을 결정하고 주어진 조건에 해당하는 행을 선텍되면 조인키를 기준으로 하여
해시 함수를 사용해서 해시테이블을 메인메모리에 생성하고 후행 테이블에서 주어진 조건에 만족하는 행을
찾는다. 후행 테이블의 조인키를 사용해서 해시함수를 적용하여 해당 버킷을 검색하고 알맞은 것을 출력한다.
USERTBL, BUTBL 전체를 읽은 다음에 (TABLE ACCESS FULL) 해시 함수를 사용해서 테이블을 연결한 것이다.*/

/*아래 쿼리는 에러가 발생한다. 그 이유는?
컬럼의 모호성, USERTBL, BUYTBL에 같은 USERID가 존재하므로 출력하고자 하는데 어떤 테이블에 있는
USERID를 출력할지 오라클엔진이 애매하다 라고 하면서 에러를 띄운다.*/
SELECT USERID, USERNAME, PRODNAME, ADDR
    FROM USERTBL
    INNER JOIN BUYTBL
    ON USERTBL.USERID = BUYTBL.USERID;

/*해결방법
모호성을 해결하기 위해서 테이블명.컬럼명으로 바꿔주면 된다.*/
SELECT USERTBL.USERID, USERTBL.USERNAME, PRODNAME, USERTBL.ADDR
    FROM USERTBL
    INNER JOIN BUYTBL
    ON USERTBL.USERID = BUYTBL.USERID;

/* 위의 코드를 더욱 더 간결하게 하기 위해서 테이블에 알리아스(별칭)을 주었다.
코드가 확실히 간결해진다.*/
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR
    FROM USERTBL U
    INNER JOIN BUYTBL B
    ON U.USERID = B.USERID;
    
/*INTERSECT 연산: 두 개의 테이블에서 교집합을 조회 한다.
중요한 것은 교집합의 조건이 되는 값을 컬럼값으로 지정해야 한다.*/
SELECT USERID FROM USERTBL
INTERSECT
SELECT USERID FROM BUYTBL;

/*외부조인(OUTER JOIN)
외부조인은 두 개의 테이블 간에 교집합을 먼저 조회하고 한 쪽 테이블에만
있는 데이터를 전부 다 포함시켜서 출력시키는 방법*/
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, MOBILE2) AS "연락처"
    FROM USERTBL U, BUYTBL B
WHERE U.USERID = B.USERID(+); -- (+)구문은 오라클에서만 적용이 된다.

/*ISO표준의 LEFT OUTER JOIN
LEFT OUTER JOIN 키워드를 중심으로 좌측 테이블의 내용을 다 출력해라*/
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, MOBILE2) AS "연락처"
    FROM USERTBL U
    LEFT OUTER JOIN BUYTBL B
    ON U.USERID = B.USERID;
    
/*ISO표준의 RIGHT OUTER JOIN
RIGHT OUTER JOIN 키워드를 중심으로 우측 테이블의 내용을 다 출력해라*/
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, MOBILE2) AS "연락처"
    FROM BUYTBL B
    RIGHT OUTER JOIN USERTBL U
    ON U.USERID = B.USERID;

/*ISO 표준의 FULL OUTER JOIN
FULL OUTER JOIN은 2개의 테이블의 모든 내용을 다 출력해라.*/
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, MOBILE2) AS "연락처"
    FROM BUYTBL B
    FULL OUTER JOIN USERTBL U
    ON U.USERID = B.USERID;
    
/*CROSS JOIN(상호 조인)
상호 조인은 조인 조건 구문 없이 두 개의 테이블을 하나로 만들어버린다.
조인 구문이 없으니 카테시안 곱이 발생한다.
카디널리티: 한 테이블에 있는 레코드의 수
USERTBL 10개의 레코드
BUYTBL 12개의 레코드
카테시안 곱: 10 * 12 = 120개 출력이 된다.(중요)
MERGE JOIN으로 실행결과가 출력된다.

아래 두 쿼리의 결과는 동일하다.*/
SELECT *
    FROM USERTBL, BUYTBL;
    
SELECT *
    FROM USERTBL CROSS JOIN BUYTBL;