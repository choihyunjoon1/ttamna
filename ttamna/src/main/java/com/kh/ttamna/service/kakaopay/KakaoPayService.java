package com.kh.ttamna.service.kakaopay;

import java.net.URISyntaxException;

import com.kh.ttamna.vo.kakaopay.KaKaoPayAutoPayMentSearchResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayAutoApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayAutoPayMentInactiveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayCancelResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPaySearchResponseVo;

public interface KakaoPayService {

	//정기 결제 준비 요청 메소드
	KakaoPayReadyResponseVo autoReady(KakaoPayReadyRequestVo requestVo) throws URISyntaxException;
		
	//단건 결제 준비 요청 메소드
	KakaoPayReadyResponseVo ready(KakaoPayReadyRequestVo requestVo) throws URISyntaxException;
		
	//결제 승인
	KakaoPayApproveResponseVo approve(KakaoPayApproveRequestVo requestVo) throws URISyntaxException;
	
	//결제 조회
	KakaoPaySearchResponseVo search(String tid) throws URISyntaxException;
	
	//결제 취소
	KakaoPayCancelResponseVo cancel(String tid, long amount) throws URISyntaxException;
	
	//정기결제 요청
	KakaoPayApproveResponseVo autoApprove(KakaoPayAutoApproveRequestVo requestVo) throws URISyntaxException;
	
	//정기결제 조회
	KaKaoPayAutoPayMentSearchResponseVo autoSearch(String sid) throws URISyntaxException;
	
	//정기결제 비활성화
	KakaoPayAutoPayMentInactiveResponseVo autoInactive(String sid) throws URISyntaxException;
}
