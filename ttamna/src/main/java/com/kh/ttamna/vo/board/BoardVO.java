package com.kh.ttamna.vo.board;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	private Date boardTime;
	private String boardType;
	

}
