package com.kh.ttamna.repository.member;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.member.MemberDto;

@Repository
public class MemberDaoImpl  implements MemberDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void join(MemberDto memberDto) {
		sqlSession.insert("member.join",memberDto);
	}

	@Override
	public boolean login(String memberId, String memberPw) {
		Map<String,Object> param= new HashMap<>();
		param.put("memberId",memberId);
		param.put("memberPw",memberPw);
		int result = sqlSession.selectOne("member.login",param);
		return result>0;
	}

}
