package com.kh.ttamna.repository.member;

import com.kh.ttamna.entity.member.CertificationDto;

public interface CertificationDao {

	//인증정보가 없다면 insert, 있다면 update
	void insertOrUpdate(CertificationDto certDto);

	//인증정보 allInOne insert, update 구문
	void allInOne(CertificationDto certDto);
	
	//인증 번호 확인(시간제한 5분)
	boolean checkByCert(CertificationDto certDto);
	
	//인증시간 만료 시 삭제
	
}
