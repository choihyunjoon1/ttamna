package com.kh.ttamna.controller.adopt;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/adopt")
public class AdoptController {

	//입양공고 root페이지
	@GetMapping("/")
	public String list() {
		return "adopt/list";
	}
}
