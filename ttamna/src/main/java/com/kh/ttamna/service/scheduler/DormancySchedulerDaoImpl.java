package com.kh.ttamna.service.scheduler;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.mail.MessagingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.ttamna.entity.member.DormancyDto;
import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.CertificationDao;
import com.kh.ttamna.repository.member.DormancyDao;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.service.member.EmailService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class DormancySchedulerDaoImpl implements DormancySchedulerDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private EmailService service;
	
	@Override
	//매일 정각에 멤버테이블에서 조회하여 마지막접속일 후 335일이 지났는지 확인
//	@Scheduled(cron="0 0 0 * * *")//매일 자정
	@Scheduled(cron = "0 * * * * *")//테스트용 1분 추기
	public void findDormancy() throws FileNotFoundException, MessagingException, IOException {
		log.debug("휴면계정 회원 찾기 실행");
		List<MemberDto> findDormancy = sqlSession.selectList("member.findDormancy");
		
		//있다면 for문으로 돌려서 이메일 전송하기.
		
		if(findDormancy != null) {//335일 지난 회원이 있다면
			
			for(MemberDto memberDto : findDormancy) {
				String certEmail = memberDto.getMemberEmail();
				//마지막 접속일의 1년 후 날짜 구하기
				Calendar cal = Calendar.getInstance();
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Date date = memberDto.getMemberLastLog();
				
				cal.setTime(date);
				cal.add(Calendar.YEAR, 1);
				String lastTime = df.format(cal.getTime());
				
				//이메일 전송하기
				service.sendDormancy(certEmail, lastTime);
			}
		}
	}

	@Override
	//매일 정각에 멤버테이블에서 조회하여 마지막접속일 후 365일이 지났는지 확인
//	@Scheduled(cron="0 0 0 * * *")//매일 자정
	@Scheduled(cron = "0 * * * * *")//테스트용 1분 추기
	public void changeDormancy() throws FileNotFoundException, IOException, MessagingException {
		log.debug("휴면계정 회원 찾기 실행");
		List<MemberDto> findDormancy = sqlSession.selectList("member.processDormancy");
		
		//있다면 for문으로 돌려서 이메일 전송하기.
		
		if(findDormancy != null) {//365일 지난 회원이 있다면
			
			for(MemberDto memberDto : findDormancy) {
				String certEmail = memberDto.getMemberEmail();
				//마지막 접속일의 1년 후 날짜 구하기
				Calendar cal = Calendar.getInstance();
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Date date = memberDto.getMemberLastLog();
				
				cal.setTime(date);
				cal.add(Calendar.YEAR, 1);
				String lastTime = df.format(cal.getTime());
				
				//이메일 전송하기
				service.processDormancy(certEmail, lastTime);
				
				//dormancyDao를 불러와서 휴면계정 데이터 이동 처리하기.
				
//				MemberDto findDto = sqlSession.selectOne("member.get",memberDto.getMemberId());
//				String memberId = findDto.getMemberId();
				DormancyDto dorDto = new DormancyDto();
				dorDto.setDorMemberId(memberDto.getMemberId());
				dorDto.setDorMemberNick(memberDto.getMemberNick());
				dorDto.setDorMemberName(memberDto.getMemberName());
				dorDto.setDorMemberEmail(memberDto.getMemberEmail());
				dorDto.setDorMemberPhone(memberDto.getMemberPhone());
				dorDto.setDorMemberJoin(memberDto.getMemberJoin());
				dorDto.setDorMemberGrade("휴면");
				dorDto.setDorPostcode(memberDto.getPostcode());
				dorDto.setDorAddress(memberDto.getAddress());
				dorDto.setDorDetailAddress(memberDto.getDetailAddress());
				//dorDto에 데이터 입력
				log.debug("dorDto = {}",dorDto);
				sqlSession.insert("dormancy.change",dorDto);
				System.out.println("휴면테이블 입력 완료");
				//기본 멤버테이블에서 데이터 삭제
				sqlSession.delete("member.quit",memberDto.getMemberId());
				System.out.println("멤버테이블 삭제 완료");
				
			}
		}
		
	}

	
	
	
	

}
