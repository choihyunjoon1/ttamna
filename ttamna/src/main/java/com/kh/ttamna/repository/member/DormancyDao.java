package com.kh.ttamna.repository.member;

import com.kh.ttamna.entity.member.DormancyDto;

public interface DormancyDao {
	
	void insert(DormancyDto dormancyDto);
	
	DormancyDto get(String memberId);
	
	DormancyDto getByEmail(String dorEmail,String memberId);

	void delete(String dorMemberId);

	DormancyDto getByEmailOne(String certEmail);
	

}
