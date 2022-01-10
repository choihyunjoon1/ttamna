package com.kh.ttamna.repository.shop;

import java.util.List;

import com.kh.ttamna.entity.shop.ShopDto;

public interface ShopDao {
	
	void insert(ShopDto shopDto);
	
	ShopDto get(int shopNo);
	
	List<ShopDto> list();
	
	List<ShopDto> listByPage(int startRow, int endRow);
	
	boolean delete(int shopNo);
	
	boolean update(ShopDto shopDto);
	// 리스트
	List<ShopDto> search(List<Integer> shopNo);
	// 조회수 증가
	boolean readUp(ShopDto shopDto);

	// 재고량 감소
	boolean sell(ShopDto shopDto);
	
	ShopDto search(int shopNo);

}
