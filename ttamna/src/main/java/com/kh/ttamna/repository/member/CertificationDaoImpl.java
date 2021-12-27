package com.kh.ttamna.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.member.CertificationDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class CertificationDaoImpl implements CertificationDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PasswordEncoder encoder;
	
	//인증정보 등록
	//get으로 조회하고 등록된적 없다면 insert / 아니라면 update
	@Override
	public void insertOrUpdate(CertificationDto certDto) {
		//인증번호 암호화 저장
		String serial = certDto.getCertSerial();
		//생성된 값을 인코더로 암호화
		String encryptSerial = encoder.encode(serial);
		//암호화한 인증 번호를 certDto에 다시 저장
		certDto.setCertSerial(encryptSerial);
		
		//인증번호 발송이력 조회
		CertificationDto findDto = sqlSession.selectOne("certification.get", certDto.getCertEmail());
		
		
		//조회 결과가 있다면 = 발송된 적이 있는 이메일이라면 update
		if(findDto != null) {
			sqlSession.update("certification.update", certDto);
		}else {//없다면 insert
			sqlSession.insert("certification.insert", certDto);
		}
	}
	
	//인증정보 allInOne insert, update 구문
	@Override
	public void allInOne(CertificationDto certDto) {
		//인증번호 암호화 저장
		String serial = certDto.getCertSerial();
		//생성된 값을 인코더로 암호화
		String encryptSerial = encoder.encode(serial);
		//암호화한 인증 번호를 certDto에 다시 저장
		certDto.setCertSerial(encryptSerial);
		
		sqlSession.insert("certification.allInOne", certDto);
	}

	//인증번호 확인. 시간제한 5분
	@Override
	public boolean checkByCert(CertificationDto certDto) {

		//인증번호 발송이력 조회
		CertificationDto findDto = sqlSession.selectOne("certification.get", certDto.getCertEmail());
		
		//발송이력이 있고 입력한 인증번호와 저장된 인증번호가 같다면 성공 
		boolean isMatch = findDto != null && encoder.matches(certDto.getCertSerial(), findDto.getCertSerial());
		if(isMatch) { //인증 성공하면 데이터 삭제
			sqlSession.delete("certification.delete", certDto.getCertEmail());
			return true;
		}else { //인증 실패
			return false;
		}
	}

	

}
