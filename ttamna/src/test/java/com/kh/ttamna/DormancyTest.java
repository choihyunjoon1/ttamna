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
		//ID로 단일조회하여 
		String memberId = "testmember5";
		
		MemberDto findDto = sqlSession.selectOne("member.get",memberId);
		log.debug("findDto = {}",findDto);
		if(findDto != null) {//멤버 테이블에서 찾았을 때 로그인 진행
			log.debug("로그인진행");
			
		}else {
			DormancyDto findDorDto = sqlSession.selectOne("dormancy.searchDor",memberId);
			log.debug("여기서 찾음!");
			log.debug("findDorDto = {}",findDorDto);
		}


	
	

	}
}
