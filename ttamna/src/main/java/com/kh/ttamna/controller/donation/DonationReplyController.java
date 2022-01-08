package com.kh.ttamna.controller.donation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttamna.entity.donation.DonationReplyDto;
import com.kh.ttamna.repository.donation.DonationReplyDao;
import com.kh.ttamna.vo.pagination.PaginationVO;

@Controller
@RequestMapping("/donation_reply")
public class DonationReplyController {

	//데이터 등록 요청을 하기위해서는 PostMapping을 이용하고
	//해당 페이지로 이동 요청을 하기 위해서는 GetMapping을 이용한다
	@Autowired
	private DonationReplyDao donationReplyDao;
	
	@GetMapping("/delete")
	public String home(@RequestParam int donationReplyNo,
					@RequestParam int donationNo) {
		donationReplyDao.delete(donationReplyNo);
		
		return "redirect:/donation/detail?donationNo="+donationNo;
	}
	
	//@PostMapping("/delete")
	public String delete(@RequestParam int donationReplyNo) {
		donationReplyDao.delete(donationReplyNo);
		
		return "donation/";
	}


	@GetMapping("/insert")//등록페이지
	public String insert() {
		return "donation/reply/insert";
	}
	
	@PostMapping("/insert")//등록요청
	public String insert(@ModelAttribute DonationReplyDto donationReplyDto) {
		donationReplyDao.insert(donationReplyDto);
		return "redirect:/donation/detail?donationNo=" + donationReplyDto.getDonationNo();
	}
	
	//@GetMapping("/list")
	public String list(Model model,@ModelAttribute PaginationVO paginationVO,@RequestParam int donationNo) throws Exception {
//		model.addAttribute(JSP에서 부를 이름, 데이터);
		int count = donationReplyDao.count(donationNo);
		paginationVO.setCount(count);
		System.err.println(count);
		paginationVO.calculator();
		List<DonationReplyDto> list = donationReplyDao.pagenation(paginationVO.getStartRow(), paginationVO.getEndRow(),donationNo);
		paginationVO.setListOfDonaReply(list);
		System.err.println(list);
		model.addAttribute("list", list);
		
		
	
		return "donation/detail?donationNo="+donationNo;
	}
	
	//더보기 페이지네이션 기능 처리
	@PostMapping("/more")
	@ResponseBody
	public List<DonationReplyDto> more(
			@RequestParam int donationNo,
				@RequestParam(required =false, defaultValue = "1") int page,
				@RequestParam(required =false, defaultValue = "12") int size
			){
		System.out.println("모어 컨트롤러 들어옴");
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		return donationReplyDao.listByPage(startRow, endRow, donationNo);
		
	}
}
