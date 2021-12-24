package com.kh.ttamna;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
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
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Test
	public void loginTest() {
		String inputId = "testmember5";
		String inputPw = "testmember5";
		//입력한 ID로 단일조회 
		MemberDto findDto = sqlSession.selectOne("member.get",inputId);
		String savePw = findDto.getMemberPw();
		log.debug("savepw = {}",savePw);
		boolean samePw = encoder.matches(inputPw, savePw);
		log.debug("samePw = {}",samePw);
		
	}

}
