package com.kh.ttamna.controller.donation;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttamna.entity.donation.AutoPayMentDto;
import com.kh.ttamna.entity.payment.PaymentDto;
import com.kh.ttamna.repository.donation.AutoDonationDao;
import com.kh.ttamna.repository.donation.DonationDao;
import com.kh.ttamna.repository.payment.PaymentDao;
import com.kh.ttamna.service.donation.DonationService;
import com.kh.ttamna.service.kakaopay.KakaoPayService;
import com.kh.ttamna.vo.kakaopay.KaKaoPayAutoPayMentSearchResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayAutoPayMentInactiveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayCancelResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPaySearchResponseVo;

@Controller
@RequestMapping("/donation/kakao")
public class PayController {
	
	@Autowired
	private KakaoPayService kakaoService;
	
	@Autowired
	private DonationService donationService;
	
	@Autowired
	private AutoDonationDao autoDonationDao;
	
	@Autowired
	private DonationDao donationDao;
	
	@Autowired
	private PaymentDao payDao;
	
	@PostMapping("/fund")//단건결제 요청
	public String confirm(
					@RequestParam int donationNo,
					@ModelAttribute KakaoPayReadyRequestVo requestVo
					, HttpSession session) throws URISyntaxException {
		KakaoPayReadyResponseVo responseVo = kakaoService.ready(requestVo);
		session.setAttribute("tid", responseVo.getTid());
		session.setAttribute("partner_user_id", requestVo.getPartner_user_id());
		//정기결제인지 단건결제인지 구분하기 위한 세션 추가
		session.setAttribute("donationNo", donationNo);
		session.setAttribute("cid", "단건결제");
		return "redirect:"+responseVo.getNext_redirect_pc_url();
	}
	
	@PostMapping("/autofund")//정기결제 요청
	public String autoConfirm(
			@RequestParam int donationNo,
			@ModelAttribute KakaoPayReadyRequestVo requestVo
				, HttpSession session) throws URISyntaxException {
		KakaoPayReadyResponseVo responseVo = kakaoService.autoReady(requestVo);
		
		session.setAttribute("tid", responseVo.getTid());
		session.setAttribute("partner_user_id", requestVo.getPartner_user_id());
		//정기결제인지 단건결제인지 구분하기 위한 세션 추가
		session.setAttribute("cid", "정기결제");
		session.setAttribute("donationNo", donationNo);
		return "redirect:"+responseVo.getNext_redirect_pc_url();
	}
	
	
	//결제 요청이 성공하면 주소에 pg토큰이 담겨서 온다.
	@GetMapping("/success")
	public String approve(@RequestParam String pg_token,
									HttpSession session) throws URISyntaxException {
		String tid = (String)session.getAttribute("tid");
		String partner_user_id = (String)session.getAttribute("partner_user_id");
		Integer donationNo = (int)session.getAttribute("donationNo");
		
		session.removeAttribute("tid");
		session.removeAttribute("partner_user_id");
		session.removeAttribute("donationNo");
		
		//결제 승인 요청을 보내기위한 Vo 생성
		KakaoPayApproveRequestVo requestVo = new KakaoPayApproveRequestVo();
		requestVo.setPartner_user_id(partner_user_id);
		requestVo.setTid(tid);
		requestVo.setPg_token(pg_token);
		
		KakaoPayApproveResponseVo responseVo = new KakaoPayApproveResponseVo();
		
		//결제구분용 코드
		String cidType = (String)session.getAttribute("cid");
		session.removeAttribute("cid");
		System.out.println("cidType = ?" + cidType);
		if(cidType.equals("정기결제")) {
			//정기결제용 cid는 TCSUBSCRIP
			requestVo.setCid("TCSUBSCRIP");
			responseVo = kakaoService.approve(requestVo);
			
			//정기결제승인이 된 시점에서 정기결제테이블에 데이터 등록
			AutoPayMentDto apmDto = new AutoPayMentDto();
			apmDto.setAutoSid(responseVo.getSid());
			apmDto.setPartnerUserId(partner_user_id);
			apmDto.setAutoTotalAmount(responseVo.getAmount().getTotal());
			apmDto.setDonationNo(donationNo);
			autoDonationDao.insert(apmDto);
			
		} else if(cidType.equals("단건결제")) {
			//단건결제용 cid는 TC0ONETIME
			requestVo.setCid("TC0ONETIME");
			responseVo = kakaoService.approve(requestVo);
			PaymentDto paymentDto = new PaymentDto();
			paymentDto.setPayNo(payDao.seq());
			paymentDto.setTid(tid);
			paymentDto.setMemberId(partner_user_id);
			paymentDto.setTotalAmount(responseVo.getAmount().getTotal());
			paymentDto.setDonationNo(donationNo);
			payDao.insertDonation(paymentDto);
		} else {
			throw new URISyntaxException("둘다아닌데요?", "둘다아니에요 ㅎㅎ");
		}
		
		//금액이 결제된 시점에서 해당 게시판의 donationNowFund를 업데이트
		donationDao.funding(donationNo, responseVo.getAmount().getTotal());
		
		return "redirect:/donation/kakao/success_result";
	}
	
	@GetMapping("/success_result")
	public String success() {
		return "donation/kakao/success_result";
	}
	
	@GetMapping("/auto/search")//정기기부 조회 요청
	public String autoSearch(@RequestParam String sid, Model model) throws URISyntaxException {
		KaKaoPayAutoPayMentSearchResponseVo responseVo = kakaoService.autoSearch(sid);
		model.addAttribute("searchList", responseVo);
		return "donation/kakao/auto_search";
	}
	
	@GetMapping("/auto/inactive")//정기기부 비활성화 요청
	public String autoInactive(@RequestParam String sid, Model model) throws URISyntaxException {
		KakaoPayAutoPayMentInactiveResponseVo responsevo = kakaoService.autoInactive(sid);
		donationService.updatePrice(sid);//sid를 넣으면 그걸로 아이디를 찾고 금액을 -로 업데이트 해주는 서비스
		autoDonationDao.autoPayDelete(sid);
		return "redirect:/member/mypage/my_donation";
	}
	
	@GetMapping("/search")//단건결제 조회 요청
	public String search(@RequestParam String tid, Model model) throws URISyntaxException {
		KakaoPaySearchResponseVo responseVo = kakaoService.search(tid);
		model.addAttribute("searchList", responseVo);
		return "donation/kakao/search";
	}
	
	@GetMapping("/cancel")//결제 취소 요청
	public String cancel(@RequestParam String tid, @RequestParam long amount,
								@RequestParam int payNo,Model model) throws URISyntaxException {
		KakaoPayCancelResponseVo responseVo = kakaoService.cancel(tid, amount);
		
		payDao.cancelDonation(payNo);
		donationService.updatePrice(payNo);
		model.addAttribute("cancelList", responseVo);
		
		return "donation/kakao/cancel";
	}
}
