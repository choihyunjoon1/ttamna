---------------- dormancy --------------------------

-- 테이블 데이터 삭제 (dormancy)
TRUNCATE TABLE dormancy;

-- 테이블 삭제 (dormancy)
DROP TABLE dormancy CASCADE CONSTRAINTS;

COMMIT;

---------------- visit --------------------------

-- 테이블 데이터 삭제 (visit)
TRUNCATE TABLE visit;

-- 테이블 삭제 (visit)
DROP TABLE visit CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (visit)
DROP SEQUENCE visit_seq;

COMMIT;

---------------- autopayment --------------------------

-- 테이블 데이터 삭제 (autopayment)
TRUNCATE TABLE autopayment;

-- 테이블 삭제 (autopayment)
DROP TABLE autopayment CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (autopayment)
DROP SEQUENCE autopayment_seq;

COMMIT;

---------------- certification --------------------------

-- 테이블 데이터 삭제 (certification)
TRUNCATE TABLE certification;

-- 테이블 삭제 (certification)
DROP TABLE certification CASCADE CONSTRAINTS;

COMMIT;

---------------- pay_detail --------------------------

-- 테이블 데이터 삭제 (pay_detail)
TRUNCATE TABLE pay_detail;

-- 테이블 삭제 (pay_detail)
DROP TABLE pay_detail CASCADE CONSTRAINTS;

COMMIT;

---------------- payment --------------------------

-- 테이블 데이터 삭제 (payment)
TRUNCATE TABLE payment;

-- 테이블 삭제 (payment)
DROP TABLE payment CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (payment)
DROP SEQUENCE payment_seq;

COMMIT;

---------------- cart --------------------------

-- 테이블 데이터 삭제 (cart)
TRUNCATE TABLE cart;

-- 테이블 삭제 (cart)
DROP TABLE cart CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (cart)
DROP SEQUENCE cart_seq;

COMMIT;

---------------- shop_reply --------------------------

-- 테이블 데이터 삭제 (shop_reply)
TRUNCATE TABLE shop_reply;

-- 테이블 삭제 (shop_reply)
DROP TABLE shop_reply CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (shop_reply)
DROP SEQUENCE shop_reply_seq;

COMMIT;

---------------- shop_img --------------------------

-- 테이블 데이터 삭제 (shop_img)
TRUNCATE TABLE shop_img;

-- 테이블 삭제 (shop_img)
DROP TABLE shop_img CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (shop_img)
DROP SEQUENCE shop_img_seq;

COMMIT;

---------------- shop --------------------------

-- 테이블 데이터 삭제 (shop)
TRUNCATE TABLE shop;

-- 테이블 삭제 (shop)
DROP TABLE shop CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (shop)
DROP SEQUENCE shop_seq;

COMMIT;

---------------- donation_reply --------------------------

-- 테이블 데이터 삭제 (donation_reply)
TRUNCATE TABLE donation_reply;

-- 테이블 삭제 (donation_reply)
DROP TABLE  donation_reply CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (donation_reply)
DROP SEQUENCE donation_reply_seq;

COMMIT;

---------------- donation_img --------------------------

-- 테이블 데이터 삭제 (donation_img)
TRUNCATE TABLE donation_img;

-- 테이블 삭제 (donation_img)
DROP TABLE  donation_img CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (donation_img)
DROP SEQUENCE donation_img_seq;

COMMIT;

---------------- donation --------------------------

-- 테이블 데이터 삭제 (donation)
TRUNCATE TABLE donation;

-- 테이블 삭제 (donation)
DROP TABLE  donation CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (donation)
DROP SEQUENCE donation_seq;

COMMIT;

---------------- mybaby_reply --------------------------

-- 테이블 데이터 삭제 ( mybaby_reply)
TRUNCATE TABLE mybaby_reply;

-- 테이블 삭제 ( mybaby_reply)
DROP TABLE  mybaby_reply CASCADE CONSTRAINTS;

-- 시퀀스 삭제 ( mybaby_reply)
DROP SEQUENCE  mybaby_reply_seq;

COMMIT;

---------------- mybaby_img --------------------------

-- 테이블 데이터 삭제 ( mybaby_img)
TRUNCATE TABLE mybaby_img;

-- 테이블 삭제 ( mybaby_img)
DROP TABLE  mybaby_img CASCADE CONSTRAINTS;

-- 시퀀스 삭제 ( mybaby_img)
DROP SEQUENCE  mybaby_img_seq;

COMMIT;

---------------- mybaby --------------------------

-- 테이블 데이터 삭제 ( mybaby)
TRUNCATE TABLE mybaby;

-- 테이블 삭제 ( mybaby)
DROP TABLE  mybaby CASCADE CONSTRAINTS;

-- 시퀀스 삭제 ( mybaby)
DROP SEQUENCE  mybaby_seq;

COMMIT;

---------------- adopt_img --------------------------

-- 테이블 데이터 삭제 (adopt_img)
TRUNCATE TABLE adopt_img;

-- 테이블 삭제 (adopt_img)
DROP TABLE adopt_img CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (adopt_img)
DROP SEQUENCE adopt_img_seq;

COMMIT;
 
---------------- adopt --------------------------

-- 테이블 데이터 삭제 (adopt)
TRUNCATE TABLE adopt;

-- 테이블 삭제 (adopt)
DROP TABLE adopt CASCADE CONSTRAINTS;

-- 시퀀스 삭제 (adopt)
DROP SEQUENCE adopt_seq;

COMMIT;

---------------- member --------------------------

-- 테이블 데이터 삭제 (member)
TRUNCATE TABLE member;

-- 테이블 삭제 (member)
DROP TABLE member CASCADE CONSTRAINTS;

COMMIT;

------------------------------------------------------

--휴면회원 테이블삭제
drop table dormancy;

commit;