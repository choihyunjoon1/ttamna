package com.kh.ttamna.controller.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.MemberDao;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private MemberDao memberDao;
	
	//관리자 메인페이지
	@GetMapping("/main")
	public String main() {
		return "admin/main";
	}

//////////////////////////////////////회원관리/////////////////////////////////////	
	
	//회원관리-목록페이지
	@GetMapping("/member/list")
	public String memberList(Model m) {
		List<MemberDto> list = memberDao.list();
		m.addAttribute("list", list);
		return "admin/member/list";
	}
	
	//목록 + 페이지네이션
//	@GetMapping("/member/list")
//	public List<MemberDto> listByPage(
//			@RequestParam(required = false, defaultValue = "1") int page,
//			@RequestParam(required = false, defaultValue = "20") int size){
//		int endRow = page*size;
//		int startRow = endRow-(size-1);
//
//		List<MemberDto> list = memberDao.listPaging(startRow, endRow);
//		return list;
//	}
	
	//회원관리-상세페이지
	//회원아이디를 파라미터로 받아 아이디 단일 조회 후 결과인 MemebrDto를 전달
	@GetMapping("/member/detail")
	public String memberDetail(@RequestParam String memberId, Model m) {
		MemberDto memberDto = memberDao.get(memberId);
		m.addAttribute("memberDto", memberDto);
		return "admin/member/detail";
	}
}







