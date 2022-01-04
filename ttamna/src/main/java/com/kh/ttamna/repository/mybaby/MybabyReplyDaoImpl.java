package com.kh.ttamna.repository.mybaby;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.mybaby.MybabyReplyDto;

@Repository
public class MybabyReplyDaoImpl implements MybabyReplyDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(MybabyReplyDto mybabyReplyDto) {
		int mybabyReplyNo = sqlSession.selectOne("mybabyReply.seq");
		mybabyReplyDto.setMybabyReplyNo(mybabyReplyNo);
		sqlSession.insert("mybabyReply.insert", mybabyReplyDto);
		
		return mybabyReplyNo;
		
	}

	@Override
	public void delete(int mybabyReplyNo) {
		sqlSession.delete("mybabyReply.delete", mybabyReplyNo);
	}

	@Override
	public void edit(String mybabyReplyContent, String memberId) {
		Map<String, Object> map = new HashMap<>();
		map.put("content", mybabyReplyContent);
		map.put("memberId", memberId);
		
		sqlSession.update("mybabyReply.update", map);
		
	}

	@Override
	public void edit2(MybabyReplyDto mybabyReplyDto) {
		
		
	}

	@Override
	public List<MybabyReplyDto> list() {
		List<MybabyReplyDto> list = sqlSession.selectList("mybabyReply.list");//1번방법
		return list;
		
//		return sqlSession.selectList("mybabyReply.list");//2번방법
		
	}

	@Override
	public MybabyReplyDto get(int mybabyReplyNo) {
		return sqlSession.selectOne("mybabyReply.get", mybabyReplyNo);
	}
	
	@Override//해당 게시판의 댓글만 내용 조회
	public List<MybabyReplyDto> list(int mybabyNo) {
		return sqlSession.selectList("mybabyReply.listByDetail", mybabyNo);
	}
	
	@Override//댓글 수정
	public void edit3(int replyNo, String replyContent) {
		Map<String, Object> map = new HashMap<>();
		map.put("replyNo", replyNo);
		map.put("replyContent", replyContent);
		
		sqlSession.update("mybabyReply.edit3", map);
	}
}
