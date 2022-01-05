package com.kh.ttamna.service.mybaby;

import java.io.IOException;

import com.kh.ttamna.vo.mybaby.MybabyFileVO;

public interface MybabyFileService {

	int write(MybabyFileVO mybabyFileVO) throws IllegalStateException, IOException;

	void delete(int mybabyNo);//파일삭제

	void update(MybabyFileVO mybabyFileVO) throws IllegalStateException, IOException;
	
	

}
