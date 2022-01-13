package com.kh.ttamna.repository.question;

import java.util.List;

import com.kh.ttamna.entity.question.QuestionReplyDto;

public interface QuestionReplyDao {

	public int insert(QuestionReplyDto questionReplyDto);//댓글등록
	
	public void delete(int questionReplyNo);//삭제기능
	
	public List<QuestionReplyDto> list();//댓글리스트

	public QuestionReplyDto get(int questionReplyNo);//댓글 단일조회

	public List<QuestionReplyDto> list(int questionNo);//해당 게시판의 댓글 조회
	
	List<QuestionReplyDto> listByPage(int startRow, int endRow, int questionNo);//더보기 페이지네이션

	List<QuestionReplyDto> pagenation(int StartRow,int endRow,  int questionNo);
	
	public int count(int questionNo);
	

	
}
