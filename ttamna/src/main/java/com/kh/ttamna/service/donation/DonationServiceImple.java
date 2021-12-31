package com.kh.ttamna.service.donation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ttamna.entity.donation.AutoPayMentDto;
import com.kh.ttamna.repository.donation.AutoDonationDao;
import com.kh.ttamna.repository.donation.DonationDao;

@Service
public class DonationServiceImple implements DonationService{
	
	@Autowired
	private AutoDonationDao autoDonationDao;
	
	@Autowired
	private DonationDao donationDao;
	
	@Override//정기기부 해지 시 금액 차감
	public void updatePrice(String sid) {
		AutoPayMentDto autoPayMentDto = autoDonationDao.get(sid);
		
		int donationNo = autoPayMentDto.getDonationNo();
		long price = autoPayMentDto.getAutoTotalAmount();
		donationDao.funding(donationNo, -price);
	}
}
