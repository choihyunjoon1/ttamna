package com.kh.ttamna;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.MemberDao;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class Test01 {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private MemberDao memberDao;
	
	@Test
	public void joinTest() {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberId("testmember1");
		memberDto.setMemberPw("testmember1");
		memberDto.setMemberNick("테스터1");
		memberDto.setMemberName("테스트");
		memberDto.setMemberPhone("010-2222-2222");
		memberDto.setMemberEmail("testmember@kh.com");
		
		log.debug("memberDto = {}",memberDto);
		
	}

}
