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
	
	@Override
	public void insert(AutoPayMentDto apmDto) {
		sqlSession.insert("apm.insert", apmDto);
	}
	
	@Override
	public List<AutoPayMentDto> list() {
		return sqlSession.selectList("apm.list");
	}
	
	@Override
	public void payTimesUpdate(int autoNo) {
		sqlSession.update("apm.update", autoNo);
	}
}
