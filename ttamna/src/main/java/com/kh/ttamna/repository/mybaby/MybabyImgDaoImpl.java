package com.kh.ttamna.repository.mybaby;

import java.io.File;
import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.mybaby.MybabyImgDto;

@Repository
public class MybabyImgDaoImpl implements MybabyImgDao{

	@Autowired
	private SqlSession sqlSession;
	
	private File dir = new File("D:/dev/ttamna/mybaby");
	
	@Override
	public void insert(MybabyImgDto mybabyImgDto) {
		sqlSession.insert("mybabyImg.insert",mybabyImgDto);
	}

	@Override
	public void save(MybabyImgDto mybabyImgDto, MultipartFile file) throws IllegalStateException, IOException {
		File target = new File(dir,String.valueOf(mybabyImgDto.getMybabyImgNo()));
		file.transferTo(target);
		
		sqlSession.insert("mybabyImg.insert",mybabyImgDto);
	}
	

}
