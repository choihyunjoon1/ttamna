package com.kh.ttamna.repository.notice;

import com.kh.ttamna.entity.notice.NoticeDto;

public interface NoticeDao {

	
	//게시글 작성(등록)
	int write(NoticeDto noticeDto);
	
	//게시글 상세조회
	NoticeDto detail(int noticeNo);
	
	//게시판 목록 조회
	
	//게시글 수정
	
	//게시글 삭제
	
	
}
