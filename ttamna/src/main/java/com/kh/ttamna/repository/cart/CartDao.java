package com.kh.ttamna.repository.cart;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kh.ttamna.entity.cart.CartDto;
import com.kh.ttamna.entity.shop.ShopDto;

@Repository
public interface CartDao {
	
	void insert(CartDto cartDto);
	
	List<ShopDto> list();
	
	boolean add(CartDto cartDto);
	
	boolean delete(int cartNo);

	CartDto get(int cartNo); 
}
