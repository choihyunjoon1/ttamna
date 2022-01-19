package com.kh.ttamna.entity.donation;

import java.sql.Date;

import lombok.Data;

@Data
public class AutoPayMentDto {

	private int autoNo;
	private int donationNo;
	private String partnerUserId;
	private String autoSid;
	private int quantity;
	private long autoTotalAmount;
	private Date firstPaymentDate;
	private int payTimes;
	private String autoStatus;
}
