package com.kh.ttamna.vo.kakaopay;

import lombok.Data;

//결제 승인 요청 객체
@Data
public class KakaoPayApproveRequestVo {
	
	private String tid;
	private String partner_order_id;
	private String partner_user_id;
	private String pg_token;
	private String cid;
}