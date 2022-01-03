package com.kh.ttamna.repository.mybaby;

import java.util.List;

import com.kh.ttamna.entity.mybaby.MybabyReplyDto;

public interface MybabyReplyDao {

	public int insert(MybabyReplyDto mybabyReplyDto);//댓글등록
	
	public void delete(int mybabyReplyNo);//삭제기능
	
	public void edit(String mybabyReplyContent, String memberId); //댓글 수정 String으로 따로따로 받을 경우
	public void edit2(MybabyReplyDto mybabyReplyDto);//댓글 수정 Dto로 받아오는 경우
	
	public List<MybabyReplyDto> list();//댓글리스트

	public MybabyReplyDto get(int mybabyReplyNo);//댓글 단일조회

	public List<MybabyReplyDto> list(int mybabyNo);//해당 게시판의 댓글 조회

	public void edit3(int replyNo, String replyContent);//댓글수정 에이잭스~
	
	

	
}
