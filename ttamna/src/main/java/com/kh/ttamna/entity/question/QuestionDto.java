package com.kh.ttamna.entity.question;

import lombok.Data;

@Data
public class QuestionDto {
	private int questionNo;
	private String memberId;
	private String questionTitle;
	private String questionContent;
	private String questionType;
	private String questionTime;
	
	public String questionTimeString() {
		return questionTime.substring(0,10);
	}

}
