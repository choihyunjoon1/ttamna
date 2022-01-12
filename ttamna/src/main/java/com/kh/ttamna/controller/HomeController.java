package com.kh.ttamna.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	@RequestMapping("/uprade")
	public String upgrade() {
		return "upgrade";
	}

}
