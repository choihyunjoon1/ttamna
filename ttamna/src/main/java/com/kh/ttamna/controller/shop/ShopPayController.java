package com.kh.ttamna.controller.shop;

import java.net.URISyntaxException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttamna.entity.shop.ShopDto;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.repository.payment.PaymentDao;
import com.kh.ttamna.repository.shop.ShopDao;
import com.kh.ttamna.service.kakaopay.ShopPayService;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyResponseVo;

@Controller
@RequestMapping("/shop/order")
public class ShopPayController {
	@Autowired
	private ShopDao shopDao;
	
	@Autowired
	private PaymentDao paymentDao;

	@Autowired
	private ShopPayService shopPayService;
	@Autowired
	private MemberDao memberDao;
	
	
	@PostMapping("/buy")//단건결제 요청
	public String confirm(@ModelAttribute KakaoPayReadyRequestVo requestVo
					, HttpSession session) throws URISyntaxException {
		KakaoPayReadyResponseVo responseVo = shopPayService.ready(requestVo);
		session.setAttribute("tid", responseVo.getTid());
		session.setAttribute("partner_user_id", requestVo.getPartner_user_id());
		return "redirect:"+responseVo.getNext_redirect_pc_url();		
	}
	
	//결제 요청이 성공하면 주소에 pg토큰이 담겨서 온다.
		@GetMapping("/success")
		public String approve(@RequestParam String pg_token,
										HttpSession session) throws URISyntaxException {
			String tid = (String)session.getAttribute("tid");
			String partner_user_id = (String)session.getAttribute("partner_user_id");
			String shopNo = (String)session.getAttribute("shopNo");
			
			session.removeAttribute("tid");
			session.removeAttribute("partner_user_id");
			session.removeAttribute("shopNo");
			
			//결제 승인 요청을 보내기위한 Vo 생성
			KakaoPayApproveRequestVo requestVo = new KakaoPayApproveRequestVo();
			requestVo.setPartner_user_id(partner_user_id);
			requestVo.setTid(tid);
			requestVo.setPg_token(pg_token);
			
			KakaoPayApproveResponseVo responseVo = shopPayService.approve(requestVo);			
			
			return "redirect:/shop/order/success_result";
		}
		
		@GetMapping("/success_result")
		public String success() {
			return "shop/order/success_result";
		}
		
		
		
		
	
}
