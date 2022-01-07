package com.kh.ttamna.repository.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.vo.board.BoardVO;

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
			//로그인 성공시 접속시간(member_last_log) 업데이트 처리
			sqlSession.update("member.lastLog", memberDto.getMemberId());
			System.out.println("[ 로그인 ] 성공.. memberId : " + findDto.getMemberId());
			return findDto;
		}else {//일치 하지 않을 때 = 로그인 실패
			System.out.println("[ 로그인 ] 실패 ");
			return null;
		}
	}
	
	//아이디 단일조회
	@Override
	public MemberDto get(String memberId) {
		MemberDto memberDto = sqlSession.selectOne("member.get",memberId);
		return memberDto;
	}

	//닉네임 단일조회
	@Override
	public MemberDto getByNick(String memberNick) {
		MemberDto memberDto = sqlSession.selectOne("member.getByNick", memberNick);
		System.out.println("[회원 조회] memberNcik : " + memberNick);
		return memberDto;
	}

	//이메일 단일조회
	@Override
	public MemberDto getByEmail(String memberEmail) {
		MemberDto memberDto = sqlSession.selectOne("member.getByEmail", memberEmail);
		System.out.println("[회원 조회] memberEmail : " + memberEmail);
		return memberDto;
	}

	//비밀번호 찾기 인증 성공 후 비밀번호 재설정
	@Override
	public boolean resetPw(String memberId, String resetPw) {
		//비밀번호 암호화 저장
		//입력한 값을 인코더로 암호화
		String encryptPw = encoder.encode(resetPw);
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("memberPw", encryptPw);
		//mapper로 보내 update 처리
		int result = sqlSession.update("member.resetPw", param);
		return result>0;
		
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

	@Override
	public boolean changePw(String memberId, String memberPw, String memberNewPw) {
		//현재 비밀번호와 새로입력한 비밀번호가 다른것과 정규표현식은 프론트에서 검사.
		//여기서는 입력한 현재 비밀번호가 아이디에 있는 비밀번호와 같은 값인지 확인.
		//(1) 입력한 현재 비밀번호 == 저장된 현재 비밀번호
		MemberDto findDto = sqlSession.selectOne("member.get",memberId);
		boolean isMatch = findDto != null && encoder.matches(memberPw, findDto.getMemberPw());
		if(isMatch) {//만약 입력한 현재 비밀번호 == 저장된 현재 비밀번호라면
			//(2) 매퍼로 입력한 새 비밀번호로 변경하기(암호화 설정 후)
			String memberNewPwEncrypt = encoder.encode(memberNewPw);
			Map<String, Object> param = new HashMap<>();
			param.put("memberNewPw",memberNewPwEncrypt);
			param.put("memberId",memberId);
			
			int result = sqlSession.update("member.changePw",param);
			return result>0;
		}else {
			return false;
		}
	}

	@Override
	public boolean quit(String memberId, String memberPw) {
		//회원탈퇴 : 
		//(1) 입력한 아이디 or 세션아이디를 단일조회하여 비밀번호 가져와서 입력한 비밀번호와 일치하는지 검사
		//(2) 둘다 일치 한다면 매퍼로 가서 회원데이터 삭제 진행.
		
		//(1) DB에서 비밀번호 가져오기
		MemberDto memberDto = sqlSession.selectOne("member.get",memberId);
		String findPw = memberDto.getMemberPw();
		//(2) DB의 비밀번호와 입력한 비밀번호 일치 검사
		boolean pwMatch = encoder.matches(memberPw, findPw);
		if(pwMatch) {//일치한다면
			//(3) 탈퇴 진행
			int result = sqlSession.delete("member.quit",memberId);
			return result>0;
		}else {//비밀번호 일치 안할 때
			return false;
		}
	}


	@Override
	public void changeDor(MemberDto memberDto) {
		sqlSession.insert("member.insertDor",memberDto);
		
	}

	//회원 전체 조회
	@Override
	public List<MemberDto> list() {
		List<MemberDto> list = sqlSession.selectList("member.list");
		return list;
	}
	
	//회원목록 + 검색목록 + 페이지네이션
	@Override
	public List<MemberDto> listPaging(String column, String keyword, int startRow, int endRow) {
		Map<String,Object> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		return sqlSession.selectList("member.listPaging", param);
	}
	
	//페이징에서 마지막 블록을 구하기 위하여 게시글 개수를 구하는 기능
	@Override
	public int count(String column, String keyword) {
		Map<String,Object> param = new HashMap<>();
		param.put("column",column);
		param.put("keyword",keyword);
		return sqlSession.selectOne("member.count",param);
	}

	//관리자 페이지 - 회원등급 수정
	@Override
	public void editGrade(String memberId, String memberGrade) {
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("memberGrade", memberGrade);
		sqlSession.update("member.editGrade", param);
	}

	@Override
	public List<BoardVO> listMyBoard(String memberId) {
		return sqlSession.selectList("member.myBoard",memberId);
	}

	@Override
	public List<BoardVO> boardListPaging(String memberId, int startRow, int endRow) {
		Map<String,Object> param = new HashMap<>();
		param.put("memberId",memberId);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		return sqlSession.selectList("member.boardListPaging", param);
	}
	@Override
	public int countBoard(String memberId) {
		return sqlSession.selectOne("member.countBoard",memberId);
	}
	

}
