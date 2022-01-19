package com.kh.ttamna.vo.notice;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeListFileVO {
// 입양전필독 게시판에서 게시판의 이미지를 목록에 보여주기 위해 생성한 VO
	
	private int noticeNo; //게시판 번호
	private String noticeWriter; //작성자
	private String noticeTitle; //제목
	private String noticeContent; //내용
	private Date noticeTime; //작성시간
	private int noticeRead; //조회수
	private int noticeImgNo; //이미지 파일 번호
    private String noticeImgUpload; //이미지 파일 업로드 이름
    private long noticeImgSize; //이미지 파일 크기
    private String noticeImgType; //파일 유형
	
}
