package com.kh.ttamna.repository.adopt;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;
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

		File target = new File(FilePath.ADOPT_PATH, String.valueOf(adoptImgDto.getAdoptImgNo()));
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

	//이미지 다운로드용 단일 조회
	@Override
	public AdoptImgDto getFile(int adoptImgNo) {
		return sqlSession.selectOne("adoptImg.getFile", adoptImgNo);
	}

	//이미지 파일 다운로드 처리
	@Override
	public byte[] load(int adoptImgNo) throws IOException {
		//파일을 실제 경로에서 불어와 바이트 배열로 보낸다
		File target = new File(FilePath.ADOPT_PATH, String.valueOf(adoptImgNo));
		byte[] file = FileUtils.readFileToByteArray(target); 
		return file;
	}

	//게시글 수정페이지에서 이미지 파일만 삭제 처리
	@Override
	public void dropImg(int adoptImgNo) {
		sqlSession.delete("adoptImg.dropImg", adoptImgNo);
		//실제 저장 경로에서도 삭제
		File target = new File(FilePath.ADOPT_PATH, String.valueOf(adoptImgNo));
		target.delete();
	}

	//게시판 번호로 조회한 모든 이미지파일의 번호
	@Override
	public List<Integer> getImgNoList(int adoptNo) {
		return sqlSession.selectList("adoptImg.getImgNoList", adoptNo);
	}
	

	//게시글 삭제시 이미지 파일 삭제 처리	
//	@Override
//	public void deleteImg(int adoptNo) {
//		sqlSession.delete("adoptImg.deleteImg", adoptNo);
//	}


}
