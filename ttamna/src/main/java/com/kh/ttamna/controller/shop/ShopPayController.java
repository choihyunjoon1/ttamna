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

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.entity.payment.PaymentDto;
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

	
	
	@PostMapping("/buy")//단일결제 요청
	public String confirm(@ModelAttribute KakaoPayReadyRequestVo requestVo
					, HttpSession session) throws URISyntaxException {
		KakaoPayReadyResponseVo responseVo = shopPayService.ready(requestVo);
		session.setAttribute("tid", responseVo.getTid());
		session.setAttribute("partner_user_id", requestVo.getPartner_user_id());
		return "redirect:"+responseVo.getNext_redirect_pc_url();		
	}
	
	// 다중 결제
	@PostMapping("/multibuy")
	public String multibuy(@RequestParam List<Integer> shopNo, HttpSession session) throws URISyntaxException {
		String memberId = (String)session.getAttribute("uid"); // partner_user_id에 첨부할 구매자의 정보가 필요함
	
		System.out.println("회원아이디 : "+memberId);
		
		List<ShopDto> list = shopDao.search(shopNo);
		
		String item_name = list.get(0).getShopGoods();
		if(list.size() > 1) {
			item_name += " 외 " + (list.size() -1 ) + "건";
		}
		
		long total = 0L;
		for(ShopDto shopDto : list) {
			total += shopDto.getShopPrice();
		}
		
		int seq = paymentDao.seq();
		KakaoPayReadyRequestVo reqVO = new KakaoPayReadyRequestVo();
		reqVO.setPartner_order_id(String.valueOf(seq));
		reqVO.setPartner_user_id(memberId);
		reqVO.setItem_name(item_name);
		reqVO.setQuantity(1);
		reqVO.setTotal_amount(total);
		System.out.println("주문번호 = "+ reqVO.getPartner_order_id());
		System.out.println("아이디 = "+ reqVO.getPartner_user_id());
		System.out.println("상품명 = "+ reqVO.getItem_name());
		System.out.println("수량 = "+ reqVO.getQuantity());
		System.out.println("총금액 = "+ reqVO.getTotal_amount());
		
		KakaoPayReadyResponseVo respVO = shopPayService.ready(reqVO);
		
		session.setAttribute("partner_order_id", reqVO.getPartner_order_id());
		session.setAttribute("partner_user_id", reqVO.getPartner_user_id());
		session.setAttribute("tid", respVO.getTid());
		session.setAttribute("list", list);
		System.out.println("리퀘스트 주문번호 = "+ reqVO.getPartner_order_id());
		System.out.println("아이디 = "+ reqVO.getPartner_user_id());
		System.out.println("거래아이디 = "+ respVO.getTid());
		System.out.println("리스트 = "+ list);
		
		
		
		
		return "redirect:"+respVO.getNext_redirect_pc_url();
	}
	
	
	//결제 요청이 성공하면 주소에 pg토큰이 담겨서 온다.
		@GetMapping("/success")
		public String approve(@RequestParam String pg_token,
										HttpSession session) throws URISyntaxException {
			String tid = (String)session.getAttribute("tid");
			String partner_order_id = (String)session.getAttribute("partner_order_id");
			String partner_user_id = (String)session.getAttribute("partner_user_id");
			String shopNo = (String)session.getAttribute("shopNo");
			
			System.out.println("tid = "+tid);
			System.out.println("partner_order_id = "+partner_order_id);
			System.out.println("partner_user_id = "+partner_user_id);
			
			session.removeAttribute("tid");
			session.removeAttribute("partner_order_id");
			session.removeAttribute("partner_user_id");
			
			
			
			//결제 승인 요청을 보내기위한 Vo 생성
			KakaoPayApproveRequestVo requestVo = new KakaoPayApproveRequestVo();
			requestVo.setPartner_order_id(partner_order_id);
			requestVo.setPartner_user_id(partner_user_id);
			requestVo.setTid(tid);
			requestVo.setPg_token(pg_token);
			
			KakaoPayApproveResponseVo responseVo = shopPayService.approve(requestVo);			
			

			PaymentDto paymentDto = new PaymentDto();
			paymentDto.setPayNo(Integer.parseInt(partner_order_id));
			paymentDto.setMemberId(responseVo.getPartner_user_id());
			paymentDto.setTid(responseVo.getTid());
			paymentDto.setItemName(responseVo.getItem_name());
			paymentDto.setTotalAmount(responseVo.getAmount().getTotal());
			System.out.println("거래번호"+Integer.parseInt(partner_order_id));
			System.out.println("Tid"+responseVo.getTid());
			System.out.println("상품이름"+responseVo.getItem_name());
			System.out.println("토탈어마운트"+responseVo.getAmount().getTotal());
			
			paymentDao.insert(paymentDto);
			
			
			
			
			return "redirect:/shop/order/success_result";
		}
		
		@GetMapping("/success_result")
		public String success() {
			return "shop/order/success_result";
		}
		
		
		
		
		
	
}
