package com.kh.ttamna.entity.member;

import java.sql.Date;

import lombok.Data;

@Data
public class VisitDto {
 
	private int visitIdx;
	private String visitId;
	private Date visitTime;
	
}
