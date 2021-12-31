package com.kh.ttamna.repository.donation;

import java.util.List;
import java.util.Map;

import com.kh.ttamna.entity.donation.AutoPayMentDto;
import com.kh.ttamna.entity.donation.DonationDto;

public interface DonationDao {

	int insert(DonationDto donationDto);//등록
	List<DonationDto> list();//목록
	DonationDto detail(int donationNo);
	List<DonationDto> detailOrSearch(Map<String, Object> data);//상세, 검색
	boolean edit(DonationDto donationDto);//수정
	boolean delete(int donationNo);//삭제
	List<DonationDto> listByPage(int startRow, int endRow);//더보기 페이지네이션
	List<DonationDto> listBySearchPage(int startRow, int endRow, String column, String keyword);//페이지네이션 검색
	boolean funding(int donationNo, long price);
}
