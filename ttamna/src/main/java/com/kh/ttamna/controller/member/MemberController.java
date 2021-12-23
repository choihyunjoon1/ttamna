package com.kh.ttamna.controller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.MemberDao;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.join(memberDto);
		return "redirect:member/join_success";
	}
	@RequestMapping("/join_success")
	public String joinSuccess() {
		return "redirect:/join_success";
	}
	//로그인
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto,HttpSession session) {
		MemberDto findDto = memberDao.login(memberDto);
		if(findDto != null) {
			session.setAttribute("uid", findDto.getMemberId());
			session.setAttribute("grade", findDto.getMemberGrade());
		}
		
		return "redirect:/";
		
	}
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("uid");
		session.removeAttribute("grade");
		return "redirect:/";
	}
	

}
