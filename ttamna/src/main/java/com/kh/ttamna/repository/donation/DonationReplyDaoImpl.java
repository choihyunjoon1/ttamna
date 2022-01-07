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
		donationReplyDto.setDonationReplyNo(donationReplyNo);
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
	
	@Override//해당 게시판의 댓글만 내용 조회
	public List<DonationReplyDto> list(int donationNo) {
		return sqlSession.selectList("donationReply.listByDetail", donationNo);
	}
	
	@Override//댓글 수정
	public void edit3(int replyNo, String replyContent) {
		Map<String, Object> map = new HashMap<>();
		map.put("replyNo", replyNo);
		map.put("replyContent", replyContent);
		
		sqlSession.update("donationReply.edit3", map);
	}
	
	@Override//댓글 페이지네이션
	public List<DonationReplyDto> listByPage(int startRow, int endRow, int donationNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("donationNo", donationNo);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sqlSession.selectList("donationReply.listByPage", map);
	}

	@Override
	public int count(int donationNo) {	
		return sqlSession.selectOne("donationReply.count",donationNo);
	}
}
