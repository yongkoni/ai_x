-- [V] SEQUENCE : 순차적인 번호 생성기. 대부분 인위적인 PK 사용용도
DROP SEQUENCE FRIEND_SEQ;
CREATE SEQUENCE FRIEND_SEQ
    START WITH 1 -- 1부터 시작 (기본값)
    INCREMENT BY 1 -- 1씩 증가 (기본값)
    MAXVALUE 9999 -- 최대값
    MINVALUE 1 -- 최소값
    NOCYCLE -- CYCLE : 순차번호 9999 → 1
    NOCACHE;
SELECT FRIEND_SEQ.NEXTVAL FROM DUAL; -- 다음 순차번호 값
SELECT FRIEND_SEQ.CURRVAL FROM DUAL; -- 현재 시퀀스 값

DROP TABLE FRIEND;
CREATE TABLE FRIEND(
    NO NUMBER(5) PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL,
    TEL VARCHAR2(20) UNIQUE,
    ADDRESS VARCHAR2(250),
    LAST_MODIFY DATE DEFAULT SYSDATE
);
DROP SEQUENCE FRIEND_SEQ;
CREATE SEQUENCE FRIEND_SEQ
    MAXVALUE 99999
    NOCACHE NOCYCLE;
SELECT * FROM FRIEND;
INSERT INTO FRIEND (NO, NAME, TEL, ADDRESS)
    VALUES (FRIEND_SEQ.NEXTVAL, '홍길동', '010-9999-9999','서울');
INSERT INTO FRIEND (NO, NAME, TEL, ADDRESS)
    VALUES (FRIEND_SEQ.NEXTVAL, '유길동', NULL,'서울');
SELECT * FROM FRIEND;
DELETE FROM FRIEND WHERE TEL IS NULL;

-- 연습문제
    -- 1. 같은 이름의 테이블이나 시퀀스가 있을 수 있으니 먼저 삭제하고 테이블을 생성하시오
DROP TABLE MEMBER;
DROP TABLE MEMBER_LEVEL;
DROP SEQUENCE MEMBER_MNO_SQ;
    -- 2. MEMBER_LEVEL 테이블은 필드 별로 다음의 제약조건을 지킨다
CREATE TABLE MEMBER_LEVEL(
    LEVELNO NUMBER(1) PRIMARY KEY,
    LEVELNAME VARCHAR2(20) NOT NULL
);
    -- 3. MEMBER 테이블은 필드 별로 다음의 조건을 지켜 생성하시오
CREATE TABLE MEMBER(
    mNO NUMBER(10) PRIMARY KEY,
    mNAME VARCHAR2(30) NOT NULL,
    mPW VARCHAR2(8) NOT NULL,
    mEMAIL VARCHAR2(30) UNIQUE,
    mPOINT NUMBER(10) CHECK(mPOINT >= 0),
    mRDATE DATE DEFAULT SYSDATE,
    LEVELNO NUMBER(1) REFERENCES MEMBER_LEVEL(LEVELNO)
);
    -- 4. MEMBER 테이블의 mNO번호는 시퀀스(MEMBER_MNO_SQ)를 생성한 뒤 자동생성 번호로 입력
CREATE SEQUENCE MEMBER_MNO_SQ MAXVALUE 9999999999 NOCACHE NOCYCLE;
    -- 5. MEMBER_LEVEL 테이블의 내용
INSERT INTO MEMBER_LEVEL VALUES (-1, 'black');
INSERT INTO MEMBER_LEVEL VALUES (0, '일반');
INSERT INTO MEMBER_LEVEL VALUES (1, '실버');
INSERT INTO MEMBER_LEVEL VALUES (2, '골드');
SELECT * FROM MEMBER_LEVEL;
    -- 6. MEMBER 테이블의 내용
INSERT INTO MEMBER (mNO, mNAME, mPW, mEMAIL, mPOINT, mRDATE, LEVELNO)
    VALUES (MEMBER_MNO_SQ.NEXTVAL, '홍길동', 'aa', 'hong@hong.com', 0,
            TO_DATE('22/03/10','RR/MM/DD'), 0);
INSERT INTO MEMBER (mNO, mNAME, mPW, mEMAIL, mPOINT, mRDATE, LEVELNO)
    VALUES (MEMBER_MNO_SQ.NEXTVAL, '신길동', 'bb', 'sin@sin.com', 1000,
            TO_DATE('22/04/01','RR/MM/DD'), 1);
SELECT * FROM MEMBER;
    -- LecNote 연습문제와 같이 출력되도록 SELECT (EQUI JOIN)
SELECT MNO, MNAME, TO_CHAR(MRDATE,'YYYY-MM-DD') MRDATE, MEMAIL mmail, 
    mPOINT POINT, LEVELNAME || '고객' levelname
    FROM MEMBER_LEVEL L, MEMBER M
    WHERE L.LEVELNO = M.LEVELNO;