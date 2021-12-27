package com.kh.ttamna.vo.kakaopay;

import java.util.Date;

import lombok.Data;

@Data
public class KakaoPaySearchResponseVo {

	private String tid;//결제 고유 번호
	private String cid;//가맹점 코드
	private String status;//결제 상태
	private String partner_order_id;//가맹점 주문번호
	private String partner_user_id;//가맹점 회원 ID
	private String payment_method_type;//결제 수단(card/money)
	private Amount amount;//결제 금액 정보
	private Amount canceled_amount;//취소된 금액
	private Amount cancel_available_amount;//취소 가능 금액
	private String item_name;//상품 이름
	private String item_code;//상품 코드
	private int quantity;//상품 수량
	private Date created_at;//결제 준비 요청 시각
	private Date approved_at;//결제 승인 시각
	private Date canceled_at;//결제 취소 시각
	private SelectedCardInfo selected_card_info;//결제 카드 정보
	private PayMentActionDetails[] payment_action_details;//결제/취소 상세
}