package com.kh.ttamna.controller.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ttamna.repository.notice.NoticeDao;
import com.kh.ttamna.repository.notice.NoticeImgDao;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired 
	private NoticeDao noticeDao;
	
	@Autowired 
	private NoticeImgDao noticeImgDao;
	
//	입양전 필독 목록 조회
//	@GetMapping("/list")

//	입양전 필독 상세조회
//	@GetMapping("/detail")

//	입양전 필독 작성 페이지
//	@GettMapping("/write")

//	입양전 필독 작성 처리
//	@PostMapping("/write")

//	입양전 필독 수정 페이지
//	@GetMapping("/edit")

//	입양전 필독 수정 처리
//	@PostMapping("/edit")
	
//	입양전 필독 삭제 처리
	
	
	
}
