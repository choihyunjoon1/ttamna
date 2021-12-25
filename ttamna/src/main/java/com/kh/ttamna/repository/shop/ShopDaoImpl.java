package com.kh.ttamna.repository.shop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.shop.ShopDto;

@Repository
public class ShopDaoImpl implements ShopDao{

		@Autowired
		private SqlSession sqlSession;
		
	@Override
	public int insert(ShopDto shopDto) {
		int shopNo = sqlSession.selectOne("shop.seq");
		shopDto.setShopNo(shopNo);
		sqlSession.insert("shop.insert", shopDto);
		
		return shopNo;
	}

	@Override
	public ShopDto get(int shopNo) {
		return sqlSession.selectOne("shop.get", shopNo);
	}

	@Override
	public List<ShopDto> list() {
		return sqlSession.selectList("shop.list");
	}

	@Override
	public List<ShopDto> listByPage(int startRow, int endRow) {
		Map<String, Object> map = new HashMap<>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return sqlSession.selectList("shop.listByPage", map);
	}

	@Override
	public boolean delete(int shopNo) {
		
		return sqlSession.delete("shop.delete", shopNo) > 0;
	}

	@Override
	public boolean update(ShopDto shopDto) {
	
		return sqlSession.update("shop.update", shopDto) > 0;
		
	}

}
