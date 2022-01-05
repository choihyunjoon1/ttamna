package com.kh.ttamna.repository.mybaby;

import java.util.List;
import java.util.Map;

import com.kh.ttamna.entity.mybaby.MybabyDto;
import com.kh.ttamna.vo.mybaby.MybabyDownVO;

public interface MybabyDao {
	//게시글 등록
	int write(MybabyDto mybaDto);
	//조회
	List<MybabyDto> list();//목록
	List<MybabyDownVO> listByImg();
	List<MybabyDto> detailOrSearch(Map<String, Object> data);//상세, 검색
	List<MybabyDto> listBySearchPage(int startRow, int endRow, String column, String keyword);
	List<MybabyDto> listByPage(int startRow, int endRow);
	MybabyDto detail(int mybabyNo);
	boolean delete(int mybabyNo);
	boolean edit(MybabyDto mybabyDto);
}
