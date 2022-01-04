package com.kh.ttamna.controller.adopt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/adopt")
public class AdoptController {

	@Autowired
	private AdoptDao adoptDao;
	
	//입양공고 전체 목록
	@GetMapping("/list")
	public String adopt() {
		return "adopt/list";
	}
	
	//더보기 페이지네이션 목록 ajax
	@PostMapping("/more")
	@ResponseBody
	public List<AdoptDto> more(
			@RequestParam(required =false, defaultValue = "1") int page,
			@RequestParam(required =false, defaultValue = "10") int size,
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
	
	//@RequestMapping("/list")//목록페이지
	public String list(
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword,
			Model m) {
		
		if(column != null && keyword != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("column", column);
			param.put("keyword", keyword);
			m.addAttribute("list", adoptDao.detailOrSearch(param));
		} else {
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
	
	//입양공고 수정 페이지
	@GetMapping("/edit")
	public String edit(@RequestParam int adoptNo, Model m, HttpSession session) {
		AdoptDto adoptDto = adoptDao.detail(adoptNo);
		String uid = (String) session.getAttribute("uid");
		String grade = (String) session.getAttribute("grade");
		//권한 확인 : 작성자와 세션의 아이디가 일치하거나 관리자일 경우 수정 가능
		if(adoptDto.getAdoptWriter().equals(uid) || grade.equals("관리자")) {
			m.addAttribute("adoptDto", adoptDto);
			return "adopt/edit";
		}else return "adopt/detail?adoptNo="+adoptNo+"&invalid";
	}
	
	//입양공고 수정 처리
	@PostMapping("/edit")
	public String edit(@ModelAttribute AdoptDto adoptDto, Model m) {
		return "redirect:/adopt/detail?adoptNo="+adoptDto.getAdoptNo()+"&success";
	}
	
	//입양공고 삭제 처리
	@GetMapping("/delete")
	public String delete(@RequestParam int adoptNo, HttpSession session) {
		String uid = (String) session.getAttribute("uid");
		String grade = (String) session.getAttribute("grade");
		AdoptDto adoptDto = adoptDao.detail(adoptNo);
		//권한 확인 : 작성자와 세션의 아이디가 일치하거나 관리자일 경우 삭제 가능
		if(adoptDto.getAdoptWriter().equals(uid) || grade.equals("관리자")) {
			adoptDao.delete(adoptNo);
			//권한이 있으면 삭제처리하고 전체 목록으로 deleteSuccess 파라미터를 붙여서 리다이렉트
			return "redirect: list?deleteSuccess";
			//권한이 없다면 invalid파라미터를 붙여서 상세페이지로 돌려보낸다
		}else return "adopt/detail?adoptNo="+adoptNo+"&invalid";
	}

	//조회수 증가 : 게시글 상세보기를 클릭하면 먼저 readUp으로 들어왔다가 상세로 리다이렉트
	@GetMapping("/readUp")
	public String readUp(@RequestParam int adoptNo) {
		adoptDao.readUp(adoptNo);
		return "redirect: detail?adoptNo="+adoptNo;
	}
	
}
