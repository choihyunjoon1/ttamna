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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.ttamna.vo.kakaopay.KaKaoPayAutoPayMentSearchResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayAutoApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayAutoPayMentInactiveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayCancelResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPaySearchResponseVo;

@Service
public class KakaoPayServiceImpl implements KakaoPayService{

	@Value("${user.kakaopay.key}")
	public String Auth;
	@Value("${user.kakaopay.contenttype}")
	public String ContentType;
	
	@Override//정기결제용
	public KakaoPayReadyResponseVo autoReady(KakaoPayReadyRequestVo requestVo) throws URISyntaxException {

		RestTemplate template = new RestTemplate();
				
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TCSUBSCRIP");
		body.add("partner_order_id", "티어하임");
		body.add("partner_user_id", requestVo.getPartner_user_id());
		
		body.add("item_name", "정기기부");
		body.add("quantity", "1");
		body.add("total_amount", requestVo.getTotal_amount_string());
		body.add("tax_free_amount", "0");
		
		String baseURI = ServletUriComponentsBuilder.fromCurrentContextPath()
//				.port(8080)
				.path("/donation/kakao")
				.toUriString();
		System.out.println("baseURI = " + baseURI);
		
		body.add("approval_url", baseURI+"/success");
		body.add("cancel_url", baseURI+"/cancel");
		body.add("fail_url", baseURI+"/fail");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		KakaoPayReadyResponseVo responseVo = template.postForObject(uri, entity, KakaoPayReadyResponseVo.class);
		
		return responseVo;
	}

	@Override//단건결제
	public KakaoPayReadyResponseVo ready(KakaoPayReadyRequestVo requestVo) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("partner_order_id", "티어하임");
		body.add("partner_user_id", requestVo.getPartner_user_id());
		
		body.add("item_name", "1회기부");
		body.add("quantity", "1");
		body.add("total_amount", requestVo.getTotal_amount_string());
		body.add("tax_free_amount", "0");
		
		String baseURI = ServletUriComponentsBuilder.fromCurrentContextPath()
//				.port(8080)
				.path("/donation/kakao")
				.toUriString();
		System.out.println("baseURI = " + baseURI);
		
		
		body.add("approval_url", baseURI+"/success");
		body.add("cancel_url", baseURI+"/cancel");
		body.add("fail_url", baseURI+"/fail");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		KakaoPayReadyResponseVo responseVo = template.postForObject(uri, entity, KakaoPayReadyResponseVo.class);
		
		return responseVo;
	}
	
	@Override//정기or단건 결제 승인 요청
	public KakaoPayApproveResponseVo approve(KakaoPayApproveRequestVo requestVo) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization",  "KakaoAK "+Auth);
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

	@Override//단건 결제 조회
	public KakaoPaySearchResponseVo search(String tid) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization",  "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("tid", tid);
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/order");
		
		KakaoPaySearchResponseVo responseVo = template.postForObject(uri, entity, KakaoPaySearchResponseVo.class);
		
		return responseVo;
	}

	@Override//단건 결제 취소
	public KakaoPayCancelResponseVo cancel(String tid, long amount) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization",  "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("tid", tid);
		body.add("cancel_amount", String.valueOf(amount));
		body.add("cancel_tax_free_amount", "0");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/cancel");
		
		KakaoPayCancelResponseVo responseVo = template.postForObject(uri, entity, KakaoPayCancelResponseVo.class);
		
		return responseVo;
	}

	@Override//정기결제 요청
	public KakaoPayApproveResponseVo autoApprove(KakaoPayAutoApproveRequestVo requestVo) throws URISyntaxException {

		RestTemplate template = new RestTemplate();
				
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization",  "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TCSUBSCRIP");
		body.add("sid", requestVo.getSid());
		body.add("partner_order_id", "티어하임");
		body.add("partner_user_id", requestVo.getPartner_user_id());
		body.add("quantity", "1");
		body.add("total_amount", requestVo.getTotal_amount_string());
		body.add("tax_free_amount", "0");
		
		String baseURI = ServletUriComponentsBuilder.fromCurrentContextPath()
//				.port(8080)
				.path("/donation/kakao")
				.toUriString();
		System.out.println("baseURI = " + baseURI);
		
		body.add("approval_url", baseURI+"/success");
		body.add("cancel_url", baseURI+"/cancel");
		body.add("fail_url", baseURI+"/fail");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/subscription");
		
		KakaoPayApproveResponseVo responseVo = template.postForObject(uri, entity, KakaoPayApproveResponseVo.class);
		
		return responseVo;
	}
	
	@Override//정기결제 조회
	public KaKaoPayAutoPayMentSearchResponseVo autoSearch(String sid) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization",  "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TCSUBSCRIP");
		body.add("sid", sid);
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/manage/subscription/status");
		
		KaKaoPayAutoPayMentSearchResponseVo responseVo = template.postForObject(uri, entity, KaKaoPayAutoPayMentSearchResponseVo.class);
		
		return responseVo;
	}
	
	@Override//정기결제 비활성화
	public KakaoPayAutoPayMentInactiveResponseVo autoInactive(String sid) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization",  "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TCSUBSCRIP");
		body.add("sid", sid);
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/manage/subscription/inactive");
		
		KakaoPayAutoPayMentInactiveResponseVo responseVo = template.postForObject(uri, entity, KakaoPayAutoPayMentInactiveResponseVo.class);
		
		return responseVo;
	}
}
