package com.kh.ttamna.entity.adopt;

import java.sql.Date;

import lombok.Data;

@Data
public class AdoptDto {

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
	
}
