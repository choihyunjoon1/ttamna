package com.kh.ttamna.entity.notice;

import lombok.Data;

@Data
public class NoticeImgDto {
//	-------------------------------------------------------------------------------------------------------------
//
//	-- notice_img(입양 전 필독 이미지 파일) 테이블 생성 구문
//	create sequence notice_img_seq;
//	create table notice_img(
//	    notice_img_no number CONSTRAINT notice_img_no_pk PRIMARY KEY,
//	    notice_no number CONSTRAINT notice_no_fk REFERENCES notice(notice_no) ON DELETE CASCADE,
//	    notice_img_upload varchar2(256) CONSTRAINT notice_img_upload_not_null NOT NULL,
//	    notice_img_size number CONSTRAINT notice_img_size_not_null NOT NULL,
//	    notice_img_type varchar2(256) CONSTRAINT notice_img_type_not_null NOT NULL
//	);
//
//	COMMIT;
	
	private int noticeImgNo;
	private int noticeNo;
	private String noticeImgUpload;
	private long noticeImgSize;
	private String noticeImgType;
	
}
