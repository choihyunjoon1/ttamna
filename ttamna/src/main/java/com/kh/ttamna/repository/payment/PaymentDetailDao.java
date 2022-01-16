package com.kh.ttamna.repository.payment;

import java.util.List;

import com.kh.ttamna.entity.payment.PaymentDetailDto;

public interface PaymentDetailDao {
	
	void insert(PaymentDetailDto payDetailDto);
	
	List<PaymentDetailDto> list(int payNo);

	PaymentDetailDto get(int payNo, int shopNo);

	void cancel(int payNo, int shopNo);

	long getCancelAvailableAmount(int payNo);

	void cancelAll(int payNo);
	
	//상품 이름 검색
	String getName(String keyword);
}
