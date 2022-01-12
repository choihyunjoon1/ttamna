package com.kh.ttamna.repository.mybaby;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.mybaby.MybabyImgDto;
import com.kh.ttamna.util.FilePath;

@Repository
public class MybabyImgDaoImpl implements MybabyImgDao{

	@Autowired
	private SqlSession sqlSession;
	
	
	
	@Override
	public void insert(MybabyImgDto mybabyImgDto) {
		sqlSession.insert("mybabyImg.insert",mybabyImgDto);
	}

	@Override
	public void save(MybabyImgDto mybabyImgDto, MultipartFile file) throws IllegalStateException, IOException {
		File target = new File(FilePath.MYBABY_PATH,String.valueOf(mybabyImgDto.getMybabyImgNo()));
		file.transferTo(target);
		
		sqlSession.insert("mybabyImg.insert",mybabyImgDto);
	}

	@Override
	public List<MybabyImgDto> getList(int mybabyNo) {
		return sqlSession.selectList("mybabyImg.getFiles",mybabyNo);
	}

	@Override
	public MybabyImgDto get(int mybabyImgNo) {
		return sqlSession.selectOne("mybabyImg.getFile",mybabyImgNo);
	}

	@Override
	public byte[] load(int mybabyImgNo) throws IOException {
		File target = new File(FilePath.MYBABY_PATH, String.valueOf(mybabyImgNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

	@Override
	public int getImg(int mybabyNo) {
		return sqlSession.selectOne("mybabyImg.getFileOne",mybabyNo);
	}
	@Override
	public boolean delete(int mybabyNo) {
		return sqlSession.delete("mybabyImg.delete",mybabyNo)>0;
	}

	@Override
	public void dropImg(int mybabyImgNo) {
		sqlSession.delete("mybabyImg.dropImg",mybabyImgNo);
		File target = new File(FilePath.MYBABY_PATH,String.valueOf(mybabyImgNo));
		target.delete();
	}
	

}
