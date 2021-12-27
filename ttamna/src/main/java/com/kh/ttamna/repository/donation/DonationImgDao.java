package com.kh.ttamna.repository.donation;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.donation.DonationImgDto;

public interface DonationImgDao {

	void insert(DonationImgDto donationImgDto);
	
	void save(DonationImgDto donationImgDto, MultipartFile file) throws IllegalStateException, IOException;
	
	DonationImgDto get(int donationNo);
	
	byte[] load(int donationNo) throws IOException;
}
