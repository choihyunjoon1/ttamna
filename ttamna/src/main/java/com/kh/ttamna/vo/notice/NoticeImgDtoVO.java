package com.kh.ttamna.vo.notice;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeImgDtoVO {

	private int noticeNo; //게시판 번호
	private String noticeWriter; //작성자
	private String noticeTitle; //제목
	private String noticeContent; //내용
	private Date noticeTime; //작성시간
	private int noticeRead; //조회수
	private int noticeImgNo;//이미지번호
}
