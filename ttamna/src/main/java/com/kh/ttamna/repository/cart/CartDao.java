package com.kh.ttamna.repository.cart;

import java.util.List;

import com.kh.ttamna.entity.shop.ShopDto;

public interface CartDao {
	
	List<ShopDto> list();
}
