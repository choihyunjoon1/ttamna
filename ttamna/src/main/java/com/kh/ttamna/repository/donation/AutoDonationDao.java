package com.kh.ttamna.repository.donation;

import java.util.List;

import com.kh.ttamna.entity.donation.AutoPayMentDto;

public interface AutoDonationDao {

	void insert(AutoPayMentDto apmDto);//정기결제 등록
	
	List<AutoPayMentDto> list();//정기결제테이블 목록 불러오기
	
	//정기결제가 진행될 때 마다 payTimes를 +1씩 증가시키는 메소드
	void payTimesUpdate(int autoNo);
}