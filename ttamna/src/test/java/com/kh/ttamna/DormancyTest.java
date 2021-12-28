package com.kh.ttamna;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.service.member.EmailService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class DormancyTest {
	//스케쥴러 사용으로 오늘(sysdate) - 마지막접속일자  > 335 일 경우 이메일 전송
	//매일 정각에 멤버테이블에서 조회하여 마지막접속일 후 335일이 지났는지 확인
//	@Scheduled(cron="0 0 0 * * *")//매일 자정
	@Autowired
	private SqlSession sqlSession;
	
	
	@Autowired
	private MemberDao memberDao;
	
	@Test
	public void findDormancy() {
		String memberId = "testmember9";
		MemberDto findDto = sqlSession.selectOne("member.get",memberId);
		log.debug("memberDto = {}",findDto);
		
	}
	
	

}
