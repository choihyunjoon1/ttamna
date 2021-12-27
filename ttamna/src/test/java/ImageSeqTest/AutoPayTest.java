package ImageSeqTest;

import java.net.URISyntaxException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ttamna.service.kakaopay.KakaoPayService;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayAutoApproveRequestVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class AutoPayTest {

	@Autowired
	private KakaoPayService kakaoService;
	
	@Test
	public void test() throws URISyntaxException {
//		KakaoPayReadyRequestVo requestVo = new KakaoPayReadyRequestVo();
//		
//		requestVo.setPartner_order_id("판매자");
//		requestVo.setPartner_user_id("정기기부신청자");
//		requestVo.setItem_name("정기기부");
//		requestVo.setQuantity(1);
//		requestVo.setTotal_amount(50000L);
//		
//		KakaoPayReadyResponseVo responseVo =  kakaoService.autoReady(requestVo);
//		
//		System.out.println(responseVo.toString());
		
//		KakaoPayApproveRequestVo apRequestVo = new KakaoPayApproveRequestVo();
//		
//		apRequestVo.setPartner_order_id("판매자");
//		apRequestVo.setPartner_user_id("정기기부신청자");
//		apRequestVo.setPg_token("0acfe9e0ba84a75735a0");
//		apRequestVo.setTid("T2979343814935437007");
//		
//		KakaoPayApproveResponseVo apResponseVo = kakaoService.approve(apRequestVo);
//		
//		System.out.println(apResponseVo.toString());
		
		KakaoPayAutoApproveRequestVo requestVo = new KakaoPayAutoApproveRequestVo();
		requestVo.setPartner_order_id("판매자");
		requestVo.setPartner_user_id("정기기부신청자");
		requestVo.setQuantity(1);
		requestVo.setSid("S2979344106992751328");
		requestVo.setTotal_amount(50000);
		
		KakaoPayApproveResponseVo responseVo = kakaoService.autoApprove(requestVo);
		
		System.out.println(responseVo.toString());
	}
}
