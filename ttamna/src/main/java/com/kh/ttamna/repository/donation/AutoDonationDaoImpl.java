package com.kh.ttamna.repository.donation;

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
}
