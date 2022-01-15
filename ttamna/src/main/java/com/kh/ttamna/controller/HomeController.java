package com.kh.ttamna.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	//보호소 등급 신청 방법 안내 페이지
	@GetMapping("/upgrade")
	public String upgrade() {
		return "upgrade";
	}
	
	//정부지원 유기동물 입양비 지원 안내 페이지
	@GetMapping("/support")
	public String support() {
		return "support";
	}

	//사이트 소개 페이지
	@GetMapping("/about_us")
	public String aboutUs() {
		return "about_us";
	}
}
