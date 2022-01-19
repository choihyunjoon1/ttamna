package com.kh.ttamna.repository.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.adopt.AdoptDto;
import com.kh.ttamna.entity.notice.NoticeDto;

@Repository
public class NoticeDaoImpl implements NoticeDao{

	@Autowired
	private SqlSession sqlSession;
	

	//게시글 등록
	//게시글번호를 생성해서 넣어주고 게시글 등록 후 번호를 반환해야 한다
	@Override
	public int write(NoticeDto noticeDto) {
		int noticeNo = sqlSession.selectOne("notice.sequence");
		noticeDto.setNoticeNo(noticeNo);
		return sqlSession.insert("notice.write", noticeDto);
	}


	//게시글 상세조회
	@Override
	public NoticeDto detail(int noticeNo) {
		return sqlSession.selectOne("notice.detail", noticeNo);
	}

	//전체목록
	@Override
	public List<NoticeDto> list() {
		return sqlSession.selectList("notice.list");
	}

	//검색 목록
	@Override
	public List<NoticeDto> searchList(String column, String keyword) {
		Map<String, Object> param = new HashMap<>();
		param.put("column", column);
		param.put("keyword", keyword);
		return sqlSession.selectList("notice.searchList", param);
	}
		
	//상세+검색
	@Override
	public List<NoticeDto> detailOrSearch(Map<String, Object> param) {
		Map<String, Object> searchParam = new HashMap<>();
		searchParam.put("noticeNo", param.get("noticeNo"));
		searchParam.put("column", param.get("column"));
		searchParam.put("keyword", param.get("keyword"));
		
		List<NoticeDto> noticeList = sqlSession.selectList("notice.detailOrSearch", searchParam); 
		return noticeList;
	}
	
	//더보기 페이지네이션 전체목록 
	@Override
	public List<NoticeDto> listByPage(int startRow, int endRow) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		return sqlSession.selectList("notice.listByPage", param);
	}

	//더보기 페이지네이션 검색목록
	@Override
	public List<NoticeDto> searchListByPage(int startRow, int endRow, String column, String keyword) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		param.put("column", column);
		param.put("keyword", keyword);
		return sqlSession.selectList("notice.listByPage", param);
	}	
	
	//게시글 수정
	@Override
	public boolean edit(NoticeDto noticeDto) {
		int result = sqlSession.update("notice.edit", noticeDto);
		return result > 0;
	}

	//게시글 삭제
	@Override
	public boolean delete(int noticeNo) {
		int result = sqlSession.delete("notice.delete", noticeNo);
		return result > 0;
	}

	//조회수
	@Override
	public boolean readUp(int noticeNo) {
		int result = sqlSession.update("notice.readUp", noticeNo);
		return result > 0;
	}




}
