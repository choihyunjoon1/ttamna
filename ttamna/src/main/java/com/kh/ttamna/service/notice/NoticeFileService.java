package com.kh.ttamna.service.notice;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.notice.NoticeImgDto;
import com.kh.ttamna.vo.notice.NoticeFileVO;


public interface NoticeFileService {

	//게시글 + 파일 등록 처리. 등록 후 상세보기로 가기위해 게시판 번호 반환
	int insert(NoticeFileVO noticeFileVO) throws IllegalStateException, IOException;
	
	//파일 + 게시글 수정 처리
	void updateWithFile(NoticeFileVO noticeFileVO) throws IllegalStateException, IOException;
	
	//게시글 수정 처리
	void updateWithFile(NoticeImgDto noticeImgDto, MultipartFile file) throws IllegalStateException, IOException;

	//게시글 삭제+DB파일삭제+실제 경로에 저장된 이미지 삭제 처리
	void deleteAll(int noticeNo);

	
}
