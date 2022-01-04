package com.kh.ttamna.repository.adopt;

import java.util.List;
import java.util.Map;

import com.kh.ttamna.entity.adopt.AdoptDto;
import com.kh.ttamna.entity.donation.DonationDto;

public interface AdoptDao {

	//입양공고 등록 기능
	int write(AdoptDto adoptDto);
	
	//입양공고 상세 조회
	AdoptDto detail(int adoptNo);
	
	//입양공고 전체 목록 조회 기능
	List<AdoptDto> list();
	
	//입양공고 검색 목록
	List<AdoptDto> searchList(String column, String keyword);
	
	//입양공고 더보기 페이지네이션 전체목록 
	List<AdoptDto> listByPage(int startRow, int endRow);
	
	//입양공고 더보기 페이지네이션 검색목록
	List<AdoptDto> searchListByPage(int startRow, int endRow, String column, String keyword);
	
	//입양공고 상세 + 검색
	List<AdoptDto> detailOrSearch(Map<String, Object> data);
	
	//수정
	boolean edit(AdoptDto adoptDto);

	//삭제
	boolean delete(int adoptNo);
	
	//조회수
	boolean readUp(int adoptNo);
	
}
