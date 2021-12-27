package com.kh.ttamna.service.scheduler;

import java.net.URISyntaxException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.ttamna.entity.donation.AutoPayMentDto;
import com.kh.ttamna.repository.donation.AutoDonationDao;
import com.kh.ttamna.service.kakaopay.KakaoPayService;
import com.kh.ttamna.vo.kakaopay.KakaoPayAutoApproveRequestVo;

@Service
public class AutoPayMentScheduler implements KakaoPayAutoPayMentScheDule{

	@Autowired
	private AutoDonationDao autoDao;
	
	@Autowired
	private KakaoPayService kakaoService;
	
//	@Override
//	@Scheduled(cron = "0 0 0 10 * ?")//매월 10일 정각
//	@Scheduled(cron = "*/10 * * * * *")//테스트용 10초마다
	public void excute() throws URISyntaxException {
		List<AutoPayMentDto> list = autoDao.list();
		KakaoPayAutoApproveRequestVo requestVo = new KakaoPayAutoApproveRequestVo();
		System.out.println(list.toString());
		for(AutoPayMentDto dto : list) {
			requestVo.setPartner_user_id(dto.getPartnerUserId());
			requestVo.setSid(dto.getAutoSid());
			requestVo.setTotal_amount(dto.getAutoTotalAmount());
			kakaoService.autoApprove(requestVo);
			autoDao.payTimesUpdate(dto.getAutoNo());
			System.out.println("정기결제 성공!");
		}
	}
}
