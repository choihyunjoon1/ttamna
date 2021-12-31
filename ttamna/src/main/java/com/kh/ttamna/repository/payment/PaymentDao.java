package com.kh.ttamna.repository.payment;

import java.util.List;

import com.kh.ttamna.entity.shop.ShopDto;

public interface PaymentDao {
	int seq();
	
	void insert(ShopDto paymentDto);
	
	List<ShopDto> list();
	
	ShopDto get(int shopNo);
	
	void refresh(int payNo);
}
