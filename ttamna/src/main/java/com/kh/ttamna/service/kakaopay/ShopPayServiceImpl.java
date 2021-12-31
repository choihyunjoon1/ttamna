package com.kh.ttamna.service.kakaopay;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.kh.ttamna.vo.kakaopay.KakaoPayApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayCancelResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPaySearchResponseVo;

@Service
public class ShopPayServiceImpl implements ShopPayService{

	@Value("${user.kakaopay.key}")
	public String Auth;
	@Value("${user.kakaopay.contenttype}")
	public String ContentType;
	
	// 단건 결제
	@Override
	public KakaoPayReadyResponseVo ready(KakaoPayReadyRequestVo requestVo) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("partner_order_id", "티어하임");
		body.add("partner_user_id", requestVo.getPartner_user_id());
		
		body.add("item_name", requestVo.getItem_name());
		body.add("quantity", "1");
		body.add("total_amount", requestVo.getTotal_amount_string());
		body.add("tax_free_amount", "0");
		
		
		body.add("approval_url", "http://localhost:8080/ttamna/shop/order/success");
		body.add("cancel_url", "http://localhost:8080/ttamna/shop/order/cancel");
		body.add("fail_url", "http://localhost:8080/ttamna/shop/order/fail");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		KakaoPayReadyResponseVo responseVo = template.postForObject(uri, entity, KakaoPayReadyResponseVo.class);
		
		return responseVo;
	}

	// 결제 승인
	@Override
	public KakaoPayApproveResponseVo approve(KakaoPayApproveRequestVo requestVo) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("tid", requestVo.getTid());
		body.add("partner_order_id", "티어하임");
		body.add("partner_user_id", requestVo.getPartner_user_id());
		body.add("pg_token", requestVo.getPg_token());
		
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		//3. 목적지 설정
		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");
		
		//4. 요청방식에 따라 다른 명령으로 전송
		KakaoPayApproveResponseVo responseVo = template.postForObject(uri, entity, KakaoPayApproveResponseVo.class);//응답을 기대하는 요청(Json)
		
		
		return responseVo;
	}

	@Override
	public KakaoPaySearchResponseVo search(String tid) throws URISyntaxException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public KakaoPayCancelResponseVo cancel(String tid, long amount) throws URISyntaxException {
		// TODO Auto-generated method stub
		return null;
	}

}
