package com.kh.ttamna.controller.mybaby;

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

import com.kh.ttamna.entity.mybaby.MybabyReplyDto;
import com.kh.ttamna.repository.mybaby.MybabyReplyDao;

@Controller
@RequestMapping("mybaby/reply")
public class MybabyReplyController {

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
	
	@PostMapping("/delete")
	public String delete(@RequestParam int mybabyReplyNo) {
		mybabyReplyDao.delete(mybabyReplyNo);
		
		return "mybaby/";
	}

	

	@PostMapping("/edit") // 수정요청
	@ResponseBody
	public List<String> edit(@RequestParam String replyContent,
						@RequestParam int replyNo,
						@RequestParam int mybabyNo) {
		mybabyReplyDao.edit3(replyNo, replyContent);
		List<String> returnCotent = new ArrayList<String>();
		returnCotent.add(replyContent);
		return returnCotent;
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
		return "redirect:/mybaby/detail?mybabyNo=" + mybabyReplyDto.getMybabyNo();
	}
	@GetMapping("/list")
	public String list(Model model) {
//		model.addAttribute(JSP에서 부를 이름, 데이터);
		List<MybabyReplyDto> list = mybabyReplyDao.list();
		
		model.addAttribute("list", list);
		return "mybaby/reply/list";
	}
}
