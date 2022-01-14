package com.kh.ttamna.entity.question;

import java.sql.Date;

import lombok.Data;

@Data
public class QuestionReplyDto {
	private int questionReplyNo;
	private int questionNo;
	private String memberId;
	private String questionReplyContent;
	private String questionReplyTime;
}
