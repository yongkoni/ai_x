-- 연습문제
-- 1.
CREATE TABLE SAM01(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    SAL NUMBER(7, 2)
);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1000, 'APPLE', 'POLICE', 10000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1010, 'BANANA', 'NURSE', 15000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1020, 'ORANGE', 'DOCTOR', 25000);
INSERT INTO SAM01 (EMPNO, ENAME, SAL) VALUES (1030, 'VERY', 25000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (1040, 'CAT', NULL, 2000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (7782, 'CLARK', 'MANAGER', 2450);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (7839, 'KING', 'PRESIDENT', 5000);
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) VALUES (7934, 'MILLER', 'CLERK', 1300);
SELECT * FROM SAM01;
COMMIT;

-- 2. 
    -- 1) 테이블 생성
CREATE TABLE MY_DATA(
    ID NUMBER(4),
    NAME VARCHAR2(10),
    USERID VARCHAR2(30),
    SALARY NUMBER(10, 2),
    PRIMARY KEY(ID)
);
    -- 2) 데이터 입력
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (1, 'Scott', 'sscott', 10000.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (2, 'Ford', 'fford', 13000.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (3, 'Patel', 'ppate', 33000.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (4, 'Report', 'rreport', 23500.00);
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY) VALUES (5, 'Good', 'ggood', 44450.00);
    -- 3) 입력한 자료 확인
SELECT ID, NAME, USERID, TO_CHAR(SALARY, '99,999.99')
    FROM MY_DATA;
    -- 4) 트랜젝션 작업 반영
COMMIT;
    -- 5) ID가 3인 사람 수정
UPDATE MY_DATA 
    SET SALARY = 65000
    WHERE ID = 3;
COMMIT;
    -- 6) Ford 삭제
DELETE FROM MY_DATA WHERE NAME = 'Ford';
COMMIT;
    -- 7) SALARY가 15,000이하인 사람의 급여를 15,000으로 변경
UPDATE MY_DATA
    SET SALARY = 15000
    WHERE SALARY < 15000;
SELECT * FROM MY_DATA;
    -- 8 테이블 삭제
DROP TABLE MY_DATA;

-- 3.
    -- 1) EMP 테이블과 같은 구조와 같은 내용의 테이블 EMP01을 생성(테이블이 있을시제거한 후)하고, 
        -- 모든 사원의 부서번호를 30번으로 수정
DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
UPDATE EMP01 SET DEPTNO = 30;
    -- 2) EMP01테이블의 모든 사원의 급여를 10% 인상시키는 UPDATE문을 작성
UPDATE EMP01 SET SAL = SAL * 1.1;
    -- 3) 급여가 3000이상인 사원만 급여를 10%인상
UPDATE EMP01 
    SET SAL = SAL * 1.1 
    WHERE SAL >= 3000;
    -- 4) EMP01테이블에서 'DALLAS'에서 근무하는 직원들의 연봉을 1000인상
UPDATE EMP01 
    SET SAL = SAL + 1000 
    WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');
    -- 5) SCOTT사원의 부서번호는 20번으로, 직급은 MANAGER로 한꺼번에 수정
UPDATE EMP01 
    SET DEPTNO = 20, 
        JOB='MANAGER' 
    WHERE ENAME = 'SCOTT';
    -- 6) 부서명이 SALES인 사원을 모두 삭제하는 SQL작성
DELETE FROM EMP01 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME = 'SALES');
    -- 7) 사원명이 'FORD'인 사원을 삭제하는 SQL 작성
DELETE FROM EMP01 WHERE ENAME = 'FORD';
    -- 8) SAM01 테이블에서 JOB이 NULL인 사원을 삭제
DELETE FROM SAM01 WHERE JOB IS NULL;
    -- 9) SAM01테이블에서 ENAME이 ORANGE인 사원을 삭제
DELETE FROM SAM01 WHERE ENAME = 'ORANGE';
    -- 10) 급여가 1500이하인 사람의 급여를 1500으로 수정
UPDATE SAM01 SET SAL = 1500 WHERE SAL <= 1500;
    -- 11) JOB이 'MANAGER'인 사원의 급여를 10%인하
UPDATE SAM01 SET SAL = SAL * 0.9 WHERE JOB = 'MANAGER';
SELECT * FROM EMP01;
SELECT * FROM SAM01;

-- 4.
CREATE TABLE MAJOR(
    mCODE NUMBER(2),
    mNAME VARCHAR2(50) UNIQUE,
    mOFFICE VARCHAR(200),
    PRIMARY KEY(mCODE)
);

CREATE TABLE STUDENT(
    sNO NUMBER(5),
    sNAME VARCHAR2(50),
    sSCORE NUMBER(3),
    mCODE NUMBER(2),
    PRIMARY KEY(sNO),
    CHECK(sSCORE BETWEEN 0 AND 100),
    FOREIGN KEY(mCODE) REFERENCES MAJOR(mCODE) 
);

INSERT INTO MAJOR VALUES (1, '컴퓨터공학', 'A101호');
INSERT INTO MAJOR VALUES (2, '빅데이터', 'A102호');
SELECT * FROM MAJOR;

INSERT INTO STUDENT VALUES (101, '홍길동', 99, 1);
INSERT INTO STUDENT VALUES (102, '신길동', 100, 2);
SELECT * FROM STUDENT;

SELECT SNO 학번, SNAME 이름, SSCORE 점수, S.MCODE 학과코드, MNAME 학과명, MOFFICE 학과사무실
    FROM MAJOR M, STUDENT S
    WHERE M.mCODE = S.mCODE;