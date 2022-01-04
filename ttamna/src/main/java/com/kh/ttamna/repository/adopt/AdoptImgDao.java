package com.kh.ttamna.repository.adopt;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.adopt.AdoptImgDto;

public interface AdoptImgDao {

	//입양공고 게시물 이미지 파일 DB저장
	void insert(AdoptImgDto adoptImgDto); 
	
	//입양공고 게시물 이미지 파일 실제경로 저장 
	void save(AdoptImgDto adoptImgDto, MultipartFile attach) throws IllegalStateException, IOException;
	
	//이미지 파일 단일 조회
	AdoptImgDto get(int adoptNo);

	//이미지 파일 여러개 조회
	List<AdoptImgDto> getList(int adoptNo);
	
	
	
	
	
	
	
	
}
