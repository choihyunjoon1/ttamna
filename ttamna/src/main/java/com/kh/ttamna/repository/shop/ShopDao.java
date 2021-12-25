package com.kh.ttamna.repository.shop;

import java.util.List;

import com.kh.ttamna.entity.shop.ShopDto;

public interface ShopDao {
	
	int insert(ShopDto shopDto);
	
	ShopDto get(int shopNo);
	
	List<ShopDto> list();
	
	List<ShopDto> listByPage(int startRow, int endRow);
	
	boolean delete(int shopNo);
	
	boolean update(ShopDto shopDto);
}
