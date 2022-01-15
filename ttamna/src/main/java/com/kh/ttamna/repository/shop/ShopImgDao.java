package com.kh.ttamna.repository.shop;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.ttamna.entity.shop.ShopDto;
import com.kh.ttamna.entity.shop.ShopImgDto;

public interface ShopImgDao {
	void save(ShopImgDto shopImgDto, MultipartFile multipartFile) throws IllegalStateException, IOException;

	ShopImgDto get(int shopImgNo);

	ShopImgDto getBy(int shopNo);
		
	byte[] load(int shopImgNo) throws IOException;

	List<ShopImgDto> getBys(int shopNo);//여러장 출력


}
