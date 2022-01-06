package com.kh.ttamna.repository.payment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.payment.PaymentDto;

@Repository
public class PaymentDaoImpl implements PaymentDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int seq() {
		return sqlSession.selectOne("pay.seq");
	}

	@Override
	public void insert(PaymentDto paymentDto) {
		sqlSession.insert("pay.insert", paymentDto);	
	}

	@Override
	public List<PaymentDto> list() {
		return sqlSession.selectList("pay.list");
	}

	@Override
	public PaymentDto get(int payNo) {
		return sqlSession.selectOne("pay.get", payNo);
	}

	@Override
	public void refresh(int payNo) {
		sqlSession.update("pay.refresh", payNo);
	}

	@Override
	public void insertDonation(PaymentDto paymentDto) {
		sqlSession.insert("pay.insertDonation", paymentDto);		
	}

	@Override
	public void cancelDonation(int payNo) {
		sqlSession.update("pay.cancelDonation", payNo);
		
	}

	@Override
	public int count(String memberId) {
		return sqlSession.selectOne("pay.count",memberId);
	}

	@Override
	public List<PaymentDto> listPaging(String memberId, int startRow, int endRow) {
		Map<String,Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("startRow",startRow);
		param.put("endRow",endRow);
		
		return sqlSession.selectList("pay.listPaging",param);
	}

}
