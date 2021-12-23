package com.kh.ttamna.entity.member;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDto {
	private String memberId;
	private String memberPw;
	private String memberNick;
	private String memberName;
	private String memberPhone;
	private String memberEmail;
	private String memberGrade;
	private Date memberLastLog;
	private Date memberJoin;
	private String postcode;
	private String address;
	private String detailAddress;

}
