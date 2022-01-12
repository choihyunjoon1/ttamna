package com.kh.ttamna.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/")
	public String home() {
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

}
