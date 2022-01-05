package com.kh.ttamna.vo.adopt;

import java.sql.Date;

import lombok.Data;

@Data
public class AdoptListFileVO {
// 입양공고 게시판에서 게시판의 이미지를 목록에 보여주기 위해 생성한 VO
	
	private int adoptNo; //게시판 번호
	private String adoptWriter; //작성자
	private String adoptTitle; //제목
	private String adoptContent; //내용
	private Date adoptTime; //작성시간
	private int adoptRead; //조회수
	private Date adoptStart; //입양공고 시작날짜
	private Date adoptEnd; //입양공고 종료날짜
	private String adoptKind; //동물의 품종 혹은 종류
	private String adoptPlace; //구조장소
	private String adoptType;
	private int adoptImgNo; //이미지 파일 번호
    private String adoptImgUpload; //이미지 파일 업로드 이름
    private long adoptImgSize; //이미지 파일 크기
    private String adoptImgType; //파일 유형
	
}
