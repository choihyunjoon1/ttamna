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



