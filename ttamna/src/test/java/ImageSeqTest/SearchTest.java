package ImageSeqTest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ttamna.entity.donation.DonationDto;
import com.kh.ttamna.repository.donation.DonationDao;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class SearchTest {

	@Autowired
	private SqlSession sqlSession;
//	@Test
	public void test() {
		Map<String, Object> map = new HashMap<>();
		map.put("column", "donation_writer");
		map.put("keyword", "test");
		List<DonationDto> dona = sqlSession.selectList("donation.search", map);
		
		System.out.println(dona.toString());
	}
	
	@Autowired
	private DonationDao donationDao;
	
	@Test
	public void test2() {
		Map<String, Object> data = new HashMap<>();
		data.put("maxPrice", 5000);
		List<DonationDto> result = donationDao.detailOrSearch(data);
		
		System.out.println(result.toString());
	}
}
