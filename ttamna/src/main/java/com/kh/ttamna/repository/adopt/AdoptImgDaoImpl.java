package com.kh.ttamna.repository.adopt;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.adopt.AdoptImgDto;
import com.kh.ttamna.util.FilePath;

@Repository
public class AdoptImgDaoImpl implements AdoptImgDao {

	@Autowired
	private SqlSession sqlSession;
	
	//입양공고 게시물 이미지 파일 DB저장
	@Override
	public void insert(AdoptImgDto adoptImgDto) {
		sqlSession.insert("adoptImg.save", adoptImgDto);
	}
	
	//입양공고 게시물 이미지 파일 실제 경로 저장
	@Override
	public void save(AdoptImgDto adoptImgDto, MultipartFile attach) throws IllegalStateException, IOException {

		//실제 경로 저장 : FilePath에 상수로 파일 저장경로 설정해 둠
		String path = FilePath.ADOPT_PATH;
		File target = new File(path, String.valueOf(adoptImgDto.getAdoptImgNo()));
		attach.transferTo(target);
		sqlSession.insert("adoptImg.save", adoptImgDto);
		
	}

	//이미지 파일 단일 조회
	@Override
	public AdoptImgDto get(int adoptNo) {
		return sqlSession.selectOne("adoptImg.get", adoptNo);
	}
	
	//이미지 파일 단일 조회
	@Override
	public List<AdoptImgDto> getList(int adoptNo) {
		return sqlSession.selectList("adoptImg.getList", adoptNo);
	}


}
