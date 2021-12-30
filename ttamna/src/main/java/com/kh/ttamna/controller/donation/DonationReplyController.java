package com.kh.ttamna.controller.donation;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttamna.entity.donation.DonationReplyDto;
import com.kh.ttamna.repository.donation.DonationReplyDao;

@Controller
@RequestMapping("donation/reply")
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
	
	@PostMapping("/delete")
	public String delete(@RequestParam int donationReplyNo) {
		donationReplyDao.delete(donationReplyNo);
		
		return "donation/";
	}

	

	@PostMapping("/edit") // 수정요청
	@ResponseBody
	public List<String> edit(@RequestParam String replyContent,
						@RequestParam int replyNo,
						@RequestParam int donationNo) {
		donationReplyDao.edit3(replyNo, replyContent);
		List<String> returnCotent = new ArrayList<String>();
		returnCotent.add(replyContent);
		return returnCotent;
	}
	// 데이터를 jsp로 보낼때 쓰는 객체는 Model
	// 앞에 @(어노테이션) 이 붙은 애들은 컨트롤러로 데이터를 받아올 때 쓰는 객체

	@GetMapping("/insert")//등록페이지
	public String insert() {
		return "donation/reply/insert";
	}
	
	@PostMapping("/insert")//등록요청
	public String insert(@ModelAttribute DonationReplyDto donationReplyDto) {
		donationReplyDao.insert(donationReplyDto);
		return "redirect:/donation/detail?donationNo=" + donationReplyDto.getDonationNo();
	}
	@GetMapping("/list")
	public String list(Model model) {
//		model.addAttribute(JSP에서 부를 이름, 데이터);
		List<DonationReplyDto> list = donationReplyDao.list();
		
		model.addAttribute("list", list);
		return "donation/reply/list";
	}
}
