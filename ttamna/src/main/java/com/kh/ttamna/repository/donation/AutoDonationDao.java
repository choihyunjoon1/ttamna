package com.kh.ttamna.repository.donation;

import java.util.List;
import java.util.Map;

import com.kh.ttamna.entity.donation.AutoPayMentDto;
import com.kh.ttamna.vo.chart.RegularChartVO;

public interface AutoDonationDao {

	void insert(AutoPayMentDto apmDto);//정기결제 등록
	
	List<AutoPayMentDto> list();//정기결제테이블 목록 불러오기
	
	//정기결제가 진행될 때 마다 payTimes를 +1씩 증가시키는 메소드
	void payTimesUpdate(int autoNo);
	
	List<AutoPayMentDto> listByMember(String memberId);//특정 회원의 정기결제 목록 불러오기
	
	//정기결제 목록+페이지네이션
	List<AutoPayMentDto> listPaging(String memberId,int startRow,int endRow);
	
	//블록 구하기 위해 게시글 개수 구하기
	int count(String memberId);
	
	//정기결제 비활성화 요청 시 테이블에서 삭제하는 메소드
	void autoPayDelete(String sid);
	
	//정기결제 정보 1개를 가져오는 메소드
	AutoPayMentDto get(String sid);

	//정기결제 이번달 일별 기부금액
	List<RegularChartVO> thisMonthDaily();

	//정기결제 이번달 누적 기부금액
	List<RegularChartVO> thisMonth();

	//정기결제 12개월간 월별 기부금액
	List<RegularChartVO> moy();
	
	//정기결제 기간 검색
	List<RegularChartVO> searchDate(Map<String, Object> param);
}
