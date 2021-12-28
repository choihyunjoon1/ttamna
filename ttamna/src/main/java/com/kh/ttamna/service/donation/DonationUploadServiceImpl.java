package com.kh.ttamna.service.donation;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.donation.DonationImgDto;
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
		//현재 게시판에 등록이 될 정보와 파일배열이 들어있다.
		int donationNo = sqlSession.selectOne("donation.seq");
		
		//파일이 있던 없던 게시판 등록 과정을 진행 해 주고
		sqlSession.insert("donation.insert", donationUploadVo.convertToDonationDto(donationNo));
		
		//여기서 파일이 있으면 파일을 등록해준다.
		//[1] DonationImgDtoList를 여기서 뽑는다
		List<DonationImgDto> donationList = donationUploadVo.convertToDonationImgDto(donationNo);
		
		int i = 0;
		
		if(!donationUploadVo.getAttach().isEmpty()){//파일이 있으면 실행
			for(MultipartFile files : donationUploadVo.getAttach()) {
				
				//[2] DonationImgNo를 뽑고
				int donationImgNo = sqlSession.selectOne("donaImg.seq");
				//[3] N번째 donationList를 Dto에 옮긴 뒤
				DonationImgDto donationImgDto = donationList.get(i);
				//[4] 2번에서 뽑은 ImgNo를 저장시키고
				donationImgDto.setDonationImgNo(donationImgNo);
				//[5] 실제이미지를 저장하는 dao를 실행
				donationImgDao.save(donationImgDto, 
						files);
				//[6] 다했으면 i를 증감시킨다.
				i++;
			}
			
		}
		
		return donationNo;
	}
}
