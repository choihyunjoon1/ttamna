package com.kh.ttamna;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ttamna.entity.member.DormancyDto;
import com.kh.ttamna.entity.member.MemberDto;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class DormancyTest {
	@Autowired
	private SqlSession sqlSession;

	
	@Test
	public void findDormancy() {
		String dorEmail = "ssuramtest1234@gmail.com";
		DormancyDto dorDto = sqlSession.selectOne("dormancy.getByEmail",dorEmail);
		log.debug("dorDto = {}",dorDto);
	

	}
}
