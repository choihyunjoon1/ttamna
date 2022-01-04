package com.kh.ttamna.repository.adopt;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.adopt.AdoptImgDto;

public interface AdoptImgDao {

	//입양공고 게시물 이미지 파일 등록 : 등록후 이미지 파일 번호를 반환해야함
	int save(AdoptImgDto adoptImgDto, MultipartFile attach) throws IllegalStateException, IOException;
	
	//이미지 파일 단일 조회
	AdoptImgDto get(int adoptImgNo);
	
	
	
	
	
	
	
	
}
