package com.kh.ttamna.vo.adopt;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.adopt.AdoptDto;
import com.kh.ttamna.entity.adopt.AdoptImgDto;

import lombok.Data;

@Data
public class AdoptFileVO {

	private int adoptNo; //게시판 번호
	private String adoptWriter; //작성자
	private String adoptTitle; //제목
	private String adoptContent; //내용
	private Date adoptTime; //작성시간
	private int adoptRead; //조회수
	private Date adoptStart; //입양공고 시작날짜
	private Date adoptEnd; //입양공고 종료날짜
	private String adoptKind; //동물의 품종 혹은 종류
	private String adoptPlace; //구조장소
	private String adoptType;
    private List<MultipartFile> attach;
	
	//AdoptDto로 변환
    public AdoptDto adoptDtoConverter(int adoptNo) {
    	
    	AdoptDto adoptDto = new AdoptDto();
    	adoptDto.setAdoptNo(adoptNo);
    	adoptDto.setAdoptWriter(adoptWriter);
    	adoptDto.setAdoptTitle(adoptTitle);
    	adoptDto.setAdoptContent(adoptContent);
    	adoptDto.setAdoptTime(adoptTime);
    	adoptDto.setAdoptRead(adoptRead);
    	adoptDto.setAdoptStart(adoptStart);
    	adoptDto.setAdoptEnd(adoptEnd);
    	adoptDto.setAdoptKind(adoptKind);
    	adoptDto.setAdoptPlace(adoptPlace);
    	adoptDto.setAdoptType(adoptType);
    	
    	return adoptDto;
    }
    
    //List<AdoptImgDto>로 변환
    public List<AdoptImgDto> adoptImgDtoConverter(int adoptNo){
    
    	List<AdoptImgDto> adoptList = new ArrayList<>();
    	for(MultipartFile file : this.attach) {
    		AdoptImgDto adoptImgDto = new AdoptImgDto();
    		adoptImgDto.setAdoptNo(adoptNo);
    		adoptImgDto.setAdoptImgUpload(file.getOriginalFilename());
    		adoptImgDto.setAdoptImgSize(file.getSize());
    		adoptImgDto.setAdoptImgType(file.getContentType());
    		adoptList.add(adoptImgDto);
    	}
    	return adoptList;
    }
    
    
}














