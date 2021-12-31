package com.kh.ttamna.controller.cart;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ttamna.repository.cart.CartDao;

@Controller
@RequestMapping("shop/cart")
public class CartController {
	
	@Autowired
	private CartDao cartDao;
	
		@RequestMapping("/list")
		public String cart(Model model, HttpSession session) {
			model.addAttribute("list", session.getAttribute("cart"));
			return "shop/cart/list";
		}
		
		
		
}
