package com.kh.ttamna.repository.payment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.payment.PaymentDto;
import com.kh.ttamna.vo.chart.DonationChartVO;
import com.kh.ttamna.vo.chart.ShopChartVO;

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

	//7일간 일별 기부 누적금액 통계를 위한 메소드
	@Override
	public List<DonationChartVO> donationDaily() {
		return sqlSession.selectList("pay.donationDaily");
	}

	//이번달 일별 기부금액
	@Override
	public List<DonationChartVO> thisMonthDaily() {
		return sqlSession.selectList("pay.thisMonthDaily");
	}

	//이번달 누적 기부금액
	@Override
	public List<DonationChartVO> thisMonth() {
		return sqlSession.selectList("pay.thisMonth");
	}

	//최근 6개월간 월별 기부금액
	@Override
	public List<DonationChartVO> monthly() {
		return sqlSession.selectList("pay.amountMonthly");
	}

	//최근 12개월간 월별 기부금액
	@Override
	public List<DonationChartVO> moy() {
		return sqlSession.selectList("pay.amountMoy");
	}

	//기부금액 총 누적액
	@Override
	public long totalAmount() {
		return sqlSession.selectOne("pay.totalAmount");
	}

	//7일간 일별 상품판매 금액 통계를 위한 메소드
	@Override
	public List<ShopChartVO> shopDaily() {
		return sqlSession.selectList("pay.shopDaily");
	}

	//이번달 일별 상품판매 금액
	@Override
	public List<ShopChartVO> shopThisMonthDaily() {
		return sqlSession.selectList("pay.shopThisMonthDaily");
	}

	//이번달 누적 상품판매 금액
	@Override
	public List<ShopChartVO> shopThisMonth() {
		return sqlSession.selectList("pay.shopThisMonth");
	}

	//최근 6개월 월별 누적 상품판매 금액
	@Override
	public List<ShopChartVO> shopMonthly() {
		return sqlSession.selectList("pay.shopAmountMonthly");
	}

	//최근 12개월 월별 누적 상품판매 금액
	@Override
	public List<ShopChartVO> shopMoy() {
		return sqlSession.selectList("pay.shopAmountMoy");
	}

}
