package com.kh.ttamna.repository.adopt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.adopt.AdoptDto;
import com.kh.ttamna.vo.adopt.AdoptImgDtoVO;

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

	//입양공고 전체 목록 조회 기능
	@Override
	public List<AdoptDto> list() {
		return sqlSession.selectList("adopt.list");
	}

	//입양공고 상세 조회
	@Override
	public AdoptDto detail(int adoptNo) {
		AdoptDto adoptDto = sqlSession.selectOne("adopt.detail", adoptNo);
		return adoptDto;
	}

	//입양공고 검색 목록
	@Override
	public List<AdoptDto> searchList(String column, String keyword) {
		Map<String, Object> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		return sqlSession.selectList("adopt.searchList", param);
	}

	//입양공고 더보기 페이지네이션 전체목록
	@Override
	public List<AdoptDto> listByPage(int startRow, int endRow) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		return sqlSession.selectList("adopt.listByPage", param);
	}

	//입양공고 더보기 페이지네이션 검색목록
	@Override
	public List<AdoptDto> searchListByPage
	    (int startRow, int endRow, String column, String keyword) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		param.put("column", column);
		param.put("keyword", keyword);
		return sqlSession.selectList("adopt.listByPage", param);
	}
	
	//입양공고 상세 + 검색
	@Override
	public List<AdoptDto> detailOrSearch(Map<String, Object> param) {
		Map<String, Object> searchParam = new HashMap<>();
		searchParam.put("adoptNo", param.get("adoptNo"));
		searchParam.put("column", param.get("column"));
		searchParam.put("keyword", param.get("keyword"));
		
		List<AdoptDto> adoptList = sqlSession.selectList("adopt.detailOrSearch", searchParam); 
		return adoptList;
	}

	//입양공고 수정
	@Override
	public boolean edit(AdoptDto adoptDto) {
		int result =  sqlSession.update("adopt.edit", adoptDto); 
		return result > 0;
	}

	//입양공고 삭제
	@Override
	public boolean delete(int adoptNo) {
		int result = sqlSession.delete("adopt.delete", adoptNo);
		return result > 0;
	}

	//입양공고 조회수
	@Override
	public boolean readUp(int adoptNo) {
		int result = sqlSession.update("adopt.readUp", adoptNo);
		return result > 0;
	}

	//메인페이지에 3개 띄우기
	@Override
	public List<AdoptImgDtoVO> mainList() {
		return sqlSession.selectList("adopt.mainBoard");
	}
	
}
