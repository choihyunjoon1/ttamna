package com.kh.ttamna.repository.payment;

import java.util.List;

import com.kh.ttamna.entity.payment.PaymentDto;

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
}
