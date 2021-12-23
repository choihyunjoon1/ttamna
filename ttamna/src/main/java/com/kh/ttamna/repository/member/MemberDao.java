package com.kh.ttamna.repository.member;

import com.kh.ttamna.entity.member.MemberDto;

public interface MemberDao {
	void join(MemberDto memberDto);
	
	boolean login(String memberId, String memberPw);
}
