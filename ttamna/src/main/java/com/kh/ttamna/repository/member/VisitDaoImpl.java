package com.kh.ttamna.repository.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.member.VisitDto;
import com.kh.ttamna.vo.chart.VisitChartVO;

@Repository
public class VisitDaoImpl implements VisitDao{

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

	//오늘 하루의 방문자 수를 계산하는 메소드
	@Override
	public int countByDay() {
		int count = sqlSession.selectOne("visit.countByDay");
		return count;
	}

	//7일간 일별 방문자 수 통계를 위한 메소드
    @Override
	public List<VisitChartVO> countDaily() {
		return sqlSession.selectList("visit.countDaily");
	}

   //이번달 일별 방문자 수 통계를 위한 메소드
	@Override
	public List<VisitChartVO> countThisMonthDaily() {
		return sqlSession.selectList("visit.countThisMonthDaily");
	}

	//이번달 누적 방문자
	@Override
	public List<VisitChartVO> thisMonth() {
		return sqlSession.selectList("visit.countThisMonth");
	}

	//이번달부터 6개월 전까지의 월별 누적 방문자수
	@Override
	public List<VisitChartVO> monthly() {
		return sqlSession.selectList("visit.countMonthly");
	}

	//최근 12개월 간 월별 누적 방문자수
	@Override
	public List<VisitChartVO> moy() {
		return sqlSession.selectList("visit.countMOY");
	}

	
	

}
