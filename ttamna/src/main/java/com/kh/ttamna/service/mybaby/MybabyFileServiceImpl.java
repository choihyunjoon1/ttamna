package com.kh.ttamna.service.mybaby;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.mybaby.MybabyDto;
import com.kh.ttamna.entity.mybaby.MybabyImgDto;
import com.kh.ttamna.repository.mybaby.MybabyDao;
import com.kh.ttamna.repository.mybaby.MybabyImgDao;
import com.kh.ttamna.vo.mybaby.MybabyFileVO;

@Service
public class MybabyFileServiceImpl implements MybabyFileService{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private MybabyDao mybabyDao;
	
	@Autowired
	private MybabyImgDao mybabyImgDao;
	
	private File dir = new File("D:/dev/ttamna/mybaby");

	@Override
	public int write(MybabyFileVO mybabyFileVO) throws IllegalStateException, IOException {
		//이미지번호 뽑기
		int mybabyNo = sqlSession.selectOne("mybaby.seq");
		
		//게시글등록
		sqlSession.insert("mybaby.write",mybabyFileVO.converToMybabyDto(mybabyNo));
		
		//List뽑기
		List<MybabyImgDto> list = mybabyFileVO.convertToMybabyImgDto(mybabyNo);
		
		int i=0;
		for(MultipartFile files:mybabyFileVO.getAttach()) {
			if(!files.isEmpty()) {//파일이 있을 때
				//이미지 번호 뽑기
				int mybabyImgNo = sqlSession.selectOne("mybabyImg.seq");
				//i번째 mybabyList를 Dto에 옮기기
				MybabyImgDto mybabyImgDto = list.get(i);
				mybabyImgDto.setMybabyImgNo(mybabyImgNo);
				//이미지 저장
				mybabyImgDao.save(mybabyImgDto,files);
				i++;
			}
		}
		return mybabyNo;
	}
	//삭제
	@Override
	public void delete(int mybabyNo) {
		List<MybabyImgDto> list = mybabyImgDao.getList(mybabyNo);
		
		for(MybabyImgDto dto : list) {
			File target = new File(dir,String.valueOf(dto.getMybabyImgNo()));
			target.delete();
		}
		sqlSession.delete("mybabyImg.delete",mybabyNo);
		
	}
	@Override
	public void update(MybabyFileVO mybabyFileVO) throws IllegalStateException, IOException {
		List<MybabyImgDto> list = mybabyFileVO.convertToMybabyImgDto(mybabyFileVO.getMybabyNo());
		
		MybabyDto mybabyDto = new MybabyDto();
		mybabyDto.setMybabyNo(mybabyFileVO.getMybabyNo());
		mybabyDto.setMybabyTitle(mybabyFileVO.getMybabyTitle());
		mybabyDto.setMybabyContent(mybabyFileVO.getMybabyContent());
		mybabyDto.setMybabyWriter(mybabyFileVO.getMybabyWriter());
		mybabyDao.edit(mybabyDto);
		
		//파일이 추가되엇을 때
		int i=0;
		for(MultipartFile files : mybabyFileVO.getAttach()) {
			if(!files.isEmpty()) {
				//파일 먼저 삭제하기
				List<MybabyImgDto> fileList = mybabyImgDao.getList(mybabyDto.getMybabyNo());
				
				for(MybabyImgDto dto : fileList) {
					File target = new File(dir,String.valueOf(dto.getMybabyImgNo()));
					target.delete();
				}
				//디비에서도 삭제
				sqlSession.delete("mybabyImg.delete",mybabyDto.getMybabyNo());
				
			}
		}
		//삭제 후 추가
		for(MultipartFile newFiles : mybabyFileVO.getAttach()) {
			int mybabyImgNo = sqlSession.selectOne("mybabyImg.seq");
			MybabyImgDto mybabyImgDto = list.get(i);
			mybabyImgDto.setMybabyImgNo(mybabyImgNo);
			mybabyImgDao.save(mybabyImgDto, newFiles);
			System.out.println("파일추가됨"+i);
			i++;
		}
		
	}
	
	
	

}
