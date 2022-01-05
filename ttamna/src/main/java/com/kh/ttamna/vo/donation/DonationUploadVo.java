package com.kh.ttamna.vo.donation;

import java.util.ArrayList;
import java.util.List;

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
	private String donationType;
	
	private List<MultipartFile> attach;
	
	//DonationDto로 바꿔주는 메소드
	public DonationDto convertToDonationDto(int donationNo) {
		DonationDto donationDto = new DonationDto();
		
		donationDto.setDonationNo(donationNo);
		donationDto.setDonationWriter(donationWriter);
		donationDto.setDonationTitle(donationTitle);
		donationDto.setDonationTotalFund(donationTotalFund);
		donationDto.setDonationNowFund(donationNowFund);
		donationDto.setDonationContent(donationContent);
		donationDto.setDonationType(donationType);
		
		return donationDto;
	}
	
//	//DonationImgDto로 바꿔즈는 메소드
//	public DonationImgDto convertToDonationImgDto(int donationNo, int donationImgNo) {
//		DonationImgDto donationImgDto = new DonationImgDto();
//		donationImgDto.setDonationImgNo(donationImgNo);
//		donationImgDto.setDonationNo(donationNo);
//		donationImgDto.setDonationImgUpload(attach.getOriginalFilename());
//		donationImgDto.setDonationImgSize(attach.getSize());
//		donationImgDto.setDonationImgType(attach.getContentType());
//		
//		return donationImgDto;
//	}
	
	//List<DonationImgDto>로 바꿔즈는 메소드
	public List<DonationImgDto> convertToDonationImgDto(int donationNo) {
		
		List<DonationImgDto> donationList = new ArrayList<DonationImgDto>();
		
		for(MultipartFile files : this.attach) {
			DonationImgDto donationImgDto = new DonationImgDto();
			donationImgDto.setDonationNo(donationNo);
			donationImgDto.setDonationImgUpload(files.getOriginalFilename());
			donationImgDto.setDonationImgSize(files.getSize());
			donationImgDto.setDonationImgType(files.getContentType());
			
			donationList.add(donationImgDto);
		}
		
		
		return donationList;
	}
}
