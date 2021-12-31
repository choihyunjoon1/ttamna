package com.kh.ttamna.repository.adopt;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.adopt.AdoptDto;

@Repository
public class AdoptDaoImpl implements AdoptDao {
	
	@Autowired
	private SqlSession sqlSession;

	//게시글 등록기능
	//등록 완료 후에 상세보기로 가려면 게시판 번호를 반환해야 한다
	@Override
	public int write(AdoptDto adoptDto) {
		
		//게시판 번호 먼저 가져오기
		int adoptNo = sqlSession.selectOne("adopt.sequence");
		
		//게시판번호 세팅하기
		adoptDto.setAdoptNo(adoptNo);
		
		//게시글 등록기능
		sqlSession.insert("adopt.write", adoptDto);
		
		return adoptNo;
	}
	
	//입양공고 상세 조회
	//입양공고 전체 목록 조회 기능

}
