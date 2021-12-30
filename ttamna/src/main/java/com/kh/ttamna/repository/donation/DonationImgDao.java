package com.kh.ttamna.repository.donation;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.donation.DonationImgDto;

public interface DonationImgDao {

	void insert(DonationImgDto donationImgDto);//이미지등록
	
	void save(DonationImgDto donationImgDto, MultipartFile file) throws IllegalStateException, IOException;//실제경로에 이미지저장
	
	DonationImgDto get(int donationNo);//이미지 정보 한개 가져오기
	
	List<DonationImgDto> getList(int donationNo);//이미지 정보 여러개 가져오기
	
	byte[] load(int donationNo) throws IOException;//실제 경로에 있는 파일 정보 받아오기

	DonationImgDto getFile(int donationImgNo);//파일 다운로드에서 쓸 파일 하나 다운받는 메소드
	
	void fileOneDelete(int donationImgNo);//파일 한개 삭제
}
