package com.kh.ttamna.service.kakaopay;

import java.net.URISyntaxException;

import com.kh.ttamna.vo.kakaopay.KakaoPayApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayCancelResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPaySearchResponseVo;

public interface ShopPayService {
		//단건 결제 준비 요청 메소드
		KakaoPayReadyResponseVo ready(KakaoPayReadyRequestVo requestVo) throws URISyntaxException;

		//결제 승인
		KakaoPayApproveResponseVo approve(KakaoPayApproveRequestVo requestVo) throws URISyntaxException;
		
		//결제 조회
		KakaoPaySearchResponseVo search(String tid) throws URISyntaxException;
		
		//결제 취소
		KakaoPayCancelResponseVo cancel(String tid, long amount) throws URISyntaxException;
}
