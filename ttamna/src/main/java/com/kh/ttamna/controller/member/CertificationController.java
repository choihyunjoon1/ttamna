package com.kh.ttamna.controller.member;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttamna.entity.member.CertificationDto;
import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.CertificationDao;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.service.member.EmailService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/find")
public class CertificationController {

	@Autowired
	private EmailService service;
	
	@Autowired
	private CertificationDao certDao;
	
	@Autowired
	private MemberDao memberDao;
	

	/////////////////////////////////////////////////아이디 찾기///////////////////////////////////////////////////////
	
	//아이디 찾기
	@GetMapping("/findId")
	public String findId() {
		return "find/findId";
	}
	
	//이메일로 인증번호 보내기
	@PostMapping("/findId")
	public String certId(@RequestParam String certEmail, Model m) throws FileNotFoundException, MessagingException, IOException {
		service.sendCertification(certEmail);
		m.addAttribute("certEmail", certEmail);
		//인증번호 메일 전송후 인증번호 확인 페이지로 이동
		return "find/checkByCertToId";
	}
	
	//인증번호 확인
	@PostMapping("/checkByCertToId")
	public String checkByCertToId(@ModelAttribute CertificationDto certDto, Model m) {
		MemberDto memberDto = memberDao.getByEmail(certDto.getCertEmail());
		String findId = memberDto.getMemberId();
		String memberEmail = memberDto.getMemberEmail();
		boolean success = certDao.checkByCert(certDto);
		if(success) {
			//인증 성공하면 아이디를 알려줘야 한다
			m.addAttribute("memberEmail", memberEmail);
			m.addAttribute("findId", findId);
			return "redirect:/find/findId_success";
		}
		else {
			return "redirect:/find/findId?error";
		}
	}
	
	//인증 성공 후 해당 이메일의 아이디를 전달
	@RequestMapping("/findId_success")
	public String findIdSuccess(@RequestParam String findId, @RequestParam String memberEmail) {
		return "find/findId_success";
	}
	
	/////////////////////////////////////////////////비밀번호 찾기///////////////////////////////////////////////////////

	//아이디 찾기
	@GetMapping("/findPw")
	public String findPw() {
		return "find/findPw";
	}
	
	//이메일로 인증번호 보내기
	@PostMapping("/findPw")
	public String certPw(@RequestParam String certEmail, Model m) throws FileNotFoundException, MessagingException, IOException {
		service.sendCertification(certEmail);
		m.addAttribute("certEmail", certEmail);
		//인증번호 메일 전송후 인증번호 확인 페이지로 이동
		return "find/checkByCertToPw";
	}
	
	//인증번호 확인
	@PostMapping("/checkByCertToPw")
	public String checkByCertToPw(@ModelAttribute CertificationDto certDto, Model m) {
		MemberDto memberDto = memberDao.getByEmail(certDto.getCertEmail());
		String memberEmail = memberDto.getMemberEmail();
		boolean success = certDao.checkByCert(certDto);
		if(success) {
			//인증 성공하면 비밀번호 재설정 페이지로 이동
			m.addAttribute("memberEmail", memberEmail);
			return "redirect:/find/resetPw";
		}
		else {
			return "redirect:/find/findPw?error";
		}
	}
	
	//인증 성공 후 비밀번호 재설정
	@GetMapping("/resetPw")
	public String resetPw() {
		
		return "find/resetPw";
	}
	
	@PostMapping("/resetPw")
	public String updatePw(
				@RequestParam String memberEmail,
				@RequestParam String memberId,
				@RequestParam String resetPw,
				Model m) {
		MemberDto memberDto = memberDao.getByEmail(memberEmail);
		//인증에 사용한 이메일 주소로 조회한 memberDto의 아이디와 입력한 아이디가 일치하면 재설정
		if(memberDto.getMemberId().equals(memberId)) {
			//재설정 후에 로그인 페이지로 이동
			memberDao.resetPw(memberId, resetPw);
			return "redirect:/member/login?resetPw_complete";
		}else {	//인증에 사용한 이메일 주소로 조회한 memberDto의 아이디와 입력한 아이디가 일치하지 않으면 error
			m.addAttribute("memberEmail", memberEmail);
			return "redirect:/find/resetPw?error";
		}
		
	}
/////////////////////////////////////////////////비밀번호 찾기(휴면)///////////////////////////////////////////////////////
	@GetMapping("/resetPwDor")
	public String resetPwDor() {
		return "find/resetPwDor";
	}
	@PostMapping("/resetPwDor")
	public String resetPwDor(@RequestParam String resetPw,HttpSession session) {
		String memberId = (String)session.getAttribute("uid");
		memberDao.resetPw(memberId, resetPw);
		return "redirect:/member/login?resetPw_complete";
		
	}
	
}
