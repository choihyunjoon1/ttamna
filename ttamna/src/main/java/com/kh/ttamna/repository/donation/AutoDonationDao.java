package com.kh.ttamna.repository.donation;

import com.kh.ttamna.entity.donation.AutoPayMentDto;

public interface AutoDonationDao {

	void insert(AutoPayMentDto apmDto);//정기결제 등록
}
