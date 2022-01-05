-- ttamna

-- member(회원) 테이블 생성 구문
create table member(
    member_id varchar2(20) CONSTRAINT member_id_pk PRIMARY KEY
                                      CONSTRAINT member_id_check CHECK(
                                         REGEXP_LIKE(member_id, '^[a-z0-9_]{4,20}$')
                                            AND
                                        REGEXP_LIKE(member_id, '.*?[a-z]+')),
    member_pw varchar2(60) CONSTRAINT member_pw_not_null NOT NULL
                                        CONSTRAINT member_pw_check CHECK(REGEXP_LIKE(member_pw, '.*?[a-zA-Z0-9./$]+')), -- 비밀번호 암호화 관련
    member_nick varchar2(45) CONSTRAINT member_nick_not_null NOT NULL
                                         CONSTRAINT member_nick_unique UNIQUE
                                          CONSTRAINT member_nick_check CHECK(REGEXP_LIKE(member_nick, '^[가-힣]{2,15}$')), 
    member_name varchar2(21) CONSTRAINT member_name_not_null NOT NULL
                                             CONSTRAINT member_name_check CHECK(REGEXP_LIKE(member_name, '^[가-힣]{2,7}$')),
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

-- 닉네임 제약조건 변경(12/27)
--ALTER TABLE member MODIFY member_nick varchar2(45); 
--ALTER TABLE member DROP CONSTRAINT member_nick_check;
--ALTER TABLE member ADD CONSTRAINT member_nick_check CHECK(REGEXP_LIKE(member_nick, '^[가-힣]{2,15}$'));

COMMIT;
-- member_id : 기본키 / 정규식 영어소문자, 0~9, _ 합쳐서 4~20글자이고 영어소문자가 들어가 있는지 체크
-- member_pw : not null / 암호화 돼서 저장되기 때문에 암호화 되는 글자에 맞춰서 정규식 정함
-- member_nick : not null / unique / 정규식 한글 가~힣 으로 2~15글자
-- member_name : not null / 정규식 한글 2~7글자
-- member_phone : not null / 숫자, 특수문자 - 포함 13글자 고정
-- member_email : not null / unique / 정규식
-- member_grade : not null / 기본값 일반회원 / 등급은 일반회원, 보호소, 관리자, 휴면 네 가지로 나눔
-- member_last_log : 마지막 접속일, 기본값 sysdate
-- member_join : 가입일, 기본값 sysdate

-------------------------------------------------------------------------------------------------------------

-- adopt(입양 공고) 테이블 생성 구문
create sequence adopt_seq;
create table adopt(
    adopt_no number CONSTRAINT adopt_no_pk PRIMARY KEY,
    adopt_writer varchar2(20) CONSTRAINT adopt_writer_fk REFERENCES member(member_id) ON DELETE SET NULL,
    adopt_title varchar2(150) CONSTRAINT adopt_title_not_null NOT NULL,
    adopt_content varchar2(4000) CONSTRAINT adopt_content_not_null NOT NULL,
    adopt_time date DEFAULT sysdate CONSTRAINT adopt_time_not_null NOT NULL,
    adopt_read number DEFAULT 0 CONSTRAINT adopt_read_not_null NOT NULL,
    adopt_start date DEFAULT sysdate CONSTRAINT adopt_start_not_null NOT NULL,
    adopt_end date CONSTRAINT adopt_end_not_null NOT NULL,
    adopt_kind varchar2(30) CONSTRAINT adopt_kind_not_null NOT NULL,
    adopt_place varchar2(60) CONSTRAINT adopt_place_not_null NOT NULL,
    adopt_type CHAR(5) DEFAULT 'adopt' NOT NULL
);

COMMIT;

-- adopt_no : 시퀀스. 기본키
-- adopt_writer : 작성자, 회원 기본키 참조 외래키
-- adopt_start : 공고 시작일. 기본값 sysdate
-- adopt_end : 공고 종료일
-- adopt_kind : 입양될 동물의 종류 또는 품종
-- adopt_place : 구조 장소

-------------------------------------------------------------------------------------------------------------

-- adopt_img(입양 공고 이미지 파일) 테이블 생성 구문
create sequence adopt_img_seq;
create table adopt_img(
    adopt_img_no number CONSTRAINT adopt_img_no_pk PRIMARY KEY,
    adopt_no number CONSTRAINT adopt_no_fk REFERENCES adopt(adopt_no) ON DELETE CASCADE,
    adopt_img_upload varchar2(256) CONSTRAINT adopt_img_upload_not_null NOT NULL,
    adopt_img_size number CONSTRAINT adopt_img_size_not_null NOT NULL,
    adopt_img_type varchar2(256) CONSTRAINT adopt_img_type_not_null NOT NULL
);

COMMIT;
-- adopt_img_no : 시퀀스. 기본키
-- adopt_no : 입양 공고 게시물 기본키 참조 외래키

-------------------------------------------------------------------------------------------------------------

--내새끼 게시판 테이블 생성 구문
create sequence mybaby_seq;
create table mybaby(
mybaby_no number primary key,--게시판 번호,PK
mybaby_writer references member(member_id) on delete set null,--멤버테이블 참조키
mybaby_title varchar2(150) not null,--제목
mybaby_content varchar2(4000) not null,--내용
mybaby_time date default sysdate not null,--작성시간
mybaby_read number default 0 not null,--조회수
mybaby_reply number default 0 not null,--댓글수
mybaby_type CHAR(6) DEFAULT 'mybaby' NOT NULL
);

commit;
-------------------------------------------------------------------------------------------------------------

--내새끼 이미지 테이블 생성 구문
create sequence mybaby_img_seq;
create table mybaby_img(
mybaby_img_no number primary key, --이미지 번호
mybaby_no references mybaby(mybaby_no) on delete cascade, -- 내새끼 게시글 번호 참조키
mybaby_img_upload varchar2(256) not null, -- 이미지 업로드 이름
mybaby_img_size number not null, -- 이미지 크기
mybaby_img_type varchar2(256) not null -- 이미지 유형
);

-- 기존 게시판 번호 참조 외래키 삭제 후 외래키 옵션 수정후 다시 추가
--ALTER TABLE mybaby_img ADD CONSTRAINT mybaby_no_fk FOREIGN KEY(mybaby_no) references mybaby(mybaby_no) on delete cascade;

commit;
-------------------------------------------------------------------------------------------------------------

--내새끼 댓글 테이블 생성 구문
create sequence mybaby_reply_seq;
create table mybaby_reply(
mybaby_reply_no number primary key, -- 댓글 번호
mybaby_no references mybaby(mybaby_no) on delete cascade, -- 내새끼 게시글 번호 참조키
member_id references member(member_id) on delete set null,
mybaby_reply_content varchar2(1500) not null, -- 댓글 내용
mybaby_reply_time date default sysdate not null, -- 댓글 작성 시간
mybaby_reply_superno references mybaby_reply(mybaby_reply_no) on delete set null, -- 댓글 상위 그룹 번호
mybaby_reply_groupno number default 0 not null, -- 댓글 그룹 번호
mybaby_reply_depth number default 0 not null -- 댓글 차수
);


commit;

-------------------------------------------------------------------------------------------------------------

--기부 게시판
create sequence donation_seq;
create table donation(
donation_no number primary key,
donation_writer references member(member_id) on delete set null,
donation_now_fund number not null,
donation_total_fund number not null,
donation_content varchar2(3000) not null,
donation_time date default sysdate not null,
donation_read number default 0 not null,
donation_title varchar2(150) not null,
donation_type CHAR(8) DEFAULT 'donation' NOT NULL
);

commit;

-------------------------------------------------------------------------------------------------------------

--기부 이미지
create sequence donation_img_seq;
create table donation_img(
donation_img_no number primary key,
donation_no references donation(donation_no) on delete cascade,
donation_img_upload varchar2(256) not null,
donation_img_size number not null,
donation_img_type varchar2(256)
);

commit;

-------------------------------------------------------------------------------------------------------------

--기부 댓글
create sequence donation_reply_seq;
create table donation_reply(
donation_reply_no number primary key,
member_id references member(member_id) on delete set null,
donation_no references donation(donation_no) on delete cascade,
donation_reply_content varchar2(1500) not null,
donation_reply_time date default sysdate not null,
donation_reply_superno references donation_reply(donation_reply_no) on delete set null,
donation_reply_groupno number not null,
donation_reply_depth number not null
);

commit;

-- 댓글 게시판 참조 외래키 옵션 추가
--ALTER TABLE donation_reply ADD CONSTRAINT donation_no_fk FOREIGN KEY(donation_no) references donation(donation_no) on delete cascade;

-------------------------------------------------------------------------------------------------------------

-- 상품 게시판
create sequence shop_seq; 
create table shop(
shop_no number primary key, -- 상품 번호
member_id references member(member_id) on delete set null, -- 아이디
shop_title VARCHAR2(150 BYTE) NOT NULL, -- 글 제목
shop_goods varchar2(150) not null, -- 상품이름
shop_price number not null, -- 상품가격
shop_count number not null, -- 상품 재고 수량
shop_content varchar2(3000) not null, -- 상품 설명
shop_time date default sysdate not null, -- 작성일
shop_read number default 0 not null -- 조회수
);

commit;

-------------------------------------------------------------------------------------------------------------

--상품 이미지
create sequence shop_img_seq;
create table shop_img( 
shop_img_no number primary key, -- 이미지 번호
shop_no references shop(shop_no) on delete cascade,
shop_img_upload varchar2(256) not null, -- 상품 업로드명
shop_img_save varchar2(256)not null, -- 이미지 저장명
shop_img_size number not null, -- 상품 사진 크기
shop_img_type varchar2(256) -- 상품 사진 유형
);

commit;

-------------------------------------------------------------------------------------------------------------

-- 상품게시판 댓글
create sequence shop_reply_seq;
create table shop_reply(
shop_reply_no number primary key, -- 댓글번호
member_id references member(member_id) on delete set null, -- 댓글 작성자
shop_no references shop(shop_no) on delete cascade, -- 상품번호
shop_reply_content varchar2(1500) not null, --댓글 내용
shop_reply_time date default sysdate not null, -- 댓글 작성일
shop_reply_superno references shop_reply(shop_reply_no) on delete set null, --댓글 상위번호
shop_reply_groupno number not null, --댓글 그룹번호
shop_reply_depth number not null --댓글차수
);

commit;

-------------------------------------------------------------------------------------------------------------

-- 상품재고
create sequence inventory_seq;
create table inventory(
inventory_no number primary key, -- 재고번호
shop_no references shop(shop_no) on delete set null, -- 상품이름
inventory_time date default sysdate not null, -- 증감일시
inventory_stock number check(inventory_stock>=0) --총 재고량 , 나중에 입고되면 + 숫자 입력, 출고되면 - 숫자 입력
);

commit;

-------------------------------------------------------------------------------------------------------------

-- 장바구니
create sequence cart_seq;
create table cart(
cart_no number primary key, -- 장바구니 번호
shop_no references shop(shop_no) on delete cascade, -- 상품번호
member_id references member(member_id) on delete cascade, -- 아이디
shop_img_no references shop_img(shop_img_no) on delete cascade,
cart_time date default sysdate not null, -- 담은시간
cart_count number default 0 check(cart_count >= 0) not null, --담은개수
shop_goods varchar2(150)
);

commit;

-------------------------------------------------------------------------------------------------------------

-- 주문내역
create sequence history_seq;
create table history(
history_no number primary key, -- 주문내역번호
member_id CONSTRAINT member_id_fk references member(member_id) on delete cascade, -- 아이디
cart_no CONSTRAINT cart_no_fk REFERENCES cart(cart_no) on delete cascade, -- 장바구니번호
shop_no CONSTRAINT shop_no_fk REFERENCES shop(shop_no) on delete cascade, -- 상품번호
history_time date default sysdate not null -- 주문일자
);

commit;
-- shop_img_no 참조 여부 확인해야함

-------------------------------------------------------------------------------------------------------------

--결제 테이블
create sequence payment_seq; -- 시퀀스
create table payment(
pay_no number primary key, -- 결제번호
tid varchar2(20) not null unique, -- 고유번호
member_id varchar2(20) not null, -- 회원아이디
item_name varchar2(300) not null, -- 거래명(상품명 외 몇건)
total_amount number not null check(total_amount >= 0), -- 거래금액
pay_time date default sysdate not null, -- 거래시각
status varchar2(12) not null check(status in ('결제완료', '부분취소', '전체취소')) -- 거래상태
);

commit;

-------------------------------------------------------------------------------------------------------------

-- 결제 상세 테이블
create table pay_detail(
pay_no REFERENCES payment(pay_no) on delete cascade, -- 고유번호
shop_no number not null, -- 상품번호
shop_goods varchar2(30) not null, -- 상품명
quantity number default 1 not null check(quantity > 0), -- 수량
price number not null check(price >= 0), -- 가격
status varchar2(6) not null check(status in ('결제', '취소')) -- 상태
);

commit;

-------------------------------------------------------------------------------------------------------------

--인증 테이블
create table certification(
    cert_email varchar2(40) primary key,
    cert_serial varchar2(60) not null,
    cert_time date default sysdate not null
);
--ALTER TABLE certification MODIFY cert_serial varchar2(60); 
commit;

-------------------------------------------------------------------------------------------------------------

-- 정기결제 테이블

create sequence autopayment_seq;
create table autopayment(
auto_no number primary key,
partner_user_id REFERENCES member(member_id),
auto_sid varchar2(20) not null,
auto_quantity number default 1 not null,
auto_total_amount number not null,
first_payment_date date default sysdate not null,
pay_times number default 1 not null,
donation_no references donation(donation_no)
);

commit;
-------------------------------------------------------------------------------------------------------------

--휴면회원 테이블
create table dormancy(
dor_member_id varchar2(20) primary key,
dor_member_nick varchar2(45) not null,
dor_member_phone char(13) not null,
dor_member_email varchar2(40) not null,
dor_member_name varchar2(21) not null,
dor_member_grade varchar2(12) not null,
dor_member_join date not null
);
commit;

-------------------------------------------------------------------------------------------------------------

-- 접속 기록 테이블
create sequence visit_seq;
create table visit(
    visit_idx number CONSTRAINT visit_pk PRIMARY KEY,--기본키 , 시퀀스
    visit_id varchar2(100) CONSTRAINT visit_id_not_null NOT NULL, --접속자 아이디
    visit_time date DEFAULT sysdate CONSTRAINT visit_time_not_null NOT NULL--접속자 접속시간
);

commit;

-------------------------------------------------------------------------------------------------------------
