package com.kh.ttamna.repository.mybaby;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.mybaby.MybabyDto;

@Repository
public class MybabyDaoImpl implements MybabyDao{

	
	@Autowired
	private SqlSession sqlSession;
	
	//게시글 작성
	@Override
	public void write(MybabyDto mybaDto) {
		//게시글번호 미리 조회해서 부여하기
		int boardNo = sqlSession.selectOne("mybaby.seq");
		mybaDto.setMybabyNo(boardNo);
		
		sqlSession.insert("mybaby.write",mybaDto);
	}

	
	

}
