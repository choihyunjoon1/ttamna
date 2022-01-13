package com.kh.ttamna.repository.question;

import java.util.List;
import java.util.Map;

import com.kh.ttamna.entity.mybaby.MybabyDto;
import com.kh.ttamna.entity.question.QuestionDto;
import com.kh.ttamna.vo.mybaby.MybabyDownVO;

public interface QuestionDao {
	//게시글 등록
	int write(QuestionDto questionDto);
	//조회
	List<QuestionDto> list();//목록
	List<QuestionDto> detailOrSearch(Map<String, Object> data);//상세, 검색
	List<QuestionDto> listBySearchPage(int startRow, int endRow, String column, String keyword);
	List<QuestionDto> listByPage(int startRow, int endRow);
	QuestionDto detail(int questionNo);
	boolean delete(int questionNo);
	boolean edit(QuestionDto questionDto);
	boolean editType(int questionNo, String questionType);
}
