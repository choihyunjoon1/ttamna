package com.kh.ttamna.controller.shop;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttamna.entity.shop.ShopReplyDto;
import com.kh.ttamna.repository.shop.ShopReplyDao;

@Controller
@RequestMapping("shop/reply")
public class ShopReplyController {

	//데이터 등록 요청을 하기위해서는 PostMapping을 이용하고
	//해당 페이지로 이동 요청을 하기 위해서는 GetMapping을 이용한다
	@Autowired
	private ShopReplyDao shopReplyDao;
	
	@GetMapping("/delete")
	public String home() {
		
		return "shop/reply/delete";
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam int shopReplyNo) {
		shopReplyDao.delete(shopReplyNo);
		
		return "shop/";
	}

	@GetMapping("/edit") // 수정페이지로 이동
	public String edit(@RequestParam int shopReplyNo, Model model) {
		ShopReplyDto shopReplyDto = shopReplyDao.get(shopReplyNo);
		model.addAttribute("shopReplyDto", shopReplyDto);

		return "shop/reply/edit";
	}

	@PostMapping("/edit") // 수정요청
	public String edit(@RequestParam String memberId, @RequestParam String shopReplyContent,
						@RequestParam int shopNo) {
		shopReplyDao.edit(shopReplyContent, memberId);
		return "redirect:/shop/detail?shopNo=" + shopNo;
	}
	// 데이터를 jsp로 보낼때 쓰는 객체는 Model
	// 앞에 @(어노테이션) 이 붙은 애들은 컨트롤러로 데이터를 받아올 때 쓰는 객체

	@GetMapping("/insert")//등록페이지
	public String insert() {
		return "shop/reply/insert";
	}
	
	@PostMapping("/insert")//등록요청
	public String insert(@ModelAttribute ShopReplyDto shopReplyDto) {
		int shopReplyNo = shopReplyDao.insert(shopReplyDto);
		return "redirect:/shop/detail?shopNo=" + shopReplyDto.getShopNo();
	}
	@GetMapping("/list")
	public String list(Model model) {
//		model.addAttribute(JSP에서 부를 이름, 데이터);
		List<ShopReplyDto> list = shopReplyDao.list();
		
		model.addAttribute("list", list);
		return "shop/reply/list";
	}
}
