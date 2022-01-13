package com.kh.ttamna.service.kakaopay;

import java.net.URI;
import java.net.URISyntaxException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.ttamna.repository.payment.PaymentDao;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayCancelResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPaySearchResponseVo;

@Service
public class ShopPayServiceImpl implements ShopPayService{

	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Value("${user.kakaopay.key}")
	public String Auth;
	@Value("${user.kakaopay.contenttype}")
	public String ContentType;
	
	// 단건 결제 준비
	@Override
	public KakaoPayReadyResponseVo ready(KakaoPayReadyRequestVo requestVo) throws URISyntaxException {
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
//		body.add("partner_order_id", "티어하임");
		body.add("partner_order_id", requestVo.getPartner_order_id());
		body.add("partner_user_id", requestVo.getPartner_user_id());
		
		body.add("item_name", requestVo.getItem_name());
		body.add("quantity", "1");
		body.add("total_amount", requestVo.getTotal_amount_string());
		body.add("tax_free_amount", "0");
		
		String baseURI = ServletUriComponentsBuilder.fromCurrentContextPath()
//				.port(8080)
				.path("/shop/order")
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
//		body.add("partner_order_id", "티어하임");
		body.add("partner_order_id", requestVo.getPartner_order_id());
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
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK "+Auth);
		headers.add("Content-type", ContentType);
		
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("tid", tid);
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/order");
		
		KakaoPaySearchResponseVo responseVo = template.postForObject(uri, entity, KakaoPaySearchResponseVo.class);
		
		
		return responseVo;
	}

	@Override
	public KakaoPayCancelResponseVo cancel(String tid, long amount) throws URISyntaxException {
		
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK "+Auth);
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

}
