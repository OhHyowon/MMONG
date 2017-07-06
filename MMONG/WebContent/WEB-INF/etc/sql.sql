ALTER TABLE member DROP COLUMN member_pwd;
ALTER TABLE member DROP COLUMN member_authority;
ALTER TABLE administrator DROP COLUMN admin_pwd;
ALTER TABLE administrator DROP COLUMN admin_authority;

ALTER TABLE GROUP_DATE CREATE COLUMN TITLE VARCHAR2(900);

/* 사용자 0번 */
DROP TABLE USERS;
CREATE TABLE USERS (
	USER_ID VARCHAR2(30) PRIMARY KEY,/* 사용자ID */
	USER_PWD VARCHAR2(80) NOT NULL, /* 비밀번호 */
	USER_AUTHORITY VARCHAR2(10) NOT NULL, /* 권한 */
	USER_ENABLE NUMBER NOT NULL /* 접근성 0 : 비로그인, 1: 로그인 */ 
);



/* 개인회원 1번 */
DROP TABLE MEMBER;
CREATE TABLE MEMBER (
	MEMBER_ID VARCHAR2(30) PRIMARY KEY,/* 회원아이디 */
	MEMBER_NAME VARCHAR2(18) NOT NULL, /* 이름 */
	NICKNAME VARCHAR2(30) NOT NULL, /* 닉네임 */
	MEMBER_PHONE VARCHAR2(15) NOT NULL, /* 핸드폰번호 */
	MEMBER_EMAIL VARCHAR2(100) UNIQUE NOT NULL, /* 이메일 */
	MEMBER_ADDRESS VARCHAR2(900), /* 주소 */
	MEMBER_PICTURE VARCHAR2(900), /* 프로필사진 */
	CONSTRAINT member_id_users_fk FOREIGN KEY (member_id) REFERENCES users(user_id)
);


/* 관리자 2번*/
DROP TABLE ADMINISTRATOR;
CREATE TABLE ADMINISTRATOR (
	ADMIN_ID VARCHAR2(30) PRIMARY KEY,/* 관리자ID */
	ADMIN_NAME VARCHAR2(18) NOT NULL, /* 이름 */
	ADMIN_PHONE VARCHAR2(15) NOT NULL, /* 핸드폰번호  */
	ADMIN_EMAIL VARCHAR2(200) UNIQUE NOT NULL, /* 이메일 */
	CONSTRAINT admin_id_users_fk FOREIGN KEY (admin_id) REFERENCES users(user_id)
);


/* 관리자공지사항 3번 */
DROP TABLE ADMINISTRATOR_NOTICE;
CREATE TABLE ADMINISTRATOR_NOTICE (
	NO NUMBER PRIMARY KEY,/* 번호 */
	TITLE VARCHAR2(150) NOT NULL, /* 제목 */
	CONTENT VARCHAR2(450) NOT NULL, /* 내용 */
	ADMIN_DATE DATE NOT NULL, /* 날짜 */
	ADMIN_ID VARCHAR2(30) CONSTRAINT ADMIN_ID_ADMIN_NOTICE_FK REFERENCES ADMINISTRATOR(ADMIN_ID) /* 관리자ID */
);

DROP SEQUENCE ADMINISTRATOR_NOTICE_NO_SEQ;
CREATE SEQUENCE ADMINISTRATOR_NOTICE_NO_SEQ;


/* 산책로 4번*/
DROP TABLE TRAIL;
CREATE TABLE TRAIL (
	NO NUMBER PRIMARY KEY, /* NO */
	CATEGORY VARCHAR2(200) NOT NULL, /* 카테고리 */
	ROUTE VARCHAR2(4000) NOT NULL, /* 산책경로 */
	CONTENT VARCHAR2(1200), /* 내용 */
	MEMBER_ID VARCHAR2(30) CONSTRAINT MEMBER_ID_TRAIL_FK REFERENCES MEMBER(MEMBER_ID)/* 회원아이디 */
);

DROP SEQUENCE TRAIL_NO_SEQ;
CREATE SEQUENCE TRAIL_NO_SEQ;

