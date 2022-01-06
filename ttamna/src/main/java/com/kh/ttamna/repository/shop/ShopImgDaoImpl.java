package com.kh.ttamna.repository.shop;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.shop.ShopImgDto;

@Repository
public class ShopImgDaoImpl implements ShopImgDao{
	
		@Autowired
		private SqlSession sqlSession;
		
		// 저장 폴더
		private File dir = new File("D:/upload/shop");

		@Override
		public void save(ShopImgDto shopImgDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
			// 시퀀스 번호 불러오기
			int seq = sqlSession.selectOne("shopImg.seq");
			System.out.println("이미지 시퀀스 = "+seq);
			
			// 파일을 시퀀스 번호로 저장
			File target = new File(dir, String.valueOf(seq));
			multipartFile.transferTo(target);
			
			// DB에 파일정보 저장
			shopImgDto.setShopImgNo(seq); // 시퀀스 번호 설정
			shopImgDto.setShopImgSave(String.valueOf(seq)); // 저장될 이름 설정
			sqlSession.insert("shopImg.save", shopImgDto);
		}

		@Override
		public ShopImgDto get(int shopImgNo) {
			return sqlSession.selectOne("shopImg.get", shopImgNo);
		}

		// 이미지 다운로드
		@Override
		public byte[] load(int shopImgNo) throws IOException {
			File target = new File(dir, String.valueOf(shopImgNo));
			byte[] data = FileUtils.readFileToByteArray(target);
			
			return data;
		}

		@Override
		public ShopImgDto getBy(int shopNo) {
			return sqlSession.selectOne("shopImg.getByNo", shopNo);
		}

				
}
