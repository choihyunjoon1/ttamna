package com.kh.ttamna.controller.member;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.kh.ttamna.entity.member.DormancyDto;
import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.entity.member.VisitDto;
import com.kh.ttamna.entity.payment.PaymentDetailDto;
import com.kh.ttamna.entity.payment.PaymentDto;
import com.kh.ttamna.repository.cart.CartDao;
import com.kh.ttamna.repository.member.DormancyDao;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.repository.member.VisitDao;
import com.kh.ttamna.repository.payment.PaymentDao;
import com.kh.ttamna.repository.payment.PaymentDetailDao;
import com.kh.ttamna.service.kakaopay.ShopPayService;
import com.kh.ttamna.service.pagination.PaginationService;
import com.kh.ttamna.vo.kakaopay.KakaoPayCancelResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPaySearchResponseVo;
import com.kh.ttamna.vo.pagination.PaginationVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private VisitDao visitDao;
	
	@Autowired
	private DormancyDao dorDao;
	
	@Autowired
	private PaginationService paginationService;
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private PaymentDetailDao payDetailDao;
	
	@Autowired
	private ShopPayService shopPayService;
	
	
	
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
			visitDto.setVisitId(findDto.getMemberId());
			//접속한지 하루가 지나지 않은 사용자에 대해서는 접속시간을 업데이트하고
			//하루동안 접속한 기록이 없는 사용자는 등록처리하는 메소드를 사용
			visitDao.allInOneLog(visitDto);
			
			return "redirect:/";
		}else {//멤버에서 데이터 못 찾을 때 = 휴면계정에서도 찾는다.
			DormancyDto findDor = dorDao.get(memberDto.getMemberId());
			if(findDor != null) {//휴면테이블에서 찾을 때 = 아이디 이메일 받는 페이지 이동
				return "redirect:/dormancy/login_dor";
				
			}else {//휴면에서도 못찾을 때
				return "redirect:login?error";
			}
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
	public String myOrder(Model model) {
		model.addAttribute("list", paymentDao.list());
		return "member/mypage/my_order";
	}
	//주문 상세보기
	@RequestMapping("/mypage/order_detail")
	public String orderDetail(@RequestParam int payNo, Model model) throws URISyntaxException {
		PaymentDto payDto = paymentDao.get(payNo);
		List<PaymentDetailDto> list = payDetailDao.list(payNo);
		
		KakaoPaySearchResponseVo respVO = shopPayService.search(payDto.getTid());
		
		model.addAttribute("payDto", payDto);
		model.addAttribute("payDetailList", list);
		
		return "member/mypage/order_detail";
	}
	
	//기부내역
	@GetMapping("/mypage/my_donation")
	public String myDonation(HttpSession session, @ModelAttribute PaginationVO paginationVO,Model model) throws Exception {
		String memberId = (String)session.getAttribute("uid");
		PaginationVO listPaging = paginationService.apmListPaging(paginationVO, memberId);
		model.addAttribute("paginationVO", listPaging);
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
	
	// 결제 취소
	@GetMapping("/mypage/cancel_all")
	public String cancelAll(@RequestParam int payNo, RedirectAttributes attr) throws URISyntaxException {
		PaymentDto payDto = paymentDao.get(payNo);
		if(payDto.isAllCanceled()) {
			throw new IllegalArgumentException("취소가 불가능한 항목입니다.");
		}
		
		long amount = payDetailDao.getCancelAvailableAmount(payNo);
		
		KakaoPayCancelResponseVo respVO = shopPayService.cancel(payDto.getTid(), amount);
		
		payDetailDao.cancelAll(payNo);
		
		paymentDao.refresh(payNo);
		
		attr.addAttribute("payNo", payNo);
		return "redirect:/member/mypage/order_detail?payNo="+payNo;
	}
	
	@GetMapping("/mypage/cancel_part")
	public String cancelPart(@RequestParam int payNo, @RequestParam int shopNo) throws URISyntaxException {
		PaymentDetailDto payDetailDto = payDetailDao.get(payNo, shopNo);
		if(!payDetailDto.isCancelAvailable()) {
			throw new IllegalArgumentException("취소가 불가능한 항목입니다.");
		}
		
		PaymentDto payDto = paymentDao.get(payNo);
		
		KakaoPayCancelResponseVo respVO = shopPayService.cancel(payDto.getTid(), payDetailDto.getPrice());
		
		payDetailDao.cancel(payNo, shopNo);
		
		paymentDao.refresh(payNo);
		
		return "redirect:/member/mypage/order_detail?payNo="+payNo;
		
	}


}
