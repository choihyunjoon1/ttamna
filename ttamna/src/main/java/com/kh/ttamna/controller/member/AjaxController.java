package com.kh.ttamna.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.repository.member.VisitDao;
import com.kh.ttamna.vo.chart.VisitTotalChartVO;

@RestController
@RequestMapping("/ajax")
public class AjaxController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private VisitDao visitDao;
	
	//아이디 중복 검사 ajax
	@GetMapping("/ajaxId")
	public String ajaxId(@RequestParam String inputId) {
		//전달받은 아이디로 조회한 결과가 null이 아니면 사용중인 아이디 = 중복아이디 NNNN전달
		MemberDto memberDto = memberDao.get(inputId);
		if(memberDto == null) {
			System.out.println("[ 중복검사 ] 아이디 사용가능. return YYYY");
			return "YYYY";
		}else {
			System.out.println("[ 중복검사 ] 아이디 중복. return NNNN");
			return "NNNN";
		}
	}
	
	//닉네임 중복 검사 ajax
	@GetMapping(value="/ajaxNick", produces="text/plain;charset=UTF-8")
	public String ajaxNick(@RequestParam String inputNick) {
		//전달받은 닉네임으로 조회한 결과가 null이 아니면 사용중인 닉네임 = 중복닉네임 NNNN전달
		MemberDto memberDto = memberDao.getByNick(inputNick);
		if(memberDto == null) {
			System.out.println("[ 중복검사 ] 닉네임 사용가능. return YYYY");
			return "YYYY";
		}else {
			System.out.println("[ 중복검사 ] 닉네임 중복. return NNNN");
			return "NNNN";
		}
	}
	
	//이메일 중복 검사 ajax
	@GetMapping("/ajaxEmail")
	public String ajaxEmail(@RequestParam String inputEmail) {
		//전달받은 이메일로 조회한 결과가 null이 아니면 사용중인 이메일 = 중복이메일 NNNN전달
		MemberDto memberDto = memberDao.getByEmail(inputEmail);
		if(memberDto == null) {
			System.out.println("[ 중복검사 ] 이메일 사용가능. return YYYY");
			return "YYYY";
		}else {
			System.out.println("[ 중복검사 ] 이메일 중복. return NNNN");
			return "NNNN";
		}
	}
	
	//방문자수 조회 전달 ajax
	@GetMapping("/dayLog")
	public String dayLog() {
		int count = visitDao.countByDay();
		return String.valueOf(count);
	}

}




