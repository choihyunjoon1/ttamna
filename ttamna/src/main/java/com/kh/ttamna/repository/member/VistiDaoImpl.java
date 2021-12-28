package com.kh.ttamna.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.member.VisitDto;

@Repository
public class VistiDaoImpl implements VisitDao{

	@Autowired
	private SqlSession sqlSession;
	
	//시퀀스 생성 메소드
	@Override
	public int sequence() {
		int sequence = sqlSession.selectOne("visit.sequence");
		return sequence;
	}
	
	
	//접속 기록을 저장하는 메소드
	@Override
	public void log(VisitDto visitDto) {
		sqlSession.insert("visit.log", visitDto);
	}

	//저장한 기록에 중복아이디가 있으면 접속시간을 업데이트
	//단, 접속일자가 (현재날짜 - 기록날짜) < 1 보다 작다면 접속시간을 업데이트
	//중복아이디가 아니라면 정보를 등록
	@Override
	public void allInOneLog(VisitDto visitDto) {
		sqlSession.insert("visit.allInOneLog", visitDto);
	}

	
	

}
