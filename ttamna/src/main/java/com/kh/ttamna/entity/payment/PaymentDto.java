package com.kh.ttamna.entity.payment;

import java.sql.Date;

import lombok.Data;
@Data
public class PaymentDto {
	private int payNo;
	private String tid;
	private String memberId;
	private String itemName;
	private long totalAmount;
	private Date payTime;
	private String status;
	private String payType;
	private Integer donationNo;
	
	public boolean isAllCanceled() {
		return status == null || status.equals("전체취소");
	}
}
