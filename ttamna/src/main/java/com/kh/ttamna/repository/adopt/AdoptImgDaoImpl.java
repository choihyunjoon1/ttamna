package com.kh.ttamna.repository.adopt;

import java.io.File;
import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.adopt.AdoptImgDto;
import com.kh.ttamna.util.FilePath;

@Repository
public class AdoptImgDaoImpl implements AdoptImgDao {

	@Autowired
	private SqlSession sqlSession;
	
	//입양공고 게시물 이미지 파일 등록 : 저장 후 이미지 파일 번호를 반환해야함
	@Override
	public int save(AdoptImgDto adoptImgDto, MultipartFile attach) throws IllegalStateException, IOException {
		//DB 저장
		int adoptImgNo = sqlSession.selectOne("adoptImg.sequence");
		adoptImgDto.setAdoptImgNo(adoptImgNo);
		sqlSession.insert("adoptImg.save", adoptImgDto);
		
		//실제 경로 저장 : FilePath에 상수로 파일 저장경로 설정해 둠
		String path = FilePath.ADOPT_PATH;
		File target = new File(path, String.valueOf(adoptImgNo));
		attach.transferTo(target);
		
		return adoptImgNo;
	}

	//이미지 파일 단일 조회
	@Override
	public AdoptImgDto get(int adoptImgNo) {
		return sqlSession.selectOne("adoptImg.get", adoptImgNo);
	}


}
