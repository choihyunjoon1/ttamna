package com.kh.ttamna.repository.notice;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.notice.NoticeImgDto;

public interface NoticeImgDao {

	//입양공고 게시물 이미지 파일 DB저장
	void insert(NoticeImgDto noticeImgDto); 
		
	//입양공고 게시물 이미지 파일 실제경로 저장 
	void save(NoticeImgDto noticeImgDto, MultipartFile attach) throws IllegalStateException, IOException;
		
	//이미지 파일 정보 단일 조회
	NoticeImgDto get(int noticeNo);
		
	//이미지 파일 여러개 조회
	List<NoticeImgDto> getList(int noticeNo);

	//이미지 파일 다운로드 단일 조회
	NoticeImgDto getFile(int noticeImgNo);
		
	//이미지 파일 다운로드 처리
	byte[] load(int noticeImgNo) throws IOException;
		
	//게시글 수정페이지에서 이미지 파일만 삭제 처리
	void dropImg(int noticeImgNo);

	//게시판 번호로 조회한 모든 이미지파일의 번호
	List<Integer> getImgNoList(int noticeNo);
}
