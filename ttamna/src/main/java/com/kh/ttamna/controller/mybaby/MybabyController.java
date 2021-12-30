package com.kh.ttamna.controller.mybaby;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mybaby")
public class MybabyController {
	@RequestMapping("/")
	public String mybabyList() {
		return "mybaby/list";
	}
}
