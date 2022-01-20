package com.kh.ttamna.repository.mybaby;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.mybaby.MybabyLikeDto;

@Repository
public class MybabyLikeDaoImpl implements MybabyLikeDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(int mybabyNo, String memberId) {
		Map<String, Object> param = new HashMap<>();
		param.put("mybabyNo", mybabyNo);
		param.put("memberId", memberId);
		sqlSession.insert("mybabyLike.likeInsert",param);
		
	}

	@Override
	public void delete(int mybabyNo, String memberId) {
		Map<String,Object> param=new HashMap<>();
		param.put("mybabyNo",mybabyNo);
		param.put("memberId",memberId);
		sqlSession.delete("mybabyLike.likeDelete",param);
		
		
	}

	@Override
	public MybabyLikeDto get(int mybabyNo,String memberId) {
		Map<String,Object> param = new HashMap<>();
		param.put("mybabyNo",mybabyNo);
		param.put("memberId",memberId);
		return sqlSession.selectOne("mybabyLike.likeFind",param);
	}

	
}
