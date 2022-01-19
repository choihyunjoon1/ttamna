package com.kh.ttamna.repository.notice;

import java.util.List;
import java.util.Map;

import com.kh.ttamna.entity.notice.NoticeDto;

public interface NoticeDao {

	
	//게시글 작성(등록)
	int write(NoticeDto noticeDto);
	
	//게시글 상세조회
	NoticeDto detail(int noticeNo);
	
	//전체 목록 조회 기능
	List<NoticeDto> list();
	
	//검색 목록
	List<NoticeDto> searchList(String column, String keyword);
	
	//더보기 페이지네이션 전체목록 
	List<NoticeDto> listByPage(int startRow, int endRow);
		
	//더보기 페이지네이션 검색목록
	List<NoticeDto> searchListByPage
				(int startRow, int endRow, String column, String keyword);
		
	//상세 + 검색
	List<NoticeDto> detailOrSearch(Map<String, Object> data);
		
	//수정
	boolean edit(NoticeDto noticeDto);

	//삭제
	boolean delete(int noticeNo);
		
	//조회수
	boolean readUp(int noticeNo);
	
	
}
