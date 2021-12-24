package com.kh.ttamna.controller.donation;

import java.util.HashMap;
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

import com.kh.ttamna.entity.donation.DonationDto;
import com.kh.ttamna.repository.donation.DonationDao;

@Controller
@RequestMapping("/donation")
public class DonationController {

	@Autowired
	private SqlSession sqlSesion;
	
	@Autowired
	private DonationDao donationDao;
	
	@RequestMapping("/")
	public String defaultList(Model model) {
		model.addAttribute("list", donationDao.list());
		
		return "donation/list";
	}
	@RequestMapping("/list")
	public String list(Model model) {
		model.addAttribute("list", donationDao.list());
		
		return "donation/list";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int donationNo, Model model) {
		Map<String, Object> data = new HashMap<>();
		data.put("donationNo", donationNo);
		model.addAttribute("donationDto", donationDao.detailOrSearch(data));
		
		return "donation/detail";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam int donationNo) {
		donationDao.delete(donationNo);
		
		return "redirect:/donation/list";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int donationNo, Model model) {
		Map<String, Object> data = new HashMap<>();
		data.put("donationNo", donationNo);
		model.addAttribute("donationDto", donationDao.detailOrSearch(data));
		return "donation/edit";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute DonationDto donationDto) {
		donationDao.edit(donationDto);
		
		return "redirect:/donation/detail?donationNo="+donationDto.getDonationNo();
	}
	
}
