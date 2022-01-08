package com.kh.ttamna.controller.shop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttamna.entity.mybaby.MybabyReplyDto;
import com.kh.ttamna.entity.shop.ShopReplyDto;
import com.kh.ttamna.repository.shop.ShopReplyDao;

@Controller
@RequestMapping("/shop_reply")
public class ShopReplyController {

	//데이터 등록 요청을 하기위해서는 PostMapping을 이용하고
	//해당 페이지로 이동 요청을 하기 위해서는 GetMapping을 이용한다
	@Autowired
	private ShopReplyDao shopReplyDao;
	
	@GetMapping("/delete")
	public String home(@RequestParam int shopReplyNo,
					@RequestParam int shopNo) {
		shopReplyDao.delete(shopReplyNo);
		
		return "redirect:/shop/detail?shopNo="+shopNo;
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam int shopReplyNo) {
		shopReplyDao.delete(shopReplyNo);
		
		return "shop/";
	}

	

	// 데이터를 jsp로 보낼때 쓰는 객체는 Model
	// 앞에 @(어노테이션) 이 붙은 애들은 컨트롤러로 데이터를 받아올 때 쓰는 객체

	@GetMapping("/insert")//등록페이지
	public String insert() {
		return "shop/reply/insert";
	}
	
	@PostMapping("/insert")//등록요청
	public String insert(@ModelAttribute ShopReplyDto shopReplyDto) {
		shopReplyDao.insert(shopReplyDto);
		return "redirect:/shop/detail?shopNo=" + shopReplyDto.getShopNo();
	}
	@GetMapping("/list")
	public String list(Model model) {
//		model.addAttribute(JSP에서 부를 이름, 데이터);
		List<ShopReplyDto> list = shopReplyDao.list();
		
		model.addAttribute("list", list);
		return "shop/reply/list";
	}
	//더보기 페이지네이션 기능 처리
	@PostMapping("/more")
	@ResponseBody
	public List<ShopReplyDto> more(
			@RequestParam int shopNo,
				@RequestParam(required =false, defaultValue = "1") int page,
				@RequestParam(required =false, defaultValue = "12") int size
			){
		System.out.println("모어 컨트롤러 들어옴");
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		return shopReplyDao.listByPage(startRow, endRow, shopNo);
		
	}
}