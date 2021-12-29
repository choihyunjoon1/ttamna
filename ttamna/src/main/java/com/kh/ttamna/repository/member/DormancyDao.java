package com.kh.ttamna.repository.member;

import com.kh.ttamna.entity.member.DormancyDto;

public interface DormancyDao {
	
	void insert(DormancyDto dormancyDto);
	
	DormancyDto get(String memberId);
	

}
