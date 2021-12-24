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
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttamna.entity.shop.ShopDto;
import com.kh.ttamna.repository.shop.ShopDao;

@Controller
@RequestMapping("/shop")
public class ShopController {
		
	@Autowired
	private ShopDao shopDao;
	
	@RequestMapping("/")
	public String main(Model model) {
		model.addAttribute("list", shopDao.list());
		return "shop/list";
	}
	
	@RequestMapping("/list")
	public String shop(Model model) {
		model.addAttribute("list", shopDao.list());
		return "shop/list";
	}
	
	@GetMapping("/write")
	public String insert() {
		return "shop/write";
	}
	
	@PostMapping("/write")
	public String insert(@ModelAttribute ShopDto shopDto) {
		shopDao.insert(shopDto);
		
		return "redirect:/shop/list";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int shopNo, Model model) {
		ShopDto shopDto = shopDao.get(shopNo);
		model.addAttribute("detail", shopDto);
		return"shop/detail";
	}
	
	@GetMapping("/more")
	@ResponseBody
	public List<ShopDto> more(@RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "12") int size){
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		
		return shopDao.listByPage(startRow, endRow);	
	}
	
	@GetMapping("/delete")
	public String delete(int shopNo) {
		shopDao.delete(shopNo);
		return"redirect:/shop/";
	}
	
	@GetMapping("/edit")
	public String update(@RequestParam int shopNo, Model model) {
		ShopDto shopDto = shopDao.get(shopNo);
		model.addAttribute("update", shopDto);
		return "shop/edit";
	}
	
	@PostMapping("/edit")
	public String update(@ModelAttribute ShopDto shopDto) {
		shopDao.update(shopDto);
		
		return "redirect:/shop/detail?shopNo="+shopDto.getShopNo();
	}
}
