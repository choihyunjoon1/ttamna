package com.kh.ttamna.repository.adopt;

import com.kh.ttamna.entity.adopt.AdoptDto;

public interface AdoptDao {

	//입양공고 등록 기능
	int write(AdoptDto adoptDto);
	
	//입양공고 상세 조회
	//입양공고 전체 목록 조회 기능
}
