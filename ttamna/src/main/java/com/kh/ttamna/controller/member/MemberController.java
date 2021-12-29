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
import com.kh.ttamna.entity.member.VisitDto;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.repository.member.VisitDao;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private VisitDao visitDao;
	
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
	public String login(@ModelAttribute MemberDto memberDto, HttpSession session) {
		MemberDto findDto = memberDao.login(memberDto);
		if(findDto != null) {
			session.setAttribute("uid", findDto.getMemberId());
			session.setAttribute("grade", findDto.getMemberGrade());
			
			//로그인 처리 후에 접속기록을 남기기 위해 객체를 생성하고 저장하는 구문을 불러옴
			//시퀀스를 미리 받아서 visitDto의 visitIdx에 넣는다
			int visitIdx = visitDao.sequence();
			VisitDto visitDto = new VisitDto();
			visitDto.setVisitIdx(visitIdx);
			visitDto.setVisitId(memberDto.getMemberId());
			//접속한지 하루가 지나지 않은 사용자에 대해서는 접속시간을 업데이트하고
			//하루동안 접속한 기록이 없는 사용자는 등록처리하는 메소드를 사용
			visitDao.allInOneLog(visitDto);
			
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
	@RequestMapping("/mypage/my_info")
	public String mypage(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("uid");
		MemberDto memberDto = memberDao.get(memberId);
		
		model.addAttribute("memberDto",memberDto);
		
		return "member/mypage/my_info";
	}
	//정보수정페이지
	@GetMapping("/mypage/edit")
	public String edit(HttpSession session,Model model) {
		String memberId = (String)session.getAttribute("uid");
		MemberDto memberDto = memberDao.get(memberId);
		model.addAttribute("memberDto",memberDto);
		return "member/mypage/edit";
	}
	@PostMapping("/mypage/edit")
	public String edit(HttpSession session, @ModelAttribute MemberDto memberDto) {
		String memberId = (String)session.getAttribute("uid");
		memberDto.setMemberId(memberId);
		
		boolean result = memberDao.changeInfo(memberDto);
		if(result) {
			return "redirect:/member/mypage/edit_success";
		}else {
			return "redirect:/member/mypage/edit?error";
		}
		
	}
	@RequestMapping("/mypage/edit_success")
	public String editSuccess() {
		return "member/mypage/edit_success";
	}
	//비밀번호 변경 페이지
	@GetMapping("/mypage/change_pw")
	public String changePw() {
		return "member/mypage/change_pw";
	}
	@PostMapping("/mypage/change_pw")
	public String changePw(@RequestParam String memberPw, @RequestParam String memberNewPw,HttpSession session) {
		String memberId = (String)session.getAttribute("uid");
		boolean result = memberDao.changePw(memberId,memberPw,memberNewPw);
		if(result) {
			return "redirect:/member/mypage/change_pw_success";
		}else {
			return "redirect:/member/mypage/change_pw?error";
		}
	}
	@RequestMapping("/mypage/change_pw_success")
	public String changePwSuccess() {
		return "member/mypage/change_pw_success";
	}
	//내 게시글 보기
	@RequestMapping("/mypage/my_board")
	public String myBoard() {
		return "member/mypage/my_board";
	}
	//주문내역
	@RequestMapping("/mypage/my_order")
	public String myOrder() {
		return "member/mypage/my_order";
	}
	//장바구니
	@RequestMapping("/mypage/my_basket")
	public String myBasket() {
		return "member/mypage/my_basket";
	}
	//기부내역
	@RequestMapping("/mypage/my_donation")
	public String myDonation() {
		return "member/mypage/my_donation";
	}
	//회원탈퇴
	@GetMapping("/mypage/quit")
	public String quit(HttpSession session,Model model) {
		String memberId = (String)session.getAttribute("uid");
		model.addAttribute("memberId",memberId);
		return "member/mypage/quit";
	}
	@PostMapping("/mypage/quit")
	public String quit(@RequestParam String memberPw,HttpSession session) {
		String memberId = (String)session.getAttribute("uid");
		
		boolean result = memberDao.quit(memberId,memberPw);
		if(result) {
			//회원탈퇴 진행하면 세션,등급 삭제 후 회원탈퇴 성공 페이지로
			session.removeAttribute("uid");
			session.removeAttribute("grade");
			return "redirect:/member/quit_success";
		}else {
			return "redirect:/member/mypage/quit?error";
		}
	}
	@RequestMapping("/quit_success")
	public String quitSuccess() {
		return "member/quit_success";
	}
	
	

	

}
