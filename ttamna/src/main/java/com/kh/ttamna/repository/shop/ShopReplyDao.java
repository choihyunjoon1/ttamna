package com.kh.ttamna.repository.shop;

import java.util.List;


import com.kh.ttamna.entity.shop.ShopReplyDto;

public interface ShopReplyDao {

	public int insert(ShopReplyDto shopReplyDto);//댓글등록
	
	public void delete(int shopReplyNo);//삭제기능
	
	public void edit(String shopReplyContent, String memberId); //댓글 수정 String으로 따로따로 받을 경우
	public void edit2(ShopReplyDto shopReplyDto);//댓글 수정 Dto로 받아오는 경우
	
	public List<ShopReplyDto> list();//댓글리스트

	public ShopReplyDto get(int shopReplyNo);//댓글 단일조회

	public List<ShopReplyDto> list(int shopNo);//해당 게시판의 댓글 조회

	public void edit3(int replyNo, String replyContent);//댓글수정 에이잭스~
	
	List<ShopReplyDto> listByPage(int startRow, int endRow, int shopNo);//더보기 페이지네이션

	List<ShopReplyDto> pagenation(int StartRow,int endRow,  int shopNo);
	
	public int count(int shopNo);
	

	
}
