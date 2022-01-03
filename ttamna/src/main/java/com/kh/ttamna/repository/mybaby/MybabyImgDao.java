package com.kh.ttamna.repository.mybaby;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.mybaby.MybabyImgDto;

public interface MybabyImgDao {

	//이미지 등록
	void insert(MybabyImgDto mybabyImgDto);

	void save(MybabyImgDto mybabyImgDto, MultipartFile files) throws IllegalStateException, IOException;

	List<MybabyImgDto> getList(int mybabyNo);
	
	
}
