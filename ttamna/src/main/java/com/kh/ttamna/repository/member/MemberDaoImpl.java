package com.kh.ttamna.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.member.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Repository
public class MemberDaoImpl  implements MemberDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void join(MemberDto memberDto) {
		sqlSession.insert("member.join",memberDto);
	}

	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto findDto = sqlSession.selectOne("member.get",memberDto.getMemberId());
		
		if(findDto != null && memberDto.getMemberPw().equals(findDto.getMemberPw())) {
			return findDto;
		}else {
			return null;
		}
	}

}
