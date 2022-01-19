package com.kh.ttamna.service.notice;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.notice.NoticeDto;
import com.kh.ttamna.entity.notice.NoticeImgDto;
import com.kh.ttamna.repository.notice.NoticeDao;
import com.kh.ttamna.repository.notice.NoticeImgDao;
import com.kh.ttamna.util.FilePath;
import com.kh.ttamna.vo.notice.NoticeFileVO;

@Service
public class NoticeFileServiceImpl implements NoticeFileService{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private NoticeImgDao noticeImgDao;
	
	//게시글 + 파일 등록 처리. 등록 후 상세보기로 가기위해 게시판 번호 반환
	@Override
	public int insert(NoticeFileVO noticeFileVO) throws IllegalStateException, IOException {
		//게시판 번호 조회
		int noticeNo = sqlSession.selectOne("notice.sequence");
		//noticeDto로 변환
		NoticeDto noticeDto =  noticeFileVO.noticeDtoConverter(noticeNo);
		//게시글 등록 처리
		sqlSession.insert("notice.write", noticeDto);
		
		//파일 등록 처리
		List<NoticeImgDto> noticeList = noticeFileVO.noticeImgDtoConverter(noticeNo);
		int i = 0;
		for(MultipartFile file : noticeFileVO.getAttach()) {
			//등록할 게시물에 파일이 존재한다면 파일 등록 처리
			if(!file.isEmpty()) {
				//파일 번호를 조회해서 noticeImgDto의 파일번호로 세팅한 후 저장 처리
				int noticeImgNo = sqlSession.selectOne("noticeImg.sequence");
				NoticeImgDto noticeImgDto = noticeList.get(i);
				noticeImgDto.setNoticeImgNo(noticeImgNo);
				noticeImgDao.save(noticeImgDto, file);
				i++;
			}
		}
		return noticeNo;
	}

	//파일 + 게시글 수정처리
	@Override
	public void updateWithFile(NoticeFileVO noticeFileVO) throws IllegalStateException, IOException {
		int noticeNo = noticeFileVO.getNoticeNo();
		List<NoticeImgDto> noticeImgList = noticeFileVO.noticeImgDtoConverter(noticeNo);
		//파일 제외한 일반 게시글 정보 수정 : 제목, 내용
		NoticeDto noticeDto = noticeDao.detail(noticeNo);
		noticeDto.setNoticeTitle(noticeFileVO.getNoticeTitle());
		noticeDto.setNoticeContent(noticeFileVO.getNoticeContent());
		noticeDao.edit(noticeDto);
		
		int i = 0;
		for(MultipartFile file : noticeFileVO.getAttach()) {
			if(!file.isEmpty()) {
				NoticeImgDto noticeImgDto = noticeImgList.get(i);
				int noticeImgNo = sqlSession.selectOne("noticeImg.sequence");
				noticeImgDto.setNoticeImgNo(noticeImgNo);
				noticeImgDao.save(noticeImgDto, file);
				i++;
			}else break;
		}
	}

	//수정 처리
	@Override
	public void updateWithFile(NoticeImgDto noticeImgDto, MultipartFile file) throws IllegalStateException, IOException {
		int noticeImgNo = sqlSession.selectOne("noticeImg.sequence");
		noticeImgDto.setNoticeImgNo(noticeImgNo);
		noticeImgDao.save(noticeImgDto, file);
	}

	//게시글 삭제+DB파일삭제+실제 경로에 저장된 이미지 삭제 처리
	@Override
	public void deleteAll(int noticeNo) {
		//파일 실제 경로에서 삭제
		List<Integer> imgNoList = noticeImgDao.getImgNoList(noticeNo);
		for(int noticeImgNo : imgNoList) {
			File target = new File(FilePath.NOTICE_PATH, String.valueOf(noticeImgNo));
			target.delete();
		}
		//DB에서 게시글+이미지 저장내용 삭제
		noticeDao.delete(noticeNo);
	}
	


}
