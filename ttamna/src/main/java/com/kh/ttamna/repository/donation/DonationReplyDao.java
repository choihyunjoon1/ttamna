package com.kh.ttamna.repository.donation;

import java.util.List;

import com.kh.ttamna.entity.donation.DonationReplyDto;

public interface DonationReplyDao {

	public int insert(DonationReplyDto donationReplyDto);//댓글등록
	
	public void delete(int donationReplyNo);//삭제기능
	
	public List<DonationReplyDto> list();//댓글리스트

	public DonationReplyDto get(int donationReplyNo);//댓글 단일조회

	public List<DonationReplyDto> list(int donationNo);//해당 게시판의 댓글 조회

	
	List<DonationReplyDto> listByPage(int startRow, int endRow, int donationNo);//더보기 페이지네이션

	public int count(int donationNo);
}
