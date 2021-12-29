package com.kh.ttamna.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.member.DormancyDto;

@Repository
public class DormancyDaoImpl  implements DormancyDao{

	@Autowired
	private SqlSession sqlSession;
	
	//휴면계정 옮길 때 데이터 추가
	@Override
	public void insert(DormancyDto dormancyDto) {
		
		sqlSession.insert("dormancy.change",dormancyDto);
	}
	
	

}
