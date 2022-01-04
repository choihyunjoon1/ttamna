package com.kh.ttamna.service.adopt;

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
		String adoptWriter = adoptFileVO.adoptDtoConverter(adoptNo).getAdoptWriter();
		String adoptTitle = adoptFileVO.adoptDtoConverter(adoptNo).getAdoptTitle();
		System.out.println("adoptFileService 작성자 : " + adoptWriter);
		System.out.println("adoptFileService 제목 : " + adoptTitle);
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

}
