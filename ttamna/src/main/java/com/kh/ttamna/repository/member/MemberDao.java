package com.kh.ttamna.repository.member;

import java.util.List;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.vo.board.BoardVO;

public interface MemberDao {
	
	void join(MemberDto memberDto);
	
	//아이디 단일조회
	MemberDto get(String memberId);
	
	//닉네임 단일조회
	MemberDto getByNick(String memberNick);
	
	//이메일 단일조회
	MemberDto getByEmail(String memberEmail);
	
	
	MemberDto login(MemberDto memberDto);
	
	
	//정보 변경(비번,정보)
	boolean changeInfo(MemberDto memberDto);
	boolean changePw(String memberId, String memberPw, String memberNewPw);

	//비밀번호 찾기 인증 성공 후 비밀번호 재설정
	boolean resetPw(String memberId, String resetPw);
	
	//회원탈퇴
	boolean quit(String memberId, String memberPw);
	
	//휴면 -> 멤버 테이블로 데이터 이동
	void changeDor(MemberDto memberDto);
		
	//회원 전체 조회
	List<MemberDto> list();
	
	//회원목록 + 검색목록 + 페이지네이션
	List<MemberDto> listPaging(String column, String keyword, int startRow, int endRow);
	
	//페이징에서 마지막 블록을 구하기 위하여 게시글 개수를 구하는 기능
	int count(String column, String keyword);
	
	//관리자 페이지 - 회원 등급 수정
	void editGrade(String memberId, String memberGrade);

	List<BoardVO> listMyBoard(String memberId);

	//내게시글보기 페이지네이션
	List<BoardVO> boardListPaging(String memberId, int startRow, int endRow);

	int countBoard(String memberId);

	int countQuestion(String memberId);

	
	
	
}
