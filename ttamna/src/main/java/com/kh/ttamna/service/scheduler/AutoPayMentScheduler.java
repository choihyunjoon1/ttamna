package com.kh.ttamna.service.scheduler;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.ttamna.entity.donation.AutoPayMentDto;
import com.kh.ttamna.entity.donation.DonationDto;
import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.donation.AutoDonationDao;
import com.kh.ttamna.repository.donation.DonationDao;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.service.kakaopay.KakaoPayService;
import com.kh.ttamna.service.member.EmailService;
import com.kh.ttamna.vo.kakaopay.KakaoPayApproveResponseVo;
import com.kh.ttamna.vo.kakaopay.KakaoPayAutoApproveRequestVo;

@Service
public class AutoPayMentScheduler implements KakaoPayAutoPayMentScheDule{

	@Autowired
	private AutoDonationDao autoDao;
	
	@Autowired
	private KakaoPayService kakaoService;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private DonationDao donationDao;
//	@Override
//	@Scheduled(cron = "0 0 0 10 * ?")//매월 10일 정각
//	@Scheduled(cron = "*/30 * * * * *")//테스트용 30초마다
	public void excute() throws URISyntaxException, FileNotFoundException, MessagingException, IOException {
		List<AutoPayMentDto> list = autoDao.list();
		KakaoPayAutoApproveRequestVo requestVo = new KakaoPayAutoApproveRequestVo();
		System.out.println(list.toString());
		for(AutoPayMentDto dto : list) {
			//만약 목표기부금액에 도달했을 경우 정기결제가 계속 이루어지면 안되므로 확인 후
			//초과 시 정기결제를 취소처리 해 준 뒤 이메일로 확인메일을 발송시킨다.
			DonationDto donationDto = donationDao.detail(dto.getDonationNo());
			MemberDto memberDto = memberDao.get(dto.getPartnerUserId());
			
			boolean reach = donationDto.getDonationNowFund() >= donationDto.getDonationTotalFund();
			if(reach) {//목표금액에 도달했을 경우
				
				System.out.println("목표금액에 도달했습니다. 정기결제 취소처리를 진행하고 확인 메일을 발송합니다.");
				kakaoService.autoInactive(dto.getAutoSid());
				emailService.autopaymentInactive(memberDto.getMemberEmail(),
												dto.getPartnerUserId(),
												donationDto.getDonationTitle()
												);
				
			} else {//목표금액에 도달하지 못했을 경우
				
				requestVo.setPartner_user_id(dto.getPartnerUserId());
				requestVo.setSid(dto.getAutoSid());
				requestVo.setTotal_amount(dto.getAutoTotalAmount());
				KakaoPayApproveResponseVo responseVo = kakaoService.autoApprove(requestVo);
				autoDao.payTimesUpdate(dto.getAutoNo());
				donationDao.funding(dto.getDonationNo(), responseVo.getAmount().getTotal());
				System.out.println("정기결제 성공!");
				
				//정기결제 성공 시 신청자의 이메일로 확인 메일을 보낸다.
				//필요한 정보
				//1. 신청자의 이메일
				//2. 신청자의 아이디(닉네임)
				//3. 신청자가 기부한 게시판의 제목
				//4. 신청자가 정기 기부 신청 한 금액
				//5. 신청자가 정기 기부를 한 회차
				
				emailService.autopaymentConfirm(
						memberDto.getMemberEmail(),
						dto.getPartnerUserId(),
						donationDto.getDonationTitle(),
						dto.getAutoTotalAmount(),
						dto.getPayTimes()+1
						);
			}
		}
	}
}
