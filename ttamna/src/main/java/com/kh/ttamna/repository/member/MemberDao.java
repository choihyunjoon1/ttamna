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
	
	//비밀번호 찾기 인증 성공 후 비밀번호 재설정
	boolean resetPw(String memberId, String resetPw);
	
	
}
