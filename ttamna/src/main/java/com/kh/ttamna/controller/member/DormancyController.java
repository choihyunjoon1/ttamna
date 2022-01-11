package com.kh.ttamna.controller.member;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttamna.entity.member.CertificationDto;
import com.kh.ttamna.entity.member.DormancyDto;
import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.CertificationDao;
import com.kh.ttamna.repository.member.DormancyDao;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.service.member.EmailService;

@Controller
@RequestMapping("/dormancy")
public class DormancyController {
	@Autowired
	private EmailService service;
	
	@Autowired
	private CertificationDao certDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private DormancyDao dorDao;
	
	//휴면풀기 페이지
	@GetMapping("/login_dor")
	public String loginDor() {
		return "dormancy/login_dor";
	}
	@PostMapping("/login_dor")
	public String loginDor(@RequestParam String memberId,@RequestParam String certEmail,Model model) throws FileNotFoundException, MessagingException, IOException {
		//휴면을 풀기위해 아이디,이메일 입력함.
		//= 1) 이메일로 인증번호를 만들어서 보낸다.
		//= 2) 인증번호 입력이 완료되면 휴면 -> 멤버테이블로 이동(비번은 인증번호로 저장) , 휴면계정 테이블에선 삭제
		//= 3) 아이디와 이메일로 조회해서 휴면계정에 있는 정보 꺼내오고
		//= 4) 인증번호 입력을 다 하면 비밀번호 변경 페이지로 이동
		//1) 이메일로 인증번호를 보냄 / 입력한 이메일을 일단 dormancyDto에서 찾아서 존재할 때 보냄
		DormancyDto findDorDto = dorDao.getByEmail(certEmail);
		if(findDorDto != null) {
			
			service.sendCertification(certEmail);
			
			model.addAttribute("certEmail",certEmail);
			return "dormancy/checkByEmail";
		}else {
			return "dormancy/login_dor?error";
		}
	}
	@PostMapping("/checkByEmail")
	public String checkByEmail(@ModelAttribute CertificationDto certDto,HttpSession session) {
		//이메일로 찾으려는 계정 조회
		DormancyDto findDto = dorDao.getByEmail(certDto.getCertEmail());
		
		boolean success = certDao.checkByCert(certDto);
		if(success) {
			//인증번호 성공 시
			//2) 휴면계정 -> 멤버계정
			String memberPw = certDto.getCertSerial();
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberId(findDto.getDorMemberId());
			memberDto.setMemberPw(memberPw);
			memberDto.setMemberEmail(findDto.getDorMemberEmail());
			memberDto.setMemberPhone(findDto.getDorMemberPhone());
			memberDto.setMemberName(findDto.getDorMemberName());
			memberDto.setMemberNick(findDto.getDorMemberNick());
			memberDto.setMemberJoin(findDto.getDorMemberJoin());
			memberDto.setPostcode(findDto.getDorPostcode());
			memberDto.setAddress(findDto.getDorAddress());
			memberDto.setDetailAddress(findDto.getDorDetailAddress());
			memberDto.setMemberGrade("일반회원");
			memberDao.changeDor(memberDto);
			//3)휴면계정에서 해당 데이터 삭제
			dorDao.delete(findDto.getDorMemberId());
			
			//4)비밀번호 변경을 위해 로그인 처리
			session.setAttribute("uid", memberDto.getMemberId());
			session.setAttribute("grade", memberDto.getMemberGrade());
			
			
			return "redirect:/find/resetPwDor";
			
		}else {
			return "redirect:/dormancy/login_dor?error";
		}
				
		
	}
	

}
