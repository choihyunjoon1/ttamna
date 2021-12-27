package com.kh.ttamna.repository.member;

import com.kh.ttamna.entity.member.MemberDto;

public interface MemberDao {
	void join(MemberDto memberDto);
	//아이디 단일조회
	MemberDto get(String memberId);
	
	//닉네임 단일조회
	MemberDto getByNick(String memberNick);
	
	//이메일 단일조회
	MemberDto getByEmail(String memberEmail);
	
	
	MemberDto login(MemberDto memberDto);
	
	
}
