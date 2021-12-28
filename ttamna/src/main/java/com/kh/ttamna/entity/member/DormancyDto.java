package com.kh.ttamna.entity.member;

import java.sql.Date;

import lombok.Data;

//휴면회원 계정용 테이블
@Data
public class DormancyDto {
	private String dorMemberId;
	private String dorMemberNick;
	private String dorMemberPhone;
	private String dorMemberEmail;
	private String dorMemberName;
	private String dorMemberGrade;
	private Date dorMemberJoin;
	

}
