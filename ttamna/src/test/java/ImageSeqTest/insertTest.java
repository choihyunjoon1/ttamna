package ImageSeqTest;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ttamna.entity.donation.DonationDto;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class insertTest {

	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		DonationDto donationDto = new DonationDto();
		int donationNo = sqlSession.selectOne("donation.seq");
		donationDto.setDonationNo(donationNo);
		donationDto.setDonationWriter("testuser1");
		donationDto.setDonationTitle("테스트기부게시글3");
		donationDto.setDonationContent("테스트기부게시글3");
		int result = sqlSession.insert("donation.insert", donationDto);
		
		System.out.println("result = " + result);
	}
}
