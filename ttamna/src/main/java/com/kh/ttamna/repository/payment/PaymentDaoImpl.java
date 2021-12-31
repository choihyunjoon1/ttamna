package com.kh.ttamna.repository.payment;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.shop.ShopDto;

@Repository
public class PaymentDaoImpl implements PaymentDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int seq() {
		return sqlSession.selectOne("pay.seq");
	}

	@Override
	public void insert(ShopDto paymentDto) {
		sqlSession.insert("pay.insert", paymentDto);	
	}

	@Override
	public List<ShopDto> list() {
		return sqlSession.selectList("pay.list");
	}

	@Override
	public ShopDto get(int shopNo) {
		return sqlSession.selectOne("pay.get", shopNo);
	}

	@Override
	public void refresh(int payNo) {
		sqlSession.update("pay.refresh", payNo);
	}

}