package com.kh.ttamna;

import static org.junit.Assert.assertTrue;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ttamna.entity.member.CertificationDto;
import com.kh.ttamna.repository.member.CertificationDao;
import com.kh.ttamna.util.RandomCertificationUtil;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class CertificationCheckTest {
	//인증확인 테스트
	
	@Autowired
	private CertificationDao certDao;

	@Test
	public void test() {
		CertificationDto certDto = new CertificationDto();
		certDto.setCertEmail("testmin88@gmail.com");
		certDto.setCertSerial("632121");
		
		assertTrue(certDao.checkByCert(certDto));
	}
}
