package com.kh.ttamna.service.scheduler;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URISyntaxException;

import javax.mail.MessagingException;

public interface KakaoPayAutoPayMentScheDule {

	void excute() throws URISyntaxException, FileNotFoundException, MessagingException, IOException;
}