/* 달력 5번*/
DROP TABLE CALENDAR;
CREATE TABLE CALENDAR (
	NO NUMBER PRIMARY KEY, /* NO */
	TITLE VARCHAR2(300) NOT NULL, /* 제목 */
	CONTENT VARCHAR2(3000) NOT NULL, /* 내용 */
	TYPE NUMBER NOT NULL, /* 타입 */
	SECRET NUMBER NOT NULL, /* 공개여부 */
	EMOTION NUMBER, /* 감정상태 */
	PICTURE VARCHAR2(900), /* 사진 */
	MEMBER_ID VARCHAR2(30) CONSTRAINT MEMBER_ID_CALENDAR_FK REFERENCES MEMBER(MEMBER_ID) /* 회원아이디 */
);

DROP SEQUENCE CALENDAR_NO_SEQ;
CREATE SEQUENCE CALENDAR_NO_SEQ;

/* 진료기록 6번*/
DROP TABLE CHART;
CREATE TABLE CHART (
	NO NUMBER PRIMARY KEY,/* NO */
	CHART_DATE DATE NOT NULL, /* 시간 */
	WRITER VARCHAR2(30) NOT NULL, /* 작성자 */
	CONTENT VARCHAR2(900) /* 내용 */
);


DROP SEQUENCE CHART_NO_SEQ;
CREATE SEQUENCE CHART_NO_SEQ;

/* 건강정보 6번*/
DROP TABLE HEALTH;
CREATE TABLE HEALTH (
	NO NUMBER PRIMARY KEY, /* NO */
	CONTENT VARCHAR2(900) NOT NULL, /* 내용 */
	DONE NUMBER NOT NULL, /* 체크여부 0:안함(DEFAULT), 1:함*/
	GENDER CHAR NOT NULL, /* 성별 */
	CHART_NO NUMBER CONSTRAINT CHART_NO_HEALTH_FK REFERENCES CHART(NO) /* 차트NO */
);

DROP SEQUENCE HEALTH_NO_SEQ;
CREATE SEQUENCE HEALTH_NO_SEQ;



/* 날씨메세지 8번 */
DROP TABLE WEATHER_MESSAGE;
CREATE TABLE WEATHER_MESSAGE (
	NO NUMBER PRIMARY KEY,/* NO */
	CONTENT VARCHAR2(300) NOT NULL /* 내용 */
);

DROP SEQUENCE WEATHER_NO_SEQ;
CREATE SEQUENCE WEATHER_NO_SEQ;


/* 소모임 9번*/
DROP TABLE SMALL_GROUP;
CREATE TABLE SMALL_GROUP (
	NO NUMBER PRIMARY KEY,/* NO */
	NAME VARCHAR2(60) NOT NULL, /* 모임이름 */
	LEADER VARCHAR2(50) NOT NULL, /* 모임장 */
	PICTURE VARCHAR2(900) NOT NULL, /* 모임대표사진 */
	CONTENT VARCHAR2(900) NOT NULL /* 모임설명 */
);

DROP SEQUENCE SMALL_GROUP_NO_SEQ;
CREATE SEQUENCE SMALL_GROUP_NO_SEQ;

/* 모임멤버 10*/
DROP TABLE GROP_MEMBER;
CREATE TABLE GROUP_MEMBER (
	NO NUMBER PRIMARY KEY, /* NO */
	GROUP_NO NUMBER NOT NULL, /* 소모임NO */
	MEMBER_ID VARCHAR2(30) CONSTRAINT MEMBER_ID_GROUP_MEMBER_FK REFERENCES MEMBER(MEMBER_ID) /* 회원아이디 */
);

DROP SEQUENCE GROUP_MEMBER_NO_SEQ;
CREATE SEQUENCE GROUP_MEMBER_NO_SEQ;

/* 모임일정 11번*/
DROP TABLE GROUP_DATE;
CREATE TABLE GROUP_DATE (
	NO NUMBER PRIMARY KEY,/* NO */
	MEET_DATE DATE NOT NULL, /* 날짜 */
	PLACE VARCHAR2(900), /* 장소 */
	GROUP_NO NUMBER CONSTRAINT GROUP_NO_MEET_DATE_FK REFERENCES SMALL_GROUP(NO) /* 소모임NO */
);
DROP SEQUENCE GROUP_DATE_NO_SEQ;
CREATE SEQUENCE GROUP_DATE_NO_SEQ;

