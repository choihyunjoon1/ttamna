package com.kh.ttamna.controller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		return "redirect:join_success";
	}
	@RequestMapping("/join_success")
	public String joinSuccess() {
		return "member/join_success";
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
		
			return "redirect:/";
		}else {
			return "redirect:login?error";
		}
		
	}
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("uid");
		session.removeAttribute("grade");
		return "redirect:/";
	}
	//마이페이지
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("uid");
		MemberDto memberDto = memberDao.get(memberId);
		
		model.addAttribute("memberDto",memberDto);
		
		return "member/mypage";
	}
	//정보수정페이지
	@GetMapping("/edit")
	public String edit(HttpSession session,Model model) {
		String memberId = (String)session.getAttribute("uid");
		MemberDto memberDto = memberDao.get(memberId);
		model.addAttribute("memberDto",memberDto);
		return "member/edit";
	}
	@PostMapping("/edit")
	public String edit(HttpSession session, @ModelAttribute MemberDto memberDto) {
		String memberId = (String)session.getAttribute("uid");
		memberDto.setMemberId(memberId);
		
		boolean result = memberDao.changeInfo(memberDto);
		if(result) {
			return "redirect:edit_success";
		}else {
			return "redirect:edit?error";
		}
		
	}
	@RequestMapping("/edit_success")
	public String editSuccess() {
		return "member/edit_success";
	}
	//비밀번호 변경 페이지
	@GetMapping("/change_pw")
	public String changePw() {
		return "member/change_pw";
	}
	@PostMapping("/change_pw")
	public String changePw(@RequestParam String memberPw, @RequestParam String memberNewPw,HttpSession session) {
		String memberId = (String)session.getAttribute("uid");
		boolean result = memberDao.changePw(memberId,memberPw,memberNewPw);
		if(result) {
			return "redirect:change_pw_success";
		}else {
			return "redirect:change_pw?error";
		}
	}
	@RequestMapping("/change_pw_success")
	public String changePwSuccess() {
		return "member/change_pw_success";
	}
	//내 게시글 보기
	@RequestMapping("/my_board")
	public String myBoard() {
		return "member/my_board";
	}
	//주문내역
	@RequestMapping("/my_order")
	public String myOrder() {
		return "member/my_order";
	}
	//장바구니
	@RequestMapping("/my_basket")
	public String myBasket() {
		return "member/my_basket";
	}
	//기부내역
	@RequestMapping("/my_donation")
	public String myDonation() {
		return "member/my_donation";
	}
	
	

	

}
