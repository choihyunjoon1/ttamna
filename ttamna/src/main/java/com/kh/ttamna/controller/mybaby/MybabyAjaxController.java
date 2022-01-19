package com.kh.ttamna.controller.mybaby;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ttamna.repository.mybaby.MybabyLikeDao;

@RestController
@RequestMapping("/mybaby/ajax")
public class MybabyAjaxController {
	
	@Autowired
	private MybabyLikeDao mybabyLikeDao;
	
	@RequestMapping("/insert")
	public void likeInsert(@RequestParam int mybabyNo,HttpSession session) {
		String memberId = (String)session.getAttribute("uid");
		mybabyLikeDao.insert(mybabyNo,memberId);
	}
	
	@RequestMapping("/delete")
	public void likeDelete(@RequestParam int mybabyNo,HttpSession session) {
		String memberId = (String)session.getAttribute("uid");
		mybabyLikeDao.delete(mybabyNo,memberId);
	}
	
	
}
