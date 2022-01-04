package com.kh.ttamna.service.adopt;

import java.io.IOException;

import com.kh.ttamna.vo.adopt.AdoptFileVO;

public interface AdoptFileService {

	//게시글 + 파일 등록 처리. 등록 후 상세보기로 가기위해 게시판 번호 반환
	int insert(AdoptFileVO adoptFileVO) throws IllegalStateException, IOException;
	
}
