package com.kh.ttamna.service.donation;

import java.io.IOException;

import com.kh.ttamna.vo.donation.DonationUploadVo;

public interface DonationFileService {

	int insert(DonationUploadVo donationUploadVo) throws IllegalStateException, IOException;//게시판상세로 바로 가기 위해서 int 반환(게시글 번호)
	
	void delete(int donationNo);//실제경로에 있는 파일 삭제
}
