package com.kh.ttamna.entity.notice;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeDto {

//	-- notice(입양 전 필독) 테이블 생성 구문
//	create sequence notice_seq;
//	create table notice(
//	    notice_no number CONSTRAINT notice_no_pk PRIMARY KEY,
//	    notice_writer varchar2(20) CONSTRAINT notice_writer_fk REFERENCES member(member_id) ON DELETE SET NULL,
//	    notice_title varchar2(150) CONSTRAINT notice_title_not_null NOT NULL,
//	    notice_content varchar2(4000) CONSTRAINT notice_content_not_null NOT NULL,
//	    notice_time date DEFAULT sysdate CONSTRAINT notice_time_not_null NOT NULL,
//	    notice_read number DEFAULT 0 CONSTRAINT notice_read_not_null NOT NULL
//	);
//
//	COMMIT;
//

	private int noticeNo;
	private String  noticeWriter;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeTime;
	private int noticeRead;
	

}
