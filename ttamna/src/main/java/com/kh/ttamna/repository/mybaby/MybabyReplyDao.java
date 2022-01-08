package com.kh.ttamna.repository.mybaby;

import java.util.List;


import com.kh.ttamna.entity.mybaby.MybabyReplyDto;

public interface MybabyReplyDao {

	public int insert(MybabyReplyDto mybabyReplyDto);//댓글등록
	
	public void delete(int mybabyReplyNo);//삭제기능
	
	public List<MybabyReplyDto> list();//댓글리스트

	public MybabyReplyDto get(int mybabyReplyNo);//댓글 단일조회

	public List<MybabyReplyDto> list(int mybabyNo);//해당 게시판의 댓글 조회
	
	List<MybabyReplyDto> listByPage(int startRow, int endRow, int mybabyNo);//더보기 페이지네이션

	List<MybabyReplyDto> pagenation(int StartRow,int endRow,  int mybabyNo);
	
	public int count(int mybabyNo);
	

	
}
