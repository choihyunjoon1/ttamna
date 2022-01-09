package com.kh.ttamna.repository.member;

import java.util.List;

import com.kh.ttamna.entity.member.VisitDto;
import com.kh.ttamna.vo.chart.VisitChartVO;

public interface VisitDao {

	//시퀀스 생성 메소드
	int sequence();
	
	//로그인 시 접속 기록을 저장하는 메소드
	void log(VisitDto visitDto);
	
	//오늘 하루의 방문자 수를 계산하는 메소드
	int countByDay();
	
	//7일간 일별 방문자 수 통계를 위한 메소드
	List<VisitChartVO> countDaily();

	//이번달 일별 방문자 수 통계를 위한 메소드
	List<VisitChartVO> countThisMonthDaily();
	
	//이번달 누적 방문자 수
	List<VisitChartVO> thisMonth();
	
	//이번달부터 6개월 전까지의 월별 누적 방문자수
	List<VisitChartVO> monthly();

	////최근 12개월 간 월별 누적 방문자수
	List<VisitChartVO> moy();
		
	
}
