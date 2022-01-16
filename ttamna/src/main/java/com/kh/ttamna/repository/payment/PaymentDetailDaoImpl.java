package com.kh.ttamna.repository.payment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.payment.PaymentDetailDto;

@Repository
public class PaymentDetailDaoImpl implements PaymentDetailDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(PaymentDetailDto payDetailDto) {
		sqlSession.insert("payDetail.insert", payDetailDto);	
	}

	@Override
	public List<PaymentDetailDto> list(int payNo) {
		return sqlSession.selectList("payDetail.list", payNo);
	}

	@Override
	public PaymentDetailDto get(int payNo, int shopNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("payNo", payNo);
		param.put("shopNo", shopNo);
		return sqlSession.selectOne("payDetail.get", param);
	}

	@Override
	public void cancel(int payNo, int shopNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("payNo", payNo);
		param.put("shopNo", shopNo);
		sqlSession.update("payDetail.cancel", param);
	}

	@Override
	public long getCancelAvailableAmount(int payNo) {
		return sqlSession.selectOne("payDetail.cancelAvailableAmount", payNo);
	}

	@Override
	public void cancelAll(int payNo) {
		sqlSession.update("payDetail.cancelAll", payNo);
	}

	//상품이름검색
	@Override
	public String getName(String keyword) {
		return sqlSession.selectOne("payDetail.getName", keyword);
	}
}
