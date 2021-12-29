package com.kh.ttamna.repository.donation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.donation.DonationReplyDto;

@Repository
public class DonationReplyDaoImpl implements DonationReplyDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(DonationReplyDto donationReplyDto) {
		int donationReplyNo = sqlSession.selectOne("donationReply.seq");
		donationReplyDto.setDonationNo(donationReplyNo);
		sqlSession.insert("donationReply.insert", donationReplyDto);
		
		return donationReplyNo;
		
	}

	@Override
	public void delete(int donationReplyNo) {
		sqlSession.delete("donationReply.delete", donationReplyNo);
	}

	@Override
	public void edit(String donationReplyContent, String memberId) {
		Map<String, Object> map = new HashMap<>();
		map.put("content", donationReplyContent);
		map.put("memberId", memberId);
		
		sqlSession.update("donationReply.update", map);
		
	}

	@Override
	public void edit2(DonationReplyDto donationReplyDto) {
		
		
	}

	@Override
	public List<DonationReplyDto> list() {
		List<DonationReplyDto> list = sqlSession.selectList("donationReply.list");//1번방법
		return list;
		
//		return sqlSession.selectList("donationReply.list");//2번방법
		
	}

	@Override
	public DonationReplyDto get(int donationReplyNo) {
		return sqlSession.selectOne("donationReply.get", donationReplyNo);
	}
}
