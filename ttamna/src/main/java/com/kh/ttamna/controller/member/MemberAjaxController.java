package com.kh.ttamna.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.MemberDao;

@RestController
@RequestMapping("/ajax")
public class MemberAjaxController {
	
	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/ajaxId")
	public String ajaxId(@RequestParam String inputId) {
		//전달받은 아이디로 조회한 결과가 null이 아니면 사용중인 아이디 = 중복아이디 NNNN전달
		MemberDto memberDto = memberDao.get(inputId);
		if(memberDto == null) {
			System.out.println("아이디 사용가능. return YYYY");
			return "YYYY";
		}else {
			System.out.println("아이디 중복. return NNNN");
			return "NNNN";
		}
	}
}
