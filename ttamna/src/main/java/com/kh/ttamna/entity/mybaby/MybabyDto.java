package com.kh.ttamna.entity.mybaby;

import lombok.Data;

@Data
public class MybabyDto {
	private int mybabyNo;
	private String mybabyWriter;
	private String mybabyTitle;
	private String mybabyContent;
	private String mybabyTime;
	private int mybabyRead;
	private int mybabyReply;
	private String mybabyType;
	
	public String mybabyTimeString() {
		return mybabyTime.substring(0,10);
	}
	

}
