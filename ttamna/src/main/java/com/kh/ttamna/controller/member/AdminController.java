package com.kh.ttamna.controller.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.entity.payment.PaymentDto;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.repository.payment.PaymentDao;
import com.kh.ttamna.service.pagination.PaginationService;
import com.kh.ttamna.vo.pagination.PaginationVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private PaginationService paginationService;
	
	//관리자 메인페이지
	@GetMapping("/main")
	public String main() {
		return "admin/main";
	}

//////////////////////////////////////회원관리/////////////////////////////////////	

	//회원 목록 + 검색 목록 + 페이지네이션	
	@GetMapping("/member/list")
	public String list(@ModelAttribute PaginationVO paginationVO, Model m) throws Exception {
		//페이징 처리하는 회원목록을 PaginationService에서 받아온다.
		PaginationVO listPaging = paginationService.memberListPaging(paginationVO);
		m.addAttribute("paginationVO", listPaging);
		return "admin/member/list";
	}
	
	
	//회원관리-상세페이지
	//회원아이디를 파라미터로 받아 아이디 단일 조회 후 결과인 MemebrDto를 전달
	@GetMapping("/member/detail")
	public String memberDetail(@RequestParam String memberId, Model m) {
		MemberDto memberDto = memberDao.get(memberId);
		m.addAttribute("memberDto", memberDto);
		return "admin/member/detail";
	}
	
	
	//회원 등급 변경
	@PostMapping("/member/edit_grade")
	public String editGrade(@RequestParam String memberId, @RequestParam String memberGrade) {
		memberDao.editGrade(memberId, memberGrade);
		return "redirect:/admin/member/detail?memberId="+memberId+"&success";
	}

//////////////////////////////////////통계/////////////////////////////////////	

	//통계 메인 페이지
	@GetMapping("/statistics/menu")
	public String menu() {
		return "admin/statistics/menu";
	}
	
	//7일간 일별 방문자수 통계 페이지
	 @GetMapping("/statistics/visitor_daily") 
	 public String visitorDaily() {
		 return "admin/statistics/visitor_daily";
	 }
	 
	//월별 방문자수 통계 페이지
	 @GetMapping("/statistics/visitor_monthly") 
	 public String visitorMonthly() {
		 return "admin/statistics/visitor_monthly";
	 }
	 
	 //일별 기부금액 통계 페이지
	 @GetMapping("/statistics/donation_daily")
	 public String donationDaily() {
		 return "admin/statistics/donation_daily";
	 }
	 
	 //월별 기부금액 통계 페이지
	 @GetMapping("/statistics/donation_monthly")
	 public String donationMonthly() {
		 return "admin/statistics/donation_monthly";
	 }
	 
	 //일별 상품 판매금액 통계 페이지
	 @GetMapping("/statistics/shop_daily")
	 public String shopDaily() {
		 return "admin/statistics/shop_daily";
	 }
	 
	 //월별 상품 판매금액 통계 페이지
	 @GetMapping("/statistics/shop_monthly")
	 public String shopMonthly() {
		 return "admin/statistics/shop_monthly";
	 }
	 
	 //통계 검색 페이지
	 @GetMapping("/statistics/search")
	 public String search() {
		 return "admin/statistics/search";
	 }
	 

}




















