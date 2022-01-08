package com.kh.ttamna.entity.donation;

import java.sql.Date;

import lombok.Data;

@Data
public class DonationReplyDto {
	private int donationReplyNo;
	private String memberId;
	private int donationNo;
	private String donationReplyContent;
	private Date donationReplyTime;
}