/* 일정참여멤버 12번*/
DROP TABLE MEET_MEMBER;
CREATE TABLE MEET_MEMBER (
	GROUP_DATE_NO NUMBER CONSTRAINT GROUP_DATE_NO_MEET_MEMBER_FK REFERENCES GROUP_DATE(NO), /* 모일일정NO */
	GROUP_MEMBER_NO NUMBER CONSTRAINT GROUP_MEMBER_NO_MEET_MEMBER_FK REFERENCES GROUP_MEMBER(NO)  /* 모임멤버NO */
);


/* 자유게시판 13번*/
DROP TABLE BOARD;
CREATE TABLE BOARD (
	NO NUMBER PRIMARY KEY, /* 글번호 */
	TITLE VARCHAR2(150) NOT NULL, /* 글제목 */
	CONTENT VARCHAR2(3000) NOT NULL, /* 글내용 */
	BOARD_DATE DATE NOT NULL, /* 글작성일시 */
	HIT NUMBER NOT NULL, /* 글조회수 */
	MEMBER_ID VARCHAR2(30) NOT NULL, /* 회원아이디 */
	GROUP_NO NUMBER CONSTRAINT GROUP_NO_BOARD_FK REFERENCES SMALL_GROUP(NO) /* 소모임NO */
);


DROP SEQUENCE BOARD_NO_SEQ;
CREATE SEQUENCE BOARD_NO_SEQ;

/* 댓글 14번*/
DROP TABLE REPLY;
CREATE TABLE REPLY (
	NO NUMBER PRIMARY KEY,/* 댓글번호 */
	CONTENT VARCHAR2(450) NOT NULL, /* 댓글내용 */
	REPLY_DATE DATE NOT NULL, /* 댓글등록일시 */
	MEMBER_ID VARCHAR2(30) NOT NULL, /* 회원아이디 */
	BOARD_NO NUMBER CONSTRAINT BOARD_NO_REPLY_FK REFERENCES BOARD(NO) /* 글번호 */
);

DROP SEQUENCE REPLY_NO_SEQ;
CREATE SEQUENCE REPLY_NO_SEQ;

/* 자유게시판사진 15번*/
DROP TABLE BOARD_PICTURE;
CREATE TABLE BOARD_PICTURE (
	NO NUMBER PRIMARY KEY, /* NO */
	ROUTE VARCHAR2(900) NOT NULL, /* 사진경로 */
	BOARD_NO NUMBER CONSTRAINT BOARD_NO_BP_FK REFERENCES BOARD(NO) /* 글번호 */
);


DROP SEQUENCE BP_NO_SEQ;
CREATE SEQUENCE BP_NO_SEQ;

/* 알림 16번*/
DROP TABLE ALERT;
CREATE TABLE ALERT (
	NO NUMBER PRIMARY KEY,/* NO */
	CONTENT VARCHAR2(900) NOT NULL, /* 내용 */
	STATE NUMBER NOT NULL, /* 상태 */
	MEMBER_ID VARCHAR2(30) CONSTRAINT MEMBER_ID_ALERT_FK REFERENCES MEMBER(MEMBER_ID)  /* 회원아이디 */
);

DROP SEQUENCE ALERT_NO_SEQ;
CREATE SEQUENCE ALERT_NO_SEQ;

/* 쪽지관리 17번*/
DROP TABLE MESSAGE;
CREATE TABLE MESSAGE (
	NO NUMBER PRIMARY KEY, /* 쪽지번호 */
	MESSAGE_DATE DATE NOT NULL, /* 날짜 */
	TITLE VARCHAR2(150) NOT NULL, /* 제목 */
	CONTENT VARCHAR2(900) NOT NULL, /* 내용 */
	STATE NUMBER NOT NULL, /* 쪽지상태 */
	SEND_ID VARCHAR2(30) CONSTRAINT SEND_ID_MESSAGE_FK REFERENCES MEMBER(MEMBER_ID), /* 보낼아이디 */
	RECEIVE_ID VARCHAR2(30) CONSTRAINT RECEIVE_ID_MESSAGE_FK REFERENCES MEMBER(MEMBER_ID) /* 받은아이디 */
);
DROP SEQUENCE MESSAGE_NO_SEQ;
CREATE SEQUENCE MESSAGE_NO_SEQ;