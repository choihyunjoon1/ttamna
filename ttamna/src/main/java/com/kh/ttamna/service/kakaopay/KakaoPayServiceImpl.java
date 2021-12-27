package com.kh.ttamna.service.kakaopay;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.kh.ttamna.vo.kakaopay.KakaoPayApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayAutoApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayCancelResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPaySearchResponseVo;

@Service
public class KakaoPayServiceImpl implements KakaoPayService{

	public static final String Auth = "KakaoAK fc05c651ed7d2aca12da712b52a76c3c";
	public static final String ContentType = "application/x-www-form-urlencoded;charset=utf-8";
	
	@Override//정기결제용
	public KakaoPayReadyResponseVo autoReady(KakaoPayReadyRequestVo requestVo) throws URISyntaxException {

		RestTemplate template = new RestTemplate();
				
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TCSUBSCRIP");
		body.add("partner_order_id", "티어하임");
		body.add("partner_user_id", requestVo.getPartner_user_id());
		
		body.add("item_name", "정기기부");
		body.add("quantity", "1");
		body.add("total_amount", requestVo.getTotal_amount_string());
		body.add("tax_free_amount", "0");
		
		
		body.add("approval_url", "http://localhost:8080/ttamna/donation/kakao/success");
		body.add("cancel_url", "http://localhost:8080/ttamna/donation/kakao/cancel");
		body.add("fail_url", "http://localhost:8080/ttamna/donation/kakao/fail");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		KakaoPayReadyResponseVo responseVo = template.postForObject(uri, entity, KakaoPayReadyResponseVo.class);
		
		return responseVo;
	}

	@Override//단건결제
	public KakaoPayReadyResponseVo ready(KakaoPayReadyRequestVo requestVo) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("partner_order_id", "티어하임");
		body.add("partner_user_id", requestVo.getPartner_user_id());
		
		body.add("item_name", "1회기부");
		body.add("quantity", "1");
		body.add("total_amount", requestVo.getTotal_amount_string());
		body.add("tax_free_amount", "0");
		
		
		body.add("approval_url", "http://localhost:8080/ttamna/donation/kakao/success");
		body.add("cancel_url", "http://localhost:8080/ttamna/donation/kakao/cancel");
		body.add("fail_url", "http://localhost:8080/ttamna/donation/kakao/fail");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		KakaoPayReadyResponseVo responseVo = template.postForObject(uri, entity, KakaoPayReadyResponseVo.class);
		
		return responseVo;
	}
	
	@Override//정기or단건 결제 승인 요청
	public KakaoPayApproveResponseVo approve(KakaoPayApproveRequestVo requestVo) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", Auth);
		headers.add("Content-type", ContentType);
		
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", requestVo.getCid());//정기결제 or 단건결제
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

	@Override//정기결제 요청
	public KakaoPayApproveResponseVo autoApprove(KakaoPayAutoApproveRequestVo requestVo) throws URISyntaxException {

		RestTemplate template = new RestTemplate();
				
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TCSUBSCRIP");
		body.add("sid", requestVo.getSid());
		body.add("partner_order_id", "티어하임");
		body.add("partner_user_id", requestVo.getPartner_user_id());
		body.add("quantity", "1");
		body.add("total_amount", requestVo.getTotal_amount_string());
		body.add("tax_free_amount", "0");
		
		
		body.add("approval_url", "http://localhost:8080/ttamna/pay/success");
		body.add("cancel_url", "http://localhost:8080/ttamna/pay/cancel");
		body.add("fail_url", "http://localhost:8080/ttamna/pay/fail");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/subscription");
		
		KakaoPayApproveResponseVo responseVo = template.postForObject(uri, entity, KakaoPayApproveResponseVo.class);
		
		return responseVo;
	}
}
