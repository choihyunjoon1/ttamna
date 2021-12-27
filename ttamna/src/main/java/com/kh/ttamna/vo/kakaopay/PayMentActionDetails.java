package com.kh.ttamna.vo.kakaopay;

import lombok.Data;

@Data
public class PayMentActionDetails {

	private String aid;//Request 고유 번호
	private String approved_at; //거래 시간
	private int amount;//결제/취소총액
	private int point_amount; //결제/취소 포인트 금액
	private int discount_amount;//할인 금액
	private String payment_action_type;//결제 타입(payment: 결제 , cancel: 취소 , issued_sid : sid 발급)
	private String payload; //Request로 전달한 값
}