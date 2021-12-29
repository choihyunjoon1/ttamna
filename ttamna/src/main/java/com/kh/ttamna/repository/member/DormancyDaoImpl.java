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

	@Override
	public DormancyDto get(String memberId) {
		
		DormancyDto dorDto = sqlSession.selectOne("dormancy.searchDor",memberId);
		
		return dorDto;
	}

	@Override
	public DormancyDto getByEmail(String dorEmail) {
		
		DormancyDto dorDto = sqlSession.selectOne("dormancy.getByEmail",dorEmail);
		
		return dorDto;
	}
	//휴면->회원 이동시 데이터 삭제

	@Override
	public void delete(String dorMemberId) {
		sqlSession.delete("dormancy.deleteDor",dorMemberId);
		
	}
	
	
	
	

}
