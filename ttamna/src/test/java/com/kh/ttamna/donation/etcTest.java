package com.kh.ttamna.donation;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class etcTest {

	@Test
	public void test() {
		Map<String, Object> map = new HashMap<>();
		map.put("column", "잘나오나?");
		
		Map<String, Object> searchMap = new HashMap<>();
		
		searchMap.put("column", map.get("column"));
		
		System.out.println(searchMap.get("column"));
	}
}
