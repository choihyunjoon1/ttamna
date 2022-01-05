package com.kh.ttamna.vo.mybaby;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.mybaby.MybabyDto;
import com.kh.ttamna.entity.mybaby.MybabyImgDto;

import lombok.Data;

@Data
public class MybabyFileVO {
	private int mybabyNo;
	private String mybabyWriter;
	private String mybabyTitle;
	private String mybabyContent;
	private String mybabyTime;
	private String mybabyType;
	private List<MultipartFile> attach;
	
	//MybabyDto로 바꿔주는 메소드
	public MybabyDto converToMybabyDto(int mybabyNo) {
		MybabyDto mybabyDto = new MybabyDto();
		mybabyDto.setMybabyNo(mybabyNo);
		mybabyDto.setMybabyWriter(mybabyWriter);
		mybabyDto.setMybabyTitle(mybabyTitle);
		mybabyDto.setMybabyContent(mybabyContent);
		mybabyDto.setMybabyTime(mybabyTime);
		
		return mybabyDto;
	}
	//List<MybabImgDto>로 바꿔주는 메소드
	
	public List<MybabyImgDto> convertToMybabyImgDto(int mybabyNo){
		List<MybabyImgDto> list = new ArrayList<MybabyImgDto>();
		
		for(MultipartFile files : this.attach) {
			MybabyImgDto mybabyImgDto = new MybabyImgDto();
			mybabyImgDto.setMybabyNo(mybabyNo);
			mybabyImgDto.setMybabyImgUpload(files.getOriginalFilename());
			mybabyImgDto.setMybabyImgSize(files.getSize());
			mybabyImgDto.setMybabyImgType(files.getContentType());
			
			list.add(mybabyImgDto);
		}
		return list;
	}

}
