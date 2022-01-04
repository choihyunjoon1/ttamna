package com.kh.ttamna.entity.mybaby;

import java.sql.Date;

import lombok.Data;

@Data
public class MybabyReplyDto {
	private int mybabyReplyNo;
	private String memberId;
	private int mybabyNo;
	private String mybabyReplyContent;
	private Date mybabyReplyTime;
	private int mybabyReplySuperno;
	private int mybabyReplyGroupno;
	private int mybabyReplyDepth;
}
