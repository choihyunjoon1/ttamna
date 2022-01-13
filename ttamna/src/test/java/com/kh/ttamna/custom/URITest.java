package com.kh.ttamna.custom;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class URITest {

	@Test
	public void test() {
		String baseURI = ServletUriComponentsBuilder.fromCurrentContextPath()
				.port(8080)
				.path("/ttamna/donation/kakao")
				.toUriString();
		log.debug("baseURI = {}", baseURI);
		log.debug("success = {}", baseURI + "/success");
		log.debug("cancel = {}", baseURI + "/cancel");
		log.debug("fail = {}", baseURI + "/fail");
	}
	
}

