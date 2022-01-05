package com.kh.ttamna.entity.payment;

import lombok.Data;

@Data
public class PaymentDetailDto {
	private int payNo;
	private int shopNo;
	private String shopGoods;
	private int quantity;
	private int price;
	private String status;
	
	public boolean isCancelAvailable() {
		return status != null && status.equals("결제");
	}
}
