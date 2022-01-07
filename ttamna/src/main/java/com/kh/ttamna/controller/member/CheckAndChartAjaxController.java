package com.kh.ttamna.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.repository.member.VisitDao;
import com.kh.ttamna.vo.chart.TotalChartVO;

@RestController
@RequestMapping("/ajax")
public class CheckAndChartAjaxController {
	
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
	
	//7일간 일별 방문자수 통계 데이터 전달 ajax
	 @GetMapping("/visitor_daily") 
	 public TotalChartVO visitorDaily() {
		 TotalChartVO chartVO = new TotalChartVO();
		 chartVO.setTitle("[ 최근 7일간 일별 방문자 수 ]");
		 chartVO.setLabel("방문자 수");
		 chartVO.setDataset(visitDao.countDaily());
		 return chartVO;
	 }

	//이번달 일별 방문자 수
	 @GetMapping("/this_month_daily") 
	 public TotalChartVO thisMonthDaily() {
		 TotalChartVO chartVO = new TotalChartVO();
		 chartVO.setTitle("[ 이번 달 일별 방문자 수 ]");
		 chartVO.setLabel("방문자 수");
		 chartVO.setDataset(visitDao.countThisMonthDaily());
		 return chartVO;
	 }
	 
	//이번달 일별 방문자 수
	 @GetMapping("/thisMonth") 
	 public TotalChartVO thisMonth() {
		 TotalChartVO chartVO = new TotalChartVO();
		 chartVO.setTitle("[ 이번 달 누적 방문자 수 ]");
		 chartVO.setLabel("방문자 수");
		 chartVO.setDataset(visitDao.thisMonth());
		 return chartVO;
	 }
	 
	 //이번달부터 6개월 전까지의 월별 누적 방문자수
	 @GetMapping("/monthly")
	 public TotalChartVO monthly() {
		 TotalChartVO chartVO = new TotalChartVO();
		 chartVO.setTitle("[ 최근 6개월 간 월별 방문자 수 ]");
		 chartVO.setLabel("방문자 수");
		 chartVO.setDataset(visitDao.monthly());
		 return chartVO;
	 }
	 
	 //최근 12개월 간 월별 누적 방문자수
	 @GetMapping("/moy")
	 public TotalChartVO moy() {
		 TotalChartVO chartVO = new TotalChartVO();
		 chartVO.setTitle("[ 최근 12개월 간 월별 방문자수 ]");
		 chartVO.setLabel("방문자 수");
		 chartVO.setDataset(visitDao.moy());
		 return chartVO;
	 }
	 
	 //기부금액 최근 7일간 일별 통계
	 //@GetMapping("/donation_daily")
	
	
	 

}




