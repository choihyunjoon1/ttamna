package com.kh.ttamna.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.member.MemberDto;

@Repository
public class MemberDaoImpl  implements MemberDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PasswordEncoder encoder;

	/*//암호화 전 회원가입
	@Override
	public void join(MemberDto memberDto) {
		sqlSession.insert("member.join",memberDto);
	}
	//암호화 전 로그인
	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto findDto = sqlSession.selectOne("member.get",memberDto.getMemberId());
		
		if(findDto != null && memberDto.getMemberPw().equals(findDto.getMemberPw())) {
			return findDto;
		}else {
			return null;
		}
	}*/
	//암호화 후 회원가입& 로그인
	@Override
	public void join(MemberDto memberDto) {
		//Dto.Pw를 변수에 저장
		String orPw = memberDto.getMemberPw();
		//입력한 값을 인코더로 암호화
		String encryptPw = encoder.encode(orPw);
		//암호화된 pw를 dto에 저장
		memberDto.setMemberPw(encryptPw);
		//mapper로 보내 insert조치
		sqlSession.insert("member.join",memberDto);
	}

	@Override
	public MemberDto login(MemberDto memberDto) {
		//ID로 단일조회하여 PW불러옴
		MemberDto findDto = sqlSession.selectOne("member.get",memberDto.getMemberId());
		//불러온 PW와 입력한 PW가 맞는지 검사. 단, 불러온PW에는 암호화이므로 encoder.matches를 사용
		boolean isMatch = findDto != null && encoder.matches(memberDto.getMemberPw(),findDto.getMemberPw());
		if(isMatch) {//저장된 Pw와 입력한Pw가 일치할 때 = 로그인 성공
			return findDto;
		}else {//일치 하지 않을 때 = 로그인 실패
			return null;
		}
	}

	@Override
	public MemberDto get(String memberId) {
		MemberDto memberDto = sqlSession.selectOne("member.get",memberId);
		return memberDto;
	}
	
	//아이디 중복 검사
	@Override
	public int ajaxId(String memberId) {
		int result = sqlSession.selectOne("member.ajaxId", memberId);
		return result;
	}
	//정보수정
	@Override
	public boolean changeInfo(MemberDto memberDto) {
		//비밀번호 입력이 올바른경우 변경처리
		MemberDto findDto = sqlSession.selectOne("member.get",memberDto.getMemberId());
		boolean isMatch = findDto!=null && encoder.matches(memberDto.getMemberPw(), findDto.getMemberPw());
		if(isMatch) {//입력한 비번과 아이디에 저장된 비번이 같은 경우 업데이트
			int result = sqlSession.update("member.changeInfo",memberDto);
			return result>0;
		}else {
			return false;
		}
	}
	

}
