package com.kh.ttamna.controller.mybaby;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ttamna.entity.mybaby.MybabyDto;
import com.kh.ttamna.repository.mybaby.MybabyDao;

@Controller
@RequestMapping("/mybaby")
public class MybabyController {
	
	@Autowired
	private MybabyDao mybaDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/")
	public String mybabyList() {
		return "mybaby/list";
	}
	
	//글작성
	@GetMapping("/write")
	public String write() {
		return "mybaby/write";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute MybabyDto mybaDto,HttpSession session) {
		int mybabyNo = sqlSession.insert("mybaby.seq");
		mybaDao.write(mybaDto);
		return "redirect:detail?mybabyNo="+mybabyNo;
	}
		
	
	
	
}
