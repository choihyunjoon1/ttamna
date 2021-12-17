
-- ttamna

-- 회원 테이블 생성 구문
create table member(
    member_id varchar2(20) CONSTRAINT member_PK PRIMARY KEY
                                      CONSTRAINT member_id_check CHECK(
                                         REGEXP_LIKE(member_id, '^[a-z0-9_]{4,20}$')
                                            AND
                                        REGEXP_LIKE(member_id, '.*?[a-z]+')),
    member_pw varchar2(60) CONSTRAINT member_pw_not_null NOT NULL
                                        CONSTRAINT member_pw_check CHECK(REGEXP_LIKE(member_pw, '.*?[a-zA-Z0-9./$]+')), -- 비밀번호 암호화 관련
    member_nick varchar2(15) CONSTRAINT member_nick_not_null NOT NULL
                                         CONSTRAINT member_nick_unique UNIQUE
                                          CONSTRAINT member_nick_check CHECK(REGEXP_LIKE(member_nick, '^[a-z가-힣]{2, 15}$')), --영어소문자15글자 or 한글5글자
    member_name varchar2(21) CONSTRAINT member_name_not_null NOT NULL
                                             CONSTRAINT member_name_check CHECK(REGEXP_LIKE(member_name, '^[가-힣]{2, 7}$')),
    member_phone char(13) CONSTRAINT member_phone_not_null NOT NULL
                                      CONSTRAINT member_phone_check CHECK(REGEXP_LIKE(member_phone, '^010-[0-9]{4}-[0-9]{4}$')),
    member_email varchar2(40) CONSTRAINT member_email_not_null NOT NULL
                                           CONSTRAINT member_email_unique UNIQUE
                                           CONSTRAINT member_email_check CHECK(REGEXP_LIKE(member_email, '^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.([a-zA-Z])+$')),
    member_grade varchar2(12) DEFAULT '일반회원' CONSTRAINT member_grade_not_null  NOT NULL
                                            CONSTRAINT member_grade_check_in  CHECK(member_grade IN('일반회원', '보호소', '관리자', '휴면')),
    member_last_log date DEFAULT sysdate CONSTRAINT member_lat_log_not_null   NOT NULL,
    member_join date DEFAULT sysdate CONSTRAINT member_join_not_null   NOT NULL,
    postcode varchar2(7),
    address varchar2(256),
    detail_address varchar2(256)
);

commit;
-- member_id : 기본키 / 정규식 영어소문자, 0~9, _ 합쳐서 4~20글자이고 영어소문자가 들어가 있는지 체크
-- member_pw : not null / 암호화 돼서 저장되기 때문에 암호화 되는 글자에 맞춰서 정규식 정함
-- member_nick : not null / unique / 정규식 영어소문자, 한글 가~힣 으로 영문이면 최대 15글자 한글은 최대 5글자
-- member_name : not null / 정규식 한글 2~7글자
-- member_phone : not null / 숫자, 특수문자 - 포함 13글자 고정
-- member_email : not null / unique / 정규식
-- member_grade : not null / 기본값 일반회원 / 등급은 일반회원, 보호소, 관리자, 휴면 네 가지로 나눔
-- member_last_log : 마지막 접속일, 기본값 sysdate
-- member_join : 가입일, 기본값 sysdate

