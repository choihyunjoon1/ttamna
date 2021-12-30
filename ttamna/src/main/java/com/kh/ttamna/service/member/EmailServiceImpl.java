package com.kh.ttamna.service.member;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kh.ttamna.entity.member.CertificationDto;
import com.kh.ttamna.repository.member.CertificationDao;
import com.kh.ttamna.util.RandomCertificationUtil;

@Service
public class EmailServiceImpl implements EmailService{

	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private RandomCertificationUtil util;
	
	@Autowired
	private CertificationDao certDao;

	@Override
	public void sendCertification(String to) throws MessagingException, FileNotFoundException, IOException {
		
		//랜덤번호 생성(6자리)
		String randomNumber = util.generator(6);
		
		//메세지 객체 생성
		MimeMessage message = sender.createMimeMessage();
				
		//설정 도우미 생성
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setTo(to); //이메일을 받을 주소
		helper.setSubject("[Tierheim] 동물의 집에서 인증번호를 발송했습니다");
		
		//작성한 HTML을 불러오기. 파일을 읽어서 내용을 설정
		//ClassPathResource 객체를 이용하여 src이후의 경로 부터 작성
		ClassPathResource resource = new ClassPathResource("email/template.html");
		
		StringBuffer buffer = new StringBuffer();
		try(Scanner sc = new Scanner(resource.getFile());){
			while(sc.hasNextLine()) {
				buffer.append(sc.nextLine());
				buffer.append('\n');
			}
		}
		
		//html 템플릿에 랜덤 인증번호를 넣어줌
		String html = buffer.toString();
		html = html.replace("{{number}}", randomNumber);
		helper.setText(html, true);
		
		//전송(message)
		sender.send(message);
		System.out.println("[ 인증 ] 인증번호 이메일 전송 완료");
		
		//전송완료 후에 인증 정보를 DB에 저장시킨다
		CertificationDto certDto = new CertificationDto();
		certDto.setCertEmail(to);
		certDto.setCertSerial(randomNumber);
		certDao.insertOrUpdate(certDto);
		System.out.println("[ 인증 ] 인증정보 저장 완료");
	}

	@Override
	public void sendDormancy(String to,String lastTime) throws FileNotFoundException, IOException, MessagingException {
		//메세지 객체 생성
		MimeMessage message = sender.createMimeMessage();
				
		//설정 도우미 생성
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setTo(to); //이메일을 받을 주소
		helper.setSubject("[Tierheim] 동물의 집에서 휴면계정 전환알림 메일을 발송했습니다.");
		
		//작성한 HTML을 불러오기. 파일을 읽어서 내용을 설정
		//ClassPathResource 객체를 이용하여 src이후의 경로 부터 작성
		ClassPathResource resource = new ClassPathResource("email/dormancyWarning.html");
		
		StringBuffer buffer = new StringBuffer();
		try(Scanner sc = new Scanner(resource.getFile());){
			while(sc.hasNextLine()) {
				buffer.append(sc.nextLine());
				buffer.append('\n');
			}
		}
		
		//html 템플릿에 휴면계정 전환되는 날짜를 입력
		String html = buffer.toString();
		html = html.replace("{{lastTime}}", lastTime);
		helper.setText(html, true);
		
		//전송(message)
		sender.send(message);
				
		
	}

	@Override
	public void processDormancy(String to, String lastTime) throws MessagingException, FileNotFoundException, IOException {
		//메세지 객체 생성
		MimeMessage message = sender.createMimeMessage();
				
		//설정 도우미 생성
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setTo(to); //이메일을 받을 주소
		helper.setSubject("[Tierheim] 동물의 집에서 휴면계정 전환알림 메일을 발송했습니다.");
		
		//작성한 HTML을 불러오기. 파일을 읽어서 내용을 설정
		//ClassPathResource 객체를 이용하여 src이후의 경로 부터 작성
		ClassPathResource resource = new ClassPathResource("email/processDormancy.html");
		
		StringBuffer buffer = new StringBuffer();
		try(Scanner sc = new Scanner(resource.getFile());){
			while(sc.hasNextLine()) {
				buffer.append(sc.nextLine());
				buffer.append('\n');
			}
		}
		
		//html 템플릿에 휴면계정 전환되는 날짜를 입력
		String html = buffer.toString();
		html = html.replace("{{lastTime}}", lastTime);
		helper.setText(html, true);
		
		//전송(message)
		sender.send(message);
		
	}

}
