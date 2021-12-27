package com.kh.ttamna.repository.donation;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.donation.DonationImgDto;

@Repository
public class DonationImgDaoImpl implements DonationImgDao{

	@Autowired
	private SqlSession sqlSession;
	
	//저장용 폴더 위치 지정
	private File directory = new File("D:/dev/ttamna/donation");
	@Override
	public void insert(DonationImgDto donationImgDto) {
		sqlSession.insert("donaImg.insert", donationImgDto);
	}
	
	@Override//파일을 실제 경로에 저장
	public void save(DonationImgDto donationImgDto, MultipartFile file) throws IllegalStateException, IOException {
		File target = new File(directory, String.valueOf(donationImgDto.getDonationImgNo()));
		file.transferTo(target);
		
		sqlSession.insert("donaImg.insert", donationImgDto);
	}
	
	@Override//파일 한개 가져오기
	public DonationImgDto get(int donationNo) {
		return sqlSession.selectOne("donaImg.getFile", donationNo);
	}
	
	@Override
	public byte[] load(int donaImgNo) throws IOException {
		File target = new File(directory, String.valueOf(donaImgNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}
}
