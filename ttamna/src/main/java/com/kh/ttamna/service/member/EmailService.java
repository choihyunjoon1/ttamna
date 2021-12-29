package com.kh.ttamna.service.member;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.mail.MessagingException;

public interface EmailService {

	//인증번호 전송 메소드
	void sendCertification(String to) throws MessagingException, FileNotFoundException, IOException;
	
	//휴면알림 메세지 전송 메소드
	void sendDormancy(String to,String lastTime) throws FileNotFoundException, IOException, MessagingException;
	
	//휴면전환 메시지 전송 메소드
	void processDormancy(String to,String lastTime) throws MessagingException, FileNotFoundException, IOException;
}
