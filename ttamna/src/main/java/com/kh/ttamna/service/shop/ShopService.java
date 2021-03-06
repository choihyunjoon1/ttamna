package com.kh.ttamna.service.shop;

import java.io.IOException;

import org.springframework.stereotype.Service;

import com.kh.ttamna.vo.shop.ShopImgVO;


public interface ShopService {
	void insert(ShopImgVO shopImgVO) throws IllegalStateException, IOException; // 파일등록
	void delete(int shopNo);// 파일삭제
}
