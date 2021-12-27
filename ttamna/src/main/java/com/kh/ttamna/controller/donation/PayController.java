package com.kh.ttamna.controller.donation;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttamna.entity.donation.AutoPayMentDto;
import com.kh.ttamna.repository.donation.AutoDonationDao;
import com.kh.ttamna.service.kakaopay.KakaoPayService;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyResponseVo;

@Controller
@RequestMapping("/donation/kakao")
public class PayController {
	
	@Autowired
	private KakaoPayService kakaoService;
	
	@PostMapping("/fund")//단건결제 요청
	public String confirm(@ModelAttribute KakaoPayReadyRequestVo requestVo
					, HttpSession session) throws URISyntaxException {
		System.out.println("단건결제 요청으로 들어왔습니다.");
		KakaoPayReadyResponseVo responseVo = kakaoService.ready(requestVo);
		session.setAttribute("tid", responseVo.getTid());
		session.setAttribute("partner_user_id", requestVo.getPartner_user_id());
		//정기결제인지 단건결제인지 구분하기 위한 세션 추가
		session.setAttribute("cid", "단건결제");
		System.out.println("단건결제 요청에서 나갑니다");
		return "redirect:"+responseVo.getNext_redirect_pc_url();
	}
	
	@PostMapping("/autofund")//정기결제 요청
	public String autoConfirm(@ModelAttribute KakaoPayReadyRequestVo requestVo
				, HttpSession session) throws URISyntaxException {
		System.out.println("정기결제 요청으로 들어왔습니다.");
		KakaoPayReadyResponseVo responseVo = kakaoService.autoReady(requestVo);
		
//		KakaoPayApproveRequestVo apRequestVo = new KakaoPayApproveRequestVo();
//		apRequestVo.setCid("TCSUBSCRIP");
//		apRequestvo.set
//		KakaoPayApproveResponseVo apResponseVo = kakaoService.approve(requestVo);
//		
		session.setAttribute("tid", responseVo.getTid());
		session.setAttribute("partner_user_id", requestVo.getPartner_user_id());
		//정기결제인지 단건결제인지 구분하기 위한 세션 추가
		session.setAttribute("cid", "정기결제");
		System.out.println("정기결제 요청에서 나갑니다");
		return "redirect:"+responseVo.getNext_redirect_pc_url();
	}
	@Autowired
	private AutoDonationDao autoDonationDao;
	
	//결제 요청이 성공하면 주소에 pg토큰이 담겨서 온다.
	@GetMapping("/success")
	public String approve(@RequestParam String pg_token,
									HttpSession session) throws URISyntaxException {
		System.out.println("pay컨트롤러에 success로 들어왔어요");
		String tid = (String)session.getAttribute("tid");
		String partner_user_id = (String)session.getAttribute("partner_user_id");
		
		session.removeAttribute("tid");
		session.removeAttribute("partner_user_id");
		
		//결제 승인 요청을 보내기위한 Vo 생성
		KakaoPayApproveRequestVo requestVo = new KakaoPayApproveRequestVo();
		requestVo.setPartner_user_id(partner_user_id);
		requestVo.setTid(tid);
		requestVo.setPg_token(pg_token);
		
		//결제구분용 코드
		String cidType = (String)session.getAttribute("cid");
		session.removeAttribute("cid");
		System.out.println("cidType = ?" + cidType);
		if(cidType.equals("정기결제")) {
			System.out.println("당신은 정기결제로 들어왔어요");
			//정기결제용 cid는 TCSUBSCRIP
			requestVo.setCid("TCSUBSCRIP");
			KakaoPayApproveResponseVo responseVo = kakaoService.approve(requestVo);
			
			//정기결제승인이 된 시점에서 정기결제테이블에 데이터 등록
			System.out.println("정기결제테이블에 데이터를 등록할거에요");
			AutoPayMentDto apmDto = new AutoPayMentDto();
			apmDto.setAutoSid(responseVo.getSid());
			apmDto.setPartner_user_id(partner_user_id);
			apmDto.setAuto_total_amount(responseVo.getAmount().getTotal());
			autoDonationDao.insert(apmDto);
			System.out.println("정기결제테이블에 데이터를 등록했어요잉");
		} else if(cidType.equals("단건결제")) {
			System.out.println("당신은 단건결제로 들어왔어요");
			//단건결제용 cid는 TC0ONETIME
			requestVo.setCid("TC0ONETIME");
			KakaoPayApproveResponseVo responseVo = kakaoService.approve(requestVo);
		} else {
			throw new URISyntaxException("둘다아닌데요?", "둘다아니에요 ㅎㅎ");
		}
		
		return "redirect:donation/list";
	}
}
