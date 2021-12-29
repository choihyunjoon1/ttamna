package com.kh.ttamna.service.member;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.mail.MessagingException;

public interface EmailService {

	//인증번호 전송 메소드
	void sendCertification(String to) throws MessagingException, FileNotFoundException, IOException;
}
