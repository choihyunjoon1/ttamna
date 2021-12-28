package com.kh.ttamna.repository.member;

import com.kh.ttamna.entity.member.VisitDto;

public interface VisitDao {

	//시퀀스 생성 메소드
	int sequence();
	
	//로그인 시 접속 기록을 저장하는 메소드
	void log(VisitDto visitDto);
	
	//저장한 기록에 중복아이디가 있으면 접속시간을 업데이트
	//단, 접속일자가 (현재날짜 - 기록날짜) < 1 보다 작다면 접속시간을 업데이트
	//중복아이디가 아니라면 정보를 등록
	void allInOneLog(VisitDto visitDto);
	
}
