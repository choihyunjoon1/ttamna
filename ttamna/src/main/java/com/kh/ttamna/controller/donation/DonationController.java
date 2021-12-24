package com.kh.ttamna.controller.donation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttamna.entity.donation.DonationDto;
import com.kh.ttamna.repository.donation.DonationDao;

@Controller
@RequestMapping("/donation")
public class DonationController {

	@Autowired
	private SqlSession sqlSesion;
	
	@Autowired
	private DonationDao donationDao;
	
	@RequestMapping("/")//목록페이지
	public String defaultList(Model model) {
		model.addAttribute("list", donationDao.list());
		
		return "donation/list";
	}
	@RequestMapping("/list")//목록페이지
	public String list(Model model) {
		model.addAttribute("list", donationDao.list());
		
		return "donation/list";
	}
	
	@GetMapping("/detail")//상세보기페이지로이동
	public String detail(@RequestParam int donationNo, Model model) {
		Map<String, Object> data = new HashMap<>();
		data.put("donationNo", donationNo);
		model.addAttribute("donationDto", donationDao.detailOrSearch(data));
		
		return "donation/detail";
	}
	
	@GetMapping("/delete")//삭제요청
	public String delete(@RequestParam int donationNo) {
		donationDao.delete(donationNo);
		
		return "redirect:/donation/list";
	}
	
	@GetMapping("/edit")//수정페이지로이동
	public String edit(@RequestParam int donationNo, Model model) {
		Map<String, Object> data = new HashMap<>();
		data.put("donationNo", donationNo);
		model.addAttribute("donationDto", donationDao.detailOrSearch(data));
		return "donation/edit";
	}
	
	@PostMapping("/edit")//수정요청
	public String edit(@ModelAttribute DonationDto donationDto) {
		donationDao.edit(donationDto);
		
		return "redirect:/donation/detail?donationNo="+donationDto.getDonationNo();
	}
	
	@GetMapping("/insert")//등록페이지
	public String insert() {
		return "donation/insert";
	}
	
	@PostMapping("/insert")//등록요청
	public String insert(@ModelAttribute DonationDto donationDto) {
		int donationNo = donationDao.insert(donationDto);
		
		return "redirect:/donation/detail?donationNo=" + donationNo;
	}
	
	//더보기 페이지네이션 기능 처리
	@GetMapping("/more")
	@ResponseBody
	public List<DonationDto> more(
				@RequestParam(required =false, defaultValue = "1") int page,
				@RequestParam(required =false, defaultValue = "12") int size
			){
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		
		return donationDao.listByPage(startRow, endRow);
	}
}
