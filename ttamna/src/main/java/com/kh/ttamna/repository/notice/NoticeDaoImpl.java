package com.kh.ttamna.repository.notice;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
		return null;
	}

}
