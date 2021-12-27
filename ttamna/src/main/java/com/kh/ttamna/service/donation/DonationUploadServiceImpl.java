package com.kh.ttamna.service.donation;

import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ttamna.repository.donation.DonationImgDao;
import com.kh.ttamna.vo.donation.DonationUploadVo;
@Service
public class DonationUploadServiceImpl implements DonationUploadService{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DonationImgDao donationImgDao;
	@Override
	public int insert(DonationUploadVo donationUploadVo) throws IllegalStateException, IOException {
		int donationNo = sqlSession.selectOne("donation.seq");
		
		sqlSession.insert("donation.insert", donationUploadVo.convertToDonationDto(donationNo));
		
		if(!donationUploadVo.getAttach().isEmpty()){//파일이 있으면 실행
			int donationImgNo = sqlSession.selectOne("donaImg.seq");
			donationImgDao.save(donationUploadVo.convertToDonationImgDto(donationNo, donationImgNo),
											donationUploadVo.getAttach());
		}
		
		return donationNo;
	}
}
