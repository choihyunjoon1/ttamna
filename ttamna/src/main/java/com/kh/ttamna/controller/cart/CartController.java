package com.kh.ttamna.controller.cart;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttamna.entity.cart.CartDto;
import com.kh.ttamna.repository.cart.CartDao;

@Controller
@RequestMapping("/member")
public class CartController {

	@Autowired
	private SqlSession sqlSession;
	
	
	//장바구니 진입
	@RequestMapping("/mypage/my_basket")
	public String myBasket(Model model, HttpSession session) {
		model.addAttribute("list", session.getAttribute("cart"));
		return "member/mypage/my_basket";
	}

	// 장바구니 담기
	@PostMapping("/detail/addcart")
	public String addCart(@ModelAttribute CartDto cartDto, HttpSession session) {
		System.out.println("장바구니컨트롤러들어옴");
		System.out.println("카트 디티오 : " + cartDto.toString());
		
		// 시퀀스 할당
		int seq = sqlSession.selectOne("cart.seq");		 
		 cartDto.setCartNo(seq);
		
		 if(session.getAttribute("cart") == null) {	// 장바구니가 비어있다면
			 List<CartDto> cart = new CopyOnWriteArrayList<CartDto>();		 
			session.setAttribute("cart", cart); // 장바구니에 물품 추가해라
			cart.add(cartDto);
//			cartDao.insert(cartDto); // 필수로 있어야함
		}  
		 else {
			List<CartDto> cart = (List<CartDto>)session.getAttribute("cart");
			cart.add(cartDto);
//			cartDao.add(cartDto);
		}
		 
		
		return "redirect:/member/mypage/my_basket";
	}	
	
			// 품목 삭제
			@RequestMapping("/mypage/my_basket/delete")
			public String delete(@RequestParam int cartNo, HttpSession session) {
				System.out.println("지우러 들어옴 ");
				List<CartDto> cart = (List<CartDto>) session.getAttribute("cart");
				System.out.println("cart = " + cart.toString());
				
				for(CartDto cartDto : cart) {
					boolean isTrue =cartDto.getCartNo() == cartNo;
					System.out.println("isTrue = "+isTrue);
					if(isTrue) {
						cart.remove(cartDto);
					}
				}
				System.out.println("cart = " + cart.toString());

				return "redirect:/member/mypage/my_basket";
			}
			// 장바구니 비우기(세션 지워서 표시안되게함)
//			@RequestMapping("/mypage/my_basket/deleteAll")
//			public String deleteAll(HttpSession session) {
//				session.removeAttribute("cart");
//				return "redirect:/member/mypage/my_basket";
//			}
		
		
}