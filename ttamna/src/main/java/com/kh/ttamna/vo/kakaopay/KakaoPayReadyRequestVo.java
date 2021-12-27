package com.kh.ttamna.vo.kakaopay;

import lombok.Data;

//결제 준비 요청 객체
@Data
public class KakaoPayReadyRequestVo {

	private String item_name;
	private int quantity;
	private long total_amount;
	private String partner_order_id;
	private String partner_user_id;
	
	public String getQuantity_string() {
		return String.valueOf(quantity);
	}
	
	public String getTotal_amount_string() {
		return String.valueOf(total_amount);
	}
}