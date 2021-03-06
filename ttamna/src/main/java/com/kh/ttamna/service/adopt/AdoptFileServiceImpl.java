package com.kh.ttamna.service.adopt;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.adopt.AdoptDto;
import com.kh.ttamna.entity.adopt.AdoptImgDto;
import com.kh.ttamna.repository.adopt.AdoptDao;
import com.kh.ttamna.repository.adopt.AdoptImgDao;
import com.kh.ttamna.util.FilePath;
import com.kh.ttamna.vo.adopt.AdoptFileVO;

@Service
public class AdoptFileServiceImpl implements AdoptFileService{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private AdoptDao adoptDao;
	
	@Autowired
	private AdoptImgDao adoptImgDao;
	
	//게시글 + 파일 등록 처리. 등록 후 상세보기로 가기위해 게시판 번호 반환
	@Override
	public int insert(AdoptFileVO adoptFileVO) throws IllegalStateException, IOException {
		//게시판 번호 조회
		int adoptNo = sqlSession.selectOne("adopt.sequence");
		//adoptDto로 변환
		AdoptDto adoptDto =  adoptFileVO.adoptDtoConverter(adoptNo);
		//게시글 등록 처리
		sqlSession.insert("adopt.write", adoptDto);
		
		//파일 등록 처리
		List<AdoptImgDto> adoptList = adoptFileVO.adoptImgDtoConverter(adoptNo);
		int i = 0;
		for(MultipartFile file : adoptFileVO.getAttach()) {
			//등록할 게시물에 파일이 존재한다면 파일 등록 처리
			if(!file.isEmpty()) {
				//파일 번호를 조회해서 adoptImgDto의 파일번호로 세팅한 후 저장 처리
				int adoptImgNo = sqlSession.selectOne("adoptImg.sequence");
				AdoptImgDto adoptImgDto = adoptList.get(i);
				adoptImgDto.setAdoptImgNo(adoptImgNo);
				adoptImgDao.save(adoptImgDto, file);
				i++;
			}
		}
		return adoptNo;
	}

	//파일 + 게시글 수정처리
	@Override
	public void updateWithFile(AdoptFileVO adoptFileVO) throws IllegalStateException, IOException {
		int adoptNo = adoptFileVO.getAdoptNo();
		List<AdoptImgDto> adoptImgList = adoptFileVO.adoptImgDtoConverter(adoptNo);
		//파일 제외한 일반 게시글 정보 수정 : 제목, 내용, 공고종료일, 품종, 구조장소
		AdoptDto adoptDto = adoptDao.detail(adoptNo);
		adoptDto.setAdoptTitle(adoptFileVO.getAdoptTitle());
		adoptDto.setAdoptEnd(adoptFileVO.getAdoptEnd());
		adoptDto.setAdoptKind(adoptFileVO.getAdoptKind());
		adoptDto.setAdoptPlace(adoptFileVO.getAdoptPlace());
		adoptDto.setAdoptContent(adoptFileVO.getAdoptContent());
		adoptDao.edit(adoptDto);
		
		int i = 0;
		for(MultipartFile file : adoptFileVO.getAttach()) {
			if(!file.isEmpty()) {
				AdoptImgDto adoptImgDto = adoptImgList.get(i);
				int adoptImgNo = sqlSession.selectOne("adoptImg.sequence");
				adoptImgDto.setAdoptImgNo(adoptImgNo);
				adoptImgDao.save(adoptImgDto, file);
				i++;
			}else break;
		}
	}

	//수정 처리
	@Override
	public void updateWithFile(AdoptImgDto adoptImgDto, MultipartFile file) throws IllegalStateException, IOException {
		int adoptImgNo = sqlSession.selectOne("adoptImg.sequence");
		adoptImgDto.setAdoptImgNo(adoptImgNo);
		adoptImgDao.save(adoptImgDto, file);
	}

	//게시글 삭제+DB파일삭제+실제 경로에 저장된 이미지 삭제 처리
	@Override
	public void deleteAll(int adoptNo) {
		//파일 실제 경로에서 삭제
		List<Integer> imgNoList = adoptImgDao.getImgNoList(adoptNo);
		for(int adoptImgNo : imgNoList) {
			File target = new File(FilePath.ADOPT_PATH, String.valueOf(adoptImgNo));
			target.delete();
		}
		//DB에서 게시글+이미지 저장내용 삭제
		adoptDao.delete(adoptNo);
	}
	


}
