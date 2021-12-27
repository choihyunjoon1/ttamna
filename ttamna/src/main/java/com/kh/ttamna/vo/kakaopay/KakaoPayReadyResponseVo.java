package com.kh.ttamna.vo.kakaopay;

import lombok.Data;

//결제 준비 응답 객체
@Data
public class KakaoPayReadyResponseVo {
	
	private String tid;
	private String next_redirect_pc_url;
	private String created_at;
}