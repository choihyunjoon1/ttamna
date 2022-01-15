package com.kh.ttamna.repository.mybaby;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.donation.DonationDto;
import com.kh.ttamna.entity.mybaby.MybabyDto;
import com.kh.ttamna.vo.mybaby.MybabyDownVO;

@Repository
public class MybabyDaoImpl implements MybabyDao{

	
	@Autowired
	private SqlSession sqlSession;
	
	//게시글 작성
	@Override
	public int write(MybabyDto mybabyDto) {
		//게시글번호 미리 조회해서 부여하기
		int mybabyNo = sqlSession.selectOne("mybaby.seq");
		mybabyDto.setMybabyNo(mybabyNo);
		sqlSession.insert("mybaby.write",mybabyDto);
		
		return mybabyNo;
	}

	@Override
	public List<MybabyDto> list() {
		return sqlSession.selectList("mybaby.list");
	}

	//상세보기or검색
	@Override
	public List<MybabyDto> detailOrSearch(Map<String, Object> data) {
		Map<String, Object> searchData = new HashMap<>();
		//단일조회용 데이터
		searchData.put("mybabyNo", data.get("mybabyNo"));
		//검색용 데이터
		searchData.put("column", data.get("column"));
		searchData.put("keyword", data.get("keyword"));
		
		List<MybabyDto> mybabyDto = sqlSession.selectList("mybaby.search", searchData);
		return mybabyDto;
	}

	//더보기기능+검색조회
	@Override
	public List<MybabyDto> listBySearchPage(int startRow, int endRow, String column, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow",startRow);
		map.put("endRow",endRow);
		map.put("column", column);
		System.out.println("column = "+map.get("column"));
		map.put("keyword",keyword);
		
		return sqlSession.selectList("mybaby.listBySearchPage",map);
	}

	//더보기기능+목록조회
	@Override
	public List<MybabyDto> listByPage(int startRow, int endRow) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return sqlSession.selectList("mybaby.listByPage", map);
	}
	//게시글 상세보기
	@Override
	public MybabyDto detail(int mybabyNo) {
		MybabyDto mybabyDto = sqlSession.selectOne("mybaby.search",mybabyNo);
		return mybabyDto;
	}

	//게시글 삭제
	@Override
	public boolean delete(int mybabyNo) {
		int result = sqlSession.delete("mybaby.delete",mybabyNo);
		return result>0;
	}
	//게시글 수정
	@Override
	public boolean edit(MybabyDto mybabyDto) {
		int result = sqlSession.update("mybaby.edit",mybabyDto);
		return result>0;
	}

	@Override
	public List<MybabyDownVO> listByImg() {
		return sqlSession.selectList("mybaby.listPlusImg");
	}

	@Override
	public List<MybabyDownVO> searchPlusImg(Map<String, Object> param) {
		Map<String, Object> data = new HashMap<>();
		data.put("column",param.get("column"));
		data.put("keyword",param.get("keyword"));
	
		return sqlSession.selectList("mybaby.searchList",data);
	}
	
	@Override//메인페이지에 3개 띄우기
	public List<MybabyDownVO> mainList() {
		return sqlSession.selectList("mybaby.mainBoard");
	}
	
	

}
