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
		//댓글 등록 후 댓글수 증가
		int mybabyNo = mybabyReplyDto.getMybabyNo();
		sqlSession.update("mybaby.replyUpdate",mybabyNo);
		return mybabyReplyNo;
		
	}

	@Override
	public void delete(int mybabyReplyNo) {
		MybabyReplyDto findReplyDto = sqlSession.selectOne("mybabyReply.getByReply",mybabyReplyNo);
		sqlSession.delete("mybabyReply.delete", mybabyReplyNo);
		
		//댓글삭제 시 mybaby_reply도 -1감소
		System.out.println("findReplyDto = "+findReplyDto.toString());
		int mybabyNo = findReplyDto.getMybabyNo();
		System.out.println("mybabyNo = "+mybabyNo);
		sqlSession.update("mybaby.replyDelete",mybabyNo);
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
	
	@Override//댓글 페이지네이션
	public List<MybabyReplyDto> listByPage(int startRow, int endRow, int mybabyNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("mybabyNo", mybabyNo);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sqlSession.selectList("mybabyReply.listByPage", map);
	}

	@Override
	public List<MybabyReplyDto> pagenation(int StartRow, int endRow ,  int mybabyNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("startRow",StartRow);
		param.put("endRow",endRow);
		param.put("mybabyNo", mybabyNo);
		return sqlSession.selectList("mybabyReply.pagination",param);
	}

	@Override
	public int count(int mybabyNo) {	
		return sqlSession.selectOne("mybabyReply.count",mybabyNo);
	}
}

