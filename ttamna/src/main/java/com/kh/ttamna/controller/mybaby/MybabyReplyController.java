package com.kh.ttamna.controller.mybaby;

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

import com.kh.ttamna.entity.mybaby.MybabyReplyDto;
import com.kh.ttamna.repository.mybaby.MybabyDao;
import com.kh.ttamna.repository.mybaby.MybabyReplyDao;
import com.kh.ttamna.vo.pagination.PaginationVO;

@Controller
@RequestMapping("/mybaby_reply")
public class MybabyReplyController {
	@Autowired
	private MybabyDao mybabyDao;

	//데이터 등록 요청을 하기위해서는 PostMapping을 이용하고
	//해당 페이지로 이동 요청을 하기 위해서는 GetMapping을 이용한다
	@Autowired
	private MybabyReplyDao mybabyReplyDao;
	
	@GetMapping("/delete")
	public String home(@RequestParam int mybabyReplyNo,
					@RequestParam int mybabyNo) {
		mybabyReplyDao.delete(mybabyReplyNo);
		
		return "redirect:/mybaby/detail?mybabyNo="+mybabyNo;
	}
	
	//@PostMapping("/delete")
	public String delete(@RequestParam int mybabyReplyNo) {
		mybabyReplyDao.delete(mybabyReplyNo);
		
		return "mybaby/";
	}

	
	// 데이터를 jsp로 보낼때 쓰는 객체는 Model
	// 앞에 @(어노테이션) 이 붙은 애들은 컨트롤러로 데이터를 받아올 때 쓰는 객체

	@GetMapping("/insert")//등록페이지
	public String insert() {
		return "mybaby/reply/insert";
	}
	
	@PostMapping("/insert")//등록요청
	public String insert(@ModelAttribute MybabyReplyDto mybabyReplyDto) {
		mybabyReplyDao.insert(mybabyReplyDto);
		//댓글 등록 할 때 mybaby_reply 를 +1 시켜야한다.
		return "redirect:/mybaby/detail?mybabyNo=" + mybabyReplyDto.getMybabyNo();
	}
	
	//@GetMapping("/list")
	public String list(Model model,@ModelAttribute PaginationVO paginationVO,@RequestParam int mybabyNo) throws Exception {
//		model.addAttribute(JSP에서 부를 이름, 데이터);
		int count = mybabyReplyDao.count(mybabyNo);
		paginationVO.setCount(count);
		System.err.println(count);
		paginationVO.calculator();
		List<MybabyReplyDto> list = mybabyReplyDao.pagenation(paginationVO.getStartRow(), paginationVO.getEndRow(),mybabyNo);
		paginationVO.setListOfMybabyReply(list);
		System.err.println(list);
		model.addAttribute("list", list);
		
		
	
		return "mybaby/detail?mybabyNo="+mybabyNo;
	}
	
	//더보기 페이지네이션 기능 처리
	@PostMapping("/more")
	@ResponseBody
	public List<MybabyReplyDto> more(
			@RequestParam int mybabyNo,
				@RequestParam(required =false, defaultValue = "1") int page,
				@RequestParam(required =false, defaultValue = "12") int size
			){
		System.out.println("모어 컨트롤러 들어옴");
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		return mybabyReplyDao.listByPage(startRow, endRow, mybabyNo);
		
	}
}
