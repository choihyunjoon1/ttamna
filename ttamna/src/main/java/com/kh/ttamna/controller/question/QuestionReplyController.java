package com.kh.ttamna.controller.question;

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

import com.kh.ttamna.entity.question.QuestionReplyDto;
import com.kh.ttamna.repository.question.QuestionDao;
import com.kh.ttamna.repository.question.QuestionReplyDao;
import com.kh.ttamna.vo.pagination.PaginationVO;

@Controller
@RequestMapping("/question_reply")
public class QuestionReplyController {
	@Autowired
	private QuestionDao questionDao;

	//데이터 등록 요청을 하기위해서는 PostMapping을 이용하고
	//해당 페이지로 이동 요청을 하기 위해서는 GetMapping을 이용한다
	@Autowired
	private QuestionReplyDao questionReplyDao;
	
	@GetMapping("/delete")
	public String home(@RequestParam int questionReplyNo,
					@RequestParam int questionNo) {
		questionReplyDao.delete(questionReplyNo);
		
		return "redirect:/question/detail?questionNo="+questionNo;
	}
	
	//@PostMapping("/delete")
	public String delete(@RequestParam int questionReplyNo) {
		questionReplyDao.delete(questionReplyNo);
		
		return "question/";
	}

	
	// 데이터를 jsp로 보낼때 쓰는 객체는 Model
	// 앞에 @(어노테이션) 이 붙은 애들은 컨트롤러로 데이터를 받아올 때 쓰는 객체

	@GetMapping("/insert")//등록페이지
	public String insert() {
		return "question/reply/insert";
	}
	
	@PostMapping("/insert")//등록요청
	public String insert(@ModelAttribute QuestionReplyDto questionReplyDto) {
		questionReplyDao.insert(questionReplyDto);
		//댓글 등록 할 때 question_reply 를 +1 시켜야한다.
		return "redirect:/question/detail?questionNo=" + questionReplyDto.getQuestionNo();
	}
	
	//@GetMapping("/list")
	public String list(Model model,@ModelAttribute PaginationVO paginationVO,@RequestParam int questionNo) throws Exception {
//		model.addAttribute(JSP에서 부를 이름, 데이터);
		int count = questionReplyDao.count(questionNo);
		paginationVO.setCount(count);
		System.err.println(count);
		paginationVO.calculator();
		List<QuestionReplyDto> list = questionReplyDao.pagenation(paginationVO.getStartRow(), paginationVO.getEndRow(),questionNo);
		paginationVO.setListOfQuestionReply(list);
		System.err.println(list);
		model.addAttribute("list", list);
		
		
	
		return "question/detail?questionNo="+questionNo;
	}
	
	//더보기 페이지네이션 기능 처리
	@PostMapping("/more")
	@ResponseBody
	public List<QuestionReplyDto> more(
			@RequestParam int questionNo,
				@RequestParam(required =false, defaultValue = "1") int page,
				@RequestParam(required =false, defaultValue = "12") int size
			){
		System.out.println("모어 컨트롤러 들어옴");
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		return questionReplyDao.listByPage(startRow, endRow, questionNo);
		
	}
}
