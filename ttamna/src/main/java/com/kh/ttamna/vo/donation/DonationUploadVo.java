package com.kh.ttamna.vo.donation;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.donation.DonationDto;
import com.kh.ttamna.entity.donation.DonationImgDto;

import lombok.Data;

@Data
public class DonationUploadVo {

	private int donationNo;
	private String donationWriter;
	private String donationTitle;
	private int donationTotalFund;
	private int donationNowFund;
	private String donationContent;
	
	private MultipartFile attach;
	
	@Autowired//게시판 번호를 가져와야 하므로 불렀음
	
	private SqlSession sqlSession;
	//DonationDto로 바꿔주는 메소드
	public DonationDto convertToDonationDto(int donationNo) {
		DonationDto donationDto = new DonationDto();
		
		donationDto.setDonationNo(donationNo);
		donationDto.setDonationWriter(donationWriter);
		donationDto.setDonationTitle(donationTitle);
		donationDto.setDonationTotalFund(donationTotalFund);
		donationDto.setDonationNowFund(donationNowFund);
		donationDto.setDonationContent(donationContent);
		
		return donationDto;
	}
	
	//DonationImgDto로 바꿔즈는 메소드
	public DonationImgDto convertToDonationImgDto(int donationNo, int donationImgNo) {
		DonationImgDto donationImgDto = new DonationImgDto();
		donationImgDto.setDonationImgNo(donationImgNo);
		donationImgDto.setDonationNo(donationNo);
		donationImgDto.setDonationImgUpload(attach.getOriginalFilename());
		donationImgDto.setDonationImgSize(attach.getSize());
		donationImgDto.setDonationImgType(attach.getContentType());
		
		return donationImgDto;
	}
}
