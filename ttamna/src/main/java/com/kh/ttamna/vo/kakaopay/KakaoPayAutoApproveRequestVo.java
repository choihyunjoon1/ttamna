package com.kh.ttamna.vo.kakaopay;

import lombok.Data;

@Data
public class KakaoPayAutoApproveRequestVo {

	private String sid;//정기결제 키 , 20자
	private String partner_order_id; //가맹점 주문번호, 최대 100자
	private String partner_user_id;//가맹점 회원 id, 최대 100자 (sid를 발급 받은 첫 결제의 결제 준비 api로 전달한 값과 일치해야 함)
	private int quantity;//상품 수량
	private long total_amount;//상품 총액
	private int tax_free_amount;//비과세 금액(우린 설정 안함 0임)
	
	public String getQuantity_string() {
		return String.valueOf(quantity);
	}
	
	public String getTotal_amount_string() {
		return String.valueOf(total_amount);
	}
}
