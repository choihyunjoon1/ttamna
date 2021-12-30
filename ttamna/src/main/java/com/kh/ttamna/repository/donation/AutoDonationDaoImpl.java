package com.kh.ttamna.repository.donation;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.donation.AutoPayMentDto;

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
}
