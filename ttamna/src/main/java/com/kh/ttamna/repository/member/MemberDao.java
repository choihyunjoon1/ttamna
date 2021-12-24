package com.kh.ttamna.repository.member;

import com.kh.ttamna.entity.member.MemberDto;

public interface MemberDao {
	void join(MemberDto memberDto);
	//아이디 단일조회
	MemberDto get(String memberId);
	
	MemberDto login(MemberDto memberDto);
	
	//아이디 중복검사
	public int ajaxId(String memberId);
}
