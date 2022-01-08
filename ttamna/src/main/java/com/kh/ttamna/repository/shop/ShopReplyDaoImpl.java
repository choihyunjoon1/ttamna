package com.kh.ttamna.repository.shop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Repository;


import com.kh.ttamna.entity.shop.ShopReplyDto;


@Repository
@ComponentScan
public class ShopReplyDaoImpl implements ShopReplyDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(ShopReplyDto shopReplyDto) {
		int shopReplyNo = sqlSession.selectOne("shopReply.seq");
		shopReplyDto.setShopReplyNo(shopReplyNo);
		sqlSession.insert("shopReply.insert", shopReplyDto);
		
		return shopReplyNo;
		
	}

	@Override
	public void delete(int shopReplyNo) {
		sqlSession.delete("shopReply.delete", shopReplyNo);
	}

	@Override
	public List<ShopReplyDto> list() {
		List<ShopReplyDto> list = sqlSession.selectList("shopReply.list");//1번방법
		return list;
		
//		return sqlSession.selectList("shopReply.list");//2번방법
		
	}

	@Override
	public ShopReplyDto get(int shopReplyNo) {
		return sqlSession.selectOne("shopReply.get", shopReplyNo);
	}
	
	@Override//해당 게시판의 댓글만 내용 조회
	public List<ShopReplyDto> list(int shopNo) {
		return sqlSession.selectList("shopReply.listByDetail", shopNo);
	}
	
	@Override//댓글 페이지네이션
	public List<ShopReplyDto> listByPage(int startRow, int endRow, int shopNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("shopNo", shopNo);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sqlSession.selectList("shopReply.listByPage", map);
	}

	@Override
	public List<ShopReplyDto> pagenation(int StartRow, int endRow ,  int shopNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("startRow",StartRow);
		param.put("endRow",endRow);
		param.put("shopNo", shopNo);
		return sqlSession.selectList("shopReply.pagination",param);
	}

	@Override
	public int count(int shopNo) {	
		return sqlSession.selectOne("shopReply.count",shopNo);
	}
}
