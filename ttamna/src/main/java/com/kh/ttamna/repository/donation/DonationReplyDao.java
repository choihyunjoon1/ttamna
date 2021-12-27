package com.kh.ttamna.repository.donation;

import java.util.List;

import com.kh.ttamna.entity.donation.DonationReplyDto;

public interface DonationReplyDao {

	public int insert(DonationReplyDto donationReplyDto);//댓글등록
	
	public void delete(int donationReplyNo);//삭제기능
	
	public void edit(String donationReplyContent, String memberId); //댓글 수정 String으로 따로따로 받을 경우
	public void edit2(DonationReplyDto donationReplyDto);//댓글 수정 Dto로 받아오는 경우
	
	public List<DonationReplyDto> list();//댓글리스트
	

	
}
