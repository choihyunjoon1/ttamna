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

	MybabyImgDto get(int mybabyImgNo);

	byte[] load(int mybabyImgNo) throws IOException;
	
	//게시판번호로 이미지 파일 삭제하기
	boolean deleteSave(int mybabyNo) throws IllegalStateException, IOException;
	//게시판번호로 이미지 디비 삭제
	boolean delete(int mybaby);
	

	//게시판 번호로 이미지 번호 불러오기(1개만)
	int getImg(int mybabyNo);

	
	
}
