package com.kh.ttamna.repository.question;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.question.QuestionDto;
import com.kh.ttamna.vo.board.BoardVO;

@Repository
public class QuestionDaoImpl implements QuestionDao{

	
	@Autowired
	private SqlSession sqlSession;
	
	//게시글 작성
	@Override
	public int write(QuestionDto questionDto) {
		//게시글번호 미리 조회해서 부여하기
		int questionNo = sqlSession.selectOne("question.seq");
		questionDto.setQuestionNo(questionNo);
		sqlSession.insert("question.write",questionDto);
		
		return questionNo;
	}

	@Override
	public List<QuestionDto> list() {
		return sqlSession.selectList("question.list");
	}

	//상세보기or검색
	@Override
	public List<QuestionDto> detailOrSearch(Map<String, Object> data) {
		Map<String, Object> searchData = new HashMap<>();
		//단일조회용 데이터
		searchData.put("questionNo", data.get("questionNo"));
		//검색용 데이터
		searchData.put("column", data.get("column"));
		searchData.put("keyword", data.get("keyword"));
		
		List<QuestionDto> questionDto = sqlSession.selectList("question.search", searchData);
		return questionDto;
	}

	//더보기기능+검색조회
	@Override
	public List<QuestionDto> listBySearchPage(int startRow, int endRow, String column, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow",startRow);
		map.put("endRow",endRow);
		map.put("column", column);
		System.out.println("column = "+map.get("column"));
		map.put("keyword",keyword);
		
		return sqlSession.selectList("question.listBySearchPage",map);
	}

	//더보기기능+목록조회
	@Override
	public List<QuestionDto> listByPage(int startRow, int endRow) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return sqlSession.selectList("question.listByPage", map);
	}
	//게시글 상세보기
	@Override
	public QuestionDto detail(int questionNo) {
		QuestionDto questionDto = sqlSession.selectOne("question.search",questionNo);
		return questionDto;
	}

	//게시글 삭제
	@Override
	public boolean delete(int questionNo) {
		int result = sqlSession.delete("question.delete",questionNo);
		return result>0;
	}
	//게시글 수정
	@Override
	public boolean edit(QuestionDto questionDto) {
		int result = sqlSession.update("question.edit",questionDto);
		return result>0;
	}

	@Override
	public boolean editType(int questionNo, String questionType) {
		Map<String , Object> param = new HashMap<>();
		param.put("questionNo", questionNo);
		param.put("questionType",questionType);
		int result = sqlSession.update("question.editType",param);
		return result>0;
	}

	@Override
	public List<QuestionDto> questionListPaging(String memberId, int startRow, int endRow) {
		Map<String,Object> param = new HashMap<>();
		param.put("memberId",memberId);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		return sqlSession.selectList("question.questionListPaging", param);
	}

	

	
	

}
