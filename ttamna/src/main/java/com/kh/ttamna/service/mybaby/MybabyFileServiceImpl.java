package com.kh.ttamna.service.mybaby;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.mybaby.MybabyImgDto;
import com.kh.ttamna.repository.mybaby.MybabyImgDao;
import com.kh.ttamna.vo.mybaby.MybabyFileVO;

@Service
public class MybabyFileServiceImpl implements MybabyFileService{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private MybabyImgDao mybabyImgDao;

	@Override
	public int write(MybabyFileVO mybabyFileVO) throws IllegalStateException, IOException {
		//이미지번호 뽑기
		int mybabyNo = sqlSession.selectOne("mybaby.seq");
		
		//게시글등록
		sqlSession.insert("mybaby.write",mybabyFileVO.converToMybabyDto(mybabyNo));
		
		//List뽑기
		List<MybabyImgDto> list = mybabyFileVO.convertToMybabyImgDto(mybabyNo);
		
		int i=0;
		if(!mybabyFileVO.getAttach().isEmpty()) {//파일이 있을 때
			for(MultipartFile files:mybabyFileVO.getAttach()) {
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
	
	

}
