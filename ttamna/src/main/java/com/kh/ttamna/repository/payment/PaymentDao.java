package com.kh.ttamna.repository.payment;

import java.util.List;
import java.util.Map;

import com.kh.ttamna.entity.payment.PaymentDto;
import com.kh.ttamna.vo.chart.DonationChartVO;
import com.kh.ttamna.vo.chart.SearchChartVO;
import com.kh.ttamna.vo.chart.ShopChartVO;

public interface PaymentDao {
	int seq();
	
	void insert(PaymentDto paymentDto);
	
	void insertDonation(PaymentDto paymentDto);
	
	List<PaymentDto> list();
	
	PaymentDto get(int payNo);
	
	void refresh(int payNo);

	void cancelDonation(int payNo);

	int count(String memberId);

	List<PaymentDto> listPaging(String memberId, int startRow, int endRow);
	
	//7일간 일별 기부 누적금액 통계를 위한 메소드
	List<DonationChartVO> donationDaily();
	
	//이번달 일별 기부금액
	List<DonationChartVO> thisMonthDaily();

	//이번달 누적 기부금액
	List<DonationChartVO> thisMonth();
	
	//최근 6개월 월별 누적 기부금액
	List<DonationChartVO> monthly();
	
	//최근 12개월 월별 누적 기부금액
	List<DonationChartVO> moy();

	//기부금액 총 누적액
	long totalAmount();

	//7일간 일별 상품판매 금액 통계를 위한 메소드
	List<ShopChartVO> shopDaily();

	//이번달 일별 상품판매 금액
	List<ShopChartVO> shopThisMonthDaily();

	//이번달 누적 상품판매 금액
	List<ShopChartVO> shopThisMonth();

	//최근 6개월 월별 누적 상품판매 금액
	List<ShopChartVO> shopMonthly();

	//최근 12개월 월별 누적 상품판매 금액
	List<ShopChartVO> shopMoy();
	
	//단건 기부 금액 기간 검색
	List<SearchChartVO> dateSearch(Map<String, Object> param);

	//후원상품 판매금액 기간검색
	List<SearchChartVO> shopDateSearch(Map<String, Object> param);



}
