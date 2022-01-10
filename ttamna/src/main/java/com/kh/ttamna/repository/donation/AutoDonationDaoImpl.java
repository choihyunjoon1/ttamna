package com.kh.ttamna.repository.donation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.donation.AutoPayMentDto;
import com.kh.ttamna.vo.chart.RegularChartVO;

@Repository
public class AutoDonationDaoImpl implements AutoDonationDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override//정기결제정보 등록
	public void insert(AutoPayMentDto apmDto) {
		sqlSession.insert("apm.insert", apmDto);
	}
	
	@Override//정기결제 목록 모두 불러오기
	public List<AutoPayMentDto> list() {
		return sqlSession.selectList("apm.list");
	}
	
	@Override//정기결제가 진행될 때 마다 payTimes를 1씩 증가
	public void payTimesUpdate(int autoNo) {
		sqlSession.update("apm.update", autoNo);
	}
	
	@Override//특정 회원의 정기결제 목록 불러오기
	public List<AutoPayMentDto> listByMember(String memberId) {
		return sqlSession.selectList("apm.listByMember", memberId);
	}

	@Override
	public List<AutoPayMentDto> listPaging(String memberId, int startRow, int endRow) {
		Map<String,Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("startRow",startRow);
		param.put("endRow",endRow);
		
		return sqlSession.selectList("apm.listPaging",param);
	}

	@Override
	public int count(String memberId) {
		return sqlSession.selectOne("apm.count",memberId);
	}
	
	@Override//정기기부 해지
	public void autoPayDelete(String sid) {
		sqlSession.delete("apm.autoPayDelete", sid);
	}
	
	@Override//sid로 정기결제 1개 정보를 가져오는 메소드
	public AutoPayMentDto get(String sid) {
		return sqlSession.selectOne("apm.get", sid);
	}

	//정기결제 이번달 일별 기부금액
	@Override
	public List<RegularChartVO> thisMonthDaily() {
		return sqlSession.selectList("apm.thisMonthDaily");
	}

	//정기결제 이번달 누적 기부금액
	@Override
	public List<RegularChartVO> thisMonth() {
		return sqlSession.selectList("apm.thisMonth");
	}

	//정기결제 12개월간 월별 기부금액
	@Override
	public List<RegularChartVO> moy() {
		return sqlSession.selectList("apm.moy");
	}

	//정기결제 기간 검색
	@Override
	public List<RegularChartVO> searchDate(Map<String, Object> param) {
		return sqlSession.selectList("apm.searchDate", param);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
