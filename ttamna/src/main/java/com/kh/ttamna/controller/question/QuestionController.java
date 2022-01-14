package com.kh.ttamna.controller.question;

import java.io.IOException;
import java.util.List;

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


import com.kh.ttamna.entity.question.QuestionDto;
import com.kh.ttamna.repository.question.QuestionDao;


@Controller
@RequestMapping("/question")
public class QuestionController {

	
	@Autowired
	private QuestionDao questionDao;

	//게시글 등록
	@GetMapping("/write")
	public String write() {
		return "question/write";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute QuestionDto questionDto,HttpSession session) {
		String memberId = (String)session.getAttribute("uid");
		questionDto.setMemberId(memberId);
		int questionNo = questionDao.write(questionDto);
		return "redirect:/question/detail?questionNo="+questionNo;
	}

	//상세페이지
	@GetMapping("/detail")
	public String detail(@RequestParam int questionNo,Model model) {
		QuestionDto questionDto = questionDao.detail(questionNo);
		model.addAttribute("question",questionDto);
		model.addAttribute("questionNo", questionNo);
		
		return "question/detail";
	}
	
	
	@RequestMapping("/")//목록페이지
	public String defaultList(Model model) {
		List<QuestionDto> list = questionDao.list();
		model.addAttribute("list",list);
		System.out.println("첫번째목록 컨트롤러들어옴");
		return "question/list";
	}
	
	@RequestMapping("/list")
	public String list(Model model) {
		List<QuestionDto> list = questionDao.list();
		model.addAttribute("list",list);
		System.out.println("두번째목록 컨트롤러들어옴");
		return "question/list";
	}
	//게시글 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int questionNo) {
		questionDao.delete(questionNo);
		return "redirect:/question/list";
	}
	//게시글 수정
	@GetMapping("/edit")
	public String edit(@RequestParam int questionNo,Model model) {
		QuestionDto questionDto = questionDao.detail(questionNo);
		model.addAttribute("question",questionDto);
		
		return "question/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute QuestionDto questionDto) throws IllegalStateException, IOException {
		questionDao.edit(questionDto);
		return "redirect:/question/detail?questionNo="+questionDto.getQuestionNo();
	}
	
	@PostMapping("/edit_type")
	public String editType(@RequestParam int questionNo , @RequestParam String questionType) {
		System.out.println("questionNo = "+questionNo);
		System.out.println("questionType = "+questionType);
		questionDao.editType(questionNo,questionType);
		return "redirect:/question/detail?questionNo="+questionNo;
	}
		
	//더보기 페이지네이션 기능 처리
	@GetMapping("/more")
	@ResponseBody
	public List<QuestionDto> more(
				@RequestParam(required =false, defaultValue = "1") int page,
				@RequestParam(required =false, defaultValue = "12") int size
			){
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		
		return questionDao.listByPage(startRow, endRow);
	}
	

}









