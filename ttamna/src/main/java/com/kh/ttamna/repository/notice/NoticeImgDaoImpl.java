package com.kh.ttamna.repository.notice;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.notice.NoticeImgDto;
import com.kh.ttamna.util.FilePath;

@Repository
public class NoticeImgDaoImpl implements NoticeImgDao{

	@Autowired
	private SqlSession sqlSession;
	

	//게시물 이미지 파일 DB저장
	@Override
	public void insert(NoticeImgDto noticeImgDto) {
		sqlSession.insert("noticeImg.save", noticeImgDto);
	}
	
	//게시물 이미지 파일 실제 경로 저장
	@Override
	public void save(NoticeImgDto noticeImgDto, MultipartFile attach) throws IllegalStateException, IOException {

		File target = new File(FilePath.NOTICE_PATH, String.valueOf(noticeImgDto.getNoticeImgNo()));
		attach.transferTo(target);
		sqlSession.insert("noticeImg.save", noticeImgDto);
		
	}

	//이미지 파일 단일 조회
	@Override
	public NoticeImgDto get(int noticeNo) {
		return sqlSession.selectOne("noticeImg.get", noticeNo);
	}
	
	//이미지 파일 단일 조회
	@Override
	public List<NoticeImgDto> getList(int noticeNo) {
		return sqlSession.selectList("noticeImg.getList", noticeNo);
	}

	//이미지 다운로드용 단일 조회
	@Override
	public NoticeImgDto getFile(int noticeImgNo) {
		return sqlSession.selectOne("noticeImg.getFile", noticeImgNo);
	}

	//이미지 파일 다운로드 처리
	@Override
	public byte[] load(int noticeImgNo) throws IOException {
		//파일을 실제 경로에서 불어와 바이트 배열로 보낸다
		File target = new File(FilePath.NOTICE_PATH, String.valueOf(noticeImgNo));
		byte[] file = FileUtils.readFileToByteArray(target); 
		return file;
	}

	//게시글 수정페이지에서 이미지 파일만 삭제 처리
	@Override
	public void dropImg(int noticeImgNo) {
		sqlSession.delete("noticeImg.dropImg", noticeImgNo);
		//실제 저장 경로에서도 삭제
		File target = new File(FilePath.NOTICE_PATH, String.valueOf(noticeImgNo));
		target.delete();
	}

	//게시판 번호로 조회한 모든 이미지파일의 번호
	@Override
	public List<Integer> getImgNoList(int noticeNo) {
		return sqlSession.selectList("noticeImg.getImgNoList", noticeNo);
	}
	
}
