package com.kh.ttamna.entity.donation;

import java.sql.Date;

import lombok.Data;

@Data
public class AutoPayMentDto {

	private int autoNo;
	private String partner_user_id;
	private String autoSid;
	private int quantity;
	private long auto_total_amount;
	private Date firstPaymentDate;
	private int payTimes;
}
