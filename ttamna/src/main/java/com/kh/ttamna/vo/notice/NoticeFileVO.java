package com.kh.ttamna.vo.notice;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.notice.NoticeDto;
import com.kh.ttamna.entity.notice.NoticeImgDto;

import lombok.Data;

@Data
public class NoticeFileVO {

	private int noticeNo; //게시판 번호
	private String noticeWriter; //작성자
	private String noticeTitle; //제목
	private String noticeContent; //내용
	private Date noticeTime; //작성시간
	private int noticeRead; //조회수
    private List<MultipartFile> attach;
	
	//noticeDto로 변환
    public NoticeDto noticeDtoConverter(int noticeNo) {
    	
    	NoticeDto noticeDto = new NoticeDto();
    	noticeDto.setNoticeNo(noticeNo);
    	noticeDto.setNoticeWriter(noticeWriter);
    	noticeDto.setNoticeTitle(noticeTitle);
    	noticeDto.setNoticeContent(noticeContent);
    	noticeDto.setNoticeTime(noticeTime);
    	noticeDto.setNoticeRead(noticeRead);
    	
    	return noticeDto;
    }
    
    //List<noticeImgDto>로 변환
    public List<NoticeImgDto> noticeImgDtoConverter(int noticeNo){
    
    	List<NoticeImgDto> noticeList = new ArrayList<>();
    	for(MultipartFile file : this.attach) {
    		NoticeImgDto noticeImgDto = new NoticeImgDto();
    		noticeImgDto.setNoticeNo(noticeNo);
    		noticeImgDto.setNoticeImgUpload(file.getOriginalFilename());
    		noticeImgDto.setNoticeImgSize(file.getSize());
    		noticeImgDto.setNoticeImgType(file.getContentType());
    		noticeList.add(noticeImgDto);
    	}
    	return noticeList;
    }
    
    
}














