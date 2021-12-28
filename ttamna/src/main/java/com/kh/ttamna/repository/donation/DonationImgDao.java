package com.kh.ttamna.repository.donation;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.donation.DonationImgDto;

public interface DonationImgDao {

	void insert(DonationImgDto donationImgDto);
	
	void save(DonationImgDto donationImgDto, MultipartFile file) throws IllegalStateException, IOException;
	
	DonationImgDto get(int donationNo);
	
	List<DonationImgDto> getList(int donationNo);
	
	byte[] load(int donationNo) throws IOException;

	DonationImgDto getFile(int donationImgNo);//파일 다운로드에서 쓸 파일 하나 다운받는 메소드
}
