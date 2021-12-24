package com.kh.ttamna.repository.donation;

import java.util.List;
import java.util.Map;

import com.kh.ttamna.entity.donation.DonationDto;

public interface DonationDao {

	int insert(DonationDto donationDto);//등록
	List<DonationDto> list();//목록
	DonationDto detail(int donationNo);
	List<DonationDto> detailOrSearch(Map<String, Object> data);//상세, 검색
	boolean edit(int donationNo);//수정
	boolean delete(int donationNo);//삭제
	
}
