package com.kh.ttamna.controller.shop;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttamna.entity.cart.CartDto;
import com.kh.ttamna.entity.payment.PaymentDetailDto;
import com.kh.ttamna.entity.payment.PaymentDto;
import com.kh.ttamna.entity.shop.ShopDto;
import com.kh.ttamna.repository.payment.PaymentDao;
import com.kh.ttamna.repository.payment.PaymentDetailDao;
import com.kh.ttamna.repository.shop.ShopDao;
import com.kh.ttamna.service.kakaopay.ShopPayService;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyRequestVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayReadyResponseVo;
import com.kh.ttamna.vo.shop.ShopOrderListVO;
import com.kh.ttamna.vo.shop.ShopOrderVO;

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
	private PaymentDetailDao payDetailDao;
	
	
	@PostMapping("/buy")//단일결제 요청
	public String confirm(@ModelAttribute KakaoPayReadyRequestVo requestVo
					, HttpSession session) throws URISyntaxException {
		KakaoPayReadyResponseVo responseVo = shopPayService.ready(requestVo);
		session.setAttribute("tid", responseVo.getTid());
		session.setAttribute("partner_user_id", requestVo.getPartner_user_id());
		return "redirect:"+responseVo.getNext_redirect_pc_url();		
	}
	
	@GetMapping("/cart/multibuy")
	public String multibuy(@ModelAttribute ShopOrderListVO vo) {
		return "redirect:/shop/order/cart/list";
	}
	
	
	// 묶음결제
	@PostMapping("/multibuy")
	public String multibuy(@ModelAttribute ShopOrderListVO listVO, HttpSession session) throws URISyntaxException {
		String memberId = (String)session.getAttribute("uid"); // partner_user_id에 첨부할 구매자의 정보가 필요함
		
		//결제 성공 시 수량을 등록하기 위해 세션에 데이터 저장
		session.setAttribute("quantity", listVO.getList());
		
		List<ShopDto> list = new ArrayList<>();
		for(ShopOrderVO shopOrderVo : listVO.getList()) {
			ShopDto Dto = shopDao.search(shopOrderVo.getShopNo());
			list.add(Dto);
		}
		String item_name = list.get(0).getShopGoods();
		if(list.size() > 1) {
			item_name += " 외 " + (list.size() -1 ) + "건";
		}
		long total = 0L;
		for(ShopOrderVO shopOrderVo : listVO.getList()) {
			ShopDto Dto = shopDao.search(shopOrderVo.getShopNo());
			total += shopOrderVo.getQuantity() * Dto.getShopPrice();
		}
		
		int seq = paymentDao.seq();
		System.out.println("SEQ = " + seq);
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
			//기존의 장바구니에 있던 데이터들을 추출한다.
			List<CartDto> beforeCart = (List<CartDto>)session.getAttribute("cart");
			//들어올때 장바구니 세션을 모두 삭제한다.
			session.removeAttribute("cart");
			System.out.println("장바구니 삭제됨");
			
			String tid = (String)session.getAttribute("tid");
			String partner_order_id = (String)session.getAttribute("partner_order_id");
			String partner_user_id = (String)session.getAttribute("partner_user_id");
			String shopNo = (String)session.getAttribute("shopNo");
			List<ShopDto> list = (List<ShopDto>) session.getAttribute("list");
			List<ShopOrderVO> shopOrderVo = (List<ShopOrderVO>)session.getAttribute("quantity");
			
			System.out.println("tid = "+tid);
			System.out.println("partner_order_id = "+partner_order_id);
			System.out.println("partner_user_id = "+partner_user_id);
			
			session.removeAttribute("tid");
			session.removeAttribute("partner_order_id");
			session.removeAttribute("partner_user_id");
			session.removeAttribute("quantity");
			
			
			
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
			
			List<Integer> shopNoList = new ArrayList<>();
			for(ShopOrderVO shopOrderDto : shopOrderVo) {
				//상품 정보를 가져오고
				ShopDto shopDto = shopDao.get(shopOrderDto.getShopNo());
				
				//상품 상세정보를 ㅌ테이블에 등록 (성공시점에서)
				PaymentDetailDto payDetailDto = new PaymentDetailDto();
				payDetailDto.setPayNo(Integer.parseInt(partner_order_id));
				payDetailDto.setShopNo(shopDto.getShopNo());
				payDetailDto.setShopGoods(shopDto.getShopGoods());
				payDetailDto.setQuantity(shopOrderDto.getQuantity());
				payDetailDto.setPrice(shopDto.getShopPrice() * payDetailDto.getQuantity());
				
				payDetailDao.insert(payDetailDto);
				
				shopNoList.add(payDetailDto.getShopNo());
			}
			
			int i = 0;
			List<CartDto> afterCart = new CopyOnWriteArrayList<>();
			for(CartDto cart : beforeCart) {
				boolean isTrue = cart.getShopNo() == shopNoList.get(i) && cart.getMemberId().equals(partner_user_id);
				if(!isTrue) {
					afterCart.add(cart);
				}
			}
			session.setAttribute("cart", afterCart);
			
			return "redirect:/shop/order/success_result";
		}
		
		@GetMapping("/success_result")
		public String success() {
			return "shop/order/success_result";
		}
		
//		@GetMapping("/mypage/cancel_all")
//		public String cancelAll(@RequestParam int shopNo, RedirectAttributes attr) throws URISyntaxException {
//			PaymentDto payDto = paymentDao.get(shopNo);
//			if(payDto.isAllCanceled()) {
//				throw new IllegalArgumentException("취소가 불가능한 항목입니다.");
//			}
//			
//			long amount = payDetailDao.getCancelAvailableAmount(shopNo);
//			
//			KakaoPayCancelResponseVo respVO = shopPayService.cancel(payDto.getTid(), amount);
//			
//			payDetailDao.cancelAll(shopNo);
//			
//			paymentDao.refresh(shopNo);
//			
//			attr.addAttribute("shopNo", shopNo);
//			return "redirect:/"+"member/mypage/order_detail";
//		}
//		
//		@GetMapping("/cancel_part")
//		public String cancelPart(@RequestParam int payNo, @RequestParam int shopNo) throws URISyntaxException {
//			PaymentDetailDto payDetailDto = payDetailDao.get(payNo, shopNo);
//			if(!payDetailDto.isCancelAvailable()) {
//				throw new IllegalArgumentException("취소가 불가능한 항목입니다.");
//			}
//			
//			PaymentDto payDto = paymentDao.get(payNo);
//			
//			KakaoPayCancelResponseVo respVO = shopPayService.cancel(payDto.getTid(), payDetailDto.getPrice());
//			
//			payDetailDao.cancel(payNo, shopNo);
//			
//			paymentDao.refresh(payNo);
//			
//			return "redirect:/"+"member/mypage/order_detail?payNo="+payNo;
//			
//		}
		
	
}
