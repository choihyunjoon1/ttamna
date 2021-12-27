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
public class CertificationInsertTest {
	//인증정보 등록, 갱신 테스트
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private CertificationDao certDao;

	@Autowired
	private RandomCertificationUtil util;
	
//	@Test
//	public void test() {
//		String serial = util.generator(6);
//		CertificationDto certDto = new CertificationDto();
//		certDto.setCertEmail("testmin88@gmail.com");
//		certDto.setCertSerial(serial);
//		
//		sqlSession.insert("certification.insert", certDto);
//	}
	
	@Test
	public void test() {
		String serial = util.generator(6);
		CertificationDto certDto = new CertificationDto();
		certDto.setCertEmail("testmin88@gmail.com");
		certDto.setCertSerial(serial);
		
		certDao.allInOne(certDto);
	}
	

}
