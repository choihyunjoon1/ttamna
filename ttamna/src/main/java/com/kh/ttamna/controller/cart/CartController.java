package com.kh.ttamna.controller.cart;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ttamna.entity.cart.CartDto;
import com.kh.ttamna.repository.cart.CartDao;

@Controller
@RequestMapping("/member")
public class CartController {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CartDao cartDao;
	
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
		
		// 시퀀스 할당
		int seq = sqlSession.selectOne("cart.seq");		 
		 cartDto.setCartNo(seq);
		
		
		 if(session.getAttribute("cart") == null) {	// 장바구니가 비어있다면
			 List<CartDto> cart = new ArrayList<CartDto>();		 
			session.setAttribute("cart", cart); // 장바구니에 물품 추가해라
			cart.add(cartDto);
			cartDao.insert(cartDto);
		} else {
			List<CartDto> cart = (List<CartDto>)session.getAttribute("cart");
			cart.add(cartDto);
			cartDao.add(cartDto);
		}
		return "redirect:/member/mypage/my_basket";
	}	
	
	// 품목 삭제
			@RequestMapping("/mypage/my_basket/delete")
			public String delete(int cartNo, HttpSession session) {
				session.removeAttribute("cart");
				cartDao.delete(cartNo);
				return "member/mypage/my_basket";
			}
		
		
}