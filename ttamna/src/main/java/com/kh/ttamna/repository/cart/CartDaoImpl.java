package com.kh.ttamna.repository.cart;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.shop.ShopDto;

@Repository
public class CartDaoImpl implements CartDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ShopDto> list() {
		return sqlSession.selectList("cart.list");
	}

}
