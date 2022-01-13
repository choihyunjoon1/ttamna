package com.kh.ttamna.repository.question;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.question.QuestionReplyDto;

@Repository
public class QuestionReplyDaoImpl implements QuestionReplyDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(QuestionReplyDto questionReplyDto) {
		int questionReplyNo = sqlSession.selectOne("questionReply.seq");
		questionReplyDto.setQuestionReplyNo(questionReplyNo);
		sqlSession.insert("questionReply.insert", questionReplyDto);
		//댓글 등록 후 댓글수 증가
		int questionNo = questionReplyDto.getQuestionNo();
		return questionNo;
		
	}

	@Override
	public void delete(int questionReplyNo) {
		QuestionReplyDto findReplyDto = sqlSession.selectOne("questionReply.getByReply",questionReplyNo);
		sqlSession.delete("questionReply.delete", questionReplyNo);
	}

	@Override
	public List<QuestionReplyDto> list() {
		List<QuestionReplyDto> list = sqlSession.selectList("questionReply.list");//1번방법
		return list;
		
//		return sqlSession.selectList("questionReply.list");//2번방법
		
	}

	@Override
	public QuestionReplyDto get(int questionReplyNo) {
		return sqlSession.selectOne("questionReply.get", questionReplyNo);
	}
	
	@Override//해당 게시판의 댓글만 내용 조회
	public List<QuestionReplyDto> list(int questionNo) {
		return sqlSession.selectList("questionReply.listByDetail", questionNo);
	}
	
	@Override//댓글 페이지네이션
	public List<QuestionReplyDto> listByPage(int startRow, int endRow, int questionNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("questionNo", questionNo);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sqlSession.selectList("questionReply.listByPage", map);
	}

	@Override
	public List<QuestionReplyDto> pagenation(int StartRow, int endRow ,  int questionNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("startRow",StartRow);
		param.put("endRow",endRow);
		param.put("questionNo", questionNo);
		return sqlSession.selectList("questionReply.pagination",param);
	}

	@Override
	public int count(int questionNo) {	
		return sqlSession.selectOne("questionReply.count",questionNo);
	}
}

