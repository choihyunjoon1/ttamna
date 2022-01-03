package com.kh.ttamna.controller.adopt;

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

import com.kh.ttamna.entity.adopt.AdoptDto;
import com.kh.ttamna.repository.adopt.AdoptDao;

@Controller
@RequestMapping("/adopt")
public class AdoptController {

	@Autowired
	private AdoptDao adoptDao;
	
	//입양공고 root페이지(전체 목록)
	@GetMapping("/")
	public String list(
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword,
			Model m) {
		//검색 목록일 경우
		if(column != null && keyword != null) {
			m.addAttribute("column", column);
			m.addAttribute("keyword", keyword);
			m.addAttribute("list", adoptDao.searchList(column, keyword));
		}else{
			m.addAttribute("list", adoptDao.list());
		}
		return "adopt/list";
	}
	
	//입양공고 게시글 등록 페이지
	@GetMapping("/write")
	public String write() {
		return "adopt/write";
	}
	
	//입양공고 게시글 등록 처리
	@PostMapping("/write")
	public String write(@ModelAttribute AdoptDto adoptDto) {
		int adoptNo = adoptDao.write(adoptDto);
		//등록처리 완료 후 상세 페이지로 이동
		return "redirect:/adopt/detail?adoptNo=" + adoptNo;
	}
	
	//상세페이지
	@GetMapping("/detail")
	public String detail(@RequestParam int adoptNo, Model m) {
		AdoptDto adoptDto = adoptDao.detail(adoptNo);
		m.addAttribute("adoptDto", adoptDto);
		return "adopt/detail";
	}
	
	//더보기 페이지네이션 목록
	@GetMapping("/more")
	@ResponseBody
	public List<AdoptDto> more(
				@RequestParam(required =false, defaultValue = "1") int page,
				@RequestParam(required =false, defaultValue = "12") int size,
				@RequestParam(required =false, defaultValue = "") String column,
				@RequestParam(required =false, defaultValue = "") String keyword
			){
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		if(column != null && keyword != null && !column.equals("") && !keyword.equals("")) {
			return adoptDao.searchAndListByPage(startRow, endRow, column, keyword);
		} else {
			return adoptDao.listByPage(startRow, endRow);
		}
		
	}

}
