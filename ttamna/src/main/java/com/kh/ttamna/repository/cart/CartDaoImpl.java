package com.kh.ttamna.repository.cart;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.cart.CartDto;
import com.kh.ttamna.entity.shop.ShopDto;

@Repository
public class CartDaoImpl implements CartDao{

	@Autowired
	private SqlSession sqlSession;
	
	// 장바구니 리스트
	@Override
	public List<ShopDto> list() {
		return sqlSession.selectList("cart.list");
	}
	// 장바구니에 데이터 삽입
	@Override
	public void insert(CartDto cartDto) {
		sqlSession.insert("cart.insert", cartDto);
	}
	@Override
	public boolean add(CartDto cartDto) {
		return sqlSession.update("cart.add", cartDto) > 0;
	}
	// 장바구니 삭제
	@Override
	public boolean delete(int cartNo) {
		return sqlSession.delete("cart.delete", cartNo) > 0;
	}

}
