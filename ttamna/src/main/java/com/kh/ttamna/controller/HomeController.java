package com.kh.ttamna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ttamna.repository.adopt.AdoptDao;
import com.kh.ttamna.repository.donation.DonationDao;
import com.kh.ttamna.repository.mybaby.MybabyDao;
import com.kh.ttamna.repository.shop.ShopDao;

@Controller
public class HomeController {
	@Autowired
	private DonationDao donationDao;
	
	@Autowired
	private AdoptDao adoptDao;
	
	@Autowired
	private MybabyDao mybabyDao;
	
	@Autowired
	private ShopDao shopDao;
	
	@RequestMapping("/")
	public String home(Model model) {
		model.addAttribute("donationList", donationDao.mainList());
		model.addAttribute("adoptList", adoptDao.mainList());
		model.addAttribute("mybabyList", mybabyDao.mainList());
		model.addAttribute("shopList", shopDao.mainList());
		return "home";
	}
	
	//보호소 등급 신청 방법 안내 페이지
	@RequestMapping("/upgrade")
	public String upgrade() {
		return "upgrade";
	}
	
	//정부지원 유기동물 입양비 지원 안내 페이지
	@RequestMapping("/support")
	public String support() {
		return "support";
	}

	//정부지원 유기동물 입양비 지원 안내 페이지
	@RequestMapping("/about_us")
	public String aboutUs() {
		return "about_us";
	}
}
