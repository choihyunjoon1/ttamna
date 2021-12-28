package com.kh.ttamna.service.scheduler;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.mail.MessagingException;

public interface DormancySchedulerDao {
	//오늘 날짜 - 마지막 접속일자가 335일 넘으면 이메일 전송하는 스케쥴러
	void findDormancy() throws FileNotFoundException, MessagingException, IOException;
	
	//오늘 날짜 - 마지막 접속일자가 365일이 넘으면 휴면계정 처리하는 다오
	void changeDormancy() throws FileNotFoundException, IOException, MessagingException;

}
